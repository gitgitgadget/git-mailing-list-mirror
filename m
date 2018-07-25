Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA931F597
	for <e@80x24.org>; Wed, 25 Jul 2018 17:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbeGYS53 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 14:57:29 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33268 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbeGYS53 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 14:57:29 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so3311283ybb.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 10:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rY10CjKLFK3hsCFtbcgQ6AX0H+kgM5lcuZ2wHaZtdfg=;
        b=XFq+wmLRTf0HsSg1Q1/gU3FRozdnCSGlW/jKe2G92vp309YpGV4WPwMhGRT7CzHPSW
         Z2DrQaqEfVkjGmuAhiS3Uc2JiVA2+eea6d4oAKA8tGN+3EnfaJ5WWXemX4S5mh0BAH+m
         lgt5fH8V/SwdWfp2yVkLJM2c4JB+tBOxXG/CTy5awztXE6/oRuubTHyiAJ0bjsf6c/Xf
         J3PQINWvfIDohsL5BtblsIqVUcYVAConbdhUAO9Zv4w0Rx+7udjd6fOaDFt2Qt+XPy/3
         TeoWbUPmkdItH0DXAnhXmCJHkP9d16/IrfDuhD4HTpnjXycYkj3gFJju66E9KAa6k+UY
         3u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rY10CjKLFK3hsCFtbcgQ6AX0H+kgM5lcuZ2wHaZtdfg=;
        b=GR0iMdA6mJ9+SmaPrUdFZT0Q5rlCfvqlnLn763A8PKitLZH/GaTlhMdWvKay8mrjhN
         TtFIWSuL/PC6+csFzJVqM653ENRwcmJWQMNzkLzAKhJ6oE+zxQC+wtCiaFatk1a4yTGY
         qVut2lMhH8eKI2bLVHsS7V82D4CxYfd02yPacPw1MZsbXYboynHe/yXyzfSt+fG184OC
         5u+xEwewP3JcgjD5aLZgWuTJJV7RRYdA1ubj422Cbk7lHLJZGf29j/3MIMca7FfGNqPL
         lJOZEnnHbtDDtYAMMSrN8+NWYBPFMCYuGi6W4+dpMIim9nede4LbeQ4G6eSXHLJB6adH
         5GMQ==
X-Gm-Message-State: AOUpUlFc7Qfq8r33ElOPVRd1fshdn6EvCQn8jSSmgHFeJcSql0QCDXxp
        xUGUEKd/B3vH/uDjVwHxhNF2+J0AGgHGsHzRJyjutQ==
X-Google-Smtp-Source: AAOMgpfGa5JqJ2qe8d/5uK4dLxMYoMxPa8gaOI8JeGrBz8GqrS3X49XOGN0mTXT31Gync7/h21T4ScNgyuu7X9P2hSs=
X-Received: by 2002:a25:cc97:: with SMTP id l145-v6mr11928303ybf.334.1532540686799;
 Wed, 25 Jul 2018 10:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <CAGZ79kb4ki0cXLnJHeqzRvWaGWki1_epWOdCy49s_v9cy_tJ2A@mail.gmail.com> <xmqq36w94o87.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36w94o87.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jul 2018 10:44:35 -0700
Message-ID: <CAGZ79kZVQZkriu8d9WwYjm01qwb89ntf2dpK_jxRqDHgL1Eq6Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Add `range-diff`, a `tbdiff` lookalike
To:     Junio C Hamano <gitster@pobox.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 2:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > On Sat, Jul 21, 2018 at 3:04 PM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >
> >> Side note: I work on implementing range-diff not only to make life eas=
ier for reviewers who have to suffer through v2, v3, ... of my patch series=
, but also to verify my changes before submitting a new iteration. And also=
, maybe even more importantly, I plan to use it to verify my merging-rebase=
s of Git for
> >> Windows (for which I previously used to redirect the pre-rebase/post-r=
ebase diffs vs upstream and then compare them using `git diff --no-index`).=
 And of course any interested person can see what changes were necessary e.=
g. in the merging-rebase of Git for Windows onto v2.17.0 by running a comma=
nd like:
> >
> > Thanks for making tools that makes the life of a Git developer easier!
> > (Just filed https://github.com/gitgitgadget/gitgitgadget/issues/26
> > which asks to break lines for this cover letter)
>
> Thanks.  These cover letters are unreadable without W Q
> (gnus-article-fill-long-lines)

While I had some comments on how I dislike some aspects of the
implementation, I think it proves its usefulness by my usage, so I
would suggest to merge it down to next as-is (and as soon as possible);
deferring the issues in the implementation to later.

I found running the range-diff on origin/pu to be a pleasant
experience, although that still highlights the issues of
in-exact coloring (the colors are chosen by the first two
characters of the diff, which leads to mis-coloring of
diff headers of the inner diff in the outer diff.

But despite the imperfection, I strongly urge to consider
the series as-is as good enough for inclusion.

Thanks,
Stefan

Thanks,
Stefan
