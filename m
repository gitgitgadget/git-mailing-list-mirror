Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41571F453
	for <e@80x24.org>; Fri, 26 Oct 2018 04:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeJZNOa (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 09:14:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37472 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeJZNO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 09:14:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so11424915wrq.4
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 21:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GrCwHfhE9Ds2JXxZa1mz3EXfZE7AisWZAxR7ULGrT1w=;
        b=ZxDANQRxbDgcrKjfS513dfc9n5cgGzNGKlH1a3cmz6ILnFxuTklqnvJd6oH9GEtFxH
         jiQGdBKnNxbIYWTo+ns09w8RNueemHyHIV3lF2zPc1j5XzZnttguOyEtR/WRIk/hkBDX
         mLNV2EGbhGhRLqkY1vQ6yn24FcLzZGWT70xPiBkF1+Tzp5FENUUUnpNHbSyYFLuQKjLN
         sYdjz6/nbWi22Nzwd+/4HGSJX1QIWTcpQehwJXm+PYozkv+nQAEoTj5PubcrHxUxgHS9
         w0bxf77+xcPorJs1ZLnaFGhvhpM/TU5kU8rMEX1ork758n207ggnzHG87jG5fpWdvEiJ
         4Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GrCwHfhE9Ds2JXxZa1mz3EXfZE7AisWZAxR7ULGrT1w=;
        b=tfurubEedCXfxq3wpdzqnf/8tGxDuGraXoVpfaK3Fkx9oZwBqkVTwQ4gjLblHVzpq6
         t/iVjxJK3g1l/OBeTEwJNRr0z/B7hHwpdAs82Qyw2oP/SNXR/XoLei2Ch542kAf2TbOl
         V4zXC55rz5DYuqMeRloBLH3jPhXCCVnu2jE5qatPHQKmpDRTE57yqUweuRQgvMkaCNVB
         ynrKXIULM99s2oqRgB9zcOg4vBdf63LUOP2awEUqd4EHvKVqvGzOQWV/bEZlg8q7cjqH
         i54sYNbDKgERjCHNYbPk7bWkaVCOPHupzCzdpjJhkzs6LflFI+gRo7oBZbXjqpgGUpV0
         kiZw==
X-Gm-Message-State: AGRZ1gKctPjL5MTKsS4LZL2EPDqaNkZFGwjrT2h8TJWBwatjSayjqqJr
        roFoB+0kYflFe6O/82G6iSMT1/D5cOA=
X-Google-Smtp-Source: AJdET5ebvWNYQdmYk2Gdal+rBjxUYcUaG1Z7rKR+3Hg65BMQDjA3RfxghiE5z5dBKH27F0Aokfgz7A==
X-Received: by 2002:adf:ebcf:: with SMTP id v15-v6mr4250656wrn.76.1540528744657;
        Thu, 25 Oct 2018 21:39:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y138-v6sm1960311wmd.2.2018.10.25.21.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 21:39:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        github@brendanforster.com
Subject: Re: [PATCH] http: give curl version warnings consistently
References: <pull.46.git.gitgitgadget@gmail.com>
        <764791d13d20478639402e7af95e901223444240.1539598481.git.gitgitgadget@gmail.com>
        <CAPig+cQFb3S0Lm+huUZDN4aw9rWwinh0iZp12ss1zVKpJ=2MdA@mail.gmail.com>
        <xmqqzhv2lnn6.fsf@gitster-ct.c.googlers.com>
        <xmqqsh0uln5c.fsf_-_@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810252059510.4546@tvgsbejvaqbjf.bet>
Date:   Fri, 26 Oct 2018 13:39:02 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810252059510.4546@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 25 Oct 2018 21:00:32 +0200
        (DST)")
Message-ID: <xmqqwoq5coex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 25 Oct 2018, Junio C Hamano wrote:
>
>> When a requested feature cannot be activated because the version of
>> cURL library used to build Git with is too old, most of the codepaths
>> give a warning like "$Feature is not supported with cURL < $Version",
>> marked for l10n.  A few of them, however, did not follow that pattern
>> and said things like "$Feature is not activated, your curl version is
>> too old (>= $Version)", and without marking them for l10n.
>> 
>> Update these to match the style of the majority of warnings and mark
>> them for l10n.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>
> I like this patch better than the one I had prepared for v2, so I dropped
> it again, and "hit the Submit button".

I took your v3 and queue this on top, instead of the previous one
on which this was prepared.

By the way, I wondered if we want to unify them by introducing

	static void curl_version_warning(const char *feature, const char *verstring)
	{
		warning(_("%s is not supported with cURL < %s"),
			feature, verstring);
	}

so that translators need to deal with a single instance of the
message, but the "feature" part may have to get localized, in which
case we'd end up with sentence lego, which is not a good idea, so I
dropped it.

Thanks.
