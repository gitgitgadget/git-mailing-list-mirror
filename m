Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-13.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F91E1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 17:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbeKUEP4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 23:15:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41128 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeKUEP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 23:15:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so1946067lfj.8
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 09:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A4mwPuUmTcnfKsLvz1aH/pBLigsGsXKFpBrTMVjrykQ=;
        b=HXy4wshC01YVBfrlFShGVqGuytuNUAuRDxOf1hRSGQLWdtjwLHsyifbsuiM9I1kjKi
         UcV6pMjOi0aoPdmBC4oeQEnnHfj8ES4uHFkpQHPJdzalwWVKDP7pxeu8zeK/eSEDyd+h
         k7dcZnOorw9nx3izWJG2QIIKma8NnGUzb3ZcMrKXhFQqcpGQ8f5wAfTkoi/xgsOSYSA7
         IXZ40il3X8DJrZIPTH0rmkKQKppP+h3IoLS9IQj87fWVOqwp4gjG1Apc6rKQH1rOlNHe
         W0fYVoYkHwU99Ar0djym5BQ+EeJ4VnhCxnd0rV24KrrsbzcxUwbIJk3+y/XDvDMqGI5D
         6pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A4mwPuUmTcnfKsLvz1aH/pBLigsGsXKFpBrTMVjrykQ=;
        b=LXYkBGAt9mbfGkwJ1RuVlZKnph7ckRWfR6nVIQvmOMLu8sT3Q9TNkDFAdHykWP1znF
         2QazxDkvOoroEys6kosq8Ubwg9xAQJeAlVM8ER6gUnntTPvR1yniEoeJIxxdbiYvhXIL
         s7UYRw89iVfDDjdwvfOMkSBsc8Ay4srFU0ZONgrd4/zBJn3uPlzHLFOQkPmd8hy8AcXl
         lSBoq1lhqfNLUhABEVwOm2Rp2WC75Sefwl+FMCTt6UP3+HXtkIE/s7wdLHyQiuiQAzZI
         WK9jqktHpUFj3sN4nDsQROX2RV/4HvmzZt0ZlIB+hMKnogSBLh4BeZHr4PPQdKyFboNX
         mCpg==
X-Gm-Message-State: AGRZ1gKBWo+Vua7ThWdyzJKjAJQRXF+zEIjcyTwCyfO5oSyjIp+S7oMN
        ZZXvh0+FM7qMZW2P+3EQ1Y7Rn+VnaMCKfPSznUNfnw==
X-Google-Smtp-Source: AJdET5fuJCtbCahG7qG/8NXZniBNJ9OFb+dqb36uYSMwGmfN+gzvhe1soz6X3d2CoeilVZm457nWWiQ/vyxQQTJhgGI=
X-Received: by 2002:ac2:4215:: with SMTP id y21mr1665274lfh.6.1542735933338;
 Tue, 20 Nov 2018 09:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <87r2fm1hey.fsf@evledraar.gmail.com>
 <20181120011841.GB62243@google.com> <87r2fgyth8.fsf@evledraar.gmail.com>
In-Reply-To: <87r2fgyth8.fsf@evledraar.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Tue, 20 Nov 2018 09:45:18 -0800
Message-ID: <CAPL8Zis6Jz3=Jb0JxuSyHczYQrrrqP3JGiov1ZuH2A_0x=dpVQ@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This sounds like a proposal for general namespacing. I like it - that
would pave the way for other header extensions - but that should
probably be the subject of a separate proposal (who owns the content
of a namespace, what is the process for adding a new namespace or a
new attribute within a namespace, what order should the header
attributes appear in, what problem is namespacing there to solve, when
do we use a namespaced attribute versus a "reserved" attribute, etc.).

x-evolve-pt seems reasonable to me. If you're keen on this and want to
document the namespacing proposal, I'll conform to it. However, if
don't have formal rules for namespaces in place yet it might be better
to avoid the use of an x- prefix for now, just in case I accidentally
squat on a name that breaks whatever namespacing rules we eventually
come up with.

Since we're talking bytes, a more compact representation of
parent-type could use single-letter codes:
x-evolve-pt c r o
(where c=3Dcontent, r=3Dreplace/obsolete, o=3Dorigin)

  - Stefan
On Tue, Nov 20, 2018 at 1:43 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Nov 20 2018, Jonathan Nieder wrote:
>
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> On Thu, Nov 15 2018, sxenos@google.com wrote:
> >
> >>> +Parent-type
> >>> +-----------
> >>> +The =E2=80=9Cparent-type=E2=80=9D field in the commit header identif=
ies a commit as a
> >>> +meta-commit and indicates the meaning for each of its parents. It is=
 never
> >>> +present for normal commits.
> > [...]
> >> I think it's worth pointing out for those that are rusty on commit
> >> object details (but I checked) is that the reason for it not being:
> >>
> >>     tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
> >>     parent aa7ce55545bf2c14bef48db91af1a74e2347539a
> >>     parent-type content
> >>     parent d64309ee51d0af12723b6cb027fc9f195b15a5e9
> >>     parent-type obsolete
> >>     parent 7e1bbcd3a0fa854a7a9eac9bf1eea6465de98136
> >>     parent-type origin
> >>     author Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> >>     committer Stefan Xenos <sxenos@gmail.com> 1540841596 -0700
> >>
> >> Which would be easier to read, is that we're very sensitive to the ord=
er
> >> of the first few fields (tree -> parent -> author -> committer) and fs=
ck
> >> will error out if we interjected a new field.
> >
> > By the way, in the spirit of limiting the initial scope, I wonder
> > whether the parent-type fields can be stored in the commit message
> > initially.
> >
> > Elsewhere in this thread it was mentioned that the parent-type is a
> > field to allow tools like "git fsck" to understand the meaning of
> > these parent relationships (for example, to forbid a commit
> > referencing a meta-commit).  The same could be done using special
> > commit message text, though.
> >
> > The advantage of such an approach would be that we could experiment
> > without changing the official object format at all.  If experiments
> > revealed a different set of information to store, we could update the
> > format without having to maintain the memory of the older format in
> > "git fsck"'s understanding of commit object fields.  So even though I
> > think that in the end we would want to put this information in the
> > commit object header, I'm tempted to suspect that the benefits of
> > putting it in the commit message to start outweigh the costs (in
> > particular, of having to migrate to another format later).
>
> I think it sounds better to just make it, in the header:
>
>     x-evolve-pt content
>     x-evolve-pt obsolete
>     x-evolve-pt origin
>
> Where "pt =3D parent-type", we could of course spell that out too, but in
> this case it's "x-evolve-pt" is the exact same number of bytes as
> "parent-type", so nobody can object that it takes more space:)
>
> We'd then carry some documentation where we say everything except "x-*-"
> is reserved, and that we'd like to know about new "*" there before it's
> used, so it can be documented.
>
> Putting it in the commit message just sounds like a hack around not
> having namespaced headers. If we'd like to keep this then tools would
> need to parse both (potentially unpacking a lot of the commit message
> object, it can be quite big in some cases...).
