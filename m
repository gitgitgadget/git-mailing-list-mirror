Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26D841F516
	for <e@80x24.org>; Fri, 29 Jun 2018 19:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936408AbeF2TlJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 15:41:09 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38360 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeF2TlI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 15:41:08 -0400
Received: by mail-wm0-f54.google.com with SMTP id 69-v6so3128861wmf.3
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Iiuetk/MzAeOca0qGIWC7ShSlv/uGs2UvW5Ekmqg3lM=;
        b=ARw/J6wTCBDbJBMvx8ygCqqKvWzOHhHJ4K2Atj6bVuyKPiEW0eUB1wZHryxJMZbPke
         t1KMCTpP/dGRHx778wEJ2HTz8w12nHJ8yJBmAPWiIalDpi9oRYMz42KfH7a86YR/F4uN
         C3X87ynNHVbvCeBLGciiXX5X+Li0+GM3p+ZCFxX6wfDKMD2TeA/C/mW3PGPsHDR8LkOt
         cj70Yl+Ri6tDOksotrPCgSm9iz94tgsEnOVeWnLgxTdArrvr7a9KsUAmMVgm9Zmo96++
         MxU1xyhCFvgOeL08WT3M3Y+ENQHY8Sl/z0ZF4F+tsLaxvEK4cHJ4Iw9MGUqPp7+aOYPd
         SD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Iiuetk/MzAeOca0qGIWC7ShSlv/uGs2UvW5Ekmqg3lM=;
        b=UxLVZvJys+ydi9dGcVy651pF8/T83w/BT1MJqhwfuMlTfMfvHNySGMUo3V8Ke9YsR0
         DU0nv3aaMcoq+XT4Hur9sfgOOJINRysVZ1UwAds1ALqMtPGbmIFziqtksAtd2RXwHp8V
         LPKl+v67YGGfgVF6GtZLTSX0hr/xdrNlAWyYAGFtnEufjZphK5brKDteFAVv5taYGZOQ
         RGKhfqGmkIPmrgbP+8igDjIFV9fzD+GV+TNaoeH6J6ef+pGL82v9G7IuWbbFOPHPCPJt
         +fCGu7EteEROd9eKq5C0PnRuy+xmMNqK/BpHzBvc4muGS7tyjt44+8g1cwej7z/DgGwP
         bmNw==
X-Gm-Message-State: APt69E0Ct+fxZLBDCLIqKeC4/JYt7qHOTiMv5uk7rVB6cNJfqUA0gxSM
        S2dnSfWR3qTKsE6I4VSoGww=
X-Google-Smtp-Source: AAOMgpe8T9OFmuiNkYX2MVjRGzJ9uZXxav1k39V7A/x9E/jgGBNxlUcAgtXDeNoTh5UXhM4OvV+uzQ==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr2754706wmt.94.1530301266840;
        Fri, 29 Jun 2018 12:41:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id d102-v6sm3488261wma.10.2018.06.29.12.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:41:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] .mailmap: map names with multiple emails to the same author identity
References: <20180629021050.187887-1-sbeller@google.com>
        <20180629021050.187887-3-sbeller@google.com>
        <xmqqh8llv690.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbG29SbsR=+7qwM+++Jk+G2AWYswQY1tYJy2KMSCKr8FQ@mail.gmail.com>
Date:   Fri, 29 Jun 2018 12:41:05 -0700
In-Reply-To: <CAGZ79kbG29SbsR=+7qwM+++Jk+G2AWYswQY1tYJy2KMSCKr8FQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 29 Jun 2018 11:38:26 -0700")
Message-ID: <xmqqpo09tm7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> It may be even better if we can arraange the author of the patch to
>> be the one who is involved, with "Helped-by: Stefan".
>
> ok, I'll think how I can help but not write the code.

I do not think there is any code required.  All it takes is a
volunteer coordinater who sends the patch with in-body From: header
pointing at the person whose name and address is getting unified,
after getting an OK for doing so from the person involved.





	
