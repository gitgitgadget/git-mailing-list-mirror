Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4AE8201A7
	for <e@80x24.org>; Sat, 20 May 2017 23:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755126AbdETXua (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 19:50:30 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34510 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbdETXu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 19:50:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so13338860pfk.1
        for <git@vger.kernel.org>; Sat, 20 May 2017 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=cKXm0Cue55sCEObMgSVNGrS8VukoK1sO7STy3dzlkBg=;
        b=r3Fpu+dYF8k86F/7ddpXPPsiWbNjPYjNsr3P/mDteAmQ6iBjD8oXHhi9u6YjFrJTmf
         mJ/jWdybzuOI8rDc27sLmF6gp7Y9moVJ3U95FcWpLHhD0vCmIHUUV507dZTZDENmYsfh
         PdvIx6zPzVDeBpcM226OuCSpohP2psSC0TUOOoWdYfkOaLBqvk0gCqVRylTTGMT72eLG
         BRzKraqWWufOoF1ULBT7od/OejxPUa7rcynvvGTfeAx+n2m+cnUZR5J0hE0LJO22K71y
         uc2pUD5Uysw1lhz27gTOtBXjfKWxRh579XGPaA+O/j+QUo5afGEGPgtB+HKE/96C7WoJ
         TBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=cKXm0Cue55sCEObMgSVNGrS8VukoK1sO7STy3dzlkBg=;
        b=H2WzIt2kNjqmD9J4xBagc7pjarOH3giZdvH/pFUmA+Dp7fkXZA3V8p0Gu/WKmX6YPj
         ik80fa5UlG1pxrtQ3wYMzKaQwruCPAyDFOaILNu2Pu3/a9DCFxJzk+XLsqT3/AwZ1F/s
         SW6AgZar4UZWPp0VeZ6THmnNiA71yRJicKrcmxqZES1i9pL48xGfqJbA+gUJTUyzXvvI
         fTgY5RdzQrMLFLKwS4+wK95nQ9ExiuTRyokM6AS8ayTJ0H5QO3CA6MXf5HO2zB4s+2jw
         8hX9Ayky/86pfyjC1RyE1ZVvY5OdIOTC4lSZXVcPFzxxHcU8rZcWDjuj+XsjI5wWvtkY
         2zNQ==
X-Gm-Message-State: AODbwcAiuVGQCz/KjwyRFeRtgm7guJNDpXq7GL3djFZq6Mlt3zQWfubi
        8uzKpJ4tGpw+hw==
X-Received: by 10.84.194.165 with SMTP id h34mr19513686pld.65.1495324229272;
        Sat, 20 May 2017 16:50:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a59e:fcd8:9df2:4b0f])
        by smtp.gmail.com with ESMTPSA id t3sm22769056pfl.60.2017.05.20.16.50.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 20 May 2017 16:50:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v3 00/30] Easy to review grep & pre-PCRE changes
References: <20170520214233.7183-1-avarab@gmail.com>
Date:   Sun, 21 May 2017 08:50:27 +0900
Message-ID: <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Easy to review? 29 (I mean 30) patches? Are you kidding me?!
>
> As noted in v1 (<20170511091829.5634-1-avarab@gmail.com>;
> https://public-inbox.org/git/20170511091829.5634-1-avarab@gmail.com/)
> these are all doc, test, refactoring etc. changes needed by the
> subsequent "PCRE v2, PCRE v1 JIT, log -P & fixes" series.
>
> Since Junio hasn't been picking it I'm no longer sending updates to
> that patch series & waiting for this one to cook first.

I actually do not mind a reroll that goes together with this.  The
only reason why I skipped the earlier one was because I looked at
the original one, and the discussion on the reroll of this 'easy to
review' part indicated that it will be rerolled, before I got to
look at these upper layer patches.

Overall nicely done.  I only had just a few observations.

Thanks.
