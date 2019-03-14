Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B8920248
	for <e@80x24.org>; Thu, 14 Mar 2019 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCNOrE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 10:47:04 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38505 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfCNOrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 10:47:04 -0400
Received: by mail-vs1-f65.google.com with SMTP id h132so3404845vsd.5
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVaP+lYB4vATcVvh6gWRJBGFc/e+2uUXVW4p3rX9kAA=;
        b=himpJbQPlIy0VqXpMmy4n2NhOds0zNNhJjqpoyxn0I+ZD3G4mJ3PSif2zlWdeWzlID
         m3XlV2qB5ugB6TSP0P6jl/fNReI6ZxviTsQ6RJx6DVpqeGzaoKs4ghSoJmT6Fch6Winr
         6o30Ohd/tk8z5zCFoLfrjEVGyahmx+y9rM6wYgf/Q755IsVa14m/uS5iac8PxbY0royM
         11Xw6GbqMx9A+ASexxhCcQs7UDRl3l+SW0MP3WEja/xrPPYe3+LgtvVCYqXDMR/xFVAk
         T6/063ZrLBMbuzbgNZ7ZUp/s4LRDQ1iB0CtNzXUOZgxEVsQQr9pORiqSRY/lwTr5+Zqp
         qweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVaP+lYB4vATcVvh6gWRJBGFc/e+2uUXVW4p3rX9kAA=;
        b=Fjv4FuHUvX/4vAvpIardosBmtuPtRap9vu8FbhVymBvFoAdmR5abOWR9thI9//Fr79
         nvp/YTVyaViCPBlmJOvsLrHOJyrZHrDUb2RZ7ulycYfRCzUTeAqSUkNijgMe7s/TPaw1
         /Ol9CRwl2ML2VtioYpYCKQURbOOOPNR3stkgz5XfWPkF0muRgEFeMu4fGMGJ6m0/lHPg
         bPnuOYoiNW7gG69HXwiqT8irMi3fUSmfJOxMwEaYaCeV0+S5PPQPR73YeKAGkJvLpdoP
         XiXvg3/4+nObqHyz1FGhtS6TkaAGLIqhY1PFG1mLkFuP7CFBNLpMqZuPK12A4jd4x7jA
         eBZA==
X-Gm-Message-State: APjAAAUQQtyf6+5JX62WmJPVoqqafgWMFfURAzveS4vXG/MhIAEzsYiu
        8gmnzq8rchdIK3CB27/kamBIig1ZPPGkwMDOkV0=
X-Google-Smtp-Source: APXvYqyL5ZIswzbwGhb69KEqOhXsnU/U7y7ROzKbd+dvqKHmRHUzj9kS1chKHEpVfM+ZCdA8xaBeF5w4hc0yLo1MgYo=
X-Received: by 2002:a67:eb97:: with SMTP id e23mr27524112vso.175.1552574822638;
 Thu, 14 Mar 2019 07:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190308095752.8574-1-pclouds@gmail.com> <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com> <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com> <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com> <20190314091753.GA9852@ash>
In-Reply-To: <20190314091753.GA9852@ash>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 14 Mar 2019 07:46:51 -0700
Message-ID: <CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 14, 2019 at 2:18 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Mar 12, 2019 at 01:28:35PM -0400, Eric Sunshine wrote:
> > > > Again, not much of a datapoint, but I do use --orphan periodically.
> > > > The idea of "fixing" the behavior so that --orphan starts with a clean
> > > > slate is certainly appealing (since it matches how I've used orphan
> > > > branches in each case).
> > >
> > > The only three people who have commented on --orphan in this thread
> > > all apparently feel the same way: the current behavior is wrong.
> > > Maybe we can switch it to start with an empty index after all?
> >
> > Starting empty may match intuition better. (More importantly, perhaps,
> > it's harder to come up with a use-case for --orphan which doesn't
> > involve starting with a clean slate.)
>
> OK so the new --orphan description would be like this, right?
>
> --8<--
> --orphan <new-branch>::
>         Create a new 'orphan' branch, named `<new-branch>`. If
>         `<start-point>` is specified, the working tree is adjusted to
>         match it. The index remains empty (i.e. no file is tracked).
> -->8--
>
> I was wondering if instead of the empty index, we mark on files from
> <start-point> as intent-to-add. That way "git commit -a" achieves the
> same as before, but you could still carefully craft the new index and
> "git commit". Dunno. Not going to implement it unless somebody says
> something, since I rarely (if ever?) use --orphan.

I don't see why <start-point> even makes sense to use with --orphan;
you should error if both are given, IMO.  The point of --orphan is to
create some entirely new history.  So, I'd expect "git switch --orphan
<new-branch>" to:
  * not create refs/heads/<new-branch>
  * set HEAD to refs/heads/<new-branch>
  * empty all tracked files from the working tree.
  * empty the index

Alternatively, you could allow <start-point> to be passed with
--orphan, adjusting the above steps so that both the index and the
working tree are switched to match <start-point>, but ONLY if
<start-point> defaults to the empty tree when --orphan is passed.

> I may need someone to come up with a convincing commit message
> too. All I've got is "I've been told this is a good thing to do" :)

How about:

"""
Switching and creating branches always involves knowing the
<start-point> to begin the new branch from.  Sometimes, people want to
create a new branch that does not have any commits yet; --orphan is a
flag to allow that.  --orphan overrides the default of HEAD for
<start-point> instead causing us to start from an empty history.  The
use of --orphan is incompatible with specifying a <start-point>.
"""
