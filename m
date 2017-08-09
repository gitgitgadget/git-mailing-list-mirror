Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20FC208B8
	for <e@80x24.org>; Wed,  9 Aug 2017 23:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbdHIXL7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 19:11:59 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34154 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdHIXL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 19:11:59 -0400
Received: by mail-lf0-f47.google.com with SMTP id g25so34210696lfh.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=S1+peumx/+ngCzv0O0HXk5Z59Q0D9CBgfyPk2hp2Tc4=;
        b=maxqAQ0leaBhTAGydx0t2v9Mk5nq8FLN5r4iNKt8V/BOut/CoXdTf3SgDFh6S4uow+
         FPav+hYfkRjuSZJRwWfXyqN4GxSbOCwMla6fNmC/p85xStvghHRO7R9Dzaa92xbd15OQ
         l2vJB1QlCcLtJtmUStWmKhDy3iwH1j+9C6dFhgEzblgFsMY76qP1qyFJZcnkP5ltC0Ma
         cMSbkHlw5xZvKSvcZhuBAqjmUGdORptcRHuzvx4KQkrAbJMWKmTyig+KT4YhksgFHQf8
         Kvcztu+CCTaXFXrl7bH+wO9zxNcG89a2AcgJEgSx7Fsmr/qV0JAVhBmST63NNWQaPVIB
         YENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=S1+peumx/+ngCzv0O0HXk5Z59Q0D9CBgfyPk2hp2Tc4=;
        b=JO69nucmd1ULruF9VI5FflVeP9LaSVlh+n9hOrB14XsMPihSOf4Vr1PrgMPaA9b5NF
         2LmYN/DVWtV/xGLtcOY8HZjRluYiHXjqVkGuQ39rDN97lqQbVmgwDCeAI2nVxMwpeMpO
         Gg5btahM7GPl4fYzGlJ7PqY3RCd0buOPQVtW5EdR5408CNw1SaUnxkhADZMPk0vIewS9
         N7g7nb0qLh4BCqVypkpQhSTcS3wGzThgKeDVxcCUQTNH2CsEmaNtD616qGpXjcbNUrNV
         vyCElnKDY9J87jj+d5hMGJoiGitoQdN+n4j6fEjnZmJH+tWWM5TYspwqasPXYXb+A9JE
         MfQA==
X-Gm-Message-State: AHYfb5iKHs2j0Eb2PDpeUZR1AHH7EKMDqzc0NPkWvH1X4qS4Bn184fIT
        a0UifbIU8eVy+il2r4JPn1rv035Lkt6w
X-Received: by 10.25.161.209 with SMTP id k200mr3489193lfe.132.1502320317454;
 Wed, 09 Aug 2017 16:11:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 16:11:56 -0700 (PDT)
In-Reply-To: <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
References: <20170808012554.186051-1-bmwill@google.com> <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com> <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 16:11:56 -0700
Message-ID: <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
Subject: Re: [RFC] clang-format: outline the git project's coding style
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 3:53 PM, Stefan Beller <sbeller@google.com> wrote:

> I would think based on these options, a pre commit hook can be
> written that formats precisely the touched lines of code of each file.

I did not search enough, "clang-tidy-diff.py --fix" should be all that is needed
