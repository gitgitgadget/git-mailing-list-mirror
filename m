Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085C8C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJRV5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJRV5l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 17:57:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855EEA2203
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 14:57:39 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3560e81aa1dso150481417b3.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 14:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xpKzEFRBvd1AHrcn4Eki2EcTzVxxszPQY4Knacq4xr0=;
        b=RZR4AMoW94yfamQKLXOy0OKq09hGKMoK1mBpYlSiupPnbYEc8zRmnYIn6Y1w1x2x3V
         O+zeTgdkU54KfBNXusGZYcSTQ6ZRpjNFHXlJ6AuRYh+B2JOLpwSURy8r9gcCKpQLJjkm
         Qnf5F6kgmDOkmaiw2YHJvXRzEK1VT8PlE+khM+mGZHlC3Bp9sLyCkynvAVa2WSXdxMu6
         0z2yjnDpWkwF//j5nIZ0bdktJAHi0NnmqCHs2wW+GsiEiLQv1ad5wF7owBuvXmjcprSy
         A2LS4UptWUzRltdKFjX5TcZ/M9kyfFSWOsi/2QNYWu7mRcsG9b11J9vBcp6QAanLUrDE
         n98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xpKzEFRBvd1AHrcn4Eki2EcTzVxxszPQY4Knacq4xr0=;
        b=LQNx4/QEm3wmDSpY2I467mZywYE3hGA0oGteR+rzmJ6lqlnXTs+NzmmK8RMvCWDYbS
         yEP8DPu7CHEeNw66v2J8QxgOMMvVEw/awaAJBupSx1W5uA86VN5XkXryx1Zq+6VIiWtO
         ziqwiskk/FbCgcXnn0Ww1JRLHGHegxwWfP6BFzu/651oZIU7BfStdJFZ6RhLZd4rhCvS
         qMrFbcGItOJ0xrVpdsWL0oGrakUOACtMDF3+faL5pUPpO9YtSl3fcn7BC8CXXUtok0qu
         bgzTKrehvY78Ws6VE/zPc4rASWCumr40ISrsLh8KN0DKDFRUuF15kPSfBhRvVsMwpurK
         FxlQ==
X-Gm-Message-State: ACrzQf0BplJDWtfPrLa62FutFlLhAiulsZsVClkTqSHuwZbsUbN7Rd7T
        DynpNBmDWAN44Q3EFgpIh/TV4Vbie1F6Ppee3zZvYfvlRMw=
X-Google-Smtp-Source: AMsMyM6fxMjQ/iNvCpR/qgO0vYFQ1RD3W3MNgCARB172dZ7upFVarI1pf7ZbakSay2AeotTH/1Qg14sLC82zihRqFdo=
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr4095933ywl.67.1666130258686; Tue, 18
 Oct 2022 14:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1359.v2.git.1663654859.gitgitgadget@gmail.com>
 <pull.1359.v3.git.1665737804.gitgitgadget@gmail.com> <69440797f302729d59f19c0994916e193c9dbf58.1665737804.git.gitgitgadget@gmail.com>
 <xmqqo7ua1nrz.fsf@gitster.g>
In-Reply-To: <xmqqo7ua1nrz.fsf@gitster.g>
From:   Jerry Zhang <jerry@skydio.com>
Date:   Tue, 18 Oct 2022 14:57:27 -0700
Message-ID: <CAMKO5CuqLSowSo3fhOux-fY8ek-CL4zudgA0fBjXAt+9CBhs9g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] documentation: format-patch: clarify requirements
 for patch-ids to match
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jerry Zhang via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 8:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  The 'base commit' is shown as "base-commit: " followed by the 40-hex of
> >  the commit object name.  A 'prerequisite patch' is shown as
> >  "prerequisite-patch-id: " followed by the 40-hex 'patch id', which can
> > -be obtained by passing the patch through the `git patch-id --stable`
> > -command.
> > +be obtained by passing the patch (generated with -U3 --full-index) through
> > +the `git patch-id --stable` command.
>
> This is not incorrect per-se, but I wonder how much it would help or
> mislead people in practice.
>
> I understand that the update means well to help those who complain
> "'patch-id' produces wrong result when I feed the output of 'git
> diff -U1'" by making them suspect that their -U1 may be the culprit.
> But the new description does not cover everything that can affect
> the resulting patch ID (the choice of --diff-algorithm affects how
> common lines are matched up between the preimage and the postimage,
> for example).
I can add a note about diff algorithm as well. Its slightly different
from the other two options
in that there should be fewer cases where diff algorithm is a problem.
U3 and full-index aren't
the default options to "git diff" so people are more likely to have
the wrong options,
whereas they would explicitly have to run the two diffs with different
algorithms to
run into a problem. But there's no harm in being more specific.
>
> So, I dunno.
Keeping patch-ids the same is difficult especially between different
git versions, as
changes could be made to "diff" that seem like improvements but would
slightly change
patch-id even with the same args. I expect that people generally aren't keeping
the compatibility of patch-id in mind when changing diff. Nevertheless
since we've
already advertised that they would match, we ought to give users the best advice
possible to minimize if not eliminate confusion.
