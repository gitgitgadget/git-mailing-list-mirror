Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 369EB1FAF4
	for <e@80x24.org>; Mon,  6 Feb 2017 04:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdBFEXQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 23:23:16 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:35118 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdBFEXP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 23:23:15 -0500
Received: by mail-io0-f172.google.com with SMTP id j18so57462509ioe.2
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Fc5seKR+D4yTICmJiODxHsj8i/Xru49EydArGWoxrEI=;
        b=IJzmAX46lh4GtnzIJl9AsFqjxO7XCxpr9CyYQ8K/AHQ6t8P8jbkgDRaKaMBhC4JL6q
         TDQwK/2iV7bSVyHVpYdxyBmwv/I6xXmYNP3S4BJqiiHosenmiViDOIu1oWsqACif2Zi/
         3oDZ4EH8QCoJ/b/u8ZpEte8razjr0yPjCMbTExmugZDELs3xWUeZUjDLAvjhJa9T1UVC
         LnmVFSvJvKHX7vexGjEdYfXR8iyMxK7NFb3wgo3o6Y1cBIlCBYFY9UlYsqPbimS8pDOR
         MqWkC5uCzT3SucJ+wiAPoUssWr4UCpGIvOKOJff6UBWgo4mrFa/qTPUVcMSDo71H4YIs
         nGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Fc5seKR+D4yTICmJiODxHsj8i/Xru49EydArGWoxrEI=;
        b=cJDUWL4QHMeDxVMqo5LCwiX6xveAv8m1NXIp58FpnvmJjs49IzmQTeWxE1d+rhyCm1
         NrW6EoOHdr4ZNl4bk/XdjJA3FSVXQQump2y8sr6jECao6dQCXKhYbMy/US0+nV5G/AFD
         tNRh3Uk9Fvd7dt8sVwtSOExMFVNDgPsLRJAYsGmtP81f40f73roYMXT+J50qk/7PfGzy
         MOta1OVeavrOx5JEy6u/axpf3CAqUX0T6e/uN781hhmnuJtVnHdQdb27BDqhj1Qqz4Ha
         CGXNUXNsCr486323+mX2M2DfsDFc2oumh2xGieix85M6CYP2n9gMv05NaI9ju2lhKGQK
         T/9Q==
X-Gm-Message-State: AMke39lvEeacRpo0eMjBXm7lNYNad+X/bMajsugkRu9pA5x22MepAnSgDEBcuESnBUxJN6aS9GHakQIaNi9vLzyh
X-Received: by 10.107.16.14 with SMTP id y14mr5252710ioi.164.1486354994419;
 Sun, 05 Feb 2017 20:23:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Sun, 5 Feb 2017 20:23:13 -0800 (PST)
In-Reply-To: <xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
 <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
 <xmqqr33krtww.fsf@gitster.mtv.corp.google.com> <c872072a-4754-051d-81e7-1e2166560733@benjaminfuchs.de>
 <xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 5 Feb 2017 20:23:13 -0800
Message-ID: <CAGZ79kY_1ELUZ2wZwNbQ+HrDnRBM3ngt9HKHKPmvaJEcoAFTtg@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-prompt.sh: add submodule indicator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Benjamin Fuchs <email@benjaminfuchs.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 30, 2017 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Benjamin Fuchs <email@benjaminfuchs.de> writes:
>
>> In [2/4] I got rid of the loop by feedback of G=C3=A1bor.
>> Sorry if my patch wasn't well formed.
>
> While it might be the way other development communities work, in the
> Git development community, we do not work that way when presenting
> your second and subsequent attempt to the community.
>
> Having the initial draft from the original developers that records
> the bugs and misdesigns in an earlier parts of a series and separate
> patches that record how the problems were fixed to arrive at the
> final shape of the codebase might be interesting to the original
> developers, and they may even find such a history valuable, but in
> the context of the history that will be recorded in the official
> tree of the project for eternity, that just adds useless noise.
>
> Instead of keeping the original, in which problems were pointed out,
> and adding later commits to correct them incrementally, a patch is
> "rerolled".  That is, you are expected to learn from the review
> comments and pretend as if you did the work from scratch and you
> already possessed the wisdom lent by the reviewers when you started
> your work.  In the "rerolled" patches you send, you pretend as if
> you worked without making mistakes you made in the earlier rounds at
> all, producing (more) perfect patches from the beginning.
>
> In reality, you may locally be using Git tools like rebase,
> cherry-pick and "add -p" while preparing these "rerolled" rounds of
> patches, but the name of the game is to hide that effort from the
> public and pretend to be a perfect human, recording the result of
> exercising your best ability in the official history ;-).
>
> So this is OK:
>
>     0/3: I want to improve X, and for that I identified that I need
>     A, B and C done.  A or B alone is already an improvement, but A
>     and B together makes it even more useful, and implementation of
>     C requires patches to do A and B.
>
>     1/3: do A
>     2/3: do B
>     3/3: do C, building on A and B
>
> This is not:
>
>     0/3: I want to improve X, and for that I need to do C.
>     1/3: I couldn't do C, and I did A instead.
>     2/3: A was totally useless. I fix it to do B.
>     3/3: B is not very useful, either. I fix it to do C.
>

I agree with Junio here,
"git rebase --interactive" and then editing/squashing commits
is your friend.

(unrelated side note:)
At GitMerge facebook presented their improvements on mercurial
and one of the things was "hg absorb". It would take the dirty hunks/lines
of the working tree and amend them into the "stack of commits", i.e. into
your local unpublished history. So instead of making fixup commits
and doing the whole interactive rebase thing, it would do it automatically
for you. I think that is a neat time saver.

Thanks,
Stefan
