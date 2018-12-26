Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_24_48,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E031F804
	for <e@80x24.org>; Fri, 28 Dec 2018 20:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbeL1UM7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:12:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37730 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbeL1UM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 15:12:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so21807816wrt.4
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 12:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=ALZ7HMXEd9o8rcnXxWhTk6CXre7t1GFa33LW9ute6Z0=;
        b=f1S5RbVrMtMMzECglatV8H3h3duCNZrBR3ySxQSf+yWYkXB4JP+mJy90l5FI0NEc77
         aVmNOMa9HYA7zE20n7SWfAVgzvvRnO927RR/Qz8rSE10a7J4frNok0O3KGy1ObtRTvkp
         RaCxAoR08kPiCcE5z4ssFO5ftsrpL/FTntworWfswGeGGJRuqmzaxKfKikJqH3juzCbS
         XcPQU0fFRQl2AWCxYpCluRLWT+561PGuD/evhSwh11dorXnOMWp1R1FMF0tpULb89iEM
         lGfM3hU6rVcVZrcAQ2zI/niUeE4yJNAG+Iuk3cw/fQMQ4MY6rkbqoBPYA89+tJegxAX0
         alIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=ALZ7HMXEd9o8rcnXxWhTk6CXre7t1GFa33LW9ute6Z0=;
        b=m0TBswCHzeQTVCzAhp6i/uOfrVqtTSBb4EsQznY/ScdXQ5CxdNVWmdY/zR+uDh48d/
         bTud7bxjqC6TVYa1iTEm4exZIowzOTJjOdprTNvxfjD9Fn3GYhgkSApH3Y9xoWrk9YUm
         wmELaOWZbSDmoJWTmbYoZ7exGPj7/iKrpR4Iqjue8lHffK/jiACk6qgFQoCR88YmQQdV
         eoeIKTTlGniVaI0PxeqEaxUvrx6K/7+QtkH+pP40BLdNtG9+DSXaRckpiz2jdFvre7Fd
         dracbOckECsfTrvPBz055Ky3mT7DvY6Naa3QP5r02639FAO6UF8NtZL2z7wUOfTwLw4L
         dgIw==
X-Gm-Message-State: AJcUukdNYig0Sucy0WItamLcB4Dqt2O0PYJUK70BzUBXDasQrOiVlFRB
        VRH/Po2U9o2Mw2TKkb0vq0KQdU2x
X-Google-Smtp-Source: ALg8bN6gg1V4U5ekxwL4KAujzP0n8AI9ZgeCxefFp8AXzYn7OixqRqxkvkShRr0ewiLmgKQL6BuZ9g==
X-Received: by 2002:adf:f052:: with SMTP id t18mr27810530wro.112.1546027977386;
        Fri, 28 Dec 2018 12:12:57 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d2sm25593408wrs.97.2018.12.28.12.12.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 12:12:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ref-filter: add objectsize:disk option
Date:   Wed, 26 Dec 2018 12:44:07 -0800
References: <CAL21BmnmfxpMgbW_Yz9D=FVZk_AzWF0uyrNZeSGPCs63PH1oag@mail.gmail.com>
        <01020167e063687c-37a43a09-0a5f-4335-8c21-ec15a0a67882-000000@eu-west-1.amazonses.com>
Message-ID: <xmqqwontmmuv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

> @@ -880,7 +886,10 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
>  			name++;
>  		if (!strcmp(name, "objecttype"))
>  			v->s = xstrdup(type_name(oi->type));
> -		else if (!strcmp(name, "objectsize")) {
> +		else if (!strcmp(name, "objectsize:disk")) {
> +			v->value = oi->disk_size;
> +			v->s = xstrfmt("%"PRIuMAX, (intmax_t)oi->disk_size);

Shouldn't this cast the field to (uintmax_t) type, as we'd format
with %PRIuMAX and we know the size on-disk is not negative?

Other than that, looks good.

Let me rewind the tip of 'next' and replace the previous round with
this iteration.

Thanks.

> +		} else if (!strcmp(name, "objectsize")) {
>  			v->value = oi->size;
>  			v->s = xstrfmt("%"PRIuMAX , (uintmax_t)oi->size);
>  		}
>
> --
> https://github.com/git/git/pull/552
