Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAA4C1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeJLVJ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:09:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37655 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbeJLVJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:09:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so13019580wmt.2
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=icGx4OKaMKfGvAmV9Rl6i1MDaYiBcCfY3JYArjll5IE=;
        b=KZPUi/k0+Eo+VptUA1K7OCWEPnZ04vYnmtnIGgrNZkjlCISFncEQElizt4jypT2gDu
         iuEKtu+MSxjSVCfv7Rbd8ev13TIqJ/GVH9QjD12YYztd9bapxsiqiUS9HOEr7Zh6NpMT
         iQL9UED5ByQpplmmmzxqf3yArvvqFv94QNmnKhaoMdH8gJk4x9o3C25Lico6zsxZqcco
         JpJi7KzTxVxg80vsFI22iZ1nva2IFAJQI5vG5lI2uWzxLNHKLmPdyKyA0T5wUTSqUiIk
         6HFbrys+GZiL3zKXt6mIMpKoHGWxrXdZw7u0tT2atqzzSSPPHXGQLRVZzi7/SqFFL1Qk
         EsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=icGx4OKaMKfGvAmV9Rl6i1MDaYiBcCfY3JYArjll5IE=;
        b=fNjCwewEbKir+EqJrLaEvtuHteavOSNk0uiPZf6mCLXE8rGoyqgF3Rvih8lDKF/IC9
         PGEfBbSCyllUsbK97wOrt6De0ffMLfLwTQczlQhXHOPosvadETlj3vkc0o5rLg87vC0T
         otMx1Ie8A1D6YMPASR2LcfyHg32derqNc03WBnc8ScZVSHae9TvUopShzCfQS8EvqUDc
         gWas4BeKJQrKOXbJaaCI5EmhTigfW6Lfw9QOkMMxt0s6l+XUlML0Yw/DnRPW5ys1tBBG
         EEKpY7L4QRgSZXenmm5tPOC3i5Tbj/IYC7QU08Vlo2S15bdwHVRkpDxi5zZ/7dbCOrlN
         HFbA==
X-Gm-Message-State: ABuFfojsnTEYdDVASWjiak57yAy3NPcBuI6ZPvkmT0XtIBrkHBGaSiwq
        gs38B+CViwEmD1y2jcR/jPg=
X-Google-Smtp-Source: ACcGV60FhQR6JwFLoBNQxJxZr+oc4Ak5aurNWZmu2yjDAobNSI/MwQOg9P7MgQeqdmgS6QfGoEEdMA==
X-Received: by 2002:a1c:4d7:: with SMTP id 206-v6mr5531921wme.13.1539351418029;
        Fri, 12 Oct 2018 06:36:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b14-v6sm1146061wrp.42.2018.10.12.06.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 06:36:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Oct 2018, #01; Wed, 10)
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
        <42930bb1-502b-b168-be12-92aee526a258@talktalk.net>
        <xmqqa7nkf6o4.fsf@gitster-ct.c.googlers.com>
        <ca3b162d-d1c6-1ed1-cb20-4232d91f7b51@talktalk.net>
Date:   Fri, 12 Oct 2018 22:36:56 +0900
In-Reply-To: <ca3b162d-d1c6-1ed1-cb20-4232d91f7b51@talktalk.net> (Phillip
        Wood's message of "Fri, 12 Oct 2018 10:59:06 +0100")
Message-ID: <xmqqbm7zb81z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> It would be nice if the parsing used starts_with(option_name, user_text)
> rather than strcmp() as well. Also I think --color-moved=no is valid as
> a synonym of --no-color-moved but --color-moved-ws=no is not supported.

I am not sure about starts_with().  Do you mean we should accept
"--color-mo", as that is a prefix of "--color-moved" that is not
shared with any existing option, until we gain a different option
"--color-more"?

If you mean "--color-moved-ws=no" (or "--no-color-moved-ws") as a
way to countermand an earlier --color-moved-ws=<something> on the
command line, I fully agree that it is a good idea.
