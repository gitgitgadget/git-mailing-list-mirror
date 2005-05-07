From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] add simple git documentation
Date: Fri, 6 May 2005 17:58:35 -0700
Message-ID: <20050506175835.65b9c9c1.akpm@osdl.org>
References: <20050505102600.GA16387@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 02:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUDYS-0003oq-Sm
	for gcvg-git@gmane.org; Sat, 07 May 2005 02:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVEGA7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 20:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVEGA7P
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 20:59:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:42729 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261430AbVEGA7H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2005 20:59:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j470x4U3020286
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 6 May 2005 17:59:04 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j470x3JX010040;
	Fri, 6 May 2005 17:59:03 -0700
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20050505102600.GA16387@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> This adds short intro to git aimed at kernel hackers.
> 

OK, but I'm hoping that shortly we'll have something more complete than
this, and your patch might not be a suitable starting point for that. 
(Large hint-dropping sounds).



> 
> ---
> commit addb0833bdadda14495d66749e6cb95b6a9445d7
> tree 7e66cb899004fbec0fadae5c9265d0731d3a26f3
> parent 1f9ca1262e6b27dde44d456a87c456d15f0a9b80
> author <pavel@amd.(none)> 1115288688 +0200
> committer <pavel@amd.(none)> 1115288688 +0200
> 
> Index: Documentation/git.txt
> ===================================================================
> --- /dev/null  (tree:de65e7579ed050d324357e3040b37c561676ab7d)
> +++ 7e66cb899004fbec0fadae5c9265d0731d3a26f3/Documentation/git.txt  (mode:100644 sha1:353d5ae7f46eeb79c058be611cb429622167f784)
> @@ -0,0 +1,41 @@
> +	Kernel hacker's guide to git
> +	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +      2005 Pavel Machek <pavel@suse.cz>
> +
> +You can get cogito at http://www.kernel.org/pub/software/scm/cogito/
> +. Compile it, and place it somewhere in $PATH. Then you can get kernel
> +by running
> +
> +mkdir clean-cg; cd clean-cg
> +cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> +
> +... Do cg-update origin to pickup latest changes from Linus. You can
> +do cg-diff to see what changes you done in your local tree. cg-cancel
> +will kill any such changes, and cg-commit will make them permanent.
> +
> +To get diff between your working tree and "next tree up", do cg-diff
> +-r origin: . If you want to get the same diff but separated
> +patch-by-patch, do cg-mkpatch origin: . If you want to pull changes
> +from the "up" tree to your working tree, do cg-update origin.
> +
> +
> +How to set up your trees so that you can cooperate with Linus
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +What I did:
> +
> +Created clean-cg. Initialized straight from Linus (as above). Then I
> +created "nice" tree, good for Linus to pull from 
> +
> +mkdir /data/l/linux-good; cd /data/l/linux-good
> +cg-init /data/l/clean-cg
> +
> +and then my working tree, based on linux-good
> +
> +mkdir /data/l/linux-cg; cd /data/l/linux-cg
> +cg-init /data/l/linux-good
> +
> +. I do my work in linux-cg. If someone sends me nice patch I should
> +pass up, I apply it to linux-good with nice message and do
> +
> +cd /data/l/linux-cg; cg-update origin
> 
> -- 
> Boycott Kodak -- for their patent abuse against Java.
