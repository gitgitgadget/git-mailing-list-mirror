Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FC501F454
	for <e@80x24.org>; Fri, 19 Oct 2018 00:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeJSIE5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 04:04:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeJSIE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 04:04:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so35510710wrt.10
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/Y6uHERoDr1U8LOBrWPkIRJ0UZf3/08wdo+bdiCwQ2A=;
        b=iVgMoFInEkMSGU0MQmoYPJbUstnV3uY3Q25YeEe3by+UWShQJElupAilL9tCoQByXS
         rYWMGy7EdUe2umHW8LdUoy/lXHjjWE1Pxg8rZlkJ93qhcIlTmuHDmpfe57pXhjG4FROr
         NhcBYwThtJlmD6E2MuRrQCUUqleaTviBpA5tyTymUyaJ5oB0RdoYD0D+1Sli9o9DeC3A
         iOkyargXtCHY2iBUZx9FFiHHYY+bY1S4wyMLOzUVWAN9meym+2Ori2e7KZmqn7TCPcvw
         6A+TqObB3/2wDFmjSDc16ea+0R2GTICzJa9mzQKymq9VnB78NUlEqVTJ8chvIM/GvWc0
         9yFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/Y6uHERoDr1U8LOBrWPkIRJ0UZf3/08wdo+bdiCwQ2A=;
        b=sB3e4WDaImb/msCTk9QmXNLEhD4omo3PiA7nFqj65bWhnCoFN9Oj8KDnNjszp8QJiA
         GmI19CTiKwndpR5dbQ46Lu/rDMo7mvNoJWmukIkW03dvzr2GMgJtHYhJzK7INH9PjtZa
         0l7fbetGOGxyb62Aav3slMt1Nr8XAy/i+iCSD4EBkkO3lAjzCgWZrl3Q8H7/irSSePHs
         Z4aUtKT6wdzi6CW3CDcS0hSSQPUIHA21Ebpz3KsJ1MuYuG8U0zuU2+XucC0UAJcMVZV/
         eDAkbF9Lz3M4MlttkEtVbiLLCHjt8dejAzcXZN1yxuWkmf9K1M4WLBv5fLWUnjybZGT+
         02Mw==
X-Gm-Message-State: ABuFfojwETtFt/LMBEg2i57ra1lYFCvA27ueKyJBJGPkrCOClxHH8sNA
        AlruD55Gr3zfM841sM1AnBw=
X-Google-Smtp-Source: ACcGV61dvjyMuDg7zCsL5+THUuR7N2sqi/t3/U80SwkryIXvV7Ibv9eoRyEai50yaOYZycd22hvG1Q==
X-Received: by 2002:adf:cf0b:: with SMTP id o11-v6mr30907619wrj.272.1539907290966;
        Thu, 18 Oct 2018 17:01:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i7-v6sm28401833wrb.30.2018.10.18.17.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 17:01:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     jrnieder@gmail.com, christian.couder@gmail.com, sbeller@google.com,
        git@vger.kernel.org, peff@peff.net, Ben.Peart@microsoft.com,
        pclouds@gmail.com, mh@glandium.org, larsxschneider@gmail.com,
        e@80x24.org, chriscool@tuxfamily.org, jeffhost@microsoft.com,
        sunshine@sunshineco.com, dev+git@drbeat.li
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
References: <20181016174304.GA221682@aiede.svl.corp.google.com>
        <20181016222243.58620-1-jonathantanmy@google.com>
Date:   Fri, 19 Oct 2018 09:01:28 +0900
In-Reply-To: <20181016222243.58620-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 16 Oct 2018 15:22:43 -0700")
Message-ID: <xmqqwoqe4xev.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> 	[object]
>> 		missingObjectRemote = local-cache-remote
>> 		missingObjectRemote = origin
>> 
> In the presence of missingObjectRemote, old versions of Git, when lazily
> fetching, would only know to try the extensions.partialClone remote. But
> this is safe because existing data wouldn't be clobbered (since we're
> not using ideas like adding meaning to the contents of the .promisor
> file). Also, other things like fsck and gc still work.

It is a good idea to implicitly include the promisor-remote to the
set of secondary places to consult to help existing versions of Git,
but once the repository starts fetching incomplete subgraphs and
adding new object.missingobjectremote [*1*], these versions of Git
will stop working correctly, so I am not sure if it is all that
useful approach for compatibility in practice.


[Footnote]

*1* That name with two "object" in it sounds horrible.  I think the
same keyname in 'core' section may sit better (this feature sounds
more 'core' than other cruft that crept into 'core' section over
time).  

Or "odb.remoteAlternate" (as opposed to object/info/alternates that
are local alternates), perhaps.
