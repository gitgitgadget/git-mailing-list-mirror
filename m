Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6ABC04A6A
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjHJVvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjHJVvF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:51:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1FF2D71
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:51:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-589ac93bc6eso14425867b3.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704262; x=1692309062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hPSzIttiLsUaEB9F2CoRQf5AyswLcztnu9uQ1DmzFGo=;
        b=1LgvXf2Z5aTvAO75Ym/JJ3QznhRLUEpX80f6x7YYdULhYMeIVvYlp44N/4bCx8V5ab
         CFARaF2+gPTXTgxGtnu4WztyGcJ1mfTa+xa+O7poBbzbJYEo10FyR/meqAnEcmnjPQ5G
         e8/D4kSGDtY8qdjz7SO12MmXCTK94iVdIW1X+W8myQUDQv+8ZkvLrPBtHAVH8gthjvP9
         UXIISQXLM6XmuN21LgyzKrSso+8FwoQGfVQnt59m3e5q17RNj+4WX5Fl/F/HDs23KNTe
         RtCrCgw0G6lTEzoFyQ0krE6ZzyNtt54w1lD2aWbRpTWAH9SzFC3i6N2Zuut3Pat1IjI/
         53AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704262; x=1692309062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPSzIttiLsUaEB9F2CoRQf5AyswLcztnu9uQ1DmzFGo=;
        b=YShYgYitVP/dG/r6t5VYjmrPK5WcxCf09G/LCmV4mZ/qOeb1c7tyDA230HWwfAunW4
         6s2C35sXVShvhGaey9FOL4qM2F01ZiUmTueeFN2Z9AWxV10/wvK0fNM162YakHRW9ZAD
         C4DugBZV0FIibn8TfSU0kTy2hgqxVwlyDGFCefcrKcSlriE+Wa1oDBDLeIavTqERKymg
         ff3zJhIhPCmPwvwZkevqjztzn0lTpoQTNUQ2TZscNzdG1REzPMXfJ4ykKySc6yBGwenn
         mk7ef6dxbHYFseNOesHO7mJoQnrZKETQAYaFZzyJp30AbDV3ZHXB30qopgYmzsVnf813
         DjcQ==
X-Gm-Message-State: AOJu0Yy2HKA8Q3kkXmuD6i+R3zuqlsjfxzgKxrBAnqJUmEuz1caoPtLt
        7wJYtMSeD74Wl3vHQPj80utgimedI0A=
X-Google-Smtp-Source: AGHT+IH9v4w4R1syDyPW9suaRFR4B8laF3km3HNI578cFY2maVpUDksDYCGSt3DIieCzNQtrLvAWECKk30U=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:ae0e:0:b0:573:8316:8d04 with SMTP id
 m14-20020a81ae0e000000b0057383168d04mr2760ywh.4.1691704262150; Thu, 10 Aug
 2023 14:51:02 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:50:59 -0700
In-Reply-To: <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
Mime-Version: 1.0
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de> <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
Message-ID: <owly8raih8ho.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
From:   Linus Arver <linusa@google.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> while thinking about what to write, i came up with an idea for another
> improvement: with (implicit) --edit, the template message would end up
> being:
>
>  This reverts commit <sha1>,
>  because <PUT REASON HERE>.

This sounds great to me.

Nit: the "doc: revert: add discussion" subject line should probably be more
like "revert doc: suggest adding the 'why' behind reverts".

> ---
>  Documentation/git-revert.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> index d2e10d3dce..2b52dc89a8 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -142,6 +142,16 @@ EXAMPLES
>  	changes. The revert only modifies the working tree and the
>  	index.
>
> +DISCUSSION
> +----------
> +
> +While git creates a basic commit message automatically, you really
> +should not leave it at that. In particular, it is _strongly_
> +recommended to explain why the original commit is being reverted.
> +Repeatedly reverting reversions yields increasingly unwieldy
> +commit subjects; latest when you arrive at 'Reapply "Reapply
> +"<original subject>""' you should get creative.

The word "latest" here sounds odd. Ditto for "get creative". How about
the following rewording?

    While git creates a basic commit message automatically, it is
    _strongly_ recommended to explain why the original commit is being
    reverted. In addition, repeatedly reverting the same commit will
    result in increasingly unwieldy subject lines, for example 'Reapply
    "Reapply "<original subject>""'. Please consider rewording such
    subject lines to reflect the reason why the original commit is being
    reapplied again.
