Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,TVD_SUBJ_WIPE_DEBT shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DD1D201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 13:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbdBUNZg (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 08:25:36 -0500
Received: from mail-ot0-f170.google.com ([74.125.82.170]:35908 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbdBUNZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 08:25:35 -0500
Received: by mail-ot0-f170.google.com with SMTP id 32so88342882oth.3
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 05:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0wgWFvKN6nfpsQ6yYYKWCUCmkkd/MuA4UlzsbDu0xiI=;
        b=RGA5RhWUjWTeaiRX2CvgbdQUYYZ7L3f9d65RAgscZ+3QQ85IsvobbwVD+egDPBP9oZ
         DTw5g52ZNEkernW/rnTvvEGQnnBLdo5NLkMjkaZJIoNUN1swKkVgMg4SGk4L3M+cxZqL
         jak9izx/ngkNdflUmY3KeLguk0/VRvgbfILCnp8069v7Pq19oVE6s88UIyvMUWg4M//G
         g+cti3NUgtR2IN/joeJ1IIbueTSGNgHnN3TZNBoqPN85GOKAa8RoszRg+eEbgR6wR55o
         NEZiLZaWxTIZK6syAyI4GSaOUF+gqjIdU8ibiud1fhbp/RVcY36zx1zRgP6C5FqH4h7z
         qntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0wgWFvKN6nfpsQ6yYYKWCUCmkkd/MuA4UlzsbDu0xiI=;
        b=o8LN9IQUEndM+Qwav5IcqWuXjhPUXXd5FMD4yjofK8yY5m19/EqfM3ZM+KP4X8MTbB
         yqoLwYezqd+ToZZ7ucj3HBo3MYCf/NrE8TtzO6TVnfocWTbF10vyWJtNubP1CkHsVRFK
         GVtt9iZMObwNaNmvWm9M1ZwM+MSkwpY6ZpXt6o/O6LpmojTYHZTLLebxAYDZRawz3TX9
         6jRCzLd7dNQS2j1mo1cVSY2brC9nGsXKcAN/WRIVDZnbVVh/4pFxatZOBxQXeXWLC/aJ
         u/WI5eg7OjqK5xbJLGiWYgMA4yrctz58G9M8UZSiL1F/gAxEH/b2PMUJBCHJFd5lsoNp
         tUSw==
X-Gm-Message-State: AMke39lqTq38mgbpehABPGanqW9nsqaO+bp8c9CdHXFZwOyw8HXb7V+73QQ8mzPzQWNe9DI8covkIv6ItRLrZg==
X-Received: by 10.157.9.242 with SMTP id 47mr14247369otz.128.1487683534367;
 Tue, 21 Feb 2017 05:25:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 21 Feb 2017 05:25:03 -0800 (PST)
In-Reply-To: <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
References: <20170217140436.17336-1-pclouds@gmail.com> <20170218133303.3682-1-pclouds@gmail.com>
 <20170218133303.3682-15-pclouds@gmail.com> <25fcb527-595a-7865-41e3-ee7c4c1ad668@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Feb 2017 20:25:03 +0700
Message-ID: <CACsJy8CqHo_sCz0mFasvWJBP_cwWUu-dccowvtWs4pMoc5uLiQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/15] files-backend: remove submodule_allowed from files_downcast()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 7:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wr=
ote:
> On 02/18/2017 02:33 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> Since submodule or not is irrelevant to files-backend after the last
>> patch, remove the parameter from files_downcast() and kill
>> files_assert_main_repository().
>>
>> PS. This implies that all ref operations are allowed for submodules. But
>> we may need to look more closely to see if that's really true...
>
> I think you are jumping the gun here.
>
> Even after your changes, there is still a significant difference between
> the main repository and submodules: we have access to the object
> database for the main repository, but not for submodules.

I did jump the gun for another reason: files-backend makes function
calls to the frontend, which unconditionally target the main ref store
(e.g. resolve_ref_unsafe, delete_ref...). Of course, because
store-aware api does not exist. My decision (off-list) to add
test-ref-store was the right call. I would not have seen these because
I was not (and still am not) familiar with files-backend.c enough to
see its dark corners.

files-backend.c is not all unicorn and rainbow :(
--=20
Duy
