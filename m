Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689A0200B9
	for <e@80x24.org>; Fri,  4 May 2018 03:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751240AbeEDDXR (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 23:23:17 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34238 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEDDXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 23:23:16 -0400
Received: by mail-wm0-f41.google.com with SMTP id a137-v6so5258726wme.1
        for <git@vger.kernel.org>; Thu, 03 May 2018 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zo/RC2bGx3E7RmYvqSu/dBAKX58D6usSq8E2r9tIynw=;
        b=QIQU0CmRXkhkbMp6TylPJalbEymFbExJYoeKFchnvZZHGpDcAsLZWW0KXkD4AC/J41
         /YnkkaQ6s02HbXfjFkxIlUju9j94oB4u4waaSGyjxeFCPzmU5iQhbtznjRjzTL52Bw/r
         x6grv51mXyKDyUYT6Kq8EcN7YB5vxmNiaJPIlgkAf0KVwVrafYNK3Eq9adxuS+QytqxX
         8tWiGV7kjwvf85b2vUGH6aCJ9NnHF690dO5zwk3j7Mn9R3n3UEvEbCptvXJ7k2Zw86vH
         yMiorc5XxGr+Eb2Dh7jcv6Hju7KnPqA38ayKvU/jlX9IwcRNqfhTkc7+Oxb+nml5T4Dw
         sXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zo/RC2bGx3E7RmYvqSu/dBAKX58D6usSq8E2r9tIynw=;
        b=GS4UwjASHHxXl/4yV+QnlEkigT0iqEpxl7BmnV7go8wjRUhoHMj47bdp7fFnFPxhLD
         KcjoXu/ogPZfsyj8rRuWPWr6h2+GDpkwoBROEmuQX3c093XHZaiE7pAe3zdT82kB5SI7
         SDrAhfzb2jPcg7rV8n2PfXxqQ9wsGDF83YEw/BOmLAckD3uTaGKSnR/7ccUdvbJK7a47
         EM0OkWDKao4hjatN1YhsK22XF0+uPgYhe7r/TPVXnEwtExF5yekxY/bppCT3Cqo18spx
         Hlcv5HWGUvIoxaCs33VrXXySYS8TQcOESGFYbwt+jtmuUFhqJCk3yxtMENiX5tjQa1nr
         tGXg==
X-Gm-Message-State: ALQs6tBmtsvpaHVcBtgdsxOdhgXXrh2T6ZUncCGZa8bJiDlA2gpnIl4b
        b5ivNTDA3VvvXjDmLoqoqj8=
X-Google-Smtp-Source: AB8JxZpWqZGOrg83NQgRdVFmofQGKWkO6w5ad3sSmOPZO57Wlr59i/t3Qy115+t814vV+yGeaNRByw==
X-Received: by 10.28.15.195 with SMTP id 186mr17655137wmp.113.1525404194893;
        Thu, 03 May 2018 20:23:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a139sm573548wma.43.2018.05.03.20.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 20:23:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
        <CAGZ79kZAidPafdfu1NGwwpVo1Vy=vKOV+EREE2=-ct_sbo7Gkg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1805032227520.77@tvgsbejvaqbjf.bet>
        <CAGZ79ka7RJq=tNnBsLs6wwL7Cf3hSJODM2iLW5tet-csAM20eg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1805032334180.77@tvgsbejvaqbjf.bet>
Date:   Fri, 04 May 2018 12:23:13 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805032334180.77@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 3 May 2018 23:49:31 +0200 (DST)")
Message-ID: <xmqqa7tgt87y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> So please: as soon as you have a concrete suggestion where to use cyan
> (and preferably even a DIFF_* constant to feed to diff_get_color_opt()), I
> will be more than interested.

I do not think Stefan's comment was that he was keen to use 'cyan'.
It was a color I suggested in a review of his change where he added
new colors to the color.[ch] palette, and I found that reusing an
existing color would have achieved the same distinction between
lines of output from his code, and it would be beneficial to make
the outcome consistent to consider why these existing colors are
used in existing places and trying to align the rationale for new
uses. "cyan" was cited as an example to illustrate that last point,
i.e. we use it to dim out relatively uninteresting part.
