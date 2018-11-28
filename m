Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3788F1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 20:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeK2HdV (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 02:33:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42406 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeK2HdU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 02:33:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id j6so23221397edp.9
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 12:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+TfrGQYO5plO/gIMdUflUwKrmnn6PWpPwV54v1bIaNM=;
        b=dRHGQGr84643wxrMfcrvu//GeJGOiWP3TvysEmGa420K7fbbBhdUZhn2lajPDpPjTD
         oO0aKLG/iC4zUM3DDuNN22Cq7IeuASiLU+FprRGbgKwCe+YiR2ak/MMG46v3YQFNMxX0
         t5Sl0B9aWUhd6xR3EGWM3x/h4Ui9XbDRgu+5WkXOdbdbHX22FnzzBjARW5LF17a9NoO9
         9W09dnibWTvEhqZynQjdwidECXo8Qf8jm+XoGauMHNGD/XeP0cg89lg24lWWsDOyroMJ
         UgVavU+F+rrPVtAu430qGAcicCHXIanpbINk6wSaXnTJjjVxg7+2JcpVtIaCbeK7lZLm
         2xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+TfrGQYO5plO/gIMdUflUwKrmnn6PWpPwV54v1bIaNM=;
        b=JmmVRaQ7IQdKo46ZRFwNiO4UsWZle7Q5pN3UtNjDdS7PwjdQGOKQY1au2fdTFtFvGp
         zueVuPmRXiGwSBs/TensqFPqkQaEFf5A85xRA1NSpPhoEokMcs/Rsux/EmixGHMwKFgj
         rSJ3zSxH84TohkS9HWiAcFPvUqh397iQjDLL3AXiP7A7wLuHviu06zXJZ5s6pHxVmSIL
         GI57gWHjgUwPDLMgKfZj7Ln6vJfmn7wmfsvqcjFLE/eiO2Fj5OIBwTDtOH9D5ffQ/isP
         CweLn0RL9oOn5rE2G5byvMwPaDx8QBTwRgjYnAaIDYiaX6YzEric9MVkSzlpZ3NWJ/Kq
         CByQ==
X-Gm-Message-State: AGRZ1gITNv3kpo6ngQBFyIReYbQcBVKV/oHN7DzegT3SwKpc7VLjWrqR
        rAIgcPBseYQbAVOgFDtNolYwdtU2QPqcdCgeFe2nCw==
X-Google-Smtp-Source: AJdET5dI4fHz6j0CyXbR8R2lEsMfTKExjUNwtedBdZ7spCfdFIvbc+l+BdMw07ViPD+/hkc++NUzAeEIliOVlVA9h3M=
X-Received: by 2002:a17:906:2dc1:: with SMTP id h1-v6mr27631149eji.67.1543437026747;
 Wed, 28 Nov 2018 12:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <CACsJy8D2gxPj4u0_eEg-_x-Z3S3+5FdTU6Su4VQM113nQq=PYg@mail.gmail.com> <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com>
In-Reply-To: <CACsJy8Cv9ZwWEs-wsOtms3JCXo7x8fL_PBatcb0TgvrrQuMUdg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Nov 2018 12:30:15 -0800
Message-ID: <CAGZ79kYiMObOHAuf+01r0-YVWHBk-6NpceXh9Z25dx9JZsP62Q@mail.gmail.com>
Subject: Re: [PATCH/RFC v2 0/7] Introduce new commands switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 12:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 9:01 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > should we do
> > something about detached HEAD in this switch-branch command (or
> > whatever its name will be)?
> >
> > This is usually a confusing concept to new users
>
> And it just occurred to me that perhaps we should call this "unnamed
> branch" (at least at high UI level) instead of detached HEAD. It is
> technically not as accurate, but much better to understand.

or 'direct' branch? I mean 'detached HEAD' itself is also not correct
as the HEAD points to a valid commit/tag usually, so it is attached to
that content. The detachment comes from the implicit "from a branch".
