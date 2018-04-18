Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16B081F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeDRVon (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:44:43 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38735 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeDRVon (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:44:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id h3-v6so8628072wrh.5
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LhJGWYuXSrSemphepLZKW406Xg+q77NIsbIeKhOQxfk=;
        b=p2QE3qS9FvusFDOWWtxkEk4LncEJsE4JC0B2VTXtkA5R+JlYFKvk0NSIOpb6+Puv+5
         lLorIxD54cFiPzwSRFK1nG9Rb1VKb9flfL6XEppgJtg5VOcri/ltL03lcxduAmBKn38D
         wX1CZmFL/4oxd8FZQFERrOv6sCOqxKutEJwzeujEmv57uRsRV5LfKSyXeEwO/7uwiTK8
         ePEQ+AAmkfL+ztvk7uM2iF5Q+SCrKc+Z0kGxXvJpRR49iWTZkddxanj6R8kPTCqPyEPF
         Mc9e3hzmP4wNeAG3cAcnioV0fvjDBAGcqZ6VI27CjxkqIWlZmAj3zmOfNa4dEUhnBRMN
         3SxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LhJGWYuXSrSemphepLZKW406Xg+q77NIsbIeKhOQxfk=;
        b=W5lWvUjwOMCOGip4abb3uiMMWOTU/q7AEjCQxxoUWtTTlouekkAXsZTTdWavwv1saf
         07OOPMoXqMVXPCpE0m3wCGTsuiQEHjgX8lxlBa/fa232Gd2xNtZ34Z4p9m2q3EAYvI2t
         OVzMHwfoj56QmCtqrNQdeyYuBySqsIBnV/oOThMz7F1sxZJXW2IZtn+5e8l9ZgrV+n39
         jRjZh3T/0UY9E2n6ld9uN2PPqBzyZBV58Ol+vu6mQayWFOSavJMKS3H7hEm6Zb9cb9Zh
         Lr+dloVdOQdGZ2ijJq6/dxWT1a+uUB96UhNJsGmcjmZ3mx1YPUviAN4SMdnEBVpilrCk
         +ULQ==
X-Gm-Message-State: ALQs6tBEE4LzCj7Yj+v6Ur6dqvL/Wa0XOYcEbHq4mEz9iK0b8IPrmqpi
        AOPnFdwFbSaMyfNvttpd8EXJjRzg
X-Google-Smtp-Source: AIpwx48zPdK3oVXS9XICSyK4ucXtgrYlY7ujZkxzlN20F/rnJWGvrEJUipysqBiL2/Yxr2hmO/YRww==
X-Received: by 10.28.173.4 with SMTP id w4mr2947194wme.54.1524087881733;
        Wed, 18 Apr 2018 14:44:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n73-v6sm3039409wrb.18.2018.04.18.14.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:44:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <mail@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Dan Jacques <dnj@chromium.org>
Subject: Re: [PATCH v3 1/1] perl: fix installing modules from contrib
References: <xmqqpo3620tz.fsf@gitster-ct.c.googlers.com>
        <20180411065120.9432-1-mail@eworm.de>
Date:   Thu, 19 Apr 2018 06:44:40 +0900
In-Reply-To: <20180411065120.9432-1-mail@eworm.de> (Christian Hesse's message
        of "Wed, 11 Apr 2018 08:51:20 +0200")
Message-ID: <xmqq36zsgpfb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <mail@eworm.de> writes:

> Commit 20d2a30f (Makefile: replace perl/Makefile.PL with simple make rules)
> removed a target that allowed Makefiles from contrib/ to get the correct
> install path. This introduces a new target for main Makefile and fixes
> installation for Mediawiki module.
>
> v2: Pass prefix as that can have influence as well, add single quotes
>     for _SQ variant.
> v3: Rename target, add to .PHONY.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---

Thanks for rerolling.  I should have made it a bit more clear that
the say-* thing was merely a personal preference "I would be writing
it that way if I were doing it", not a "You should write it this way
when working on this project".  I think .PHONY is still a good idea
to have, even for only its documentation value (it is unlikely that
anybody would create a file "perllibdir").

Let me queue this on top of the v2 queued in 'next' as an
incremental update.

Thanks.

-- >8 --
From: Christian Hesse <mail@eworm.de>
SUbject: Makefile: mark perllibdir as a .PHONY target

This target should be marked as .PHONY, just like other targets that
exist only for their side effects that do not create filesystem
entities with the same name.

Signed-off-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 75b9ad3b48..b284eb20aa 100644
--- a/Makefile
+++ b/Makefile
@@ -1973,6 +1973,7 @@ GIT-PERL-DEFINES: FORCE
 		echo "$$FLAGS" >$@; \
 	    fi
 
+.PHONY: perllibdir
 perllibdir:
 	@echo '$(perllibdir_SQ)'
 
