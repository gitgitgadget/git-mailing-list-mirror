Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CACC51F463
	for <e@80x24.org>; Mon, 16 Sep 2019 14:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfIPOZm (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 10:25:42 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:45387 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIPOZm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 10:25:42 -0400
Received: by mail-lj1-f176.google.com with SMTP id q64so73235ljb.12
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=Xjv1Ob8sR2QWO0f5N6yQyJLWzwB4oJwSO1CGu6E05mc=;
        b=dkMFUeGLe4fkq/+hkRbKdblEB9YIniqAxVRHjJjSjUTSyJkkl2xIidqoedwjvDLYot
         qirEX7oE8UA41v+/JJ7CP1spb7W2Rox9E8pm6t7FUz94mzfkSkFDVtiFyNmLY64yH1AC
         G3GDlXuaCZfNM1BhYlMHNK1Wyewp8U/tWetLTz3BnxtRFrsfkdTz3+ff6m3CcES7cOy3
         dT929HkPd48NXOsj+GQk5J74PkttqNYbZirGPceX64a2DXQJKM7mFxKSuxT3zq7mQzNh
         JbAEv30k0MOFnROpTtqkyEDuy35+2rGhSOuH2769w7wbaCkBdc123F6a+wrmacY831Qe
         BD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=Xjv1Ob8sR2QWO0f5N6yQyJLWzwB4oJwSO1CGu6E05mc=;
        b=Oy+ZgWO3nLC86wxxd/LCDISRtfpw2rFPvsSxWueYRvEFgVMqbS4P2FGnLYKB5qZy0B
         UafO6z3wN9botbWhVtChsjXEupICs1P1hor6iGUi2zEkQxZIK2ACN4wzWzcfDf35TI5q
         QyI7skcyEy0fDxGlv0o1TOV/l07w6w8xGQWrrFP6MNqxrwjyEH7r6xgmJQ4t2MOEc20h
         BeW7MT6dStXc06d7DkWvZJA/VzVxnHfXlAzF3XHU+8T4AzVdRbVm/1C4Pad2IsgOXdX9
         yGftQwMUgtHOyZKZe4XbaBduH019T6tfUxIkcpnE8hrdFMn4Uoc5cwrXSjd7jDaYRo8J
         DxQg==
X-Gm-Message-State: APjAAAXZ2xGG3G0suLkYpJUC4kFfFJFqjV+tNpAhBGb+kdr23FwkslCY
        hg6KOAbbtiR3rTjFdna8K50hIp8k4VrIn1StoTo=
X-Google-Smtp-Source: APXvYqyOnaQXU4xSiinKlX8WpuoaZ7Uvl0KFTcpZvs+0DQz64MxNDggO/BmUxSts0+AOz2dn+MgvTBmHmU0c7YQTKBQ=
X-Received: by 2002:a2e:8785:: with SMTP id n5mr32933855lji.210.1568643940403;
 Mon, 16 Sep 2019 07:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BT35jvPtsuD9gfJB0HJ=NxtzyQOaiD7-=sHJbFYhphpg@mail.gmail.com>
 <20190914033017.GA30458@sigill.intra.peff.net>
In-Reply-To: <20190914033017.GA30458@sigill.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 16 Sep 2019 09:25:28 -0500
X-Google-Sender-Auth: DVmjV0INL14ERj_1dOC7ZwwBJEQ
Message-ID: <CAHd499CJ9oZNNM68w27D0ifehJ1EksWBSbk7s45ZUZJAvM9z=g@mail.gmail.com>
Subject: Re: diff.renames not working?
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 10:30 PM Jeff King <peff@peff.net> wrote:
> SNIP
>
> > Now this looks more like it. I can actually see a useful diff here,
> > instead of everything looking like a new file. But there is a lot of
> > confusion here:
> >
> > 1. `diff --follow` is not a documented[1] option. Why does it work?
>
> Accident. :) See above.
>
> > 2. `diff -M` doesn't actually work either. It should, though. In fact,
> > I expected it to work as `--follow` does. But it doesn't.
>
> It doesn't work because this is a copy, not a rename.
>
> > 3. The `diff.renames` config doesn't seem to be working here, when it should.
>
> It does, but the pathspec prevents it from finding a source candidate.

Jeff, thanks so much. All of your examples help to contrast the
different behavior. I thought -M did copies & renames, that was my
misunderstanding. But the fact that you explained that the file spec
would prevent it from working as I'd like anyway means it doesn't
matter too much.

Ultimately my goal is to use the pathspec to filter what is visible, I
don't necessarily intend it to obscure my results due to internal
behavior. I realize there are performance obligations too (as you
described) but I feel like something like this should be
straightforward for end users. I consider myself a step above most
people with my understanding of Git and how it functions, and even I
was confused by this. Especially when it comes to folks I work with at
my day job, I just don't see them making sense of this.

To me, as transparently as possible, moves and copies should be
handled intrinsically. I realize there are technical challenges
(performance, ambiguities, etc), but anything that can be done to help
with that would go a long way with most users. Maybe a 3rd option from
your list to solve this issue might be adding some metadata to commits
or blob object types to record the pathspec of the file it was a copy
or move of. Even if this required you to first do a git cp/mv before
modifying the content, or a strict similarity threshold, I think it
would go a long way. That means that `diff` can utilize the metadata
in the object itself to find the path specs to follow, instead of
requiring some complex deduction logic that has a steep performance
cost.
