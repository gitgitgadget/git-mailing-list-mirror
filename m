From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 16:14:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221611020.2307@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
 <20050522184237.GG18500@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org> <7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
 <7vy8a7cavf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org>
 <7vis1adfvq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 01:11:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZzbN-0001rV-L4
	for gcvg-git@gmane.org; Mon, 23 May 2005 01:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVEVXMc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 19:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVEVXMc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 19:12:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:4052 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261821AbVEVXM0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 19:12:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4MNCJjA029291
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 16:12:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4MNCIAA000443;
	Sun, 22 May 2005 16:12:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis1adfvq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Junio C Hamano wrote:
> 
>     Everything but the last are copies.  If the last one have
>     different src and dst, then it is a rename.  Otherwise it
>     is a "stay".

If so, I disagree. Totally.

You seem to think that it's a feature that you can't get the same output 
out of git-diff-helper, and I think that's not a feature, but a total bug.

> LT> resulting in:
> 
> That's not a counter-example.  You are agreeing to what I said in
> this message:

No, I'm not agreeing at all. I'm saying that this is unacceptable, and if 
this was intentional, as you seem to be saying, then it was in my opinion 
a bad idea. We might as well go back to the original diff format, which 
had other problems, but they were no worse than the new one.

Basically, with the new format as-is, renames and copies cannot be 
described sanely. That was exactly the same problem as the old format had, 
except the old format was less verbose. So why do the new format at all?

I'm arguing that we should consider it a _requirement_ that "raw diffs" 
can be translated into te same thing the "-p" flag internally does.

		Linus
