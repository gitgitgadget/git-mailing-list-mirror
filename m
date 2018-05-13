Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0331F406
	for <e@80x24.org>; Sun, 13 May 2018 02:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeEMCDy (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 22:03:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55105 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbeEMCDx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 22:03:53 -0400
Received: by mail-wm0-f68.google.com with SMTP id f6-v6so7988312wmc.4
        for <git@vger.kernel.org>; Sat, 12 May 2018 19:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QnpHUU0B/evgdibBSWw35t6yyTGUkSTGmxl0b1zLwvE=;
        b=OmSdpPLTNRq2ejdE5PIXmO+PQ7dVaHh4v8Ch7HOnN0ldu/bJLbkrMn5NLMmMkDZURE
         Mw5DI5/bo9YMHtmB8HZhbuLoa5AIHxROpvOvGhKD4WyBKiHiulzXvoPAYn6Mvk6vDsUK
         Lc0xy9LWnpDiGgC+Hf/IRI2GI5MoE31G68gB93FCG6IXM9+Y2tIC5KDMQLm4xCG+aCVZ
         xdmZPfMWLONaH/ZXUude3Kbv0G6xTVB/oRz/5m4TobgjVOZBnQN8B342t06WrCdwDxsF
         9W36s/1XBJ9V3cFpSZvpJh9LUJbuzVkmONT4UthQOX3440nHcwG74Bq5p3RSAz9irqeB
         ob6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QnpHUU0B/evgdibBSWw35t6yyTGUkSTGmxl0b1zLwvE=;
        b=J4PhikNDH8mPsPT/CeTRdbva/sY8yeLa+J3UryI+nXt4Yzy0Z164RSqA+PFph+A736
         Y8iAP6CCbi46/0irODzHq+iO318lnC+SiF3Du60fdg0c6PpDSMCusyEgB42cIfsn8Jrs
         FKfj9qDnEPJprPTph+HxlTs2pyYkEfmcvad4MqGun3GbCszi8GcuZ/s2F2LcaxX4NFTK
         3AvXzPIpDkUZgSeli/eL4eqQJV+uLWbpPeOZAU1C+R35gH1c6nyANJYgN4eLevJRwiGA
         Qiu5uNQvlKpT6YCpS9b/Jc3wIv+FgITQqCx7GPqBdSoNS4luy4OJMLo+JloQfYo6W2QY
         UwhQ==
X-Gm-Message-State: ALKqPwcWB/4ddnP5u2rKYd+EmZI6Z8EqruY0Wyl1FI6+vDh59boxV3O/
        f0z7CiHtjUTkGEeBgs3YR60=
X-Google-Smtp-Source: AB8JxZqziED2NSM6ACrpUe9jVscc1liySaf0jYa+PpRtS69qrIurfKL1GXEXKQZ8uqWdI9kMNjhBQw==
X-Received: by 2002:a1c:41c1:: with SMTP id o184-v6mr2191671wma.127.1526177031836;
        Sat, 12 May 2018 19:03:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w5-v6sm4844207wmd.26.2018.05.12.19.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 May 2018 19:03:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit.h: rearrange 'index' to shrink struct commit
References: <20180511172054.7684-1-pclouds@gmail.com>
Date:   Sun, 13 May 2018 11:03:49 +0900
In-Reply-To: <20180511172054.7684-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Fri, 11 May 2018 19:20:54 +0200")
Message-ID: <xmqqmux4e2gq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> On linux 64-bit architecture, pahole finds that there's a 4 bytes
> padding after 'index'. Moving it to the end reduces this struct's size
> from 72 to 64 bytes (because of another 4 bytes padding after
> graph_pos). On linux 32-bit, the struct size remains 52 bytes like
> before.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  commit.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/commit.h b/commit.h
> index e57ae4b583..fd1cbe7263 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -19,11 +19,11 @@ struct commit_list {
>  struct commit {
>  	struct object object;
>  	void *util;
> -	unsigned int index;
>  	timestamp_t date;
>  	struct commit_list *parents;
>  	struct tree *tree;
>  	uint32_t graph_pos;
> +	unsigned int index;
>  };
>  
>  extern int save_commit_buffer;

Quite nice.
