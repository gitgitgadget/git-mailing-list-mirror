Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E41F20248
	for <e@80x24.org>; Sat,  2 Mar 2019 23:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfCBXsa (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 18:48:30 -0500
Received: from mail-ua1-f44.google.com ([209.85.222.44]:40979 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfCBXsa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 18:48:30 -0500
Received: by mail-ua1-f44.google.com with SMTP id j7so1274578uak.8
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 15:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cy8ty2q9kEo1A2xb8wobD7IZHc1DEZKnbrGhA+xKtjw=;
        b=MRE19HUECY7LvrKlGyng8r7feSoTPTbauNkyq27GjlT2Z/knpMQ9H3ZR1YhvHa78Xb
         VdJufwSq4GysExRxO8fnuV4SUM0sZLlLQm97QIpQjqcQfFvE73hNaAi9E8OZnAA2T3FQ
         f6t3HC1zCJSAFHGGNurvgwhUFG2fUUhsue83hAbyDnbFIm6UrraX01tbKaXshzbiBPDB
         P1PzuWZ+H0OWADklcKtVGtgv2+ujVaNbKDb3NTBCpIdc9HdvTreEyu/NM+6qdq1FT6tj
         jFHlzPTCEnjDxLiR+Bzir3uxHT0oVi2ZSJR8uxa8O5nQ/C/fC6Qc9Ig3BLL/WxDN7Ivb
         jS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cy8ty2q9kEo1A2xb8wobD7IZHc1DEZKnbrGhA+xKtjw=;
        b=UUkkgP6HaH37s1Tps0woIFz7ywReosFY8s8O2SBxISIaXYqsigLHXZ1ik7B/ZpaNNF
         FwDsqYnzn4WMX7Kc1JFIQxIvGsZ3ZrR4EhWg3lY+96fDCvnv7wG6s+rjHu9YrdmgRoRo
         0e1t5xR+y9Eb4SFXLv7KDozkwJKVfsqGbHvbrKt40Ze+UNf7ClHEX1Eq/cg263HddeIl
         d29wCftXRaiNLvVgnQ0gxdDUakgeRybuqdIAXCssa+OV+lycNZ3JduaF5A0bj6DWsV2K
         +CGnXlRN0b0y+MWKrp3YLztAIQaLj/1aUrrQ2ivdLlG948O7uiFjep13y0iuOqtC7eRj
         ubKQ==
X-Gm-Message-State: APjAAAVw9WE3bScdwsdOE1dNBeU0OyekG4jxTDc+HlOgW0EVco+Bq0t6
        fbNPU2cfV9RNZwB2pzBkLSfgzcYQ8FNnbYtcCVvNIVtk
X-Google-Smtp-Source: APXvYqwCaoVmdVAagYu1EpFF6ezrZxnElU8Dar9A0flEcFCjHgCmGS6HU6JSvTd+edAUFFt83uUVA8hnIVDExezEvxQ=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr6426516uao.28.1551570508882;
 Sat, 02 Mar 2019 15:48:28 -0800 (PST)
MIME-Version: 1.0
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se>
 <512993fe-51da-745d-031b-37ea162499fb@gmail.com> <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
 <20190227164056.GA2062@sigill.intra.peff.net> <CABPp-BGOqQ0P8ywCK_sybPOeASxPnkTq7NXW8678f=345=68-Q@mail.gmail.com>
 <xmqq7edj9uh2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7edj9uh2.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 2 Mar 2019 15:48:17 -0800
Message-ID: <CABPp-BFdbC2Shq8BrP=Ht21ZbjvEZVL_uQC0=3_YwbLJVbBU+g@mail.gmail.com>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Feb 28, 2019 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> As you know that I've always been skeptical to this rename-directory
> business, this probably won't come as a surprise, but I seriously
> think directory renames should be made opt-in, and as a separate
> option, making the option three-way.  I.e.
>
>  - do we do any renames (yes/no)?
>
>  - if we do do renames, do we base the decision only on the contents
>    of the thing along, or do we allow neighbouring files affect the
>    decision?
>
> That is, in addition to the traditional --renames or -M, we'd have a
> separate bool --allow-directory-renames that is by default off and
> is a no-op if the former is off.

We've gone from always-off (ability wasn't implemented), to always on
(assuming normal rename detection was on), and now we're considering
making it an option, with you proposing opt-in.  While I think opt-out
would be a better default, we may want to first consider the range of
possibilities; if more safety is needed, other choices might be safer
than either opt-in or opt-out.

This email reminds me a bit of the recent overlay discussion, where
some of your wording made me think about directory handling, but you
had smudge filters in mind.  We're occasionally on different
wavelengths, and I'm worried I might be mis-reading your main point
and/or that my responses only address part of the issues you have in
mind.  Let me know if that's the case.

> We had to fix a breakage recently for 3-way fallback case, and we
> explained the fix as needed because the case lacks the full
> information, but I think even with the full information at hand, the
> rename-directory heurisitcs is inherently riskier than the content
> based rename detection.
>
> Suppose you had F1, F2, ... in directory D1, and moved them all to
> D1/D2.  In the meantime, somebody else adds Fn to directory D1.  It
> may be likely that some variant of Fn would want to go to D1/D2, but
> it also is very likely that there should be a difference between
> D1/Fn somebody else had, and the contents of D1/D2/Fn in the merge
> result.  Perhaps D1/F1 in your preimage used to refer to another
> path in the top-level directory as "../top", but the reference would
> have been rewritten to "../../top" when you moved D1/F1 to D1/D2/F1,
> and the person doing the merge should at least check if D1/Fn that
> comes from the other party needs a similar adjustment while merged.
>
> In the above scenario, if there were D1/Fn in _your_ preimage and
> all the other party did was to make in-place modification, the story
> is vastly different.  Most likely you would have made most of, if
> not all, the adjustment necessary for D1/Fn to sit in its new
> location, while the other party kept the relative reference to other
> places intact, so we can say that both parties have say in the
> contents of the auto-merged result.  The "since neighgours moved,
> this must also want to move the same way" heuristics does not give a
> chance to the party that is not aware of the move to prepare the
> contents appropriate for the new location, by definition, so the
> onus is on the person who merges to adjust the contents.

There are a few issues here to unpack.

First, in regards to your example, the very first "Limitation" imposed
by the directory rename heuristics was:
  * If a given directory still exists on both sides of a merge, we do
not consider it to have been renamed.
Therefore, your (detailed) example above of "renaming" D1/* to D1/D2/*
isn't something the directory rename heuristics supports (the presence
of D1/D2/ implies D1/ still exists and thus could not have been
renamed; this particular case is explicitly mentioned in t6043 and I
brought it up a couple times during the review of the directory rename
patch series with Stefan).  There are too many edge/corner cases that
become difficult without this rule and it was considered more likely
to (negatively) surprise users, so even with directory rename
heuristics on, a new file Fn added to D1/ on the other side of the
merge will remain in D1/Fn after the merge.  Perhaps this
clarification helps assuage your worries, or maybe your example was an
unfortunate one for relaying your real underlying concern.

Second, you stated that you thought "rename-directory [heuristics are]
inherently riskier" than not having them on, and then gave a single
(though involved) example.  This could be read to imply that you
believe directory rename heuristics are for convenience only, that
there is no risk involved with not detecting directory renames, and
thus all that matters is the cost benefit of the convenience of
detecting renames for users vs. whatever risks there are in
"detecting" renames that aren't actually wanted by users.  I do not
know if you intended any of these implications at all, but I do want
to point out that not detecting directory renames is not merely a
convenience.  While that convenience was _part_ of the reason spurring
my work on that capability, it was also pushed due to my having been
told about bugs caused by not having it.  I don't remember the details
I was told (and I wasn't even told the full details of the bugs), but
my understanding and/or guesses years later is:
  * build systems sometimes build code according to directories and globs
  * an un-detected directory rename can thus cause new files on one
side of history to not get built as expected
  * other files may not have direct references to identifiers in the
new files, thus no compilation-time or link-time failures occur
  * the new code could have had a static singleton that registered
itself with some other logic in the code
  * the "other logic" rather than having a one-to-one set of handlers
may have a priority listing of which static singletons to use
  * therefore, there is no runtime failure from failing to compile the
code either, just different behavior than expected
  * a testcase should have caught this type of problem anyway, but
testcases aren't always added
  * it was a rarely used, but important case
  * the developer did *manually* test this pretty carefully...but
didn't expect a "clean merge" to break things.  :-(
  * this kind of issue might not be detected before release,
deployment, or installation and usage at a customer site.
  * testcases are a best practice for a reason, it was totally our
fault for missing them, but having multiple LTS releases and large
code directory refactors between versions increased the odds we'd
eventually hit failures of this type

Third, at the end of your example, you say that the rename-directory
heuristics "[puts the onus] on the person who merges to adjust the
contents", but my example above shows the same is true if directory
renaming is turned off.  The person doing the merge needs to somehow
know there may have been a directory rename and possibly move files
and update references or things may have semantic breaks.  This seems
no different to me than normal content merges with e.g. new
invocations of a function added on one side of history and on the
other side of history new parameters added to the function call
signature.  Actually, I guess there is one difference: we have a way
of detecting the (potential) directory rename and notifying the user
of a possible change -- though we haven't taken advantage of this
possibility yet (handle_rename_via_dir() silently moves files).

Perhaps, though, you see directory rename heuristics as somehow
riskier than semantic merge conflicts of other types, and perhaps we
should add more options here.  But I think there are other possible
solutions here which are worthy of consideration before choosing which
behavior we want.  Thinking just in terms of the default behavior,
here are eight possibilities:
  * leave the capability on with no changes (no ability to opt-out,
other than turning rename detection off entirely)
  * remove the directory rename detection capability entirely (go back
to pre- git-2.18 behavior)
  * opt-out (let users choose pre-git-2.18 behavior, but default to
silently moving files according to directory rename heuristics)
  * opt-in (directory rename detection is off by default and users are
given no notice that paths should perhaps be renamed)
  * display messages whenever directory rename detection adjusts a path location
  * display messages whenever directory rename detection could adjust
a path location, but don't adjust it
  * whenever directory rename detection adjusts a path location, mark
the new path as conflicted (i.e. record at either stage 2 or 3 instead
of 0)
  * whenever directory rename detection would adjust a path, leave it
where it was but mark it as conflicted, and print a helpful message

Whatever we choose for the default could be tweaked by some new option
(e.g. make it less noisy or don't mark such paths as conflicted if the
user has explicitly stated their preference for or against directory
rename detection).  I'm struggling to see directory rename detection
as "risky" (though I certainly feel that lack of it is and thus do not
like the opt-in option), but if others feel there is risk here,
wouldn't one of the last four options be safer than Peff's suggestion
of opt-out or your suggestion of opt-in?


Thanks,
Elijah
