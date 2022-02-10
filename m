Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7AEC433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 18:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbiBJSHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 13:07:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiBJSHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 13:07:35 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234C25CD
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:07:35 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id w207so3042038vkd.2
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 10:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kVPi2Aqj78vOBXRPqTIb/2PFRyEYkVKfLTrjb2VhblA=;
        b=fqagP96mwWeRwq+WBbybQySa3/aWm4WwDGaT086/OVUd6q/dt+5UFMWfFfrfIIvfas
         tROCpWVYCFG2cI0Lm6/g4BU0OspfW+uoUhgSiz7gnrqOGhNazfL9mayn+LgjyGRbeMWz
         nI/hd/xpJ2AaYs9U4BeytFMF/b+LspB4YEV0k9zUbetNOTgEiHXdnoYQHTjitXuOrXCo
         s33l/H4BAC7fF00Pe4stgvjdWJkpnIta84S2ygto0XrwwLJRgzVjxDIUQA58c9oJbp9P
         GJ7n6YBsa+fDLPjKjAmJyAbwh/NeyAq2okbwGB0JgVnKpP2ZWtiU/4dV+zSeAh65sx4p
         imeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kVPi2Aqj78vOBXRPqTIb/2PFRyEYkVKfLTrjb2VhblA=;
        b=GXyWHNaSatO1mY16td8sCAf4O9ILCqKoYVSQAF9IXPK+X80SEb/MWD+YVbgxz7gxDh
         BKtvGgBlHtqShzngX/jT/nFNZtiDfYcCYfjG9qTLayi2uCWmM/qEVQzhDXVxxPkN0RrQ
         /ke7ArKnzZGPSCcIqJWmYb+tnkFeKWG6gDS9srWpTLdVccZC7/423CpIfEtIs5AhwFDI
         24JOBSb2arRdnKud9Pzq+bEZDAr+c/+/8VBFvFCcsPE7jtbz7byXLIH94H8PuCn5NdPH
         w1BrJR24riU7/+Fb6bFsWbMaCwWS7VvnJEIiV0tr1M3NCn00WNWk+6/oIjI2ImkanHP2
         czUg==
X-Gm-Message-State: AOAM5315SoM1+tIdfX/YExp1IqXigEYp7+DPfiUo8FHT4iw+Gcpvjn+4
        EXfBwzQUhjT6aP1wGx3SKHA+LpcwW9gOKoxzA0AbPA==
X-Google-Smtp-Source: ABdhPJydi8Fnnn9V92cHN9YcfHdLceUkCIUdrAUfg2U9r+qpflCqg7ZDkmdh97iWJqonERvoTSjdKk1d1fNpeNBzVCQ=
X-Received: by 2002:a05:6122:7c8:: with SMTP id l8mr2943631vkr.7.1644516454341;
 Thu, 10 Feb 2022 10:07:34 -0800 (PST)
MIME-Version: 1.0
References: <xmqqczjvxy3o.fsf@gitster.g> <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
 <xmqqiltmwufw.fsf@gitster.g>
In-Reply-To: <xmqqiltmwufw.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 10 Feb 2022 19:07:22 +0100
Message-ID: <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
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

On Thu, Feb 10, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
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

refs.c says

        if (is_pseudoref_syntax(refname))
                return REF_TYPE_PSEUDOREF;

Ie. ref_type("HEAD") =3D=3D REF_TYPE_PSEUDOREF

This may be partly my fault (commit 55dd8b910 "Make HEAD a PSEUDOREF
rather than PER_WORKTREE.").

From the source code I had only understood that pseudorefs are ALLCAPS
names and are in the toplevel namespace.
(HEAD, FETCH_HEAD and MERGE_HEAD have special-cased support in various plac=
es).

Is this glossary the official definition of what things are? If so,
the source code should refer to there. If not -except for confusion-
how bad is it if the info in the glossary is inaccurate?

> What worries me the most is that we cannot simply say "all-caps
> names that end with '_HEAD' all behave like refs except that they
> will not be symrefs without reflog." MERGE_HEAD is the only known
> exception if I am not mistaken, and I am OK to single it out as an
> oddball.  The current description however gives that there are a lot
> more differences _among_ pseudorefs.

It might be possible to add this extra info the reftable format as a
further subtype of the ref record.  We'd have to update the JGit
implementation, though.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
