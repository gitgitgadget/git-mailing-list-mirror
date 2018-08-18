Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD72F1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeHRTRz (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:17:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33618 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbeHRTRz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:17:55 -0400
Received: by mail-it0-f66.google.com with SMTP id d16-v6so4211793itj.0
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BV6QiLEsHzizM768Fm3Bs5ComeU27ml2AKGi0pDvzv8=;
        b=dPPjqrpgNqLOyNFkEzKeNsYMucbdm3SwcIYSXEQ73NHxy5Cr+IGXvJICyxFKTpTvGL
         JR4Ml78tDYtgwRUQ1oNyw4qlqi+sg63NGHFS3SqiwGivAkhDOfhcnDmUC1VNe29tDVUX
         LdnH5ddJn4O8G0TEdeD8uVCinVHIfpFCc9m3HYglRfu5hSWvivLE4PTftNzzWzZYN2ri
         XbfFkrz9GvZzZBNNHkDG+9B5CIy43Y8qdXN47j8fVlUpUKtPeX72PI5UGLTJnx9/wlhD
         6DLgr39UNu51hCnrmCd1ih6Sjy1W0vSiTHhkFHe2Z5tEfN54LtwKiC4OmWfq9hnNMhun
         abqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BV6QiLEsHzizM768Fm3Bs5ComeU27ml2AKGi0pDvzv8=;
        b=U87Aise/zrWkK8bND3L6+iW6bFD//QwKUJXJf8ROoVEOt1+GslKcWyqksPgGka6aca
         jgK5hrzwnpUHPt2268FXWMypJc9CBgXtUMxxlLb+IgodZW4bJ0BF9dRNHUxJ/kf5psEK
         BRA6t41/EuEOHlQQEyuU58fnVobb7/e5YvOaM5RYLjTXZcK6r3+yxR6ZWOfwYNf3dlPO
         StNpNo4LUjfJ+vR2o8hUWXrka6fFzUu3ptTvwjsfoCMQijGUm+vtD4wiG6BkX7hUCBCD
         i3T+ErGmUk9IovKZ0rExhhD8bxYnFX6pNrB/nuuBwQefjQ7Nu0A5/p+xwSyZ98bjsdqj
         eNMA==
X-Gm-Message-State: AOUpUlHbrNTHODOMIQNYycNaLfqQ0ECvA+eFOTMWonCq/4vKRJ/RrTE+
        zM3IEOEjgW0hmEK6KNybXARc46/+YxwhEOOG+HQ=
X-Google-Smtp-Source: AA+uWPxF5HohZIXQymojzUhFAfsa8wVIsTTLwEtDIWMZ4asTSswIGWbDSrxIwaC28DJDgqBScOokyMlL5/Ii7PO1PL4=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr8001590ita.5.1534608582287;
 Sat, 18 Aug 2018 09:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com> <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
In-Reply-To: <7ba9a8515d445d10af36a8a79071af51b90f5aef.1533753605.git.ungureanupaulsebastian@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Aug 2018 18:09:15 +0200
Message-ID: <CACsJy8BSpVxXMKVTVOv0CMzi+zXLDNLxJ11HFL-cxTTX6Loz=w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v7 05/26] stash: convert apply to builtin
To:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 8, 2018 at 9:00 PM Paul-Sebastian Ungureanu
<ungureanupaulsebastian@gmail.com> wrote:
> +       strbuf_init(&info->revision, 0);
> +       if (!commit) {
> +               if (!ref_exists(ref_stash)) {
> +                       free_stash_info(info);
> +                       fprintf_ln(stderr, "No stash entries found.");

Maybe _() ?
-- 
Duy
