Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1055A1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 02:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeCECgl (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 21:36:41 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45843 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932417AbeCECgk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 21:36:40 -0500
Received: by mail-wr0-f173.google.com with SMTP id p104so15649597wrc.12
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 18:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9sWy3nxQC7ct/K2QerlI/aac7QWb/hdusj709+Sh+aM=;
        b=vC1HAeOb0/n577zup3LDBta4ctWisxVmDqnFBUHb6/r1Ml6Eo1qajIHwmILvQFzQW4
         mzsXGoaCYlqpXHrLCRdHHzizCfqL/h4THFgFFE0oAAaWpy+b1t6X3kGs6FSNfAWal8uC
         mEMUUaDGizuRKrKga2wFtDOtn5zGPYES/tR2Llqpf0euVQxulQ30zTR5QqcfIAhtXJzt
         /pRYdIOqAHGEO7LfCOYP0OyUdJ2WvXxVYwamv5898oU6eEEbWN8l2IEfamDcdjXQZnUs
         BBul95JO3j31zMOL+4epSiz9Oc0wskCjqkALy/6FD9VIhf3wSO6Tq+DZ/VYUXY2ecYpX
         GuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9sWy3nxQC7ct/K2QerlI/aac7QWb/hdusj709+Sh+aM=;
        b=S5yEweYsWU03fLTWcN9Ueln1I2zliU/3MCqWOVfHN0pZxZLSs95VasCz+IRp2cebXz
         nbxev+aktNygnrvH6xPBb1TBL2qSFFEyM85Fti6dQjxr2kp6d7QPZILzUuRQek4uZItX
         EjFnxHLih/EnyD68O9oi8l82I7lAtGw2lnumZtS62pcjFVWq5jZvkwzMcTUpbGloEpd6
         ZZOOwrnO3WKEeswmLWxna7sE9B9HBZtFawHTiSneB4zdk2tPVrTVM91bv33t6pJFftEF
         oSyPvSU9uLwUdTrfMTrSt9oEJYVzD9uw3DI6afp69A8qLnXGp61jEjVsywEapSHDeL6O
         wM+w==
X-Gm-Message-State: APf1xPDJN/b8fv1DsBUUxQtGZ7giN6Rqs4a99H4Pc5NrnyUtnfwg2wTh
        nC/UwkPUPietIIwO/HrG55k=
X-Google-Smtp-Source: AG47ELuglfj+3KBF4ZD4+/6nSZrBXXmB317vC0/oGhvh8C0OeoRYA+tvSeoQNHMSRiVU8JoFxqMO0g==
X-Received: by 10.223.134.205 with SMTP id 13mr12392184wry.283.1520217398675;
        Sun, 04 Mar 2018 18:36:38 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m187sm9469370wmg.0.2018.03.04.18.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Mar 2018 18:36:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dorab Patel <dorabpatel@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: handle default excludesfile properly
References: <20180303034803.21589-1-dorabpatel@gmail.com>
        <CAPig+cR=adC_Ok=FJw2APaLahXX_v1ix4ufEJyBhED5ruXaQxA@mail.gmail.com>
        <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
Date:   Sun, 04 Mar 2018 18:36:37 -0800
In-Reply-To: <CAE09B1+XXJvrOucHwehUGk=Taio7sirfOh5gq7KGs4iZSpK=vQ@mail.gmail.com>
        (Dorab Patel's message of "Sat, 3 Mar 2018 17:36:51 -0800")
Message-ID: <xmqqr2oz9rka.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dorab Patel <dorabpatel@gmail.com> writes:

> Looking deeper into how the function git-get-exclude-files is used, I
> see that it is only being called from git-run-ls-files-with-excludes.
> So, perhaps, a better (or additional) fix might be to add the
> parameter "--exclude-standard" in the call to git-run-ls-files from
> within git-run-ls-files-with-excludes. And remove the need for
> get-get-exclude-files altogether.

It is absolutely the right thing to depend on --exclude-standard, I
would think, so that we do not have to worry about details like XDG
paths and such.  Thanks for working that out between both of you.

Having said that, I am sorry to say that I am not sure if the copy
we have is the one to be patched, so I would appreciate if Alexandre
(cc'ed) can clarify the situation.  The last change done to our copy
of the script is from 2012, and I do not know if Alexandre is still
taking care of it here but the script is so perfect that there was
no need to update it for the past 5 years and we haven't seen an
update, or the caninical copy is now being maintained elsewhere and
we only have a stale copy, or what.

Thanks.
