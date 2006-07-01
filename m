From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Fri, 30 Jun 2006 20:59:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606302054580.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 06:00:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwWeP-0001sR-NW
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 06:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWGAD77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWGAD77
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:59:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57324 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932401AbWGAD76 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 23:59:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k613xsnW025559
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Jun 2006 20:59:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k613xs5q009687;
	Fri, 30 Jun 2006 20:59:54 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23040>



On Fri, 30 Jun 2006, Linus Torvalds wrote:
>
> (it's not strictly a valid set operation, but it approaches being an 
> "xor" instead of a union or an intersection or a difference).

Oh, I guess it _is_ perfectly valid. It's called a "symmetric difference" 
in set theory.

So from a set standpoint:

	Git op:			Set theory:

	git-rev-list a..b	// difference: B - A
	git-rev-list b..a	// difference: A - B

	git-rev-list a b	// union of A B (order doesn't matter)

	git-rev-list a...b	// symmetric difference A B (order doesn't matter)

	git-rev-list $(git-merge-base --all a b)
				// intersection of A and B

I think.

		Linus
