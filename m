From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-diff-cache sans --cached and unmerged paths
Date: Mon, 2 May 2005 21:23:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505022119540.3594@ppc970.osdl.org>
References: <7vr7gpnria.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 06:15:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSoof-0004Sg-Fx
	for gcvg-git@gmane.org; Tue, 03 May 2005 06:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVECEV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 00:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVECEV3
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 00:21:29 -0400
Received: from fire.osdl.org ([65.172.181.4]:46795 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261379AbVECEVK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 00:21:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j434L5s4006945
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 21:21:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j434L3hF007254;
	Mon, 2 May 2005 21:21:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7gpnria.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Junio C Hamano wrote:
> 
>     git-diff-cache without --cached says 'U filename" (or "unmerged
> filename") when working with an unmerged cache entry. Since the form
> without --cached is to mean "look at the work tree", I think it should
> be changed to report the mode and the magic 0{40} SHA1.  What do you
> think?

Hmm.. I like the "it's unmerged, so we report it that way" thing, but on 
the other hand, what you describe as your workflow:

> I was manually fixing up a merge and I wanted to compare the
> merge result in the work tree with the pre-merge HEAD version
> from either heads, but this behaviour (yes I am the guilty one)
> makes it cumbersome, and that is the reason behind this
> question.

This seems to make sense as a workflow perspective, so I guess I'll have 
to agree. A unmerged file that exists in the working tree should probably 
get reported as the working tree version, not as unmerged.

If it's not in the working tree at all, I'd assume that "U" is the right 
thing to do (and obviously, with "--cached" there is no question about 
it).

> BTW, when you have a chance, could you please give the
> executable bit to git-apply-patch-script, pretty please.  This
> is my fourth attempt ;-).

I just sent you a description of the problem I had with your tree, so 
maybe fifth time lucky..

		Linus
