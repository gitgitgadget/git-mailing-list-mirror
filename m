Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94884203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 23:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbcLSXgd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:36:33 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36513 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbcLSXgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:36:31 -0500
Received: by mail-qt0-f179.google.com with SMTP id w33so162089016qtc.3
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xlOkut3ZF9FvOeWQ6s1LkhranXCh1/0iIKNHZQyUNew=;
        b=vm9VQGNE/wS/LwUaGjxBhw0UwRHpxMeZkDIu9/ilqg+xrMfy3PfDzShWMNFmO9Ajzi
         khU7qbcEAeW/RURfvZ4uAIcKWCbbYQBhcQJlePLprSHaGJhxnd+NO34lCJdk0gSecZhU
         lG5OZF8wesGkp5PLNjPQZAY4dQtOSOg9PMvWIhWaX66onIRuSRV+jrC2dzKjO3biHgi2
         D8zgugRHAuAgwdep5/f5RoqQEX9JqK+p3LqKQefYrHxhQDnR8vCBMotf1ewzG3GlKLs+
         fxZV5twaH/f6tcY8lOQYpGw2Pa2hzH/ldUuBOr7e5l6X9KzV4pxSn9c6MUWL1R7q91I8
         vAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xlOkut3ZF9FvOeWQ6s1LkhranXCh1/0iIKNHZQyUNew=;
        b=BTh8gwBDDCPXK2nLZv8Xz4On31lI34LXK1BEeYym9KvhvFaVux8DgOlfEHasxhrohX
         vD35BNPOF6ctKGAB8uO++Bvwyhesc9Ye6qsgg5U772ZYbT6+wzzCHydjK0m7eDt3QYEY
         qDc9qccBLAdFnVIx/Sl1EH+v/q5CssSpWsyDNI5lyO0oGLioJYGKPAEPd59Lpxg7wlEu
         JpH4CijKtnhfRNFQ4s7i0dsKNXk5ZBtmVktsiI+Ktq+EH/VElEXIAtEW+Btb1k3axabn
         4axfC/Ge5sX9g6tn66h2PAQ6+TtQS9HwuG8bGFLuY0pb6sHN6gUVTaT+8t9fyU524Gyb
         pU+A==
X-Gm-Message-State: AIkVDXJi5BRX8yFaYJL4+W8zr5h7Nv0qIqjhHCT20LmTOZFQm6r9V92pQEv0sdaU1WgT+dfBHYvw0s3ZGGx0ZrUp
X-Received: by 10.200.58.65 with SMTP id w59mr17198637qte.54.1482190543362;
 Mon, 19 Dec 2016 15:35:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 15:35:43 -0800 (PST)
In-Reply-To: <20161219233256.GB41080@google.com>
References: <20161219232828.5075-1-sbeller@google.com> <20161219232828.5075-4-sbeller@google.com>
 <20161219233256.GB41080@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 15:35:43 -0800
Message-ID: <CAGZ79kY7XpM2zi8CWjZ5d=yBJi1JGz7XkY=d=v+3rVPkF-N4mA@mail.gmail.com>
Subject: Re: [PATCHv4 3/5] run-command: add {run,start,finish}_command_or_die
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 3:32 PM, Brandon Williams <bmwill@google.com> wrote:

>> +             strbuf_addstr(&err, "git ");
>> +     for (i = 0; cmd->argv[i]; )
>
> Missing the increment of i here.

Doh :(

When writing the code I was undecided between using
an incremental loop "for (i = 0; cmd->argv[i]; i++)" and
a pointer arithmetic thing as "for(;;) {... cmd->argv++;",
and ended up with a broken middle ground.
