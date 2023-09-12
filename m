Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD4CA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 05:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjILFA7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 01:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjILFAq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 01:00:46 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE830C1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 21:57:12 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5704127d08cso5571039a12.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 21:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694494632; x=1695099432; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJWJJxbp5m4HLOfJfgy7hOEA9P2JtVrJQNJNYVvTKnE=;
        b=YHuls9gCQ/S3IsIVpB3JVBvdIzgYzeiCIQldcqVEKCCRUQ457gd0Cr0/OlpXlIvYqa
         jRrTrv04e7KWgw6o7rZ61d266NzWPXw6MyIlX5aY9FKwLtbhGaMDi5wgwqsQ4ehJToPP
         R6QbHAKoWdMvDitEqMHfcy7GkPha1SGFK2IIE4jjVDaQJgE+0CRkNWdnyIdOGydmitGu
         dVuod4GAhf3oXwqeJwqizMQ0xfG7oYJz8N+D1AZfa6vUULHtWLp1YVqNbfrCSFcVhkwt
         0bezxIk8FerpPi5Va6izK6pMvgVRl3K85R5bHLehn7Hf7wp8Hy6zzYZ8paZQvFApLA1d
         STBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694494632; x=1695099432;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJWJJxbp5m4HLOfJfgy7hOEA9P2JtVrJQNJNYVvTKnE=;
        b=H8Zb7UZNXJHOVaRluaDLA43X9BZ32GsFK7NZy7Lu9tN402Wm8N3mUMPge2Uc3ohDb4
         LAxh88XlXyYqFlnN6BF4YmP1++UYIDx+7mpbPy5ncBK6yvzg/YgWEYxVV3S9QyahA/wQ
         7Yru44B83+zEU1a02rJ9hqT/Z910UGtCPyC8Pwo6Xfi6m+WA/X7YvYfn9CkjM4/qXhMK
         4dJZdlkzcMNHE7VQ0XFDrHcxqLcBLuQZIM4CUHNM77aMCELPoLjKM7I7Gv5gdSJ98jXl
         f8AHvQImjcWwK+5DcYsA6WlMrUz74G83jWRta8SL0TBW0DLb5mn7Ss+uq9/Uycwz3jpg
         KDMg==
X-Gm-Message-State: AOJu0YwUbp5pL9kD4b0zRphe8j+9wxXRbAeh0es/56uka273HXWOoj61
        xoSt+noLjfanamFuPSUofpmYeMx40AQ=
X-Google-Smtp-Source: AGHT+IGyaKzyXTY24fI1Sx0PXv3aEQxzFBeJyyjC5N9pq0mh4X/jG7XwvFjwft20m5/gM2yHoFWx/58Nt44=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a02:91c:b0:577:464f:143e with SMTP id
 ck28-20020a056a02091c00b00577464f143emr385627pgb.2.1694494631827; Mon, 11 Sep
 2023 21:57:11 -0700 (PDT)
Date:   Mon, 11 Sep 2023 21:57:10 -0700
In-Reply-To: <20230818233729.2766281-2-gitster@pobox.com>
Mime-Version: 1.0
References: <20230818233729.2766281-1-gitster@pobox.com> <20230818233729.2766281-2-gitster@pobox.com>
Message-ID: <owlyfs3kkmzd.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 1/3] update-index doc: v4 is OK with JGit and libgit2
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> [...]
> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index f4bb9c5daf..a367f8d65a 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -166,9 +166,11 @@ you will need to handle the situation manually.
>  +
>  Version 4 performs a simple pathname compression that reduces index
>  size by 30%-50% on large repositories, which results in faster load
> -time. Version 4 is relatively young (first released in 1.8.0 in
> -October 2012). Other Git implementations such as JGit and libgit2
> -may not support it yet.
> +time.  Git supports it since version 1.8.0, released in October 2012,
> +and support for it was added to libgit2 in 2016 and to JGit in 2020.
> +Older editions of this manual page called it "relatively young", but

Nit: s/editions/versions because typically "edition" means a version of
physically published text (such as books). Also I don't think we use the
word "edition" anywhere else in our codebase.
