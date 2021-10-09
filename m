Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE95C433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F3260F6C
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 09:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhJIJfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbhJIJfB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 05:35:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B2DC061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 02:33:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v11so5548730pgb.8
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kacw/2OtgRcWtMDDQGMCZFyzuLTeZ4T/O/bTeyPE5ac=;
        b=jXwWmk+JjSuWRFE2YgJm0XSiNwmbKCLesYXeQa2oWhIKE7bO2Z/v8SvtVwirx34Vkh
         fbWFJZ+OXq4AmSaVCgZ/FhDMv/30ieNnX6Dr9kmZ4Qcf6zUuihLKvIr7PtS1ORm8PB1Z
         MWssjt+vY8ri+gQaELxjbcMq3VI2NoAxbkpL7qTyJh2iXRFuvqasccjZuZi1ilT4lyCa
         CKjZE1RNQEY/ZpuWpfsU+odf1Bol4zs3MMzy13cus1N9vtpu4SaNwO4IoKkIpyDgji76
         JdxZF9jxw3E8nsemySSedWXoJI95PdWvhN90jhJa3EaWf2dDGiqHlOHGpXuAHlIrJ+g0
         P/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kacw/2OtgRcWtMDDQGMCZFyzuLTeZ4T/O/bTeyPE5ac=;
        b=CfLj23gY+vo29jrWwS8ocze4l8NHXI0u4oIe28getHJst6iM54zS21aF/9C9//ffky
         RL26vJofXv33Xf2dLdbgTxSqnBXfuDj/XJGmI9r8ihSDo6zUk08vThNZXzY9yfgI+lN2
         Cn55FnQK8yPY45ZAyU6hMEhrJCR86h7DOEmKq/ebIYmGZiURFiRbRfZWv4cJTTfATjX5
         /f9CHEb3oDhRNP+PRRRJIc/TUhf9t7jiSLTNJMUAVTdBjTmCblNkWLQO/RJBOKm+BHxU
         Rf68d/KE2mgYTYgJUCpMtaVnLYj6Fai2exL3tfrsaowQEvzdFUa72xcPLaeE7hbJRa0J
         Dlyw==
X-Gm-Message-State: AOAM531j/c+h1EdUEO+23upBMjmbmnqU0qjDrdniOpe3JIj1vUU8YZUK
        HYn5c9dX+J75dPQ+45xrASx9inQK4Os1FF/u2de7c9lFOBI=
X-Google-Smtp-Source: ABdhPJwyhGl0Cn0IxgJPmpvd6v3pgO8pKa5zzluwWaWwireu334vn2W0f13DCWpUbYVF27AvTveUnWFi/rahF3xU2bI=
X-Received: by 2002:a1f:2d83:: with SMTP id t125mr13379679vkt.23.1633771973983;
 Sat, 09 Oct 2021 02:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211007033652.80793-4-tbperrotta@gmail.com> <20211009083133.4446-1-carenas@gmail.com>
 <1d6ec04f-6f89-5da6-75a9-3099e2437df5@gmail.com>
In-Reply-To: <1d6ec04f-6f89-5da6-75a9-3099e2437df5@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 9 Oct 2021 02:32:42 -0700
Message-ID: <CAPUEsphrNMPO_KaAmae02-DsxB9m1tBEK_Gnv29_mLQn0j2MkA@mail.gmail.com>
Subject: Re: [RFC PATCH] Documentation: better document format-patch options
 in send-email
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, tbperrotta@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 9, 2021 at 1:57 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 09/10/21 15.31, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> > -2. Generic <revision range> expression (see "SPECIFYING
> > -   REVISIONS" section in linkgit:gitrevisions[7]) means the
> > -   commits in the specified range.
> > -
> > -The first rule takes precedence in the case of a single <commit>.  To
> > -apply the second rule, i.e., format everything since the beginning of
> > -history up until <commit>, use the `--root` option: `git format-patch
> > ---root <commit>`.  If you want to format only <commit> itself, you
> > -can do this with `git format-patch -1 <commit>`.
> > +2. A Generic <revision range> expression that describes with
> > +   options and revisions a range of commits.
> > +
> > +If you give a single <commit> and nothing else, it is taken as the
> > +<since> of the first form.  If you want to format everything from the
> > +beginning of history up until <commit>, use the `--root` option:
> > +`git format-patch --root <commit>`.  If you want to format only the
> > +<commit> itself, use instead `git format-patch -1 <commit>`.
> > +
> > +If you want to affect a set of commits, provide a range (see
> > +"SPECIFYING RANGES" section in linkgit:gitrevisions[7]).
>
> Supposed that we have following commit graph:
>
> a --- b --- c --- d --- e --- f (main)
>              \
>               --- g --- h --- i (mywork, HEAD)
>
> According to your edit, `git format-patch <c>` and `git format-patch
> --root <i>` are equivalent, right?

I didn't change the definition of --root with my edit, but I guess it
is still confusing.

the beginning of history from your tree is a, c would be a "fork
point" AFAIK, but if you use --root will get 6 patches (a, b, c, g, h,
i)

> > @@ -18,8 +19,8 @@ DESCRIPTION
> >   Takes the patches given on the command line and emails them out.
> >   Patches can be specified as files, directories (which will send all
> >   files in the directory), or directly as a revision list.  In the
> > -last case, any format accepted by linkgit:git-format-patch[1] can
> > -be passed to git send-email.
> > +last case, a revision in a format accepted by linkgit:git-format-patch=
[1]
> > +as well as relevant options must be provided to git send-email.
> >
> >   The header of the email is configurable via command-line options.  If=
 not
> >   specified on the command line, the user will be prompted with a ReadL=
ine
>
> Did you mean that in the second form of git send-email, only
> format-patch options are accepted?

The synopsis shows "send-email options" are also allowed (as
optional), the mention of "relevant options" here was to indicate
additional options from git-format-patch which make sense (ex: common
diff options, --root, or the options from the range section of
references).

The truth is that you can actually do files, directories and revisions
now, but that is a bug.

Carlo
