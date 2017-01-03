Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5554A1FEB3
	for <e@80x24.org>; Tue,  3 Jan 2017 17:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbdACRwi (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 12:52:38 -0500
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33096 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753143AbdACRwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 12:52:36 -0500
Received: by mail-qk0-f170.google.com with SMTP id t184so382874803qkd.0
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 09:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mSI6jT7QcGmULdsmEz7vACvnoTTY5a5bPBQamlHp2os=;
        b=iTQe8x9Id1rGz8bEywMv2FJ4vY+GWdJEeUtZTUMISC0RqxhvVtRqm5pi7oHfOqiHW4
         +Mb8uFurkJguaB/1Je9mDlpgQna0YKBRKDGwSrlyVJc4mgJNMc/fKlYf5lcDyIzCXwW1
         Nwd3NEYVbSI24aAoPgLmq9TYJIS64roBo/M27rQu6jAwC2RR0ay7x3Q2vHpTEPU6hYpF
         OMOLuyP58hf73SpJcrygQt8xmw4mL9Ni5Ow+VM7QNt4TGx8a2blOmuP80ix4NLoSyz9d
         ePhTTIK2I9kJdaBFdIns/SAxmt9dpQPJwXSvZ7P17gnnAEJAIzERqs4OvIF/iWD1E1vh
         KHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mSI6jT7QcGmULdsmEz7vACvnoTTY5a5bPBQamlHp2os=;
        b=U8qJjdqcNaDLigPDXdL9+d/lPDmVriAOVbgR4+Bd7doIC2kUHloZ6llNJzUdnKkAbq
         FAvcY7zje3iqTeuybKv4FwgpmcXG1eZape9458SRf2qxPj25i5SjjVl/DyUNAgC10xlP
         tCNDPM3yCVg6EDJWXsLO6FOf+sNwlKACL7QXORmjBD133e2FDY7FG9zN9uM+9GIqoBLc
         eoYFrijrFZIOmJjqBmpSgtSQQc1nG34+TlkJfy22ccLYV6+EalyyF9ZrnSQHapA7lY/B
         Pez9HrSEjy0s3z99jox9hgFOBWb11L1TQV5cvEHa1uyEexIforhzBigccMF7Hgq2kqQ6
         5Dcw==
X-Gm-Message-State: AIkVDXIwWAm36HZkSUEqEBFRHLuaI/axLN8fFr1fWn7dj0BLz1+UBbd44lVePOpt63UZVoTxDTD4D6WOMJJJyeMG
X-Received: by 10.55.170.140 with SMTP id t134mr61144247qke.53.1483465955669;
 Tue, 03 Jan 2017 09:52:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 3 Jan 2017 09:52:35 -0800 (PST)
In-Reply-To: <20161231114412.23439-1-pranit.bauva@gmail.com>
References: <20161231114412.23439-1-pranit.bauva@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Jan 2017 09:52:35 -0800
Message-ID: <CAGZ79kYbJuujDpT-3Dj6AFkZUaKUrj8NJ=WgBbT1YbgwTibc=Q@mail.gmail.com>
Subject: Re: [PATCH] don't use test_must_fail with grep
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 3:44 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> test_must_fail should only be used for testing git commands. To test the
> failure of other commands use `!`.
>
> Reported-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

Thanks for writing up such a patch!
I had put it on my todo list, but you
were faster on actually going through.

Thanks,
Stefan
