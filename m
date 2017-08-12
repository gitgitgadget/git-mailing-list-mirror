Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335AC208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 13:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbdHLN1X (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 09:27:23 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34766 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdHLN1W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 09:27:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id t86so5843062pfe.1
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Npa8c7pU1LVJkZbdQ18BRZDh8T3n+HoHf+NdMIGhJM=;
        b=ocxuCy7ytB/sImEa/MejuNvitknUIDDTmdfKRAbvHvILxXhds8jAX4wLwURLN74EpJ
         MlUmVtTgcFJ2M/xgfTFO2BhXi3Q/8/7a2gNUiaJq6368NqaTK7fw/mPtU/Z758P7ZtlW
         rr16Zs2T54KOaxXeCQPzXRohPXf/uo3xQT+L+yahqlexF5HOV3BQ/GUWzOy5hUTco1Gc
         JFeBvk/MW84Rg1d9V9ygRads+a4dsURPgPRYji/UhaMndHv5tq6NjNHgmUldhmgzaw1u
         hu4KrzXIJ5nYzjn+C32E3StQVucXqS/oNJuc9Jx6Hr2+tZA1jR/dLw83/ATrT3ODS8Tx
         YmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Npa8c7pU1LVJkZbdQ18BRZDh8T3n+HoHf+NdMIGhJM=;
        b=i820zh0SaM8+6WsZeLmdha6NERCZ2hAGWVDCwtUc1Uc8M86ZruacmzIKoST5Bxlmhe
         NrCNLvNZYQNXNPJxLyLIn6Ry+lluLqm4r0wMQg6kNHawwfy23zkuLACigYilWAp1IkHO
         djt7EMHuec69G3bpcD0GaoIevaFnRMnX+yHCpEX2vJr+l9U4LAS2qRxO3u5QbZ1Ey8cO
         kplymU6R6yPNh11llkFiEojPvAuiT+MGjH+VOojqRW4HCLwmD5Y6mAVCOhkg+9+S+DBi
         bpgpHeg692SPKhOgtVKAu+bg1yC3lqOvKleydgrbfODkWPFJkIH4iKDzyq/HjQnJdq0M
         rIPw==
X-Gm-Message-State: AHYfb5g9rYbKmZoQhSMRNypnFJWWVDS//fapNkXDKDDuGsLM94dk1Crm
        MimlmmQxkqyW8kvtN+lqxtQ1nj6HFw==
X-Received: by 10.98.220.134 with SMTP id c6mr19882454pfl.253.1502544442412;
 Sat, 12 Aug 2017 06:27:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Sat, 12 Aug 2017 06:27:21 -0700 (PDT)
In-Reply-To: <1502527643-21944-5-git-send-email-martin@mail.zuhause>
References: <1502527643-21944-1-git-send-email-martin@mail.zuhause> <1502527643-21944-5-git-send-email-martin@mail.zuhause>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 Aug 2017 15:27:21 +0200
Message-ID: <CAN0heSqu0evvo7dFPwWvgEthoafCVZmJKbRftBbHRhtN_du4HQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] Convert various things to size_t
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 August 2017 at 10:47, Martin Koegler <martin.koegler@chello.at> wrote:
> From: Martin Koegler <martin.koegler@chello.at>
>
> ---
>  bisect.c                | 2 +-
>  blame.c                 | 2 +-
>  builtin/fmt-merge-msg.c | 2 +-
>  builtin/mktag.c         | 2 +-
>  dir.c                   | 4 ++--
>  dir.h                   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 2549eaf..0580c82 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -131,7 +131,7 @@ static void show_list(const char *debug, int counted, int nr,
>                 struct commit *commit = p->item;
>                 unsigned flags = commit->object.flags;
>                 enum object_type type;
> -               unsigned long size;
> +               size_t size;
>                 char *buf = read_sha1_file(commit->object.sha1, &type, &size);
>                 const char *subject_start;
>                 int subject_len;

Would this need to be done in a patch where read_sha1_file is converted?
