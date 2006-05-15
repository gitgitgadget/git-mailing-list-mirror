From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add "--summary" option to git diff.
Date: Sun, 14 May 2006 18:51:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605141848080.3866@g5.osdl.org>
References: <BAYC1-PASMTP0770FC4238970CB812C192AEA20@CEZ.ICE>
 <7v3bfcno2b.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP02640E2C9813E4DA1E778BAEA30@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon May 15 03:51:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfSFT-0004l8-Ta
	for gcvg-git@gmane.org; Mon, 15 May 2006 03:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWEOBvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 21:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWEOBvr
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 21:51:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38331 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751389AbWEOBvq (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 21:51:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4F1pVtH013802
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 14 May 2006 18:51:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4F1pQZj020570;
	Sun, 14 May 2006 18:51:29 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP02640E2C9813E4DA1E778BAEA30@CEZ.ICE>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20004>



On Sun, 14 May 2006, Sean wrote:
> 
> What's a bit more worrying is that:
> 
> $ PAGER= ./git whatchanged -B -C --stat --no-merges --diff-filter=RC
> 
> Causes the same problem on the current (1.3.2) release branch without any
> other patches applied at all.

If you have electric fence installed, just do

	PAGER= ef ./git whatchanged -B -C --stat --no-merges --diff-filter=RC

to run it with the efence preload, which should cause a core-dump and/or 
be more debuggable.

Sadly, last I tried, you can't run gdb under ef, because electric fence 
(incorrectly) thinks that zero-size allocations are bad.

		Linus
	
