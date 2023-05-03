Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C889AC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjECRoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjECRoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:44:16 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A6419B5
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:44:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24dea6d5ce8so4474538a91.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683135855; x=1685727855;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bm7hbLP6dKIRmvkGBpPGg8gT/KIHBxx4luKHg5+71Bo=;
        b=PMuTuYYThkDtlbcz8mU8cHnBgW41wPC2FNoW/SBI6/e92SZVPY3+VoYG6XeW2bOgHr
         G9stv4nvqpgWaFTWvKKzr+Pq8I63ADJdh1BE/AY3ThZFYX5s4Ks5PVRAM9VaYYgyJiF/
         JzsqSJU+l0jLiL+xTB7NacJfVos/nQwtsSX+/75P5V/3WcH5seOfkg9XwCe0NoIyNg/F
         lAz5gig/Iz+briFDQpzRTn5Dr2/hK34e4uNi3z3iF1LwwKcc+w0CGdWd/Yp95mwnY04F
         5ftfZPq1seBcswlXfOIxOSPO02DUBvxpDmPt7IFuDGtzBsLUpYKI+TyvVJcrjQFAq4zz
         S1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135855; x=1685727855;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bm7hbLP6dKIRmvkGBpPGg8gT/KIHBxx4luKHg5+71Bo=;
        b=B6s4tSCpcIW//DBCVdnq3Vym0G3TcrU6U9izCtb2o1t5LfpqfAE2phdx9Ui3yt8AJU
         twD1JZSOvNOpNImYG7rqzCi9CvtlpHWoK8uA8VQsnBoXQZ0wVdQOIvvkymWFGjE1XqTY
         5w96fDrdohUAv+7NgU7O7nRHdErDKG0Z4WHqBjY5iUhGw4pfBY//dKtpbrOpwzwpMVG1
         dXxfF+xtYGHBPbAYdf4hZUzLdFIxgMBOklsgSqUGkohi/AEcsUYSsdilljteZJj5nhcY
         /MyhNQOG11E7AZY7ryuNPQKc6PnSahH1sc41ePMZxCyGqjzidxSvHoIrWvDJuu2uDGsr
         JFnw==
X-Gm-Message-State: AC+VfDwI8i66ELcrksdkiglTyKt8QhO3I9uJs7VcT08InTU8KrJ3WYQy
        XXKvo7mRIEMEj5dKwnAMD8E=
X-Google-Smtp-Source: ACHHUZ4nksQrStz/0MhYyX+VoRO8/LxoZWERLI0eeHkikkgreCbKzw7Wd08O97gtWW6/V0HM1c7r1A==
X-Received: by 2002:a17:90a:f284:b0:24e:3254:5d94 with SMTP id fs4-20020a17090af28400b0024e32545d94mr5231028pjb.40.1683135854971;
        Wed, 03 May 2023 10:44:14 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090b050500b0024749e7321bsm9763837pjz.6.2023.05.03.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:44:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
        <20230418070048.2209469-2-felipe.contreras@gmail.com>
        <xmqq8ren8xz1.fsf@gitster.g> <644684018a766_aba29424@chronos.notmuch>
        <xmqq8reg96cu.fsf@gitster.g>
        <20230425061029.GA4015844@coredump.intra.peff.net>
Date:   Wed, 03 May 2023 10:44:14 -0700
Message-ID: <xmqqzg6lqpht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The first hunk seems less obviously good to me. We're not part of a
> list, so there's no continuation. We might say that it is good to always
> stick the callout list directly adjacent to the associated code block,
> since it does matter in other cases. But dropping the blank lines
> between the paragraph-sized callout blocks makes the source less
> readable, and empty lines between list elements are a pretty normal
> thing in asciidoc.
>
> That said, I don't feel _too_ strongly about it, so I'm OK with the
> patch as-is.

I agree with the conclusion.  

The first hunk may be iffy (in the sense that "it is not
cut-and-dried better than the original"), but the change makes the
postimage of that hunk look similar to the postimage of the second
hunk, and adopting it as our local rule to alwys stick the callout
list to the associated block gives us more consistent look, that is
good, too.
