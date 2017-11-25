Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DF120954
	for <e@80x24.org>; Sat, 25 Nov 2017 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdKYVr0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 16:47:26 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45818 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751753AbdKYVrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 16:47:25 -0500
Received: by mail-wr0-f193.google.com with SMTP id a63so23057252wrc.12
        for <git@vger.kernel.org>; Sat, 25 Nov 2017 13:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fphEc1AaHydvMs2InfsGvCSbzXIJ8/euRYBLYPn/CxQ=;
        b=LH02VS8r4lk/YXnr8sw4SKe4/xxWZCPWKEoJawoClXVGCHvcmyXC2GpIaobU2TeC/m
         AV+Das7hHYa+FbVafFA7FVxXGLPxBGQIUkLJoBs4QRgdD9W+QKY/zxaCjByJRngf9GiW
         i7drcZG9BfP1gHFtn6VWwZZ8pFgVIvcuqqvfo+x1uMhKECDImpmBInqxYZAbXF7Ks5Gp
         WxM0Gj22BIw6G6b4Qjig3pBImn7gXTUjKPvFCoBMXTeFR8EKf0JgDCnwx4uv9h/tpzVV
         s/SItuUR0h0M6CMXpMbZtAlIH0PT9ERohS4PJ9DAMkX3yEQCnH+moY6Vl3H0X50DaW2L
         ToHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fphEc1AaHydvMs2InfsGvCSbzXIJ8/euRYBLYPn/CxQ=;
        b=jjrUAbLU/ItXzHkAelfDO4ihYCTGPkdswNoofjLMEiXTMgxNXM/35zZvDdD/BQYwQe
         31/ch0pooX5oid8tDhitvqBj8vWbG5ETvdQOuS2pXLCBR5twxicpLxwsFDX9U3c940UQ
         kQQK8PSto5vmMOS+piy421qJBnJ810LSkxV2M4kcB6DXfc7j79qTuyb1J04SB8S4+LLI
         2tWoETJWDHALWEEGDltvF10bW3EtAdpeOW4bgrZkvVEpldT0yp6pnOOjoGuT+/ceIrED
         HJL49Ja7u8qZzxfJ8g1JfoM5uzT0HqDTuChY3BZwmBVf8SFAxgFfiMiDSzF7R5OxGxSV
         SS1Q==
X-Gm-Message-State: AJaThX59jTtFc7hwSHNfHKR72E86UQKhSQNQNYXBLXsODlK5jDxJWKkK
        Z+TmqUcPBWcVou4LL5m1GXlgglMp
X-Google-Smtp-Source: AGs4zMZgZUStBnLsESzkY58qvmbqhQIdzYIk8CasDjg07e5xJUNVhZki3+HU53MIkjAoHxBe+NKPkQ==
X-Received: by 10.223.173.4 with SMTP id p4mr25760826wrc.209.1511646444523;
        Sat, 25 Nov 2017 13:47:24 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y15sm50059867wrc.96.2017.11.25.13.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Nov 2017 13:47:23 -0800 (PST)
Date:   Sat, 25 Nov 2017 21:48:56 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Paul Smith' <paul@mad-scientist.net>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
Message-ID: <20171125214856.GB4344@hank>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
 <20171122223020.2780-5-t.gummerer@gmail.com>
 <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
 <20171125175010.GB14993@hank>
 <1511634365.2847.211.camel@mad-scientist.net>
 <20171125200615.GA4344@hank>
 <004401d3662d$8f099e10$ad1cda30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004401d3662d$8f099e10$ad1cda30$@nexbridge.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/25, Randall S. Becker wrote:
> On November 25, 2017 3:06 PM Thomas Gummerer wrote:
> <big snip>
> >however we currently document one behaviour, which I would like to change
> >(I usually have branches
> >without a / in that I want to look at) we currently document one behaviour,
> >which I'd like to change.  So 
> >in that case we are a bit worried about backwards compatibility, and how
> >this will affect current users
> >that have a certain expectation of how the command is supposed to work,
> >hence the discussion of
> >whether to hide the new behaviour behind a flag or not.
> 
> >Either way, if we do put the behaviour behind a flag, I'll also add a
> >configuration variable, which can
> >be set to enable the new behaviour so one doesn't have to type out the flag
> >all the time.
> 
> To be consistent with other commands, you could put path after -- and the
> ambiguity with refs containing '/' goes away, as refs before the -- would
> always be considered refs while after you have paths.
>
> What I don't like is the current add syntax of:
> git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>]
> <path> [<branch>]
> 
> where the path-spec precedes branch making things a bit icky. It might be
> better to have an alternate syntax of:
> 
> git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>]
> <path> [<branch>]
> git worktree add [-f] [--detach] [--checkout] [--lock] [-b <new-branch>]
> [<branch>] -- <path>

Hmm I don't think there is any ambiguity there, the first argument
always needs to be a path, and the second one is always a commit-ish.
So this way there is no disambiguation needed.

I'm not convinced the alternative syntax would buy us much, at least
not in the context of what this series is trying to do.

> But since we only have one path, that may be redundant. Just a thought, as
> -- avoids a lot of interpretation evils. While we're here, I wonder whether
> <branch> should be changed to <ref-spec> for more general use. Consider
> release identifiers using tags, and using the tag instead of branch to
> define commit on which the worktree is based.

'git worktree add' can already take a commit-ish, it's just not
documented that way.  I'll add a patch updating the documentation to
the series.

> Cheers,
> Randall
> 
> -- Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)/NonStop(211288444200000000) 
> -- In my real life, I talk too much.
> 
> 
> 
> 
> 
