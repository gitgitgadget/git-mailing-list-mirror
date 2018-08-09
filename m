Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AA4A1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 07:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeHIKDO (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 06:03:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35052 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbeHIKDO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 06:03:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so2204020plq.2
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 00:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WNXzfKvESMOBsYqODpPbAOZpviSoP7lLfBE9k/Tp4E8=;
        b=qiPdJZXX4cYC+ynVrtUEBEXSmuqelEji8yVAWXIU2dDfC5aqc1Jde/39AvqNjGQhJR
         0CHZqcIkDYCyT+4jHRq3dUToPErgayoont9/DlxhP5ziTIRIs201qyqJuy6sUym66CAi
         jk/bBUBB3a08yNBQItWs1OGHFIvrI+Y+iSIljKDHhh8hqW1QELN1IixwChmTrHjkyO+E
         4jMWa6BG0mDLnk1quiIF1NcTLmaDZUnlji3s43zBWhyhbV3e5wJnYMusMZFSfcJuhfU1
         bv+jow25WS5FDSMKoeJPFJguYOdZkbcr+dUAl3IZk//wHoDZExtJzR6kMhyGHeArR7WC
         EEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WNXzfKvESMOBsYqODpPbAOZpviSoP7lLfBE9k/Tp4E8=;
        b=cNBsSO8Y+4jt8OXWBSdK372EuLcNcJdyCKTVToxiJBbWE3p+PLYusRMR6rTw0Dy2F1
         /xJfbAApJpVGjsKIT5XHxBjGqTLA5nmuTWTqxYqTXSHQI/9D5yaTNfgN55eh4p8OkNw5
         XuveYneGcO46jpQ9GxAKf+MtA1VhTfA/iCr6wBmR1/OQEjK0YP+1XyxQGIUhPla68Wmn
         V9KLHc/aeD/8/CUUJli9VthyAga24a/FyfjLUn6n6GNDHnkJl9q7A1iUbimylHIG/PIG
         cHcN0ypE/cJ02IDMKMwdCqF2jZIIGf2HoSz+Efq6T0nyIUso1YD3cz5EfM0zJ42/+F3s
         rlfA==
X-Gm-Message-State: AOUpUlEh7t9H7uH4FOeAFi6h1wZYffaAOD5JNBu6dvsMdGuATNafVg7g
        k+hbaQo2sPi9gWhI+EFAL5mRnHywE308Og8Xu34=
X-Google-Smtp-Source: AA+uWPzQ9j+55KU72eqK+zII5UkLQVIzbQ6OKSsS7kpPK6AE0YTJZRhpRzNOgAHdqCAEovlVQ2fIS2W5GnRgzwh97nw=
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr1051970pld.168.1533800379770;
 Thu, 09 Aug 2018 00:39:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3541:0:0:0:0 with HTTP; Thu, 9 Aug 2018 00:39:39
 -0700 (PDT)
In-Reply-To: <20180808221752.195419-4-sbeller@google.com>
References: <20180808221752.195419-1-sbeller@google.com> <20180808221752.195419-4-sbeller@google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 9 Aug 2018 09:39:39 +0200
Message-ID: <CAN0heSqwGoFwn34nRp3i09ExnjDPSY8WD=81M9jN5OW-ccpiTg@mail.gmail.com>
Subject: Re: [PATCH 03/10] sha1-array: provide oid_array_remove_if
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>, hvoigt@hvoigt.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 August 2018 at 00:17, Stefan Beller <sbeller@google.com> wrote:
> +int oid_array_remove_if(struct oid_array *array,
> +                       for_each_oid_fn fn,
> +                       void *data)
> +{
> +       int i, j;
> +       char *to_remove = xcalloc(array->nr, sizeof(char));

Do you really need this scratch space? Let's see..

> +       /* No oid_array_sort() here! See the api-oid-array.txt docs! */
> +
> +       for (i = 0; i < array->nr; i++) {
> +               int ret = fn(array->oid + i, data);
> +               if (ret)
> +                       to_remove[i] = 1;
> +       }
> +
> +       i = 0, j = 0;
> +       while (i < array->nr && j < array->nr) {
> +               while (i < array->nr && !to_remove[i])
> +                       i++;
> +               /* i at first marked for deletion or out */
> +               if (j < i)
> +                       j = i;
> +               while (j < array->nr && to_remove[j])
> +                       j++;
> +               /* j > i; j at first valid after first deletion range or out */
> +               if (i < array->nr && j < array->nr)
> +                       oidcpy(&array->oid[i], &array->oid[j]);
> +               else if (i >= array->nr)
> +                       assert(j >= array->nr);
> +                       /* no pruning happened, keep original array->nr */
> +               else if (j >= array->nr)
> +                       array->nr = i;
> +       }
> +
> +       free(to_remove);
> +
> +       return 0;
> +}

I can't entirely follow this index-fiddling, but then I haven't had my
morning coffee yet, so please forgive me if this is nonsense. Would it
suffice to let i point out where to place items (starting at the first
item not to keep) and j where to take them from (i.e., the items to
keep, after the initial run)?

> diff --git a/sha1-array.h b/sha1-array.h
> index 232bf950172..151c7ad7f30 100644
> --- a/sha1-array.h
> +++ b/sha1-array.h
> @@ -22,5 +22,8 @@ int oid_array_for_each(struct oid_array *array,
>  int oid_array_for_each_unique(struct oid_array *array,
>                               for_each_oid_fn fn,
>                               void *data);
> +int oid_array_remove_if(struct oid_array *array,
> +                       for_each_oid_fn fn,
> +                       void *data);

Maybe some documentation here, but this seems to be following suit. ;-)

Martin
