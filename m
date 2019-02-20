Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9EC1F453
	for <e@80x24.org>; Wed, 20 Feb 2019 21:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfBTV4n (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 16:56:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34417 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfBTV4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 16:56:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so5637903wmd.1
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 13:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=URqoHkagdnWKFTlCAaoCeH2qDhmOYeQYJe0ChQoWS/w=;
        b=eLyjJFCJeYiiQ8ih/ppE0GeO8JrI0jacTpYf1MYDWv0b8PeO49L5nygs4TcXrdwrzi
         oAubk2FBiH9OX3uUlIl7oKVohFxKhRuWI/n1Nj39oXIkxamGo34pTTSZFExPo71M2DZp
         5KXsoniOaR8SXeo7ItCjZOfObqjdLIvhWywIqIs8l8mgfB6zhiqRq+sdAxzZQZh20ND+
         ts1QkZ05w1FEZYr0mca348BjjFUVsf4DC91KMODkLEHVoEp2Qa/6itW6uwdqXURnbqA8
         sQI1xfCd/arTEE67rIgbAIerzEVZoasgqts1NgqEIvA35NKLb/6zCaEyNXSPzo6skNae
         ApJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=URqoHkagdnWKFTlCAaoCeH2qDhmOYeQYJe0ChQoWS/w=;
        b=n+hQO78CQtTeNkDG6kXF4uU2azQ7VPSyR/AGsbTAMdLk/PiVbfTNhIv/TTKWvqcl/P
         7fzGSnoO0PK7ZdbIY2JYEj6nT10YqEIYkC1XIWaqQ6PgXH7RxAPMIGz6ijFVBXXFXqSk
         1D2SCQXZ8u4pKpdSV8zUNnnhd8AR0UpjXsFwgrk3MQTb2YBRwfFA38Tm7rv1zTtF069k
         sTieFwqOXlFF67MhZr/kiweU6462VqvJD0FxxTcDTB4gV8abvbiYfqUFoXp92/h0dwAS
         Py7rURho88AEfJNes4QpDpB8C2hY3fHUubgS5Ip06KsNYwvyfxUMaWRxMpDo/qqe6ZKg
         jorA==
X-Gm-Message-State: AHQUAuZhR/wejksn750qz8s8HFnebcDzUxWaftIDUN4Q4fqhrAzmwdwH
        A+ZxnFsJwqKpt2WlTBR9R78=
X-Google-Smtp-Source: AHgI3IZbggFAJuAaMNp0F0SMfJdufefD0lpR10EG98HDq+Y/pkUxVGH+cnn/pvOp/uVGJJJrrcqa1w==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr7572850wmj.151.1550699800838;
        Wed, 20 Feb 2019 13:56:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d206sm5263945wmc.11.2019.02.20.13.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 13:56:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 00/21] nd/diff-parseopt part 2
References: <20190207103326.10693-1-pclouds@gmail.com>
        <20190216113346.25000-1-pclouds@gmail.com>
Date:   Wed, 20 Feb 2019 13:56:39 -0800
In-Reply-To: <20190216113346.25000-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 16 Feb 2019 18:33:25 +0700")
Message-ID: <xmqqwoluuns8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v2 changes the subject line to help clarify in "git log --oneline"

Some were not straight-forward converison, but nevertheless looked
correct.  Thanks.

>
> Nguyễn Thái Ngọc Duy (21):
>   diff-parseopt: convert --patch-with-raw
>   diff-parseopt: convert --numstat and --shortstat
>   diff-parseopt: convert --dirstat and friends
>   diff-parseopt: convert --check
>   diff-parseopt: convert --summary
>   diff-parseopt: convert --patch-with-stat
>   diff-parseopt: convert --name-only
>   diff-parseopt: convert --name-status
>   diff-parseopt: convert -s|--no-patch
>   diff-parseopt: convert --stat*
>   diff-parseopt: convert --[no-]compact-summary
>   diff-parseopt: convert --output-*
>   diff-parseopt: convert -B|--break-rewrites
>   diff-parseopt: convert -M|--find-renames
>   diff-parseopt: convert -D|--irreversible-delete
>   diff-parseopt: convert -C|--find-copies
>   diff-parseopt: convert --find-copies-harder
>   diff-parseopt: convert --no-renames|--[no--rename-empty
>   diff-parseopt: convert --relative
>   diff-parseopt: convert --[no-]minimal
>   diff-parseopt: convert --ignore-some-changes
>
>  Documentation/diff-options.txt |  20 ++
>  diff.c                         | 510 +++++++++++++++++++--------------
>  2 files changed, 319 insertions(+), 211 deletions(-)
