Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D9881F453
	for <e@80x24.org>; Fri, 19 Oct 2018 02:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeJSK71 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 06:59:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42778 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSK71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 06:59:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id r17-v6so3411425wrt.9
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9d3jzkfQxDORwPtEdKdlQU7/qCXEBrpcxv0LMyqq0Bs=;
        b=oS7b18JeLdJGcf/ERj1OHtHb3bkTfMoog8h85bdYcxVtAHY8mnsHGR5xs1t7K0pArD
         z+3Yx6fVpBTrmyYeJnKz073LKmc+jPu6kkx7tq37pev4feCGAAnTLbxyyoRxQAe6VCXD
         fFsS4tPF1PSVrX+roNtPncbE0ngB2/8XSE6zasKZdDehx8R3t7w517GoklN8uHAgDLao
         nGaI7RVSCGrS5fnt6p32yxgjtQaTt4rk+Xf5iTbZTpcXMZXeEredmxdLhq5wqBKIJwHb
         DS2u6QYq+1G06PA9yxf4ny3DonIdwj1wSzh9USyOSLYgtq/Ms8R5KeV0P0jpX6oP0aPr
         B+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9d3jzkfQxDORwPtEdKdlQU7/qCXEBrpcxv0LMyqq0Bs=;
        b=YcnbrXIjH+AF5pRmnJ9BykI6UdnYqNAPNb8J3Kl5QtB+df+Mlti5zK7sM8Qh+xJw91
         z2FSGFHLd96dEjgus2uKoxOGicwvIZm7q3j2N59/6BZvU2U42hVFM9iSKVvkBhomPAHA
         65gVIhTymFx7RfPrRKlad7LWzf7y3+Y1510+xuUwPMihlXM8RwbyYIdd1g3KV/Q15ElP
         T4LvZNsua19EoYMGHUlXA0JdWFAYpZYOWXa+ir7BmLU6+l5e6McYnL25Cd1EvIjvQ/ei
         tQnsSCjg6TR/aSShh9p0w2ieNcZLg3rTeJEI6cnGZGDdI5V7URUp6vktCJ6PuTPPnPRc
         0gVA==
X-Gm-Message-State: ABuFfojfR0ayjeBy2deCLOfIcxwgJV0HBucnaotkt1y6C0Y2Ah8UQwNy
        TfKmkPPKUwexdKrDrDK30T4=
X-Google-Smtp-Source: ACcGV607B9/Ak96zP7KrLacFY+uuXTLz9dAtxn8D8KxlYjdnQJTNsTEt5NFfkSTe9XvgTc7h56c8Cg==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr33489930wrq.189.1539917722672;
        Thu, 18 Oct 2018 19:55:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e14-v6sm22576795wrt.76.2018.10.18.19.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 19:55:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        christian.couder@gmail.com, sbeller@google.com,
        git@vger.kernel.org, peff@peff.net, Ben.Peart@microsoft.com,
        pclouds@gmail.com, mh@glandium.org, larsxschneider@gmail.com,
        e@80x24.org, chriscool@tuxfamily.org, jeffhost@microsoft.com,
        sunshine@sunshineco.com, dev+git@drbeat.li
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
References: <20181016174304.GA221682@aiede.svl.corp.google.com>
        <20181016222243.58620-1-jonathantanmy@google.com>
        <xmqqwoqe4xev.fsf@gitster-ct.c.googlers.com>
        <20181019003325.GA30421@aiede.svl.corp.google.com>
Date:   Fri, 19 Oct 2018 11:55:20 +0900
In-Reply-To: <20181019003325.GA30421@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 18 Oct 2018 17:33:25 -0700")
Message-ID: <xmqqftx23asn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> It is a good idea to implicitly include the promisor-remote to the
>> set of secondary places to consult to help existing versions of Git,
>> but once the repository starts fetching incomplete subgraphs and
>> adding new object.missingobjectremote [*1*], these versions of Git
>> will stop working correctly, so I am not sure if it is all that
>> useful approach for compatibility in practice.
>
> Can you spell this out for me more?  Do you mean that a remote from
> this list might make a promise that the original partialClone remote
> can't keep?

It was my failed attempt to demonstrate that I understood what was
being discussed by rephrasing JTan's

    Or allow extensions.partialClone=<R> wherein <R> is not in the
    missingObjectRemote, in which case <R> is tried first, so that
    we don't have to reject some configurations.

