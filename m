Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9351FE4E
	for <e@80x24.org>; Mon, 27 Jun 2016 23:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbcF0XLg (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 19:11:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34046 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbcF0XLf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2016 19:11:35 -0400
Received: by mail-io0-f193.google.com with SMTP id 100so334379ioh.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 16:11:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=gtuzsLyDDEKdCJqW6qWvCa8zHiEOpF/4g6g+qYAUJWw=;
        b=jg4ObmJ8PD0StCsNuQG032YuUY/yn9qu1gLvQXdoZ8g2EQVclA4iduGBdDU+iHK0bM
         8MpSw41rRSVIDdwm3POAIB0vNE8VbwpqhW5irOWcRCaIy8lxOEmg/4xRcygFZAIfFxsD
         Fp9mW9jaD1iSlqc/vAp91TdoBgK4QUtM5g2uEjoVnd2YUG/wCJUfJq3P1sLd838KrX3I
         5ncYh2Ff8lv5Z21fb0H2OCDq2MgGQvb7qFk49+YavnDSZSeD1FSzHeiRHk3wZyMZYZGt
         0ZaogMo7UD7OlWhH7zdhqr0zuJekRUzxfpS8tIy61+iyEyh5O0c1tx/p1PJzyBrNdqAa
         g3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=gtuzsLyDDEKdCJqW6qWvCa8zHiEOpF/4g6g+qYAUJWw=;
        b=gwWXqzgLumSYAsRMZbu/TPtCyWRqUM/7+83B2dsFHVWMiU+0L+lr4vknfXenRUZuxr
         e8Gr6X1+0kwanpIGo/ymVH0VVB3rzCDgv0/D5LSTYP9FC8oO6Zb525RvP8R4FTqwcvyT
         GpnlhUIUjeDLqVR7Dh3qMx012w3um/DQSJFEVI6a7p4SCCijyNcdDPHv1MsuQIG9Ph7f
         qyNgRFCB2y523KaA3YMIzbUMgaNoEwG2+3VfVnZ0i9Gi/4E9fnFBpjOPSdpNBCp2vcQJ
         rH7WkJ5SuBO3tOjFgnoWc70shaQoq3rmeDPkXrnAKuH1yOXfD2lZTc/w4ceWZFog1+ZY
         UmHg==
X-Gm-Message-State: ALyK8tJwLHBYfYYkzT1+YBDLFxE6+T779FR1S0DLuzLXK1xl8QirJYQvimSg9rcsJTRR7bXHhSuFOLeEWQOEdg==
X-Received: by 10.107.47.41 with SMTP id j41mr313160ioo.168.1467069095070;
 Mon, 27 Jun 2016 16:11:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Mon, 27 Jun 2016 16:11:34 -0700 (PDT)
In-Reply-To: <A2F194FC-281D-44DF-88CA-E0B8221A3E68@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org>
 <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
 <CAPig+cRNUZZBw=F-Q2f3Ehc-8T2iBp4kvDusNRGv4ea5nihQVQ@mail.gmail.com> <A2F194FC-281D-44DF-88CA-E0B8221A3E68@brennie.ca>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Mon, 27 Jun 2016 19:11:34 -0400
X-Google-Sender-Auth: gh51K7lYfzOTKegClt9O_a5Nw78
Message-ID: <CAPig+cSEwib1iFyWE5h8-qTbsAC+zsaSDSYQnv6otWoOOjWAeA@mail.gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
To:	Barret Rennie <barret@brennie.ca>
Cc:	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 1:52 AM, Barret Rennie <barret@brennie.ca> wrote:
> On Jun 26, 2016, at 5:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> One thing which hasn't been explained, and about which I'm still
>> confused even after reading this thread in its entirety, is what
>> Barret means when he says that he "breaks" his worktrees. What is the
>> nature of this breakage? Depending upon that answer, would "git
>> rev-parse --git-dir" be sufficient for your needs? Or, would "git
>> worktree list" be able to give you the desired information? (As
>> envisioned, "git worktree list" was intended to provide much more
>> information than it currently does, such as the .git/worktree dir
>> name, and such an enhancement might be welcome.)
>
> My worktree breakages are usually the result of my reorganizing my projects,
> usually because a branch changes name (for example, if branch release-1 gets
> pushed back to release-2). Then I go and rename all my directories and git
> gets unhappy and I have to manually fix them or re-create the worktrees.

Quoting from your earlier email justifying why you consider this patch
desirable:

    ...when I break my worktrees and can’t figure out
    which worktree dir is the one I’ve broken.

But, doesn't "git rev-parse --git-dir" from within a "broken" worktree
answer that question? Or, wouldn't an enhanced "git worktree list"
answer the question from the opposite side?

> Having `git worktree list` give the worktree directory would be very useful,
> but I still would like the ability to change the name of a worktree.

My knee-jerk reaction is that the directory name under .git/worktrees
is an implementation detail (and could easily have been an arbitrary
ID, such as .git/worktrees/7ba84ec0) and rather than exposing it
further and encouraging people to muck around in it manually, we
should be providing higher-level solutions so that they don't have to.

Even without the higher-level solutions, it seems like "git rev-parse
--git-dir" should satisfy your needs, and if someone enhances "git
worktree list" to provide the additional worktree tag name (as
envisioned all along), then you'd likewise have sufficient information
to "fix" your worktrees.

As an example of higher-level solutions, Duy's "git worktree move"
series[1] would, I think, be exactly what you need to avoid such
breakage in the first place (assuming you can retrain your fingers or
fix your scripts, if they are doing the worktree renaming).

I don't know how Duy and Junio feel about it, but my response to this
patch and what it wants to accomplish (even with Junio's input) is
fairly negative. I'd much rather see more missing high-level worktree
features implemented rather than see patches further exposing
git-worktree's internals.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/298194
