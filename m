Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E1FC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23B161360
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 05:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFCFlK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 01:41:10 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:38785 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFCFlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 01:41:09 -0400
Received: by mail-il1-f181.google.com with SMTP id d1so1396794ils.5
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 22:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E6IpFSAgYHK7FqFPhrnrlCwZj1Cxnhyce/QJ1OWfXNY=;
        b=MPOxgCl+JCHn4WHMJ8Clnm2nZAfHZ4Kygfmg3yQgOfz8yzIYscId8W7JDR/4nmRXSm
         iZkNp6kAEhOWPk1gyxAZfgs4nbvvoEXw9LYBXwe6eXNXW8EZqVTci5kJEdzM2fRo7gqT
         cGJUBLBQud6x9RBjhUq8PH8M6ZiadKDvRlpXRmHEiX1vxcsFHamabfQn3DEleRAYX/yd
         NI7vOZR0xsDhawAEXyMAnj6M28cqxxLgUtEcBSMS6HcB7tPX98lUbLpTK8myMm2YCRBB
         4vlBIt/RfBfaPyo9VIkAQdg+atZo33IY7eCyRHejJWHPowkdtFEiiyg1T2bnDYc7uVUw
         9IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E6IpFSAgYHK7FqFPhrnrlCwZj1Cxnhyce/QJ1OWfXNY=;
        b=MRT0MtO4v2pwvUsbAe6zUfhPqfu1Ei23dr5RXJxdggh1aEeM4T9+xZr6qAzMqrkC9Q
         uIHl5kJkNcnz/hbQt5X3UV/mQafBsv7badYhsiksf4SLAgHdvpkgaj9u8djIpXgiqkDJ
         OdlkUxb+GSfpapT9wuBOwms4JKeWnVesNj4xX1/MRlLAJFWuiaV8pgFqj4xMyoVKfjGt
         jdyhL6dcU3rsLiws0yhtrbBUpIi0fNe8830ltqiB7/luHrvaKxLxrYiweoV2AUnrXILf
         RAo6pyOgRWUSFv65VsVxK7mbFzIb/uwfYguBA+o59qjDmNx04uIPABugRPY0dRShCJ7l
         UAdw==
X-Gm-Message-State: AOAM533Ty8GGjZJOElJQ3lC09eFwjaisLIk+3jru43pSSOjJKD2OcJMv
        zYoffr5THIrYum6tt3U3Ky4ucnsOZlBbsdDpBtw=
X-Google-Smtp-Source: ABdhPJymBj17zTAiH0ZzGhQJ0G2qolXG5Qo47Jk6adhz6E8LmJJdktlXuw9itGk85upAGPW3AtCdqavinJAIaefFx+w=
X-Received: by 2002:a05:6e02:1ba5:: with SMTP id n5mr9459005ili.174.1622698690683;
 Wed, 02 Jun 2021 22:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com> <0961dc61-e785-8e3d-8c06-bdb8f2d6ee6a@gmail.com>
In-Reply-To: <0961dc61-e785-8e3d-8c06-bdb8f2d6ee6a@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 3 Jun 2021 13:37:57 +0800
Message-ID: <CAOLTT8SudqfYq-UDqOjVpKs4xNpthiDNMA8QduKqrQvz9HaNWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] [GSOC] ref-filter: add %(raw) atom
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=883=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 01/06/21 21.37, ZheNing Hu via GitGitGadget wrote:
> > In order to make git cat-file --batch use ref-filter logic, I add %(raw=
)
> > atom to ref-filter.
> >
> > Change from last version:
> >
> >   1. Change is_empty() logic.
> >   2. Simplify memcasecmp().
> >   3. rebase on zh/ref-filter-atom-type.
> >
>
> I prefer no first-person pronouns (I and we) in patch cover letter and
> commit message, so better say:
>
> "Add %(raw) atom to ref-filter to make git cat-file --batch use
> ref-filter logic."
>

Ok. I will change my way of narrating.

> --
> An old man doll... just what I always wanted! - Clara
