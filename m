Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E94207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 13:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1170918AbdDXNXK (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 09:23:10 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:32809 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1170248AbdDXNXI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 09:23:08 -0400
Received: by mail-yw0-f173.google.com with SMTP id 203so76125727ywe.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 06:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RLgom7o7P3crOXMxpQzoOSbSuDtx5lAXI8uNLssgR6U=;
        b=pnCLHiyXXFZpK+UfCbddb7OaNfzfbUrtEa+gNpSg1i5EViQe5QItLRUMWjOjmUG9r9
         jc5aYunCHemqEzHq3SywQsTV7N9Oroi1EWRD2avSd6eU7xaODYGu68RzsVBoHTYG+mC8
         G+crYTs/C/Q68sZ4Azmbk3cdB/1T6UAb8dH8zEY1ZDv9owRPzLEnDffFjhUowKt1KQbs
         J3moML8fWak64mntiMtvPLyPLBn2rXw12zgbOGHwHutDGEG63+pg7fi8aAMRgk2QoF0Q
         or/zugXc5AD1b1JnPx9+RpRoQ9/ykMM2dRI6+FgK96gdSHxStjyjmOh/ArHonLMiUes/
         l+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RLgom7o7P3crOXMxpQzoOSbSuDtx5lAXI8uNLssgR6U=;
        b=ISun8PwPxn+D/64pin0HegxB8EZqUch/wyXprU+kshPePd0X1QIYcJiQi+82s8oyHZ
         2EvJAiO0pAximWcyLk38oBCVkSKt3tdMS7nEBIEU0uOuY1iwLdFW8n5L7zIVWOxN+6HZ
         CfQ1pWV0GdzwXCaTWg157gDy/0HYfFnAEHJlqMQjo/JvTfGVCVd9iIP7GLzEsO/30mHU
         JZOS8QHz9bylZyD9RW0KIxdim8+JPruV5yiQh0Rg4Mlc7j7q1gzNgKNy6+1hkQ2S02a1
         bzWeZhSElEDwaqBsdvHXP7o2VpsMemKxI+vS30Pnqpw05RmiPfd3WCx0w00HueHpDkkP
         sByg==
X-Gm-Message-State: AN3rC/6QjOFiHmzNDsloi1nU1N5aLDrkrhZixhbB6Hjt9aTAExUWH2vT
        XPOkalwSegmqG8DAH4qO3vWblwsoOQ==
X-Received: by 10.157.28.165 with SMTP id l37mr12638716ota.199.1493040187282;
 Mon, 24 Apr 2017 06:23:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Mon, 24 Apr 2017 06:22:36 -0700 (PDT)
In-Reply-To: <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
 <FDAE86E2-F607-4E82-8E0C-0E6DCEF7ED67@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 24 Apr 2017 20:22:36 +0700
Message-ID: <CACsJy8BceB96D39gbjTFx=XQZ6ATHYYQGMRSeV=u4C3jEvTDbQ@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 9:54 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> Am 20.04.2017 um 23:58 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com>:
>>
>> As a refresh of everyone's memory (because mine needed it). This is a
>> feature I added back in 2011 when the i18n support was initially
>> added.
>>
>> There was concern at the time that we would inadvertently mark
>> plumbing messages for translation, particularly something in a shared
>> code path, and this was a way to hopefully smoke out those issues with
>> the test suite.
>>
>> However compiling with it breaks a couple of dozen tests, I stopped
>> digging when I saw some broke back in 2014.
>>
>> What should be done about this? I think if we're going to keep them
>> they need to be run regularly by something like Travis (Lars CC'd),
>> however empirical evidence suggests that not running them is just fine
>> too, so should we just remove support for this test mode?
>
> Right now we are building and testing Git in the following configurations=
:
>
> 1. Linux, gcc, stable Perforce an GitLFS version (used by git-p4 tests)
> 2. Linux, gcc, stable Perforce an GitLFS version (used by git-p4 tests) *
> 3. OSX, clang, latest Perforce an GitLFS version (used by git-p4 tests)
> 4. OSX, clang, latest Perforce an GitLFS version (used by git-p4 tests) *
> 5. Linux32, gcc, no git-p4 tests
> 6. Windows, gcc, no git-p4 tests
>
> 1-4 run the same tests right now. This was especially useful in the begin=
ning to identify flaky tests (t0025 is still flaky!).
>
> We could easily run the tests in 1-4 with different configurations. E.g. =
enable GETTEXT_POISON in 2.

If CI stays idle some time, I suggest adding a test run with valgrind
on 'pu' or 'next'. If there's still spare capacity I would add another
test run with GIT_TEST_SPLIT_INDEX=3D1 (but not right now, it's broken)

Off topic, is it possible to receive mail notifications from Travis
when a fault is found in either 'pu', 'next' or 'master'? I know how
to do it in Jenkins, but I'm not familiar with Travis and there's no
obvious button from the web page..
--=20
Duy
