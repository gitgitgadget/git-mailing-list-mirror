Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4BD2211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 09:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfANJ7s (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 04:59:48 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36172 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfANJ7r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 04:59:47 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so11403518itj.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 01:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5YsQUH56DfdeyWIFWzkoWLR0dnnpqKzWBfBnuzl1MQ=;
        b=PYxYlCNhiKZrHY1CDqNtMpfFuLpWOnAxyOazc0zVyOfXqISgDZjhMXCOyEVEGhz1W4
         5+Oj0jHpwGbzoJF0zwxzbsDXcL0s8ktc29SwJb77WNdnFCGTujYsCEgCZVXeGpLu6pv4
         jC9aD0gdOv+ZAARN+FTyTvFc/gYkNinMlCBafgDRdUtECH6b/1dNn5PkWs73FTqxCPQK
         MmraCwnyACS+k/ISYcVCLMht0Dfkdz2qJMhN/ZCz5r0Pjwp3oDOte8zNdBrhJDpUN90X
         MSsgv9taxp9tkoavtnCh1D9aQVWTOzhoUWSWrGANHK6qaCTfGhDbdq+I5vcDl9fM/m/8
         qOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5YsQUH56DfdeyWIFWzkoWLR0dnnpqKzWBfBnuzl1MQ=;
        b=roZri5/tPNa9+qv7CJWQv9SwkDl6FxkaJZJ2N0wRIoptaGODZ/vCPPqmn6s+/Lmw5L
         EcnB62q632+G0qGJiCFblxgBLcgg4KC8Q+GDvWEWuHz0B1lZ2k7aWtaVsAeYbmZ13yYO
         rHi4b5yxe5Pj76xXUkk4AR3Gok867A2DbmqeNhBxXzU120DDC/tcifSD1GrJbKwxcj7Y
         1Ge3C78akIpfzCznELABH6SVpUK8+nekIUdTp/RwdT8ILGcPxo5Wlw/96rDy5Iam4Kzj
         IT/kktL8wB2Qnvli+xK0w+Q1jlD8FwkNTaCHreid5QE2LZP7W54+5TJE0VFuphWDc8GX
         w6rw==
X-Gm-Message-State: AJcUukfo4cpN1gp8IA6dpJ5R44JVUmvn7iqoBZhlAIerWEPd+1/pI+Fc
        dROu3JZIuRH+hzav5KtOlr4vevbLAf7mNmlrpmM=
X-Google-Smtp-Source: ALg8bN4EqWSd9ORXcNzwtNC8cpk+UixcSWrSuitGNTXUj00nOnJH88Ju1VOoNVhYkcQ9HJITCh+3SUWFu7wW2t713SI=
X-Received: by 2002:a02:183:: with SMTP id 3mr17211365jak.130.1547459986407;
 Mon, 14 Jan 2019 01:59:46 -0800 (PST)
MIME-Version: 1.0
References: <13179d3e-f1d5-55f7-3572-829b5ddc9827@ramsayjones.plus.com>
In-Reply-To: <13179d3e-f1d5-55f7-3572-829b5ddc9827@ramsayjones.plus.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 Jan 2019 16:59:20 +0700
Message-ID: <CACsJy8DceS3J_kmA9p66J1ecYTZ3=-ky5mT-NwMT7uKkVtUmdA@mail.gmail.com>
Subject: Re: [PATCH] config.h: fix hdr-check warnings
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 4:02 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> commit 8f7c7f5555 ("config.c: add repo_config_set_worktree_gently()",
> 2018-12-27) adds three function declarations that cause the hdr-check
> make target to complain. The hdr-check complaint is caused by placing
> the new declarations, which include 'struct repository *' parameters,
> before the declaration of 'struct repository'. Move the struct
> declaration to the top of the file.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Duy,
>
> If you need to re-roll your 'nd/config-move-to' branch, could you please
> squash this into the relevant patch (commit 8f7c7f5555).

Hi Junio, I notice you squashed in all changes of this series (I was
preparing to resend last weekend). Will you squash this in too? It's
of course ok if you don't, I'll resend.

> BTW, none of the three new functions are called outside of config.c on
> the 'pu' branch - I assume future patches will add some calls to these
> functions (yes?).

Yes. Once this part lands I'll submit the fun stuff.
-- 
Duy
