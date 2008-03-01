From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix git reset --abort not restoring the right commit
	under some conditions
Date: Sat, 1 Mar 2008 12:11:56 +0100
Organization: glandium.org
Message-ID: <20080301111156.GA2933@glandium.org>
References: <7vod9y4xcn.fsf@gitster.siamese.dyndns.org> <1204367534-28204-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 01 12:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVPaX-0006BJ-EN
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 12:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbYCALId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 06:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbYCALId
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 06:08:33 -0500
Received: from vuizook.err.no ([194.24.252.247]:50969 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbYCALIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 06:08:32 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVPZl-0007Qe-GI; Sat, 01 Mar 2008 12:08:27 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVPdE-0000mj-5i; Sat, 01 Mar 2008 12:11:56 +0100
Content-Disposition: inline
In-Reply-To: <1204367534-28204-1-git-send-email-mh@glandium.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75655>

On Sat, Mar 01, 2008 at 11:32:14AM +0100, Mike Hommey wrote:
> Previously, --abort would end by git resetting to ORIG_HEAD, but some
> commands, such as git reset --hard (which happened in git rebase --skip,
> but could just as well be typed by the user), modify ORIG_HEAD.
> 
> Just use the orig-head we store in $dotest instead.

Oops, forgot the -s.
Signed-off-by: Mike Hommey <mh@glandium.org>
