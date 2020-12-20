Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C06C4361B
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0653C22D37
	for <git@archiver.kernel.org>; Sun, 20 Dec 2020 06:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLTGqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 01:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgLTGqL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 01:46:11 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6908C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 22:45:31 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id g1so6079697ilk.7
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 22:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTeFlVwjU1PwUZfhFn/q67nidZe31GLAGPIv3xNIYMU=;
        b=e8MvikLJFD4Gjvt6A9QlmMQCJqgiaGSpo/Xt/ts1tshF2E2Lwh/LmvfC6E9JzHspN9
         i+9VqUIbRC9QLa+RxGJBnmiL1JqQoiw7tV5dIQDEhvc7p6I47uLg56laEH9VE1thTZoC
         6BezaL5VRX70euFfpzKg7JKShm9j0gepiLDsjgocjAMKahg5kgkinktCXFVwwgWKwQE1
         fGz+PFNHLauZJIGps0Zj+Cb6mAcL9mr3B8iesBflDjzg5puIU40DoLiJwxCi2PDMNScl
         OxI7C1kK1QS5SfztOcE14Kmsu5x9CCvLt9iU7USU7xFEdNdjhbbOXFr9SwIXOsDfGaF1
         knfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTeFlVwjU1PwUZfhFn/q67nidZe31GLAGPIv3xNIYMU=;
        b=ZmtYsQpxTONTpIW3ZK+zjPKhoXe1GZM52AGPpxI2hb5ZCVrY7060O2q5aY4MehQx3F
         6Sbezdx5L8yah/sq1yj86jUH42TrjLtbZofGipsb4bsB2IO3CPpepxHsKnTtO1uYQG3V
         rEeXMHQGpMt86XQ8D72hRRWMfE91dhTGdOkzuzXKeWqQbUZJdwiSPjuyYbgVjA83OwuG
         KWJ7TYt/1zWQdxiGJv38jQkoKJn+6ABImub0b9hW4mDh2cXUsEVzrktRIOmoOimAKy8s
         Uvp2VhGx4m+td9AKHUIBJruxQsvbA0xVjBtg0XmUjai8YFin12wo0U+xkagbVobENrr9
         5iLg==
X-Gm-Message-State: AOAM532kGTZ6Ow5WO7e571HEC1XAaoPvh88dhcqDUCM1wbGooOkiXFhw
        79bsguQS8YDPltVCSeCL9rvgSQcg0htyIMvGU+M=
X-Google-Smtp-Source: ABdhPJylwoe+fsqHDJdiZFNHcI/QA7TXu4dTSU35jy0qRqVgTe/8rTQQQMy1+PGqmm+TZathz1McxnOILTKOYZ2moDQ=
X-Received: by 2002:a92:9ada:: with SMTP id c87mr11854750ill.5.1608446730935;
 Sat, 19 Dec 2020 22:45:30 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com> <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch> <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen> <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen> <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen> <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen> <xmqq3603v3a0.fsf@gitster.c.googlers.com>
 <5fdc998216c89_104e15208da@natae.notmuch> <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
 <5fde69944fe4d_1e50c7208f@natae.notmuch>
In-Reply-To: <5fde69944fe4d_1e50c7208f@natae.notmuch>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 19 Dec 2020 22:44:54 -0800
Message-ID: <CAJDDKr6RP+TPFF2mHph7sqa-eG9uoRtqS4d4vUU84V3HJ_CMBA@mail.gmail.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 19, 2020 at 12:59 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Junio C Hamano wrote:
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> > >> Another reason why allowing users to disable the feature per tool is
> > >> important is because as far as I know we have kept the mergetool
> > >> framework to allow adding a tool that can merge binary data, and
> > >> leaving these three files pristine was one ingredient for that.
> > >> With only a single knob, we would be making a decision to declare
> > >> that such a tool is unwelcome, which is not quite acceptable.  I
> > >> expect that users would want the new feature most of the time
> > >> because they would be managing text files more of the time, and
> > >> having only a single knob would force an unnecessary choice on those
> > >> who want to use such a binary-capable tool as well.
> > >
> > > I can't imagine what that binary data could look like, and how any tool
> > > could represent that to the user.
> >
> > What I had in mind are use cases like merging "comment"-ish part of
> > media files (e.g. exif in jpeg, id3 in mp3---things like that), as
> > I've heard some people do use Git to manage their photo collection.
>
> Right. They can do that with a text editor.
>
> > Of course, I can imagine that a cartoonist first draws a background
> > picture, cop es it twice, and then draws a dog on top of the
> > background in one copy while drawing a cat in the other.  You should
> > be able to merge the resulting two pictures cleanly by following the
> > three-way merge idea (take what got changed on only one side plus
> > what did not change--anything else is a conflict) as long as these
> > animals do not overlap.  You probably can even do an equivalent of
> > -Xours (not --ours) to essentially say which object is closer to the
> > viewer in a conflicting case.
>
> The whole point of separating the background from the foreground is that
> the foreground can be animated on top of the background, so they would
> always be two different files.
>
> Even if we force the issue and make two graphic artists work on two
> different branches, what they would inevitably end up doing is work on
> different layers, which for all intents and purposes are like two files.
> No mergetool is going to help them integrate their changes.
>
> > > But either way "git merge-file" fails on those cases, so we can just
> > > check if the file is empty, and bail out.
> >
> > Catching failures from merge-file and reverting back to the original
> > behaviour would be an improvement, if the code in the earlier
> > iteration was not checking errors.  But I would prefer not count on
> > the tool always to fail, as there are image file formats that appear
> > to be text that are unreadable to humans (like pnm),
>
> git would not add conflict markers on the part of a pnm file that did
> not change, so in fact, a person merging pnm files might in fact desire
> automerge.
>
> > and my primary reason for configurability is as an escape hatch to be
> > used in cases where we do not anticipate here.
>
> Once again: "mergetool.automerge=false" is a thing.
>
> > Listing "what about this case, it does not break" million times would
> > not help us here.
>
> This is the philosophical problem of induction: a million white swans
> doesn't prove all swans are white.
>
> The only thing we know for certain is that there is no known problem.
> And that if and when such a problem occurs, we would need to think about
> the proper solution.
>
> > With per-tool enable/disable option, the users do not have to rely
> > on failure from merge-file anyway.
>
> They don't have to rely on that failure, they can just turn off
> mergetool.automerge.
>
>
> But fine. Let's the perfect be the enemy of the good. That seems wise.


FWIW I'm in favor of having per-tool configuration precisely for
custom mergetools that do things with custom file formats and benefit
from having all of LOCAL REMOTE and BASE.

I don't have to imagine these use cases, they are very real. No survey
can be exhaustive so being flexible and allowing for a mixed tool
ecosystem is the right choice.

This design choice is also in alignment with the general
mergetool/difftool per-tool configuration paradigm.  If we didn't
support per-tool, then it would be inconsistent.
-- 
David

(sorry, posting from gmail's web interface so this probably won't hit
the public lists, but I probably won't reply beyond this email stating
my preference)
