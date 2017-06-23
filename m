Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 226DF20282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755108AbdFWUNK (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:13:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36811 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755015AbdFWUNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:13:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id q86so27990229pfl.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=O2h+IyNgv+EA9ou9EE8hIoGOBdswGwTKC2f0DZNyQrI=;
        b=pT+/BIOwzZ8Yxw9q/DXl3HdX42mmYwIj0EypGbhMxtmNNoY/SXHME6edYnsIwJuiZb
         fbv6J+I4owJdwL9kTE3BAN9ou8pL3WDYgey20XHmwVxcrj67ieMSyM0v7R3EAYkiJgzd
         VQpYdUeciBlkM8ymjYXAS9wd1mXnKaCZIUfT9x9DWh+m6oWQqlOP49CvXBTxosMlrLRT
         d9FnIB9rwhbutoZQqeLo+gNB78aDtIYNzz990TnsLkFQHamjeUzb86AKqIHdjixt1Q9h
         JoYYZYCl8r3rB/GT7j5vRJumtiUx6whZRWS5f2DY2sJ8sxlmA4svCr/0PczgeNJI8q52
         uKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O2h+IyNgv+EA9ou9EE8hIoGOBdswGwTKC2f0DZNyQrI=;
        b=qfHrD+DLt2b5lx4+RoOK5qPgaO+gIT1du+sq6Zxk6Bjw58Z6CI/eLowz7O/rWqEbwm
         Uil6XI+/xHnGf0L6XszH/00QPSI8LTPIItLzeq0ALEeWCzUHrbh254HJtKDMAul5VY8e
         dyfzw5cd7FjhPv4CtU4O3mcIlJMSph9tZPqyrutN1G7qQvkCOcw+7n6Xs15nCeCTLjJf
         lO7FYFZfsYr9ReKW+3ESL3ERT1TVVndOI2ZGxhH05zP43+h3KBkm3ArlKZMkElym65YM
         B8cCNNgdr/OLKHmt1sqcxGgJuM+YLl0aTYk/JTSdq3Tx0ePH0lQDqOwN6dOeykTdm4F/
         qUcQ==
X-Gm-Message-State: AKS2vOxqhVwwkX244BZ6zrH55Dup28nN3xrFmx3NsazN2uC6hQwR+SNZ
        4wz0Oyu5R357s62eXhIPo4q8h5PXC9uK
X-Received: by 10.99.186.81 with SMTP id l17mr9942760pgu.87.1498248783533;
 Fri, 23 Jun 2017 13:13:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Fri, 23 Jun 2017 13:13:03 -0700 (PDT)
In-Reply-To: <xmqqa84yeads.fsf@gitster.mtv.corp.google.com>
References: <20170620024816.20021-1-sbeller@google.com> <20170623012919.28693-1-sbeller@google.com>
 <20170623012919.28693-5-sbeller@google.com> <xmqqa84yeads.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Jun 2017 13:13:03 -0700
Message-ID: <CAGZ79kZhtS7HOPARLc+MGTkjRZ2+NK-SRDznEJJmVPJBDXkCkA@mail.gmail.com>
Subject: Re: [PATCHv2 04/25] diff.c: introduce emit_diff_symbol
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 23, 2017 at 1:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     diff --git a/new.txt b/new.txt
>>     index fa69b07..412428c 100644
>>     Binary files a/new.txt and b/new.txt differ
>>
>>   could be buffered as
>>      DIFF_SYMBOL_DIFF_START + new.txt
>>      DIFF_SYMBOL_INDEX_MODE + fa69b07 412428c "non-executable" flag
>>      DIFF_SYMBOL_BINARY_FILES + new.txt
>
> Hopefully this is an oversimplified example and I'd assume that you
> will do the right thing when showing a renamed filepair by allowing
> both old and new paths that could be different?

Yes, this is simplified to drive the point of having as little data as possible,
so I thought we might have a flag that says "same file name" instead of giving
the file name twice.

We do not do such an optimization yet.
