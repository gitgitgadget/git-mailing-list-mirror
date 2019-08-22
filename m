Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF9A1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 03:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfHVDSs (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 23:18:48 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35971 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHVDSs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 23:18:48 -0400
Received: by mail-vk1-f193.google.com with SMTP id u203so1159576vku.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 20:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TEASGrsEMPqajR5QavBUSxxwWXxoL1MBgVtY8kJ5C+s=;
        b=Kyo2Qkzj8demGwiQ2083CmsaUDF20QJkbgCGkBfgTHkST/8ufa3eYl1S3AqDuqiyZq
         gW3rvj3D9CjrBGKhiMFNd4oxeuVySBmVblltLKmKyd7n9iFs5Y60Bpw0TbynkXglS6md
         Rfc5/s05io+NMWkJpA17gMN7PAKOobYsdDpBfhKJShUPwFyg2XJCvT6bzb4+nJsH+rkJ
         /I9bLkkuMwTzbnyNrQs7jx+2zHeDOtC72RTZIeCrNzuQnxma1J7j3WtoNePzwfAJEzNG
         80JQn93phBQzZis4FUkkeiOzumbiBqZArIgxvUPMMX3HZoGOsvcOYAOF6BVU5dua5Tqn
         fr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TEASGrsEMPqajR5QavBUSxxwWXxoL1MBgVtY8kJ5C+s=;
        b=SnMyoozb/4T7G/qDSe3c6PbNEpymGjTxECFW6jlzNAZky/goGpNruZsUyAr7agKSum
         LKees7Tn70TuwoPoIzcYlFmuq8woqc3BVQ2Z3YgLvPavUyLrrWzXgYppSnR/H5+55Vom
         wwcpz/0fR7s1/OgiP+pCeZ+UTeCsuPAK6REbeuYxxFiYVWHIl8ClFm8hq0Lkv7xGXhe9
         BBvqH/6idBS1DwJ0t0N2Z+eRY5pcSI4qSR/jyjdv/8jksgeIS7xw2VLufFbh12+3Iglv
         2SZwIL1GYQ5QdJzC8mmxZl5eJ4hdO9g+NmZ2032vi4QS54GByBzNwyllnZgn0rDrZILr
         z0eQ==
X-Gm-Message-State: APjAAAX7bqp1q1ShWES10VwUcXwa2IgxloUGyJF7fQLQrVJd4dIhw4wj
        AKgq+GDcq+th9ZHUhsNzWAxGSXyTcEhw1JnLnq4=
X-Google-Smtp-Source: APXvYqzxwyVejqVvpKSFd/0UG8gqwPLLajC/XWIXYSEyRW3aYxnQSlk8xbHjBJyBik//kxYa3pTSROyJcL1FS+VX9n8=
X-Received: by 2002:ac5:c901:: with SMTP id t1mr13463190vkl.27.1566443927134;
 Wed, 21 Aug 2019 20:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.317.git.gitgitgadget@gmail.com> <20190821223158.GB20404@szeder.dev>
In-Reply-To: <20190821223158.GB20404@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Aug 2019 20:18:36 -0700
Message-ID: <CABPp-BGuwjC494sC8BCAjURyg1KgnzkhKfgewLH0fven6Qjc3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] [RFC] Revert/delay performance regression in 'git
 checkout -b'
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 5:01 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Wed, Aug 21, 2019 at 12:18:32PM -0700, Derrick Stolee via GitGitGadget=
 wrote:
> > As we were integrating Git 2.23.0 into VFS for Git, we discovered that =
"git
> > checkout -b new-branch" went from 0.3s to 10+s on the Windows OS repo.
>
> Does this slowdown only affect the Windows OS repo with VFS for Git,
> or other biggish repos without VFS for Git as well?

It will also affect other biggish repos without VFS for Git; see the
"does not seem to be GFVS-specific in any way" paragraph of
https://public-inbox.org/git/CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVP=
XjUjA@mail.gmail.com/
