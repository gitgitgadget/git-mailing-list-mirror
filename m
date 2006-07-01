From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 11:20:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607011115500.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <20060701180125.GA27550@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 20:21:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwk5e-0000Hv-3U
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 20:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWGASVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 14:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWGASVG
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 14:21:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751276AbWGASVF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 14:21:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k61IKtnW009576
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Jul 2006 11:20:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k61IKspx007013;
	Sat, 1 Jul 2006 11:20:54 -0700
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060701180125.GA27550@fieldses.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23054>



On Sat, 1 Jul 2006, J. Bruce Fields wrote:
> 
> What's the logic behind naming the operator "..."?

Well, if ".." is set difference, why not "..." for symmetric set 
difference.

The operations really _are_ related.

Also, the parse syntax and logic really is the same, even if Rene's patch 
didn't take advantage of that.

That said, it does have a real downside, and that's simply that it can 
take a long time to compute.

Somebody should also verify that there are no interesting interaction with 
the fact that we end up traversing the commit lists twice (no object flag 
interactions etc) with the new "get_merge_bases()"

		Linus
