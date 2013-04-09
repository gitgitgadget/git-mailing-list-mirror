Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 23371 invoked by uid 107); 9 Apr 2013 15:47:37 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Tue, 09 Apr 2013 11:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762371Ab3DIPpi (ORCPT <rfc822;peff@peff.net>);
	Tue, 9 Apr 2013 11:45:38 -0400
Received: from plane.gmane.org ([80.91.229.3]:38723 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760614Ab3DIPph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 11:45:37 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UPajo-0005U2-KW
	for git@vger.kernel.org; Tue, 09 Apr 2013 17:45:36 +0200
Received: from ip68-227-87-145.sb.sd.cox.net ([68.227.87.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 17:45:36 +0200
Received: from richard_hubbe11 by ip68-227-87-145.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 17:45:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: segfault in git-remote-http
Date:	Tue, 9 Apr 2013 08:47:18 -0700
Organization: " "
Message-ID: <20130409084718.587e99aa7a935296867a84a1@lavabit.com>
References: <20130407093812.cae0e19123f7b6d2061800aa@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-227-87-145.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: encrypt
X-Operating-System: Barebones_6.1
X-Gmane-NNTP-Posting-Host: 192.168.1.1
X-NNTP-Posting-Host: 192.168.1.1
Mail-Copies-To:	never
X-Archive: expiry=17
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org
X-Status: A

On Sun, 7 Apr 2013 09:38:12 -0700
rh <richard_hubbe11@lavabit.com> wrote:

> Hello,
> (cross-posting to bitcoin-devel in case they've seen it)
>  
> 1) git clone https://github.com/bitcoin/bitcoin.git
> segfaulted in libcrypto.so.1.0.0
> 
> 2) git clone git://github.com/bitcoin/bitcoin.git
> had no problems
> 
> This was yesterday, I retried today
> 
> 3) git clone https://github.com/bitcoin/bitcoin.git
> and it worked fine.
> 
> Yesterday I was running bitcoin-0.8.1-linux/bitcoin-qt when #1 failed.
> Today I was running bitcoind when I ran #3
> 
> Two things I thought might be coming into play here, network
> pressure and memory pressure. Is this occurence reasonably
> possible or is something else afoot?
> 

The symptoms that this patch addresses look similar:

http://article.gmane.org/gmane.mail.postfix.user/217790

Quote from that thread:
"This behavior is actually documented (SSL_set_fd() destroys
a BIO already on the SSL handle, and creates a new BIO)."

Maybe someone used to looking at git-remote-http code can
say anything about this.

