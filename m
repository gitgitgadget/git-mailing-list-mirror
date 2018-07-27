Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68E281F597
	for <e@80x24.org>; Fri, 27 Jul 2018 23:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbeG1BBs (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 21:01:48 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:43900 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388870AbeG1BBs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 21:01:48 -0400
Received: by mail-yw0-f196.google.com with SMTP id l189-v6so2468230ywb.10
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcQh2TOvbNx7+Bh/8VQyge7B+z4LMciuB5LMQZZoIlQ=;
        b=Tity3lIQq9zr25CKTkyMlKhl1zSJmkrK0KCnmjALkrczP2uf6d3HWGH9gmjtUYBrQy
         2ToYGYUUPeT+3od/lC6aLZxTSqmOzRZA5Th3v6/ia6egttzgnGxzNxc77Fz0UQZfLSec
         CNVC903T3dLcyftRvek2st1yidEDXzJIAsD8XYPP1xVuaca1CzgOfbNheErKOcZG+pOi
         js1sTOg/BKi5NebqzIZ9mhqGdl9woL4PT+mrEkcikUYEctOe2jkXcGoUA0b01JhvFBzd
         9aQRfsc54iXMiwqk/0OhZCwf1L7eSHFsmQzHbRDj8Vzr7Lkh3bpmiGlJ1j35J9ZkFbAe
         0RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcQh2TOvbNx7+Bh/8VQyge7B+z4LMciuB5LMQZZoIlQ=;
        b=RKgsFHsAS6vsrV4FJi/O32iwy3eHeJw66ZNq36o3iZBRWghb9UmB1mbSUCKVqiKmdx
         DwiPJpHAAyvFC2twMFisvrGzhJohcWci3Gu1tdqv0FvJV+LSIEihuJ5+Op63kUi3LpaQ
         7FHPZ3O2RNOHzgvQP9bDvuFwiCA9nJz+IQWf5RCmYTg5P5vW1wA4Gk9XPfDTlFlZ0aeR
         li9C75J2XGMu+ZBZYlBOrLkQy1CJFNiV1sme/2KT9ZZQPy6MlFUsElFXut9pD6dFUEeq
         cSfkcATl7BN+RHEW/NaBE5+VnDCYTZGAej8pU9FbUn23Eu4o3KVH/wyaz2+lj3rJT80P
         ihTQ==
X-Gm-Message-State: AOUpUlE14eF7wG0ECkqvb0na/Ab+EaW4Y73mlaM7rSz6Hic9O4Nzqo91
        nSbSEpFPUQdjOVfZZ8Rg+kSr5F1b3S65cX4GebEOVhD4ZiE=
X-Google-Smtp-Source: AAOMgpcGmLjtGlIZRsvg5z+pxlTxBwylSL14WikMVdjOMb8/2Vo5w8Sf3mzAH+tcOE/PtUJrLe5eelxMJny2tCIBQ5w=
X-Received: by 2002:a81:a9c4:: with SMTP id g187-v6mr4347173ywh.238.1532734657521;
 Fri, 27 Jul 2018 16:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAGZ79kaVS96_K-G-_hEnRecBS843tjn7=Am0xZQjZABCdC7L0A@mail.gmail.com>
 <20180727233606.179965-1-sbeller@google.com>
In-Reply-To: <20180727233606.179965-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 27 Jul 2018 16:37:26 -0700
Message-ID: <CAGZ79kawMESBLHRV6CN7QJVPgdxL_1-BJ3Wu+xAFdpJn5PbyRg@mail.gmail.com>
Subject: Re: [PATCH] config: fix case sensitive subsection names on writing
To:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I cc'd the wrong peff. Sorry about that.

On Fri, Jul 27, 2018 at 4:36 PM Stefan Beller <sbeller@google.com> wrote:
....
