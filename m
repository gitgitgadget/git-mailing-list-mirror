Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D4A1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbeIUWOQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:14:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41957 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeIUWOP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:14:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so9351315wrt.8
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sRHdhtE/dCDjkIB/z1m5DaXS951YdiEbfD7xmD66WvQ=;
        b=BCg6826yGcooV6vxtIzBCUPzOWPc2gg2XwnGQzW2rhH/klbf/f6TnKiySpnO5KSmsN
         yygrocNU11z2dLuIUUJG5S2xWEwQ1RY9WaTOqjDO1TStALqfWCgpRNzh6V5gK46GhoY2
         vgSLgn2/MHvW7aQzDkZqDY9qn/sSvk3Lmj1WaopEKCi37e8oTbxWnPgtZO2nIwbWrGr0
         OlkWWTuCM5PTD1iicmzNl4OW79nSk5l4bbtYDKBQN5l5BtTJuBiNztXB3Qy2RJUbE25Q
         Ea4D2C4pzIzgJy9K/NEfjQoaYrCOUHbvpVKXuPJTjfIC9l6CE96/E1yJ9mWlZJqkeQHX
         VSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sRHdhtE/dCDjkIB/z1m5DaXS951YdiEbfD7xmD66WvQ=;
        b=PYWQRkiloBVi84t+BFJSnvaLicGNlM1QD/AvGhRMrXA325ykaalfxqkmNiwn1z8n42
         NE+xsflhrzNC8IPw0i1UbCxDjDvXWRRCuatkdIqQ+uOBm4/9BtDC7kqnNplde5f38y3r
         2LPBbaf/9mNUQ1O+C4YYD07ZhjUqZq8LYNg1mLWbVnfxStN9Sn50Qai1eTDEWpR0Fjpu
         zsnBHKdOhJltStoWuDOKzwaefozxcyZeBF2zCpY93zMqVto/hjGNACTqFfY9x4p/5OZx
         t3T35kU76psFWTlt06kJ2O0g7ARslhMH5NPWUEcgr7CXK+0eZ5EoIUU7NvVMRnGNL6F8
         2MVQ==
X-Gm-Message-State: ABuFfohFaNHcepggtZaYqZFgsRa6gtV7ITbUCwQS+GfOUO27dc2coLL4
        vJpXuAI1OkgVjrMzmX/fC871zGcx
X-Google-Smtp-Source: ACcGV63qK2zSq6bOvCbOie+ggyNcjEIhvZnWqv/F4Nt/3y49O+B9/hiiF4bFciKPEmMz6CrX+VWgRw==
X-Received: by 2002:adf:f506:: with SMTP id q6-v6mr3656735wro.241.1537547077129;
        Fri, 21 Sep 2018 09:24:37 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t2-v6sm11200361wre.96.2018.09.21.09.24.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:24:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] userdiff.h: add missing declaration (hdr-check)
References: <c46ca4a9-6822-436c-8e84-95b977527912@ramsayjones.plus.com>
Date:   Fri, 21 Sep 2018 09:24:36 -0700
In-Reply-To: <c46ca4a9-6822-436c-8e84-95b977527912@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 19 Sep 2018 01:20:45 +0100")
Message-ID: <xmqqworex1h7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> ... and this is the patch I needed for the current 'pu' branch.

Which in turn means that this is to fix 5b338d60 ("userdiff.c:
remove implicit dependency on the_index", 2018-09-15) and should be
rolled into nd/the_index topic.


>
> ATB,
> Ramsay Jones
>
>  userdiff.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/userdiff.h b/userdiff.h
> index dad3fc03c1..b072bfe89a 100644
> --- a/userdiff.h
> +++ b/userdiff.h
> @@ -3,6 +3,8 @@
>  
>  #include "notes-cache.h"
>  
> +struct index_state;
> +
>  struct userdiff_funcname {
>  	const char *pattern;
>  	int cflags;
