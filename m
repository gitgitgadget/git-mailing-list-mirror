Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E1B3207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 14:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3001136AbdDZO17 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 10:27:59 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34556 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3001121AbdDZO15 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 10:27:57 -0400
Received: by mail-io0-f177.google.com with SMTP id a103so3747404ioj.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cfdrMwuI0ligse/Reoi3Vcu+43Eo7IUIT7gvijyq7HU=;
        b=bxnJ6X/oMfcNCvJcPT3lPLsfkoXhCSE3cNipIzfc1rB5gc1UpmYEMYDvsKYPnyJB+U
         M0I7ihQtbWD4fDjViPD7PM/0eKvu0c/Y+ARz3yxOm4bIx8Oq0HulAVV/zVBmk+MBmTIn
         sN539f6rldQH58d32k6lmvep/yaA5228waxPgBFKWXGzTxEgCDw/tvl+y8p0XUtM1Pwl
         AecPIiplFIE3aKCGiVVk816No7GSZi/G3NE0dl9YL1uL969ZULNm9MC8Q6Gm6l0B3OKW
         /eh95SQlsTnZFZJWHHVKL/pUbK7oI1TbiKXe/bgee5toWgmFe7YbOJOwhQ6bCAyWd7il
         RsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cfdrMwuI0ligse/Reoi3Vcu+43Eo7IUIT7gvijyq7HU=;
        b=pRuU+sc2znyeru87PGQMSi7J7eWj2xilhGedgdLyRboMwxFDGeAu5agCVwqClwXXML
         xYPofi7n1BVtm4RuCH6WPRe2D36N3+1myfePoTWLOW8ZUaXp/MqdQ+VDQOALAEzxObWv
         XW/HygEJy0JiPNhMQi0kZilGrKC1I4+WiAHdHyU6KkOQU6Kc8Qo5V15Z9djf6aXNOrLO
         YtcknO8+LbA/X692pTWirw1ZzK5+HMvTWrPgupFbRljM7XGh+TstTEUQKuE33iET/JhI
         V/Dsk617xr9slYoUUVgn0o8lqEpT5StJm8xmcIzE4uRAx0SRDehNey3j/S1hUK6wmOEz
         Z36w==
X-Gm-Message-State: AN3rC/4NsMCSCiMaWdbGp//o08DcZComfvgascSP3T7G0A9tZWxtkMcK
        2DTV/ACNvsQToefTrydajGf2WG+USw==
X-Received: by 10.107.146.139 with SMTP id u133mr42156iod.160.1493216876709;
 Wed, 26 Apr 2017 07:27:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 26 Apr 2017 07:27:35 -0700 (PDT)
In-Reply-To: <4bd88c83-1892-8fc2-981f-f31cfd1b4c87@grubix.eu>
References: <xmqqwpaa38o2.fsf@gitster.mtv.corp.google.com> <20170424110434.27689-1-avarab@gmail.com>
 <4bd88c83-1892-8fc2-981f-f31cfd1b4c87@grubix.eu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 26 Apr 2017 16:27:35 +0200
