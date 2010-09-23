From: "George Spelvin" <linux@horizon.com>
Subject: Re: Newbie question
Date: 23 Sep 2010 00:59:30 -0400
Message-ID: <20100923045930.16223.qmail@science.horizon.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: arjuncode@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 23 07:07:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oye1L-0003CA-9o
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 07:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211Ab0IWFGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 01:06:53 -0400
Received: from science.horizon.com ([71.41.210.146]:47330 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752880Ab0IWFGx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 01:06:53 -0400
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Sep 2010 01:06:52 EDT
Received: (qmail 16224 invoked by uid 1000); 23 Sep 2010 00:59:30 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156849>

Jakub Narebski wrote:
> You have the repository itself (the object database containg all
> version info plus other info).  Put those files and directories into
> <project>/.git subdirectory, and use "git checkout" from within it.
> You should have checked out files in <project>/ directory.

What he said.  Cloning it in the first place is the easier approach, but
what happened is that you got a copy of a "bare" repostitory (without
checked-out files, suitable only for remote access), which is typically
in a directory named "project.git".

What you want is a normal tree, where all the git files are in "project/.git"

This is pretty easy to do:

mkdir project
mv project.git project/.git
cd project
git config core.bare true
git checkout

That does 3 things:
- Set up the directory structure correctly,
- unset the core.bare flag, which disables certain commands that
  make no sense on a bare repository, and
- Check out a working copy
