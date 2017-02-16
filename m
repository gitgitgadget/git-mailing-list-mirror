Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6087F1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbdBPTkY (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:40:24 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35214 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbdBPTkX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:40:23 -0500
Received: by mail-qk0-f176.google.com with SMTP id u25so25590018qki.2
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 11:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t/d8sxU2PG3oJDIwNnoDGeYlbhA0RphC/ndPCNwExZc=;
        b=Fv+CZyDlq8tTlMmXV0zp7KzIyXsSqHOIL26FiClPUkNrHce5IjbhFRi8K+1KeNnVYt
         kd5isRSoIbZJGOdokuaKZAHsUujAHzKe3QC5Uwdu00ZWABCWHFdfUlLgpSrJo4uDhfLa
         awjKkLtHo7YZTJVgKsosELOVqivPkuaR4eFiAf149IE23Ld3CyRcqwFah1r7qB9CM0oC
         +Odyrup8fYLOp5Hr1RoK7F5RvZ6fhaK2+6xR8z+x8CKvTO8TXj5zJo8O1P11d00YW3xd
         xjvTZtoONNEa3bSmB9RMBvyq9aamIMRghfM+K0puubHKtW40BtCvEzX66KoQZWryrblp
         f4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t/d8sxU2PG3oJDIwNnoDGeYlbhA0RphC/ndPCNwExZc=;
        b=i2eUzwPN3kawSsnvyNwF+PF3V+V5/mrjBTXSC1rihqAetDH95I7gvVwrxAGQJGi1xS
         dECRLQ5tEAiH0S5OroIEPO80Bb+rdxWAwfzV3Mh7yDnN2HTGxE8CmO/0QzSyjR/Rtgfq
         KWyR8ljscUeC8ybFQcVmiEjyjQh9R/XdgtAg1UK7Zwq9LUGvUW5L5h4GYcBLLQsB3h4q
         uiUWyBf93hU1fEdRIyY2bapFmqANfPoj9zxAQeeX90UECouxDhx4o5CMnbQYrzorgnkx
         2ICJ36DxWcckzBjgn+k6shYT+fJqcDDOK/BCH9C4egQsL52RYJmWXW8R3OmKRuFMtYSs
         vh+w==
X-Gm-Message-State: AMke39mw8eKpUQknDUGtGISSTbiwi/x4F7C/iOAwaVrbXzs0IUmjFxyoPbbyNEhYUVAISkhfNkbkJE5qKxHLaQ==
X-Received: by 10.55.118.67 with SMTP id r64mr3686927qkc.285.1487274022134;
 Thu, 16 Feb 2017 11:40:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.106.138 with HTTP; Thu, 16 Feb 2017 11:39:41 -0800 (PST)
In-Reply-To: <vpqwpcqgfmw.fsf@anie.imag.fr>
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
 <1487258054-32292-2-git-send-email-kannan.siddharth12@gmail.com>
 <vpqwpcqm69k.fsf@anie.imag.fr> <xmqqwpcqxay0.fsf@gitster.mtv.corp.google.com> <vpqwpcqgfmw.fsf@anie.imag.fr>
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
Date:   Fri, 17 Feb 2017 01:09:41 +0530
Message-ID: <CAN-3QhrO2FDDNfXLZJm-3DO5fw6m0Ea0QjW4Cu+Ceo9aJJBPWg@mail.gmail.com>
Subject: Re: [PATCH 1/4 v4] revision.c: do not update argv with unknown option
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Jeff King <peff@peff.net>, pclouds@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.ath.cx>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Matthieu,

On 16 February 2017 at 23:52, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Indeed, I misread the patch. The explanation could be a little bit more
> "tired-reviewer-proof" by not using a past tone, perhaps
>
> 1. setup_revision, which is changed to ...

Oh, okay! Sorry about the confusion!

Yes, I used the past perfect tense to refer to changes that were made
in this particular patch!

I will change the message in the next version to something that's in
present tense.

>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



-- 

Best Regards,

- Siddharth.
