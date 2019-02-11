Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8461F453
	for <e@80x24.org>; Mon, 11 Feb 2019 22:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfBKW32 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 17:29:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34195 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfBKW32 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 17:29:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so889419wmd.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 14:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=pCJ6UwAESXPkpj2E8TNgnM9TqQSsmlaiy94LmMuYo7Q=;
        b=O+AzzJSfynmfEq5CImXH1ilixw+GLdbaWjI8/dfj8keXSDY/SInHFGMQhvZuHOZXc2
         qwftm9TyfTNg+QgGXbPLyeVmW4DYmvj3ujO9a+IqMimQUVdTnH7/ljyBY7cfiqYSFfGA
         1WzxkbwVH+I1qJuOIJTiBk0F1e2yyX0BhbvIQTTWON16Jk4X54xW56yvjyZA4yR0QDII
         +YGULJdsUdJO3jud/KBoXnNdXIAfdkNaBQ8Rtu8G4gvpXzgtmNG3UETSmOvgb20xvjKt
         ZQdTtY9RdC7/nLtkfIBrRJqP7F3nfygR+mJiTCBT/u2mSRuWWJLUzykI/FUTWofEif6m
         EZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=pCJ6UwAESXPkpj2E8TNgnM9TqQSsmlaiy94LmMuYo7Q=;
        b=MpNjrtapZhx1PjrjCOkaMM+6vUY1PhfMcaQcQvLV3hrE64+/7O71gpu0p8HwWLG3w5
         08MQNSK7WhFoMAY4CURkuxnscEk6jeXAp+E0adzfdychmpnKk9k8H788h64YCl+JBDyY
         fDwLSgfKgVXHMxiy3lRWy3wtwU7f/7WL3oGMHa9q/76B/weTa/pu4czuEiuRAM+pJqjM
         njZllkaTF+QO3Tcvp3qTuN/PlhQDY+M+8FR5nv191oG8W3zDMmNPmJBSRhjwLt5/uQDm
         XPGJa90H11MCElOsD3Frdfaxeej0umJlMx5eGS1vHzClFCWXhK9e2CnU+3+zBDXQzVek
         Xeag==
X-Gm-Message-State: AHQUAuayU8e1QfGurSUiGNN6QUwm8BYv3vPRW2hUrCS2gv3KV3uLvDm9
        1keOm1nnZXeGe+mN4XMBBbgLG925
X-Google-Smtp-Source: AHgI3IbxILjFYnJgKx8pxkjS4tDRNSKvoc0QVwq/Y29v5IRRr41Y2HtjPraJr3uxpPx5n5CgWAW1bA==
X-Received: by 2002:a1c:c90b:: with SMTP id f11mr343564wmb.33.1549924166110;
        Mon, 11 Feb 2019 14:29:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q12sm7474788wrx.31.2019.02.11.14.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:29:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: fix non-portable pattern bracket expressions
References: <20190208115045.13256-1-szeder.dev@gmail.com>
        <20190211195803.1682-1-szeder.dev@gmail.com>
Date:   Mon, 11 Feb 2019 14:29:24 -0800
In-Reply-To: <20190211195803.1682-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 11 Feb 2019 20:58:03 +0100")
Message-ID: <xmqq7ee6gdrv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Use a '!' character to start a non-matching pattern bracket
> expression, as specified by POSIX in Shell Command Language section
> 2.13.1 Patterns Matching a Single Character [1].
>
> I used '^' instead in three places in the previous three commits, to

Ah, thanks for catching them.  We should have caught these during
review.

> Should go on top of 'sg/stress-test'.

Thanks.
