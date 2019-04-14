Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53DE820248
	for <e@80x24.org>; Sun, 14 Apr 2019 03:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDNDzv (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Apr 2019 23:55:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDNDzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Apr 2019 23:55:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so17084751wrq.8
        for <git@vger.kernel.org>; Sat, 13 Apr 2019 20:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zwqctMwpNf7dB2zWoAqq/Xp2sUiilcyfims9A3qRisg=;
        b=Y4KDatV9Tudo1/do6Vq3H8puuXTJDLwJVESyAfmcMZrnBU+t0cKtUcMIMPsdGDAJ9k
         m1rHe8ZfWiaT3e77liultDj9Jr9okWL2dAPG7X/qLEUgVOxqAOnP1SxuEzpfsiLgmFUm
         ROc5W/YIbgenX1gOU35wBi70JHYHTvwuJVPjqV43Wgvk6TjzhZ0vXctThLrA1lT0Wlax
         Ru0GsHUg6QQZlz3Isg0hGqBtoE65jkf0upV0gFR4sELlF4KojwrzY+BrLmamJo/Aqngn
         1aUIByGViivk0CC63AA8WxgtDLfxMR1VoIEEoZNDVK51p2iPTJxxfSYjDmxiTCVeUA+s
         lF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zwqctMwpNf7dB2zWoAqq/Xp2sUiilcyfims9A3qRisg=;
        b=IuQsMfxqkBDImTFY562VxhWKh9Sb7B6VVaGMtBaVuOtdT7Ce6m6PXXt2a1WVOdCGzH
         yZsaMbuxzHzejq8FgAqs9sZSlWJzd+AHAocIhLcbUXIq/yzUNRwBc/whfxIt2l80tq99
         BjwDBqcrj/m/50liubvPh7JQ8fpW0tW3PAPLT1gFHIC8ug/QGX6Mscl/rPziCPLp7Iuh
         RwgV36vyVL38zSYkA7G1OAS/ezbHmkkrJgSz8/3/2cLr1W7w1MnTxEM9cd3JoFGG6Jyj
         oFRiPUM5GAd9wX/3+NttWYRMx41y5qcsRjjLSr220OQi2jgRQQDTzCpq7qtWDGx9UB4O
         W5GQ==
X-Gm-Message-State: APjAAAXjAI2cJaJA+u5LNHZ6W7SAkab03fQfuYo+m6O87kZ8HuaKF9EA
        rMEL+In/qacnbcWH4QGm4flIa+NrjHU=
X-Google-Smtp-Source: APXvYqyYWDRa6+XrC9/QBnPNga3bN0sj3PJKEFNnWJcTCSmBuQVh9CVwWwQbL6jjjbz/kbkJ3eXTCw==
X-Received: by 2002:adf:e74f:: with SMTP id c15mr40555582wrn.23.1555214149399;
        Sat, 13 Apr 2019 20:55:49 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id e12sm45007885wrt.94.2019.04.13.20.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Apr 2019 20:55:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2019, #02; Wed, 10)
References: <xmqqr2ab2gs6.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD2KsjPo7G0BtzXfA3gyoUyR7y_WsNLm3mn39O8h4n+Kfw@mail.gmail.com>
Date:   Sun, 14 Apr 2019 12:55:48 +0900
In-Reply-To: <CAP8UFD2KsjPo7G0BtzXfA3gyoUyR7y_WsNLm3mn39O8h4n+Kfw@mail.gmail.com>
        (Christian Couder's message of "Thu, 11 Apr 2019 17:06:06 +0200")
Message-ID: <xmqqftqlw88r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> I can send a new version where the top two commits have the following titles:
>
>   - replace: peel tag when passing a tag first to --graft
>   - replace: peel tag when passing a tag as parent to --graft

If/when there are other things that needs fixing in the series, that
may be worth doing.

Thanks.
