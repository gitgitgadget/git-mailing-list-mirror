Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC682023D
	for <e@80x24.org>; Wed, 24 May 2017 06:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936483AbdEXGi1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 02:38:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32790 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932843AbdEXGiW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 02:38:22 -0400
Received: by mail-pf0-f194.google.com with SMTP id f27so31870279pfe.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fQpg542zoqrktWtmA6Va9ZlTwfx2w48kBwWDF6I5IZ4=;
        b=cL9+tRB9qIuHfSBVCpVwFdAzxby1HVRlljIBNwpaw1B4F9JV4KFtpLReZOKcAycvoU
         Vqxmc7ZfJaX11N0vUJ+gIm/Bghq7Gm2Ok8266WV27CFamLqeZSqai7JpxRtJKfNIS4cp
         BN7EQujMI7F3L7ijwyUGGTsnLPKTqxSux+2mNuJnp7+YTb/SAA+/OF2KfDuwJyKd0bdI
         9OzecrQ0RJ9hWArTb/mIK0AHS/3FGZCy5e7Q+se+F+jsDziwYWayrT6OYIa49cAwTrqu
         xIMfDKrJfNmdKaLVLt9jen1gvVEKtzKdx3rjWZAXub4D1RVjMjWFVrwLV3wBUOVobABC
         0bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fQpg542zoqrktWtmA6Va9ZlTwfx2w48kBwWDF6I5IZ4=;
        b=WBaubbqlJk7RTP6yUlzBwlitsklq1WPo+x+Rt7O+H0pOdPgwEDD2NLQgJTEFagjkup
         G6BKFaDaj8RYU3VA+/hiZEMWUhsfCVD1j5+e8rLRp2Nq1Q34ULqNLbRUAEgWVCi+D9nz
         fsh1oHyjMTtHxsKIioFtBO9ghSPWWfa0KPN+AO38mAUOAgGKkhDQHPwf0NyYSnBAbdGK
         ZXkjIsnn9SkLK9nayGQO6fdLRN5hdT8BQtmbCXkUgWutWaAeJRBIg63aXNhOlbNU9ReW
         hJCMkKvBQgjFzuRQLgDSo6YQjVpbcZeyqFwMCFjCVnWC8F6AHEQU2glXGu+4sQZmFtCK
         xO8Q==
X-Gm-Message-State: AODbwcDSJVFDdxJoXTmRRVm1d9ibWvKWcsrov/opM8UMRULEFVptwf1Z
        VgsQ7iUmjXtGSg==
X-Received: by 10.98.157.207 with SMTP id a76mr36771368pfk.17.1495607901525;
        Tue, 23 May 2017 23:38:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id q68sm4959749pga.57.2017.05.23.23.38.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 23:38:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 5/7] grep: un-break building with PCRE < 8.32
References: <20170523192453.14172-1-avarab@gmail.com>
        <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
        <20170523192453.14172-6-avarab@gmail.com>
        <xmqqh90ahjzy.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 May 2017 15:38:20 +0900
In-Reply-To: <xmqqh90ahjzy.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 24 May 2017 15:00:33 +0900")
Message-ID: <xmqq60gqhi8z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> So in that sense, I do not think keeping them separate in practice
> has the "makes it easier to revert this change" benefit.
>
> If I were doing these two patches, I'd squash them together into
> one, rename GIT_PCRE1_CAN_DO_MODERN_JIT to GIT_PCRE1_USE_JIT, and
> explain in the log message why we turn it off for versions older
> than 8.32 like you did in the log message for thsi patch.  
>
> The reason for the "rename" is because I might also be tempted to
> allow users of newer version to manually decline GIT_PCRE1_USE_JIT
> in Makefile/config.mak; i.e. we may decide not to USE something even
> if we CAN, and the #ifdef symbol you are using is about the decision
> to USE or not USE, not necessarily if the library CAN.

Need to say a few things that I forgot to mention.

I said that I do not see practical benefit for keeping the patches
separate.  But at the same time, I do not see it a huge problem that
such a "main one that is partly broken" followed by "fix for one
minority" followed by "fix for another minority" pattern causes to
bisection.  So I'd be OK either way.

Especially, I'd be more than OK if the "main one that is partly broken"
says "by the way, this is (deliberately) left broken for two cases,
and if you hit this during your bisection, do not answer good or bad
and instead reset to a few commits newer that has both fixes" in its
log message.  Then there is no downside in bisection.



