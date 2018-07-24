Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18BD1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 13:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbeGXO2U (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 10:28:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35071 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeGXO2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 10:28:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id o18-v6so2555487wmc.0
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qsTjWYbqYyjoCkd6R4niBUfg9PovXoc0W88AbwK+PHY=;
        b=CRbb/QR7echMuj0wwmCOYfissAxHSjqYkOJ+9RIdjgmh5MaFaNHS3HETCGaOiCbpV0
         2feL29CIe4fx/9+nl99lBovcAC4dA4Y/W7pXRhx/9+/Fpf2XiRzgzHFs30g3rHbsCljB
         L9nP+fOP2yyC2To5j2Y9dMm4QjlTRlyK8/+rggabsxgrDzyZwKHU0W8QvLkQTqS+TswD
         Fv2CHcwRKv6PR5KF11AVRMScAHpwWi+2czmyQ8t1qQ/iH01UYtwoicFICz3+RIHJrQWr
         e6X5Ch5LzOHUWTjdbEdlZfmFCyvahbDAOZpti6SEQQxMrasamFKh04h8un86JCteolol
         fzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qsTjWYbqYyjoCkd6R4niBUfg9PovXoc0W88AbwK+PHY=;
        b=fdL/qjgphjpItf/Rn5c02ZxVxKYQSZqnaJsO7gBr6xZizjm2urQJeA+WdvSHqnZRMJ
         jGovBFgrfS/h9DOrnKnnKg0vg4JFkHlwa50ZEZyai4AMDhe5SYg1VbqxRBs8rUgEa/lb
         B0q6g1h/wd+72V+CCBDuXRP9lqU+hnHSwFwtpjoFG+hwlq6zBnoRfYWyA8Itikh8RKlQ
         Q8AZgw7e0S7H1tx2DTaWwFjDxkAGyJDXJrhtg8tRdN+m5pbJXrodzpKxFCNY8clR4pif
         yRcXnEF4YVQpnO1BcilxWPguJrxIll5gYcxGLVJe+f8Hyx6pmcTBP4yQFugDlIc93msC
         Lqbw==
X-Gm-Message-State: AOUpUlF5dRybpSSqgtuDHU70r3jJzP3XAKxSNhD8a1i/byPxiXN46mQF
        GTYFuhlpjHiGdm4QXc1pTzc=
X-Google-Smtp-Source: AAOMgpdUlVgKXaFkSyO+vRsZ80+DuCUL/uqTy5zMfFn8IHoqYpW2E/DrhzU3YUMHHWQPsdEU/HWo+g==
X-Received: by 2002:a1c:63d4:: with SMTP id x203-v6mr1909688wmb.9.1532438511084;
        Tue, 24 Jul 2018 06:21:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e12-v6sm10127815wrt.29.2018.07.24.06.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 06:21:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] Makefile: add a DEVOPTS flag to get pedantic compilation
References: <20180721203647.2619-1-dev+git@drbeat.li>
        <xmqqva956ax8.fsf@gitster-ct.c.googlers.com>
        <7666172f-3113-109c-29cf-f1598195b100@drbeat.li>
Date:   Tue, 24 Jul 2018 06:21:49 -0700
In-Reply-To: <7666172f-3113-109c-29cf-f1598195b100@drbeat.li> (Beat Bolli's
        message of "Tue, 24 Jul 2018 08:04:23 +0200")
Message-ID: <xmqqa7qg22he.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> On 23.07.18 20:53, Junio C Hamano wrote:
>> 
>>> This is the convenience knob for all developers that led to the series
>>> bb/pedantic[1]. It does not depend on this series, though.
>> 
>> Yup, but "make DEVELOPER=Yes" build won't pass unless this patch is
>> queued after those clean-up ;-)
>
> Then there's a bug in this patch. It should only have an effect if we
> "make DEVELOPER=Yes DEVOPTS=pedantic". Did you try this?

Sorry, "exercising the feature" is what I meant to say with that
"make" invocation, so I should have also spelled DEVOPTS bit, too.
