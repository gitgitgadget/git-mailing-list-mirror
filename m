Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 984D21F404
	for <e@80x24.org>; Wed, 20 Dec 2017 17:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755715AbdLTRyr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 12:54:47 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:41699 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755498AbdLTRyq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 12:54:46 -0500
Received: by mail-qt0-f175.google.com with SMTP id i40so29315105qti.8
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 09:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lh+8BLL9sL5APVBtznN1qPIGAnR8ysOBruwhwxpHKgg=;
        b=A2uqri/Mm9nl0eUONqfp9PbWa9L4FJNq+1WwLJFV7GD4P/XzFQvUz0id36N5wk0geJ
         TFQrqc6y6KZc8OTDCIrWwPNjvaIOiw4V+t7uaYR+1j7BvGJi4hZuQGvUIN/BeyX7dIDt
         1yu26poekYugz4qn2+QYMv5smRnXdavNitNmEQVnA50B/4m783TZLFuiq9NnYd4SH823
         5/9s33twtI7WALmTatjrq9sy5q1vzPq9K+qkSmW9bQLK25MHpF8oPLcDV33EX2Z2sEwu
         VWdjQkMPFQAIuM6VEpS4N3FBcD/xokEB12oYMu7bv7YeqPSP/RDYFttAlmLBnKpJEY/v
         SwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lh+8BLL9sL5APVBtznN1qPIGAnR8ysOBruwhwxpHKgg=;
        b=Qq9/riFGUTFmVVubn1kCDmZjbGFBaPjFeYY/lZS3CWlWgzLfxSNrahEvmIzMimwdwm
         ymUy//OnVagymNvXymaoGFihw7KHXYSsAwinUxhoLnp0XNHI9C3lLfEv8Exht+N01eN7
         MTP708U5F9PZTX3wCFYv/6pRFYjQSQptUrzyUEXxGzp5SqWwu/w/WTHtTEhsL2QII52m
         K0phIus6l50HhdnEueBbY5ZsevLSQbTKJsgj5kWsstZ4/IqogAP28UehsGsmN0Pfxq4J
         52spIE8gJfGgC3Sa8Z+K4EnUqx9LqrzZO8F9Xe4XLmJGIuYmIDn++vdwoj+9NPt7eY9Y
         VzoQ==
X-Gm-Message-State: AKGB3mIeVupDWXv+ZPMsnPWE3nttTCOT2LrbE/HkM0PK9Q9y39m/vjrP
        z61T7yEj+EkGnzPijo99fga3HvQdJS5YDO5zK75/GmSf
X-Google-Smtp-Source: ACJfBotrb2JIoME1G513+HOeQA/gtGQ9+3ntuDXfqueD+6WaaUg2Bm6834N/pwbIqfo4MS7XdC7HHMpayyQiaarhLQ0=
X-Received: by 10.200.36.22 with SMTP id c22mr11258846qtc.207.1513792485439;
 Wed, 20 Dec 2017 09:54:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 20 Dec 2017 09:54:44 -0800 (PST)
In-Reply-To: <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
References: <CAFBGMVPBwxeSXCTcoBdxDbYtJo-38w=tf4T6-rNWuys=3drP+A@mail.gmail.com>
 <20171219180230.254881-1-sbeller@google.com> <xmqqk1xitl6l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbqntXuYuLGF7zjXfQ5X998QdEba20yy8A0cqS=DaRxFA@mail.gmail.com> <CAFBGMVO+P99hJ_nKgCJ4OqhMEdRdc3m8KHNS1pPrrhU_0wS6=A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Dec 2017 09:54:44 -0800
Message-ID: <CAGZ79kZf8GL1DY6Vmc-byEOOy+hrKF8X8qRPM6jNO-La+rD4uw@mail.gmail.com>
Subject: Re: [PATCH] Re: Bug with "git submodule update" + subrepo with
 differing path/name?
To:     Andreas Urke <arurke@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 12:22 AM, Andreas Urke <arurke@gmail.com> wrote:
> Thanks for looking into this.
>
> I was able to reproduce it from scratch, but I followed my earlier
> workflow where I first created the subrepos, and then later renamed
> it. At the time I was not able to find any command to rename without
> changing the path (and I was not able find one now either, is there
> any?), so I edited name and path in .gitmodules and ran git submodule
> sync. Am I asking for trouble doing it that way?

"rename without changing the path" sounds like a red flag to me,
as the submodule name was introduced specifically to be a constant
as the path may change, whereas the name ought to never change.




>
> Let me know if you need the exact steps I followed.

Well yes, ideally as a shell script (or even embedded into our test suite).
