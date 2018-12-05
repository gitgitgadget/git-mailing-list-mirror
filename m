Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDF6211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeLEU6t (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 15:58:49 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39351 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeLEU6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 15:58:49 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so22456215itl.4
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JPFW5ldOXs95rh2TubvG91mkXZib3zZvM3VJ0Yxi+g=;
        b=tfWyKErCguOlbuzVnakmaWzc5avAfFu+N+rxAi7WYYv8R++0L9dMtQ4FnjXHyJ+8tN
         y7N6HUjFursg78/qefmwF1mrtTqfddduV/WwzP5xQsbqwfknbd71a/hjSIL96DymaCgW
         kDy9FCGxeu9qOgEnEvfNpwwdm1qDWw7VpY/lbB3vncc7hzf25jowqEIGE3RtXkezB88Q
         oO/g3Mzp4w++pd0pRo10I3Vw0ZTvHbXp9QZ/Cllb4T/7Xdyy9OECk8NKK4U6KQ2wMFo1
         qpPC+QduK89mOVQIPdIrqkbpWfsgxTfUzUFD7lXXDlO6GwxamDTH0R/qx7y2OFTMHX3v
         68uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JPFW5ldOXs95rh2TubvG91mkXZib3zZvM3VJ0Yxi+g=;
        b=YOiSVXyXJXtscZ7yP6E5eaFe3Io9rjORtwdcIgLxj4vIQ+cyln7u2z7/guhMpW4cZj
         wQpz8j2xuvN35t6GBkZzQDK1qrNdQOgheIhJMnp6FktOqLWzFsdrYZs9lmIIZiI7fApY
         yXYdymTDUrGCCX4FUtZIzI1cQa86ahXsPNRLL1vzIXBNvSL7l/7fUkcnBeeaBI6gChcJ
         4v3bqkTfS0Vs3gfj6ZPo2tt01Itf3zQynPa7ZikiNQgCKh1jDTFmi4/c+Tv+a+41CeW7
         8YlpDH6RbSngYfxcLmX5JPgbLMU6rsTB114qJbMCwZeMyLlxIIa4W1+UCUOJkmxrSpLP
         vArA==
X-Gm-Message-State: AA+aEWY0yQkCaIA4KahvYSOwT4AOT+k9+3M/bYBD9mr5mVnqfcQq1gVO
        VJNzOvBqg6FrohLIAHqpr2bRCDLwgREdmttD5KEKFQ==
X-Google-Smtp-Source: AFSGD/ULOWtKEXdqNk74zfZUwIjeUsV1l+6/k4aza1MiR6YqEccA89hbQklRcNU9zl7qWTWJf8fcpVrM1elPO85RdLA=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr16687956itk.70.1544043528266;
 Wed, 05 Dec 2018 12:58:48 -0800 (PST)
MIME-Version: 1.0
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com> <878t13zp8y.fsf@evledraar.gmail.com>
 <a5a3009e-346e-2b63-5b7c-3e9daf0c7de2@gmail.com>
In-Reply-To: <a5a3009e-346e-2b63-5b7c-3e9daf0c7de2@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 5 Dec 2018 21:58:21 +0100
Message-ID: <CACsJy8AzMvG3U5GnVkn0Ax3XP3NnPCwwc1AzdVV9JkePfMjwWg@mail.gmail.com>
Subject: Re: git, monorepos, and access control
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John.Coiner@amd.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 5, 2018 at 9:46 PM Derrick Stolee <stolee@gmail.com> wrote:
> This directory-level security is not a goal for VFS for Git, and I don't
> see itbecoming a priority as it breaks a number of design decisions we
> made in our object storage and communication models.
>
> The best I can think about when considering Git as an approach would be
> to use submodules for your security-related content, and then have server-
> side security for access to those repos. Of course, submodules are not
> supported in VFS for Git, either.

Another option is builtin per-blob encryption (maybe with just
clean/smudge filter), then access control will be about obtaining the
decryption key (*) and we don't break object storage and
communication. Of course pack delta compression becomes absolutely
useless. But that is perhaps an acceptable trade off.

(*) Git will not cache the key in any shape or form. Whenever it needs
to deflate an encrypted blob, it asks for the key from a separate
daemon. This guy handles all the access control.

> The Gerrit service has _branch_ level security, which is related to the
> reachability questions that a directory security would need. However,
> the problem is quite different. Gerrit does have a lot of experience in
> dealing with submodules, though, so that's probably a good place to
> start.
>
> Thanks,
> -Stolee
-- 
Duy
