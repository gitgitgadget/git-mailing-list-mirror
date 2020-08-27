Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18801C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDD4422BEB
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgH0OJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:09:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39002 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgH0OJC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 10:09:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id z195so4701862oia.6
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 07:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+DPyvTzU6TIfJCcuG9Ie+ZY7ffmQka7Ys+5cCyMQ83o=;
        b=JJaprRmlAmLRRSLe/gp/bY6f/SsM2mv0H6DG8YIC3gyyO/l28/aGCnJG9jFtmMqO1u
         31xv2+aLU4lfGqoCxxZ2fyQSECP6Y9mfqiHNYOEEJfCazrDohOwfvxsRgPAACBV66mOv
         izp7YMKra5AQ8KS1M7NjoW2TVT6afUq5bXSy34roLRX+HMn1CzdeVtTZkiV3nNcDwEjf
         aeRF28OchBRMHHgQgiQHtbqiiV42m8S6yT5r0hntbEXTBswvTIrjTxKt14oFX14y7vjX
         7Wx42puWEf40hXFNTR/catkoJVS6ynRvi+bHdKHBN4eTSQ/9y/stY3R15aFjdSPUjl34
         lsbQ==
X-Gm-Message-State: AOAM530SnvCFN/wI8KBFFyWqJ54C1mNdb6i4nKOfpF6BLG/c+A0q4fTN
        5PJXFZeVKZSWXcrPa9urZHqRwKpj0zI=
X-Google-Smtp-Source: ABdhPJwN/CpRMNQoj+6pN+XBWXDsYgElRcd8bWde8MuJZhM+C551gIH6kIc4Ti9+bJV+vvjuD/x0sg==
X-Received: by 2002:a17:90a:e286:: with SMTP id d6mr6392429pjz.98.1598536881225;
        Thu, 27 Aug 2020 07:01:21 -0700 (PDT)
Received: from localhost.localdomain (50-125-94-129.hllk.wa.frontiernet.net. [50.125.94.129])
        by smtp.gmail.com with ESMTPSA id e23sm2475641pgb.79.2020.08.27.07.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:01:20 -0700 (PDT)
From:   Sean Barag <sean@barag.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, sean@barag.org,
        stolee@gmail.com
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
Date:   Thu, 27 Aug 2020 07:00:46 -0700
Message-Id: <20200827140045.470411-1-sean@barag.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <xmqqpn7csoqd.fsf@gitster.c.googlers.com>
References: <xmqqpn7csoqd.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In order to realize any new feature that needs to read the existing
> (i.e. per-machine or per-user) configuration files to affect the
> behaviour of "git clone", whether it is the "give default to
> --origin option" or any other thing, first needs to fix the start-up
> sequence so that the configuration is read once before we process
> command line options, which is the norm.  Only after that is done,
> we can build the clone.defaultRemoteName and other features that
> would be affected by the settings of clone.* variables on top, and
> it is not wise to mix the foundation with a new feature that uses
> the foundation.

Makes sense!  Thanks for all your help -- I _really_ appreciate it.
I'll give it a try over the next few days.
