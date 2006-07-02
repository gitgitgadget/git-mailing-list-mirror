From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 2 Jul 2006 13:44:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607021344040.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
 <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
 <20060701150926.GA25800@lsrfire.ath.cx> <7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>
 <44A6CD1D.2000600@lsrfire.ath.cx> <Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>
 <7vveqhccnk.fsf@assigned-by-dhcp.cox.net> <7vpsgpccak.fsf@assigned-by-dhcp.cox.net>
 <20060702094938.GA10944@lsrfire.ath.cx> <Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>
 <44A8051D.6040605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 22:45:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx8oX-00047z-1i
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 22:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWGBUo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 16:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750759AbWGBUo7
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 16:44:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750743AbWGBUo6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jul 2006 16:44:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k62KinnW024994
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 2 Jul 2006 13:44:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k62KimaX017497;
	Sun, 2 Jul 2006 13:44:49 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <44A8051D.6040605@lsrfire.ath.cx>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 2 Jul 2006, Rene Scharfe wrote:
> 
> No and yes.  Patch 1 in the 3+1 series changes the flags used in
> commit.c to not conflict with the ones in revision.h[*].  So we have two
> different UNINTERESTINGs, and get_merge_bases() doesn't mess up the
> show/no-show markings.

Gaah. So UNINTERESTING in commit.c needs something else than everywhere 
else? That's a bug waiting to happen.

Please give it a name of its own.

		Linus
