Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 071841F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeCZSAq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:00:46 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:53274 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeCZSAq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:00:46 -0400
Received: by mail-wm0-f42.google.com with SMTP id p9so4576070wmc.3
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=I6Zyk0P5KTM8U/ELYN3ZHxEwpPIKUfqOcW3dLpMBaDg=;
        b=XBOubHpvr8qvrE961ZgMYSk1LjdcPzkTAIpz+JxgyBoXV9JuEl7QyJSEWiYV4FYgjI
         O9cJy2eZLiqnm55lz5y77oioavFC6Bm+FGVvuluZ1A7rwoep+UjVcFfWLut2UsG9lDPh
         IiE1zq8fkhGJDph3plF8rT3Fiy8ntjVnhXb+8bHM+8qrW3CAIqigaK4jDevRwFd39DOl
         wCWE9W8yGzI3zPpw8ozLinXi6zenRwTQHSv8LwkayYUWqjkphZ9vhnORrCmSNaI0w5I9
         Cc0koKK2bd+LzKlpscAhXVrDZ0xZVv88gF+BQV4b0jWSRXHls2i/O//YTNL99HmDWW3F
         2dZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=I6Zyk0P5KTM8U/ELYN3ZHxEwpPIKUfqOcW3dLpMBaDg=;
        b=tX+b87OLuo7ysrBAFuvCcx1hbTi9mt2qSzbBWXA73dbpkj8gjAXbQ8uikLSpMuSOx3
         GO2UN6jH8tCfkSVX0v+WWbUibawbH3JSr12A62EfXC1PWrkYi8TqTpnFKqtIHiHBLH8m
         przdVobfILy+zyDoA7PELuPvlOejuotC+3SQ7aNOEbvsDoZIMOjGTDGQxjXg6wSfhQMD
         k9cR63c3X18yBtKQaTqvryc9wATGN5R6eHd4RKBaKqThUjL4AGBLzpBM42QOJHzG38XV
         cgavP03jUnafcSr3817UrPIvdAzPUFB3GJywv21etEB3cmLUZ50QETQ74ZMe9jzXTc4C
         l8oA==
X-Gm-Message-State: AElRT7EZHAQ0cYIdzvCQDPwE5ytnMZmVvomboR1kaMYuVW0HK6JW+2ka
        Qto1RtdBWTTlCw9/52UV/yY=
X-Google-Smtp-Source: AG47ELuaqFKvAedEApGj6igAiDU43FY1q/dlLk124saBxTnM8ys4sknovtUQtqm59fNeGyGEukauHA==
X-Received: by 10.28.108.5 with SMTP id h5mr17386851wmc.100.1522087244546;
        Mon, 26 Mar 2018 11:00:44 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m62sm20609652wmi.19.2018.03.26.11.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 11:00:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Wink Saville <wink@saville.com>, jeffhost@microsoft.com,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
References: <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
        <xmqq7eq2h0wa.fsf@gitster-ct.c.googlers.com>
        <CAKk8isoJQrikitO7ezRajgphUXYR6207k4UkXP6r57WJEFBaDA@mail.gmail.com>
        <CAKk8ispSgNgZxS7KfuOyxfU53tzesvNyLRaNXFZa3K7SCbaRkQ@mail.gmail.com>
        <xmqqzi2ude4w.fsf@gitster-ct.c.googlers.com>
        <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com>
Date:   Mon, 26 Mar 2018 11:00:43 -0700
In-Reply-To: <9ca76d31-828d-0b6f-5069-375792c1f55d@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 26 Mar 2018 13:01:50 -0400")
Message-ID: <xmqqd0zqd8dw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I am concerned that the above compiler error message says that uintmax_t
> is defined as an "unsigned long" (which is defined as *at least* 32 bits,
> but not necessarily 64.  But a uint64_t is defined as a "unsigned long long"
> and guaranteed as a 64 bit value.

On a platform whose uintmax_t is u32, is it realistic to expect that
we would be able to use u64, even if we explicitly ask for it, in
the first place?

In other words, on a platform that handles uint64_t, I would expect
uintmax_t to be wide enough to hold an uint64_t value without
truncation.
