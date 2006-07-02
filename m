From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 2 Jul 2006 14:17:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607021414060.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060702094938.GA10944@lsrfire.ath.cx> <Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>
 <44A8051D.6040605@lsrfire.ath.cx> <7vmzbr50b3.fsf@assigned-by-dhcp.cox.net>
 <44A8339B.7070608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 23:17:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx9Jf-0007aF-Pd
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 23:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWGBVRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWGBVRR
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 17:17:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750837AbWGBVRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 17:17:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k62LH8nW026252
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Jul 2006 14:17:09 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k62LH7JT023286;
	Sun, 2 Jul 2006 14:17:07 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44A8339B.7070608@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23120>



On Sun, 2 Jul 2006, Rene Scharfe wrote:
>
> I have an idea.  Would it help to gather a list of all commit object
> flags from the different files?  And then we would come up with unique
> names?  And then move the definition of all of them to commit.h?

We already did that once, for a subset of the programs. Except we put them 
in revision.h instead ;)

And yes, we should probably do it for most of the rest.

Some of them (git-show-branch) have really special flags usage, and don't 
want to pollute their magic flags with anybody else at all, but most of 
the rest (fetch.c etc) have just a few flags and could in fact mostly 
re-use the standard ones.

		Linus
