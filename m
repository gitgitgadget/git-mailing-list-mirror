Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04B251F424
	for <e@80x24.org>; Tue, 24 Apr 2018 02:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932800AbeDXCl6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 22:41:58 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33417 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932779AbeDXClp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 22:41:45 -0400
Received: by mail-wr0-f169.google.com with SMTP id z73-v6so46360957wrb.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 19:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y08A9mcq/HFwDTKqAz8soAKony2qqE+XE1odFbZE5r0=;
        b=rq6kAXwdeUgMjJ4jvEcRATaxteECupcOiyG+qX60Haxc7to4G4LOwH4pSFz0dsIaIy
         X7vJTiojtnDrlGj9aAE7BhQ6stCkoIasmd0eERfybuEj/ALJLk8OTe3LiqDGY1azu11Z
         4wIWX4s0wfRXFwEE01E9q0wBS30mNJW624yHf5iHjgz4FXD+1X3rP7J9hU4hgWBfUGrj
         yp4ls4rqU7dQH9MlzXAnZ9J3hGnIx1yMKr9Qnr59aYo1S5O/D5akpZeX+I3dNVj0kzSy
         rr4EewTtC0vBtZvVlWMZ71m8/F9c4FNVOOTfCozpGa3HdtaH5aVfrhvmAQ3BVpzht997
         QnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y08A9mcq/HFwDTKqAz8soAKony2qqE+XE1odFbZE5r0=;
        b=JRgN/qPoQu0x8vtvkpmumU2YZqqJXZ+9C1yy/5e7HzaIRELloJJcsPC/ZE5d95It1R
         qdylrOabPOd/8vC6kAvmp8ndwGko4AOE9UFbuT6Hb1DNyT50w4SoGfNrq7mk3L0TYNqr
         qTcDRB3q+CHtz27FUgjGDDO2bCsIQaJ2q9yZfPxaWeTHOaFPqgSc1W2XYKXRHa4K2zZN
         pCunagTBxO7afohaY1ZGgBlUJTHF/OKKsachVVr2M6vXGbSGGX2VSfcivUjhJNtlIZQz
         vcr/WnBdyKH5TIFZxw2qg/67FPekQlPBez38bNNlG9w0w8THBtGnNQtaNUr5clAc7Mrf
         zdoA==
X-Gm-Message-State: ALQs6tBjqggc0y3el+IXrzluDCbMPY1QqW9WPuaiJjlSG4QNNICf7JCp
        6csPQlyVfAr8cLJYP45X5T8=
X-Google-Smtp-Source: AIpwx48VOoici5eHncBkJADxn+towk5/6Am5ROftOtudYY6zl4D4V8jS4ezqCe5pKmk5VEshihfzVw==
X-Received: by 2002:adf:87ab:: with SMTP id b40-v6mr19389274wrb.156.1524537703711;
        Mon, 23 Apr 2018 19:41:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u37-v6sm15046431wrb.53.2018.04.23.19.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 19:41:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Dan Jacques <dnj@google.com>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Some add-on patches on top of dj/runtime-prefix
References: <cover.1524211375.git.johannes.schindelin@gmx.de>
        <cover.1524309209.git.johannes.schindelin@gmx.de>
        <xmqqzi1t74zo.fsf@gitster-ct.c.googlers.com>
        <xmqqvach74qe.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 24 Apr 2018 11:41:42 +0900
In-Reply-To: <xmqqvach74qe.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 24 Apr 2018 10:50:01 +0900")
Message-ID: <xmqqa7tt72c9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> base-commit: b46fe60e1d7235603a29499822493bd3791195da
>>
>> Basing your work on the tip of 'next' is good for discussion, but
>> not readily usable for final application.  Let me see if I can
>> untangle the dependents to come up with a reasonable base.
>
> I'll queue this on top of a merge of 'dj/runtime-prefix' into 'master'.
> Merging the resulting topic into 'next' and applying these patches
> directly on top of 'next' result in identical trees, of course ;-)

Actually, these trivially rebase on top of dj/runtime-prefix, so
I'll queue them like so without taking it hostage to other things in
'master'.  We'd want to keep these mergeable to any integration
branch that dj/runtime-prefix would be merged to, so that is the
most logical organization, I would think, even though I do not
immediately see the reason why we would want to merge
dj/runtime-prefix to 'maint' and lower right now.

Thanks.
