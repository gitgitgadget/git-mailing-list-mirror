Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9255920193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934688AbcJ0V7O (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:59:14 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36279 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933375AbcJ0V7N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:59:13 -0400
Received: by mail-qk0-f173.google.com with SMTP id o68so65008292qkf.3
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 14:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=usImsrBlLnGBu2b+AV5pWhlxCp/0p4ZfOPeDtFXMx+g=;
        b=lDOKbpFi+UHClJ4aPXzkLTULyHHREfQbvhRoBT4jAO03TpTlpvqfSdJi9Glezu2MN1
         c8XN9DQS/fAwA97txK9iV2xbun/3IxMY/FZF3ynfS//GIm+hLGCKKTpb3Nv+l4Uuu9o3
         9Kt/5lG3goQ7Lcg+cNo4iEAWyl5+NOaTpEIfPz9swRoWyatvb/O/oWI6VvPUCoereBx7
         D1JiINjqKiU/KSyaCDNFwxiR2/xh8d1tMGog4FtOCmHaFeXubUFRtTIwT9nDX0wDrPrG
         wIK6Ww2JUOeF2NAhDJr0ArC5ZGAp1IzVFLLsOAa04PJkZHjLbw5MW7KOhS3vSFCS3gQb
         rvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=usImsrBlLnGBu2b+AV5pWhlxCp/0p4ZfOPeDtFXMx+g=;
        b=hRT3yn8DpbpCqomXCG4g/ii/r7s93So0lVRYsieFz9VrVRC9Q5R4NeAWkpzO7mUHQg
         Qk6Hjqj2nuLMQydSN8tx2LdLQWVTyyKXyI+qfgQ0ixe5H0VoTGgLcRzm3zjOqYhqsXHh
         4+rb+IuGnTOPHe3tHktFwvlLgHO3DdAmqhLmoADyozlm3KF1K48qIA5vglTO1lJo3Dup
         +BAAGKe8IpgFkEWkzVmkW3ZwZEPbnVv5j2CHpLGxIa5bl0WQX6InSmaG6ns32YYREpq7
         cZYY0HL3grkYJ9q16Rw/9+CcOJl41f/gBTuiOE94ZzmZ3m+H7Hz0iJvrV93X3eGQATHA
         nK/A==
X-Gm-Message-State: ABUngveiGDQIrPPgpuMZn8BN+Iw3JOLKvb/tCxPc/B0s2iTUILhgO++kl9F6o1g21oEnroEhFtRXB7fV5MTmVORk
X-Received: by 10.55.56.11 with SMTP id f11mr7304874qka.255.1477605551641;
 Thu, 27 Oct 2016 14:59:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 27 Oct 2016 14:59:11 -0700 (PDT)
In-Reply-To: <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
References: <20161026215732.16411-1-sbeller@google.com> <93be5d21-6cb6-ee2b-9f4f-c2fe7c690d6c@kdbg.org>
 <xmqqlgxa8h3a.fsf@gitster.mtv.corp.google.com> <67e38b43-0264-12f2-cca8-4b718ed7dc9d@kdbg.org>
 <xmqqh97y8g74.fsf@gitster.mtv.corp.google.com> <xmqqd1im8foi.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbP3pgPHgv-x1Q-Q1QwmXc=gOyxWhXh2SngO8WSZc3PFA@mail.gmail.com>
 <34c88c40-2088-fd74-5d26-56c0599b7eb9@kdbg.org> <xmqqr3716301.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kY_fZ_pDtVnwJoDkR6PjTNoqDMN5OC70Z8SH_J0Wvkq-w@mail.gmail.com>
 <a2e5acd6-485d-0387-7a85-6042dee702f7@kdbg.org> <CA+P7+xpckfaeHmoEGQBdLD-=Kf7gQ-jOxGFKrKmiFH1SBN7GjA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 27 Oct 2016 14:59:11 -0700
Message-ID: <CAGZ79kbpzAcaRWyJQe_XS6QCve_U9=mOUx9C=si=o_3wzmPcRQ@mail.gmail.com>
Subject: Re: [PATCH] compat: Allow static initializer for pthreads on Windows
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Simon Ruderich <simon@ruderich.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> there isn't really a great place to put a dynamic initialization.

Answering this question specifically (Where to put it?),
I am about to send out a patch that puts it in compat/mingw.c:2232:

diff --git a/compat/mingw.c b/compat/mingw.c
index 3fbfda5..9881c3d 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2232,6 +2232,9 @@ void mingw_startup(void)
         /* initialize critical section for waitpid pinfo_t list */
         InitializeCriticalSection(&pinfo_cs);

+        /* initialize critical sections in the attr code */
+        start_attr();
+
         /* set up default file mode and file modes for stdin/out/err */
         _fmode = _O_BINARY;
         _setmode(_fileno(stdin), _O_BINARY);

If I understood Johannes correctly this is the place to put it.
Junio seems to be ok with static mutex init for non windows platforms,
so I put it into the mingw specifc startup code.

Thanks,
Stefan
