Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642541F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeGSVro (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:47:44 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51891 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeGSVrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:47:43 -0400
Received: by mail-wm0-f52.google.com with SMTP id h3-v6so7052516wmb.1
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=0yG+72IAnCfd/f6Nyl8neXixHz1mk7qF1P4vqWaNZRY=;
        b=ntbCkUnlTgc7Cr/Rd8UuBYXjkHoZDocwKAiVwGgw5rWN5fwXDPT9B1Paas1joSIh82
         vQzqS71tJK2XmoNpb/Fpad/mct8KvKfuOS0B2o4RVo2sqU0ANkhP7U0IJtq6fCD0alLE
         7pimpzwW6OABW7VKmVoH415xpZS9F7xarTeGX37lyJbHWjQ7J00voNEqKCSsFP5eD07X
         zEPeS/jAeIP7k2rxGJouPydQU4+DKnDVqhpbJ8eWAQc3TBT/yclrj5yQ2CymXSsYmpkH
         NZokMCsWEQNzPGkrNUSclXnHHa8R9MoaDyxbzhkTKvoXUCaRXfBAyT18uJ010FyToYbl
         Uw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=0yG+72IAnCfd/f6Nyl8neXixHz1mk7qF1P4vqWaNZRY=;
        b=uC43+KsV7vlsEMljzDcFSkRdPGPeUC7zjgLmYM2IToIuNgKAMSQpt01So3riTmdLKs
         Qqvp1Yo77Z+QYrlGKOBcU1h+b2O49ocb6IiYBo10RKdDqhb/T1EXR5szrV+anZLGoKyc
         cAa07UHsZii1dc/T61OZQZK9piyzEZr57TgG4PjwC1Cn0wXaN2jw8iB9XxvhHrfrkKCH
         nBpyL4Vbau7j54xr6Eo6bk+AZAjXlf0IglctMFVO8xJw+TsCajpro3X3lmfS9HBEYk5Q
         OSd4sy8OUpsF3pIPfYBZyR5P/VqURsPqAvYUHQdeOlaJYsev7ZCRXO9/TGaJOSbfdaPc
         5TDg==
X-Gm-Message-State: AOUpUlFATDjAYf4TtVJoRCThSc/1U75m4n4s7mKapNA/6qP/PCXuYVo0
        9odpWIneYJ0PnY+qwkaMtPe1YzkL
X-Google-Smtp-Source: AAOMgpecjXHOazLf41Q0s0upkXMRzAPu8NtTAvI5WqNMywzvN1JMUYDkE8HzOvX5AE8isE2DHVK3Og==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr5507279wms.46.1532034170188;
        Thu, 19 Jul 2018 14:02:50 -0700 (PDT)
Received: from larsbook.fritz.box (p5DDB4D1C.dip0.t-ipconnect.de. [93.219.77.28])
        by smtp.gmail.com with ESMTPSA id f2-v6sm118157wre.16.2018.07.19.14.02.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 14:02:49 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Find commit that referenced a blob first
Message-Id: <C00CED1F-D685-40E5-A5CC-4040BFD82886@gmail.com>
Date:   Thu, 19 Jul 2018 23:02:47 +0200
Cc:     Jeff King <peff@peff.net>, Jared Murrell <primetheus@github.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a blob hash and I would like to know what commit referenced 
this blob first in a given Git repo.

I could iterate through all commits sorted by date (or generation 
number) and then recursively search in the referenced trees until 
I find my blob. I wonder, is this the most efficient way to solve 
my problem? Is there some trick/existing Git command that would 
perform this search more efficiently for large repos?

Thank you,
Lars
