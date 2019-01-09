Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72FBE1F803
	for <e@80x24.org>; Wed,  9 Jan 2019 18:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfAISGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 13:06:40 -0500
Received: from mail-it1-f202.google.com ([209.85.166.202]:54273 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfAISGk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 13:06:40 -0500
Received: by mail-it1-f202.google.com with SMTP id v3so6965910itf.4
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sptQqgqHjUTFK07GWES3lblGIoCPypiR1aawy6Yg45A=;
        b=fVljDTKAX40tCYzbyFO8M3vJP0PgSDH6yWAnUWBWsXRatmFUSjCQugZs1PZ4h/lgwm
         ioocZ9FPJFenHM2EhzdhkHr9Of1U/cLhjb4hHTQImCYliI8O6e3LhhYLbWTRkRBHB/sd
         j6+O4ewK27ucE/lGI59l9Niv8sSrisjmqOALuL1aKnGfNgLud5EJc8w3a+wJSUFOdcTG
         gHzn/OjF2Pi5e1QwRwSg5a6HpeyfI01uhfdECTLHbTqexTUrAv3/WsBGVJDIdjVdAAdJ
         MBdUoltoLfCdEcphOT15pHBtxUlZYj26JfhiN27Tp8ch3HdkDfohKFZ5yqETshIwU2az
         TaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sptQqgqHjUTFK07GWES3lblGIoCPypiR1aawy6Yg45A=;
        b=dPqnTctU8pKXWlIjoqeQ50Q/rI2xe4S+A0xneFDXzwJlHL+KOOfTTnwVyL9+9NmWLi
         FbuP+A4j4XsBbLMTxMgK2GUmO6Itfhy8CX+TYIsvDc1VYeGmtY40c4Bv5dJeLeuhJpkN
         hkiRKRBxv7NblAv+cKDHzaW0fVuXlwsR6EfZjtXc/iJwpIx5ol0XbdT73u12GB4RPiDI
         ag2mrkqkhha4winfCXR2jvn25hiFuS9hd1VlZv1sdV67oaZocAKIpWRQFcQu5czQJVC2
         8cdLvQMsmRs3L7mXcX169Wa8Gjr6dUFQqWI8A4bNbgs7cz3rRZuEw/0QL5QH/JsLZgB3
         T0eQ==
X-Gm-Message-State: AJcUuke4lgELHwY8LhmjhVsPJSQPNJHtpwxUXvdzGlJRdn0NalupABOI
        JQi1imhMbNUCFO+A7OzfnUaTM6dQ4UzR8ScA+MSF
X-Google-Smtp-Source: ALg8bN4cyhrFE2zNZn3tryZZmUIh/ch0WjFwFPeEuy1q2O8Ef1cE1xeN71S9CuyGynB83s6ovx99FjlYW0pZQcldM5dw
X-Received: by 2002:a24:5603:: with SMTP id o3mr1280472itb.15.1547057199170;
 Wed, 09 Jan 2019 10:06:39 -0800 (PST)
Date:   Wed,  9 Jan 2019 10:06:33 -0800
In-Reply-To: <20190109025914.247473-1-matvore@google.com>
Message-Id: <20190109180633.10273-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190109025914.247473-1-matvore@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 0/2] support for filtering trees and blobs based on depth
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This applies suggestions from Jonathan Tan and Junio. These are mostly
> stylistic and readability changes, although there is also an added test case
> in t/t6112-rev-list-filters-objects.sh which checks for the scenario when
> filtering which would exclude a blob, but the blob is given on the command
> line.
> 
> This has been rebased onto master, while the prior version was based on next.
> 
> Thank you,

Thanks, these 2 patches are Reviewed-by: me.

Your approach in the 2nd patch makes more sense, and I checked that both
oidset_insert() and oidset_remove() return 1 when the element in
question was in the set (prior to invocation of the function), so that
works.
