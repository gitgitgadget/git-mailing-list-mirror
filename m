Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2AB1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 15:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbeFTPNP (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 11:13:15 -0400
Received: from mail-ot0-f170.google.com ([74.125.82.170]:39700 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbeFTPNO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 11:13:14 -0400
Received: by mail-ot0-f170.google.com with SMTP id l15-v6so4088643oth.6
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 08:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCZ/KluhYaosqZ2aZvUDG2c0y0QLaYu0NVy5vRhkcS4=;
        b=NH9n9uQXH3pVwmicA8Vu6f83oyikMq1iXN/qJieex2OYPavV+71qvuJiJGdxDRfKG8
         QwjzzVgEwErjXoImHcDth/0b9lpcIVT67SLv5LayRMzylKZCTUdelXh4JdtQzMSXpusH
         TwFvzYUUsuvKb//EhXPUgsRnVvknI1dyJ+s8CR+X4d2/NuCdafv9BNCZjDM8db49yN/U
         NdpOOMg8pxcSTfnelFGf1LxKdP+CSR/XxFhpLgvkTMqSIavuxOWfpREFNb/W2WySq1vo
         qWQzJ7b/DSy/2SYVqNydqcYLYzMzKA7yfVMwB8+Qsdn2UfrF/KdLtuNMl6tQ03OLs5jX
         HsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCZ/KluhYaosqZ2aZvUDG2c0y0QLaYu0NVy5vRhkcS4=;
        b=Njg1PXfjxLC9EryT2Fkvyb+YYM7FjMasFhg/poWIpkH6wKa6GRO4vArZAu0GIQT/FQ
         zjTWNtV6vdgud7+qKGc1QvpNRnP15OtcnOPuHlj5kV/sI+OXV52Blx1vpJJCMW8d1lpF
         pGJ+tbsCjmstHege2olENxvsufA6+oT4XUs132H/02wo6U5mX463d/+GCFbwZj2z4gam
         5i3FZ7NOFitezFpy5J4H/Lg0TqTq3JTVkOwqJD71vjfqtNuNek3Yr/Yo6JE3Yj4Tr1IU
         kAYVR6bKF9k1LgbBlgvQimJutxu/sS2qe3+8F5NRqHZoaPsY+RucSP0KAjqs4GJ1YJHH
         C4tQ==
X-Gm-Message-State: APt69E1WMtsGLf9jxX38S7Z6LvQG5XyEyn72BWl0Cp8rw07YyGn/nYtt
        XBq/DywKk3KoCkofooerCqJsLjjDJYDkpJCD7yQ=
X-Google-Smtp-Source: ADUXVKL7QaIY3OCBDCwwxSlBaloi5RzM1BNPwEQwg939kLbnb4xCOAoNCtVHpMLm8uqxXPuQa0luWVSLiziACePBN/I=
X-Received: by 2002:a9d:2f91:: with SMTP id r17-v6mr14211173otb.356.1529507594153;
 Wed, 20 Jun 2018 08:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZtEZA1rvgfSCS+m4dsrB86Cf-XiePWQmeU-kCNxP_NLQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Jun 2018 17:12:47 +0200
Message-ID: <CACsJy8AOBuLkY3fFN4QkoCHvTPzcJhT9q96KvJve2-u+2Ci7oQ@mail.gmail.com>
Subject: Re: The state of the object store series
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 12:09 AM Stefan Beller <sbeller@google.com> wrote:
> "xx/convert-revision-walking"
>   This series aims to convert get_merge_bases(), in_merge_bases() and all its
>   revision walking code to take a repository argument.

We'll see who gets there first [1] ;-). It does not really matter (and
I suspect you may beat me to it) but I hope we all agree to pass
'struct repository *' in init_revisions(), or I should start reworking
that patch now.

[1] https://gitlab.com/pclouds/git/commit/a4a91e3815cf0e594d5c9999e0c862f5060e2c26
-- 
Duy
