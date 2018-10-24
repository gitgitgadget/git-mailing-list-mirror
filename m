Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A131F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeJXLgl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:36:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55007 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLgk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:36:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so3733112wma.4
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rb3v9eeDms2Jv1Lo4InfS+2LwQNWsh7Rt4MGwhqcdaM=;
        b=W35F/jNxtrqWV+5kW/ditpQzDjtYsFvar+/HLvZL8D5RIGi1yHoMaIRp/qoF63q91L
         bk39Jc1UX+70UrWS+vFTebYVwbNpbN6BIHRy7sqfOzrRARndQ69QPlBGRdg3X+LpDpyp
         Ub74An5J+4noOuHuVXY4NGBbOrKq9VofVwNYE+MX60d/p0zoWWwCCSgFYPpwKV48v7/K
         MQk7h6Fgxpt8VkGsgz/MW30eVk3W6xGRRZiM9uDZ4zn6f9WWx+rNJq68KQAb+l3tn71k
         MjCeICErc6Ne4xW5woRYNa9ZVi0T8Tcv1EHvxa8/uFC3dokRMv8yrhNPP6oWKJhENSji
         Hkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rb3v9eeDms2Jv1Lo4InfS+2LwQNWsh7Rt4MGwhqcdaM=;
        b=kARz1imVjQ+idEIDzVXx6uHcRC2K3JjXmXPWnXIYc339nII1MqSg7X/IOPGGMzQVbb
         v1eaciovQcqgHcsEAX1zlCc82zsrfasordOY2ltRwaeSqYkZUCprPhH7NnsikIftVt9j
         yPiDglG1HQbFG2Y2irlsdHri00NBZnA5iTY9n8j6/oG/6HdJD42cF66m4B7FIL9Gdbch
         RurPWTOrmUQH4RX8WbXgFtwyZPC8N4e0jFQwxiihsyyUfT0ugIyUYC/mvplHPpt5uUew
         O0PNnkVPAq3s88GeM+rY0v393P+Y8PMdZnA2eDc/kOIOP077WwWZ9fg4HHtcZ14WRGOW
         6MjA==
X-Gm-Message-State: AGRZ1gKkVIijj+/z8mptt6rW80k9DIiGY60eKwPuKSTxCWQyedxT3AyX
        6gKwv3fXjJUl6NZLRuoYbXyx51ucGz4=
X-Google-Smtp-Source: AJdET5dSRLTxyFvXOpfRznQZpOY1mUqhkOQETOug/f0gn0VtfWxI6sQP4EDSDlAiPhp6v+hALJJTgA==
X-Received: by 2002:a1c:adc6:: with SMTP id w189-v6mr490240wme.96.1540346871800;
        Tue, 23 Oct 2018 19:07:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o4-v6sm1779573wrj.45.2018.10.23.19.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:07:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitter.spiros@gmail.com
Subject: Re: [PATCH] test: avoid failures when USE_NED_ALLOCATOR
References: <20181023093856.78944-1-carenas@gmail.com>
Date:   Wed, 24 Oct 2018 11:07:48 +0900
In-Reply-To: <20181023093856.78944-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 23 Oct 2018 02:38:56 -0700")
Message-ID: <xmqqlg6oqeq3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Belón  <carenas@gmail.com> writes:

> contrib/nedmalloc doesn't support MALLOC_CHECK_ or MALLOC_PERTURB_
> so add it to the same exception that is being used with valgrind
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Unlike the case for valgrind, where we actively do not want to set
these two environment variables [*1*], I am assuming that nedmalloc
simply ignores these two environment variables.  Is there a reason
why we want to special case nedmalloc like this patch does, but
leave these set for other implementations that do not pay attention
to them?  

Of course, I am also assuming that there are implementations of
malloc(3), which are not nedmalloc, that can be used to build and
test Git and that do not react to these two environment variables.
The patch would make sense if all the other implementations of
malloc(3) paid attention to MALLOC_{CHECK,PERTURB}_ and nedmalloc
were the only odd-man out, but I do not think that is the case.

[Footnote] 

*1* see the last two paragraphs of the log message of a731fa91 ("Add
MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test suite for
detecting heap corruption", 2012-09-14)


> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 44288cbb59..2ad9e6176c 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -143,7 +143,7 @@ fi
>  # Add libc MALLOC and MALLOC_PERTURB test
>  # only if we are not executing the test with valgrind
>  if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||
> -   test -n "$TEST_NO_MALLOC_CHECK"
> +   test -n "$TEST_NO_MALLOC_CHECK" || test -n "$USE_NED_ALLOCATOR"
>  then
>  	setup_malloc_check () {
>  		: nothing
