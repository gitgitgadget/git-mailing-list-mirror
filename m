Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FFB20248
	for <e@80x24.org>; Mon,  4 Mar 2019 22:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfCDWyR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 17:54:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCDWyR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 17:54:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id g20so718690wmh.5
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 14:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rNOOiAiFyoluONfKfhhdLWmCe9xPnHPZVr+r/n4ADlk=;
        b=p+PskmSVdpnQn37kX3+0qTcCpoN32/JljXonaWZcsBRu9YF0YrNUNxf+Sfl/yuxbu/
         MOoBlDdhrnRCHI6YDs4m8sq0SMP2pySmRI72ezD/jkAaUXwvk81KwxTj9E3SClo1zdWn
         a3ZAcVd5iNGZQ0L7RmBGeVz/BMicB9HK1Ldm0TToFKkcKdwHF2H7SCoT8z4ga7wNP2u3
         5pRDi74ONypYtSU2xHfYui2cbXOZIzd42G7/V2UJWp/nQrKtGxdeuiFMNJ/w6shWR4ZX
         u9b4HbCOr/2nokctZzpKt0oDLXX3ZJj5R+JHN2MTo7Iz1yVYyYJANHy7ONKX1EoH9iyc
         tF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rNOOiAiFyoluONfKfhhdLWmCe9xPnHPZVr+r/n4ADlk=;
        b=PYhJDKxIqjmw4isxp28k4evSwiUg0SfE0Ji5oaPbZp9l0T8QEJrNdSf7AdcE2/fPyJ
         LSuMBybKp3ijyvA1OJggOItUSZLQDQ/U4g0LilGAXtWLcCcyWbOE7mfBIR2r7AUet6hT
         8j1Ai7AxZOjdbQf+VQw90eErVSvee9FhveqLpAKfmUKMcE1l+O9CYLUYYtGtcynepwxl
         zCfpOCT98fQogcHZAJpMXI5s+G6+k5PtUop80sm5g6QBrNB1iyFk3Vx1oKU7CyUPMyGu
         dG/vTGvCtP+Cf5pupLdBgrOhmrQn9HU71uIGmmrBx8u49wfXaX+uAFd6pMIDle1QFxnC
         wR4w==
X-Gm-Message-State: APjAAAXMxB+puqRE4f6yWJrgOZxFrmsPBnfgaKNzt1/hSOjSNkfE76Y9
        Y2ELksbF9ZF28zm0zNF5Q9E7nlCgdjk=
X-Google-Smtp-Source: APXvYqwlnRB6FIlXiFYS6COMakCqAodL8fJKSFxnC1dmZZFfcu4UKbIJXEaYXqvtE8TQS/FKcVtkSw==
X-Received: by 2002:a1c:2545:: with SMTP id l66mr729177wml.96.1551740055298;
        Mon, 04 Mar 2019 14:54:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h15sm7880109wrt.56.2019.03.04.14.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 14:54:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is "git rebase ... [branch]" equivalent to first "git checkout [branch]"?
References: <alpine.LFD.2.21.1903041536460.12447@localhost.localdomain>
Date:   Tue, 05 Mar 2019 07:54:12 +0900
In-Reply-To: <alpine.LFD.2.21.1903041536460.12447@localhost.localdomain>
        (Robert P. J. Day's message of "Mon, 4 Mar 2019 15:41:16 -0500 (EST)")
Message-ID: <xmqq4l8iw8rv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   i *think* i know the answer to this based on man page and reading
> the code, but i just want to verify that i'm not missing any subtlety.
> ...
>   "If <branch> is specified, git rebase will perform an automatic git
> checkout <branch> before doing anything else. Otherwise it remains on
> the current branch."

Yes, but with a caveat ;-)

At least, the original scripted version of "git rebase" both
designed and implemented the final extra "rebase this one, not the
current branch" argument as a pure short-hand for lazy people (like
me, who wanted to have such a feature and made it so) to be exact
equivalent to "checkout before doing anything else".  Which means
that HEAD@{} reflog would record such an event as "checkout that
switched to the branch", and it would have affected the computation
needed if you said "git checkout @{-1}" after the rebase finished.

I do not offhand know if the current verison of "git rebase" that
was reimplemented in C changed the behaviour, though.


