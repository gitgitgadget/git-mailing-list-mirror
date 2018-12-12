Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288E820A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 22:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeLLWrE (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 17:47:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39636 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbeLLWrD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 17:47:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so425970edt.6
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 14:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84yO7mwe2eChsrUA9vNolGuq2jEXAI8R0e6ZswFAROA=;
        b=NOTk4kI6saqVIQci1Rq96yzcJyuWQNsMdWuIPfi0sPgLLQV+6fcojkGEaawXOhIdlR
         RK7I2anJjemBrIMtMegoBqGmKEa3PCYwirO5s11bTTMXWgCpUiPS37Ky+noTuh0HHZIp
         YvI37+3Ez7puxuDzFSQ0OuoHqEl8/JEflGzhLdvl4ako52YyF0d6eSeG+3BWsjUpKb5V
         Kx9QlGq+Lu+yLtfuGUW1YuHoeLRKxCscscFDxt15YWMNCVlq06MPowL1Bs37REDrEnEH
         MMDASN0fIQ3ZZorZZarN+RdGxg8AvJw1en/D85thN5GI4MtW4AFg1ZVE8O3zHaT0WVym
         fEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84yO7mwe2eChsrUA9vNolGuq2jEXAI8R0e6ZswFAROA=;
        b=SGq0ePfKPVGOU5lAc0eYB8DbyCxhKnhaBYXQL8eQYB6d4JPrt4A1go9BgWEnPcKNs4
         +gpEbFh9S4S0WMpWg8E5DcdBDon/0Ypt0BukuKua8d2QL5/GRGbHSKSTQYHFh5Uh+z0R
         79Uf3AX5OYQhTpqwjDADMLOj3TnVPcGvfkuUHBg+MbDLL3UBjdlZLJKc4C7baCDSiJJW
         gb2uxEs52OG7NJNdvAygk57KMJqUd0m7OHh8Cu3heshsaYOwJPR5xGwnT0F9fvUFiWL2
         lv+yWofxQOcyupm/gUqTNYt97AYJ/5bhRYaXNe/+lYSz3zcusuEDCpMW5+dXqRVgu9gM
         VAKg==
X-Gm-Message-State: AA+aEWbCXDlTXW/aLvzcmVfFyO+kXPQu+YsIsZxpsy32wEyklSngbOOW
        F3Fby+0Sz2Zybj/zO4sYiEmdc4CZqIwD/H68jBiIbA==
X-Google-Smtp-Source: AFSGD/UiNfe4pCdQ/jMgxdqS50TQaTz4pL2wjwc0Ar08xe4s+tIKEhIeQPMOwh0Er58kSE4ODl3CoEmblFYEFjtjIyA=
X-Received: by 2002:a17:906:2dc1:: with SMTP id h1-v6mr16433247eji.67.1544654821551;
 Wed, 12 Dec 2018 14:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20181207235425.128568-1-sbeller@google.com> <20181207235425.128568-4-sbeller@google.com>
 <xmqqsgz87bj9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgz87bj9.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Dec 2018 14:46:50 -0800
Message-ID: <CAGZ79kb0Vqk8Gtao6OdKx7gJi6pCEpLzcqQsk=uqCLfePZrmVw@mail.gmail.com>
Subject: Re: [PATCH 3/4] submodule--helper: fix BUG message in ensure_core_worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Unlike the step 2/4 I commented on, this does explain what this
> wants to do and why, at least when looked from sideways.  Is the
> above saying the same as the following two-liner?
>
>         An ealier mistake while rebasing to produce 74d4731da1
>         failed to update this BUG message.  Fix this.

I am not sure if it was rebasing, which was executed mistakenly.
So maybe just saying "74d4731da1 contains a faulty BUG
message. Fix it." would do.

The intent of the longer message was to shed light in how I found
the BUG (ie. I did not see the BUG message, which would ask me
to actually fix a bug, but found it via code inspection), which I
thought was valuable information, too.
