From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 17:07:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610201702580.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <vpqirigqzpd.fsf@ecrins.imag.fr>
 <20061019123349.GE20017@pasky.or.cz> <200610201350.12273.jnareb@gmail.com>
 <7vlknalgne.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:07:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4P2-0007U1-7s
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWJUAHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWJUAHe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:07:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030205AbWJUAHd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:07:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9L07SaX016815
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 17:07:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9L07R3R008293;
	Fri, 20 Oct 2006 17:07:27 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlknalgne.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29562>



On Fri, 20 Oct 2006, Junio C Hamano wrote:
> 
> I am not bold enough to say _exactly_ N places, but you missed
> at least one more important one.  Merge simplification favors
> the earlier parents over later ones.

Which is probably slightly inconsistent (although I seriously doubt 
anybody really cares - when we simplify a merge we obvioously do it 
exactly because the parents are identical wrt the files we are following).

Most of the rest of commit traversal tend to have a rule that says 
"traverse youngest parent first", simply by virtue of the fact that 
revlist() normally pops off the queue in date order. But Jakub is 
certainly correct that when we do "^" we just take the first one. 

And "gitweb" does consider the first one special, since it shows diffs 
against that one (although I've argued that it probably shouldn't, and 
that there should be some way to show branches against arbitrary parents)

So we're a bit confused. Not that it probably really ever matters. We 
might as well say that parent order is random, and that our "random number 
generators" are pretty damn lazy ;)

		Linus
