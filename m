From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Issues with higher-order stages in dircache
Date: Sat, 16 Apr 2005 22:31:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504162228300.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
 <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
 <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
 <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
 <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
 <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net> <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
 <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
 <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
 <Pine.LNX.4.58.0504152256520.7211@ppc970.osdl.org> <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net>
 <7vll7i95u1.fsf_-_@assigned-by-dhcp.cox.
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 07:26:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN2I8-000819-T5
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 07:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVDQF3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 01:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVDQF3i
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 01:29:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:61857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261261AbVDQF3g (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 01:29:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3H5TTs4009541
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 22:29:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3H5TSBF008805;
	Sat, 16 Apr 2005 22:29:28 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ym2dju.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Junio C Hamano wrote:
> 
> I am wondering if you have a particular reason not to do the
> same for the removing half.

No. Except for me being silly.

Please just make it so.

> Also do you have any comments on this one from the same message?
> 
>  * read-tree
> 
>    - When merging two trees, i.e. "read-tree -m A B", shouldn't
>      we collapse identical stage-1/2 into stage-0?

How do you actually intend to merge two trees? 

That sounds like a total special case, and better done with "diff-tree".  
But regardless, since I assume the result is the later tree, why do a 
"read-tree -m A B", since what you really want is "read-tree B"?

The real merge always needs the base tree, and I'd hate to complicate the 
real merge with some special-case that isn't relevant for that real case.

		Linus
