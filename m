Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BD6720248
	for <e@80x24.org>; Thu,  7 Mar 2019 10:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfCGKVI (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 05:21:08 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:34371 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfCGKVI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 05:21:08 -0500
Received: by mail-it1-f182.google.com with SMTP id d125so7567086ith.1
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9hFLJ8h85PIEyWsVuCpsA14P82xP1eoszaUULSFSOo=;
        b=WVy7aHGtGlwkUvav4tqskMF0UBi5sfsrtbTpGjXa/X4Qp+yxqtBWxPmYw5RDEZE+FD
         swnXYYoV4HuO6R9lPW3vylasdeTjHMF5BsNZX2rKvT0ubcB/LPkgiynyrkGF667AYE8j
         eXC8icX2ahv9GbiJofVvpne5dSzaqt2vV9IuEIFCJridmSms0uecrVbzL5CkZtrNMINd
         3lMFQP9lbV9bVixDswunFO4xGt2stNil2cYHD56aP1+mtgdsf0cHECKh9Ge6kexxJWog
         FPdpbps4fHkdkXqO3FjsQoBrWoPbMqTgJYWPeTaI40PNtAgYlJZgjcoQrDVFjkP0Ivac
         +rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9hFLJ8h85PIEyWsVuCpsA14P82xP1eoszaUULSFSOo=;
        b=E3SayYWiGRtmpGedmqYsyC4LKEoOhgdNTxA5Fvs6Q4U8CSdOq/Yk4rKgmawCnqHQrD
         ULqf+zHdJvfmxiYT6vD3We3+WLUgjdod8QIXOI23buVS5bGa2LvXRoYzr9Po4Ay3aIvS
         5srzMbK8/aahskm+YeMq0MkkH8wMwFJEmePfVTZXP2bGhsSTTTJzLPKQjchZ8RJlbwKY
         nRAdedTBoePNm6ThHh6Jpglsd+j9OFrDSnpFz9v7L3dt1O22poHauXet5skyNzJe5TsO
         EbNeZZ15d1V+f2qC467LIdC9CSrbDbUd7tpAlubZFZJP8HHhssFrw7MnKi0eD8HM0dy/
         McCg==
X-Gm-Message-State: APjAAAUBkAaVwhJEB47LeuCRhIZdaPyaXSmtRcRuJBdLTMSODozx6Pzd
        n8C9Pj93fJRl/hfnRIo81nczNh4tNIGIDexJRV4=
X-Google-Smtp-Source: APXvYqxwxgA25h/xKKVWfEKyKM4TmsqO4kHCgbhexv87FPhnb+QU+2sL2wjoxWvwuRersetyRfNqkD5i774zLnwNM8s=
X-Received: by 2002:a24:7542:: with SMTP id y63mr4839876itc.70.1551954067115;
 Thu, 07 Mar 2019 02:21:07 -0800 (PST)
MIME-Version: 1.0
References: <f6e197f2-886a-5e82-7fc4-c53737dd66cc@gmail.com>
 <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com> <CACsJy8CrSGQt=_RK8cwc3AW_+gfGLf_M5UKAmjMZrm43Qu3Z8Q@mail.gmail.com>
In-Reply-To: <CACsJy8CrSGQt=_RK8cwc3AW_+gfGLf_M5UKAmjMZrm43Qu3Z8Q@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 7 Mar 2019 17:20:40 +0700
Message-ID: <CACsJy8Dt9eky51g_hrakGdMHks2mwCEn9uGFNkPO249H-s0+2A@mail.gmail.com>
Subject: Re: [BUG] worktree local refs weirdness
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 7, 2019 at 4:46 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Mar 7, 2019 at 4:38 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> >
> > On 06/03/2019 15:57, Phillip Wood wrote:
> > > When it is run in a worktree 'git for-each-ref' only seems to show refs
> > > under refs/rewritten if that directory also exists under $GIT_COMMON_DIR
> > > even though they are local to the worktree.
> > >
> > > Initially I thought this was due to $GIT_COMMON_DIR pointing to a bare
> > > repo, but that is not the case. However while writing a test case which
> > > cloned to a bare repo I noticed it was listing a ref for the HEAD of a
> > > worktree in the repo I had cloned from, not the clone itself.
> >
> > Ignore that last paragraph, it's just showing the branch that got
> > created when the worktree was created. The last part of the script is
> > redundant, I've updated it below
>
> Thanks for the test script. I could reproduce it and I think I see the
> problem (update-ref creates per-worktree refs even though
> refs/rewritten should be per-repo). Working on it...

My mistake. refs/rewritten is per-worktree, but the ref iteration code
has a bug. The fix should come soon.
-- 
Duy
