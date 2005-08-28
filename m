From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Sun, 28 Aug 2005 12:48:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508281245150.3317@g5.osdl.org>
References: <19723.1125249085@lotus.CS.Berkeley.EDU>
 <Pine.LNX.4.58.0508281045060.3317@g5.osdl.org> <43120BC5.8060608@kaijanaho.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 21:48:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9T8h-00044C-3h
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVH1TsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 15:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVH1TsR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 15:48:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750772AbVH1TsQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 15:48:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7SJm3jA021861
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 28 Aug 2005 12:48:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7SJm2Np027800;
	Sun, 28 Aug 2005 12:48:02 -0700
To: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.info>
In-Reply-To: <43120BC5.8060608@kaijanaho.info>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7883>



On Sun, 28 Aug 2005, Antti-Juhani Kaijanaho wrote:
> 
> This is not true under C99.  If an array[] is the last member of a
> struct (which is what we are, AFAIK, talking about), then sizeof that
> struct is defined and gives the size of that struct as if the array's
> size were zero (but the struct cannot be used in an automatic context).

Ahh, thanks. Mea culpa, I thought it was illegal in general. In that case,
the only reason not to use [] is that older gcc's don't like it, but even
that version cut-off may be old enough to not matter.

Anybody know? gcc-2.95 is still considered production at least for the
kernel. I don't have it available to test whether it understands []
though.

		Linus
