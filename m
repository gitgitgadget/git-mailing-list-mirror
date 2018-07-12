Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 577251F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeGLRRj (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 13:17:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54325 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeGLRRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 13:17:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so6292383wmf.4
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o9/Omw1zRzcyfC0MpyFmVpVU24B5mxQqVyxm7PT7ezs=;
        b=NApvgR+NmdPaObxIMDm8GK9pEk1WV46dsLqWw1rluxRP1TADy9WHGpLm9tJqKO/iGT
         EW/6spG2E0gNK6RBl1yEQbuEqbLgJFIkb6O/ReIgAVblqToVDdnhSc3aActvKOyxB/lp
         tEM0Imu5Bo6+VPCIAmiupTJumhLrThXhEGIpEqMbS1MAmkbM1BwLMzj273qNDmuXFAk8
         W5VuCCISh2PhzgF7kk5B9Y/zzbe/J5k6kVMftS/4wY7+y8C9o+n7Fg7IJVP6wW9ToLte
         TopGvJCOFNAuP2Yx79+psmcqw9ihF2qQWftuZv4FK9zQSQILGNilkkqejtUyu3CSi+if
         vP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o9/Omw1zRzcyfC0MpyFmVpVU24B5mxQqVyxm7PT7ezs=;
        b=gRGxym34qsuXU6A878wbWjIFRj7NpKsE21LwyoYiHKmBioWd26H7E0ebT8ze8g+vOb
         Ou3vo5vS6oCjd7WYTEA+P/3Ypcb0Y2liWjKZxjcLvytk0qrmcwfsdemEluXwaeeecMaK
         42OEw1eWfkt9sjNWlZWLyTFQth6GkqnH+RNyal0apGAh+TJiw8domH1j/z+vzQ5LXm4+
         ZsYDoRv7Z3B0r1gXxYpSVhrQ6NgAxdPraJgy26z3CvlX+Iv0D3sqtsSDKI6IL4MgEakm
         pjyOVGr3rwFlZ6qeyCZUbyGHyKmzHvOq1BM7adatbqBq32gvn4E2El8Zf3E09kjiKJC+
         95PA==
X-Gm-Message-State: AOUpUlHpx3wH66703ZTwtIyLC564Shn28UQ4EVO/CxTXZQVgq8pERxyq
        MvOauG0+sxwOC964PIRfLIRSW/0WYaN9SRPTMHU=
X-Google-Smtp-Source: AAOMgpeDQTpSfT1E27FaB9tc6wxcBW3uT+et7Hbal1J1qZB3pLgTsP5dMbkqYxsCBRxhORvjcZLnvlnx/sMYsEhiuXc=
X-Received: by 2002:a1c:85cc:: with SMTP id h195-v6mr1772655wmd.110.1531415232989;
 Thu, 12 Jul 2018 10:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 10:07:12
 -0700 (PDT)
In-Reply-To: <bbd5f6f5-8587-606e-01be-4c5e37609037@ramsayjones.plus.com>
References: <bbd5f6f5-8587-606e-01be-4c5e37609037@ramsayjones.plus.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 12 Jul 2018 20:07:12 +0300
Message-ID: <CAL21Bm=eqEV8qXECvXBm5Nqx6Wgbsha7ya=pEvTuqw+F-FncDg@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: mark some file-local symbols as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-07-12 18:57 GMT+03:00 Ramsay Jones <ramsay@ramsayjones.plus.com>:
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Olga,
>
> If you need to re-roll your 'ot/ref-filter-object-info' branch,
> could you please squash this into the relevant patch (commit c5d9a471d6,
> "ref-filter: use oid_object_info() to get object", 2018-07-09).
>
> [Both sparse and my static-check.pl script are complaining about
> the 'oi' and 'oi_deref' symbols.]

You are right. Thanks a lot!

>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  ref-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 9aedf29e0..70fb15619 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -63,7 +63,7 @@ struct refname_atom {
>         int lstrip, rstrip;
>  };
>
> -struct expand_data {
> +static struct expand_data {
>         struct object_id oid;
>         enum object_type type;
>         unsigned long size;
> --
> 2.18.0
