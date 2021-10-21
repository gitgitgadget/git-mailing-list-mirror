Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE41AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 06:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A677B6128B
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 06:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJUGkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 02:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbhJUGkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 02:40:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF031C061753
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 23:38:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j21so2733303lfe.0
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIjaxU/pCuaJRYQdiY8ELD0ZCto3BDfS77saYMzOwFY=;
        b=OS2RQpv66zbrjDKvCQBwkrQrdG3NHaibQlhXow+J+OwtqrqE9zgL7cTJmTXDSESKn4
         KQEUrPfrUD8dwOPKRBsFhFA758TStmCng/o8IvMBw9eT8UOogDU450MetbJcKgcX6kqt
         vA3uQxncQS+2F3N1ykwhGlfHM1GA03RVaWxFN8OIeqllXNr21rhCg6mtgiel5IeG2QdD
         s9N9DwYxxmEZSF1B52sA+4bzmi3rtb0eYkXj87LeOaR18yjbZhGctcD/NuswKaJvQGod
         tnfpaod75eUVwqIq9VbxBute55BXwXToPz0rFCWI7NUJ2rZT3bqhQPYqLl5012bqJPzu
         evEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIjaxU/pCuaJRYQdiY8ELD0ZCto3BDfS77saYMzOwFY=;
        b=6j7EVjN6MqFRcjmQ/GYIM2wpzvDMty96ocaU9cSNqD41OV8aewJPjY0s00d57JESwz
         NXTJhkUNOOsZZbibSqlo2t/oWV0axR3XvBhrK170egnI2mZ/kiY5UQ4MzPh+XByHihmU
         cgL3iUQz0V8heE4DkjGUeCLoWmQ+BvoDG9h3uKvyVDLLgicHvv1HcMkLNzoGpWUf3bLc
         dNlTc25O0GfTVg2imaxzLlhAy61bFozgHXR+QdJ/xjgMJtDXAcXA2VeN3TjQeS7EpVnS
         GCpE3CpTTnblhNB7eyET7W2rEQzbSRZLGT5MYXrFrUDpftR9jNsOdK/8tzWSN6q/xbJB
         r5Dg==
X-Gm-Message-State: AOAM530qtUgcdWoB6fjFCRFg81OJiSdjpdCzesKKSPwoZzhx1w+asbeB
        QJIozU0C7IiFLcVmNQaArQdlRGyt/DPVkZN2YzA=
X-Google-Smtp-Source: ABdhPJyZTl4ckVxxFylOMIH3gaRecjVnDH2Rh53MFoC55q8g972gy0Z6SXtylEnfvd3+Z8gC3lXqKa0oqHYCWIobIP4=
X-Received: by 2002:a05:6512:3b0a:: with SMTP id f10mr3870761lfv.8.1634798314097;
 Wed, 20 Oct 2021 23:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
 <YW83JG9t2JaX92xV@coredump.intra.peff.net> <xmqqzgr3pso7.fsf@gitster.g>
 <xmqqh7dbplji.fsf@gitster.g> <YXB/1S2fid7MUmvu@coredump.intra.peff.net>
In-Reply-To: <YXB/1S2fid7MUmvu@coredump.intra.peff.net>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 21 Oct 2021 00:38:23 -0600
Message-ID: <CAMMLpeQYSWyhM92RDQuK0TSkNcbuE06_8RQiYHtz_JDYmXJXMA@mail.gmail.com>
Subject: Re: [PATCH v2] pull: --ff-only should make it a noop when already-up-to-date
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Kenneth Arnold <ka37@calvin.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 2:45 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, Oct 20, 2021 at 12:02:09PM -0700, Junio C Hamano wrote:
>
> > Earlier, we made sure that "git pull --ff-only" (and "git -c
> > pull.ff=only pull") errors out when our current HEAD is not an
> > ancestor of the tip of the history we are merging, but the condition
> > to trigger the error was implemented incorrectly.
> >
> > Imagine you forked from a remote branch, built your history on top
> > of it, and then attempted to pull from them again.  If they have not
> > made any update in the meantime, our current HEAD is obviously not
> > their ancestor, and this new error triggers.
> >
> > Without the --ff-only option, we just report that there is no need
> > to pull; we did the same historically with --ff-only, too.
>
> Thanks, this looks good to me overall, and I agree this is a regression
> we should try to fix promptly (so thank you for jumping on it).

It looks like you guys got this under control in no time. Thank you so much!

-Alex
