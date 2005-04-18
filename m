From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] git: fix 1-byte overflow in show-files.c
Date: Mon, 18 Apr 2005 10:28:27 +0200
Message-ID: <20050418082827.GA21612@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414121819.GA14380@elte.hu> <20050414125354.GB15420@elte.hu> <20050417235920.GY1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 10:25:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNRYx-0003Tu-7N
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 10:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVDRI2s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 04:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVDRI2s
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 04:28:48 -0400
Received: from mx2.elte.hu ([157.181.151.9]:31875 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261934AbVDRI2p (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 04:28:45 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 2615C319CEB;
	Mon, 18 Apr 2005 10:27:33 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 1EAAD1FC2; Mon, 18 Apr 2005 10:28:30 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050417235920.GY1461@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

> > will attempt to append a "/" string to the directory name - resulting in 
> > a 1-byte overflow (a zero byte is written to offset 4097, which is 
> > outside the array).
> 
> The name ends precisely at offset 4095 with its NUL character:
> 
>      {PATH_MAX}
>      Maximum number of bytes in a pathname, including the terminating
> null character.
> [ http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html ]
> 
> So, if I'm not mistaken, '/' will be written at offset 4095 instead of 
> the NUL and the NUL will be written at 4096. Everything's fine, right?

yeah, you are right - ignore this patch.

	Ingo
