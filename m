From: David Kastrup <dak@gnu.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 23:54:36 +0200
Message-ID: <854pjltv4z.fsf@lola.goethe.zz>
References: <20070730180710.GA64467@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Craig Boston <craig@olyun.gank.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 23:55:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFdD9-0002A4-Ij
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968127AbXG3VzW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938298AbXG3VzV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:55:21 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:33595 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932308AbXG3VzU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 17:55:20 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id EF06F303854;
	Mon, 30 Jul 2007 23:55:18 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id E09F75BD63;
	Mon, 30 Jul 2007 23:55:18 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-066-191.pools.arcor-ip.net [84.61.66.191])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id BA3A42351A4;
	Mon, 30 Jul 2007 23:55:18 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 917FD1D58B8F; Mon, 30 Jul 2007 23:54:39 +0200 (CEST)
In-Reply-To: <20070730180710.GA64467@nowhere> (Craig Boston's message of "Mon\, 30 Jul 2007 13\:07\:11 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3821/Mon Jul 30 21:48:09 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54283>

Craig Boston <craig@olyun.gank.org> writes:

> So far the main snag I've found is that AFAIK there's no equivalent to
> "svk import" to load a big tree (~37000 files) into a branch and commit
> the changes.  Here's the procedure I've come up with:
>
> cd /path/to/git/repo
> git checkout vendor_branch_X
> git rm -r .
> cp -R /path/to/cvs/checkout_X/* ./
> git add .
> git commit -m"Import yyyymmdd snapshot"


I have not tried it, but shouldn't something like the following work?

cd /path/to/cvs/checkout_X
git --git-dir=/path/to/git/repo/.git reset vendor_branch_X
git --git-dir=/path/to/git/repo/.git add .
git --git-dir=/path/to/git/repo/.git commit -a -m "Import yyyymmdd snapshot"


-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
