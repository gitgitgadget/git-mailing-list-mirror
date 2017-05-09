Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD021FDEA
	for <e@80x24.org>; Tue,  9 May 2017 14:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753862AbdEIOX0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 10:23:26 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33080 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbdEIOXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 10:23:25 -0400
Received: by mail-pg0-f65.google.com with SMTP id s62so117306pgc.0
        for <git@vger.kernel.org>; Tue, 09 May 2017 07:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eIkX+mM/dtD30uOwYXSziXIy3Av0sd0apDAn9yKSgTA=;
        b=BZmRFiDPZ69S3Lie+LHutHuVbMGJtgWEo9ybepjxETuIViU6TCJbfmKtI5n+y+7zPf
         7ytVkMHJ+H8kxFQyu7CepTXJ8BYlLDK86bwBH706wlu+IQForlu6YiWHPbOnA+GKHZnT
         bNZmFe+Gd41uOMDTjYtS4khjbpByDBXNRaxq/D2ScMlxNzRJK/1NiUxe517CLKy/YTHW
         qh4b0fS18Q5CnZkpEDxBoOPOz1IlOBk+m7xWuexAC2xvvWzFUICfxMbEC++ciwA8ediB
         rQcI9xfYUhY+JgbYPWgweZvQLxt4PKOX2WEXnNhYJXn0EYiKdM1WVRqTW7nXVbbo2rqI
         Myww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eIkX+mM/dtD30uOwYXSziXIy3Av0sd0apDAn9yKSgTA=;
        b=M7erFvrONGQMJWDMknYDgpZLiO7hWfI4cD8prHiGjHvAfvkIfLiNZL/f7ZiOIbvufw
         +X2ViyGghmEapZRfTOB4DaLpiJTq4BqAFFs/8adHMIQBJwBS0KmlIY+SI1tDPidytCuo
         SWKX/arDFUOBt9rKf4YTuP++FZLVzRwETIncOuPzyZL0J8DeV0OAlc9vgEcU12Cx91Jf
         5JKAIiX8SwJMSsjPtQ5J3GEfPm4WZsD1umQ2ukRtm5TbmpG5S36dQk7LlRibwuHPaZ63
         mKmGPLQJbsyPY6u8PBCwW1itMklQk2/ecKPxqXZH4scmOYBHq6/CxAx/zxIFOAbtHXkV
         5z/g==
X-Gm-Message-State: AODbwcDv6HNdAbEUdNvoxOUUIeDEZTQuTw84n8JZYVqrNp4pTJO2TMbY
        BedIfxDMk6J5jA==
X-Received: by 10.84.222.133 with SMTP id x5mr592694pls.36.1494339805161;
        Tue, 09 May 2017 07:23:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id y63sm276865pfa.107.2017.05.09.07.23.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 07:23:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Ray Chen <oldsharp@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?utf-8?B?bg==?= 
        <vnwildman@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.13.0 round 2
References: <CANYiYbGfDXj4jJTcd3PpXqsDN-TwCC8Dm8B9Ov_3NaSzwsrCfg@mail.gmail.com>
Date:   Tue, 09 May 2017 23:23:23 +0900
In-Reply-To: <CANYiYbGfDXj4jJTcd3PpXqsDN-TwCC8Dm8B9Ov_3NaSzwsrCfg@mail.gmail.com>
        (Jiang Xin's message of "Tue, 9 May 2017 22:08:11 +0800")
Message-ID: <xmqq4lwu2jok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> I can not send email outside at work, but now I am back home. Here is
> the pull request:
>
> The following changes since commit 4fa66c85f11bc5a541462ca5ae3246aa0ce02e74:
>
>   Git 2.13-rc2 (2017-05-04 16:27:19 +0900)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po tags/l10n-2.13.0-rnd2
>
> for you to fetch changes up to 60638e9816d0aae40d4234d1a068f94fabc2fd4d:
>
>   l10n: zh_CN: for git v2.13.0 l10n round 2 (2017-05-09 21:55:38 +0800)

Thanks.  

I see another merge for sv and the tag is now l10n-2.13.0-rnd2.1
(i.e. I couldn't find -rnd2 tag), which I assume is what you meant
me to fetch?
