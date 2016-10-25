Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4D32022A
	for <e@80x24.org>; Tue, 25 Oct 2016 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbcJYKBS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 06:01:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34043 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751044AbcJYKBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 06:01:16 -0400
Received: by mail-oi0-f66.google.com with SMTP id p136so6153089oic.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f6sY9c9LrYZrK27Ofg9gS+L8MlcvbP4U9aV4Ql2Onm8=;
        b=hzPAV5/8J19EwtMPvXDOwcIT7t5uuoRmizofJYmdQEqtd0b0BhMN3XOZg9AtJ8e0iY
         sBgvsMy9VbY71w2iUf2oXgzVDcMa1AsdLlqnT2feNHEtLFuVPNprKpbzCSPS9puqICjd
         YqoMcAPCoOSFU3SEtiXcNoRORRme6M8Xl7LxXlz1wDE5GAokwvlblt0n2MtuR703TuKZ
         SpyX+OeNPdoH4YYZw4MtZF6oH6wLmWUxt3laUhMct2hRxugKlCfTK4+405Tm+aKlRmGQ
         036pjsdyvGGYtjwCSD7twBnsFT/uAraZxiXl5m1cx3/OJjSCUoAgMSqzu7kMzk7iAm1c
         9QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f6sY9c9LrYZrK27Ofg9gS+L8MlcvbP4U9aV4Ql2Onm8=;
        b=FbAHZra7FHN37M8xOdicDRObGO/0tAKpCmhInzPxY4BK5E4XCUWFdBQN/q15n3Y/DP
         35DAaoShtaUF1VM5B76cxl5+rcH65cWbvyT1un+u1uyF68Bv40hItnkLLu+GXdmgxMTU
         rogU+Fu0eAycnfp3y5Bq0DqwT0cQTyfwXDW0KEtK/3aOOMNrRfvmGQzq7IYxoXYhDgRs
         vcLPU9Pf+mBERPl9/YfJFnEIGMJiKHftACVXCUu2iz7oreQrXzORB7C13XRCEhX0gpLA
         hpsrn8VzHHbL+9VJcv3tUftvmH2ddL8kHVJDmBL3YA9H6MXryVUsylV0IBf0gjf3dj+R
         88tQ==
X-Gm-Message-State: ABUngvcREZS6E7PJQCoVFh9xf3hSK/LkIulgQTazXElI2bmHdwt6DV8hhRmtjLDwZCnn8nucSb6h8I6X1VJ4EA==
X-Received: by 10.36.54.69 with SMTP id l66mr990370itl.3.1477389676053; Tue,
 25 Oct 2016 03:01:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 03:00:45 -0700 (PDT)
In-Reply-To: <20161023092648.12086-6-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org> <20161023092648.12086-6-chriscool@tuxfamily.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 17:00:45 +0700
Message-ID: <CACsJy8Br2q0aadTFjkNgb=oN8nSzbkWJEK7bCCgr7v-oOZtrSA@mail.gmail.com>
Subject: Re: [PATCH v1 05/19] update-index: warn in case of split-index incoherency
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 23, 2016 at 4:26 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> When users are using `git update-index --(no-)split-index`, they
> may expect the split-index feature to be used or not according to
> the option they just used, but this might not be the case if the
> new "core.splitIndex" config variable has been set. In this case
> let's warn about what will happen and why.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index b75ea03..a14dbf2 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1098,12 +1098,21 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>         }
>
>         if (split_index > 0) {
> +               if (git_config_get_split_index() == 0)
> +                       warning("core.splitIndex is set to false; "
> +                               "remove or change it, if you really want to "
> +                               "enable split index");

Wrap this string and the one below with _() so they can be translated.

>                 if (the_index.split_index)
>                         the_index.cache_changed |= SPLIT_INDEX_ORDERED;
>                 else
>                         add_split_index(&the_index);
> -       } else if (!split_index)
> +       } else if (!split_index) {
> +               if (git_config_get_split_index() == 1)
> +                       warning("core.splitIndex is set to true; "
> +                               "remove or change it, if you really want to "
> +                               "disable split index");
>                 remove_split_index(&the_index);
> +       }
>
>         switch (untracked_cache) {
>         case UC_UNSPECIFIED:
> --
> 2.10.1.462.g7e1e03a
-- 
Duy
