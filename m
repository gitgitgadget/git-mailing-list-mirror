Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8EC0209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 19:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751453AbdFFTD6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 15:03:58 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37474 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdFFTD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 15:03:58 -0400
Received: by mail-it0-f53.google.com with SMTP id m47so116193066iti.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GUcysJcFPYh/0PaPqCITJ5jmo6SOJsfpAqm/rSBWY8k=;
        b=JiUZzgHGpe5397oz9jgBasSceJV7ROrU7RRsEr9cU94g/6J5aiI6CPX1H/ZFQ64ioi
         JZzmxffXAkoEOmhEbc2tnOWZZpjF6Y75kvyPWAMCgXXXzGyNF8rRVs0QIKx52UfoonxA
         aC0iMwBr5IdafWaPSMgGJOIIoxXpzRrZ4uzlugSNXleRbHyU74R1BPq0pYTVWoDNOgdv
         p/suGkW4dGc5bMPAPNU/0v+kgTD6d3LyTMkYdSvbGQWQ372738keEtfelURzxKCYeNoI
         uag7sGkDC13PPA11uhnJpf709MZ2uW9WUEbVsvtsON22Kxww+ymVJl1/qPHPJ0XhZdeb
         66lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GUcysJcFPYh/0PaPqCITJ5jmo6SOJsfpAqm/rSBWY8k=;
        b=YtowIfHJrSKsZCTLQ7wdirVCKzJhJCLQYZcW6eTwkqSIFzWmcDKR3su4qCe2WH5yr8
         MRww+KXoTUujhAlKEkaLQqrmuxu/4enSak1ryiD3X/3N9oacvPpz1Yjumzvj+YubAdOo
         iD/DJxHm4UM76iGYbMD5hUuoprOmzUqmIbT3Yi3DVXBT6uvfJv3dnhVkMAHH69hrjVCw
         k4FVA3TZUC/WXmWLIVTBEEwCg6kK0+QxF+FX42kBgYKHlk2W7Ijkru7XzLQfPY3IYzSb
         a1Yu9S2gcspd416121kfxZ6D6xHfiqXyfNdKoOLseq7PFrYcmYfMbLoFlzOXMxzgLZrX
         SPZA==
X-Gm-Message-State: AODbwcAYNOrMADuAbN57Ww3a39WW1cqs7yYYUGPefgERPMgfIrawbEwE
        Web5o5bKj7SUd3zqvUpcYjFMnWzf7A==
X-Received: by 10.36.164.67 with SMTP id v3mr7507784iti.71.1496775837096; Tue,
 06 Jun 2017 12:03:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Tue, 6 Jun 2017 12:03:36 -0700 (PDT)
In-Reply-To: <CAGZ79kYGaF6=RQZ2HpTZ8qE50V2SU0DO+-0nx-n9WEkQmM4WoA@mail.gmail.com>
References: <20170606124323.GD25777@dinwoodie.org> <20170606151231.25172-1-avarab@gmail.com>
 <20170606151231.25172-3-avarab@gmail.com> <CAGZ79kYGaF6=RQZ2HpTZ8qE50V2SU0DO+-0nx-n9WEkQmM4WoA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 6 Jun 2017 21:03:36 +0200
Message-ID: <CACBZZX6WJDrcUj4WMxZsShEaXK91CxR2sMUbWV+K3AudNYAXbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Michael Kebe <michael.kebe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 6, 2017 at 8:48 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jun 6, 2017 at 8:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> Add an option to use the sha1collisiondetection library from the
>> submodule in sha1collisiondetection/ instead of in the copy in the
>> sha1dc/ directory.
>>
>> This allows us to try out the submodule in sha1collisiondetection
>> without breaking the build for anyone who's not expecting them as we
>> work out any kinks.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>
> Other projects using submodules sometimes have
> a .gitattributes entry to have .gitmodules not exported
> via git-archive. Do we want a similar thing?

Right now we end up with an empty directory due to the issue you noted
in https://public-inbox.org/git/CAGZ79kZC98CxA69QjmX2s_SU6z1CSgKgwZeqvwiMRA=
Qc6+S3xg@mail.gmail.com/

It's probably best to have the .gitmodules file as some hint that
something should be there. We also ship the other .git* files.

> Speaking of attributes, I wonder if we want to specify
> the .gitmodules file to be text with unixy file endings:
> Having an entry
>     .gitattributes eol=3Dcrlf
> to simulate a Windows environment doesn't harm
> submodule operation, which is good. I'll check if we
> have a test for that.

I have no idea what that would do or why we'd have it, but I'm going
to understand this as you looking into it :)
