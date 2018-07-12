Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFEB01F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeGLPua (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:50:30 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39789 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeGLPua (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:50:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so6488684wmb.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 08:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ip9h0LF3LiwLRjNZ1rIRKA/eOmggOMzDYnPVCcOlEec=;
        b=c78T+nsJNwhOG8UDuYu5ddO5XI4nQSAlLLWlIeSA09SW4Xm6NiqftvyUb0qYSxbuW8
         TSLgwTKacKeA3TdnJWhX9L3ZIs2KpuubT13zAfsWVtyKHzeKcHgduP6UG9ngejETysVr
         jLiXLl3OYpl/6c7NBUVQBFurchgtsSgkvTewYV5jS/kHgxPbgvGCMBhJ0Z2e0lZZG8L1
         9/RId8LuObSe9XICc1OGOufXJxO1uzhzNc0uGbudwhVlUoLTqzhytAvIBeaJ6HHtRLnR
         SkBZJm6zxpSPYwxqvDQCYE4Bjkyb8xRXUx1lfnMbW7lmcEJV7cNjMyU82pMF157+m5t1
         k2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ip9h0LF3LiwLRjNZ1rIRKA/eOmggOMzDYnPVCcOlEec=;
        b=EqbooVzTFZBgEJdkeSy73OJhrML/3c79lmXd55HIY9UZzMebs8C8AFfhdWTgWSlbv7
         zdBO6NNqyjQ/iFZhcBDB9iXW7yAxguN72MZU/BvQBoo+ccZoYZw67E+cl5jIov+4z/A1
         tKF4sCnCLVbYHut4obu42VORll93tR8LRsh+CnbE/CxVOfFFQqPH7J8P0uU41Xj3PvOn
         KvsAR3R4rvhkXrC5W1C7w0IFQF0AejlBrFkZXCzTVhVua2jO/JFBXP9ehZ0CSrkp7X+a
         0G+0Fyrh2KvTenDNYuZLK7p6U9q0TeJgeZK3dzIFaX1rbW1WFvLhWMquIxlqlSTxWhvJ
         m5yw==
X-Gm-Message-State: AOUpUlGAJC1WhDT+2Ku2Q8wofU24Mg4VaS3OIDir5qTS2ygNizoKeepd
        MeY9iCL3JLAtqGOVqL8bwuI=
X-Google-Smtp-Source: AAOMgpcKieD+/gL7SwapITsM2/QRUT6R3F6zbsAdKI4dwGkyRQCPbKRdK9P6X4zi4dMzNaWVdUDzrg==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr1735510wma.143.1531410023663;
        Thu, 12 Jul 2018 08:40:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18-v6sm24212315wrt.64.2018.07.12.08.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 08:40:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH 0/6] Compile cleanly in pedantic mode
References: <20180708144342.11922-1-dev+git@drbeat.li>
        <20180709192537.18564-1-dev+git@drbeat.li>
        <xmqqd0vwaxrq.fsf@gitster-ct.c.googlers.com>
        <3f0ab3f42606d2251a6574d6fb45bf11@drbeat.li>
        <xmqqin5l4w3r.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807121524420.75@tvgsbejvaqbjf.bet>
Date:   Thu, 12 Jul 2018 08:40:22 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1807121524420.75@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 12 Jul 2018 15:25:51 +0200 (DST)")
Message-ID: <xmqq36wo1mzd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> That may be something worth discussing before doing; I'd prefer to
>> wait until these 6 patches, plus the unsized static array one you
>> did spearately, graduates to the 'master' branch.
>
> If this change to DEVOPTS was done as 7/7, then this would be very easy to
> guarantee (or as 2/2 if you want to graduate this here patch series faster
> than the static array forward-declaration fix).

It would guarantee that there is *no* period to discuss if it is too
inconvenient for developers between the time these 6 plus 1 graduate
to the master branch (and willing volunteers have chance to try it
themselves) and the change actuallly is forced upon the developers.

That is why I said I'd prefer to wait.

A separate patch that depends on the 6 plus 1 topic that is kept in
'next' longer than the main series is a possibility, though.
