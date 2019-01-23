Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5011F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWXje (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37975 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfAWXje (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so1148989wml.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=DozuzC2hZZcPqOs+RQmj30b5HGEW1bPNg6eSlMnrr8Y=;
        b=G3kyz+PyPGR2aSembqBxILVdZghxnEoWUKUM+8KV7/sr3MZivArYb2ZegU4+/LEiTb
         BbfdOn0weRqLkR4L8p/c1Syv4kIYh+0VGdcJLZSuFnxFGjNeN8ZdqxHNIysLjF0l5QeQ
         NJ8n+MIfGPXAD9vSgjxAvJsH3M3hdnomMm+ANAvFzHZ8MjSR9WB9CUO2ir7UqKzz+q7L
         /90+oeqWfZEXjriunJMgz2gn9MLsd1QkIGW4FyGYHwKIPb0CBzxaVpUxutydn1OR0R9K
         mPok57XeFA8dcZRH6pGTMZGRGxJUPXG4fXFuvVRiMMc92/0IGK7T5oucEYKA59IYDGNI
         iIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=DozuzC2hZZcPqOs+RQmj30b5HGEW1bPNg6eSlMnrr8Y=;
        b=H4qIIk1EKIhuC5RTbu7iqaHW8yzCXS/iPE3G7TfNHsL5nR1vXNyNQTXWZT5UlWgpB7
         8LMY12gKUCSmo1tgiKZDGGW27e8eNHtAI4DTC7adhMzRhMd4/Ll2rJtsNqORdkey096X
         IdTHpt7e5zEwjPA8MEcOsIlYi+B042ISauzg7FfD1p9UqPAjUOpeC4bBT/NHRd2ZVG4g
         bwexdsVXu7BhLfZ4Ww3V41+K5Tw4ti+w5zPBrHE4+ICZICX2svHMrU9dOBPgTv88p15g
         CGnsIzzDc0vIL9LqO3FcgB4Tt6JFRES+WBO+AMDCKfxNG4tFrv/ZOyvcbdfVjbmyPLSS
         nK1A==
X-Gm-Message-State: AJcUukcQv6FamMNhIITzknoI0oiH+4EW5XFWES2TceY5H4x/Hhl7kyIk
        p20FRQIeXJzy+1eQryN13c4=
X-Google-Smtp-Source: ALg8bN6Vx46lviHzAOy8F2y9zIYuysw/2a3kvDsij4JvDBFJlmLbDsPaEvrcPa0d34vdOcltE+KaMA==
X-Received: by 2002:a1c:d082:: with SMTP id h124mr123384wmg.21.1548286772433;
        Wed, 23 Jan 2019 15:39:32 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7sm88074028wrw.22.2019.01.23.15.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:31 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 00/21] Offer to run CI/PR builds in Azure Pipelines
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
Date:   Wed, 23 Jan 2019 15:39:31 -0800
Message-ID: <xmqqo9873pvw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series took waaaaaaaay more time than I had originally
> anticipated, but I think that in particular the advanced display of the test
> results and the reduction of the overall run time was worth it. Please let
> me know what you think about this.

I left comments here and there on individual steps, but overall it
was a pleasant read.

Thanks.
