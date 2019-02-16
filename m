Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4E181F453
	for <e@80x24.org>; Sat, 16 Feb 2019 18:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfBPSFn (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 13:05:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34816 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfBPSFn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 13:05:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so12803257wmt.0
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 10:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=chh6DWc9uQXjVObf47Kx8Y9FdPXhjBnCIkdEAeW61eE=;
        b=ENY4VoaLvRpbaqJW9jTV7mNpw0IHxwmNbc/cAyTyScxJKLfjmM2pnQpL/FodpcLFIG
         rnnLOrDaF7amczqYI9iVxkaMeeTs0brLvGC11A6Gvd7kEuPHozEGaFRWPaBjneN4zvLN
         IyQVnaXsvzlA3UNN+sR03012R9K3kQbGzkmu27tndNSQl1ILreeQ1rHSolgsK+OlEX1R
         UnJ1xiQ8QqzYtGL3M33LdCzAhfZRlsYa1hVqAuNwEUYJPC7rI90Fird+bjZ4Lb27uzSx
         SzJepa0d77blGEm8BjK5pxpyHFrnrZxjSweJLaVEQ+aHYlBUfAClqt58AjVJtwEQ3ym5
         fawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=chh6DWc9uQXjVObf47Kx8Y9FdPXhjBnCIkdEAeW61eE=;
        b=Xb4VJLZG912sx03aHp+qn4J2qYUDQP0lqtQLZZY4eW6AvrQ+C5haH+f2SodX1BqhW4
         7C/16ekMenIzRmUvtUifzz5vs1HO7SoXkZEvEz9UAOpRO0PTuFEUV+Au+Bz8zmMnLqy5
         bUVXy5fs5cLsqycXEk5uI4WMd6492r9MHJ3fW9wiZkDVHZzq9W9Jz5GrWAtF9UDZTkVb
         k5LyC1jNm1wHncSTCxLg05ial/ruGdAZwYI/CUgegJnzjiFlNAFOPDnTSNNB1jrL3nH/
         oKtWepU0gTqaHuzFuy6hNPp5KR9vhXP3yph6xYZXR7+UPuTq1wtH50mr1NnCvgNDTRG1
         UjMw==
X-Gm-Message-State: AHQUAub43vaOoJLOsmCQllLnkuA+SadrMw6r/eVGdZUH1JqjcoMb+I1g
        SO1icSqTAIYmCcADtJ6qf5o=
X-Google-Smtp-Source: AHgI3Ia9vx2OCChZB8DdwuLb/J0G3UgpN/1SwIz1pslvtRCJbnMr6rSrkTGPgIgzwyyAXxb2hTUxZQ==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr10394718wmh.115.1550340340751;
        Sat, 16 Feb 2019 10:05:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y18sm12577894wmi.5.2019.02.16.10.05.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 10:05:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Max Kirillov'" <max@max630.net>,
        =?utf-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc1 (NonStop Results) - Good News
References: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com>
Date:   Sat, 16 Feb 2019 10:05:39 -0800
In-Reply-To: <001201d4c617$de429540$9ac7bfc0$@nexbridge.com> (Randall
        S. Becker's message of "Sat, 16 Feb 2019 11:51:25 -0500")
Message-ID: <xmqqftsn4nik.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On February 16, 2019 3:27, Max Kirillov wrote:
>
>> What you could try is
>> https://public-inbox.org/git/20181124093719.10705-1-max@max630.net/
>> (I'm not sure it would not conflict by now), this would remove dependency
>> between tests. If it helps it would be very valuable information.
>
> Good news. This patch does seem to do the trick. I wonder whether this fixes
> the Azure build also.
>
> I have run the test under the following conditions:
> Run 1 (system idle): Pass
> Run 2 (system idle): Pass
> Run 3 (system idle): Pass
> Run 4 (system idle): Pass
> Run 5 (system idle): Pass
> Run 6 (system mild load, heavy file system): Pass
> Run 7 (system mild load, moderate file system load - git fetch): Pass
> Run 8 (heavy system load, heavy file system load): Pass
> Run 9 (--verbose, heavy system load, heavy file system load): Pass
> Run 10 (GIT_TRACE=true, --verbose, heavy system load, heavy file system
> load): Pass
> Run 11 (very heavy system load, very heavy file system load): Pass

That indeed is a good news.

> The current condition of the code is (the generate_zero_bytes delete was
> previously removed so can be ignored for the patch):

Just to make sure I do not misunderstand, this result is with Max's
patch but without the generate_zero_bytes stuff?

Thanks, all.  Hopefully we can get this test failures behind us
before -rc2; knock, knock...
