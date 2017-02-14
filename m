Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 283B71FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 04:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdBNEl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 23:41:56 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36527 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdBNElz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 23:41:55 -0500
Received: by mail-it0-f67.google.com with SMTP id f200so2875641itf.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 20:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o4kGNS5bE4B3c0WBXbCeYNXMcL18wqVOJP1awMD74PI=;
        b=Gus0tz0MkDaAfcPns06/iOEKJvYL+9hPH/e++61WtNSaqx9PyCnu79OpkM9ff6P14C
         QxyIUvzq6Uxrmju676waLqg6IcxymgCfrjKoWI5+ZD+cr7vpeGBJ04CeVchBfDUFaNlN
         3zNRknXXEMmqZQGCRHr4/nwTzSa47lm0QpgDRPUVsmP05GjhtLF6LDlSN0Wxw5g6AWDr
         qrRXKtG7AQM5QJMfOnfE4LbrUrYX8cgxAvK2znTuUh2iC1Z82lj7giSFhQO4CqmzZXUZ
         CZPM5xRL3UWXmskIki4QuBvVqssqGC7PiAM9b2ksvi9nVhbtKGZLussM2FZVk25JA2A3
         3CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o4kGNS5bE4B3c0WBXbCeYNXMcL18wqVOJP1awMD74PI=;
        b=siQQhYHRqUnc54D8NPFuopITBZNtsvjB0Mwucee05mlPtatibA7oAiwSa+0MfY9S25
         ywu2fWEj3+TM9zqeuhjc5pwZS7dSpoFI94Xjc6zMOF0fxzfh/l2a6P9axRTknpety/kn
         qua/5UivVA1vcXF66atTmW2JWYDGC5G7xDbYHJyQ7gv6rq8AtDuplII9CnBD4q/8F8Yu
         h/jv1F/cWsDMIN62WfGmHefKa9M6i7T+KBCQcTYqTAqM6Kh0dF/g5J1GnsMklFuv1u94
         zOroSPp5Uze0sm/iDhEHjPxH6kp0HgA8u9YwnbqQN4FfbrDTlfOTdQUahevJhMecg6Kz
         VOHA==
X-Gm-Message-State: AMke39lU5B2O1ZibkArOS2MjR4srN77R385XAXgMqI1ysgK8a/lD+nsBqjRHksIU5XPZxQ==
X-Received: by 10.84.132.1 with SMTP id 1mr34117392ple.44.1487047314249;
        Mon, 13 Feb 2017 20:41:54 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id l25sm17368758pfg.134.2017.02.13.20.41.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 20:41:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Arif Khokar <arif.i.khokar@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta\@public-inbox.org" <meta@public-inbox.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
        <alpine.DEB.2.20.1608181430280.4924@virtualbox>
        <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
        <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
        <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
        <alpine.DEB.2.20.1608241509200.4924@virtualbox>
        <alpine.DEB.2.20.1702101707060.3496@virtualbox>
        <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
        <xmqqefz1ew1h.fsf@gitster.mtv.corp.google.com>
        <acac96da-2404-4f7e-a83d-7648ca448d31@hotmail.com>
Date:   Mon, 13 Feb 2017 20:41:51 -0800
In-Reply-To: <acac96da-2404-4f7e-a83d-7648ca448d31@hotmail.com> (Arif Khokar's
        message of "Mon, 13 Feb 2017 22:55:49 -0500")
Message-ID: <xmqqlgt99yeo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arif Khokar <arif.i.khokar@gmail.com> writes:

> One concern I have regarding this idea is whether or not SMTP servers
> typically replace a Message-Id header set by the client.

The clients are supposed to give Message-IDs, but because some
clients fail to do so, SMTP server implementations are allowed to
add an ID to avoid leaving a message nameless (IIRC, 6.3 in
RFC2821).  So "replace" would be in violation.

But some parts of the world ignore RFCs, so...


