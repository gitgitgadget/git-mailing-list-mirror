From: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] Add cg-printenv command.
Date: Mon, 09 May 2005 07:35:32 -0600
Message-ID: <427F6724.6010705@mesatop.com>
References: <200505081911.10371.elenstev@mesatop.com> <200505082125.28521.elenstev@mesatop.com> <2970.10.10.10.24.1115610025.squirrel@linux1> <200505082159.59595.elenstev@mesatop.com> <20050509072438.GB3599@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	Marcel Holtmann <marcel@holtmann.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 15:29:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV8JR-0005eE-RO
	for gcvg-git@gmane.org; Mon, 09 May 2005 15:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261372AbVEINfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 09:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVEINfy
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 09:35:54 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:63980 "EHLO
	mailwasher.lanl.gov") by vger.kernel.org with ESMTP id S261372AbVEINfk
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 May 2005 09:35:40 -0400
Received: from w-mail.lanl.gov (w-mail.lanl.gov [128.165.4.47])
	by mailwasher.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j49DZckG006255
	for <git@vger.kernel.org>; Mon, 9 May 2005 07:35:38 -0600
Received: from [128.165.67.197] (spc7.esa.lanl.gov [128.165.67.197])
	by w-mail.lanl.gov (8.12.11/8.12.11/(ccn-5)) with ESMTP id j49DZWeH005493;
	Mon, 9 May 2005 07:35:32 -0600
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050509072438.GB3599@pasky.ji.cz>
X-PMX-Version: 4.7.0.111621
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Dear diary, on Mon, May 09, 2005 at 05:59:59AM CEST, I got a letter
> where Steven Cole <elenstev@mesatop.com> told me that...
> 
>>On Sunday 08 May 2005 09:40 pm, Sean wrote:
>>
>>>On Sun, May 8, 2005 11:25 pm, Steven Cole said:
>>>
>>>
>>>>I had intended it only as a quick check by an end-user before doing
>>>>a commit that the values had been set as desired.
>>>
>>>Hey Steven,
>>>
>>>Rather than creating a separate command, perhaps the values could
>>>automatically be added to the initial commit message in a few "CG:" lines?
> 
> 
> I was already thinking about this and I think Sean's way makes more
> sense. Also, I actually believe you should add this functionality to
> commit-tree instead (commit-tree -n (dry-run), perhaps?) - so that the
> user can actually check the default values commit-tree is going to use
> too. *That* would be useful.

I agree that having a --dry-run option here would be useful.  I frequently
use the 't' option when untarring an unfamiliar tarball.

> 
> 
>>A secondary reason for adding the cg-printenv capability was that a user would
>>see this command in the cg-help list, and cg-help printenv would give:
> 
> 
> No, I think this sucks. You should just list the variables in cg-commit
> documentation if anything. That's where they matter anyway and where the
> user could possibly look for them anyway.

OK. David has done a good job of documenting this in the git-commit-tree
section of Documentation/core-git.txt, and here is the information again in
the comment header for cg-commit.

That's the way of open source.  Post an idea, and any number of superior
implementations come rolling in.

--------
Add comments to cg-commit to point out usage of git environment variables.

Signed-off-by: Steven Cole <elenstev@mesatop.com>

===================================================================
--- 3974261da777f55a7a11aff6e02f584bbfe2b475/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -13,6 +13,16 @@
  # appended to a single commit message, each as separate paragraph.
  # -e forces the editor to be brought up even when -m parameters were
  # passed to cg-commit.
+#
+#These git environment variables are used in case
+#values other than that returned by getpwuid(getuid())
+#are desired when performing a commit.
+#
+#AUTHOR_NAME		Author's name
+#AUTHOR_EMAIL		Author's e-mail address
+#AUTHOR_DATE		Date, perhaps from a patch e-mail
+#COMMIT_AUTHOR_NAME	Committer's name
+#COMMIT_AUTHOR_EMAIL	Committer's e-mail address

  . ${COGITO_LIB}cg-Xlib



