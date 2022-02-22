Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E507BC433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 23:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiBVXwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 18:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiBVXwl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 18:52:41 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE330F5A
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 15:52:14 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so1086858pjw.5
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 15:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tyBqE7H4RLCVrgECQ9YEbcWR65adTTUHAb82dSA4vR0=;
        b=PnvVIXEegCiIKE8FuX4Gzi2Hf69+xu1j/AoWULtiJy61PetdvYfOpbckfOIHID+RI4
         gab5+lYMPdAEKwfCDHsMhH630VQPApTzM4uDagZLeePHZNeOHh0RAPi8EBy2iAiQfp4u
         ZMvJ2+s69ZHbhCwDuzH1BDrvZpx1g3RwiuP1kFtJ/CH+kZeA/jS5kq70AtkLadXSRKwk
         zklhi2O2TiMVgJXsXj0WnWYS4tcoZhy5rWTfEkeGzk3A9pGwD1doJj+m53oe0lMfmvDL
         Lil3CTdxYBDoXvabkVl0Ml1OR0ZPBV7P1PUosod4ZbOh7Z332R0+N9Ih0CdxcLbTY1VK
         E2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyBqE7H4RLCVrgECQ9YEbcWR65adTTUHAb82dSA4vR0=;
        b=MnQLXS7wqAAXpTv6aFvAc34AR7MYe+xTlBEz6VguUE9PPv9uwiY1sNzoIucLiayQQZ
         XooyIpREdxW4tMoBAa8uiKyxGRS5ek45MHYQbmccpmd6qeuql5r3LXQdoryYIKEhAv7k
         OyK1o8VPe7texLJHYqU/T4tC9lYUWR0QVVnQYltemHNd/U7RwTgLptteypNDWNTyJshp
         01j3KaJKnx3mecI6oj+1zmY4GXlUodXGTQWBk87+Ja5WUT4kQglmixRcDbPR8AaYOD4r
         reP1gGEvRFjBZW7Qpo7nmZlrmIrG4pQGjpqT+28Ujc8y6Oi4UxzPu6XNTlUa7qXwQVzK
         l1oQ==
X-Gm-Message-State: AOAM532b+tyj4cunSs56o+nt8CV8Vpno6gVKgLCcayFB/7ktoV3RQInB
        F3YDauiIjZqlJV0twijpm0gRkIzUmgc=
X-Google-Smtp-Source: ABdhPJy3wpciSVfFF47WXFaF4sc/L91HLDNGUdWE1JObRwTZpIVp3zcLldnNAlkSWMa0J4C4lu4Kjg==
X-Received: by 2002:a17:902:6b81:b0:14f:37e1:3940 with SMTP id p1-20020a1709026b8100b0014f37e13940mr24879419plk.115.1645573933602;
        Tue, 22 Feb 2022 15:52:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:2ada:62da:c2a8:ce2c])
        by smtp.gmail.com with ESMTPSA id y191sm19126270pfb.78.2022.02.22.15.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 15:52:12 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:52:10 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: en/present-despite-skipped (Re: What's cooking in git.git (Feb
 2022, #05; Thu, 17))
Message-ID: <YhV3KruSTFYEDBAO@google.com>
References: <xmqqley93rkw.fsf@gitster.g>
 <YhBNgUFnujFGVcRo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhBNgUFnujFGVcRo@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>> * en/present-despite-skipped (2022-01-14) 6 commits
>>   (merged to 'next' on 2022-02-15 at 960873fdad)
>>  + Accelerate clear_skip_worktree_from_present_files() by caching
>>  + Update documentation related to sparsity and the skip-worktree bit
>>  + repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>>  + unpack-trees: fix accidental loss of user changes
>>  + t1011: add testcase demonstrating accidental loss of user modifications
>>  + Merge branch 'vd/sparse-clean-etc' into en/present-despite-skipped
>>
>>  In sparse-checkouts, files mis-marked as missing from the working tree
>>  could lead to later problems.  Such files were hard to discover, and
>>  harder to correct.  Automatically detecting and correcting the marking
>>  of such files has been added to avoid these problems.
>>
>>  Will merge to 'master'.
>>  cf. <20220204081336.3194538-1-newren@gmail.com>
>>  source: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
>
> I'd recommend holding off on merging to 'master' for now, until we
> figure out what to do about
> https://lore.kernel.org/git/YhBCsg2DCEd9FXjE@google.com/. Hopefully that
> won't take long.

Since as discussed there this isn't a regression for existing users of
git 'master', I see no reason to hold off on merging to 'master'.
Thanks for your patient help.

Sincerely,
Jonathan
