Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F061F453
	for <e@80x24.org>; Mon, 29 Oct 2018 17:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJ3CdM (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:33:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38746 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJ3CdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:33:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2-v6so3319893wmh.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=lN3X0YpSXkxwcUItO+NmbqYPErRw3jWuqMln0Oo+8CE=;
        b=DXVHH+i7xKE4bUitcELpx7WpRG7ZCApd5iNV3LacygjfTCLx7PJoiMm7pOjcXqhpTv
         5AEr6/ND4HniC1PwLnBM9nsnBGkXDoLCYcDGpTqAhtxxH1030a8HSxnI8gAzAvB5Mbwu
         rdBXOhTslmooEAzahj+Dne3VolAPQmvy1rI1QTqGos8mdwTBiGWgpzzdC6MTgkHe16GR
         MfzFifxdyF54pUhXkuaz0AEBZocnuWPF/yAeTWotWpUx3knoGYozB6sS2v/TddYBgZqV
         soPebA8zeu9m9XRZPblhSQzAjcdC46mAn+lH9PTl9aRbNLuoeV+/M7yrCMpLpnuq6J2L
         FE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=lN3X0YpSXkxwcUItO+NmbqYPErRw3jWuqMln0Oo+8CE=;
        b=C3zI3vEu+r7G1q+8horWH4ruXKLat6o4bXJ6A5LmWTx299AhrSzp72e4ZGl4KpKVVL
         42VxrLqBxenicYQ9cNVW4CpNuLV7v1rHOvstwvovW58kC/KhsZpDuvD1uzrkJ9d5Uv9+
         cBtJJsMHqF2ntfNLLUs5qaXvbcgx8uFuL/N7f6WarSxNPQbcK5S75/dzB5+MVKoyeFnK
         v3IEDJ5FoLN7gaKedYqbr08xyl2rVnefjg9U4oSqYYK4A4xXMccs9bhpPwNx8ykSo2ea
         qXQj5GqD7300FxooE/DQPwL8PZGc9raCmwturC/04/FaO1irJ+J456N3KBt2iYk3I0Hu
         dFBQ==
X-Gm-Message-State: AGRZ1gLe4FMChzANtiYQU2kEsmiDW5IqDfRcugsBTJ6+bwejwKiR5LzH
        NXv3xT+H5KvYdY+X3wgZ93Y=
X-Google-Smtp-Source: AJdET5cG852FliPWOulK19hEtOeA2gTIFdZ6x7aqLCOck9nj/Cq3oVc5axKYBijzwoSSBsYZY7f8Mg==
X-Received: by 2002:a1c:c90f:: with SMTP id f15-v6mr14519934wmb.48.1540835013275;
        Mon, 29 Oct 2018 10:43:33 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id 12-v6sm17159402wms.11.2018.10.29.10.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:43:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181028065157.26727-13-pclouds@gmail.com>
        <20181029105304.GP30222@szeder.dev>
        <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CE2mi69kXcs2sFYm34txfDb24Qqm4bgv_w3WAcYEEFLg@mail.gmail.com>
        <87ftwolkl4.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87ftwolkl4.fsf@evledraar.gmail.com>
Date:   Mon, 29 Oct 2018 18:43:30 +0100
Message-ID: <87efc8lkcd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29 2018, Ævar Arnfjörð Bjarmason wrote:

> On Mon, Oct 29 2018, Duy Nguyen wrote:
>
>> On Mon, Oct 29, 2018 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>>
>>> >> -    fprintf(stderr, "%s in %s %s: %s\n",
>>> >> -            msg_type, printable_type(obj), describe_object(obj), err);
>>> >> +    fprintf_ln(stderr, _("%s in %s %s: %s"),
>>> >
>>> > Are the (f)printf() -> (f)printf_ln() changes all over
>>> > 'builtin/fsck.c' really necessary to mark strings for translation?
>>>
>>> It is beyond absolute minimum but I saw it argued here that this
>>> makes it easier to manage the .po and .pot files if your message
>>> strings do not end with LF, a you are much less likely to _add_
>>> unneeded LF to the translated string than _lose_ LF at the end of
>>> translated string.
>>
>> Especially when \n plays an important role and we don't trust
>> translators to keep it [1] [2]. It's probably a too defensive stance
>> and often does not apply, so nowadays I do it just to keep a
>> consistent pattern in the code.
>>
>> [1] https://public-inbox.org/git/20120308220131.GA10122@burratino/#t
>> [2] but then translators can crash programs anyway (e.g. changing %d
>> to %s...) we just trust gettext tools to catch problems early.
>
> As Jonathan pointed out in the follow-up message[1] this sort of thing
> is checked for in msgfmt, so sure, let's strip the \n, but it's really
> not something we need to worry about. Likewise with translators turning
> "%s" into "%d" (or "% s") or whatever.
>
>     $ git diff -U0
>     diff --git a/po/de.po b/po/de.po
>     index 47986814c9..62de46c63d 100644
>     --- a/po/de.po
>     +++ b/po/de.po
>     @@ -23 +23 @@ msgid "%shint: %.*s%s\n"
>     -msgstr "%sHinweis: %.*s%s\n"
>     +msgstr "%sHinweis: %.*s%s"
>     $ make [...]
>     [...]
>     po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'
>     msgfmt: found 1 fatal error
>     3470 translated messages.
>     make: *** [Makefile:2488: po/build/locale/de/LC_MESSAGES/git.mo] Error 1
>
> 1. https://public-inbox.org/git/CACsJy8AcUy9FZiiehGc7mEL4i+XP6u0pmH1rGoR-WZnhYT1UMQ@mail.gmail.com/

...to add to that, if there *are* formatting errors that --check doesn't
spot let's hear about it so we can just patch gettext upstream:
https://github.com/autotools-mirror/gettext/blob/master/gettext-tools/src/msgl-check.c#L572-L756

Unlike the rest of our stack where we need to support however many years
old tools we can freely rely on bleeding-edge gettext features, since
the only person we need to convince to upgrade is Jiang. I.e. he accepts
the PRs from translators, (presumably) runs msgfmt --check and then
submits the result to Junio.

See the "Usually..." paragraph in my 66f5f6dca9 ("C style: use standard
style for "TRANSLATORS" comments", 2017-05-11) for an example. We
already rely on a fairly recent gettext toolchain.
