Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5323E1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeIIMut (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 08:50:49 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45630 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeIIMut (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 08:50:49 -0400
Received: by mail-io1-f66.google.com with SMTP id e12-v6so4627421iok.12
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt4j4XCKZvujosd+U3jJ0oSMrcF9iZ4XXPBNaPQlJOw=;
        b=i6j7Vv4EZEc6P80oX2K8M8lIRXLxBpjR4zv3yB/wUn9lt+amcI3gdi2o9QyxFfncxt
         SqxzfKA1EJ2G2Er6Fmtg91vCyap83biyoy3LYH4+WAuXw+Hlm4UhtOlMU8Qx8Ax8uZYW
         KiJkOUwCNCk+ERgwCBbPirBUtvJ/eN/RX9LUjYQfHzH8iTm9WZ70bst7kt1pJrmw9w/4
         YMta4G6r0KpDNb3dgifXwQTbsBC28zKx6bebDOwt/itAZZ2s7cMH66KMm5gDqaZnUHKx
         EFA9zgpW+YQ5TyB/2DG/wQ9iQmvdCqPOZ3n5QTwlI/SrKORuEaNIxBbH2ZavKIDcf/tT
         0r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt4j4XCKZvujosd+U3jJ0oSMrcF9iZ4XXPBNaPQlJOw=;
        b=oVkvEkDJDPdvLfrMnemez0oRxBF6qebNHurl5Us0EqzimMogdvWWOjq3KO1MjB92XO
         SdXN+eHunVG13RvdwA8uVWK4uUZ6y94KAcEyGq5zJCbm9qvhI5/1Gvcn7fjZvN+SmtQ/
         aAxXk3KzJPGExBQt/JFf4ptPQ0ovDJdaljFFonPHqTfPikymxgOgWWpLPX8uSfyms457
         dtfidTUX8vQgU266W9DfvXZhZV4jCKEuZWnQvCnUkG3+1fkO5Cl5x91lfizTnF/iLNSB
         yb1vqaM1/glOskc0uWkF8XhcFwRog1zlxVCfEwzkqWPkVSVKGAH7ZgOk+O3D0+OmErbZ
         7BBg==
X-Gm-Message-State: APzg51AC2rySpfS/DDnxdX9tn3jSX0FOLEk5TkeoPS8v5PpK+EVS5DZL
        l8QwBs86gBk/ZJYL7fo0lrbjqEu0XHCKEMg1X5Q=
X-Google-Smtp-Source: ANB0VdbjSrFN2572vo9j15Vhy0gWBDMjbwQreedmPDPqf15QoYZ9/rF3rJ0oGRtFpKmOaLq76X/vCayPhnSjKBke2Ik=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr11431538ioe.282.1536480120767;
 Sun, 09 Sep 2018 01:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-13-pclouds@gmail.com>
 <CAGZ79kb=gcmEDGmTS-j-veFj8BgKup0g96i0Gm1P+j8eyX8_mQ@mail.gmail.com>
 <CACsJy8D9ZMGA8FDmgcNMbWH7VP5O8bfn7tLnXda2TcQKmLM5NA@mail.gmail.com> <CAGZ79kYBg62votOkFmpWjFoR_s2WZq-cSvXa==EP1q22WNEKpQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYBg62votOkFmpWjFoR_s2WZq-cSvXa==EP1q22WNEKpQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 9 Sep 2018 10:01:34 +0200
Message-ID: <CACsJy8AqV63N9Xiu=ha+rqjriStNFdR3NyLZ_yoRqFNChKTHaQ@mail.gmail.com>
Subject: Re: [PATCH 12/21] patch-ids.c: remove implicit dependency on the_index
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 9:54 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Mon, Sep 3, 2018 at 11:03 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Mon, Aug 27, 2018 at 9:13 PM Stefan Beller <sbeller@google.com> wrote:
> > >
> > > > -int init_patch_ids(struct patch_ids *ids)
> > > > +int init_patch_ids(struct patch_ids *ids, struct repository *repo)
> > > >  {
> > > >         memset(ids, 0, sizeof(*ids));
> > > > -       diff_setup(&ids->diffopts, the_repository);
> > > > +       diff_setup(&ids->diffopts, repo);
> > >
> > > Just realized when looking at this diff, though it applies to
> > > other patches as well. (and reading Documentation/technical/api-diff.txt
> > > confirms my thinking IMHO)
> > >
> > > What makes the repository argument any special compared
> > > to the rest of the diff options?
> > >
> > > So I would expect the setup to look like
> > >
> > >     memset(ids, 0, sizeof(*ids));
> > >     ids->diffopts->repo = the_repository;
> > >     diff_setup(&ids->diffopts);
> > >
> > > here and in diff_setup, we'd have
> > >
> > >   if (!options->repo)
> > >     options->repo = the_repository;
> > >
> > > or even put the_repository into default_diff_options,
> > > but then I wonder how this deals with no-repo invocations
> > > (git diff --no-index examples for bug reports)
> >
> > That makes "repo" field optional and I'm very much against falling
> > back to the_repository. revisions.c in the end does not have any
> > the_repository reference, and it's actually undefined for most files.
> > This makes accidentally adding the_repository back much more
> > difficult.
>
> Thanks for the clear explanation. I agree that this is a good approach
> with these reasons given. So in case a resend is needed, maybe add
> these to the commit message, as it explains why we deviate from
> the pattern here.

Actually I looked at it again and diff_setup() clears diffopts as the
first step, so any assignments prior to the diff_setup() call has no
effect.

> > Yes the --no-index stuff will have to be taken care of at some point,
> > but I think for now we could just put "struct repository *" in place
> > first to see what it looks like, then go from there.
>
> I would think repo = NULL would do? But we can defer this
> discussion to later.

Yes. But the the_hash_algo currently points to
the_repository->hash_algo. We need to at least make the_hash_algo
independent from 'struct repository *', then figure out how to set
the_hash_algo without $GIT_DIR/config file...
-- 
Duy
