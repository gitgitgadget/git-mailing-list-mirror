Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 672761FF30
	for <e@80x24.org>; Tue, 22 Nov 2016 10:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbcKVKm1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 05:42:27 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36242 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755366AbcKVKmB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 05:42:01 -0500
Received: by mail-yw0-f182.google.com with SMTP id a10so10840933ywa.3
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 02:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O1SPMrIMemIlHeshDlnhrcAkdzArR0OP9CpWxTShpFQ=;
        b=yyasVXga3smIehS7sw0ZNQeeyOFk9N3CVxXdGgumLZgwvJWzQ1Qe4WzoNiirTAgaFg
         vqCkKGaI0UPybDEjbjF2YkF5Q+F/yHKFzYXZt2m/ukhfquyr2MtApEfq3t5dkDCk0lok
         pg6VcVczmmctA3H06rvsJ2tWTnpZGtgP/9/FJ9WTjYI3Ksui/BEthcg0ROraIpFwuxBe
         5FMGCRmgfxcsZVTyiqAwLBG8Fng0bvbHCkRFDygLGYxlU2+Dlb0o6wo/jkbgvqKaxI+O
         RuJE8fFMUVJ0XA9Bb6NK8wF+Qftt2XUpUqEVIqLAkODP3+3j6ZRynpC51TqEFlACC00g
         Cbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O1SPMrIMemIlHeshDlnhrcAkdzArR0OP9CpWxTShpFQ=;
        b=kTmKwHPfCazQcg23H9wx8ulrR4kvOgV+Pd+fGVmE5J8b3dyEFMMc6bqQJzNaOGA6/N
         n5V4WPNskJjqiOxINqiCbFZPewjHZ1EnFjasFPAzVx+KG/3zz7E5ZkUjgyjVhMNLikJZ
         Cflzsw+qbMe53Dq8/5gxpJRDTjO2kHfOcLhm3w26Za3qqZ4DVt3RrF3U89u/QM0VLHwB
         9D0efV537w8OIhF4RLI5A+vfuzpYuaNJqVNFYeDtMa2DhHOYu9dxiUwZT1LTJH1lz0Xa
         5EpJRrH1RRjCjFHKHzhiERm1hGGmHFfwKeP4WoOfEJW1RhkQXXF1uVtVazFX5P2fYM3A
         Kjxw==
X-Gm-Message-State: AKaTC01IzfLhRYGlZfBjoUoj3nLJiKKgba116ylQG1aVrvyyGqKDKpHhKk9BdYgxylo16hr8tAQHYnOlizL+/A==
X-Received: by 10.13.240.7 with SMTP id z7mr18825772ywe.37.1479811321023; Tue,
 22 Nov 2016 02:42:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Tue, 22 Nov 2016 02:41:30 -0800 (PST)
In-Reply-To: <20161110203428.30512-32-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com> <20161110203428.30512-32-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 22 Nov 2016 17:41:30 +0700
Message-ID: <CACsJy8BXjYOza_1mPCJJw+Mk1zksLLJMBNKvbAk8+1-bdAGJMw@mail.gmail.com>
Subject: Re: [PATCH 31/35] pathspec: allow querying for attributes
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 3:34 AM, Stefan Beller <sbeller@google.com> wrote:
> @@ -139,7 +140,8 @@ static size_t common_prefix_len(const struct pathspec *pathspec)
>                        PATHSPEC_LITERAL |
>                        PATHSPEC_GLOB |
>                        PATHSPEC_ICASE |
> -                      PATHSPEC_EXCLUDE);
> +                      PATHSPEC_EXCLUDE |
> +                      PATHSPEC_ATTR);

Hmm.. common_prefix_len() has always been a bit relaxing and can cover
more than needed. It's for early pruning. Exact pathspec matching
_will_ be done later anyway.

Is that obvious? I'm wondering if we need to add a line or two in the
big comment code before this statement. I'm thinking it is and we
probably don't need more comments...
-- 
Duy
