Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EEB91F45F
	for <e@80x24.org>; Tue,  7 May 2019 16:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfEGQot (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 12:44:49 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46007 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbfEGQot (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 12:44:49 -0400
Received: by mail-vs1-f67.google.com with SMTP id o10so10794963vsp.12
        for <git@vger.kernel.org>; Tue, 07 May 2019 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dJTANFgJVQBbt/+8ANyl/otP9LM9EfRlw4zUhB+9Ohg=;
        b=Jj28wM+rcit8MFeKBt70xCdOunkntU6MUUG9ofSIAveilaWoWjFEAH64VEKdLHy20w
         775Sgin+PpnG3NiEYk3KsFa5Kk690SgfsA9K8ho6q45LF5Mccmm5/E0p2+vWRXUFxdA5
         2rbsJPrA0OBWdlRKBG3WNfQMh7HF3+0ZAJIxNBJWDXAgDi4nS8Jr03lU1jAXNVFP8/Vm
         WELiPZaR0wY0uUFhb55vF9h4eH41yWoXxQ/Et9NrVRM1XL1/B1yU+W/qR1gqTbUmaTBV
         VRLDlYy437uz1/v//vTuA+u9G4jJO683iobgqwpx0+xiAm1bwGt42nebPomF8hfvBXMr
         KJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dJTANFgJVQBbt/+8ANyl/otP9LM9EfRlw4zUhB+9Ohg=;
        b=oKF8uohhuli+D5C8TRTuBHE9a6QJskFFka0BFTMEj+r7j1Q24ooYKUztbW6RYWaz/6
         PjkssxNvsbTK5oyPczKJLGRSHZTxBn0EXkfXVp9C+x5EFUeni3PSjTKyz06b6UjC1h3K
         xy1XKbtkJynE2BD4V9ro6M9TWIoTJtqy/UYwXhAslsTBgns918LuZ2G4NkLZ/GxUx1MX
         kkpdiqzPWZfGOPxBgfioh2lgn7JLId1MjmfXBuR7cruqcQ7LlPeAySrSf68B8M8FfiUB
         BKokJSxWQ+PKmMFjgHJdYpDCANEzkTLYYP7X5cVp03UlIwm5zs++nsc+8DmDqElZaEEU
         I+oQ==
X-Gm-Message-State: APjAAAVyrd2JdW0FWgtqQ09TTBOmvwLcIFpzRJQO0JYy/eF0bTIM9cQk
        QvszzBt4TeKMJ6wawTF9KsFi1tz+2QQSF9f0pSU=
X-Google-Smtp-Source: APXvYqxfyikMLwsu8jZqr0IISH1TH5gt8Kgdkf3hrgte/brsoRJuF60A7TZQ2o2T8d6f6m31MR9cHSjwnWz+Dtr7L1U=
X-Received: by 2002:a67:f985:: with SMTP id b5mr746865vsq.136.1557247487994;
 Tue, 07 May 2019 09:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm> <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
 <874l67i1ie.fsf@evledraar.gmail.com> <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
In-Reply-To: <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 May 2019 09:44:36 -0700
Message-ID: <CABPp-BECj___HneAYviE3SB=wU6OTcBi3S=+Un1sP6L4WJ7agA@mail.gmail.com>
Subject: Re: Merge commit diff results are confusing and inconsistent
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Eckhard_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 7, 2019 at 7:12 AM Robert Dailey <rcdailey.lists@gmail.com> wro=
te:
> On Mon, May 6, 2019 at 6:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:

> The majority use case I'm interested in is seeing net-positive changes
> that happen in merge commits. Normally I take for granted that merge
> commits have nothing meaningful in them (meaningful here defined as
> something unexpected for a merge commit). But what if someone makes a
> poor decision and does some crazy refactoring in 1 file and amends it
> into a merge commit? Let's also say that these changes are done to a
> file that wasn't modified in any parent (say a unrelated.txt next to
> your color.txt). Since neither parent cares about that file for the
> purposes of the merge, I am trying to make sense of a revision
> specification that can be used to see what they did to that file.

An ability to find evil merges/cherry-picks/reverts by diffing a merge
commit to an auto-merge of some sort is something I am planning to
tackle; I'm tracking it at
https://bugs.chromium.org/p/git/issues/detail?id=3D12.  I'm working on
filter-repo first, then the merge rewrite, and then if I'm not
distracted by other stuff (a big if), then I'll tackle this.  Both
those other projects that are first in the list are rather large,
though, so it may be a while...

> Even ignoring that issue, the more concerning observation of mine is
> that `diff @^!` produces any output at all. If you exclude both
> parents, why do I see a diff for parent 2 (I see the complete diff of
> the branch that was merged in)?

I think using ^! on merge commits with diff ought to be an error,
personally.  Not that I'd want to get into the battle of figuring out
if someone did figure out what it means and find a valid use for it to
determine if we need to deprecate or provide alternate syntax or who
knows what for it.  I know it can be explained to be a combined diff
of some sort, but that's it.  ^! as a post-fix operator on a non-merge
commit makes sense to me and is useful, even though it's an ugly hack
and hideous usability-wise from a teaching or explaining perspective.
Without digging into the code in detail, I wouldn't for the life of me
be able to explain how ^! will work on merge commits with diff.

> Again, thank you for your example, you definitely made things very
> clear for me. I see where the confusion is. And I think --cc is a good
> way to get more context. At this point I'm just concerned about the
> @^! behavior with merge commits & diff.

I am too, though my suggestion for that case is: please, for all that
is good in the world, DON'T USE THAT.  EVER.  Whatever it might do, I
certainly don't want to waste any brain cycles supporting it or making
sure it still works.  diff is an endpoint operation and people should
pass endpoints to diff, not ranges (with only two exceptions I can
think of: '^!' on non-merge commits and usage of the super confusing
and ugly but also necessary '...' for diff against a merge-base.)

Honestly, I am tempted to make git throw a warning whenever folks use
a range operator with diff other than the exceptions noted above.
Hmm...

Elijah
