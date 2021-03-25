Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FEEC433DB
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 07:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B035E60C3E
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 07:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYH61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCYH6A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 03:58:00 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B8C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 00:58:00 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id d10so1393624ils.5
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=+32MKg1/RBQbbP1sGg5rCWBT8u775vLbnGsIqWeUzPU=;
        b=iMGs0ujmUhQ6pIe5u0qgvHkaLf26uLESDy5JRk8/DkgVW6m88uQLX+qKyp65ElVfLJ
         rFtRXryOUrPot8VeshWdT7i0txCM2kFEKrmaIiPBAb3W1PpAjnG4wDL8EHR9yI7kelFo
         5b73woXVAaH/wiXU84B5qj/RM4wWEhuHzj/UiZZLzR7CZFiALO96CbPNA2KAZNM4B3bO
         sKU9K0x186EE6OE44OdbAQzu4O5pCobMta9wv1pG3GI+en9Muo+OmM0GQjATClz9ihc6
         CHVfYv2YAbmo8r/sh5qjLf1Myz0dgdTXHku9IFH/MyCpWmcu6XfoEeYxBOE7HhUs5Mz1
         jCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=+32MKg1/RBQbbP1sGg5rCWBT8u775vLbnGsIqWeUzPU=;
        b=MukBOdjOyL3Yyu9Ha7RIx3T1g4TrwDUvA512fmGEJfeL/V8SkXRFIuUOpfpzZ0MtP2
         pcWDM9sPNc2gqJ9d0mr2q81Ud4s48qqdsKlpFoTMvbPilOyN6gk/n1Noo8q2CyBOw3H1
         fZ9ZODreGnbDirP6DWIFY1tfNKhquiCUOyzV+gjlm+ID9TiDnqB+Ak86Zr8BQs/4jlb1
         gGyA8ruSegdhbzRlYSYibozsdUBYhxdWsudwVd1OfZO8pMbyZLYiR93L1RXnp1ymzTme
         6kpVGG4adzFphSQSjhkweO1x9xDQItxXaQhI31gHSCeqFTlAjfRuz1EKf99JLZdhnJ0h
         wt4w==
X-Gm-Message-State: AOAM531Ix3ue0rYhNcHvGn8NrSB9o51l9tBHa0Qx3LBfCn5cZGreFzpl
        Io9y3iZrDA99fkSAk87tMCMUvuA829qSkIFgpy+qWJx1Kmc7AQ==
X-Google-Smtp-Source: ABdhPJwAMK753PbV9PrDJ1w6ielLE7iKUkZZXATNAp8di46G1VaxuydypqL3oUl9X91nBZlLXSeUizrXzE/alCAWKGs=
X-Received: by 2002:a92:c883:: with SMTP id w3mr6138474ilo.212.1616659079883;
 Thu, 25 Mar 2021 00:57:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 25 Mar 2021 03:57:46 -0400
Message-ID: <CAH8yC8mnaEpnw8xCKsyBg0XXsuwhiE10AFXFDBdH2AW0qUP3HQ@mail.gmail.com>
Subject: not ok 47 - log.decorate configuration
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm testing 2.31.0 tarball on an Apple M1:

not ok 47 - log.decorate configuration
#
#               git log --oneline --no-decorate >expect.none &&
#               git log --oneline --decorate >expect.short &&
#               git log --oneline --decorate=full >expect.full &&
#
#               echo "[log] decorate" >>.git/config &&
#               git log --oneline >actual &&
#               test_cmp expect.short actual &&
#
#               test_config log.decorate true &&
#               git log --oneline >actual &&
#               test_cmp expect.short actual &&
#               git log --oneline --decorate=full >actual &&
#               test_cmp expect.full actual &&
#               git log --oneline --decorate=no >actual &&
#               test_cmp expect.none actual &&
#
#               test_config log.decorate no &&
#               git log --oneline >actual &&
#               test_cmp expect.none actual &&
#               git log --oneline --decorate >actual &&
#               test_cmp expect.short actual &&
#               git log --oneline --decorate=full >actual &&
#               test_cmp expect.full actual &&
#
#               test_config log.decorate 1 &&
#               git log --oneline >actual &&
#               test_cmp expect.short actual &&
#               git log --oneline --decorate=full >actual &&
#               test_cmp expect.full actual &&
#               git log --oneline --decorate=no >actual &&
#               test_cmp expect.none actual &&
#
#               test_config log.decorate short &&
#               git log --oneline >actual &&
#               test_cmp expect.short actual &&
#               git log --oneline --no-decorate >actual &&
#               test_cmp expect.none actual &&
#               git log --oneline --decorate=full >actual &&
#               test_cmp expect.full actual &&
#
#               test_config log.decorate full &&
#               git log --oneline >actual &&
#               test_cmp expect.full actual &&
#               git log --oneline --no-decorate >actual &&
#               test_cmp expect.none actual &&
#               git log --oneline --decorate >actual &&
#               test_cmp expect.short actual &&
#
#               test_unconfig log.decorate &&
#               git log --pretty=raw >expect.raw &&
#               test_config log.decorate full &&
#               git log --pretty=raw >actual &&
#               test_cmp expect.raw actual

Jeff
