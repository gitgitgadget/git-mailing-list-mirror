Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FB0B1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 23:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbdBIXnV (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 18:43:21 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34834 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdBIXnT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 18:43:19 -0500
Received: by mail-pf0-f193.google.com with SMTP id b145so227004pfb.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 15:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wH3vOjsVe68Pm1HxBqa0u9TY+PqrpRoy2S1RnW9rpx4=;
        b=B7ULgVkG3EmX03nLt8HAkk+zXuW8XhBdApuCfJdv4h4G+2lfhy8coMeEmlINULd5zi
         uusAL9iwa5qa+vfdd136eF8wbzU/j/ykS3I3m7jBsZN6hQWcG5GkhGHAewVRU8IhpX8q
         09lSzkoVpLZ1xLdYZV7hOw5fQpoTncL2KRjCTU93Pf0qqTKhkMKz8TXcTkd8FqO1XmpI
         2xBXQk4PKW89ZeSU/mIx/OxiaqgQJFjWRjYdQd/hcf2N+q+z0VL9ABSYJN+FbsXjUBht
         2iczrzPteTgEVw57sTO/SSOMIIj2up5usvbtTWdiy/1//L6lgDVeUkHLIV20Pe/WJn11
         sIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wH3vOjsVe68Pm1HxBqa0u9TY+PqrpRoy2S1RnW9rpx4=;
        b=dJa29qslIbxQJvknEof5r/AAHyfUl9XHnLrp9mznDiZUmKEA3HM48zwMcshO1i7CCL
         BY6bM1GahtcXuOZAjS+gRrbDdY+nUexvZVaHaXft0EGVhxIpHrVRYotBlXDrcbCURKDK
         DnOoZHjwsjyl0PZLtRZ17/T+MiZkUK6VbLWHMgeAmSLMUkbBJvReuFWaPwa2QuGZ59hU
         NtO6s+tB/9Fdlnx6sFUbISVoi4ynHw6+V50CMadoTEjPsMe+0R6rda8rVT3TlktRus9W
         ekpqJWL77MLMqf1lJihS2Fo5Cns37cqB2wPZg2krOEmbA3OHGm+EzOJ8wI4I2U6bVUTd
         qGyg==
X-Gm-Message-State: AMke39lHkdJ3LartX+ehgpibujkmWWiH10j+op+j3z40pz735AqNSEBFIT9sUU5OkY03JQ==
X-Received: by 10.98.9.206 with SMTP id 75mr6611822pfj.159.1486683712616;
        Thu, 09 Feb 2017 15:41:52 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id l71sm31728569pga.13.2017.02.09.15.41.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 15:41:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: use OpenSSL's SHA-1 routines
References: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
Date:   Thu, 09 Feb 2017 15:41:51 -0800
In-Reply-To: <6a29f8c60d315a24292c1fa9f5e84df4dfdbf813.1486679254.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 9 Feb 2017 23:27:49 +0100
        (CET)")
Message-ID: <xmqqbmublyo0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Use OpenSSL's SHA-1 routines rather than builtin block-sha1 routines.
> This improves performance on SHA1 operations on Intel processors.
> ...
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Nice.  Will queue as jh/mingw-openssl-sha1 topic; it is a bit too
late for today's integration cycle to be merged to 'next', but let's
have this by the end of the week in 'master'.

Thanks.
