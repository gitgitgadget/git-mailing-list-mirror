Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3E420323
	for <e@80x24.org>; Tue, 21 Mar 2017 10:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756772AbdCUKhl (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 06:37:41 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34919 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756186AbdCUKhj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 06:37:39 -0400
Received: by mail-oi0-f44.google.com with SMTP id a94so34954408oic.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DLPRSZ78eW1QQWmw84ANyQNIUzw6U7CxfX5k0yDko3U=;
        b=MhYCiIXr72dadVl5JSXLDxwCDbqx6articK6XQuV4v4jGOTQh4SzSsSIc+6J2AqedG
         sblDQ28shfxboEF2a7MzedioeVBfUbzEIsCWgHdeF61LvXxo/q1mN8KSGxCgIErfvoxT
         NpmgCudvMBc3MjB/8IKyr3TeVPa2eSVOCNFZ9dB4ozGjTDHYqlpzRGgJG+A8NSjh7YEN
         gY7Fktpw4HMeqtzavIXNONH+kRgCZDKZpIEWxVYdKoX5KkntrfMaNyZaMyWNjlFsJBlr
         Of5uL0yp5INxYI3h6kDbfR7RUfJUVjzDwAg/DRGc036qvY7dOYPZWfwU+i9O0v8KNfo0
         tT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DLPRSZ78eW1QQWmw84ANyQNIUzw6U7CxfX5k0yDko3U=;
        b=Dq3Yq24oA98uk3LLIE1GHQlTBhM/xbRYbuBQq5OlgxGBnNBuxmS7MGJEtuMvPYjAIp
         z5/tqXHCLBqTe1zaVVgp/tSsKpoWSjE0CJedqsFnXogum5IoEoWicRPm3SGvb6kGINnM
         aEpiesw9WJVFGMxji8X/dMZWKxufWfjXW6txzSYmVs1yIsLyfcPeRizqB+zmKW7F9pmB
         VOe363pFw5xWU/JLr0tt9MZHoN88HJv+Wba9YBEt+mlSx7EBHxjhc7OL+AZ3fIGGDDrI
         VfLayhjXlXgRjJq1xDNgHjIAWA0o55p5f9PKBAVCebFciTQ8A56sTTxW/g6iC0RhYd6T
         jVRg==
X-Gm-Message-State: AFeK/H3W6+TT0H/RK8HV55e3uPx99Ok2Q+ZVtJgNjveeFU3/9wcSjPnpi80UkbAtrHdYTt8LR/mDgruJJoK+HQ==
X-Received: by 10.202.204.86 with SMTP id c83mr18586803oig.146.1490092658418;
 Tue, 21 Mar 2017 03:37:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 21 Mar 2017 03:37:08 -0700 (PDT)
In-Reply-To: <20170320185038.GU26789@aiede.mtv.corp.google.com>
References: <20170317222842.GP26789@aiede.mtv.corp.google.com>
 <20170317225110.13417-1-sbeller@google.com> <xmqq60j75psk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kayeSxFTJr3Q1atFgOyR74PzQyCLiejuZxh7+wTGGb=ww@mail.gmail.com>
 <xmqqbmsvx1ey.fsf@gitster.mtv.corp.google.com> <20170320185038.GU26789@aiede.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 21 Mar 2017 17:37:08 +0700
Message-ID: <CACsJy8CBmfj8wY+LQzEshJT0Ya+nmAGs=K8b1Nyr3qinvCo4kA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-worktree: use working tree for trees on
 the file system
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 1:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>
>>> While it may be true that you can have bare worktrees; I would question
>>> why anyone wants to do this, as the only thing it provides is an
>>> additional HEAD (plus its reflog).
>>
>> A more plausible situation is you start with a bare one as the
>> primary and used to make local clones to do your work in the world
>> before "git worktree".  It would be a natural extension to your
>> workflow to instead create worktrees of of that bare one as the
>> primary worktree with secondaries with working trees.
>
> For what it's worth, this conversation makes me think it was a mistake
> to call this construct a worktree.

For the record, I am totally confused with Junio's last line, with two
"with"s, "worktree" and "working trees" in the same phrase :D

> It's fine for the command to have one name and the documentation to
> use a longer, clearer name to explain it.  What should that longer,
> clearer name be?

No comments from me. I'll let you know that if Eric (or Junio?) didn't
stop me, we would have had $GIT_DIR/repos now instead of
$GIT_DIR/worktrees, just some extra confusion toppings.
-- 
Duy
