Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32F5C6FA99
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 05:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCJFqR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 00:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCJFqP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 00:46:15 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5AF8A48
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 21:46:14 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c18so4679046qte.5
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 21:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678427173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whUpoLRMgu0RogFEB237wU0shlAnV26GWMkC3gMjbHo=;
        b=XgJojiefLSImjLAmvUizu2Iz75Ou3HoaH7z5oah79ryiF9WDDasRcmBmTxYbDV9UDY
         p1VYVWIAlLkHoDbsSTlaPCqYt7O9ztXWrmkMFVyRF7IQslTQjsOC7RdPK3grSx1qnbOQ
         WYzSzmkhhwIHwxAHIGXYX1k/Tan+LSowxJ31uR4jih8m0tIuNeXCY4qKWVOJaaLJYV1a
         2OicFTJs/bdfxv8B46oZgE5ldAVSCkKNAT5tVu69tPDBlGkPhr4ubArNwLqVdLNDTN4f
         8rsV58y65V71aC5bXWLo/QEzYGw6G0/UrgzuzdhHq85s3gmZByKGRvoJDAVJX+7esxG3
         N9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678427173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whUpoLRMgu0RogFEB237wU0shlAnV26GWMkC3gMjbHo=;
        b=7R2PzH0O7v3lVeTrGO+lgarAfqtMa0Q3KwojU5ZJatu+A8sz5OYOkaBD8QSAKRjt3H
         7GKTYpH1kHxvDqcfHTwKIg6co5El+k0CZvGmoIufaMWxXMVRuc3CmUok+o7BB8foXL/a
         PsCay2xvRVNkUruu43gD71vYuT9FhUDbGVOqGi/w47CFVCc7IMZay0CZ4YGzat+EMICk
         KtosBFc0DA6wWC8Ly1KE8TubNPXmE4RahM26lhs0/o325xGAsczoWkCk/pBR6oekOlSu
         MzHRHFuAh4eHKxpfx/oxQxnfgcfXmRQqOk6Uucy9kyBdo6l2upP5p7+KaWRX0qOFdbEs
         bUJg==
X-Gm-Message-State: AO0yUKWhDeYBVLvleMwRavNGU6FoSY/n//tXajWi/q/sjBwU+u1Rd5v7
        0FQzVqprFUP8BnXrGQhIhTwUfkbvxlVURaJjKok=
X-Google-Smtp-Source: AK7set+ctWG54uNwEOv1EPsU1w8IDzLFzHSEljTK2AWHVk6Qs8g4vqCgUkIVeLvhE9mNjDLkvaoIVWaDpQhKkbhCCWc=
X-Received: by 2002:ac8:20b:0:b0:3bf:c315:44df with SMTP id
 k11-20020ac8020b000000b003bfc31544dfmr7391746qtg.12.1678427173191; Thu, 09
 Mar 2023 21:46:13 -0800 (PST)
MIME-Version: 1.0
References: <CAABMjtGXGZtUnU+8KgEccNeLXRJmWnE5f24BMG8ysbZKfT-ctQ@mail.gmail.com>
 <7097d1d6-00a1-2a82-1923-610d41f4053f@github.com>
In-Reply-To: <7097d1d6-00a1-2a82-1923-610d41f4053f@github.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Fri, 10 Mar 2023 11:46:02 +0600
Message-ID: <CAABMjtHmf8DPNbRrEfYK03JiFj506USeeTQjfApbwp-5TVpHQA@mail.gmail.com>
Subject: Re: [GSoC23] Working on project Idea from SOC 2011
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 9, 2023 at 8:26=E2=80=AFPM Derrick Stolee <derrickstolee@github=
.com> wrote:
>
> On 3/9/23 7:07 AM, Khalid Masum wrote:
> > There is this SOC 2011 idea named "Resumable clone" here:
> >
> > https://archive.kernel.org/oldwiki/git.wiki.kernel.org/index.php/SoC201=
1Ideas.html
> >
> > ...
> > Currently cloning a remote repository has to be done in one session.
> > If the process fails or is aborted for any reason any already downloade=
d
> > data is lost and one has to start from scratch.
>
> > Goal: Allow Git to resume a cloning process that
> > has been aborted for any reason.
> > Languages: C
>
> "for any reason" is going to be pretty difficult.
>
> One direction that is relatively new in the Git project
> (much newer than that project idea) is the bundle URI
> standard, allowed by "git clone --bundle-uri=3D<X>". It
> helps bootstrap clones by fetching bundle files and using
> them to populate the object directory before finishing
> the clone with an incremental fetch to the origin server.
>
> Since the bundles are expected to be precomputed files,
> it is much easier to use standard HTTP range queries to
> download only the "missing" portion of the file from the
> bundle server.
>
> I think one thing that would need to change on the Git
> client is the location of the temporary file being used
> to store the bundle as it is downloaded. It currently
> uses a random name, but if the name was a hash of the
> URL, then it would be predictable and could restart the
> download if the 'git clone' process was halted for any
> reason. (Resuming a download due to a network error
> noticed in-process is possibly simpler.)
>
> This might be a more focused approach that is more
> likely to have progress in a GSoC project.
>
> That said, I don't have the capacity to be a mentor,
> but I thought it worth mentioning this variant of the
> project.
>
> Thanks,
> -Stolee

Thanks for your insight. I will write a proposal based on this and
hopefully get a mentor, while trying to understand how git bundle
cloning works.

thanks,
  -- Khalid Masum
