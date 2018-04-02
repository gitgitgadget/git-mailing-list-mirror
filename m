Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FE81F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDBRRa (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:17:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35129 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeDBRR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:17:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id r82so28860692wme.0
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DACmTM0Szuw1dD6S+84VvxbxqKrW1QgAOzgUDPrV9/w=;
        b=CJMrXhhTN/Egof/2bricw8Fi5sq4qyOJlqkAGExYlKDG0khF0s5wRMwCWTfAn1PVNf
         ZS5vnAiy/KWxZ5sjDyhvB5R7QukGfPe+Am+KvXjPmDwnETNsqLJ0aRfVo8Ct5Tfm0Pui
         hWu6KiBtMO0kyo6tQ21J/FYrk8p2TJO6lvw4c4T9oXnFzWEfO8+FUOvkJnKCalUCgWx/
         IWsv7gfbItAvbrnfgX7SdMpTPzcRjOEN+oDaU/NY2pmPF9uyepoZ+JWqiJZg0lD0Xqzi
         MbdpBJ+gFNoeg7yTHw/liwsLiFDLDjGJ9qwDLDEj1LF31Uq5/yle4o/6AnxY2AKMQ1Jg
         hojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DACmTM0Szuw1dD6S+84VvxbxqKrW1QgAOzgUDPrV9/w=;
        b=a6bUsfo2bNYbQ4wW2bSzAYTL4tKFpg3Im1oJO7XWl7tRmD7gXcurkMDwPSdn0ZWs/s
         pqh6eYGQYC35Ga3jBj4do6rOUT1aUjAkYl+gy0IcC/lrDUHGMVnJNAJ//YjC8fM02bqZ
         3V4hBXJNas8o72lmAaTTuW3wl16XLfLsV+RX3al0ICxI39ySCaT4LgHQVlPVJ5ixQxll
         O2jtkldkNw7JURKBfKJO1ycbjoTzuynJw542InnSBTO+LXZ2XGBGAbtNSsw9sXRp2FS3
         HY/Abj+YpZCPxQoAyktpBwYMJg4cb/k+Krs8P3vsqV4ocHTQwM3uicudyD3yPbNuo8lQ
         coBw==
X-Gm-Message-State: ALQs6tCa8XpyNxlepczFGFmgvjx+DbOtimMUMoywE4G5i7J/Uwn6puxX
        rWoa9E26WqsO4+fMpVyQSX8=
X-Google-Smtp-Source: AIpwx4/dPajQRKMCpP9HByKoZUSmrsP5dg1X02nkh4QbQkFYAGFWy0YxPTplyPwSHja+h3UeB3nY4A==
X-Received: by 10.28.21.77 with SMTP id 74mr1589285wmv.76.1522689448069;
        Mon, 02 Apr 2018 10:17:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l41sm1788547wrl.2.2018.04.02.10.17.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 10:17:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Changwoo Ryu <cwryu@debian.org>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Jordi Mas <jmas@softcatala.org>,
        Marco Paolone <marcopaolone@gmail.com>,
        Peter Krefting <peter@softwolves.pp.se>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Ray Chen <oldsharp@gmail.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [GIT PULL] l10n updates for 2.17.0 round 1
References: <CANYiYbGfJ_R_yT5+0=qTrvzt0GdxsG6EtjWJauHNAyUNpaPwNg@mail.gmail.com>
Date:   Mon, 02 Apr 2018 10:17:26 -0700
In-Reply-To: <CANYiYbGfJ_R_yT5+0=qTrvzt0GdxsG6EtjWJauHNAyUNpaPwNg@mail.gmail.com>
        (Jiang Xin's message of "Sun, 1 Apr 2018 19:18:13 +0800")
Message-ID: <xmqqo9j1zfx5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Would you please pull the following git l10n updates.
>
> The following changes since commit 0afbf6caa5b16dcfa3074982e5b48e27d452dbbb:

Thanks, done.
