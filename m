Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA77FCE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 10:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIXKcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 06:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjIXKcG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 06:32:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCF9B
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:32:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50435a9f800so5702618e87.2
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695551518; x=1696156318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YEDbELRsHD5gCMqjkfkOx4nCBeq/qlOO5oWH4jIz1VM=;
        b=kaoD/bq11m+cYLIaV5NBkptg66L1RoaAVYmD/Km+j4relCWhrW34JPPEQ4ozxB0lFy
         FlinTxtpBBsXIdfp0XaEVGdizS0QO873zmIpoh1V3xPzmaRT6yvhrkThCbBNhiamcrX6
         W07ZJvz3wFkkMffACG6C2CAJpmrsh5IsMM81DwR/tViQtyeYDpCMjowTC8sIk3LUzGjW
         QnhYUdFjHhlihRrLTHboGpLEEWjIWXNRiicS6xfVpsb2zaoztyXJ9U9sFrMIT/C6rSpe
         AYgHpNUlquDha1qLQtXqsEKt10pOCGlrYFE1MB6eZjD0K9AyFToZ3LoikS3ehEoPJ6sY
         yXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695551518; x=1696156318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEDbELRsHD5gCMqjkfkOx4nCBeq/qlOO5oWH4jIz1VM=;
        b=pE6gaMF8tytQ96D8UJwHK8n2V4bE0+Y8x3brN4yn/qxyv1ndMll6OxzISvPUfHH068
         K49FIQsFODtllzJYLD11miJqkwSPcP5W+2Ablw5W0HfdlOz3LNjgpT6l6m6Uv9xyCHtO
         /h1yAIUaSsuI/prEc4D3q1XhPOp1EAZoNKCriKHYtM35Ow1fsAWKYX2jqdDhc176F3Hq
         FrW2qv0G9e7lXKF7zPLPdeTgWqnNGs/Ng6/XQur6fyq9BFgrRV7sc5/GQOfJJrNjrGuE
         /FDEn46Wuwm7nmbj/P81T2qCDJOxddmN1hu5xd1/IALErJvzMC8rNyADXZ/Nl386tuXT
         IeuQ==
X-Gm-Message-State: AOJu0Yx+WCEBWTzk3BUKLcmhLM/6ylj1IBwL4SWnYgFCEArquOy8F3se
        oy0/ZnBu4Zs3rOWgX5sZB9NlMzStMj3r537bjKNniC8V
X-Google-Smtp-Source: AGHT+IEhAbOPOKgVyVOKbmu4TdplEkyGK+2nMP7NdJ1QXorMULdgRqOLFCngK8vmSavPpm0I/IVVvoMDskIhDONSn9o=
X-Received: by 2002:a05:6512:3582:b0:4fb:7675:1c16 with SMTP id
 m2-20020a056512358200b004fb76751c16mr2918816lfr.49.1695551518148; Sun, 24 Sep
 2023 03:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.950.git.1695391818917.gitgitgadget@gmail.com> <xmqqsf75zxbv.fsf@gitster.g>
In-Reply-To: <xmqqsf75zxbv.fsf@gitster.g>
From:   Josh Soref <jsoref@gmail.com>
Date:   Sun, 24 Sep 2023 06:31:46 -0400
Message-ID: <CACZqfqCVsv-ZaSRWt_ejMn5f_U_1E2h7wsCgUg_50A+KHzOgkA@mail.gmail.com>
Subject: Re: [PATCH] pretty-formats.txt: fix whitespace
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> > * two spaces after periods for sentences
>
> Although I admit I tend to hit my spacebar twice after a sentence, I
> think more people tend to just do with a single space and let the
> formatting software (like AsciiDoc) take care of the inter-sentence
> spacing.  To me, this falls into "it would be nicer if we did this
> when we write a new sentence, but it is not worth the patch noise if
> somebody already wrote with a single space to change them" category.

> The title of the patch may have been written after you did the
> above, but now it includes other changes listed below, so it may
> want to be revised.

Indeed.

Would it get revised or just abandoned in favor of something else?

> > * comma (before/)after `i.e.` and `e.g.`
>
> That's modern American English.  I think our documentation is
> mixture so this may also fall into "if it is already written that
> way, it is not worth the patch noise to change" category.
>
> > * comma after `etc.` when not ending a sentence
>
> There is one instance that says "A, B, C, D, etc., are all accepted."
> without the comma after 'etc.' and the patch corrects it.  OK.

It seems like this is the only change that's of interest.

Do I just make a distinct gitgitgadget PR with that change, or do I
ask it to mark that single change as a V2 to this? (given the branch
name assumed whitespace and the only change would be a comma, it'd be
kinda wrong...)

> > * space before `(`
>
> If you mean by the above that we used to say
>
>         ... as described below(see linkgit:git-config[1]))
>
> and you added a SP before "(see", that is a definite improvement.  I
> however didn't find an example of a line that lacks SP before '('
> that got corrected to have a SP there.

I'm pretty sure that's what I meant, but I can't find the change in my
git reflog, and I'm not quite sure how I could have made that mistake.
