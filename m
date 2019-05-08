Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6391F45F
	for <e@80x24.org>; Wed,  8 May 2019 14:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfEHOlq (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 10:41:46 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:54848 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfEHOlp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 10:41:45 -0400
Received: by mail-it1-f195.google.com with SMTP id a190so4428541ite.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=STeE8SSHdVBfzK0Kv1F8FcZ8vKdPjTxpnSCPjnwnxkM=;
        b=uqL4oxnoeKJsSAgfWRBkHYAfuUHKLVRNEAAaFZsn8WiqgRtKofZg5LjBA05MDVhLPM
         OEBX03sEQU6Ah2CdZ5FKTRXGOEF7r7KkyMwqFdUGLmyDOpRLKQR/EGYjEphKhj752Aoq
         KkywhZ//XFEBJZ+twD+BJs0QK1iQDDkPa/ua1/euDmmC0KYxMNsbmZ0ue8EJ986gWcpZ
         QK7W/NAO9iAGarH7ApQHNp8gzna+EIgLyBmA7ebtnHSFmvFWD6rkcruBjlHFePpzuf1o
         j0d6qivWNdU6iX1AJgR3VnZykJ2p/uwOuzrZt9cBcgNVN/Z0UaO+uvnMF28uw6nkC06W
         v9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=STeE8SSHdVBfzK0Kv1F8FcZ8vKdPjTxpnSCPjnwnxkM=;
        b=qKgMDLbC00Wyw7r3jGzdLe70mCoJoaoTsr5fW/wL61sK4hZgtYssu67xQsIhXlH7nn
         3z2p39yHt4EecCKXDlJTT4zXh+GfjzrsrpSEqzHWsKYRva7KMnaOB8NFp+NH6NQh+tjY
         bQiiwEvS2V5Cjzh56xczoXQKVFmZz7p9GT+/gssOmTYtkfEHEfViLhVgbQK5CRRG1u3L
         KXdErw9VsR+GVhK5Fm7HhQk4qUIzeZZhLZouNh7N06osZiAr6B2DOC2mLedQQEd5zRk/
         7L/lVtGLQWZE6JnMlxoBK2CfMG+JsSg0Vqfn6pHbboE8GDhQ9lyK54KXxHetmL+AB6np
         oc+Q==
X-Gm-Message-State: APjAAAXPrfxrZrgJD+XwFveC93IMNvu/xdre82d70EZuEvXBmRDp8dJY
        gx2BsMNhvyQ0iUb6eR61EWkX0r3ILsVxe0spHbsokA==
X-Google-Smtp-Source: APXvYqwOjZqwzH+DCGlolRsBYzBcZjERIOMxfzK/Gpignp/rerZBPP3uKIvJKhLaOmZ85OyQfGQt2jo041evhu7bYU0=
X-Received: by 2002:a24:5c83:: with SMTP id q125mr3737845itb.70.1557326504148;
 Wed, 08 May 2019 07:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190508111249.15262-1-pclouds@gmail.com> <20190508111249.15262-2-pclouds@gmail.com>
 <0509589b-7a92-6c05-e404-65a9b2bf5666@gmail.com>
In-Reply-To: <0509589b-7a92-6c05-e404-65a9b2bf5666@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 8 May 2019 21:41:17 +0700
Message-ID: <CACsJy8DEjBS-aiWqDe2AU56rJBVZ4Po6c-C7GxR4QDNiGSiZoQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] revision.h: avoid bit fields in struct rev_info
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 8, 2019 at 9:07 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/8/2019 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > Bitfield addresses cannot be passed around in a pointer. This makes it
> > hard to use parse-options to set/unset them. Turn this struct to
> > normal integers. This of course increases the size of this struct
> > multiple times, but since we only have a handful of rev_info variables
> > around, memory consumption is not at all a concern.
>
> I think you are right that this memory trade-off shouldn't be a problem.
>
> What worries me instead is that we are using an "internal" data structure
> for option parsing. Would it make more sense to create a struct for use
> in the parse_opts method and a method that translates those options into
> the bitfield in struct rev_info?

But we are doing that now (option parsing) using the same data
structure. Why would changing from a custom parser to parse_options()
affect what fields it should or should not touch in rev_info? Genuine
question. Maybe you could elaborate more about "internal". I probably
missed something. Or maybe this is a good opportunity to separate
intermediate option parsing variables from the rest of rev_info?
--=20
Duy
