From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 09:28:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603250927410.15714@g5.osdl.org>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <7vk6ajxbe5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 18:29:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNCZM-0000XC-8J
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 18:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWCYR2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 12:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWCYR2w
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 12:28:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750717AbWCYR2w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 12:28:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2PHSlDZ020387
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 25 Mar 2006 09:28:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2PHSl6U005519;
	Sat, 25 Mar 2006 09:28:47 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6ajxbe5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17989>



On Fri, 24 Mar 2006, Junio C Hamano wrote:
> 
> Another thing I noticed is that while libxdiff always shows full
> line counts "-n,m +l,k" GNU seems to omit them when it can (m,k
> <=1).  I am not sure if apply.c is set up to grok what libxdiff
> emits correctly.  Running t/t1200 shows some obvious examples.

Actually, the GNU diff output is the special case, and git-apply handles 
it as such. 

We could make libxdiff do the same @@-shortening, but it doesn't seem to 
be huge deal.

		Linus
