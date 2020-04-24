Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63059C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1493B206D7
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 18:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="fvvuMpfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgDXS3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:29:35 -0400
Received: from avasout04.plus.net ([212.159.14.19]:36817 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgDXS3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 14:29:34 -0400
Received: from [10.0.2.15] ([217.32.115.138])
        by smtp with ESMTPA
        id S34ujk9PmpB7IS34vj66kS; Fri, 24 Apr 2020 19:29:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1587752973; bh=vXeFtxAYu5FcA2Q5hQdvADM6CxKNGNoHhP7zmSx9ed4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fvvuMpfnpIvmvUh9E7ThC+DrFF2bccRLTuUC9NalJpATT0viXQAlszC+G9b5q3Alu
         BkXh5x9gkpSud8ibQVrAtC3BvMoRY2+8ZqqGR0b5MlXbu0QqElm76FgMafDxFmJMgE
         N9HliMXNtFCFx7Vknt4B2adbBW3pbEPKhWTJq/zgYFN7vt0yZovWx8+RDgjjMa37G0
         MSQQ8ZrfWaErYiFwLGVIX6nYKYIPMnZ2sEIqXOYsscU4HmtxbF3VCtqElqqn2QSM4u
         Cpdztw9c5p0o/Vyhevvzyhu8liYC8Kjavl2DYaseWw+Mds1BDlrvsPBtW1njBEXjG4
         yC2zNSzahZxig==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=MKb7ZPRl c=1 sm=1 tr=0
 a=T9WNts+jH3PhiGdS1gtV5Q==:117 a=T9WNts+jH3PhiGdS1gtV5Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=wmOa9ne9PhTv1M8BaqAA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/4] compat/regex: include alloca.h before undef it
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
References: <cover.1587648870.git.congdanhqx@gmail.com>
 <cover.1587740959.git.congdanhqx@gmail.com>
 <290ba923b5ee5bcaa4801454b6692deb532bd681.1587740959.git.congdanhqx@gmail.com>
 <820d44c5-5852-fa83-a814-8e58dd120565@ramsayjones.plus.com>
 <20200424170916.GA29153@danh.dev>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0bee8daa-99d0-4939-e225-8783bc0457f8@ramsayjones.plus.com>
Date:   Fri, 24 Apr 2020 19:29:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424170916.GA29153@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOhS98uUAthk2QyF1yWOxT/s832Tsb7DBbITCygPGY5/jyTH4Kwmo940rdepaECD935CNelbyaTxFbU+HLBobsQixEdWuX9i2tSZdVp5Zo7Qx+5FUqTn
 HIT0y0jKlcwBstMYyttPyhjnUAr2b1PWmfJuD/yL5YcJWAhRdMAQ3ZAPhdeFkAcEBQzP2yQCB377Mw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/04/2020 18:09, Danh Doan wrote:
> On 2020-04-24 17:56:46+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
[snip]

>> So, again I don't see a problem. I guess it is possible that the
>> version of sparse I am using (see above) has _also_ fixed this
>> problem, in addition to the prototype attribute placement fix.
>>
>> Another option is that the version of glibc also matters. (I am
>> on Linux Mint, which is based on Ubuntu 18.04 LTS) It would not
>> be the first time that I have seen errors in system header files
>> change from one release to the next ...
> 
> I'm using a Linux distro with musl libc.

Ah, OK.

I just tried re-building v0.6.1 to see if any '<alloca.h>' related
errors/warnings show up for me, but they don't:

  $ sparse --version
  v0.6.1
  $ 
  $ git checkout master
  Switched to branch 'master'
  Your branch is up-to-date with 'origin/master'.
  $ 
  $ make clean
  GIT_VERSION = 2.26.2.266.ge870325ee8
  ...
  $ 
  $ make NO_REGEX=1 compat/regex/regex.sp
      SP compat/regex/regex.c
  compat/regex/regex_internal.c:925:1: error: symbol 're_string_context_at' redeclared with different type (originally declared at compat/regex/regex_internal.h:433) - different modifiers
  $ 

> I guess it's the main culprit?

Quite possible, I guess. What do the errors/warnings look like?

> I have another box with glibc, but it's mostly in Windows 10,
> because my sister is its main user.
> 
> I'll take a look if it make that warning when my sister agree to leave
> that box to me.

Sounds good.

ATB,
Ramsay Jones

