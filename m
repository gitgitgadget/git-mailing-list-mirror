Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69D3C1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 09:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbfHBJjC (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:39:02 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:37917 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfHBJjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:39:01 -0400
Received: by mail-qt1-f182.google.com with SMTP id n11so73199639qtl.5
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=E8fhwZCiotdo69ODEjkEZa8pfp6D3PpcfZiWqFs1rzg=;
        b=ORRsNsEECSE5Co49XkEaPafrr3IK1Hlkmf3GDIu0HbZjYDEnDbh8niSBXrlexEQU9T
         ytlVfOaG/59G7ySPo/IFPDUcys145CEYDjT0lU9Mo16KRmntbHymKPNjEoL/7v+eOS2z
         bW0Vf7mqykhEz4axiX1MaKwF6Cxjqv7ONRKmPeg8CofmEBUlXgTovXBLbOjmja+Ek146
         suzt/AKpu5LFP/svM+4jT+vYHIAy9yec9iWdH20SZyz+hiqBdpgr9KN9vryy0i4RMzvD
         BNBN6P7/dDkVpH55DqkHmxKG286wbKHHl30b6DZ8xrLPG1eyLSN3pfBulkq7FB1kfW/D
         x6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E8fhwZCiotdo69ODEjkEZa8pfp6D3PpcfZiWqFs1rzg=;
        b=WEQMVRK/eqq60BnGiC0epnvfhMBRd6GCjPAQrpHTgnFxPrev3rwyRYT+6z6L1SeZX2
         Z6AZ0fFmTait4Aoc/N/aofFr9TvuzwFcfsk1e9QbFsmdjU8TN56TvCn053oDyufJYOnr
         DDec/rjdJLKgyrgvtHGo7uWVJNuWlVgaYbKmF46B9Recifhd3XPwOch77xkWwmJKkGrF
         2MSthELS0RVK+tXuVsHNBlKkib1Ns6Rw6bwSWcUqqycHtpYHZ9l678/x0/EV4ABk2n1s
         d/UNH3/Bi7kYu61Z7ACpqzO0f14NJJk4+YweDEXK9ZDve81tn5PUgNewrHHjs1TSvs3n
         ss4w==
X-Gm-Message-State: APjAAAUcSC2LBNqNSPeZSsRzE0eT3433R7JDP7oQk6rIm0WIJkh11Rgc
        yozNEszs5wBSt6Q7WVeNNUUAXfMcdi/AkVe5wjiyQija
X-Google-Smtp-Source: APXvYqzaDBzQg/APjCs7fPmBeD25vAtxabYpVfjAO+UzVxU3KApMk8TpyzrPjUHg8YmUwWTtneJqAcWCupLFltNoysE=
X-Received: by 2002:ac8:6b41:: with SMTP id x1mr1575248qts.246.1564738740924;
 Fri, 02 Aug 2019 02:39:00 -0700 (PDT)
MIME-Version: 1.0
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Fri, 2 Aug 2019 11:38:50 +0200
Message-ID: <CAA01Csp=g08N4+S1HKAjV2a12VJNSJU0UYdAU6LW1jGWLD9SLQ@mail.gmail.com>
Subject: git-log on a file, and merges
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have merged a branch into master.

When on master I do "git log -- some/file", it does not show commits
from merged branch (which I know they changed the file).
I have to add "--full-history" to see the commits.
When I run "git log" (without "-- some/file") I can see the commits
without using "--full-history".

This seems not logical, and contrary to user expectations. Harmful even ;)

Am I missing something?

git version 2.22.0.rc1.windows.1

Thanks
-- 
Piotr Krukowiecki
