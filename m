Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F9E81F403
	for <e@80x24.org>; Sat,  9 Jun 2018 18:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeFISBz (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 14:01:55 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37821 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbeFISBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 14:01:54 -0400
Received: by mail-oi0-f44.google.com with SMTP id l22-v6so14592050oib.4
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8cKfTujdm6jdVPLSVqIPwiWfonxrLlIe8DgN/o7f2H8=;
        b=tfunOIUHdE1lMe/KP4MvyPG9mAieucDWHG0cXdXPTSu+E81UlQz1MK1h/g2xWMjJc3
         LwLm+jMxiA/709T/qEoPpxfrrXsq2IaUWv/7wbo6hJ9QAC/zEc1+G29Pkq82X/nY5ql9
         hXKichWoEXfZxhrFlj6yNvgYko4mEpP9Q7p2ehPUaaCR1IIzgEePaNAV3prtfnOtC1yd
         +rPyN8TGWK9L5pbf5A+Pr04p/r3NAbiDWnc1sM2DNog+LZwqArGRZ05wD/nEMQwsvd0N
         deN8m9Qjc4etdwzrO0lDLfdZf52bXiw6zPSAu4d1pDdLgpEhjRf7KXUy90IQey0Ld9PK
         wphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8cKfTujdm6jdVPLSVqIPwiWfonxrLlIe8DgN/o7f2H8=;
        b=OPVxpDo7tsAhTdoDlbLD4nrgIAeyKzEy/t9wvgJ7q8qvPXiyxdtNwVFcl6P0ywvzIg
         H/WYnXv2dDZNDV+jC+wnBLUOpylMxnRNhC4i7No90vv8FoDqbo207YeJo/Yb3b6YLAh/
         bplWJS0+q+fI7WoQmYLZy7sYGbILITD144nYOwtOJpyUgsn10nYKg1CRXv8mCG+izhXl
         d2AQ65MjK+s6dGsRtXt2fT90UQRmb/+wn0SnwFON+3oYenydh2lvYYr5knDRdce/dXtx
         CU/MAaowJTlaO4NAtH6JjXb73w8bCUeeJPkP/F40tG39wPSnMIjo39NdkRVS+fvy/H/9
         HI/Q==
X-Gm-Message-State: APt69E0/dxcW+Klw8hO8qcLpqPWHezrQCGmD4tyRAN9XHVAs3Es7RaWJ
        zSZAejgS0gs+jbxH4CxbglPk3xsqV2vC4m5OOfQ=
X-Google-Smtp-Source: ADUXVKLGd6FCXBKD5MboeJSAEEf98JFiwLioHhTFwNeiy+AjMC3kXBytyzzV8pw6HRRPkFbOBAM/uRucrPMbR2h5SZk=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr5509665oie.30.1528567314025;
 Sat, 09 Jun 2018 11:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180607140338.32440-1-dstolee@microsoft.com> <20180607140338.32440-19-dstolee@microsoft.com>
In-Reply-To: <20180607140338.32440-19-dstolee@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 9 Jun 2018 20:01:28 +0200
Message-ID: <CACsJy8BQ5xxhQ8L9K84KO2EkYELsKKKkdJ0mvc8p427sA8bapQ@mail.gmail.com>
Subject: Re: [PATCH 18/23] midx: use midx in abbreviation calculations
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 4:06 PM Derrick Stolee <stolee@gmail.com> wrote:
> @@ -565,8 +632,11 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>
>  static void find_abbrev_len_packed(struct min_abbrev_data *mad)
>  {
> +       struct midxed_git *m;
>         struct packed_git *p;
>
> +       for (m = get_midxed_git(the_repository); m; m = m->next)
> +               find_abbrev_len_for_midx(m, mad);

If all the packs are in midx, we don't need to run the second loop
below, do we? Otherwise I don't see why we waste cycles on finding
abbrev length on midx at all.

>         for (p = get_packed_git(the_repository); p; p = p->next)
>                 find_abbrev_len_for_pack(p, mad);
>  }
-- 
Duy
