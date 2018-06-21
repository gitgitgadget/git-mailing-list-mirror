Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4461F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933146AbeFUUqI (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:46:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37849 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933018AbeFUUqI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:46:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so4516231wrp.4
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=yeuv0Imvnof6yMTpeiMUhTSLC83+x/lnwCSHt151DK4=;
        b=m1zqFS8fFdEjoFG9H/TVEOLfNSB31pHzD8GC3fqwbNGjrIdc7B/OkGSDzoyUeAQ2M/
         KRijKGuqz+G8sqXZ4q9BG/xTV2KybasVWPk5HiGFLcJDpktP0lQJ8wzK45KxC8CYyb6t
         onXL+hhxOcYqP2fTzFKu4sz7R/3PRl9naKie90SmZjKoebtJ4hbE3mHOtfoD9NmAMUSH
         tlysap5yozXgZjz3+fGIczAwBufcyXTwFmo82MfuP7WyJiTfoxU3/zwmGyw9doKAO7b1
         dwTSAGtQPOaPRfwGcvt1HyILEcHFa5LFnKBe6dDfPRgAy98v7ijPLplMVFSbGgCFzmNR
         u1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=yeuv0Imvnof6yMTpeiMUhTSLC83+x/lnwCSHt151DK4=;
        b=V4kSdnuIvKcGaTXxlmcdOI3mbzJWc7ALUHnxPYV7GATpNH0+CcPp3nTIltJQi6FvxR
         eLLY4l9bXqyl0LtyaUnXIRPiWw0dFA84YDhpi9WKYP0PWqI9pzFBACHe1llF4o82aKys
         ASi0hdQiPkDqnr4sK5BvOY49Cl0nEZfmhEzFXpBCT2s8u116wqoEnjkXfR/D+Plco2tK
         M7b2hIGk9ClHMBM3nX9TatV1SaiRflXl7h4X5LOEyN3sr23KKZ75JRIvXfMv3lV+vo0y
         Um5x0EouZCI1uFsb/ee+Kqs+QQcqRDUTMX4QOreZc8OI6aZnZlBTRJ+CfMMftlH23h8A
         DyUg==
X-Gm-Message-State: APt69E06oFB2SuxkF7BgYDgLGsYaXz53gdKRC7DejP3NxJsGI5uCqJYH
        Dn9M21VPY1B/hpTm2PSKBNLiNOhE
X-Google-Smtp-Source: ADUXVKJLl/M/KghWyQ3Zw6yXvZiPP+g5MJ6rF4Rgn79OOMFWdwdqf+Jkm7ZbHeF9nqqDL5LdMP5DbQ==
X-Received: by 2002:adf:fc05:: with SMTP id i5-v6mr22818523wrr.157.1529613966640;
        Thu, 21 Jun 2018 13:46:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q1-v6sm2971815wrm.96.2018.06.21.13.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:46:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 6/7] git-rebase.txt: address confusion between --no-ff vs --force-rebase
References: <20180617055856.22838-1-newren@gmail.com>
        <20180621150023.23533-1-newren@gmail.com>
        <20180621150023.23533-7-newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:46:05 -0700
In-Reply-To: <20180621150023.23533-7-newren@gmail.com> (Elijah Newren's
        message of "Thu, 21 Jun 2018 08:00:22 -0700")
Message-ID: <xmqqbmc3swaa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> rebase was taught the --force-rebase option in commit b2f82e05de ("Teach
> rebase to rebase even if upstream is up to date", 2009-02-13).  This flag
> worked for the am and merge backends, but wasn't a valid option for the
> interactive backend.
> ...
>  INCOMPATIBLE OPTIONS
>  --------------------
>  
> @@ -559,11 +549,6 @@ Other incompatible flag pairs:
>  BEHAVIORAL INCONSISTENCIES
>  --------------------------
>  
> -  * --no-ff vs. --force-rebase
> -
> -    These options are actually identical, though their description
> -    leads people to believe they might not be.

Ah, I should have held off my review of 5/7 before reading this one.
Perhaps we want to do this before the step 5/7 to reduce the churn?



