Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FCE41F403
	for <e@80x24.org>; Thu, 14 Jun 2018 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbeFNQ03 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 12:26:29 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:46074 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755071AbeFNQ02 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 12:26:28 -0400
Received: by mail-ot0-f181.google.com with SMTP id a5-v6so7750970otf.12
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzhMmhM+Oq/vpLaEqSUDoq2QzZ4p0fWwGjEDaPhYbZ0=;
        b=rzDnmjHe0hSya9XVbttYyHb2R3yWApaQVhE+dBL/C1lCJCr7ew+00mDflqawcPzTyt
         tPU3E4DwYz2SqJGw1oeU0M/XAgEs06fGgG7Ge3J/ifLtWcX+054n5g02BqD64IQ8FLQ9
         RnKbVIWwTDzxBop/k9sfXi5k7KXFAfWzQN7thDRTuqxsg05jq8p+k1uXWeXqxdBXWBRI
         xwPcxvQiGeespI3srdAEK14ibf8ZJQQstNbhmUSOoQuUsxfv7JZkl9CPw01vNt/uaWk3
         ASReC1rSZd0ctAl9RkUbyfkuMaWGdVnnmIVwYGG9ZaBFOIINw5q1mVSlQBLNbdlUyExC
         93kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzhMmhM+Oq/vpLaEqSUDoq2QzZ4p0fWwGjEDaPhYbZ0=;
        b=Uxbf0Yzted8zHUbYvsvg68CDvlRSalgR+4RbiizxinQruzZq6a21/mWmj3yF2RiyLT
         miOOBRkuG6GA04/5IFTJiGvSi5i4VUQXR+38E9ZVUb2atXCVsqDweQzqV3WXE4FpoiKW
         t6iGMozy1A8RNO3+OOFH8BG2qHgD+04aONubxXw7SXg2Xj/ZYM4CNoEXQ7Gm3YXovgKG
         fhI7TJxwvBHZLJb7Z0mI6NRwHRHhfdw83CxLhV5LnsOTBN66b02UUiHFHERo6/KFTX3Y
         toiawbByXYNRno8GA8xwkoHfPHGHG5PWnMfqFg6QFDUMHz0+pjG43E1valdRHT0HRrto
         ALkw==
X-Gm-Message-State: APt69E2673AwuoM5LwAIMVR+Hm1ILozNfV8oAZns1KuaybivSwUE1FWZ
        lwO8Utj6p3nyPNCTGbTCdERQSH0h2vGKtpe2gCk=
X-Google-Smtp-Source: ADUXVKKfmf1kcL/dOdHOz1vMvNGt5bzDQ/97zprKDpQuUu2+QJYtvrZmKP9hrVAVgClOdRUlxxD6yjJmq1W3aT3dTow=
X-Received: by 2002:a9d:16cb:: with SMTP id s11-v6mr1870552ots.304.1528993587730;
 Thu, 14 Jun 2018 09:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180530004810.30076-1-sbeller@google.com> <20180613230522.55335-1-sbeller@google.com>
In-Reply-To: <20180613230522.55335-1-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Jun 2018 18:26:01 +0200
Message-ID: <CACsJy8BvsfPoBZg69u8MvGQUxp3eQQu4=w-0FPmZ9EKQqA55Zw@mail.gmail.com>
Subject: Re: [PATCH v2 00/31] object-store: lookup_commit
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 1:08 AM Stefan Beller <sbeller@google.com> wrote:
>
> * removed mentions of cooci patches
> * added forward declaration of commit buffer slabs.
> * dropped 3 patches that add the repository to lookup_unkonwn_object,
>   parse_commit and parse_commit_gently, but were not converting those
>   functions. We'll convert these in the next series, as this series is
>   growing big already.
> * This series can be found as branch 'object-store-lookup-commit' on github,
>   it applies on top of nd/commit-util-to-slab merged with sb/object-store-grafts
>
> v1, https://public-inbox.org/git/20180530004810.30076-1-sbeller@google.com/
>
> This applies on the merge of nd/commit-util-to-slab and sb/object-store-grafts,
> and is available at http://github.com/stefanbeller/ as branch object-store-lookup-commit

I only looked at whole-series diff, not individual patches (sorry).
Besides the one comment I made elsewhere, it looks good.

You don't even need to reroll this series to address that one. A
follow up patch whenever you feel like it is fine, or I'll get to it
eventually (after the_index is gone, I plan to kill the_repository
outside builtin/ too, for the same reason).
-- 
Duy
