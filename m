Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95DE20248
	for <e@80x24.org>; Mon, 11 Mar 2019 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfCKS2R (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 14:28:17 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:43310 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKS2R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 14:28:17 -0400
Received: by mail-vs1-f65.google.com with SMTP id u6so511754vso.10
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z5QXF3nNFtDNNO2vUVdlhNjB3rmz/sdgiaN5EHyDlsc=;
        b=tOfRBJCqEBSafdQlzASo2lHRE6Bv0wJXwYu6zrIlhw/zRzK2lQLni6JHxDudELuh0d
         eGB/BgGHjWuSKFi+TWYA4+E/F7LmAaRiJqEuomP2C/cwj3b0aPLo5+yrTHJz/Vqo9uqy
         CeVbJQMlCXJrOAp3mfKHN5dxdTytCEshAZD6UDkG0b2U1j/ZkJkArW5COOhYPFbKRl8m
         uG57CiwbotrSv315dNxiCjNhRNDy8uccs6v8eUB5WLZvhHXFPI6v/dUKkigpwam0kHfv
         Q3lDDWI6oTQ+mbPUsK45xQnkIMG1+HhszSv7JGm2IEvkM/xoIXyCJ00UB8jWFol2UViW
         zalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z5QXF3nNFtDNNO2vUVdlhNjB3rmz/sdgiaN5EHyDlsc=;
        b=h8PVjUja0r6DMeD6sblO35uRAg//rt+VuC5qQmiRHD077PKN5NltWwW2YgIOEI2/4J
         I5UZ+zBOdzluRTWyczH70BEArZLGCZ15Hlk+wrTpWTEpFuLK9uLsNUuLCYUSf3JoEsuY
         YnKJgmDRLclLHB+VNBF3YSDy7uepsYf0uJmhKtUrQNEKJ9+TAqQ1jOEMTnvorHQsZ6aX
         r9bpfBg9Yw72wl4ssPXI7DljRa6oKhIPQKuCX0/mM/7ZgD1Wc4hnTAmx3TwVbBLILxNt
         uxhzdg9iAYVDHIPCn1yorV2l1fu3fuA+92MLfx3N8i8vDdCjctTN8k8w+pZNx85yUK7X
         1lCw==
X-Gm-Message-State: APjAAAWb/0h8lGHgjrdjApPmInvXF2K6MbH8W4LsncZXf0d4E4HJEz6f
        2UdfU3snk9Wiyg2Ja2VdkOiYXAUyPvjG+BZoUKE=
X-Google-Smtp-Source: APXvYqwuEdVwr3Sho41ifXCCtUIhq/Sni3ONIrVK9z8ajeySTEwv+Hws5+4Ml1TFQPtJ01sietmXol5bEaKS+Wusk7g=
X-Received: by 2002:a67:fa46:: with SMTP id j6mr17922603vsq.117.1552328895786;
 Mon, 11 Mar 2019 11:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-11-pclouds@gmail.com>
 <CABPp-BGbqYUMEK0V_m0i7dpFb38Mm3sS-h0Ut-GSdvsKEZzRQg@mail.gmail.com>
 <CACsJy8DeGQ=GRnRByNQ18Npe5JEcRXBf2oK3Xg6uv44OCg_EBA@mail.gmail.com> <CACsJy8ASZ2jcrk7jf+5p0yCk9bLy-8SJmQyEjG9TSULhd+GhaQ@mail.gmail.com>
In-Reply-To: <CACsJy8ASZ2jcrk7jf+5p0yCk9bLy-8SJmQyEjG9TSULhd+GhaQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 11:28:04 -0700
Message-ID: <CABPp-BEv1taYym_084qVJj3-jkWWS9hKXZ=grrmH7PDUb5ASwA@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] completion: support restore
To:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

// CC'ing Thomas since this touches on a thread elsewhere about the glossar=
y

On Mon, Mar 11, 2019 at 8:40 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 10:22 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Sun, Mar 10, 2019 at 2:17 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Fri, Mar 8, 2019 at 2:17 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> > > >
> > > > Completion for restore is straightforward. We could still do better
> > > > though by give the list of just tracked files instead of all presen=
t
> > > > ones. But let's leave it for later.
> > >
> > > s/give/giving/
> > >
> > > I'm slightly worried that due to using --no-overlay mode by default i=
n
> > > restore, having tab-completion include untracked files increases the
> > > risk of accidentally nuking the wrong file.  restore is a destructive
> > > command anyway and should thus be used with care, so perhaps this
> > > isn't a big deal, but I thought I'd mention it.
> >
> > This makes me think about my "git restore :/" example, which does not
> > remove untracked files because its source is the index. But isn't it
> > inconsistent that we only remove untracked files with --source and
> > keep them without? Will that just confuse people more? Or did I just
> > forget to implement no-overlay mode for the index too?
>
> Nope you confused me. non-overlay mode never touches untracked files
> and so neither does git-restore.
>
> It does make the description of git-restore about "remove if paths do
> not exist" incorrect. But frankly I find it hard to explain
> non-overlay mode with the index being the remove filter. In
> git-checkout, where we update both index and worktree, this may make
> sense to use the index as the remove filter. But worktree works on the
> worktree only by default. I'll need to sleep on this.

So, I guess this means that my addendum to Thomas' glossary entry for
overlay is wrong; instead of:

[[def_overlay]]overlay::
       Only update and add files to the working directory, but don't
       delete them, similar to how 'cp -R' works.  This is the default
       in a <<def_checkout,checkout>>.  In contrast, no-overlay mode
       will also delete files not present in the source, similar to
       'rsync --delete'.

the definition should be (note the insertion of 'tracked'):

[[def_overlay]]overlay::
       Only update and add files to the working directory, but don't
       delete them, similar to how 'cp -R' works.  This is the default
       in a <<def_checkout,checkout>>.  In contrast, no-overlay mode
       will also delete tracked files not present in the source,
       similar to 'rsync --delete'.

...and perhaps the reason this makes it hard for you to explain when
the index is the source is because this definition means there is no
difference between overlay and non-overlay mode for that specific
case.


Am I on the right page now?
