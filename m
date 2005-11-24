From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Thu, 24 Nov 2005 03:33:30 -0800
Message-ID: <7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 12:35:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfFM8-000223-13
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 12:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVKXLdd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 06:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbVKXLdd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 06:33:33 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44187 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932528AbVKXLdc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 06:33:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124113210.KKAH17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 06:32:10 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12705>

Thanks for the patch.  I unfortunately was doing the same,
because I wanted to get the repo-format-validation stuff into a
presentable shape, and I thought this would interfere with it
and wanted to do it first (fortunately it didn't).  They are
both in the proposed updates branch.  At a quick glance, I think
your patch is identical to what I did (there aren't that many
different ways to rename a command after all).

> 	Sorry, git-mv did not work on my system. I can now confirm that
> 	there is *at least* one perl 5.6 version out there which does not
> 	like lists in open statements at all. Grmpf.

Yeah, perl5.8delta says that is 5.8 feature.  As discussed on
the list with Merlyn, we have a fair amount of backporting, I
suspect.  At least we should work on 5.6, if not 5.5.

I do not use git-mv myself.  It does not work in subdirectories,
and typing Documentation/ twice to move just one file is a
chore, so I tend to just 'R' (rename) the file, move to the
renamed file, and '!' (run shell command on the specified path)
with 'git-add', all within a single Emacs dired buffer.

> 	Further grpmf: Is it intended behaviour that git-diff *detects* 
> 	renames, while git-format-patch *doesn't*?

I do not want to force all the kernel subsystem maintainers to
use git (namely, git-apply) to process e-mails, so format-patch
should not default to git specific renaming patches.

An option to git-format-patch _might_ make sense someday.  Maybe
after the world domination ;-).

Oh, wait.  It already can produce renaming patches, just does
not do it by default.

		Junio "again I forgot what I implemented before;
		sheesh I even used it myself to feed some patches
                to Linus" Hamano
 
