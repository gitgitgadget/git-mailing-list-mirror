Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF8C1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 11:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfGNLeE (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 07:34:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40233 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNLeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 07:34:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so6168116pfp.7
        for <git@vger.kernel.org>; Sun, 14 Jul 2019 04:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yDd181UACiEW9Tf2KLdP6x/LmuTGoldaJaC/7nVaUk=;
        b=aaa6tueytmLYVWMTBaGTTbI5qopW9M48/mZ4kvYF+OqgHHuxO1VmS8LW7F84PmMXtg
         i+d7sZwSQqIxSIkBQp/X6kaK4KbKZzi2UO6W4xQuHD+mkb6pFfJpfeNaDJwJAHBrauZS
         zCyXwV8PCGy1ePTVOXV8JAhKEopKrKYnHn/8If92DLbUGR3H+fDJRFyjCyUlhwbbj1h0
         18e5tqnRHQ072zNqh37TrD7CvwxBYIPzJ7DrY11rQt4BJIBehsOvRaHwt/lDSMysdrY4
         LLGaAvZ//PEzCjYJoTJEChWoKRetF3EJiitmBY2RUOQPb01IiH816vAbV+2SgEB7yPV3
         9/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yDd181UACiEW9Tf2KLdP6x/LmuTGoldaJaC/7nVaUk=;
        b=DQi/Lotd0cn97WVPp4uGNPrYueBdv6bIM8a2PbUBEbPGzXW0w/rEUze0J+3PbNVYmV
         CJi1tYu6NirVmEuwBb5THd3WA0hnPSOGLV7VUrMql+U8K02xcCyzKQ41nnAs9V4Uw8P+
         T/25nYH4SlrZTAPpa/jT2nL3IwC55OB1rBTn8yxdLRHpDyZJCvaWRbaEmzTqJ78+VcGK
         NOUUexfRYZU2eYkV4F7tI7jqfbs3tZtcxg6o4tUT3LxkS8aZHKn1zVyPBGOyBVm2DesY
         woSLPRUXVT6upApdNVD/Q9k/WgjFKpWW5u5NFLx/5lqkqKAUVUBHO9j1gzf3nunUbQBz
         TnXQ==
X-Gm-Message-State: APjAAAXgn/6w8QebyXF+wAILDV2yIQSFX7mhBxbG4xrSYV+audSHSJ+V
        GfgbpBUTzfSGIMS0AnOFmo0=
X-Google-Smtp-Source: APXvYqyK9vlL4911SRJYs1qBHUp50YBsGuL6kGexrgYt0yKQaEjGpdEoHT2oC+4iDOf8MWlVGzsL2g==
X-Received: by 2002:a65:514c:: with SMTP id g12mr21350373pgq.76.1563104042836;
        Sun, 14 Jul 2019 04:34:02 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.215])
        by smtp.gmail.com with ESMTPSA id 137sm18321437pfz.112.2019.07.14.04.33.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 04:34:01 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 2/2] rebase -i: support --committer-date-is-author-date
Date:   Sun, 14 Jul 2019 17:01:17 +0530
Message-Id: <20190714113117.11748-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190712185357.21211-3-rohit.ashiwal265@gmail.com>
References: <20190712185357.21211-3-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 13 Jul 2019 00:23:57 +0530 Rohit Ashiwal <rohit.ashiwal265@gmail.com> wrote:
>
> rebase am already has this flag to "lie" about the committer date
> by changing it to the author date. Let's add the same for
> interactive machinery.
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> [...]
>
> +test_expect_success '--committer-date-is-author-date works with interactive backend' '
> +	git rebase -f HEAD^ &&
> +	git cat-file commit HEAD | sed -e "/^\$/q" >head &&
> +	sed -ne "/^author /s/.*> //p" head >authortime &&
> +	sed -ne "/^committer /s/.*> //p" head >committertime &&
> +	! test_cmp at ct &&
                   ^~~^~~~~
Slight mistake in changing names, I'll change it after a full review,
please ignore till then.

> +	git rebase -i --committer-date-is-author-date HEAD^ &&
> +	git cat-file commit HEAD | sed -e "/^\$/q" >head &&
> +	sed -ne "/^committer /s/.*> //p" head >committertime &&
> +	test_cmp authortime committertime
> +'

We should also include a test for am backend since the flag is not
directly passed to the am after the application of this patch.

> +
>  test_done
> --
> 2.21.0

Best
Rohit

