Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B5B20248
	for <e@80x24.org>; Mon,  4 Mar 2019 07:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCDHyO (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 02:54:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54237 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfCDHyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 02:54:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so3562701wmg.3
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 23:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dHqW3EClOqLjn5JKh5pRfotuR3V+q1+BTjGI2KhlG28=;
        b=ITJJlL8U5xCtHeH70ma5KKmPrqz+cZBev26WJd6eKTqmkNvY4eKl8gPLCOILsPZAIL
         R5DNhWpsKJCIr6Mxm4r/1jeFFU7BTD0gG+Rux8QE5+ex40l0G4UX4RwWEqvdlGaH8OZ9
         ocC1cqZJxLAMhKfGjyxDDpRbCCBkg0kYudMnUmJOdw9yWveuu8BcTkvBWK/Q9ACP9bnx
         vfSgntXMWoE7Oivmq/zTVlNUGS0di8Rkp1JZMlBzQgNo/jHK3SRrOSou9jTO1cwJfkTL
         glqTM2fnOXC1/q0uFDcWK8hkyvC2+oa7nSfFpBSk8UkDWSC64gpyYgIJfUrNPWQji7BV
         KsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dHqW3EClOqLjn5JKh5pRfotuR3V+q1+BTjGI2KhlG28=;
        b=qBe6bTrxTWqrbi/Xg1xk9cgywoKYkn9bicMCtOC2T8pTituPJfyrT3ACxA8uGUfkta
         HgOGkGdPSKnHf9K/dZl1plDfC1TGEMjbjmeqc+zkFJJPSVR0+BpfDOq/RdEPlxR5fE7D
         I8J8iuNu4YrDk1TY/fkXkqr+1G7rOUnVA4/tbKYSFj2U5NOMIi2pArlEYV2FPQHBbvaT
         ppcWAfgyBhTv9lvU8Mj3wzolGIADu2Q6vEtm5/KXlpM07rFZsAtHH4wCqxISJ2hDxbnq
         qB3ceJLtcskBlgXuhwZxytAc9A9VgEDkTJEZTrV+mxxGjmg7c6BvzvB39d1gnE9S10ev
         JThg==
X-Gm-Message-State: APjAAAVrRQ+mj7ItJqt9VVzGq5AdYoZe4VddbqL4KytW5yF9BShSU2GC
        5p2C4p+oy6Q93lu6Oc+e6r3OpJX8ITU=
X-Google-Smtp-Source: AHgI3IZ/S+eIjxOTembavwY5mMobwRyWG3FFKwLaDhqTPnaSBr/cDWUO49bV7bRy1VDA4VerTImSDA==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr10633907wmg.39.1551686052344;
        Sun, 03 Mar 2019 23:54:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v9sm4054434wru.83.2019.03.03.23.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 23:54:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git@vger.kernel.org
Subject: Re: Git log print commits between a revision range (inclusive)
References: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn>
Date:   Mon, 04 Mar 2019 16:54:11 +0900
In-Reply-To: <62307e7b.399f4.169479a611e.Coremail.wuzhouhui14@mails.ucas.ac.cn>
        (wuzhouhui's message of "Mon, 4 Mar 2019 15:28:13 +0800 (GMT+08:00)")
Message-ID: <xmqq8sxvvzvg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> writes:

> I want to know how to display logs between a revision range (both
> start and end are inclusive). I searched it and only found[1],
> which doesn't resolve my problem completely, because
>
>   git log <older hash>..<newer hash>
>
> doesn't contains the log of <older hash>.

 $ git log maint --not v2.20.0^@

gives you commits that are reachable from (i.e. ancestors of) maint,
excluding those that are reachable from the set of commits denoted
by v2.20.0^@.

v2.20.0^@ is how you spell the set of commits that are parents of
the commit v2.20.0.

If your "range" is simple and "old" is a single-parent commit,

 $ git log <old>~1..<new>

is equivalent, because <old>~1 (i.e. the first parent of commit
<old>) would be the same as <old>^@ for a single-parent commit, and
because the short-hand "git log A..B" is the same as the long-hand
"git log B --not A".







