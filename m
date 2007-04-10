From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 18:28:37 +0200
Message-ID: <200704101828.37453.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 02:10:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbJDF-0006su-3p
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 18:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031055AbXDJQ2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 12:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031056AbXDJQ2o
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 12:28:44 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:47682 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1031055AbXDJQ2n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 12:28:43 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id C23CF28DB;
	Tue, 10 Apr 2007 18:28:41 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704092115350.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44152>

On Tuesday 10 April 2007, Linus Torvalds wrote:
> ...
> +	if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
> +		return 0;
> +	return hashcmp(sha1, ce->sha1);

So this does mean that the SHA1 of a gitlink entry corresponds
to the commit in the subproject?

I wonder if it is not useful to be able to add some attribute(s)
to a gitlink, i.e. first reference a gitlink object in the superproject,
which then references the submodule commit, and also holds some
further attributes. These attributes can not be put into the subproject,
as it should be independent.

An example for such an attribute would be a subproject name/ID.
An argument for this: The user should be able to specify some policies
for submodules, like "do not clone/checkout this submodule". But the
path where the submodule resides in a given commit is not useful here,
as a submodule can reside at different paths in the history of the
supermodule.

Josef
