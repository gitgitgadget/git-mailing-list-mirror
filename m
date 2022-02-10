Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30578C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 17:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244816AbiBJRDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:03:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiBJRDk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 12:03:40 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416DBB9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 09:03:40 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id y22so4949323eju.9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lbw5XVuH3kNxzsvuqlA3q7ENwII3wacIQLYMxUoYBew=;
        b=Ezws/8lvwoU8EIULC/rOiACbkZzmhSf8TAJHCxwoEZJp3fsOTj/d++m60NaBiGr5kN
         F/wltSXYuRK+OArxK3bJcycepIyRi3cXxsC/m8jwaKGK2+pVPLPrwEMggEhbvWr4XQa2
         NPiQgtYrocSXtesN9iXUF0um/A47FvB3c0RHWyAjjeuahS+SGBRL/fZ2L5/b5776dtpu
         ZNIgXGhahTBjdRMxY+7YZlaU6LYREoEVlwC0YH/ynJ0BgTwO6WIikyiEG9OCCubISrel
         v00qCMX2yDfxruypGOiMoltV0ZxRfiprOgg4sO8Oauewni8VJs9jZYAJYXEpuf9wpCqc
         ohWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lbw5XVuH3kNxzsvuqlA3q7ENwII3wacIQLYMxUoYBew=;
        b=qqvVtO8cuaaZ3Uu+xARot5BIYPNrEsMp55Oqs2ry1oADkIYp/89ndWj+Dm2wZ+dhfK
         /nghzGz3PDeljNdd1U0pgDeRYMh/oFFxv/JZu5maia5Dj8xpd3l2iaqAS57T74QPmWXo
         Wje6E+8DOXt09vRPtL/dg5MsstY7P9UyK4y7JkOdi2PqNX7xi5ep6clXamW4RBeloqOw
         zoxP0wtVPESpVyqoTQMJ4ZOCyx3a7cQeeFnA4/rBN5XMpk+Dop5+5DpRpIGRG+ABLMGU
         lZ3xnnIv5s3SOj/bQ8yXMedmJSL8JBuWqk3eY0jcuO5hrhQ7rGxkseZKJNv1/4Dd9ZS+
         h/qg==
X-Gm-Message-State: AOAM532pc02sWqdUDAwhMc/Z52V5I+Xkzh4rW5AAq9Di3rh+XucJKBar
        uK6JkE5kFpZOeS96dz2Zk1X2VhkwvgQErzv50fw=
X-Google-Smtp-Source: ABdhPJy5Ui6KYnqbBarmMgGfwQv3rk0sUCIH8iu93kN/OSmllF4BMY7dIJSaCsiILvgCMa3TlEPl/QcUr7X2y3ROLHw=
X-Received: by 2002:a17:907:1b0f:: with SMTP id mp15mr7170327ejc.493.1644512618721;
 Thu, 10 Feb 2022 09:03:38 -0800 (PST)
MIME-Version: 1.0
References: <xmqqczjvxy3o.fsf@gitster.g> <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
 <xmqqiltmwufw.fsf@gitster.g>
In-Reply-To: <xmqqiltmwufw.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Feb 2022 09:03:27 -0800
Message-ID: <CABPp-BEtjtpUK7gsb2QYW6JiicA3=ewkK7oKr6i8jh-1ndMnYw@mail.gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 8:35 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >>    One thing that makes me worried somewhat is what I did not touch,
> >>    namely, how pseudo refs are defined.  I know MERGE_HEAD is very
> >>    special and it may be impossible to coax it into refs API for
> >>    writing, so the text there makes sense for it, but there are
> >>    other all-caps-and-directly-under-dot-git-directory files like
> >>    ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
> >>    API, so the description would have to be updated there.
> >
> > I'm not quite following; why would the description need to be updated?
> >  Sure MERGE_HEAD is written without using the refs API, but we didn't
> > mention how the pseduorefs were written in the description, and all of
> > MERGE_HEAD, CHERRY_PICK_HEAD, ORIG_HEAD, REVERT_HEAD get written
> > per-worktree so doesn't "pseudorefs like MERGE_HEAD" cover it as far
> > as the reader is concerned?
>
> Here is how pseudo refs are defined.
>
> [[def_pseudoref]]pseudoref::
>         Pseudorefs are a class of files under `$GIT_DIR` which behave
>         like refs for the purposes of rev-parse, but which are treated
>         specially by git.  Pseudorefs both have names that are all-caps,
>         and always start with a line consisting of a
>         <<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
>         pseudoref, because it is sometimes a symbolic ref.  They might
>         optionally contain some additional data.  `MERGE_HEAD` and
>         `CHERRY_PICK_HEAD` are examples.  Unlike
>         <<def_per_worktree_ref,per-worktree refs>>, these files cannot
>         be symbolic refs, and never have reflogs.  They also cannot be
>         updated through the normal ref update machinery.  Instead,
>         they are updated by directly writing to the files.  However,
>         they can be read as if they were refs, so `git rev-parse
>         MERGE_HEAD` will work.
>
> Points that may need to be looked at in the world where files
> backend is not the only ref backend are:

Ah, sorry, I assumed in "the description would have to be updated
there" you used "there" to refer to some part of your new patch text.
Re-reading, I can see you did specify the pseudoref section, but I
just somehow missed it.  Sorry about that.

>  - "are ... files under `$GIT_DIR`" may no longer be true, once some
>    of them are stored in reftable, for example.
>
>  - "followed by whitespace" may be an irrelevant detail for the
>    purpose of this paragraph.
>
>  - CHERRY_PICK_HEAD, as written in sequencer.c::do_pick_commit(),
>    use update_ref() to write a named file out, so "followed by
>    whitesspace" (and other cruft, like MERGE_HEAD does) certainly
>    does not apply.
>
>  - Also "cannot be updated through the normal ref update machinery"
>    is no longer true.  sequencer.c::do_pick_commit() even calls
>    update_ref() with REF_NO_DEREF to ensure "cannot be symbolic
>    refs".
>
>  - "never have reflogs" would make sense for the current set of
>    pseudorefs (does reflog on CHERRY_PICK_HEAD, for example, have
>    real use case?), but I do not know if it stays that way.  I do
>    not care too deeply either way, but I want to avoid over
>    specifying things.
>
> What worries me the most is that we cannot simply say "all-caps
> names that end with '_HEAD' all behave like refs except that they
> will not be symrefs without reflog." MERGE_HEAD is the only known
> exception if I am not mistaken, and I am OK to single it out as an
> oddball.  The current description however gives that there are a lot
> more differences _among_ pseudorefs.

Makes sense; thanks for clarifying for me.
