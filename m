Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97E8C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 18:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiBJShD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:37:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiBJShB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 13:37:01 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE52195
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:37:01 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id t184so7440934vst.13
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ryJ+wr5Brh2Qf3xWq/ngG2r0E4v2wCv+XkCD+ZlI/w=;
        b=Iqf8LJGv5EUGmiytbdeJ31OFQUG3zYtzbWUPAI/c/BT7i4ApOu4VkeSM/nQX6IoTlK
         EP41o2Y7MEWb1WgBA9td2CqYenYgYyH8zDCoC24sCdqp6KvtVNmkFAHpgTrQFchjofEw
         an9oj6tCbVi0qbKcvhQGRFGDMrgPfWdktge7c/MJeIbqYhcExFDWUVykbJtLwM7eK8I+
         TPDg6tIMO+NTSh1jOkegxZFvb+QP72cF6BSBgN6HB+50JqNS8HcRawz9uZYKggDQ83dU
         LUwz6bXKA8iAYJcIgVZu0f8BjszQAPxxvyvm9EcEHbDBA5ZRZx5pz3r207VJWiTTFioZ
         PmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ryJ+wr5Brh2Qf3xWq/ngG2r0E4v2wCv+XkCD+ZlI/w=;
        b=qBDXo8W1Ulkk9x4bphUNpOKmVN/ESxNJnIBErF1olpDMYgdk/BBZVHt9LqMSYMBqf6
         ggGgJvCUtBTUAka3K9Lp8Yg/zvAPfY3ihvn/L4v9LGRtemm9xZslLe1RfJ3dUEsFDw1c
         2MakDYcvC9Wi1AMh7JGqI7OTm8E4+1dqkCCcUNovACE4GzGHljpWj9YZf/7opO1CJrly
         7o47rgZJPT54DRZG+4L7gqVfau8CZ2zQfMwfB4ZhAIO+Tne+HePYSMWgEZAkRvAMA512
         9lI6k5brPOKsx+uq330yvdoC1wp00kFcAYc8dyG+Bj/UhkA7fc6rqHt0FOw6P/13sHWf
         f1Jg==
X-Gm-Message-State: AOAM532wf/5RAtagqEwhEP7lIrhVvY5nwsckfg7TM6uVudkSIj/zekJl
        OaDSuhkAUVZyzrRJvaa8Ctf28ziT5Ywm37EqCxil8Xc1jGA=
X-Google-Smtp-Source: ABdhPJzNG+xUeQJK68k2+VKbvUkWsR05YLsvpxlIL6CS720HLPO2GE7qVZryQsxh8DMGNr0alYUBNJ6l3D557mJaidQ=
X-Received: by 2002:a05:6102:418c:: with SMTP id cd12mr3084818vsb.83.1644518220366;
 Thu, 10 Feb 2022 10:37:00 -0800 (PST)
MIME-Version: 1.0
References: <xmqqczjvxy3o.fsf@gitster.g> <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
 <xmqqiltmwufw.fsf@gitster.g> <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
 <xmqqh796tw34.fsf@gitster.g>
In-Reply-To: <xmqqh796tw34.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Feb 2022 19:36:49 +0100
Message-ID: <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 7:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > On Thu, Feb 10, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrot=
e:
> >> >>    One thing that makes me worried somewhat is what I did not touch=
,
> >> >>    namely, how pseudo refs are defined.  I know MERGE_HEAD is very
> >> >>    special and it may be impossible to coax it into refs API for
> >> >>    writing, so the text there makes sense for it, but there are
> >> >>    other all-caps-and-directly-under-dot-git-directory files like
> >> >>    ORIG_HEAD and CHERRY_PICK_HEAD that are written using the refs
> >> >>    API, so the description would have to be updated there.
> >> >
> >> > I'm not quite following; why would the description need to be update=
d?
> >> >  Sure MERGE_HEAD is written without using the refs API, but we didn'=
t
> >> > mention how the pseduorefs were written in the description, and all =
of
> >> > MERGE_HEAD, CHERRY_PICK_HEAD, ORIG_HEAD, REVERT_HEAD get written
> >> > per-worktree so doesn't "pseudorefs like MERGE_HEAD" cover it as far
> >> > as the reader is concerned?
> >>
> >> Here is how pseudo refs are defined.
> >>
> >> [[def_pseudoref]]pseudoref::
> >>         Pseudorefs are a class of files under `$GIT_DIR` which behave
> >>         like refs for the purposes of rev-parse, but which are treated
> >>         specially by git.  Pseudorefs both have names that are all-cap=
s,
> >>         and always start with a line consisting of a
> >>         <<def_SHA1,SHA-1>> followed by whitespace.  So, HEAD is not a
> >>         pseudoref, because it is sometimes a symbolic ref.  They might
> >
> > refs.c says
> >
> >         if (is_pseudoref_syntax(refname))
> >                 return REF_TYPE_PSEUDOREF;
> >
> > Ie. ref_type("HEAD") =3D=3D REF_TYPE_PSEUDOREF
> >
> > This may be partly my fault (commit 55dd8b910 "Make HEAD a PSEUDOREF
> > rather than PER_WORKTREE.").
> >
> > From the source code I had only understood that pseudorefs are ALLCAPS
> > names and are in the toplevel namespace.
> > (HEAD, FETCH_HEAD and MERGE_HEAD have special-cased support in various =
places).
> >
> > Is this glossary the official definition of what things are? If so,
> > the source code should refer to there. If not -except for confusion-
> > how bad is it if the info in the glossary is inaccurate?
>
> Developer and end-user confusion ensues.

that's why I said: "except for confusion" :-)

I'm asking to understand if there is anything stopping us from
changing the glossary to match the current code.

> For backward compatibility, "git merge FETCH_HEAD" still may have to
> work the way it does (i.e. if FETCH_HEAD has multiple lines, the
> resulting merge would become an octopus merge, and merge message
> will say not just the commit but mention where they came from).  But
> I am not sure if it is essential for us to keep treating these
> oddball temporary files as if they are (sort of) refs.

on a tangent: I posted a patch to write MERGE_AUTOSTASH,
rebase-merge/autostash, etc. as refs.
Is that the right direction? They are read like refs, but they are
together in a directory with other bits of stateful data (similar to
what is appended to FETCH_HEAD). Perhaps I should rather change the
read path, so they're always read as files rather than refs?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
