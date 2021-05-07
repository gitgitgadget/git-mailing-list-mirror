Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DED1C433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29580613E3
	for <git@archiver.kernel.org>; Fri,  7 May 2021 04:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEGEdm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 00:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGEdm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 00:33:42 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A859C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 21:32:42 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id l19so6631740ilk.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 21:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiGR7LRgdW0G7UWsx97uaY3cvzm1r4+m3eTqkmbUas4=;
        b=PusntFm1ic/ZcwZxJfxYGVC7kiGv4OvwtGPA4IEENG9oHReprVD5WMJU88S2aWFqj8
         FNYl8xYPyiAX+SAghlzHYsQMb7Ng0BVK2AY/qta5lFDMCVOWnuYdXvzf3yUnN3mDP0TR
         gTL5Qed7eBQNHRV2qH1Lkh9iuA/34fGxGMNC2+mBmEDSLbOLJtI4lIvWogZWlruSCSrS
         5RZ/SyCbsufARpDw+NPbb4au4yMktJwxSgSAhjfHrj16xQGBiJvE+ED3J/2dZKFr+Mng
         scykmTdUAy9U/93SilPNLkVeYOtj6NQ6bgsFY+nZsmuT930XXwnJ+6wfUSgMpx82gpLy
         7lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiGR7LRgdW0G7UWsx97uaY3cvzm1r4+m3eTqkmbUas4=;
        b=Sj3AFPcyqO8RfkM89Ldf5KROdQ2/NxTcjcZLb1J5d2BenSsLmSajDiWILO+rJexO+k
         Ht3LKoh2/xmKfY8fX1CnLNvqTWnPLxxXW8mBx2hXmjvbNM6fD6M8kriO6N+mUueaF93R
         464xUUkZK33gjvi8ItEN44+4w5QUZwZOc/WXLI8pVlYP32GzajsDU0vg6Hp2JB9jqrt0
         hcic6xLC9vVVz+LIJCNbO7nikp+bQlyyfBjlHG5GKC3wqLgzHI2fFWFXAkZcW19mPiJX
         o0Z9QPI8Dt/9UfCraXWdvFxovzxAHn7bcjFj6CzcWbk0jhlXKKaqcqb4PfO7ithWZ9Yn
         YprA==
X-Gm-Message-State: AOAM532ZQPeQcU+jvtKnc0hmlHLaQE2nzvVLdEXFdnGtjc+MbDEyeI0L
        SxizvRXHxCi5OatqRnxtTYnRetDHEHalrFmCtQbAfjb4s+wmtagZBAtH2Q==
X-Google-Smtp-Source: ABdhPJykLdKd39spWacKhv3ap0SRwr7J0E37/S4u3chTKVMZnohLNLgd7AkN1TcIb63BnikXftj4aLmt/ff9j5cSP18=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr7683830ilj.53.1620361961461;
 Thu, 06 May 2021 21:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.git.1620228664666.gitgitgadget@gmail.com>
 <xmqqfsz01vc2.fsf@gitster.g> <CAOLTT8SmvRaohV+v2C9eFXyc8O+di5PfZJeWNinmm8X=Ckdveg@mail.gmail.com>
 <xmqqk0oczao3.fsf@gitster.g> <CAOLTT8S9TbRWGPeGKR9=cDnaw2RMukawV48dPEK1KL0X_87udA@mail.gmail.com>
 <xmqqtungxg4y.fsf@gitster.g> <CAOLTT8TQXAh9vu21d5rvaHe=+eqtFU8MCVhorfGmqYRohDThUg@mail.gmail.com>
 <xmqq8s4ry2ye.fsf@gitster.g>
In-Reply-To: <xmqq8s4ry2ye.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 7 May 2021 12:32:25 +0800
Message-ID: <CAOLTT8QWadP9ovrUC_7m86dKh1PsawUyZ=msK5tx1utTpuCXMQ@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: solve bugs caused by enumeration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hmph, I do no think that would be futureproof at all.  If a new atom
> "pushe" gets added, it is not all that unlikely that it would add
> its own member to the same union.  name here would be "pushe" and
> starts with "push", and upon parsing "pushe", its own member in the
> union, atom->u.X, would have been assigned to, but the code we see
> here still accesses atom->u.remote_ref.*, so you still have the same
> problem you started to solve, no?
>

Well, this "pushe" has `atom->u.X` which is different from "push" and
"push:". This is indeed worth worrying about.

> The check we use in remote_ref_atom_parser() to see if the atom is
> about pushing, i.e.
>
>         if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
>
> is unlikely to be invalidated in future changes, as this is very
> much end-user facing and changing the condition will break existing
> scripts, so that is what I was expecting you to use instead.
>

But I am afraid that the cost we paid for string matching here is too high,
Since the string matching here is to illustrate that we use one of the members
of the union, why can't we directly add a "union_type" member to used_atom?
if we have this, we can just switch the "union_type" flag and also make the
program correct. Perhaps this would be better than the large number of string
matches have done here.

>
>

Thanks.
--
ZheNing Hu
