From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 18:18:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508271814410.3317@g5.osdl.org>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
 <7vwtm726xq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
 <Pine.LNX.4.63.0508271855100.23242@iabervon.org> <Pine.LNX.4.58.0508271621210.3317@g5.osdl.org>
 <Pine.LNX.4.63.0508271941090.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 03:20:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9BpO-000125-La
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 03:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVH1BTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 21:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbVH1BTA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 21:19:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750992AbVH1BTA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 21:19:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7S1IrjA011371
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Aug 2005 18:18:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7S1IqRh024888;
	Sat, 27 Aug 2005 18:18:52 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0508271941090.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7859>



On Sat, 27 Aug 2005, Daniel Barkalow wrote:
> 
> It looks like stage 2 is currently special as the stage that's similar to
> the index/HEAD/working tree.

Ahh, yes. We do actually want that. So yes, we should make only stage 3 
have the multiple entries.

> I'd be afraid of confusing everything by removing the uniqueness
> invariant, although I guess not too much does anything with entries in
> stages other than 0. I probably just don't find the index as intuitive as
> you do and as the struct tree representation.

Yes, I find the index to be very nice to work with - it basically allows
you to work with multiple trees in one go, instead of working one file at
a time. You just slurp in any number of trees (with some trivial rules
about which stage they go in), and then you can just walk through each
filename and efficiently handle one file at a time without re-doing the
tree thing. Very nice.

			Linus
