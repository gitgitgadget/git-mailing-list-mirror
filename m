Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED22C004D4
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 07:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjARHFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 02:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjARHFD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 02:05:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C4267944;
        Tue, 17 Jan 2023 22:34:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so1102567pjb.1;
        Tue, 17 Jan 2023 22:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJYbw0LKodAqaUWH85oGEyiW04YMiBEWPGaAh2akyUo=;
        b=E59VRXQwyNiJzDnL4rNzBMuipHyTVktFr4Kb2CVjDQpbTolwOnFcwrfagMuLH9oxXI
         Vg3KPXvD+xkHdLGqBcXagkCuG2qjcyH0ZX3+OMxBgdczYAwphD+1Q42ishuGT7Ec/Wtr
         kZ4NsDjOnTfmHVJ0oAALoyXtLe5HRkQLQe6JluTMvZqCT6PR7zypc6hud7UcHu+C5Se+
         /3Wh93darUV5QsEfQK6Xkqql5+ZAwE/fKkXju7R/SLeVYdD4Y0+LFwGACJJXKMWkWk0Q
         xFlZFd2yqqWS4TzRYGBSGOMTR0/2Z2a75DVrF+lazl1KM+TT6mj5bcEz1B364ea/k2yw
         W5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qJYbw0LKodAqaUWH85oGEyiW04YMiBEWPGaAh2akyUo=;
        b=SNIvRl4hzqeST1tnLMtrlmooWvmarM8WStzhUZtamA/YqesJHlOlmtb8nCKo+4SGdK
         EIpXleW8BU49Xh00JQWe3h8bENnQW48Q/CkOhE+aQLdo2uUCfNofKaSMvqhRgDFX1rRu
         OPnFvi7oohY/nUobsLA1H0A05t4UIYyzQqdVjjWviq/CG1hkn5xGmT/xohy19dF7ns00
         FUBPQRof8akJY7/6ZEagZbmPrCUH2iwcL1eTkFxWtBv4trv+zY6xAWHUxfi5CKnMLDDR
         Te9+JGm9MnL8K5PtoMYW455DAwjlrjzjvChvZxHQAjSAssWXMJlfzG/KwRfZnJNxRNFu
         /ETg==
X-Gm-Message-State: AFqh2koTms557nBFtxZnS6JRiMj6rmNC1UfngvO/a+d24C4+c3F8ynsk
        wsfrRNKio+kXoTyWTy9h5kE=
X-Google-Smtp-Source: AMrXdXuxZbiQ/wXV9nI2B7KnhhlQXR1JeKxaswjrmFrMylyrKPj9yyQpqfF1c361ojTp42z9Rl4l6A==
X-Received: by 2002:a17:902:7889:b0:192:b5a8:3eb6 with SMTP id q9-20020a170902788900b00192b5a83eb6mr5028131pll.44.1674023658286;
        Tue, 17 Jan 2023 22:34:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u9-20020a170903124900b00174c1855cd9sm22170331plh.267.2023.01.17.22.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:34:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org,
        git-packagers@googlegroups.com, lwn@lwn.net
Subject: Re: [ANNOUNCE] Git 2.39.1 and others
References: <xmqq7cxl9h0i.fsf@gitster.g>
        <3b79e8c2-ddb2-fa6f-db6f-1f3cae31a729@ramsayjones.plus.com>
Date:   Tue, 17 Jan 2023 22:34:17 -0800
In-Reply-To: <3b79e8c2-ddb2-fa6f-db6f-1f3cae31a729@ramsayjones.plus.com>
        (Ramsay Jones's message of "Tue, 17 Jan 2023 22:35:02 +0000")
Message-ID: <xmqqa62g8i6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> $ git tag -v v2.31.6
> object 82689d5e5d3f41da2ab1fbf9fbe7aacfd6da74c1
> type commit
> tag v2.31.6
> tagger Junio C Hamano <gitster@pobox.com> 1670933242 +0900
>
> Git 2.31.6
> error: no signature found

Oops.  Corrected.  Thanks.
