Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBD11F424
	for <e@80x24.org>; Sat,  7 Apr 2018 09:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeDGJvW (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 05:51:22 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:45829 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeDGJvV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 05:51:21 -0400
Received: by mail-oi0-f51.google.com with SMTP id 71-v6so3291518oie.12
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 02:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U1XV2H0PqINlHRviCtcSLSlj0A6cLeRWoj6M2IT/akY=;
        b=DMuy6HEUsodkOMC44TOppp1ru1fLwJOnuHaWHfu++eqwOmhTomIz+JMTvy/15qQpHn
         8I8UY7BP3iGFwcacJRIyaTjOMPFben93wxa+ptOpuhEGDO50O2eR2J1yK4Jz+6bKQsd/
         fIEz8JUpHlOguj0hY7PBuTHDLiVqBDlkGW7vUhABkOJzCA0L4uDYsQ1HyAdfWyoqawSO
         /PiazEVuE6RpWYlKWG/8ROJOx2Ev20ZYZsgk3xVPD4TCy1l3+FgPpN9BEQg2bLx7m9V+
         SHzRvncPs4/VARjuUczrjWod4qaJWy3k/1EO1wALajJIpg4P6eOi18mwJKkZurDRo+0y
         76Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U1XV2H0PqINlHRviCtcSLSlj0A6cLeRWoj6M2IT/akY=;
        b=Ua1CWCal1lGpQlM8l2Vf8VOVphcA7ImvCz94HFt7RFaEPocg1o4LUEfPtfSy+Dpgz5
         KUaCQFCaMx+zWTpriQbfWtTv2LjFCpaR9prLXO7z05t4k5DdGVmuey3xTeTXC63bIgoa
         h9XClnFkL0wK/f2oWQ+6L/FCgIW0je3tvwx8nzokZ+c36qW8gbTHKvuf79uiJooa1WqC
         KBGD9HCS1yAAfydihENRFs4AgAtDRIlcMqAaZ1nti62YzpRDWkKpyWuLuG2hKWeNfyPm
         YBUE/n73uijXGjLe+9kUhSPgHxvl87xmrMJ24aXYWSVfcpwc8Q4XRzRDChiRDgEQ7Tph
         oDYg==
X-Gm-Message-State: ALQs6tACD8kMPWRUpl+kJFYmUFQUoLJwrQ4jo7fRpHcbAmAdkjZ92O7D
        wu4t8DdYNr25jNKLPrRUUDu0B8hPJI8qdujU1jI=
X-Google-Smtp-Source: AIpwx489OENEOYJ45xe9jjMmLqCCp2mU/5DdX3jrn/yXGFgO7Ks1BjZ7DLJV7L14rEqFmn5qdtLU/w/o4S2A4yTRWJU=
X-Received: by 2002:aca:f141:: with SMTP id p62-v6mr18112582oih.56.1523094681464;
 Sat, 07 Apr 2018 02:51:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 7 Apr 2018 02:50:50 -0700 (PDT)
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 7 Apr 2018 11:50:50 +0200
Message-ID: <CACsJy8BKKgfxUGm+SgOAENNsSaMGehU5NVbn6YuebCgUL4S0jQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/19] object-store refactoring 3 (replace objects,
 main ref store)
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 7, 2018 at 1:21 AM, Stefan Beller <sbeller@google.com> wrote:     *
> diff --git a/repository.h b/repository.h
> index 09df94a472..2922d3a28b 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -26,6 +26,11 @@ struct repository {
>          */
>         struct raw_object_store *objects;
>
> +       /*
> +        * The store in which the refs are hold.
> +        */
> +       struct ref_store *main_ref_store;
> +

We probably should drop the main_ prefix here because this could also
be a submodule ref store (when the repository is about a submodule).
worktree ref store is a different story and I don't know how to best
present it here yet (I'm still thinking a separate struct repository).
But we can worry about that when struct repository supports multiple
worktree.
-- 
Duy
