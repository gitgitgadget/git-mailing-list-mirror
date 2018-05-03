Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 589A3200B9
	for <e@80x24.org>; Thu,  3 May 2018 05:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbeECFF5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 01:05:57 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42905 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeECFFw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 01:05:52 -0400
Received: by mail-wr0-f196.google.com with SMTP id v5-v6so16121267wrf.9
        for <git@vger.kernel.org>; Wed, 02 May 2018 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+JNajKiwthDll63NL2jWxRW6SGfXcPZD6sHSf193ZLE=;
        b=GZtYWue28456MzojwQxptDO/+zpm0M2PlavXWHXTi/l50wTNbJ2PxJzQP0rETgVJpL
         AAOEwUZijusjw4LBKaL0j5Pzb0sEn09vHEkchy2Nx0ad5XBslX/GbN3zFzA1bjynSpeT
         sufwjBunCI3P7pXCI35Spji6tzreJIIabBOcYa1nmCeF5mAwlasRsUXxzgr/lOnRkgFa
         9NncznFYBZnrD+MlGL2KNFGV4Ld923oW7uHTvgvEZKOcxNIEbW+ktBBjkzw7dMGvdCR7
         xarVqHqnPxH4JG71cB/MaMAy9gDpCWvP2kLwvYOVOtDAGdz92rY+FlLjIMIRp7boQQf3
         Th9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+JNajKiwthDll63NL2jWxRW6SGfXcPZD6sHSf193ZLE=;
        b=JIOKJMD5NzguVAzG5Or6/i2FyR7CCQ34qjQYUTAtJh1YibE6XApLYWiu4gWNMVNsm8
         O6CrLaJEnDcRu/ImVSDg+WWzvROsuBpMz/Nkrn+mETzTlVxV+o8rdy6Jdw4t1uX7SNcc
         GiyMHClnjD8F5I6lquVESeJvtCg30THyEBjcAYwXMJUZXHw+YFGWaOu+X9qYe4fnpY4L
         oB39t9Iy+cqG7QIzc/POkU1PpPaajKbedsgAYTjXVb7aA+eHjuC1NX4fOpGa0S4GYq3h
         7nLfGFP2TPP/iPXft3Qg1n+2i9OIm0il+3/LWNpS+kOmfxlU0yWR1v7tH5v1Snz4sDuc
         Njng==
X-Gm-Message-State: ALQs6tDJrhu16sJ9cfmwCsSMSEj5Xij73FtIM2lIdfnqRrGyBuneeVRy
        nnvS25bNf8/IjCfrB4jf4S0=
X-Google-Smtp-Source: AB8JxZrW/up3swBwexwPF84raXpfAE5cA+KrwkC1MDBRFHxEmYYm4xS7yXfGN3cQilgbCvnrrejYQQ==
X-Received: by 2002:adf:9658:: with SMTP id c24-v6mr15498014wra.190.1525323951191;
        Wed, 02 May 2018 22:05:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 39-v6sm21282372wry.89.2018.05.02.22.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 22:05:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 04/12] cache.h: add comment explaining the order in object_type
References: <20180501184016.15061-1-avarab@gmail.com>
        <20180501120651.15886-1-avarab@gmail.com>
        <20180501184016.15061-5-avarab@gmail.com>
Date:   Thu, 03 May 2018 14:05:49 +0900
In-Reply-To: <20180501184016.15061-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 1 May 2018 18:40:08 +0000")
Message-ID: <xmqq8t91uy4y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> The order in the enum might seem arbitrary, and isn't explained by
> 72518e9c26 ("more lightweight revalidation while reusing deflated
> stream in packing", 2006-09-03) which added it.
>
> Derrick Stolee suggested that it's ordered topologically in
> that as a comment.
> 5f8b1ec1-258d-1acc-133e-a7c248b4083e@gmail.com. Makes sense to me, add

When referring to a message-id, please do not omit surrounding <>,
which is part of the message-id string.  That's like writing your
e-mail address as avarab gmail.com without at sign.

>  enum object_type {
>  	OBJ_BAD = -1,
>  	OBJ_NONE = 0,
> +	/*
> +	 * Why have our our "real" object types in this order? They're
> +	 * ordered topologically:
> +	 *
> +	 * tag(4)    -> commit(1), tree(2), blob(3)
> +	 * commit(1) -> tree(2)
> +	 * tree(2)   -> blob(3)
> +	 */

I am not sure if the above makes sense at all in explaining tag.
With all others, type with smaller type id can refer to another type
that is with equal or larger type id (tree can refer to another
tree).  If tag had the smallest ID among all, it would have made
sense, though.

Before anybody confused raises noise, a gitlink records a commit in
a tree, which may seem to contradict the rule even more, but it
merely records a commit, without "referring" to it in the same sense
as other reference that require connectivity.

>  	OBJ_COMMIT = 1,
>  	OBJ_TREE = 2,
>  	OBJ_BLOB = 3,
