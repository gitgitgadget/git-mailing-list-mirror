Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3057215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 21:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbeD3ViJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 17:38:09 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:40120 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeD3ViI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 17:38:08 -0400
Received: by mail-yw0-f170.google.com with SMTP id p144-v6so3055056ywg.7
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MvjL1NxbnGK+VqkNPyd+BC0A5lHqiqN0vsrWS3w5A7I=;
        b=Ffx9Z4kRtk9+MOoQ2h81dO5eKxZ4phngux1trVptTwRSQUio/OwdIAbYifyGbVcM1V
         tnNG8d3BXx7ELVSoOI5uL8bpeZbwoY1u+nmQvncLp9SHi441SrBlJRjtjo/Igz3DN72f
         TYe4l/4uuTNIyug2GSauIgY3dLbgW6VuJTUSitXs2rl7zqu0TSmtEqRXpsIccEnJDYPz
         +ocpKrdFRyX5YTUE8ExAZMWRIUTJh+2r6eX3wpeyvQl9p3hapM7Wg55PEn2no/JIgKtJ
         nvXKMWhdCoSeTERYXSTwcuZXLWu3xrvaDPC8Hqq+9a5CEhoRAWw2KQbcDbjGpznDZGPL
         e8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MvjL1NxbnGK+VqkNPyd+BC0A5lHqiqN0vsrWS3w5A7I=;
        b=a+HTOYW+QCOnoSzD70523CamVBPcj532L1tSuiLVgKVC74FGf1bkAvzI1vqw/3vjt4
         5zt5WQx7CxvPpU9zTAukmEWK8FTHYYjFmWeg0YCeHpiVT0Vf2rMXwpkbCPkOKrqistdo
         oALs6ZWKSn1ipCk/zVAKSaiawvNA/A3eqyL+RTXF3daijwAZTCbkoycVWVjvH6rVr+5o
         zEJIfJHDcRH18jiK3YeKSDPVihXukuxMCvnzLtMKGMHkfZmIJiM3peX5v7FjdPddaHdg
         mSc/2Cra9sSnrMFo6AJXiMu2MyLKuaU608f/kmtBO/J3QA3b9b6zwAQV1cLevnLFEvQf
         oucg==
X-Gm-Message-State: ALQs6tDJgmFgn6xaNgJl2dNbwQE6DrOBKQg32iGxUEYnqWrZPFpDJVHq
        vMUUG12YWoLn0J/lYBRxTN7sh2MUKnGqCVI28Mh3VQ==
X-Google-Smtp-Source: AB8JxZogNm1CxL9oxX49c3tPIjpzwpM4+W9sPFSAIPRR3XCswbS83EVEnH4on8AZiycieBI8Y8EbTooCasyABttjViU=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr7240448ywf.238.1525124287759;
 Mon, 30 Apr 2018 14:38:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 14:38:07
 -0700 (PDT)
In-Reply-To: <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com> <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 14:38:07 -0700
Message-ID: <CAGZ79kakirTjA32cTmByLpjnb3QKUL5eGEgPFFMhUnewC73S8Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
To:     Avery Pennarun <apenwarr@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 1:45 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> On Mon, Apr 30, 2018 at 5:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> I think at this point git-subtree is widely used enough to move out of
>> contrib/, maybe others disagree, but patches are always better for
>> discussion that patch-less ML posts.
>
> I really was hoping git-subtree would be completely obsoleted by
> git-submodule by now, but... it hasn't been, so... no objections on
> this end.

No objections from me either.

Submodules seem to serve a slightly different purpose, though?

With Subtrees the superproject always contains all the code,
even when you squash the subtree histroy when merging it in.
In the submodule world, you may not have access to one of the
submodules.

Submodules do not need to produce a synthetic project history
when splitting off again, as the history is genuine. This allows
for easier work with upstream.

Subtrees present you the whole history by default and the user
needs to be explicit about not wanting to see history from the
subtree, which is the opposite of submodules (though this
may be planned in the future to switch).

> The gerrit team (eg. Stefan Beller) has been doing some really great
> stuff to make submodules more usable by helping with relative
> submodule links and by auto-updating links in supermodules at the
> right times.  Unfortunately doing that requires help from the server
> side, which kind of messes up decentralization and so doesn't solve
> the problem in the general case.

Conceptually Gerrit is doing

  while true:
    git submodule update --remote
    if worktree is dirty:
        git commit "update the submodules"

just that Gerrit doesn't poll but does it event based.

> I really wish there were a good answer, but I don't know what it is.
> I do know that lots of people seem to at least be happy using
> git-subtree, and would be even happier if it were installed
> automatically with git.

https://trends.google.com/trends/explore?date=3Dall&q=3Dgit%20subtree,git%2=
0submodule

Not sure what to make of this data.
