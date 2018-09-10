Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CFE61F404
	for <e@80x24.org>; Mon, 10 Sep 2018 17:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbeIJWha (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 18:37:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42756 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeIJWha (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 18:37:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id v17-v6so22831114wrr.9
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=x/lazhARZuto8PM4UTCXRRuw+79gjFME2Jq1Pyy+WmY=;
        b=U/F7Lbqh3i6dwOAVrVAX1VcLzKLBkGDf3r1UYeE5BgizHfjyEq6xLV96hEAwsJl702
         WHxlu8H9QyFsKflsuGn70k99GZ4b0n14D9mHgdRsbPFJaF0zQgEpuE68Cz/ewiW1xEl+
         Bgv1q9qPZO+wUHtQpFEHJyR8e11o9aWgwVebmZDeOIWeNhcW6b5wJPEKvRBhOi6reaNo
         SPpuprTW9hLHzrEEhhplbRRuUo/gRHupIbCMksDYDC+/GL9hKnpXeIDr3zjJIPitvbX+
         A+8Q2mQut4QxLPHc0QLLWTSe8MUtroZf32zFVUKPwn4noutrCop/lzg1xHW5UVzjW5uU
         TpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=x/lazhARZuto8PM4UTCXRRuw+79gjFME2Jq1Pyy+WmY=;
        b=JcjiRiixVIY4cHN3cmw3tjJVyye08clm2nBbClfTyGa3aoc8e6kak5AVfvSgEhBPzm
         P7agz5DBUt3IybU0CPf4St56B33ESG+qzC0unK15dfgiOvilN2JvlrPaXY2Ifge4Tn2n
         RWLM9Fd5Zt5IJqHqSJN3ogAtZZmlMPvMay/1YDlxiIoSmUD+LEvxttHyFZLDIrksV9Fe
         GOL32I7taE4lxLsKZPMvscNQyUgnjr5gUZuUE3Wq25dime6CFML0oZiiHLPkb7EYUGBx
         s8qiQdmuDwII5Irx5tLzRRMYY35/oo/XQ9Tbtl+I5My+/ozXzbO98zz3wvTlDYxI0smz
         pyYA==
X-Gm-Message-State: APzg51CAprctNU+WyqlfGA7oOeX8Isv/bhTYxEc8XPtYgtt2VDJTKThK
        yvATk1jL+0Trfu9bQB7bKjY=
X-Google-Smtp-Source: ANB0VdYlsibFi4AXmh4PIZQgyHw1vhylmNPF+pzjeEbz5DdhP2JIIZYA/d9T3BgMqlxg8eo8/clScA==
X-Received: by 2002:adf:b7c9:: with SMTP id t9-v6mr15259006wre.274.1536601337403;
        Mon, 10 Sep 2018 10:42:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 204-v6sm21309514wmh.25.2018.09.10.10.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 10:42:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBR?= =?utf-8?B?dcOibg==?= 
        <vnwildman@gmail.com>
Subject: Re: [GIT PULL] l10n updates for 2.19.0 round 2
References: <CANYiYbGT7R6dLwGpefH=nUxyvdHBuKF1tTtyLy9GRnK5FdH6Kw@mail.gmail.com>
Date:   Mon, 10 Sep 2018 10:42:16 -0700
In-Reply-To: <CANYiYbGT7R6dLwGpefH=nUxyvdHBuKF1tTtyLy9GRnK5FdH6Kw@mail.gmail.com>
        (Jiang Xin's message of "Sun, 9 Sep 2018 22:45:51 +0800")
Message-ID: <xmqqefe1tfk7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> The following changes since commit 2f743933341f276111103550fbf383a34dfcfd38:
>
>   Git 2.19-rc1 (2018-08-28 12:01:01 -0700)
>
> are available in the Git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.19.0-rnd2
>
> for you to fetch changes up to c1ac5258dccbb62438c8df73d728271f7a316c99:
>
>   l10n: zh_CN: for git v2.19.0 l10n round 1 to 2 (2018-09-09 22:38:39 +0800)
>
> ----------------------------------------------------------------
> l10n for Git 2.19.0 round 2

Thanks.
