Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251331F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPXGh (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:06:37 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:56234 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbeGPXGh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:06:37 -0400
Received: by mail-ua0-f202.google.com with SMTP id r19-v6so13992766ual.22
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yggDjfiaGVIpxXacFGhUoWG2fxLuoV5WcX6k7ZJk/9k=;
        b=IpTdqac1vnTR2bXr48IC4p9GSnSkMTklLsa+Wgf8T/S4toN2WYEH9f479RzxM2Yv/1
         7nfcMP/QGxg70/j/YYc3CUiJ7bKNjvHNcXnGI60AS1qHGOgy/60rR8a1boUV1IFioHm/
         jwnhs91Xn7JPIV62/yDbcELsP4AkTO5+b+NP4eZvC2sfgxkAwhyBVqgjz4aa7YlvdaNP
         QzRAuKhsHIIBr9Ug0foDuZB8draVFMz4hwREMaL99zX2fT8sTnZdvLAnrloTCmTcsESv
         nA+nRuor/iQUthY4jxI3/L8wY3RfR/r/C1uS6h9ylgY8KxOQdVEkDvAJPzlK285NPXGX
         MBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yggDjfiaGVIpxXacFGhUoWG2fxLuoV5WcX6k7ZJk/9k=;
        b=KEQeeCu3s1dWcpZ+lc0iet246hJpXs5ZgiI6IJZtexrn6BvBS6PVWMLSrmCwjuEhDE
         5TIF3Sp0Ep0oHlraLcg8Hk3rKAt29NwxuzNpfBC327PGX32MuLW2LRVnsP+8qdK37I3I
         0BxmCXF2qZzY5jJtImx9fMqsr0ZKRgH71JOjFPUiWEOUGUhxZPYnPqcet0NDo4lrjlz7
         +1pZ6VjnDI8sXbO+rQf9w5ibHQ57LG60BAPv1C9DLlOHmje/NgYqTyUSdDYrG5wslHaK
         qPMxbE4sAlfcqe7HzT5LmgTdSCS9OEt0E6buPR+myb+sZq27AZ/9q4yMbt9z1Vmx2dNL
         VKLQ==
X-Gm-Message-State: AOUpUlEbBtNuGZarWQ7ByUcAzxTyhXF2/WskpHzZoKHDPLtNGh92SUwM
        4+N4aS6CswhLO6l1N0tW8v3VWrrwqyhc4B+jF4mM
X-Google-Smtp-Source: AAOMgpfkmR+bSZhdkH83kU4dhtAmZ1w1Vh/LjDxG8FvnNr5PyeNigaILp9NHkZdQdltgVQL43yNRqHqbaPrCnw/k6J80
MIME-Version: 1.0
X-Received: by 2002:ab0:12e8:: with SMTP id o40-v6mr9884778uac.50.1531780627593;
 Mon, 16 Jul 2018 15:37:07 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:37:03 -0700
In-Reply-To: <cf4559e08c47adcaf4c938a325acf829a5759285.1531746011.git.gitgitgadget@gmail.com>
Message-Id: <20180716223703.252965-1-jonathantanmy@google.com>
References: <cf4559e08c47adcaf4c938a325acf829a5759285.1531746011.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.18.0.13.g5a7731b13
Subject: Re: [PATCH 07/16] commit-reach: move can_all_from_reach_with_flags
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  /* Remember to update object flag allocation in object.h */
> +#define REACHABLE       (1u<<15)
>  #define PARENT1		(1u<<16)
>  #define PARENT2		(1u<<17)
>  #define STALE		(1u<<18)

Update the object flag allocation in object.h.

> +int reachable(struct commit *from, int with_flag, int assign_flag,
> +	      time_t min_commit_date)

In this and previous patches: I think it's better to use "unsigned int"
as the data type for a flag, just like in clear_commit_marks().

Other than that, this and all previous patches look good.
