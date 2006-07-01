From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 13:04:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 22:04:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwlho-0001Io-Hg
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 22:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWGAUEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 16:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWGAUEd
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 16:04:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751919AbWGAUEc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Jul 2006 16:04:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k61K4PnW014217
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Jul 2006 13:04:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k61K4Onw009592;
	Sat, 1 Jul 2006 13:04:24 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44A6CD1D.2000600@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23062>



On Sat, 1 Jul 2006, Rene Scharfe wrote:
> 
> I wonder why the two clear_commit_marks() calls at the end of
> get_merge_bases() are not sufficient, though.

Why does that thing check for "parent->object.parsed"?

Also, it only clears commit marks if they are contiguous, but some commit 
marking may not be dense (eg, the "UNINTERESTING" mark may have been set 
by (PARENT1 && PARENT2) triggering, but is not set in the commits that 
reach it.

		Linus
