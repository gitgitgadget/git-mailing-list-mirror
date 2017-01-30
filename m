Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD321FF1E
	for <e@80x24.org>; Mon, 30 Jan 2017 23:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753381AbdA3XUU (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 18:20:20 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33749 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753369AbdA3XUT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 18:20:19 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so24529417pfg.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2017 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GQuWqffHud3rEZmo0ArTZ8oaAsAytJiJ/x8m6eJKCxY=;
        b=Sw8IBvZ1zpx4C739EPqtyqS0sgAH8lNfGbkKVI42KpECTamimnsO0rYx/gqVSXLY7L
         rI+SFtJld95M9ppvuE61TtQPB/XxQZJxlBX+GWX5glDbgbWlbtlVySVFaucuXBOnCG9u
         LlwhREg66aF1ZVkri5qQi25HkZJ9vScMYJK9Q0ojL1WyygHYskdALx3bUuy57SPnh2yC
         GuavSdAslIyC08ZJ+pnCmeGxdtqkAu5HhK7wAnkt25HJhPXY2tjR7vZbcJubBgP+w0+/
         Dwmgc2Zt87TUvM9rUgCYJdlTAND82l3W2zsI7WZUJbe+XaaB46Q9pOmpJ6qfeedcCSqc
         JVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GQuWqffHud3rEZmo0ArTZ8oaAsAytJiJ/x8m6eJKCxY=;
        b=lR3Qi12WvqjFNUPRjpXjDK7QZTeA7ZBG5U4QEvxwKqdpRdsj9CGQ5nTYS931hj+ekL
         CZ9m6Ly7OBIShB3n2eYXMFjal6e7TgdrhV4suRspUL5C4u0NPTK+7H5JKCQyOCvneV8v
         A5SsnzYqkqK1y2ZybzK8twVx06RcRpbfCBt3p7FgR3dlsI68vhVSAFKmDaCqv1e5kA9n
         8Gj0ubPOGjOAHOWcDWkHLM1EdHaPBdQKKl/z2Ye2ysU9RmuzMOFwrsa8WbSc73jX3rV3
         aq2V7zVsyZxHcOb4ZaPunoyWnzQ6lqQP+oJT9pFczOcP4yA4miMV/Z7OWpkjS2bC92GU
         vhBg==
X-Gm-Message-State: AIkVDXIgwxZobuf8XlqfTTPxrm69TUNxep0sLpNIWF94YLALIqxIAnqI4SnszsdFCxqC8Q==
X-Received: by 10.99.99.193 with SMTP id x184mr26919602pgb.226.1485818419035;
        Mon, 30 Jan 2017 15:20:19 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a9ce:56f8:45fd:fc63])
        by smtp.gmail.com with ESMTPSA id p14sm35202046pfl.75.2017.01.30.15.20.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jan 2017 15:20:18 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] introduce SWAP macro
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
Date:   Mon, 30 Jan 2017 15:20:17 -0800
In-Reply-To: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 28 Jan 2017 22:13:28 +0100")
Message-ID: <xmqqzii8rv7y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Exchanging the value of two variables requires declaring a temporary
> variable and repeating their names.  The swap macro in apply.c
> simplifies this for its callers without changing the compiled binary.
> Polish this macro and export it, then use it throughout the code to
> reduce repetition and hide the declaration of temporary variables.

All looked reasonable (modulo "swap tree2 and tree1???" ordering).
Also the object-id ones looked good.

Thanks.
