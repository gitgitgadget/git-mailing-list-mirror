Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE0C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99467611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhETMbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhETMam (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:30:42 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FFC0C73B8
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:29:42 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id x15so16037612oic.13
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rD3psgJ/tu+doaldnfh8Ul3kOIdBberetv6FCUtPUiY=;
        b=uR6BS4Sn0dhml2QXYrPZSBwbw7b6FOYov4iHoAPaE/UFiZS2LDFKE5bEIEqORYjJ3c
         I4B+Aw3WuK7FkE2nkwJBeWV/A2SjkaIN0atFBArJoXf3lqWXcTRW0nD7oI1UkTQESJor
         pvf/8/JLBkJ382MzRw2T7zcli0ZLAnZVXYUNciEBgO4NHhveVyYtN5p77DLHTCLWr7Bv
         c5dnx9QpJOLaMRhc1gtkO1aE5GS1STqLTQSmsabDgfmGey5PChRLfJ01Z9NkHNoVeAu4
         2WfN7VCaKEL6+OVziboui6YV2kjsue+qYbtIvJ8Wh1LSA45I4LGAc0MrC98SnVJiiaqf
         KmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rD3psgJ/tu+doaldnfh8Ul3kOIdBberetv6FCUtPUiY=;
        b=LCkAbRaoi2b6iIpAV1jtsHB8NfvJIgbg9t/hke+8I4PM+O/keee7aumud3xo+Keeq9
         UWOcByxGIF0OXuzRU4PFVoKmFy4kBJ1uCupxZpgdi6sfoYJGeCCWPva4PJVpjbxJhFPn
         kWK6hJ+0iPK+n5Kic8Rjz30ww09Gd5SRf/qOPsuFxBVc75con9JgQN8cEZiCAIt5t83q
         V1SXxw2IydqfQwIHWZNhQTiAnlwGo3YoKJXOsigASMwlefEgGf98zX+SY049+NHfXD0Y
         PCqddMgC2xOp0l+fWEtXq/iwGUprryRcI7yVxDji64SntPGZzLbiCe5/i9a+w3EE70+1
         Y6ig==
X-Gm-Message-State: AOAM5331HDwrKzJL1A1cgmOGtiE6hhCnz4d7dJF/USpU07MV3O5aubzh
        yAmaaUFf0AXCuCUmzAk5DYp0Q2dGmGZNyN532G8q72tFEqOe9g==
X-Google-Smtp-Source: ABdhPJxXRJJ86zOmqX5liUywqAQuM7VEDLwaO59nDPtozfmSC/v/mfcFmOoa9XBsCQC/RUFmY+n4HPR9GBLHDllh9B0=
X-Received: by 2002:a05:6808:cf:: with SMTP id t15mr1004853oic.132.1621510181892;
 Thu, 20 May 2021 04:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
In-Reply-To: <pull.958.git.1621500593126.gitgitgadget@gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Thu, 20 May 2021 16:59:30 +0530
Message-ID: <CA+CkUQ8kiCk7X2kFMqPDK2VMbhgRh-HaHynV2GjE7k=LAJhiUA@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add contents:raw atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi ZheNing,

On Thu, May 20, 2021 at 2:19 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> diff --git a/ref-filter.c b/ref-filter.c
> index e2eac50d9508..fc384a194c0c 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -133,7 +133,7 @@ static struct used_atom {
>                         unsigned int nobracket : 1, push : 1, push_remote : 1;
>                 } remote_ref;
>                 struct {
> -                       enum { C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,
> +                       enum { C_RAW, C_BARE, C_BODY, C_BODY_DEP, C_LENGTH, C_LINES,

Maybe it's better if you can preserve the alphabetical order?

Thanks.
