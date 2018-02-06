Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 607231F404
	for <e@80x24.org>; Tue,  6 Feb 2018 04:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeBFE1J (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:27:09 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:37803 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeBFE1F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:27:05 -0500
Received: by mail-qt0-f175.google.com with SMTP id s27so646580qts.4
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sX3yh8Ur/eT3u7p4oKwnYrneCWN2WBdUAhsfBrCNMFw=;
        b=H9daQqFpKTdY3/9zrykQlPaVHkJx6BBOwjOA2PWARsMitYcSRXVgUfs3I8TDgQFn58
         MX4CVE8hSxf7TGa3LFFj63TWBiEEHskEkOzJqkV5VbNWX2/ERzxE0Y9SJAwpnkru49Hv
         y/6BaHvq7typ2CqfpOmeRA/JC3urN94JGw+ldjntsUaNNh8ENf4PBihfgS8l+KhM/nft
         y8stnXmHgFkkTU6lZ81V83sA3t336oxEESUmm9JEEWT+OKnuBGiBeOYn0Mv6GljU9tcQ
         D9PztV/7bqRpBzbCkNxO5a3phJm9e/N3baI6LeziSR+AWqJYq82qtZvIocC/A9jK70s8
         hg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sX3yh8Ur/eT3u7p4oKwnYrneCWN2WBdUAhsfBrCNMFw=;
        b=uKIh5Mj6kR8GT4b8Zm4zUsugIHu6ekky+w9BO9ZU84RZyQbQR+Lo1A+1dwXx8kevXY
         c4nnNBneO3rQxhefNmLrD8qlEatktbxPqxW/8AhtNxu5e5aPYWzI5T1GxHrBD/+go9Gn
         wKc1b8QyfZvyh1ozvIqfgbuV3tzGzxSAvhsymfcdX+8NyYuDXVdyta+R+3qaCEGKO5ka
         XY9DGY17ORx0GA8MhNpBVYwRd9A6F2hsAjdguQaUlYtXc1ZAwsj0b89lYLsXDrblE3Iz
         OXHfIXLHl/Dz7eCmk9hHDomdAOTm9AIHR95X3LPO7JOTHUVgLMeA4DFPAUW9B0mnYU+x
         iH4Q==
X-Gm-Message-State: APf1xPBP8PfelddkLvD1g290oWPE7WvLx/0gqXPbmdTTjMDzSFxjvGyU
        JIEA2kZGzhV15MdRQ8VTkGWxfHNRMfckwl45KlM=
X-Google-Smtp-Source: AH8x225CkU8hzRcp+TTPQIfDoo3pj/JLPahogxroV9WRsI7zyguNUJnZJEJMdp9vNH+3gUF1MEefvA+R+jGxfrAQCoI=
X-Received: by 10.200.82.4 with SMTP id r4mr827176qtn.75.1517891225038; Mon,
 05 Feb 2018 20:27:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 20:27:04 -0800 (PST)
In-Reply-To: <20180205235735.216710-39-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-39-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 23:27:04 -0500
X-Google-Sender-Auth: v23VKWQW-G1dHj1WiBTN_x5HPZE
Message-ID: <CAPig+cTnucxCf5=24UBKGU5q_n0mwn0eB1pCLdiA77qXn-1n7Q@mail.gmail.com>
Subject: Re: [PATCH 059/194] refs: store the main ref store inside the
 repository struct
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/refs.c b/refs.c
> @@ -1609,9 +1609,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
> -/* A pointer to the ref_store for the main repository: */
> -static struct ref_store *main_ref_store;
> diff --git a/repository.h b/repository.h
> @@ -33,6 +33,11 @@ struct repository {
>          */
>         struct object_store objects;
>
> +       /*
> +        * The store in which the refs are hold.
> +        */
> +       struct ref_store *main_ref_store;

Do items moved to the 'repository' structure need to be freed when the
'repository' itself is freed? Is that being done by a different patch?
If so, it would ease review burden for the freeing to happen in the
same patch in which the item is moved to the 'repository'.
