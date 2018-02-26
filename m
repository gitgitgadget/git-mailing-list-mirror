Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62AC11F404
	for <e@80x24.org>; Mon, 26 Feb 2018 18:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBZSTt (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 13:19:49 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38696 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeBZSTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 13:19:46 -0500
Received: by mail-wr0-f195.google.com with SMTP id n7so22240300wrn.5
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 10:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p75Mj5hm6xpxHBCUediH9W0Pd+iHb8jhNfJdydhIx2I=;
        b=Zkc6LgpyvuKnRkAEOFamWUMVrHYgBM84YmaYonDU8jr8RYoLPfTTDEmnMnhhTw/sUv
         3CpybdkFD/ZEnhvzqg87vBtPDlua6FqvI3IqphpjKYuef+sbrmmOgn1JJeV3Tx8JIExc
         Vx5vhK/LDcnVDMLdoIsxQcqBi5UQTMb2CQHxtFDTEla/cSQKOdYCKtkuR4mAOzcaEswd
         IN99wqJbqebveB3ijGKuzdS/jUWu8w3OZXxa2krLPI5KRjpsnnGaIdb7uxpMapRdGd2Q
         BUkyZUNSNyOEhxsnvL/QyG18zeb47PCQa3ATzTXVkDsdj1L5c8x5/vN26AhR4QoiM1IG
         AVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p75Mj5hm6xpxHBCUediH9W0Pd+iHb8jhNfJdydhIx2I=;
        b=VNE6rk+9W9Mbpv0YPMHRu5aITuv5e+rFey0gOva9U20UVhqR06sxQ4TPGT3won6UBs
         HAyeJB9eMt2Jx9y8tFzpiLwFdt8jdwkZY21DQvbQYpORDksDmMFcCvCCTbOMcjsuDj2B
         9SelWKHe1/4QhpnTz/3YVhq0wLLdId7EI1pfkOIONRSmMu8qDAblmpveux5Rjh9xFe1r
         1UxPtyevzPNlEDJyQ4SWekRDU1GiNXHIvM9Aq0XflhNGrSTlnJ8rxyAzrxq6ckw82xcc
         rGuooHteG1D1KQekRObwru9DY55Y38WcfwyeHmVrAV9fiZm63o1qSgRjjYgyqOZZEdsY
         i7xg==
X-Gm-Message-State: APf1xPCIzHYfoG5iSC5RtegLnFAXvBIKaQJU0QngFtBwd9VROh7aMtAI
        f6efYn2n53H7jS/o4jl43F0=
X-Google-Smtp-Source: AH8x226/EKLJAnQnU8Uorpy6PLwhlDpVvBjm3Z9xR4SFz4qvkNTCyG3HiUgPxNXiYFjIs6wdTEhOUw==
X-Received: by 10.223.135.102 with SMTP id 35mr11063034wrz.53.1519669185228;
        Mon, 26 Feb 2018 10:19:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y145sm9300180wmd.43.2018.02.26.10.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 10:19:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, sunshine@sunshineco.com,
        bmwill@google.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 01/27] repository: introduce raw object store field
References: <20180221015430.96054-1-sbeller@google.com>
        <20180224004754.129721-1-sbeller@google.com>
        <20180224004754.129721-2-sbeller@google.com>
        <20180226093040.GA10479@ash>
Date:   Mon, 26 Feb 2018 10:19:44 -0800
In-Reply-To: <20180226093040.GA10479@ash> (Duy Nguyen's message of "Mon, 26
        Feb 2018 16:30:41 +0700")
Message-ID: <xmqqo9kbr4u7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> diff --git a/common-main.c b/common-main.c
> index 6a689007e7..a13ab981aa 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,6 +1,7 @@
>  #include "cache.h"
>  #include "exec_cmd.h"
>  #include "attr.h"
> +#include "repository.h"
>  
>  /*
>   * Many parts of Git have subprograms communicate via pipe, expect the
> @@ -32,6 +33,8 @@ int main(int argc, const char **argv)
>  	 */
>  	sanitize_stdfds();
>  
> +	init_the_repository();
> +
>  	git_setup_gettext();
> ...
> +void init_the_repository(void)
> +{
> +	the_repository = &the_repo;
> +	repo_pre_init(the_repository);
> +	the_repository->index = &the_index;
> +	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> +}

I see what you did here, and I like it.
