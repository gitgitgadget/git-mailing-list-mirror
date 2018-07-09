Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6D51F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 08:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeGII1Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 04:27:24 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37629 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeGII1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 04:27:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so19770331wmh.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 01:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=W1G0uSQDFP9tAWZkoHxf3Sd5OazlhBt+7mD4LkkbFmI=;
        b=uFP61BU6LHrCc4yYJ28Wa4KYCLVMijGtZSAlRawMt0daVl36Z5gdMfJfM4V5owJYNX
         mp88sXffPmNvjMTlAhAJpSHQm2h8qdQEfPqSEau5YHL3+EAjkUUZ2mOAi3ix5aYvJbCl
         rUY1Q/mNdUqQrknX3B5MxJWK6fZ2bzdaEeXTONDZgqe3YTAC0q67bH4Wpjb37JnKvcWv
         RJ1w02xFNvw/z4wnFcwZoJgXq5LgqD6rV/zJiFR1ycZhOqroWAF29u+qO9qRYa+OAoRZ
         B6VWo+bHs7PjTysURxD1JYTeC1xOcrEsSAUfXMXsU1FPCAGvamH3M3nqYOvy8AI2od0E
         dgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=W1G0uSQDFP9tAWZkoHxf3Sd5OazlhBt+7mD4LkkbFmI=;
        b=bp19Dzi86BcdP95VEoVeXF1B8PU9BL/NBAfYr+XFrX3WkkXpPfGrfQ/N8tTr8VCyTR
         o9oGnXO6xlaXeOThXrHUiVmOhaH+nS/gTAcdexCCxcQafKtHcfDxoNT+BcV7yL3VF56W
         z+aeo3LwY5SIcfbzNuVAT1pqQg18UrVqA7rNteZhoa790mpXtFx6LP23LtsfB++pSbPg
         2SgOymyYdJ2Gqs9E71wMnACZdxSPR3aLTXfMG4b4xapq3k02aYUkKJ6esqCYjQNuJmlB
         tYtj4OXLAP+06ToLj805VMVAmZmC8c2pjMzKLB16ltVtdebXdolK3tXFRID06GoYVAKQ
         eVUw==
X-Gm-Message-State: APt69E0W7h3s63W9QY+6nswmPyGDvhJdkShwK3rPQk515xfxc11Sp8P9
        pyXBgWsVO1I7M3Lmy6GLH9gYvZmIqQSsSyEMh8FSEJaA
X-Google-Smtp-Source: AAOMgpe34JC93AHPiAlNQ/CcRiYCsHuYxLjQi7dmJPgCMin4y80NWnBe7JQ19eNDqUQCEQycJEznS250tTgGKcTEAvc=
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr10856771wme.109.1531124842240;
 Mon, 09 Jul 2018 01:27:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e9c6:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 01:27:21 -0700 (PDT)
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Mon, 9 Jul 2018 11:27:21 +0300
Message-ID: <CAL21BmkBohTOVdCO_ENVfzL28aRjoh1MCCF6750AQEYsc7L54w@mail.gmail.com>
Subject: [PATCH 0/4] Use oid_object_info() instead of read_object_file()
To:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,
This is my new attempt to start using oid_object_info_extended() in
ref-filter. You could look at previous one [1] [2] but it is not
necessary.

The goal (still) is to improve performance by avoiding calling expensive
functions when we don't need the information they provide
or when we could get it by using a cheaper function.

This patch is a middle step. In the end, I want to add new atoms
("objectsize:disk" and "deltabase") and reuse ref-filter logic in
cat-file command.

I also know about problems with memory leaks in ref-filter: that would
be my next task that I will work on. Since I did not generate any new
leaks in this patch (just use existing ones), I decided to put this
part on a review and fix leaks as a separate task.

Thank you!

[1] https://github.com/git/git/pull/493
[2] https://public-inbox.org/git/010201637254c969-a346030e-0b75-41ad-8ef3-2ac7e04ba4fb-000000@eu-west-1.amazonses.com/
