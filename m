Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D20C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9526103A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhHMR5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhHMR5o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 13:57:44 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC42FC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 10:57:17 -0700 (PDT)
Subject: Re: send-email issue
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benaaron.dev;
        s=key1; t=1628877435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jnLHtH+kDi5S/Gvpg5qOI+iiaLSZ2QrwphDOlytok4A=;
        b=iU6B4vztTayumJYKNal49pL4/GMqoEEgRGdEgw7vd/Ft1tGoc5rN4h8nxErkP0jO+yIFfN
        h9BwFuicij8MDrshpvJs4Wbb4pCZrYs+Ji39DzopVxjUxp8qiEHd3BuuNTDsFs9efDeH12
        c9OyUIWkuopYkwulLgtdyBHl1Cg/G7xMgZJE8vHfgP2RgASap9uM7O5vlliWuAjgdcwM1k
        Uf3BYEMYTFhFI0xLk/qzZrLKa42+rQ2SFbCWLNOoUODz16LarRZ13tSfS4sXnScmcmrA8F
        4P9HOOvrcPUxzzw6/BqJv1lotNav4M0AXNQdPiCyGy90VsOpR1C+W+PkZjTttw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Ben Goldberg <ben@benaaron.dev>
To:     git@vger.kernel.org
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
Message-ID: <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
Date:   Fri, 13 Aug 2021 13:57:13 -0400
MIME-Version: 1.0
In-Reply-To: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: ben@benaaron.dev
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A little additional info. When I run send-email with --smtp-debug=1 I 
get this.
```
Net::SMTP>>> Net::SMTP(3.13)
Net::SMTP>>>   Net::Cmd(3.13)
Net::SMTP>>>     Exporter(5.76)
Net::SMTP>>>   IO::Socket::IP(0.41)
Net::SMTP>>>     IO::Socket(1.46)
Net::SMTP>>>       IO::Handle(1.46)
Net::SMTP: Net::Cmd::getline(): unexpected EOF on command channel:  at 
/usr/lib/git-core/git-send-email line 1556.
Unable to initialize SMTP properly. Check config and use --smtp-debug. 
VALUES: server=smtp.migadu.com encryption=tls 
hello=localhost.localdomain port=465 at /usr/lib/git-core/git-send-email 
line 1583.
```

Hope that helps.
