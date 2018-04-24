Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D061F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbeDXSPj (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:15:39 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:38575 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXSPi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:15:38 -0400
Received: by mail-pf0-f178.google.com with SMTP id o76so8233041pfi.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pMYJWrryuZaSRiCt2JJ69dGgSJiGRu9QuM2Lz5jQ2yQ=;
        b=cFpaElv1A4isx0zQFgByONyTf4Hx5nuiFNa9Wk5/KykzS/l5VX8DXySwkv1eVdQNpD
         TOmxev8c0YhWLmQcsEmHY8iqUBuIPzXaEyy4g7oqyjGOaMKz+oKWO5muY4xJykTFlX4G
         FOTyp3jyYRsJqpafCh6xHK+J7eVvhSQ2g7IpK5cYVg6L0ZmhtC9Lt51zxq0oK7zzle9C
         jVvcGxWzKBY3Nd2ii1pXww6yfAyr06VLG0AQttVrCyxezPHzBUppKsMmrX0AT2wKbmsx
         09y6isPvtUl/w4wb7IgoU7hpCS8XXe9S/dMqLAgMNRTMHMt96jDTIw9WJUA3rWS9rw6a
         KE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pMYJWrryuZaSRiCt2JJ69dGgSJiGRu9QuM2Lz5jQ2yQ=;
        b=Sc246Uq9/LkCzRZVtZhS2e3e17Rd1bpYNV4c35t2U1dvilKkoNfBgc7epVgcbaksdB
         wRhLkiLC72MGGDQeOnoq3DjH4YS22s5jDaLD8aKWkoU8TCqxcanfZz8qxwD9Agx8A+bb
         vIlkPFs0nZ2piPNVszsPItB6S+5AQvhyFeB9BcTE45XAx2wk5yjeIJiovxz0pK9otk8Q
         0Yac4W4Ls+rkHMpwV08oPudQNZz78HWTS9Sr5piIiSks0ASFT2V+pxUBlYLz2YiKr9Iq
         wybg7+dJHl/2zhE5Z+kSdHzWJfqyHqB78/RrmKlGIv52BCcFAHnC9uedfcpSWAxFIOCF
         tSCA==
X-Gm-Message-State: ALQs6tBIFEwarTqnOTAN0PoE4bRj2tggY/LruJxyRETqaPqp0eQXXcYD
        GxV6cKCTYYHDusEz92YDbhyOKlre8uU=
X-Google-Smtp-Source: AIpwx49TotU6eYp35iMdk8zVMxN7WAnt0jJDz9MF1FyvmIWW4RuE1uqrpnm9+BydIlOQi3afOfFq5A==
X-Received: by 10.98.201.137 with SMTP id l9mr24333414pfk.221.1524593737870;
        Tue, 24 Apr 2018 11:15:37 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id z27sm1581893pfi.33.2018.04.24.11.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 11:15:36 -0700 (PDT)
Date:   Tue, 24 Apr 2018 11:15:35 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] cache.h: add repository argument to oid_object_info
Message-Id: <20180424111535.67beac25e0d342b15804896d@google.com>
In-Reply-To: <20180423234327.250484-3-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
        <20180423234327.250484-3-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Apr 2018 16:43:20 -0700
Stefan Beller <sbeller@google.com> wrote:

> Add a repository argument to allow the callers of oid_object_info
> to be more specific about which repository to handle. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.

From here...

> In the expanded macro the identifier `the_repository` is not actually used,
> so the compiler does not catch if the repository.h header is not included
> at the call site. call sites needing that #include were identified by
> changing the macro to definition to
> 
>       #define sha1_object_info(r, sha1, size) \
>           (r, sha1_object_info_##r(sha1, size)).
> 
> This produces a compiler warning about the left hand side of the comma
> operator being unused, which can be suppressed using -Wno-unused-value.
> 
> To avoid breaking bisection, do not include this trick in the patch.

...until here: I don't think this explanation is necessary - this macro
trick is temporary anyway in all our patch sets. Also, wouldn't
repository.h be needed anyway if we reference "struct repository"?

I would replace this section with the "As with the previous commits"
explanation you have in PATCH 3/9 and others.
