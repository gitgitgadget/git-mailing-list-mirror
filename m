Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E028320966
	for <e@80x24.org>; Mon, 10 Apr 2017 13:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbdDJNn7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 09:43:59 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:36425 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753255AbdDJNn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 09:43:58 -0400
Received: by mail-ua0-f180.google.com with SMTP id a1so33285073uaf.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8YuvaJMUKjIuMmM67i8ysT3ZyO5m35fc3f+d33+I2sM=;
        b=ggEZYbdqV4OqG7lpkhilm3yb1buV1GtSo26R0Pz1s6afCjPSFdMO4K5d84XDW4aUlC
         GT+fQWa3ITTvBxDOX2gzQMKWvHB64N6PEdpZtXBDtABkq99K6KJAa4eYUR8g2kBqmQ9I
         TwbD03y2uxrLmbrRNz5l1Muoaet22PpVvJXbbj/d4Nunwe3RQlfJUsLzBVRkPZhmo5M8
         vzdCbcy2rChCKMWobKXtsSJZNTJF4tYaZSgO5R1zZW3CUP8NRi+TPsd+XX0LD6Quk1uG
         /0m6lFuq2FgNgMznih5jVOtjIks6PknGAb5+3ymSFNJ8eMRcMJtYlzbaDt6DH30zXggW
         IWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8YuvaJMUKjIuMmM67i8ysT3ZyO5m35fc3f+d33+I2sM=;
        b=WNdViy0s6NWGDwctK2GWEj7C2GJ0ZSP1M291bld6Z6Ju7InPl3VzRKFFaqqqKg7iu8
         t9s/rvagSN8X5s4NivCjm18sovNlSzqqaXfoFuPbEMrisgFgECXjIr12MD8j/9OzpDD3
         WWHTVhWwfsICS2yR3gOrergX/ZeWk7QO41WlmY4KxPQfhGpJ/nEqF8sGrcKyM8XBPdrZ
         V+ETFSG/ynZep2RwoVgPeAke7xU+mkP2opL+PlCj3ZRHBRUMNBEJ0T5lL4db/gd1iRPm
         PGHaXctVTFGq0xE6Xzw3B2ONMQG99rp3RWv1Kn+iQdE7nZSpi6Uia2c9veFlvRGEVyiz
         fQhQ==
X-Gm-Message-State: AFeK/H2RivKp3g4FcrrFd4oWdOqSAwxLbRl2UKnqSThhHjveAOsUVbGlsqDbhJvcPwIIPlBBpzfX9BnZrYFEwg==
X-Received: by 10.176.6.7 with SMTP id f7mr19268230uaf.174.1491831837084; Mon,
 10 Apr 2017 06:43:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.16.94 with HTTP; Mon, 10 Apr 2017 06:43:56 -0700 (PDT)
In-Reply-To: <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
References: <20170409191117.25175-3-avarab@gmail.com> <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
 <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com> <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 10 Apr 2017 15:43:56 +0200
Message-ID: <CAM0VKjmzwQJ4eYboP5BX1qm4tnsjfxsRPN7Asw1-=LAfWgTO-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Joachim Durchholz <jo@durchholz.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 1:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 1:19 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com>=
 wrote:

>> A few other failures are triggered by the ':' in the trash directory's
>> name, breaking the following commonly used pattern:
>>
>>   export GIT_CEILING_DIRECTORIES=3D"$TRASH_DIRECTORY" &&
>>   cd subdir &&
>>   test-git-pretending-it's-run-outside-of-a-repository
>
> Does GIT_CEILING_DIRECTORIES support escaping somehow? E.g.
> "foo\:bar". If so maybe we could use a wrapper to set it, if not
> that's a bug in the ceiling dir feature, surely.

It doesn't, these $PATH-style variables in git, in the shell or
elsewhere tend not to.


>>> b) I think any sort of magic like using it with 'make test', but not
>>> when the *.sh is manually run, will just lead to frustrating seemingly
>>> heisenbugs from people trying to debug the test suite when things do
>>> fail, i.e. you run 'make test' on some obscure platform we haven't
>>> fixed path bugs on, 10 fail, you manually inspect them and every one
>>> of them succeeds, because some --use-garbage-dirs option wasn't
>>> passed.
>>
>> That's not really an issue.  When a test fails during 'make test' with
>> garbage in trash dir names, the dev comes and attempts to cd into the
>> trash dir, and will be instantly reminded that non-printable
>> characters might play a role in the failure when he can't do so with
>> ordinary means.
>
> When a test fails for me I cd to t/ and re-run the test *.sh manually.
> I don't go straight to inspecting the existing trash.
>
> If those manual invocations were running in some different mode &
> succeeded that would be very confusing.

On the contrary, that's a clue to where you might want to look.
Besides, this is already the case when someone sets some options in
GIT_TEST_OPTS in his config.mak.
