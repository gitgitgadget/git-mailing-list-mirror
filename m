Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA47C433E9
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B063D64F7F
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 12:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhCSMXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbhCSMXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 08:23:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC5C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:23:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z8so11665914ljm.12
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LbVO9WOJOCb5ScEqZhH1NnWT5ZaGiwM4cmbrIDMv0TY=;
        b=yPj6kQ2DY5FQvUd7o2Q8PxBDprGYrNQVoGfmxSI4Lo3XbiJRCZp7WUy5H4zC9MORt6
         TzyZJxNf5rOg2zX4/W1+KBrkN7SgcXpfxp/nl5kXV9AKlRHtIjVospgMcU4BabJ7o1x/
         q5/XrGi0RmVJQNRyC9kFKB0b8xDm/S3WCQEvZwQpiNsLMxP6uPa1ykzWFGljEkPrbe5V
         9QAvBpD7DPW4H/1iwjLh2qP6ISqUUOgBXYRQy2WzgmZfqPWLSSKjrgzlAPoLG8ga2vJ4
         JhPCXlR10c1TAtixV0Tik/o3VVPaBOAAz0DrPYvUATl/z9ZJ5/NRZxRaTkqwHqDvrIIh
         QqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LbVO9WOJOCb5ScEqZhH1NnWT5ZaGiwM4cmbrIDMv0TY=;
        b=np5sBEJoAWFCvf8REvWJew1eHGwqO/Ib9/xt9ZvWbwg2fi96Y6LZwSeN2r/2s2zBPg
         tFNFezCg87wwUds+EQjO4+Oj6bUGO7tYp9D99M6CRyNN1HFt1KyfKKgKjpKUDPuoYFIl
         ayJ9vjIjs7shegOW2lrXYnEQLdP50wg2YnqMtwu/DN6tlVIHpUa9jhjREa5RqNYSS8qc
         OMNklS1NMvciORRTINmbE9S/152bk4XEmd/3ouEt02knWsp8fysqaqbX3cDjYCTOCulF
         TUXWVRxnQgIbAYuWyNM1MaugIOxTAmfzruNmMlGER22UkOpSVuAjr6YGbhFu783G388L
         pKfQ==
X-Gm-Message-State: AOAM532Vux9wRyy2MKCGM7K7FvG3tYtOx/pdxrqYL8RNSBHF8iXzoqD0
        DoEjKlCoBqOb5Ouj+24q5E79DEGhNKAex5FHJpIBPg==
X-Google-Smtp-Source: ABdhPJwHfpV0YMJXia5o0DdsSK4Tqk9SqvbhQ956o7KNvIlqcJmS/w8pV2+g1zbQfaryTGhbDgNJ8ctnKVwV1feYKqU=
X-Received: by 2002:a2e:7c17:: with SMTP id x23mr761505ljc.65.1616156594252;
 Fri, 19 Mar 2021 05:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615588108.git.matheus.bernardino@usp.br>
 <34a61a0d03868c43d68a04bca8d86dd98de2aa28.1615588109.git.matheus.bernardino@usp.br>
 <xmqqsg4sowks.fsf@gitster.g> <xmqqo8fgovuz.fsf@gitster.g>
In-Reply-To: <xmqqo8fgovuz.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 19 Mar 2021 09:23:03 -0300
Message-ID: <CAHd-oW4V4_XrY7XfQO1gLEZZmzcLbG0_M2ys+Meh4Ysu0Psz0Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] refresh_index(): add REFRESH_DONT_MARK_SPARSE_MATCHES
 flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 18, 2021 at 9:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Matheus Tavares <matheus.bernardino@usp.br> writes:
> >
> >> refresh_index() optionally takes a seen[] array to mark the pathspec
> >> items that had matches in the index. This is used by `git add --refresh`
> >> to find out if there was any pathspec without matches, and display an
> >> error accordingly.
> >
> > It smells a bit iffy in that this allows a path to "match" a pattern
> > but yet not result in seen[] to record that the pattern participated
> > in the match.  If the series is working towards certain operations
> > not to touch paths that are outside the sparse checkout, shouldn't
> > it be making these paths not to match the pattern, and by doing so
> > it would automatically cause the pattern to be considered "not yet
> > matching any path" when the matcher attempts to match the pattern to
> > such a path?
>
> In other words, the change makes me wonder why we are not adding a
> flag that says "do we or do we not want to match paths outside the
> sparse checkout cone?", with which the seen[] would automatically
> record the right thing.

Yeah, makes sense. I didn't want to make the flag skip the sparse
paths unconditionally (i.e. without matching them) because then we
would also skip the ce_stage() checkings below and the later
ce_mark_uptodate(). And I wasn't sure whether this could cause any
unwanted side effects.

But thinking more carefully about this now, unmerged paths should
never have the SKIP_WORKTREE bit set anyway, right? What about the
CE_UPTODATE mark, would it be safe to skip it? I'm not very familiar
with this code, but I'll try to investigate more later.
