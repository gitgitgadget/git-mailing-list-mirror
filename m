Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6A5C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 22:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358204AbiFVWBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359399AbiFVV66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 17:58:58 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B65F81
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:58:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u13-20020a170902e5cd00b0016a53274671so730344plf.15
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=/BVg6Gp6zwQV4IuQNhigtOnXrs7jYwbSiaom7XkNtls=;
        b=i7ZVV/sJgaBRvKrM/HwxJcSH2UnZjYtAooEqhVtsLt52sF7Jg45w1vmgzDWRLUkDQ6
         xMXmlrwnAjxhEnXIDPdbK/Q8mQfJ9Q84YmzEIwqF5WgBT5abnEy3TIbj/f2SmLIXDanE
         lNzKAPHczk/2eiKRoJRNWVTImTXNRSwTR9hRDzlf4HRu/l+VWadW5OKQvRK7zJPMZM0k
         CGRlexirut9/POe9JSDYkWkT1s9iAjJzgavsjRtQowWGaA3ghwtD7i2XrA0Bjb3Uf5aY
         YFcaFDLhcIQsyUS+IkNg6kf8Lpa3W7G0pDxcLxJJAjIG1TmhCvlAqr558honkiIuNOUm
         mPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=/BVg6Gp6zwQV4IuQNhigtOnXrs7jYwbSiaom7XkNtls=;
        b=eNYbi/YPLVZgI30IsO9lUJFdFIDVNbNtJfj59lNweBJH5nOIEUVjVSpfSjhufsASPZ
         Vgucqp14ZvOnvL1nKDxBosblaZkRlpyKEEkh66CvaSp0Y6/suS1WIJYZrBZB+7E2byQT
         3+8QnaqrOL2xFDv4ZA5AyR3QnxQQwcWCR5+bA+oQTzvyzL7XVZWwSQ9ft7B/zOlc9veV
         +gjx40Eu0Ze34LPk9X8zt2hd5VtAziYOkVA6IuqiocjPqTybmlPUFS+AZtwQn9fP/M/O
         O55UMfYJDwq8s1KAdwbInrTJFLbxf5e7xfcJbloStk3skylZYUr55YXO21MSzLtlhwUA
         VOTQ==
X-Gm-Message-State: AJIora/jv5sbFFBf/W2vDS/torMg0ZSZP15EZ3V0bI/7m23biwXPh/Ck
        ZOwXiiFp2LGfETpvrES9T12+H86cajMkZOzA6RQl
X-Google-Smtp-Source: AGRyM1s5J51IPKLEFvH0pbohcJbw9d0KgItvzuqHYTmORuY8NaA1yO0H7aSya9eJXYcDhyPAZ0mceWqpK5ZlcO6yadv8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:f548:b0:167:5c83:3adb with
 SMTP id h8-20020a170902f54800b001675c833adbmr35636270plf.70.1655935132350;
 Wed, 22 Jun 2022 14:58:52 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:58:47 -0700
In-Reply-To: <a5a1dcb03e18f3b9f3fd77ef94c17a05763a5f13.1654635432.git.gitgitgadget@gmail.com>
Message-Id: <20220622215848.3733308-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH v4 2/5] Documentation: define protected configuration
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> For security reasons, there are config variables that are only trusted
> when they are specified in extra-trustworthy configuration scopes, which

Probably better to delete "extra-trustworthy", or at least "extra-" -
it's better to explain why and how they're trustworthy, which you have
already done in the commit message.

> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 5e4c95f2423..2b4334faec9 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt

[snip]

> +Protected config refers to the 'system', 'global', and 'command' scopes. Git
> +considers these scopes to be especially trustworthy because they are likely
> +to be controlled by the user or a trusted administrator. An attacker who
> +controls these scopes can do substantial harm without using Git, so it is
> +assumed that the user's environment protects these scopes against attackers.
> +
> +For security reasons, certain options are only respected when they are
> +specified in protected config, and ignored otherwise.

Also "especially trustworthy" here.
