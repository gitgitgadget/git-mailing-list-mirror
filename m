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
	by dcvr.yhbt.net (Postfix) with ESMTP id 022B11F454
	for <e@80x24.org>; Mon, 29 Oct 2018 17:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJ3C14 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 22:27:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeJ3C1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 22:27:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id d17-v6so9349619wre.11
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 10:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=3c++BQy6QGTvJm8DWw84KXrwpesBwMwiOwgmWB9z3uE=;
        b=fwSLoXpvE0MjxojZOAn9D6O2h/PfbVbNYu84HFgn6eTa50+8G9D+GcXLB6yAwADylV
         57HAqZdHrMGjjHbDA2PXC0yXOwg2b4ey+ozCWihDYpKkl3BALu2DqQLvcE0mAfd7iIgn
         0u+1ZTmNSRvD9uTYW6Ar5FUmPKfyEFpwYhwRcfWV50jqw3gBh4LYMjCyzdk5qLgi1o4o
         dpWfQi0KVyW0lf4dcHs9vNNNxO+n1UtNZvs8BEufoQpLjaAeOZDMHJ5lItoFqHuNWVPJ
         svMg+0OnwlJYxSy+H5jthZhlJ0rIsfzSF+kV/SXGUYF1CVI6BsKEHU1DNsfQudOsQgwb
         o6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=3c++BQy6QGTvJm8DWw84KXrwpesBwMwiOwgmWB9z3uE=;
        b=SpyX1q0ul0eNo7vd7GwI7ACdydPMgQ3DCHX/xriOP537etyMFwN6Jy0S/SU+vz1UMt
         pskQpJlZTZ7WcqcAHYplhPDKCdjsyPfFx36QSOLlGmi7kPsSpgHouyOTCvhtsvHai5oC
         jriotYOWl8/gMLQhFkxc8mWJA9amn7JD2Yy22PRalLsCIO2QEvkVU5Nhm6Ptif4y07hF
         Z2HE29SrzGnSxQnWoOVff9kc8h4Wt9bUVqbwNJZVhQoR0jWuJd8t/NVBuRsQrxUUnW3W
         enrcF9KKIBnFLZ8+vvBqi/MyYxE6+ZJcxxTp/F9IqiJxR/6aeEgAvKXsvwJoQr5LobBg
         wgKw==
X-Gm-Message-State: AGRZ1gLd/rF1PwAA0+elcTkvIek+a9cYezsT2obqssKj/JgVNDXHgrS0
        wtasgO0Sx+TNSlrwA4OzhdE=
X-Google-Smtp-Source: AJdET5dyf+gg3vPyjDspJjxVbEIfXSCFxygWE51ZzXGyht3xHNEFTgk6dD4P+kbrz9LE2zinkrOfyA==
X-Received: by 2002:a5d:5086:: with SMTP id a6-v6mr3192766wrt.31.1540834698549;
        Mon, 29 Oct 2018 10:38:18 -0700 (PDT)
Received: from evledraar ([2a02:a450:3911:1:fd59:dbfe:7c38:41f0])
        by smtp.gmail.com with ESMTPSA id i204-v6sm23240407wmd.28.2018.10.29.10.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 10:38:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
References: <20181028065157.26727-1-pclouds@gmail.com> <20181028065157.26727-13-pclouds@gmail.com> <20181029105304.GP30222@szeder.dev> <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com> <CACsJy8CE2mi69kXcs2sFYm34txfDb24Qqm4bgv_w3WAcYEEFLg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CE2mi69kXcs2sFYm34txfDb24Qqm4bgv_w3WAcYEEFLg@mail.gmail.com>
Date:   Mon, 29 Oct 2018 18:38:15 +0100
Message-ID: <87ftwolkl4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 29 2018, Duy Nguyen wrote:

> On Mon, Oct 29, 2018 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> SZEDER Gábor <szeder.dev@gmail.com> writes:
>>
>> >> -    fprintf(stderr, "%s in %s %s: %s\n",
>> >> -            msg_type, printable_type(obj), describe_object(obj), err);
>> >> +    fprintf_ln(stderr, _("%s in %s %s: %s"),
>> >
>> > Are the (f)printf() -> (f)printf_ln() changes all over
>> > 'builtin/fsck.c' really necessary to mark strings for translation?
>>
>> It is beyond absolute minimum but I saw it argued here that this
>> makes it easier to manage the .po and .pot files if your message
>> strings do not end with LF, a you are much less likely to _add_
>> unneeded LF to the translated string than _lose_ LF at the end of
>> translated string.
>
> Especially when \n plays an important role and we don't trust
> translators to keep it [1] [2]. It's probably a too defensive stance
> and often does not apply, so nowadays I do it just to keep a
> consistent pattern in the code.
>
> [1] https://public-inbox.org/git/20120308220131.GA10122@burratino/#t
> [2] but then translators can crash programs anyway (e.g. changing %d
> to %s...) we just trust gettext tools to catch problems early.

As Jonathan pointed out in the follow-up message[1] this sort of thing
is checked for in msgfmt, so sure, let's strip the \n, but it's really
not something we need to worry about. Likewise with translators turning
"%s" into "%d" (or "% s") or whatever.

    $ git diff -U0
    diff --git a/po/de.po b/po/de.po
    index 47986814c9..62de46c63d 100644
    --- a/po/de.po
    +++ b/po/de.po
    @@ -23 +23 @@ msgid "%shint: %.*s%s\n"
    -msgstr "%sHinweis: %.*s%s\n"
    +msgstr "%sHinweis: %.*s%s"
    $ make [...]
    [...]
    po/de.po:23: 'msgid' and 'msgstr' entries do not both end with '\n'
    msgfmt: found 1 fatal error
    3470 translated messages.
    make: *** [Makefile:2488: po/build/locale/de/LC_MESSAGES/git.mo] Error 1

1. https://public-inbox.org/git/CACsJy8AcUy9FZiiehGc7mEL4i+XP6u0pmH1rGoR-WZnhYT1UMQ@mail.gmail.com/
