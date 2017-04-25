Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804DF207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 05:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S980489AbdDYF7j (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 01:59:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35950 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759974AbdDYF7h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 01:59:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so1391861pgv.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 22:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p3vEOU6uZ0CvqHHk1pTBAmaWOTLFE6+ct3D0upDAN4A=;
        b=D15CibbgQ4UWBbMRUIr+SgoyCZeu3nNaTQyXQndHI0S4qhANPv44JiZTFCfkKYkqI+
         M/PjCPu8gqPspwMCunq5lP9MlS6Ry4QyVb5UY70EwNXhuTAxUryqP+OLLfBmVrCbKw1Q
         QP48YXaZYX4hXMxMOqAxbXtE8FyxQfENiwJZpJLB0svR/QPPqvYO8Y5XQfzegdQFdRIu
         G8SGKm6BtmTuAIj+OdZY8+gQ/GMTrNRcms19EuSGus4SXmEk0EB/0KYP/YpMgkasHJBE
         5JHx7G5LXeLbnx1OviuQpYbLqNyHp26rVXPAKOV3EhoMealY3wr7MtMBIUHdl75XeLeB
         0YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p3vEOU6uZ0CvqHHk1pTBAmaWOTLFE6+ct3D0upDAN4A=;
        b=TQs7Z+V5Ir0SVYYPkUyaxe0kR7JJcD+l+b73COoCD2FunGKuv9QIT2zyckSuF87Uno
         YPbXt5meTKskMuLrfkW/Ru0tFUYt4hlVSPYfURAe47A9yWnC8KS7CAW9gLmavYXmi7Vw
         UDpxaqD7xYCwzYFBPS2hTR/18uxRgXj6ByBT1sEQ10iwmfFvs3+qGe82TuoYvyQsTfJ0
         HWM3gKRWytTtycNRGfajXWQWIcBMRHNlPZWKJEnzz9swIGSUbJB1/N8ejdeAzRNiZB42
         F+JHc4jBXXrai+tysxZ/xL/npvtc2NM2SIY0rfaTbSG39jkcb2WHvKJnZ8KhDR05Y6QG
         kAJA==
X-Gm-Message-State: AN3rC/70Vbyev1Kqp27UQA9uZ0ApmIAPBDqMjQ1myOFszNqgAIzufQ2N
        eD01ODzvIHrQknIZ7/8=
X-Received: by 10.98.5.5 with SMTP id 5mr4495224pff.36.1493099977062;
        Mon, 24 Apr 2017 22:59:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id 133sm21222381pfv.127.2017.04.24.22.59.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 22:59:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 4/8] Specify explicitly where we parse timestamps
References: <cover.1492771484.git.johannes.schindelin@gmx.de>
        <cover.1493042239.git.johannes.schindelin@gmx.de>
        <d6c1709475927a55c5bb0e6ce9d0b6be20b05735.1493042239.git.johannes.schindelin@gmx.de>
Date:   Mon, 24 Apr 2017 22:59:35 -0700
In-Reply-To: <d6c1709475927a55c5bb0e6ce9d0b6be20b05735.1493042239.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 24 Apr 2017 15:58:05 +0200
        (CEST)")
Message-ID: <xmqqtw5duiwo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

oJohannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/pretty.c b/pretty.c
> index d0f86f5d85c..24fb0c79062 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -409,7 +409,7 @@ const char *show_ident_date(const struct ident_split *ident,
>  	long tz = 0;
>  
>  	if (ident->date_begin && ident->date_end)
> -		date = strtoul(ident->date_begin, NULL, 10);
> +		date = parse_timestamp(ident->date_begin, NULL, 10);
>  	if (date_overflows(date))
>  		date = 0;
>  	else {

Good.  We'd need to choose a different sentinel when we allow signed
timestamps, but that is outside the scope of this series.  

It would not hurt if we used a symbolic constant instead of 0 here
to save duplicated effort for future developers, though, and it is
in line with the spirit of this exact patch where it uses a more
specific function name to differentiate strtoul() used for times
from other uses of the same function.

In any case, I think another change to this section of the code made
later in another patch was where t4121 was broken in the previous
round, and it is good to see the breakage go.  As Peff was hinting,
we might want to revisit "should we substitute with a sentinel, or
make this a die?" decision, but discussing it is totally outside the
scope of this series.

