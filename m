Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 139A81F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeDVXdP (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:33:15 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:37922 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753443AbeDVXdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:33:14 -0400
Received: by mail-wr0-f179.google.com with SMTP id h3-v6so36316689wrh.5
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WcCf5hwZxCqsa0LShcKu7c9mbXjbuVXtyMYtnqZ/Pms=;
        b=FVk0TVZF2sQjxWHehq+Kq7TAeA9x9W2jhKkr6TCKwThX7cCXRED1kenSsCljfXI9AM
         i4Q9YpcU4j4dxmp1wtcc0FYXYBuiNOV8zkUnRmNLovkMwhWypeqcCLeYWUpa9TVptCQl
         JBjRZ7D/L5IlyMRMKbxXJQR/jk8Qtpb375YOAb67fZlfjcknaSu9p/BeIl4Cl6d8pVJA
         yXXCf8ot3ZPxMlI+NIdfXdQQZXvvyJUMIfn5Zv6Ebo7+TdegmefazPLDSCEwlbMz+Hmw
         SuY8Anr7rbpwGGw0rw2JFAmfZOeUpUFZ4ImqSWjErifrH3u34c/QBsVgEfzmx572OhTm
         I0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WcCf5hwZxCqsa0LShcKu7c9mbXjbuVXtyMYtnqZ/Pms=;
        b=HVlRRvQobYhsoMZNlNnqMvWYTLwrsqEZHlwxHJgIKruI5IMmCgo9yKRaiF3VPOt+Ig
         gy3E11G3epJTTFeNpiS8hu5imtG8LbJFGCcYuzeApNfpfZsYgoWmbKpcYWCD5HPnmm/7
         UXLve+njM4tlHK3AngddLpaw9E51nNJ0aAf84K5H7zBs839BpQvTxoqi1VvSf+dKxF77
         1CjgV7lsfUo4jrIsgvqaLhA/WUjCp0xAHM6TgY/qtS34LGedUADQBvhASHXs6q3KPsft
         uuR9lcgAkDDb11A5bMToIxAsHoi3HCScbYbKumo3LiGqKlsSpwTysV8wZ1jFdB5ay9MY
         anXg==
X-Gm-Message-State: ALQs6tDbvxuj58LcC1hjkgruH/ONQI02JBr3/N8omQLCuI4oKtKV0Upj
        kPrLXpmRUlNIHTRycjj7Sz+id+M/
X-Google-Smtp-Source: AIpwx4/rJ2FYwpYDoK2699aEGbD6+wJB+Jg0q5KC1dQlRVOr+P9Z4UdnE38TOP86wi7U/Qg24Q3BjA==
X-Received: by 2002:adf:c412:: with SMTP id v18-v6mr12465963wrf.20.1524439992900;
        Sun, 22 Apr 2018 16:33:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y100sm15454477wmh.2.2018.04.22.16.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 16:33:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
        <20180422201755.GA92212@syl.local>
Date:   Mon, 23 Apr 2018 08:33:11 +0900
In-Reply-To: <20180422201755.GA92212@syl.local> (Taylor Blau's message of
        "Sun, 22 Apr 2018 13:17:55 -0700")
Message-ID: <xmqqo9iaakaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I noticed that tb/config-default, however, only landed two commits:
>
>   - builtin/config: introduce `color` type specifier
>   - config.c: introduce 'git_config_color' to parse ANSI colors
>
> but not:
>
>   - builtin/config: introduce `--default`

Whenever something like this happens, especially the patch was
original sent more than several days ago, it is helpful to give the
message-id of what you are referring to to identify and retrieve it.
More often than not, it wasn't explicitly rejected but was simply
dropped, either by mistake or got delayed in delivery and got
forgotten.

Also for a pair of small series like these, when rerolling the
preparatory series for the final round, it is helpful to also send
the other series that depends on the preparatory one at the same
time, even if the latter hasn't changed since the last time.

Thanks.
