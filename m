Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE89820D14
	for <e@80x24.org>; Fri,  2 Jun 2017 02:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751142AbdFBCG1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 22:06:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34762 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFBCG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 22:06:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so10273054pfk.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=owUqsnqBw3su7j2hb8XkUUT6txR6ADG8mSGwfRv2yK8=;
        b=iS+/hHXBYHEpasmnqZeC3CsUN6Ts8+2U/ueRVehCQxuq1mKB2QhxVC8tdpf3egGJ/x
         pIqGfe6j/bu8uzciB/nIwih6fBDUf1Wzf0EJDe+2Jncybt9VGZqP1BhuPLbLf1obJYmR
         xo5QrOwK3E7yHZSxjB45yOG9ckxiuAxHIN7aDO2tpGx/zRRFiGgDyWhGBI1tsRYcqE7w
         Bm/zCnq1Lvfg4/roSgePQlOt3cux29du8mu0UWmPCCAZLMMFU7xfoJeRSiHynJJMhkQh
         8AB7ukCGzWzV8v43UFeJgWYPLf0SWwdwUgYdmkCqNauR9MMJAEVAbSxzaMvsUHtYsIQZ
         cbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=owUqsnqBw3su7j2hb8XkUUT6txR6ADG8mSGwfRv2yK8=;
        b=he8tmOmvLsVPo9t6qpOi8I6AQn4JYs0weiklwqwGz0mWxXDFm9Q+SgPAA9dTCUFb3J
         YY2JMaUFseYdts3Mr6xAs0sQVAgcWrQtx0mXCjpfOn5EI922QXQAD6SmyPD6m66AryVb
         KwNNvHc4GExrjCmczCeSMrgueBkTEX8SNs5mzWfJFDI/4MIBUbp5h2oIiIjbSHV7R70d
         Wmr3K74wIZNjrSx86425P/L/88ae7HBswE8NV49Y536FqB64uBGd9MCOF93Ir7WmLzsf
         qmNNLeqLSYX2Ne9ipP4RSHledd05EbSMXAMBvSywQGQc6kBSMXrDhm8XT7qpGAvmgF+7
         trXw==
X-Gm-Message-State: AODbwcD6T24NF5fNxr5/U9QgpXZerfzSwbc2z4QgzjxeUNCYkDb2aPpx
        8fuvX2Gsm3LrU0D5G8h0kg==
X-Received: by 10.98.193.65 with SMTP id i62mr4218501pfg.134.1496369186241;
        Thu, 01 Jun 2017 19:06:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id x71sm37055150pgd.6.2017.06.01.19.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 19:06:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 0/5] convert: add "status=delayed" to filter process protocol
References: <20170601082203.50397-1-larsxschneider@gmail.com>
Date:   Fri, 02 Jun 2017 11:06:24 +0900
In-Reply-To: <20170601082203.50397-1-larsxschneider@gmail.com> (Lars
        Schneider's message of "Thu, 1 Jun 2017 10:21:58 +0200")
Message-ID: <xmqqbmq716u7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> If you review this series then please read the "Delay" section in
> "Documentation/gitattributes.txt" first for an overview of the delay mechanism.

OK.