Message-ID: <CACBZZX4opSbALKGQXcXsp2=698rxbx8+1GBSJ6H0TvRriaNk9A@mail.gmail.com>
Subject: Re: [PATCH] tests: remove the GETTEXT_POISON compile-time option to
 test i18n marking
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 11:17 AM, Michael J Gruber <git@grubix.eu> wrote:
> [Turns out I still can't operate gmail's web interface. Sorry for the dup=
e.]
>
> 2017-04-24 13:04 GMT+02:00 =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com>:
>> Remove the GETTEXT_POISON=3DYesPlease compile-time which turns all of
>> git's LC_*=3DC output into strings like "# GETTEXT POISON #" instead of
>> gettext(msgid).
>>
>> See commit bb946bba76 ("i18n: add GETTEXT_POISON to simulate
>> unfriendly translator", 2011-02-22) for what this was originally
>> intended for.
>>
>> This facility has been broken for quite a while and has been subjected
>> to frequent bitrot. The initial idea behind it back when it was added
>> in 2011 was to prevent the accidental translation of plumbing
>> messages.
>>
>> This isn't a big concern anymore as git isn't mass-adding i18n
>> messages for a newly developed i18n facility as it was back then,
>> maintaining this facility incurs a burden, and in actuality this has
>> often been broken long enough for potential plumbing messages to be
>> translated & make their way into major releases anyway.
>>
>> Most of this patch consists of search/replacing the test suite for:
>>
>>     test_i18ngrep ! -> ! grep
>>     test_i18ngrep   -> grep
>>     test_i18ncmp    -> test_cmp
>>
>> 1. <AANLkTi=3D5MrU-JyeQ3UVNbVwzn-8FbstUXafgcQaLWXDB@mail.gmail.com>
>>    (https://public-inbox.org/git/AANLkTi=3D5MrU-JyeQ3UVNbVwzn-8FbstUXafg=
cQaLWXDB@mail.gmail.com/)
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>
>> On Mon, Apr 24, 2017 at 3:18 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> Michael J Gruber <git@grubix.eu> writes:
>>>
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.04.2017 =
23:58:
>>>>> As a refresh of everyone's memory (because mine needed it). This is a
>>>>> feature I added back in 2011 when the i18n support was initially
>>>>> added.
>>>>>
>>>>> There was concern at the time that we would inadvertently mark
>>>>> plumbing messages for translation, particularly something in a shared
>>>>> code path, and this was a way to hopefully smoke out those issues wit=
h
>>>>> the test suite.
>>>>>
>>>>> However compiling with it breaks a couple of dozen tests, I stopped
>>>>> digging when I saw some broke back in 2014.
>>>>>
>>>>> What should be done about this? I think if we're going to keep them
>>>>> they need to be run regularly by something like Travis (Lars CC'd),
>>>>> however empirical evidence suggests that not running them is just fin=
e
>>>>> too, so should we just remove support for this test mode?
>>>>>
>>>>> I don't care, but I can come up with the patch either way, but would
>>>>> only be motivated to write the one-time fix for it if some CI system
>>>>> is actually running them regularly, otherwise they'll just be subject
>>>>> to bitrotting again.
>>>>
>>>> I use that switch when I change something that involves l10n, but
>>>> usually I run specific tests only. To be honest: I have to make sure n=
ot
>>>> to get confused by (nor forget one of) the build flag GETTEXT_POISON a=
nd
>>>> the environment variable GIT_GETTEXT_POISON. I'm not sure I always
>>>> tested what I meant to test...
>>>
>>> To be quite honest, I have always felt that we are just as likely
>>> inadvertently use test_i18ncmp when we should use test_cmp (and vice
>>> versa) as we would mark plumbing messages with _() by mistake with
>>> this approach, and even with constant monitoring by something like
>>> Travis, GETTEXT_POISON may be able to catch mistakes only some of
>>> the time (i.e. when we do not make mistakes in writing our tests).
>>> Without constant monitoring, I agree that the mechanism does not
>>> work well to catch our mistakes.
>>
>> Here's an alternate patch to just remove it entirely. I think we
>> should apply this instead, the only reason I sent the patch to fix it
>> up was because of Michael's comment that he was occasionally using it.
>
> Yes, I think test_i18ngrep and test_i18ncmp gave the impression that
> they are i18n-aware grep and cmp, whereas in fact they turned off
> these tese test lines completely.
> Combined with the fact that GETTEXT_POSON builds turned on
> GIT_GETTEXT_POISON, this sounds somewhat dangerous - we test more
> aspects of plumbing commands but turn off (some) tests for porcelain.

It gives us no less test coverage because we still run the tests
without GETTEXT_POSON. Thus running first without that & then with
gives 100% coverage.

The entire point of the GETTEXT_POSON mode is that we've already
manually gone over things that broke in the past, and are skipping
them with C_LOCALE_OUTPUT or one of these i18n functions, and when
adding new translations we keep an eye out for new breakages that
haven't been marked yet.

These are then a candidate either for marking to skip, if they're
porcelain commands using our new gettext()-utilizing code, or we've
made a mistake and translated some plumbing, in which case that would
hopefully be caught by list review or Travis.

I still think it's better to just get rid of it, but this aspect of it
is working exactly as intended.

> I'm still wondering wether we couldn't generate a test locale
> automatically by mangling the english strings (but preserving format
> specifiers). That way, tests that test porcelain output could require
> LANG=3DC while others could run in the mangled locale. (tt_TT is taken,
> though ;) )

If we wanted to keep GETTEXT_POSON this would be going further in the
wrong direction. The reason the message starts with a "#", has no
trailing \n & most importantly ignores any format specifiers the real
translation would have is exactly because we'd like as many things as
can break break under this mode.

If anything we should consider changing "# GETTEXT_POISON #" to
"<random binary garbage>" if we keep it.

Including format specifiers would just reduce the set of things that
would break, consider e.g. a test that merely greps for some substring
that would be emitted by a "%s branch %d commits ahead" format, now we
change that to "%s GIBBER %d ISH", but the test still passes because
it just does $(awk '{print $1}'), but it might be a plumbing message
that could be translated as e.g. "%d WORD1 %s WORD2 WORD3", breaking
the API.
