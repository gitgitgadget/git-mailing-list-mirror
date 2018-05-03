Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF40200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751286AbeECPQg (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:16:36 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36970 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeECPQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:16:35 -0400
Received: by mail-pf0-f172.google.com with SMTP id e9so10978789pfi.4
        for <git@vger.kernel.org>; Thu, 03 May 2018 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X59ujwpjflWR4nWeA9t725jt/bfKQJIjrgTTTxXKxTU=;
        b=WXV7wGG60PRltGLU/opy+qolM84NKrQlD6F7x28e1x/87lnw5b/ZkKuWzrMO9D69dp
         oGv0fVn0Ko6iDjZz/5dJhJPbNsCiRiNnfmfwpC706duipm7li7njEulzI8eVdMyI9SA+
         AmgwfnlNvRZxmeRzi9KI7F55S77ugGfQR9q1vI3x3y3lPvgRI7hfR7nhrV6fVpgLY28z
         qmBexTszd36e06xaZjg1TKdU3Pq9uEnxRqGXwkdlQRcwyMbEyRczL2yl2VC0Px5rJ5nW
         O2OGGycRTpgcRb5NJ9RYAgUSNhvPdH1Gxj5JPEDqQtkjuUHrT3VNMl+59BMhj32XOv7J
         adhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X59ujwpjflWR4nWeA9t725jt/bfKQJIjrgTTTxXKxTU=;
        b=bkQvjtFNRpcA1x8IAxVpCKMkN2YvwOoCEb0km1EqLZo8TgohGtmq5w8u8V+t/BfYzH
         fr4P/G3nE/Qw0axfxeyIApVf1bel1gRxny2KnSCDZthuBNp3Czhk1zESQxJm4q05OEio
         XG7MLcclYi5iH2EyXZTKj4gLD0hIENilZHVgaTrScHY5p0ZRz7Q9YJUufOIndCK46bs/
         K5NGDtGFliQzNj36dANniuroJTUEKnzNlepnj1TqluLfYCfp9TSERtE0D+GpSABdnlGu
         d20wHsPaQ20CO9e0MCf+9vW+mjanfb37NrTwFrtX8gEifgyTPcK5Al8J9qFbuaIawkVx
         Ee7A==
X-Gm-Message-State: ALQs6tBDpMtVGdZnIc9PYofSt/SaAFRc7dBIryS+Uk2WvoWMXJQSTQaN
        NVULNYZwYw+6PfTK96pz2jfmtQ==
X-Google-Smtp-Source: AB8JxZqWSThR1uKHZmCb9LzILoW0yueWz7kTgCT1Bd7e4Gmqf2kjICirH2DPGCqAHz/jFgsiR18hRw==
X-Received: by 10.98.61.84 with SMTP id k81mr23494071pfa.193.1525360594869;
        Thu, 03 May 2018 08:16:34 -0700 (PDT)
Received: from skmbp (218-228-157-73f1.hyg1.eonet.ne.jp. [218.228.157.73])
        by smtp.gmail.com with ESMTPSA id u68sm26633928pfu.167.2018.05.03.08.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 May 2018 08:16:33 -0700 (PDT)
Date:   Fri, 4 May 2018 00:16:29 +0900
From:   Shin Kojima <shin@kojima.org>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Shin Kojima <shin@kojima.org>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitweb: Measure offsets against UTF-8 flagged string
Message-ID: <20180503151627.45pt2veqcjzbk44q@skmbp>
Reply-To: shin@kojima.org
References: <20180501064015.59977-1-shin@kojima.org>
 <xmqqtvrqv632.fsf@gitster-ct.c.googlers.com>
 <86k1skzzc4.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Disposition: inline
In-Reply-To: <86k1skzzc4.fsf@gmail.com>
User-Agent: NeoMutt/20180323
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> One solution would be to force conversion to UTF-8 on input via "open"
> pragma (e.g. "use open ':encoding(UTF-8)';").  But there is no
> UTF-8-with_fallback encoding available - we would have to write one, and
> install it as module (or fake it via Perl trickery).  This mechanism is
> almost the same to what we currently use in gitwbe.

Yes, I tried using `Encode::Guess` with "open" pragma, but no luck.
https://perldoc.perl.org/Encode/Guess.html

I'm also afraid of "open" pragma does not work properly while using
git_blame_common().  Let's say someone using non-ASCII characters in
his/her name, committing non-UTF8 encoded characters.  git-blame will
combine them in the same line.  Following is an example:

$ git blame dummy | xxd
00000000: 3461 6464 3565 6331 2028 e585 90e5 b3b6  4add5ec1 (......
00000010: 20e6 96b0 2032 3031 382d 3035 2d30 3320   ... 2018-05-03
00000020: 3232 3a34 383a 3432 202b 3039 3030 2031  22:48:42 +0900 1
00000030: 2920 8367 8389 8343 0a                   ) .g...C.

    * e585 90e5 b3b6 20e6 96b0 : my name, encoded with UTF-8
    * 8367 8389 8343           : "トライ" encoded with Shift_JIS

It means I need to split each lines of git-blame output at the very
beginning, then convert the first-half as UTF-8 and the second-half as
Shift_JIS.

Sincerely,

-- 
Shin Kojima
