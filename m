Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18F0E20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeLNCXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:23:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35482 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbeLNCXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:23:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so3950122wrb.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kf7ArszYP7LEvlA3ZEezFwxUtU58WSPodX6ylIqmzOg=;
        b=lMip2jCl+ue2YTm+tyorjem+z00i9Y1OKDQGhepWJyu/5daW2wrUpJ1DC3VCCES/Gh
         q0TS/jWyqktNsX7QKgopdQpSuTkorfVop+84slA0OhWamkM92h9KTlfmO+OYGL/XkrMB
         FDkfTqRIhsWt5OhRY/4cKxAxgbS3GzHdzhXXHWgmcqx6Ou9zbDCQQN+dRZ5wFPks+3lc
         0TbFBstUpnTBh4kvZ1r0LXIIsR9wejeh+SMZK+IkCz1b4uF+jGR5skpUJux6NibWf9ju
         l+cSoytz/YnDhCGSLDtYi8YOXxLMzvzgKjCvaeDj7j0OlSh+XI/6oUF+bmp0yKgVGjCG
         AxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kf7ArszYP7LEvlA3ZEezFwxUtU58WSPodX6ylIqmzOg=;
        b=KxV8lqj1HN28JNM7MTwo+qUPHfnUVmXy/lOU8QWuMR2aZR1pzeSA3UlmIEhEhnAi/T
         bEifbqfHHGP2E/VOUCTg+g9C+06r55R90SJNWxP8HoBmnUWpoORqxi+kc+5MVAhCvfaJ
         yHEXXSafOslWt7KhDax7HcNWom+NgYl+EOMFKmf+mJApRukEG9fyyxaXvhMqtqm/KYRb
         CetMVsAaF1457b8nWU1sIYpegtE5dYIApZxi31edqqdINSrtJru1E5dw8L1mcJpgAL3B
         Un853rDlOjqCFFXv3VGb70TSNk+29+mac5vGt3npBurSaaH0RdMqNjAnjgyD/Tqtlkb9
         hiWA==
X-Gm-Message-State: AA+aEWbQ92UpvKP9h6sf0xnChySa0QIHkoWLNWL9Fqozm6Y+ZfN2rTP7
        ASBXzf1aeNWn2YACdObsc08=
X-Google-Smtp-Source: AFSGD/W8oZ3qR0Kry0IoFB8hDV/fcG2LQKzgPYTb0+DpwW84VeN50ga6WyvC0rG8SAN37Kr7MXJFzg==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr896990wrv.287.1544754226696;
        Thu, 13 Dec 2018 18:23:46 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12sm2925349wrm.45.2018.12.13.18.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:23:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/2] .gitattributes: ensure t/oid-info/* has eol=lf
References: <pull.98.git.gitgitgadget@gmail.com>
        <pull.98.v2.git.gitgitgadget@gmail.com>
        <4a22502a318a65f144b3b6542cc5e711a1811c78.1544638490.git.gitgitgadget@gmail.com>
        <xmqqva3ygnh3.fsf@gitster-ct.c.googlers.com>
        <6d6ca9a2-9245-e5e9-6d7a-e6d3004054bb@gmail.com>
Date:   Fri, 14 Dec 2018 11:23:45 +0900
In-Reply-To: <6d6ca9a2-9245-e5e9-6d7a-e6d3004054bb@gmail.com> (Derrick
        Stolee's message of "Thu, 13 Dec 2018 11:22:26 -0500")
Message-ID: <xmqqbm5oethq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> FWIW, I personally do not think "is sensitive to CRLF" is too bad,
>> as my attempt to clarify it does not make it much better, e.g.
>>
>> 	The logic to read from these files in shell uses built-in
>> 	"read" command, which leaves CR at the end of these text
>> 	files when they are checked out with CRLF line endings, at
>> 	least when run with bash shipped with Git for Windows.  This
>> 	results in an unexpected value in the variable these lines
>> 	are read into, leading the tests to fail.
>>
>> So, I'll keep what I queued when I received v1 for now.
>
> Sorry for missing the edit to the message. You are correct that v2
> just added one commit.
>
> I like your rewording, if you feel like editing it.

I'm kinda neutral ;-).
