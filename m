Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C86DD1FBB0
	for <e@80x24.org>; Fri, 25 Nov 2016 13:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbcKYNpc (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Nov 2016 08:45:32 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36861 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754445AbcKYNpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2016 08:45:25 -0500
Received: by mail-yw0-f193.google.com with SMTP id r204so3460717ywb.3
        for <git@vger.kernel.org>; Fri, 25 Nov 2016 05:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kLQEcCgMFPoQUubbmxIZlsVEB/B68M7ZC/7SmSa5UvE=;
        b=cqgKfDxAFXB1ErfvhhW4m/Lu6/iQAUJRbOMVdOjy+yX+LKogKhcz6MwJfl7l1hD5ZZ
         7pzSyDoL7V72EI6H4GLK2JCg59xayoOxHAuhaGgY6RgA2M6uyvxmVkIsty04/VrkawW/
         U8ZvnjGA+qvi5vMnw5A0Z83VUwxj3NggYnBaVTl07p1cpJ/ySL7UL63oIcfNgvLn9x1u
         v/Livmpfst4OUOpXmmgvnPrnBPP8o/NyiLG1cn5KBLFvLQzdsjPbhb+qdKRN+oSISrcf
         nTsVVyOvAO1dgxDncgB+KSi3QxmkySpPDAf5bn4LPH6rUhfBNZFXnmwJ6DtPQUzIKIgL
         MP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kLQEcCgMFPoQUubbmxIZlsVEB/B68M7ZC/7SmSa5UvE=;
        b=BzmflplWENq/79oZVlIFzjpk56awyVBJcqkdGWmFu9L9m8tPSO2avS9WhvJq/VItub
         8pZpkYILn9TAI2y8/gjNP5DGN9/j75FvO2AC1sR1tW0WvQd0Yc2L+dc1B7C2GKREprbR
         Qotnm4HHbg9am5qupRlhuAtMElhlqhadq6m8WMHJ/OScEXLa6+5ryAywdBpjfwdWFB+Y
         ms0fzx0TyeNHwH7uwiRWSiRi3ofo09sNsLmuHDwJGcHVRYjZb+LdfJGcXYmdfA64O2l1
         fy37blVaZI5/dGkixaBuuwKdOGflap2Of/p84ddGkNwW8c+DtxxibBbJIxugvUs2mgQV
         mCVA==
X-Gm-Message-State: AKaTC00B/0TkbMvsMaa560woR0NaBSEF8fAb04MsK1j1623xW9bCnYyzjsoPOFeiEHyVMYR6Kcv2vzjxClUbaA==
X-Received: by 10.13.239.198 with SMTP id y189mr9325180ywe.202.1480081524080;
 Fri, 25 Nov 2016 05:45:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.211.7 with HTTP; Fri, 25 Nov 2016 05:44:53 -0800 (PST)
In-Reply-To: <CACsJy8D+vyO0LF_A2Wym+PUg=HOTPyDe-1fVwv8zN797pL-rmw@mail.gmail.com>
References: <20161122100046.8341-1-pclouds@gmail.com> <xmqqbmx6nnpg.fsf@gitster.mtv.corp.google.com>
 <CACsJy8D+vyO0LF_A2Wym+PUg=HOTPyDe-1fVwv8zN797pL-rmw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 25 Nov 2016 20:44:53 +0700
Message-ID: <CACsJy8CpySQs07cfioOnoxoH1TALRePGbeVCc45ZqDr43519qQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Minor fixes on 'git worktree'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mike Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 25, 2016 at 7:24 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Adding the test for the failed parse_ref() is possible, I think. But
> since that function is destined to die, as I promised to use
> refs-provided api instead of rolling out a custom ref parser, and I'm
> going to have another hard look at refs subsystem for the
> gc-not-looking-at-worktree-refs problem, may I make another promise to
> add tests after this function is gone?

Never mind. I went ahead and made a test case anyway because why not.

But that's not worth an email. An interesting thing maybe worth
sharing is, if HEAD is broken (the only reason we would fail to create
"struct worktree" for main worktree), then "git worktree list" from
main worktree would fail too, because repo setup code fails to parse
HEAD as well and die(). That makes the "always show main worktree"
patch useless, since we won't get far enough to execute
get_worktrees() in the first place. However, you can still do "git
worktree list" from a linked worktree, gitdir setup code will not stop
you (how can it). And the patch is still needed.
-- 
Duy
