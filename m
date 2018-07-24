Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C54208E8
	for <e@80x24.org>; Tue, 24 Jul 2018 21:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeGXXI1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 19:08:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34701 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeGXXI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 19:08:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id y5-v6so3814882pgv.1
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9YxsW0QomFqeWAouODr6JjiSD3fP7+6xGp30UQAfqo=;
        b=rQtKS6tfVo/1K/QS9KgpQF2f5QdaAscU1zxWkfPQabddLGuFP6VRlYl57kQZc/tYo0
         1Jqgv9ptQg1ScbBmK/dPClL/kJPecqgYsJvOPyxh3sDxdGJGX7ZwHlvGugWehCwua39Q
         3+Eksf4hj3QITCkS0P93Jx7zwAf/7q4eTtAGzh90G5xtz+PdvgReP/URig+AqsNBQs1I
         frXEhIIOR/Di5oyjiwB0SCj3oGOTxP4UKmTWhqbRsFEFR0HUkmQ0q5m6t9srIxQBZ2Ah
         Zvvp/ia1wCNXp5u/Un9Q+YhBK+Ge4RfNocGrTAeauWA/+v4Bfl+3MJC5vjX1KXPq/CZL
         E1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9YxsW0QomFqeWAouODr6JjiSD3fP7+6xGp30UQAfqo=;
        b=hn0criF5crA92QYI7gvlS6k9Of+etaQQRuoYpKg6l3H3hgwPUevVUMoIuJMxHUaxVu
         8QH/KVMgwdf2uMiVDQhLDNJkdMOJb3DAIVmhKfMc/wclC82d3ANpaZYycApTjr0HGvHg
         OxPQjkt6aIwIutbSpsIAw9bJn1hEE91mWPLSjV5NksJgvWFbFIq5hz4IqD0cCb01rV1M
         GeAmO1Ry1FRrcGgwb2yn5uBgPJPUoJWkpA95MPzwGEgN2dD+XEc0oCQpXAji2TvqrPc4
         Ctjz0cU+29JrL1bObtrLHsh50BK0nwNNiblHYpW2BwOlvFVdrywXg5lqv2i6xh0jaO4j
         LKgw==
X-Gm-Message-State: AOUpUlHsE573QWtaWJMxS4GpXAGCguwjNL/WQXAiQY1xQbYg5iQKm2CK
        SnsEL3NhxUyj9Oy4kV/sRN4=
X-Google-Smtp-Source: AAOMgpfy65kpY//1BwiyGcjWsajz+twpAnKHHED8hBzkXdjhtNwgFzgBvSQnJYNtHI8SN1reGdtVHQ==
X-Received: by 2002:a62:cc4d:: with SMTP id a74-v6mr19503534pfg.200.1532469596023;
        Tue, 24 Jul 2018 14:59:56 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 14-v6sm20738756pft.93.2018.07.24.14.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 14:59:55 -0700 (PDT)
Date:   Tue, 24 Jul 2018 14:59:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] remote-odb: un-inline function remote_odb_reinit
Message-ID: <20180724215953.GD136514@aiede.svl.corp.google.com>
References: <20180724215223.27516-1-dev+git@drbeat.li>
 <20180724215223.27516-3-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724215223.27516-3-dev+git@drbeat.li>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Beat Bolli wrote:

> When compiling under Apple LLVM version 9.1.0 (clang-902.0.39.2) with
> "make DEVELOPER=1 DEVOPTS=pedantic", the compiler says
>
>     remote-odb.c:87:2: error: static function 'remote_odb_do_init' is
>     used in an inline function with external linkage
>     [-Werror,-Wstatic-in-inline]
>
> Remove the inline specifier that would only make sense if
> remote_odb_reinit were defined in the header file. Moving it into the
> header is not possible because the called function remote_odb_do_init is
> static and thus not visible from the includers of the header.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  remote-odb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

What branch does this apply to?

[...]
> --- a/remote-odb.c
> +++ b/remote-odb.c
> @@ -82,7 +82,7 @@ static inline void remote_odb_init(void)
>  	remote_odb_do_init(0);
>  }
>  
> -inline void remote_odb_reinit(void)
> +void remote_odb_reinit(void)

This looks like an oversight in
https://public-inbox.org/git/20180713174959.16748-6-chriscool@tuxfamily.org/:
there isn't any reason for this function to be inline.

Christian, can you squash it in on your next reroll?

Thanks,
Jonathan
