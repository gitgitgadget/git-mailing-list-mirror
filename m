Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33BAB1F404
	for <e@80x24.org>; Wed, 31 Jan 2018 22:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751839AbeAaW7h (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 17:59:37 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37561 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbeAaW7f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 17:59:35 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so2165749wmv.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 14:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YMm0GkV/gJvCOfNWD5/34vueYXX9tAblgru2kYX96YE=;
        b=Gf4tmhL1QlSmlFjP2rpbHOChogkk7uclN2gv0+j/UAdVHuHg3cDL5K4k4O/6RNYQSu
         o6w6bgaccx+0sKNuTJmPKcT516lRS+vMkS/fjTUFak32u+QPCuNz7GjSCOgRuD6fh2kk
         igSVf3GCoodm0GJSUtwqUtZO5TTuKuA1Yb6w/mel3GexVhObwj2KlD8EkPJ3ZiMXzMyh
         1A+k1LqjHC7RHow1x5OhoJnwsCcylHstCjhcl5iGHLrc453GgIsKRDZScCNpk2DUbvKi
         jPOWz57xLp5hFLXC68QtDikpIyUc+Kgm91vampFTeH5kKevdmPm4yB3Xs4i5kc9uQMbL
         aaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YMm0GkV/gJvCOfNWD5/34vueYXX9tAblgru2kYX96YE=;
        b=SWyS//Uc/Xn2I5YVY0NsKMitl1gxZSG0vfO/LcnCkvz2+r7SXIb/q0KRS3CBLir1Pg
         VEDSxeqhGu2o8jRN9MvUShCfNGWzqVIxPEvdA8rQl0/gXb/F7jnqDIg/di7YM5z8DQi7
         Gb2sErUvM1nd/9iZQ/50cCo3WFOi9RNnJOZMJSDLJpyKXujiJ3q+M/7afpIOzxpLl50A
         p3xFuMCJgLs+1Q45txP8VCxVoOFuhnqLawcRHGpV1VR2/MmcCNtvjYm/7qY47eaL1RkJ
         9/HFJEjKmJiCF8CEycWMiOrRCw/TqzwOA9yQvtzUkRF0UIh1CJxM7UJ6Uq4lxmNoA75i
         NojA==
X-Gm-Message-State: AKwxytfhiiQ9gc3qLXropilpB0Gdn79VatIxO4MnyfP9f0kQnCOo7qQx
        ucaSPQpa3HiJSfPf162v20w=
X-Google-Smtp-Source: AH8x226wwrUs8sPXZvqz8+e4ksTlp0LviVK06DH9s4oaTABkZQ2Xz5ogIzBVGCZIBinhATKlCm3meg==
X-Received: by 10.28.231.8 with SMTP id e8mr3741450wmh.148.1517439574216;
        Wed, 31 Jan 2018 14:59:34 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q195sm864916wmb.33.2018.01.31.14.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jan 2018 14:59:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        tim@tim-landscheidt.de
Subject: Re: [PATCH v2 1/3] am: add --show-current-patch
References: <20180126095520.919-1-pclouds@gmail.com>
        <20180131093051.15525-1-pclouds@gmail.com>
        <20180131093051.15525-2-pclouds@gmail.com>
        <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
Date:   Wed, 31 Jan 2018 14:59:32 -0800
In-Reply-To: <CAPig+cR24=0_NPekYaF+oG9OovDkv1Et-RpNvAHqE7Qd7g7QQA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 31 Jan 2018 04:40:46 -0500")
Message-ID: <xmqqpo5pr5wr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 31, 2018 at 4:30 AM, Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> Pointing the user to $GIT_DIR/rebase-apply may encourage them to mess
>> around in there, which is not a good thing. With this, the user does
>> not have to keep the path around somewhere (because after a couple of
>> commands, the path may be out of scrollback buffer) when they need to
>> look at the patch.
>>
>> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
>> ---
>> diff --git a/builtin/am.c b/builtin/am.c
>> @@ -2121,6 +2120,22 @@ static void am_abort(struct am_state *state)
>> +static int show_patch(struct am_state *state)
>> +{
>> +       struct strbuf sb = STRBUF_INIT;
>> +       int len;
>> +
>> +       len = strbuf_read_file(&sb, am_path(state, msgnum(state)), 0);
>> +       if (len < 0)
>> +               die_errno(_("failed to read '%s'"),
>> +                         am_path(state, msgnum(state)));
>
> Isn't this am_path() invocation inside die_errno() likely to clobber
> the 'errno' from strbuf_read_file() which you want to be reporting?

True.  After coming up with the pathname to the current patch file,
we are going to exit without ever calling am_path(), or underlying
get_pathname() via mkpath(), again before exiting anyway, so perhaps
it is sufficient to just do an am_path() just once upfront, feed it
to strbuf_read_file() and also to die_errno().
