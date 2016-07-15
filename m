Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A96DD20195
	for <e@80x24.org>; Fri, 15 Jul 2016 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbcGOPrP (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 11:47:15 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:35318 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbcGOPrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 11:47:13 -0400
Received: by mail-io0-f172.google.com with SMTP id m101so107526991ioi.2
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 08:47:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F/5JIv8q4w6Owm4ruRioBdhNNjrUEPf+pSx0GqEi0dE=;
        b=uN/A7flZr102Epk3a4ie0O72TPEVRpXfCHVsQLJHRcjGwm2GOxlVIgXjEUzrVjKzWW
         RmlaLC81J+NDPRssSDk0xRowXtVc/vB7/zgXgLfQKmlGfjmbyFekO79TM1Sa0ThXx3R1
         U1V1ythxfZh6+pRYMRCS3fyRbzymY22ykOpnzNKFeySwiYd5W8s+xwidzdVr9tPqRIbO
         wm5Yp9yuyxa3kVmfkSDXlPoSnEo96tSWXz92Bf4lswTjkAYDoDo8wC2IVmciPB5UmtJE
         hi6wy63ziYC6lAGjT3Mb7SJGnF2l90nQlzUH/uSM2w8FRORSHA0VhBdyiICrajwpAg1U
         QH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F/5JIv8q4w6Owm4ruRioBdhNNjrUEPf+pSx0GqEi0dE=;
        b=e0fM9EN1mkmhVDZ/K1805Z2A8id/aEUEIv8onsP+fDnZO2MQLRrnkis2vptvfFhgJK
         /fI+aTa6btd5V1RBv1S0+GXKj6b/lRBrLm8+kgdsYopfFG42XkG4mUE0BG3jobNj9xkQ
         MqaoNvsllPeW7OHZj/Whr+wNjLABdOcNUkvzrbkADt6KQpfW5LSNUUEMJXdvEsPe2FK3
         NgnNrvUFy76ipd50yghiKsPdEDlyM0YslMj+re1wdSgyMKRNK5nfROXYUfREScHKBBYK
         cadXCUkVUAzvq78h8ZQHPhZIqoJGzfaDXjyVGLRMp5fzvJNPhYUG+2Vf0ZrrGqgjw/WE
         YzyQ==
X-Gm-Message-State: ALyK8tKHNBcrBc38dxCDieOFXcyRocrMZSmsyaKGKKQr7DyibX4nbCrfJAqcodcU6Cs/SGbTdxGIbCkXbzi+Ig==
X-Received: by 10.107.8.140 with SMTP id h12mr22581167ioi.95.1468597631987;
 Fri, 15 Jul 2016 08:47:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 15 Jul 2016 08:46:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607132055090.6426@virtualbox>
References: <alpine.DEB.2.20.1607090928500.6426@virtualbox>
 <20160709140931.GA3185@x> <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
 <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox> <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607121243470.6426@virtualbox> <20160712152646.GF613@sigill.intra.peff.net>
 <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
 <20160712155141.GA5967@sigill.intra.peff.net> <CACsJy8BfXSvKM3=rRCDYzR=rpLRi+FBYs4r1WGXFisq0Esk00w@mail.gmail.com>
 <alpine.DEB.2.20.1607131004410.6426@virtualbox> <CACsJy8BXOrGobyLGAKf=5Dv_4h_Keon9ktZ3B8Vr85qHOY0+mA@mail.gmail.com>
 <alpine.DEB.2.20.1607132055090.6426@virtualbox>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 15 Jul 2016 17:46:42 +0200
Message-ID: <CACsJy8At1FLhpcbtaYe-=Fpf4d5AZLKxr8rMoV62ZY+Tk=68Cw@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 13, 2016 at 8:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> No.
>
> Oh? So you do not see that we are already heading into serious trouble
> ourselves?

I do see problems, that have solutions. But I have not yet seen that
we are heading to a dead end.

>> I prefer we have a single interface for dealing with _any_ worktree.
>
> I agree. So far, I did not see an interface, though, but the idea that we
> should somehow fake things so that there does not *have* to be an
> interface.

Calling it "fake" is a bit too strong. I'd call it an abstraction. We
have always had the one-repo/one-worktree relationship, now we're
breaking that assumption. Some operations work at repo level and
require a "repo view" while others work at worktree level. We do it in
a way that a program designed with these separate views can still work
correctly in the traditional one-worktree-one-repo configuration,
where both views are the same.

 - For accessing data in $GIT_DIR, you do not peek directly into it
any more. You use "git rev-parse --git-path" to retrieve a path in
$GIT_DIR (instead of doing `git rev-parse --git-dir`/some/path), then
you can do something about it. This is the equivalent of git_path() at
C level.

 - We have a set of rules to define what part of $GIT_DIR is shared
and what is not. When you add new stuff and follow this rule, it will
work in single or multiple worktree config. So far pretty much every
unknown thing is per-worktree. $GIT_DIR/common will be the shared
place for external scripts, soon.

 - It's the same thing for refs: we may reserve a portion of it for
per-worktree, and the rest is shared.

 - We provide means for one worktree to access data of any other
worktree if needed (e.g. $GIT_COMMON_DIR, or the new ref storage API)

 - Because the majority of operations is per-worktree, that has been
the default view so far when working in multiple worktrees. Repo-level
operations such as git-gc, rev-list --all, fsck... need to "switch
view". I missed this and this seemed to cause big problem for you. My
only excuse is, this is an experimental feature.

The idea of single config file with separate "worktree namespace" (eg.
core.worktree vs worktree.<abc>.worktree) was shot down because it
would result in a lot of changes. And it's the same thing why we start
to split views this way (and make default view "per-worktree") instead
of rewriting every piece of code to deal with multiple worktrees
explicitly (by carrying the worktree id everywhere).

There are two loose ends that are on my mind, but I have not clear
ideas yet: the incorporation of ref namespace and odb alternates.
Imagine when you you submodules, all submodule repos (refs and odb)
can be stored in the top-level .git repo, separated by namespaces.
After all a repo is just a container, of a bunch of refs. This make it
much easier to peek into another submodule from a supermodule, and
makes it safer to "rm -r a-submodule" when you get mad at something.

I hope this shows that it is less of a fake thing.
-- 
Duy
