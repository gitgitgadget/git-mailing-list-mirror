Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAECF211B5
	for <e@80x24.org>; Fri, 25 Jan 2019 15:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAYPWv (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 10:22:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39978 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYPWv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 10:22:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so10708595wrt.7
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 07:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=07HJJEXMkVZIHpY44IPRwMaH6sxt1Pr9urVOB8djIb8=;
        b=oIsBO9plHIJieQncZbU6LIJK1LT7QcUqOSkYMFBvheM3EG6yLgCV33RvXUXCHx5PuW
         3O4raa2LGtoxroVuZiaL3Fb2MGGBLbNjyEZRgmPKYHpKYh40lQAia134ucdyqDKZC0zR
         3SFTmea+R7XwLGxhmFBl/IIM0WNuloMpXUYZbvQCLdkYBtg0kMg9ybGNN31q9InIy2CN
         y1uDJnIdTmPz98qhWMfCboJn4cFtIwDqMNPva8ctYFq8PP9lUxUQBbbcb4B/UE0mFhqp
         QSUohj/UMVTVpBxZ5SwRnML6GaQUubhoFDVijcwKTmg6V7BtM2aKDFKnWLVq6EYPf7n6
         r4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=07HJJEXMkVZIHpY44IPRwMaH6sxt1Pr9urVOB8djIb8=;
        b=iSUcG8Xhl7ZsiItTCQavUHgT3w9BmpU4N9cHC5bxsJZusa4i6S6zhrO+gh0qTBVs9s
         pCS2m+CX59Q/vTFCm712XoyN1K5BU5R3SyzQZs6maBau9AHaXAo8D5ZHaLl6Wc1uXWkV
         PD7R+irxrsID7HFTgd5tOjTLIFzOcjNB8dQsVBJH5SRwVtU1RWbV5HwZVHFTaWa133C0
         D+cPev71sADTSf+12UQDLP59yieXlPQLo48+1+GMhfX5I59yGzEjFWvMMYEQ+L5YXqzX
         qSV6f0cFH9GKZ1nlkLSJYiKDhd4UYM89mjYIBX3OzQzU4yC877vri9vY6BtWP2zDQj/y
         nQIw==
X-Gm-Message-State: AJcUukffamP3Y7x2vDaiD1MyMRkEBRDkdUTLFl6uTO/G6G2VS1zA+4It
        JmW7LroAcsx21y7RPOkN9+8=
X-Google-Smtp-Source: ALg8bN6bnK77TMD93cohWjTUiOxj+nPS6qEt99LcLqAwi6tT/4gde96YCQHQ+mipd6s4ZdKujC6VvQ==
X-Received: by 2002:adf:b783:: with SMTP id s3mr12458944wre.274.1548429769666;
        Fri, 25 Jan 2019 07:22:49 -0800 (PST)
Received: from sid (dhcp-18-250.cable.infonet.ee. [212.7.18.250])
        by smtp.googlemail.com with ESMTPSA id c65sm61988722wma.24.2019.01.25.07.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 07:22:48 -0800 (PST)
Message-ID: <5bc3256d49834c96db2a51c12190f2cb7cf7ac42.camel@gmail.com>
Subject: Re: [PATCH v1] git-instaweb: Add Python builtin http.server support
From:   Arti Zirk <arti.zirk@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, e@80x24.org, peff@peff.net, jnareb@gmail.com,
        flavio@polettix.it, wil@nohakostudios.net
Date:   Fri, 25 Jan 2019 17:22:45 +0200
In-Reply-To: <xmqqva2cg61l.fsf@gitster-ct.c.googlers.com>
References: <20190124161331.25945-1-arti.zirk@gmail.com>
         <20190125020451.GU423984@genre.crustytoothpaste.net>
         <xmqqva2cg61l.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> > Could we call this "python3" instead, or provide some other way to
> > communicate this to the user?
> 
> Sounds like a good idea.  Also would this be _the_ sole http server
> implementation Python3 users would choose, or is it just a possible
> one?  What I am trying to get at is that we might need to be even
> more specific than just "python 3", but may need to convey that this
> is for "http.server using python 3".  I dunno.

This is the built in http server that Python comes with (like Ruby
users have builtin webrick server). While it is possible to install
something else, I don't think many casual git-instaweb users would do
it. 

I haven't looked in depth into it but I'm pretty sure that by simply
changing the imports I could make this code also work in python2.

Upstream python2 support ends in ~11 months and would Red Hat/CentOS 7
users using new git releases really care about "git instaweb -d python"
not working on installations without Python 3?

In the end I would like to keep the name just "python" to signal that
it only needs standard Python installation and nothing else.

