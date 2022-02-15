Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A5C4332F
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 22:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244624AbiBOWk6 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 15 Feb 2022 17:40:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbiBOWk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 17:40:57 -0500
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A80C1160
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:40:47 -0800 (PST)
Received: by mail-pl1-f173.google.com with SMTP id i10so443106plr.2
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 14:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRShthG0Toz0gPRtGPXxtZGkfEQA3xqjFypkHUDebsw=;
        b=YwFHgyKeBSDAgDnLU/Q3thNSiiraWu6z4ISFJAMtYE+h0Me5P7lrBMSMN4WNe33T7N
         ML4tc+3uNdnkd2Y4w/RhaHz+EIr9nUql6jIiq8Kv6TqHznCGrTwqGmqmrofwiemik0YT
         stRzhHLz3yEScu3LdritxLJPPwwRW/uy5C3KdGjGVYx/noxOsRpME36mx4nDqzNjz6hY
         SOq+lCFCvF2f5ojAhKC5qVuwqox1zSHLnAtwZg2itfDaxBghbq5arSdcmG4uR/yVMhKg
         xjmqRgkQTrhdYibj/j96TzBguHS1MSkX0k6biRIHDUQa3xSF0eG+tBQ+SSQmKwRj9CpE
         T6UQ==
X-Gm-Message-State: AOAM531ajFbE1zETldb8YSZ/2u4qOJYQTb+KOG2wWTnrlklp8KF2wLgY
        EXizODpe8GTywhz58+R9+N869KFxF/8MrKnbb0I=
X-Google-Smtp-Source: ABdhPJxRvR1PonY304WoyTxbc1vI7iFG4IFjfSK8PNAMw7odriG8fFoVHSUlWko5k6Ctb4k0+HXpU8zjz0QPJTq+Sbg=
X-Received: by 2002:a17:90b:1b11:: with SMTP id nu17mr1180434pjb.104.1644964846341;
 Tue, 15 Feb 2022 14:40:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6ez60l8.fsf@gitster.g> <f36712f5-28bd-42d7-3ea1-f4afa328be07@gmail.com>
 <xmqqfsope48k.fsf@gitster.g>
In-Reply-To: <xmqqfsope48k.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 15 Feb 2022 17:40:35 -0500
Message-ID: <CAPig+cR+n=LQg5AJQgGQXuYStN90-jExWnE45sS1EXo+O8dQgQ@mail.gmail.com>
Subject: Re: ds/sparse-checkout-requires-per-worktree-config (was Re: What's
 cooking in git.git (Feb 2022, #02; Wed, 9))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 11:51 AM Junio C Hamano <gitster@pobox.com> wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> > On 2/9/2022 7:12 PM, Junio C Hamano wrote:
> >> * ds/sparse-checkout-requires-per-worktree-config (2022-02-08) 6 commits
> >>  Will merge to 'next'?
> >
> > You and I have had a good discussion about the latest version. I
> > think we've mostly landed on finding ways to improve documentation
> > in other ways (including the patch you submitted), but here are
> > the things that I see as still outstanding:
>
> With the maintainer hat on, I agree that all are good points.  From
> a reviewer's point of view, I do not care too deeply about 1 or 2
> myself though.

Agreed.

> > 0. Eric mentioned earlier that he was interested in looking again,
> >    but has not signaled that his review is complete.

I have now read through the most recent version and left one or two
minor comments, but probably nothing actionable.

> > 1. You and Eric disagree about the use of "worktree" and "working
> >    tree" in the documentation. I could revert the change to these
> >    docs from v5 to v6.

I wouldn't go so far as to characterize it as a disagreement. In my
review, I only pointed out that this series was introducing some new
instances of inconsistency which some earlier efforts (started by
Michael Haggerty) had eliminated. As mentioned in [2], I personally
prefer the term "worktree".

[1]: https://lore.kernel.org/git/CAPig+cS-3CxxyPGcy_vkeN_WYTRo1b-ZhJNdPy8ARZSNKkF1Xg@mail.gmail.com/
[2]: https://lore.kernel.org/git/CAPig+cSY7E_XQC1gHzDJxoDGGmgWDmNz9Ys=CwbhLkCt+DQf-A@mail.gmail.com/

> > 2. You mention that the changes in config.c could be split into
> >    two (first, create repo_config_set_multivar_gently() and then
> >    create repo_config_set_worktree_gently()).
> >
> > 3. Jean-Noël noticed an improvement to reduce work on translators.
> >    The diff below could be squashed into patch 5 OR I could submit
> >    it as a forward fix.
