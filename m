From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] remote-hg: do not fail on invalid bookmarks
Date: Mon, 30 Dec 2013 07:24:33 +0900
Message-ID: <20131229222433.GA31355@glandium.org>
References: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 00:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxPTs-0002PQ-R3
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 00:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab3L2XIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Dec 2013 18:08:46 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:49088 "EHLO
	jigen.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752496Ab3L2XIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Dec 2013 18:08:46 -0500
X-Greylist: delayed 2647 seconds by postgrey-1.27 at vger.kernel.org; Sun, 29 Dec 2013 18:08:45 EST
Received: from mh by jigen.glandium.org with local (Exim 4.82)
	(envelope-from <mh@glandium.org>)
	id 1VxOmf-0008A0-Ur; Mon, 30 Dec 2013 07:24:33 +0900
Content-Disposition: inline
In-Reply-To: <1388316602-22443-1-git-send-email-apelisse@gmail.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239798>

On Sun, Dec 29, 2013 at 12:30:02PM +0100, Antoine Pelisse wrote:
> Mercurial can have bookmarks pointing to "nullid" (the empty root
> revision), while Git can not have references to it.
> When cloning or fetching from a Mercurial repository that has such a
> bookmark, the import will fail because git-remote-hg will not be able to
> create the corresponding reference.
> 
> Warn the user about the invalid reference, and continue the import,
> instead of stopping right away.

It's not invalid, it's used to indicate deleted bookmarks. (Tags have
the same property)

Mike
