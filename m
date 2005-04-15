From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 11:36:49 +0200
Message-ID: <20050415093649.GA28077@elte.hu>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <1113556448.12012.269.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 11:34:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMND2-0004Rl-Ax
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 11:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVDOJhD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 05:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbVDOJhD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 05:37:03 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48543 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261781AbVDOJg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 05:36:58 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id ADB6A31FE7B;
	Fri, 15 Apr 2005 11:36:16 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id B02801FC2; Fri, 15 Apr 2005 11:36:52 +0200 (CEST)
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113556448.12012.269.camel@baythorne.infradead.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* David Woodhouse <dwmw2@infradead.org> wrote:

> Consider a simple repository which contains two files A and B. We 
> start off with the first version of each ('A1B1'), and the owner of 
> each file takes a branch and modifies their own file. There is 
> cross-pulling between the two, and then each modifies the _other's_ 
> file as well as their own...
> 
>    (A1B2)--(A2B2)--(A2'B3)
>     /  \   /            \
>    /    \ /              \
>  (A1B1)  X               (...)
>    \    / \              /
>     \  /   \            /
>    (A2B1)--(A2B2)--(A3B2')
> 
> Now, we're trying to merge the two branches. It appears that the most 
> useful common ancestor to use for a three-way merge of file A is the 
> version from tree 'A2B1', while the most useful common ancestor for 
> merging file B is that in 'A1B2'.

do such cases occur frequently? In the kernel at least it's not too 
typical. Would it be a problem to go for the simple solution of using 
(A1B1) as the common ancestor (based on the tree graph), and then to do 
a 3-way merge of all changes from that point on?

	Ingo
