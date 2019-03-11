Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71A220248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCKWFN (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:05:13 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45531 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfCKWFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:05:13 -0400
Received: by mail-vs1-f67.google.com with SMTP id n14so347565vsp.12
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3woX1f6lVIz6R6zaTuLLtYvO1XrMVoPQuIxc6fJ1rYM=;
        b=F5mDTEiifcOoPSLpal4yKFC6nJNmtH3I2CaT1v3cbDXLiNev82P/unyNzrIWyTHjEE
         NWDolDu/nz4zLizt3KQFOVuXckOENnvAJgQLHGgYoqbyQskUshbUolXILvtJomRliLgi
         yv/xpouIKNxSXQIxhlsmKKP1ccTSyLMHCL8Vi2O92N/rES2bBDvsoXPNhS6AuYtmt53G
         apzODxJFtub+lHP/DQSJrJrevU2JzQ2xBEXhu30GqgD8+Kjgf2s4DoMLN6XOTXRRREsd
         jfNZ/xiLV84aZikOnnBJ+XBLeX0elvE3SpQbZ53BRrnBDa5Yih8i9eZ/34Dmd4Bxw6yC
         xq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3woX1f6lVIz6R6zaTuLLtYvO1XrMVoPQuIxc6fJ1rYM=;
        b=ToCFK6naCBJQK5N5Ry1vv8MGopgykT5+4uxgdWJGjvBanqKEP2U0C/pmdQf3b5gzvp
         Y/hZbf92UfH7+rdyNKGvhAgQPh93k9TDZbjArfxr8z7mku0IgK79IyJ79auuJJie95Jr
         8kEKhUsPd7NQfx+tqp1phzvqLBrl2zbRZxbfK8ngfr9dcG0kEHC05GTr6ASo+pqreC2o
         IWOoTqNn4nDQ71QC147Qbq1cLc1V2EUNZukloqhuBzxT50uXOx8sU00lmbbWKs45TiOK
         gh1yewIpCoXrb0XCvwIi+gK1bbBu3HzdUPfmYeu47eGNQg7k/qMT4J8qS6k2HB+toijV
         VuIA==
X-Gm-Message-State: APjAAAVaWculYdKkASJ3F4uMPSisSQAvR85LXrHe5gbgbalPTy9gF/oP
        F3uqBL35athX9nZVkSZGmKkp18QI3QfJZmyfhA8=
X-Google-Smtp-Source: APXvYqwkINwYiVYSRJUn+7KAIh5gaMBn1dt8uAXudpsHqu8mKC2IeinGJwwsWAJ/HSqsGqG9Lulav3zdJ3G9Fcz2I3A=
X-Received: by 2002:a67:f8cc:: with SMTP id c12mr18019012vsp.136.1552341911438;
 Mon, 11 Mar 2019 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com> <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
In-Reply-To: <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 15:04:59 -0700
Message-ID: <CABPp-BH8FjK9LrZoctpxsuKW13FW_2qfk9wx=VXCZ5U+3B8b+Q@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 1:51 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
> On 11/03/2019 17:24, Elijah Newren wrote:
> > On Mon, Mar 11, 2019 at 4:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >> On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.co=
m> wrote:
> >>> On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> >>>> "git checkout" doing too many things is a source of confusion for ma=
ny
> >>>> users (and it even bites old timers sometimes). To remedy that, the
> >>>> command will be split into two new ones: switch and
> >>>> something-to-checkout-paths.
> >>>
> >>> I think this is a good idea, thanks for working on it. I wonder if it
> >>> would be a good idea to have the new command refuse to checkout a new
> >>> branch if there is a cherry-pick/revert/merge/rebase in progress (wit=
h
> >>> an option to override the check) as switching branches in the middle =
of
> >>> one of those is likely to be confusing to users (if I do it it is
> >>> normally because I've forgotten that I've not run 'git whatever
> >>> --continue').
> >>
> >> Interesting. I think this would be a good default if we have an escape
> >> hatch (which could even come later). I often wander off to some other
> >> branch and go back. But then half the time I end up forgetting I'm in
> >> a middle of something and just "git rebase --quit" :P
> >>
> >> Of course with git-stash (*) and git-worktree, I guess there's little
> >> reason to just switch away from a something-in-progress worktree. I'll
> >> try to implement this in the next round, unless someone objects.
> >
> > No objection here; I like this idea.
> >

Keeping this hunk since it's now relevant to the comment below...

> >>>> +-f::
> >>>> +--force::
> >>>> +     Proceed even if the index or the working tree differs from
> >>>> +     HEAD. Both the index and working tree are restored to match
> >>>> +     the switching target. This is used to throw away local
> >>>> +     changes.
> >>>
> >>> I'd always thought that --force meant "throw away my local changes if
> >>> they conflict with the new branch" not "throw them away regardless"
> >>> (which is better as it is deterministic). Maybe we can come up with a
> >>> clearer name here --discard-changes? At the moment --force does not
> >>> throw away conflicts properly (see the script below in my comments ab=
out
> >>> --merge).
> >>
> >> Yeah if you want to redefine --force, now is a very good time.
> >> Personally I'd rather have separate options than the "one catch all"
> >> --force (or worse, multiple of --force). I'll leave this for the
> >> community to decide.
> >>
> >> Adding Elijah too. He also had some concern about "git restore
> >> --force". Maybe he's interested in this as well.
> >
> > I like Phillip's suggestion of --discard-changes.  I also like how he
> > came up with a simple testcase showing one bug each with checkout's
> > current -m and -f handling; we should fix those.
>
> With regard to discarding conflicts, do we want it to clear up any state
> associated with the conflicts (like reset)? They rarely happen in
> isolation, there's a MERGE_HEAD or CHERRY_PICK_HEAD etc. I'm not sure
> what it should do in the middle of a rebase or when cherry-picking a
> range of commits. I think it would be surprising if it was the
> equivalent of rebase/cherry-pick --quit but just clearing the conflicts
> in those contexts may not be very useful in practice.

You already suggested above (outside the context of --discard-changes)
that we should just error out if there is some special mid-operation
state (be it from a merge, cherry-pick, rebase, or bisect).  The user
can then manually resolve the operation first, or, perhaps use a
special override to force the switch command to proceed despite the
presence of mid-operation state.

Personally, I'm leaning towards --discard-changes operating within
that same context; I think that mid-operation special state should
require a more explicit and operation-specific step to remove (e.g.
rebase --quit).
