Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B54A1F406
	for <e@80x24.org>; Tue, 12 Dec 2017 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbdLLPyK (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 10:54:10 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43750 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbdLLPyH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 10:54:07 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so21528987wmg.2
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KfCydbhcFS/0s+L+LPR1bo2QtytMkBBWyth8MXmwWpc=;
        b=RFUh2QCWv8/qJwoCPFmsspR58zhaqEDoJaRSIpqBE67xbMhSktB5ibNoyeXtooOldX
         NQ/nHgf680Rw9IEeqctu0mCrTD+Wxqe9K5MPoMwcVbOGRk9EEAkyR01J+Mmi38qNGe0F
         eFxzd+WWQnQam6LKu0pjSVDGG2XqfEkeejnte1oFJauMP+hVJJ1Er3TDCTGOT/mGo494
         Mj2y+enr3KqXPp6GuNogZ6H1PCSYipo0LEm28feWtaHqWfuStBQbHJ4tjIRxT/6m9NAx
         vQEmfmBTVYMLco62eiu0h/Mg9eJlHgHNAZwvM3hD1sTvtG7UdpbYOIwxaYE8oTVUoSuN
         tq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KfCydbhcFS/0s+L+LPR1bo2QtytMkBBWyth8MXmwWpc=;
        b=c3XZJMMm7HuLSi+YylVjAaPefiyXqv1szHEDTBxeit0f424C5NLA++CvehqBTiGuzX
         v0dIBK+UqN7guJttOQJEKGhjWYSuxNar234lV4vZnywNWjwjgdtZpz0XZAgFp3AoR0ls
         UWJNCaKYEbrsKAjBKz521/Nj5YJKispguVdlyCm4AYKgJ0CSEkE1W5WS6iPEjfjlFYE8
         uoWz9TDbNSc4HHxYH3hXnZse5dQZQ5wR7pok5+0ltPNSKK8KfHR5bB8HwSS8uKKD0d/Z
         kvwADLIcBQkXD0MHWAwtwpRdsmRtW5eKooJHCelluyaZ6zxn1BUpft+BLh5qiCqpm5Qo
         WG9w==
X-Gm-Message-State: AKGB3mIyPXFxf8pd+zdlg0RvPZxmpnrDIYsSYQuHGLQDdYE+UDqHiyzD
        /1poynm+yhgyh+sbLetSleQ=
X-Google-Smtp-Source: ACJfBos7bNlwXjdmZ4g8z0UJPEnCdSsFo3rs7didhJenqRMsnYlZuh1vmz+Kn7F49yHTJPiphgii1g==
X-Received: by 10.28.5.201 with SMTP id 192mr2066183wmf.142.1513094045860;
        Tue, 12 Dec 2017 07:54:05 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n17sm11906633wmd.22.2017.12.12.07.54.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Dec 2017 07:54:05 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/3] travis: run tests with GIT_TEST_SPLIT_INDEX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171211214255.GA24597@hank>
Date:   Tue, 12 Dec 2017 16:54:04 +0100
Cc:     =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C5F93DFF-D3DF-4507-8546-941BFA768705@gmail.com>
References: <20171210212202.28231-4-t.gummerer@gmail.com> <20171211210948.6867-1-szeder.dev@gmail.com> <20171211214255.GA24597@hank>
To:     Thomas Gummerer <t.gummerer@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Dec 2017, at 22:42, Thomas Gummerer <t.gummerer@gmail.com> =
wrote:
>=20
> On 12/11, SZEDER G=E1bor wrote:
>>> Make sure that split index doesn't get broken, by running it on =
travis
>>> CI.
>>>=20
>>> Run the test suite with split index enabled in linux 64 bit mode, =
and
>>> leave split index turned off in 32-bit mode.
>>=20
>> This doesn't accurately describe what the patch does.
>> Travis CI runs three 64 bit Linux build jobs for us: one compiled =
with
>> Clang, one with GCC, and one with GETTEXT_POISON enabled.  This patch
>> enables split index only in the latter build job, but not in the =
Clang
>> and GCC build jobs.
>=20
> You're right, it's my first time using travis CI and I got confused
> about how the .travis.yml works, thanks for catching that.  Will
> re-phrase the commit message.

Szeder is spot on. If you fix up the message, then this patch looks
perfect! Pragmatic (=3D very good!) idea to combine GITTEXT_POISON with=20=

GIT_TEST_SPLIT_INDEX :-)

Thanks,
Lars


>=20
>>> The laternative would be
>>> to add an extra target in the matrix, enabling split index mode, but
>>> that would only use additional cycles on travis and would not bring =
that
>>> much benefit, as we are still running the test suite in the =
"vanilla"
>>> version in the 32-bit mode.
>>>=20
>>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>>> ---
>>> .travis.yml | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 281f101f31..c83c766dee 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -39,7 +39,7 @@ env:
>>>=20
>>> matrix:
>>>   include:
>>> -    - env: GETTEXT_POISON=3DYesPlease
>>> +    - env: GETTEXT_POISON=3DYesPlease =
GIT_TEST_SPLIT_INDEX=3DYesPlease
>>>       os: linux
>>>       compiler:
>>>       addons:
>>> --=20
>>> 2.15.1.504.g5279b80103

