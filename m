Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64A821F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 08:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeJMPte (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:49:34 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:33754 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeJMPte (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:49:34 -0400
Received: by mail-wm1-f49.google.com with SMTP id y140-v6so19442054wmd.0
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PdOL6j+8GgwgS8mRV3EyCLUBj9INPVHnq86hfi1bYcg=;
        b=nRvE0MXQGoWSO2jp6lcG8COkWJxC3G0V+hPXmAIGukZsXKUKQ8Q83nL5M23asAofuT
         /NWH+r+IE9CioEeGQH+B9uQh3E4qD6H9jPizxoVHcvEhNPvWqd/zQwve/zO5T2d8hYBy
         W0vYAWyo9VFYSq/gEDjsROzlwm5DNk4JH1tcFGsZ54h9p0/0Q0iQA9/6xOw45ypVCcZY
         9tZzwj+kY1xph6AwE9hpHnEHnTVMsrPGFaqCjusrC815gdyCR2BAmrV6NdhsFju2KVgB
         jSrgcfHizJ8gyf7jRxFM8l6dlE6pLWmi0MLrxCnwr1NQc3kYyaw21ZhzlCYGWXaw1Sn1
         DKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PdOL6j+8GgwgS8mRV3EyCLUBj9INPVHnq86hfi1bYcg=;
        b=FOw2V+jvLwyUHyJv4AUwn+/BkHgKZj9KKpItJn/IKtgGe4gemZIW+Ac+T+cUGgjUSp
         PGloTeHP3CWeu9d9HbgB6jGk+ZBY2CW7fHVY534aQNlaNaij7eRtsqhlZ9ydchX8xjAy
         LcvTUPaf6c5YMqbcDKge0O9n26O4cd7ph2NhLVRBpEAHakveEGOJNHkqhw1FmiqxZr0l
         Lh6mz8RU/BMc1GouSe7+3gQUxVLOfEDaEetzsNZbok9j0CQEKKtj4Hp6dyuMWjNpmMmt
         S79fvlctz2jkyCe+qajJWvIYx2qDfCYCRIWpWFhUOSQT2pvMazdrGWwNVpqkVBnjuc/L
         AM3w==
X-Gm-Message-State: ABuFfoiEwW8+30/d7v0KeuAwL8bh7SEPMXwcJv2VwniNn6wFBWSqClRb
        DRlyR+D72VpZye5PX8/qZzE=
X-Google-Smtp-Source: ACcGV61QLyI+9t+IM3oV+hL9kxqvDsKj41RplzlzN8WyDSkGLMKZrah26noBLUnZJRY9kOC9E0U/BA==
X-Received: by 2002:a1c:b402:: with SMTP id d2-v6mr7527893wmf.37.1539418399843;
        Sat, 13 Oct 2018 01:13:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w192-v6sm2590008wmf.33.2018.10.13.01.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 01:13:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Andreenko <andreenkosa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: issue: strange `git diff --numstat` behavior.
References: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
Date:   Sat, 13 Oct 2018 17:13:18 +0900
In-Reply-To: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
        (Sergey Andreenko's message of "Fri, 12 Oct 2018 11:23:28 -0700")
Message-ID: <xmqqr2gu8dsx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Andreenko <andreenkosa@gmail.com> writes:

> git.exe diff --numstat "C:\diff" "C:\base"
> ...
> output will be:
>
>               0       1       {iff => ase}/1.txt
>
> So (folder_name_length) symbols were cut from the path (“C:\\d” and “C:\\b”).
>
> Is any way to avoid that? I have checked several git versions and they
> all do the same.

Not an attempt to offer a solution (I don't do windows), but just
trying to see what random things we can try, I wonder what you'd get
if you did something like

	$ git diff --numstat //c/diff //c/base

