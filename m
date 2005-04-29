From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 07:34:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262732AbVD2Ofb@vger.kernel.org Fri Apr 29 16:41:37 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262732AbVD2Ofb@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRWZz-000212-Pq
	for glk-linux-kernel@gmane.org; Fri, 29 Apr 2005 16:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbVD2Ofb (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Fri, 29 Apr 2005 10:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVD2Odd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:33:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:54408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262732AbVD2Oca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:32:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TEWHs4001633
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 07:32:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TEWG0X016236;
	Fri, 29 Apr 2005 07:32:16 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050429074043.GT21897@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> Mercurial is even younger (Linus had a few days' head start, not to
> mention a bunch of help), and it is already as fast as git, relatively
> easy to use, much simpler, and much more space and bandwidth
> efficient.

You've not mentioned two out of my three design goals:
 - distribution
 - reliability/trustability

ie does mercurial do distributed merges, which git was designed for, and 
does mercurial notice single-bit errors in a reasonably secure manner, or 
can people just mess with history willy-nilly?

For the latter, the cryptographic nature of sha1 is an added bonus - the
_big_ issue is that it is a good hash, and an _exteremely_ effective CRC
of the data. You can't mess up an archive and lie about it later. And if
you have random memory or filesystem corruption, it's not a "shit happens"  
kind of situation - it's a "uhhoh, we can catch it (and hopefully even fix
it, thanks to distribution)" thing.

I had three design goals. "disk space" wasn't one of them, so you've
concentrated on only one so far in your arguments.

		Linus
