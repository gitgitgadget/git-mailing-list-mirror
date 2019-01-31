Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5129C1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfAaSXR (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:23:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55920 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAaSXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:23:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so3498384wmc.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 10:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JNH8FofBR8oQmNwvpL0POEQrUIP18vo84yRFmDJ8Z+k=;
        b=JCGFq5fDqsmUqqyKYW7S+5POOmmtFrwFfps17dYJcey2YQ5bZcyH7C9EySA/8vLDGH
         peRCi5leOS0l1piBj5mpr3oGsQrKKBCfmu2BG00N4ojLhnZyj92UPVQSaV0XysBEMDzZ
         dSgrOu2fjcBujS/La9Hg6LCArVZioHH5ATiE130j9a9cctQqBA0P/u6pr5+D+wT7RmYn
         i1AOMR/rYaUjrWlZr2qH9w5oWLsmNuUzFGwckZovhuMWZbk1Pyw/Jaa6+DxG9yWdSEFO
         h6oJ300eXc6hUIINNM+qQjWUB357XQ5LlJoHAZ0ZaCkap+tKeJcg0vfYdFY/iaDaIgj6
         J4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JNH8FofBR8oQmNwvpL0POEQrUIP18vo84yRFmDJ8Z+k=;
        b=faE/gjNjeUWKFqCflrOzz7QmhtCHimS5WJTboVUHm2ifkLWNyYf69LvsfQcp+LZrg1
         BEe8bBSapOxL6/pjGZoUNczvXRJhL1i3wYmwGZ/uzrh0PWH6WvjWVlJP92he6CqP9mX7
         4FpmOTBRNXaFlG6RLwHQIIlloDjWhO+eZbbfnYrurH/w3WNrvqYXocp4HyYEhpdAqIr/
         PUw0ROSkEwabD0BaqMQTu/TFXZQ7GifNpQUhQ0m6nVevB9tLpjbAYhg58SRGH+roIyuM
         4fZBAdWdkexpTsHGDRTcwxO4qlFiQVfp0unU5ytsgVOuh3IW2tbkNsGV60EtHd0Qa9jL
         Pvlw==
X-Gm-Message-State: AJcUukcJaZ177qUSmNAil9zQfm8bTLyRleONnk/3/j3jam/yaa8Y5uQY
        QPSHRbbGJScfObIT04SS8W8=
X-Google-Smtp-Source: ALg8bN7B8CkHfjINietEgPBZrXtT+Fhk+KTD60KXHij8egJuRPeibZA5QtJeLwtvn4JEv1HjS/K3rw==
X-Received: by 2002:a1c:4683:: with SMTP id t125mr31957923wma.9.1548958994623;
        Thu, 31 Jan 2019 10:23:14 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 3sm5182773wmw.46.2019.01.31.10.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:23:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/19] Add new command "switch"
References: <20190130094831.10420-1-pclouds@gmail.com>
        <20190131133731.GK13764@szeder.dev>
        <CACsJy8A7TjYWJsxXETUU31JzZL-aCXcr+rHsQ23Ec1ujeMcQTA@mail.gmail.com>
Date:   Thu, 31 Jan 2019 10:23:13 -0800
In-Reply-To: <CACsJy8A7TjYWJsxXETUU31JzZL-aCXcr+rHsQ23Ec1ujeMcQTA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 31 Jan 2019 21:51:29 +0700")
Message-ID: <xmqqk1ik3cvi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> Adding '--soft|--hard' from 'git reset' would go in the opposite
>> direction.
>
> If it's about the confusion, I think we can avoid it. If it's about
> the one-command-do-all, I think it still fits in the main topic of
> git-switch, which is about switching. But in git-reset case it's
> switching HEAD, not a normal branch.

I do not think "switch branch" should update HEAD for the branch.
Let it be handled by "reset" (or "branch -f that-other-branch").

I personally did not have "it is way too overloaded" problem with
"checkout", but it turns out that many others found it so.  You'll
see the same happen for your "switch" if you do not resist
temptation to add unrelated things (or things you may find related
but you see others find unrelated even in this early discussion).
