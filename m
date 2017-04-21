Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0DF207BC
	for <e@80x24.org>; Fri, 21 Apr 2017 18:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041200AbdDUS3V (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 14:29:21 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33252 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422783AbdDUS3N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 14:29:13 -0400
Received: by mail-io0-f175.google.com with SMTP id k87so130871599ioi.0
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5s/DldDqcDc8sPy5zuWcgAjH/FQZHsNJD8TMeFc7Lhg=;
        b=jDEVP5W9P5MvIliCve92cKFycYstWHfm73yf6qegHkpLgiXjELrR33XtTcqwOYZQ9h
         xN8c5gsSalmn8LCGoRAW1UV4BZGDTEoVYygId7xeEuFtE+xyzdBXR0t7+ZJENu/0NKY9
         /aZg5bJZNtTtu1yG2AnC+2PnaeLxtaXUEO3w9joDzTak2RBYt6FGmkELL54c5vuU1vtK
         Nu14TA1ZGrXXJC71pADVHlkPHo52s9pf55M3rG97EeDJh3n0yxrvJhUMemmAKpPOJ18e
         ixGvdn/z93doys7iPYBqwSvjwc5bcPVJgMbhPe7FDtQJ5oqNW71xiM2eGSSdp5cV1SGf
         CS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5s/DldDqcDc8sPy5zuWcgAjH/FQZHsNJD8TMeFc7Lhg=;
        b=BuuM47P420epP5znDrz0yNNeE/QycVUxt/RuVWZNAy3h41BBgpS0XJ/fzJWjIfFUMJ
         KZqZ/GRQ3K0At/kUYFb47ozUkIkAhHA18oN4BTFZRPKnzqe6ijfdEmuhNoi+ct7wMnMX
         hn0GRVOKVoO373npAzQ/rNimXzu0K30EQl0uCrZC99qE2uBng8ETidjj1gMghnWguLEa
         BF8LZU/v+TMLnCg7lQvZm1QML8rD2Nu3bW0ibFSF1Sma2sUZd5XUU8ov0OrGhh85dJSs
         FiCa81+T3m7v3+xUKCC5vbfVELnrDY+ecOXAUCuBzvE/e1Km6qi/rkKZU17MmJbl+Z0g
         3Gtg==
X-Gm-Message-State: AN3rC/4ynpVsgK6TtScEWVV8/DVlI3F1McSPD2yxnUlOlCZC3Gc1RT6y
        TGwY1vDgudlOWcMu36eyHuDfz/liE7DIkjE=
X-Received: by 10.107.32.199 with SMTP id g190mr17867636iog.117.1492795723234;
 Fri, 21 Apr 2017 10:28:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 21 Apr 2017 10:28:22 -0700 (PDT)
In-Reply-To: <e7aed763-cf46-4d7e-1b11-0a7a65b8f496@grubix.eu>
References: <CACBZZX62+acvi1dpkknadTL827mtCm_QesGSZ=6+UnyeMpg8+Q@mail.gmail.com>
 <e7aed763-cf46-4d7e-1b11-0a7a65b8f496@grubix.eu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 21 Apr 2017 19:28:22 +0200
Message-ID: <CACBZZX5t43FWGOFeOEZs9gv3sGrv4Y1ZbapHXY2wLEC18ZU-HA@mail.gmail.com>
Subject: Re: [BUG] test suite broken with GETTEXT_POISON=YesPlease
To:     Michael J Gruber <git@grubix.eu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jiang Xin <worldhello.net@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 4:47 PM, Michael J Gruber <git@grubix.eu> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.04.2017 23:=
58:
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
>>
>> I don't care, but I can come up with the patch either way, but would
>> only be motivated to write the one-time fix for it if some CI system
>> is actually running them regularly, otherwise they'll just be subject
>> to bitrotting again.
>>
>
> I use that switch when I change something that involves l10n, but
> usually I run specific tests only. To be honest: I have to make sure not
> to get confused by (nor forget one of) the build flag GETTEXT_POISON and
> the environment variable GIT_GETTEXT_POISON. I'm not sure I always
> tested what I meant to test...

For any of the built-in tests, you just need to compile git with
GETTEXT_POISON=3DYesPlease, the env var is set by test-lib.sh for you,
you only need to set GIT_GETTEXT_POISON=3D1 if you're ad-hoc running
some git command yourself, e.g.:

$ ./git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working tree clean
$ GIT_GETTEXT_POISON=3D1 ./git status
# GETTEXT POISON #master
# GETTEXT POISON #
