Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095BA207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 01:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbdFXBB6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 21:01:58 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36258 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754075AbdFXBB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 21:01:57 -0400
Received: by mail-pg0-f51.google.com with SMTP id u62so27292449pgb.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NRF1donuyFbpUs7tTVleeGHZPK+MBdiJ4M+pBOWZH5E=;
        b=jmsXO5dqN5fNdSMDXwmV/4LElYX6Si7DqHzHLL46UXAdvtILvLOutcrKHVcOYLIDLy
         7w6x4GHdz48/EyLLUa4RYdTlLn6TTPqEdOeK7XsotEAj1T7hDHhQrmeGJqGV/Fu+kCWM
         qaiUI/mLHpxfypYWQEAUhdId5o+t+0d6m71jF+my2VIxsaF9V8C2NNl50jzaXvE1L1px
         1L/V3pHP2l7xQexE/g0yqi0OypgAnSHsAr0pTOrcGfloptzBk4tQbfWVdAn++/dOU8KH
         i79uK+VB0sZwauLeWY/Fz8D9ZtOqHJeichfsZPAJOp3UsuihJVAZEJYrbKvQvVs/Cz1i
         ICQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NRF1donuyFbpUs7tTVleeGHZPK+MBdiJ4M+pBOWZH5E=;
        b=Tcb3JNL4R3ITKQAI7Gar1wysSNXUETX0ElpplITvQMeaX2feOa+qUShYgfnWo4Y3CQ
         zxOnatoyNCfoRhkLWhj3UpFP0L+hL2TvKQxrbhYT1DMnyuNIsvPdqmV9wRAbWtDsoCI5
         wlmq2JKzzo2+sbe7RKfACXDXzGvamTKyZWGhipC5GKVdzrJiTH4jVEPbdXq+WNAE0CoW
         YFEHBT9l0aIrDpyhkdXO7C2Dg8Npb7kDWRpr/WA1whwYL4WrGUaL+71LAS2pjLF4z6C3
         IF2GXKTW/0Hp+PEmeoPLorHiSMrCvPHkgFOnqKFsm8S5Su6kuGoVbMW2foBi2yMxep8u
         9J9Q==
X-Gm-Message-State: AKS2vOw7BlR+QSLBKrvCujkcRZB50eaKtyoaC9+9KDuEUjG0GHKYOev1
        9bfnajlqsnbBk8TNt7s=
X-Received: by 10.98.101.6 with SMTP id z6mr11007390pfb.221.1498266116958;
        Fri, 23 Jun 2017 18:01:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id 67sm12005835pfa.83.2017.06.23.18.01.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 18:01:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
        <871sqajrgi.fsf@gmail.com>
        <CAGZ79kZyMUKPahTXOF7ds6zSvFKLrM2N78JKG-2+GRL5nnmuvA@mail.gmail.com>
        <xmqq60fmb4q8.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 23 Jun 2017 18:01:55 -0700
In-Reply-To: <xmqq60fmb4q8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 23 Jun 2017 17:37:35 -0700")
Message-ID: <xmqqwp829p18.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But for the purpose of this "moved line coloring",
> excluding multiple copy destinations of the same thing may be a
> simpler and more robust solution.  It will not catch "somebody
> stupidly removed one function and made two private copies", though.

Let me take this one back.  Treating multiple copy destinations and
multiple copy sources differently is a bad idea.  It is easy for a
user to give "-R" option to "diff" to turn such a stupid patch into
"somebody brilliantly consolidated two copies of the same thing into
a single function", and we want to keep "diff" and "diff -R" output
symmetric.

