Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78F971F597
	for <e@80x24.org>; Thu, 26 Jul 2018 04:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbeGZFaH (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 01:30:07 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:52918 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeGZFaH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 01:30:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id o11-v6so529684wmh.2
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 21:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=h2Eg/+0tJ2FUHIFq/RK+n2KExQ4ECad2qZU4Z5jgR2Q=;
        b=gIV2rGBNijRcvXVQDAdFiB4+rRXt5wndLFo2jRlOJBGX3YtRLtZKpFhqIprw102Gr6
         L6AMq6cEJ4AMLj3QdzKNZo3OYdlYCsiSwOwSY4cAgnEYfr+1XExxF8NIan4JNNGnfkcI
         k0z8NN1/sYN2fylYrNnrUZs0H2GdAAIhydK/34kRIO/qGWRb99RgP9vcTdkFcG9RM8uh
         pbueMdJgD7mzS8k3vTKenCOn2eda+fd3z7fVWk2/IQO1BOTfaTo1Q0YlgkTc4IMhbazY
         EtVB+Z/rkiduPv0XyAtmkweR9FP5XvTuESFa/pzb81TKrUnJjBDVBWxn5fQbw02EXraU
         exeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=h2Eg/+0tJ2FUHIFq/RK+n2KExQ4ECad2qZU4Z5jgR2Q=;
        b=i2XNEvRvET3pbXn2FgFzc+vC/67thqNwjtoLGLxOL9iqW0SyPRaL92+j0TJSun9xXo
         /iZrVlCnS2onY1nm00fKukeqSSFB5xGgqf5NPLLluvq6t8KixX6QQaqnBUJz1fx/Xx5c
         /l/N2pRtr3sTFAh5MwhXUE/aXfi65ssclfUQAMxWulUVnmviU3k70OhSDL5KfClgj7Ik
         clu2v/C4S/N+hjHIbpvtulPyhii1AalhaIWO1avZYq0ezTDvrVfASdAVCGCqmMdkC6wG
         7rmnAcfCFjZUYR1u384x889xN9XAzx+6Ljna83Xw5TVDJnHnhUNX99KyqOoH4uG+dswZ
         emlw==
X-Gm-Message-State: AOUpUlF2npmk87QdaCKKNnw6yJoG+y2Box0lMiRHo1BlhpBr5aqHcPcG
        GvlqGhyMJuSm5xCGNgzbk5w=
X-Google-Smtp-Source: AAOMgpcLtu8nxAVw1T6Qszwp21vird9Bq5eRwymOmMKSiQ1ORJcb0+ER0W22r+2EqqcigsD/bHa2cg==
X-Received: by 2002:a1c:57c1:: with SMTP id l184-v6mr416952wmb.16.1532578514302;
        Wed, 25 Jul 2018 21:15:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s9-v6sm411349wmc.34.2018.07.25.21.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 21:15:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
        <xmqqva92swpz.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 25 Jul 2018 21:15:13 -0700
In-Reply-To: <xmqqva92swpz.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 25 Jul 2018 16:48:40 -0700")
Message-ID: <xmqqmuueskdq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>> * ag/rebase-i-in-c (2018-07-10) 13 commits
>> [...]
>>>
>>>  Piecemeal rewrite of the remaining "rebase -i" machinery in C.
>>>
>>>  A reroll (which is rumored to be quite good) exists, but hasn't
>>>  been picked up yet.
>>
>> Forgot to state so on either the mailing list (or Github or IRC),
>> but I read the tip of the reroll and I think it is good.
>
> No, you did not forget (otherwise I wouldn't have said anything
> about the rumor).  Skimming "git diff master..." is not a review
> X-<.

I was reading the early part of the series and all updates from the
previous round looked OK.  I haven't had enough time to spend on the
new stuff at the end.
