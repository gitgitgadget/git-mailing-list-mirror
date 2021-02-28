Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51010C433E0
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 20:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C07064E62
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 20:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhB1UB4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 15:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhB1UBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 15:01:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E757C061786
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 12:01:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b15so9674215pjb.0
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 12:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhwAySjtesc1FQBwe/tDBbtrSd2VxUUFmUaUiD2d5js=;
        b=SkLsTIEmv7L6zqXUKZ3m66oeh7QB+f/OT+yOXXxd+fELXifeOjwjsdaxtMmw+mG8w5
         1Qv7V1g/AuzhgB8OfmqP/5fP50L+IvwyndOF+X7suPxnzeYsygutYnya5SUuPq34G5B6
         7A6ejV80j3DOV3pR8jCOrPdJD5QM3RBwBRU2wuOaX+EFyx8oKzX5AfeftUT0bRK6FwwP
         SuHYG0CmobqU1CriwPjRdKo7LcNFGxlIOSaU+BfJEpq3XbqLWHbl/SuGMgLrdYtJ/xpK
         kWlsg2rAAKgkuUVvTiJt7VcUCDVO80Bd9h+SjlgLRe9gDFPhUJoB/gW0VvXucZ5JVn2D
         ShYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhwAySjtesc1FQBwe/tDBbtrSd2VxUUFmUaUiD2d5js=;
        b=QCuRv8GiccXHU7GMRn8UUi2hHhwTc7pyjrPqj0QrWtNh2SrAVpMs4qFssHam5lRodc
         gHM0KvZd5SyA0K8izI1dzqNUvXkXQBY5nJ6lQKk+Rz0/cySXFPBiZ42YgjbJaI+yTaka
         dPxv6yGvkLZ1AbhllB3IvcYPcV5RvF3L449d9m9Co8Z9zUkd5y1C+aW5nFku1ZB2Nb5C
         H89ZoV6WqJeq7s82FYmjwtYssd/MVtr5bKMleb/QvJ+78FN+277+jSYYW7ADJRTbKTDq
         ypOAg5ia1N7YwsLSHmZrxU9UMxqcyjWLjC2Kf77Nr0f5Z1taYV7AswGdkCJaApqf+R5m
         gR/Q==
X-Gm-Message-State: AOAM5305rqkDUi/JXoy8JxJRmVfvxNkioHQk5q2EKfqElMxoJC+ud6ud
        ayCtkaBDDvHi2qXvABfXWx5/6WjpS8t0YhekEvg=
X-Google-Smtp-Source: ABdhPJybtXQMGGDRHpiFtxK9cJ8jZfHatfWb5a9vW/aCTUJ6/fhFmMc4VjIHqhkhTZekJS/K8HPfEQUYOfvooHqHQoo=
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr13545262pjb.137.1614542474453;
 Sun, 28 Feb 2021 12:01:14 -0800 (PST)
MIME-Version: 1.0
References: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
 <ead5b3145c0cbf726c2fe06f5c95536373c85265.1614354223.git.matheus.bernardino@usp.br>
In-Reply-To: <ead5b3145c0cbf726c2fe06f5c95536373c85265.1614354223.git.matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 28 Feb 2021 21:01:03 +0100
Message-ID: <CAN0heSpZ4938f+Wd_LOnykCpLbWernXzLJU02LA79axcGCA_-Q@mail.gmail.com>
Subject: Re: [PATCH v2] convert: fail gracefully upon missing clean cmd on
 required filter
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>, prohaska@zib.de,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 26 Feb 2021 at 17:24, Matheus Tavares <matheus.bernardino@usp.br> wrote:
> This assertion is not really necessary, as the apply_filter() call below
> it already performs the same check. And when this condition is not met,

> -       assert(ca.drv->clean || ca.drv->process);

FWIW, this LGTM.

> +       test_i18ngrep "fatal: test.ac: clean filter .absentclean. failed" stderr

> +       test_i18ngrep "fatal: test.as: smudge filter absentsmudge failed" stderr

(Funny how these two error messages differ in quoting. That's obviously
not anything your patch needs to fix.)

Martin
