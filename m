Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650E220193
	for <e@80x24.org>; Thu, 11 Aug 2016 19:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbcHKTIy (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 15:08:54 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35273 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbcHKTIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 15:08:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id f65so9374035wmi.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 12:08:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CMdOIYxKunniXNIIpRdUxrRt6/QRW5XOFUstcJKW46w=;
        b=YVr6xOP02pt8BEyEHLRNZZE4RFYlBkeReBoAnOBXFDu614nP/IXaRvG5uddJNX9BEc
         cRAi9Q1LrZlmDuE9+gGb7d4qJOdUgSuBBiIMArILj+4aIgPM+BMprlvcvzLP+u5gEtAk
         +0C4lFeHtc0eYnlE/gcMWKzlIxfmq12yONT4DnH+ZLxZoR3aEHXRRkCYC/BIbiPSH8m0
         7p0NiKMG1WFMZV1kSm9BDImhzkBP3ycvJBRLUM3ccM1Kdij6EFrJ/9qGHclHVgBsDuGB
         puiKYvQDMEn0yVspmdoT5flaoVpCoK6Tt3s0nB5L+mH3dZ89UX3nErsDnZJHMlBvN/Wa
         1ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CMdOIYxKunniXNIIpRdUxrRt6/QRW5XOFUstcJKW46w=;
        b=N7tLc+7wsywpZPCVIYl4TTl+MVbQ1aYzcmKfhA4zArVC+SNZOe2IYV/scvc31bK67s
         /hyaY45N67ASsh3GqaWOafDe9fLSgHi6Zx9WQQ58755/0r3nEAXWhPNGzGi1uTc6J62t
         PIE8KkUiUhdELCYAv40xXkb/34Od9mBMN+GFYTglThZjjnkMjUroDMVNiVzNYtuYVrtF
         IJYHoxD5vw6jeW/Xy2aIn9nJkRzgLm60bZ9T55Ah2h0Z4R0+G5vAkF8TweJgVNBt3WsJ
         1TyIAiVxk0CD6rMLCAzW5zPvh2QoCzD4bNUddsSoXnJ2hz8Q2w/b0RJNDvR8DOmGocHM
         Kt2w==
X-Gm-Message-State: AEkooutql2l6SB/q+6e30ArAXH10ffD6iHQilWbi6cElsgZr78RIXv5TZkVkeF1QqQBhmSsq8rLLTmf+mebNZg==
X-Received: by 10.28.129.137 with SMTP id c131mr10278541wmd.79.1470942530861;
 Thu, 11 Aug 2016 12:08:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Thu, 11 Aug 2016 12:08:50 -0700 (PDT)
In-Reply-To: <xmqqlh045y0l.fsf@gitster.mtv.corp.google.com>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
 <20160808210337.5038-34-chriscool@tuxfamily.org> <xmqq60raewod.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2ZAdUjQnO-4qnum2_AK84SfBN2_yO=py+Jj+pkV8pk-w@mail.gmail.com> <xmqqlh045y0l.fsf@gitster.mtv.corp.google.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Thu, 11 Aug 2016 21:08:50 +0200
Message-ID: <CAP8UFD3-0=O7uLXG=KL8OVueFPCpN5y-JmtcncVyrd8GoRh--g@mail.gmail.com>
Subject: Re: [PATCH v10 33/40] environment: add set_index_file()
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> Isn't the mention on NO_THE_INDEX_COMPATIBILITY_MACROS in the added
>>> comments (there are two) pure red-herring?
>>
>> Yeah, true.
>>
>> So do you want me to refactor the code to use
>> hold_lock_file_for_update() instead of hold_locked_index() and to
>> avoid the set_index_file() hack?
>
> I somehow thought that we already agreed to accept the technical
> debt, taking your "it is too much work" assessment at the face
> value.  If you now think it is feasible within the scope of the
> series, of course we'd prefer it done "right" ;-)

Yeah, it is feasible and perhaps even simpler using
hold_lock_file_for_update() than with set_index_file(), so I dropped
the set_index_file() patch and added a new one that uses
hold_lock_file_for_update().
Sorry to have understood only recently what you said in some previous
emails and thanks for the explanations.

> Is the problematic hold_locked_index() something you do yourself, or
> buried deep inside the callchain of a helper function you use?

It is something done by the apply code, so we can easily modify that.

>  I am
> sensing that it is the latter (otherwise you wouldn't be doing the
> hack or at least will trivially fixing it up in a later "now we did
> a faithful conversion from the previous code using GIT_INDEX_FILE
> enviornment variable in an earlier step. Let's clean it up by being
> in full control of what file we read from and write to" step in the
> series).

It was more a misunderstanding of how the index related functions are working.

> Do you also have an issue on the reading side (i.e. you write it out
> to temporary file and then later re-read the in-core cache from that
> temporary file, for example)?  Or is a single "write to a temporary
> index" the only thing you need to work around?

It looks like it is the latter.

Thanks,
Christian.
