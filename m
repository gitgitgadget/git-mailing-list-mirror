Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364562013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbdBPAd7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:33:59 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:36912 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbdBPAd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:33:58 -0500
Received: by mail-it0-f49.google.com with SMTP id x75so7844869itb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=hsWx8A7DChtr2WegC4niLPwBgis+JB2nZe6uzzrWnE8=;
        b=rZsma2hnhl2ma3tQbHQ8p2EYn9TEsKCpmA6rPE3gYNDgjwey9gXkrORvoqGOEIXVzI
         QP6BE3V3oPWFFiTdpTJ/K7XDSlLWHFRPWW25E1a7IHkkNthAkiSTb8m2xF5pJcqNe7zR
         7mxaG0M4P8O7qOFqenNVos35pj9R/3Grvu5ZddlVxZIr0QCWTd/N39ZVsvr2Xj51Rs6N
         hAO4yEov1DA8tR4RWB53bs/+jZ75wzzrpKl1l1puvskxL9Tq/TEPJZvwA36TYc+h3qlc
         XkildxyzbW3oDVPaWA9puJU7jVUjAP5xBS/Gqwixll0yIW87yx8W2q3H/8yFvXA574P9
         JCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=hsWx8A7DChtr2WegC4niLPwBgis+JB2nZe6uzzrWnE8=;
        b=LImYqGGA8KAVwadasMg2OHjV/6bGFbXMpaBsgHT0cZptGONIf1OryOT5Csu3O4bgAj
         +h8SA6wDW+NBRwisbbLlUhNjTgoPBGCFgguuVN8aePz757FKsXSqq7xH5s19HP6XAyUr
         a3bv1vV5OP/2o8bHo+L0vAeBSSwE6V9poRZ3WssbiAK+VMqo3RI95dCTVHTJTRpiflqo
         zyoFNgDGIea8yBqNJO4QnZD7rfKM0SDHg8QvZkxWqtmVGHGNAZU80tye6sqrStTrmlVJ
         xrdEdM2uM0CBbRzgG/YHIyWzM/v5U7sZKcniSBbMaVc7nELA95ef01y40RoM8y29h8g3
         Tiqg==
X-Gm-Message-State: AMke39ltxUqnOxm0Hyt86Hpzkc3n6yuPwFkq61yZCS9hbPzzeYsK7PMY81TVs9g7gQKDmJ2UcsRqQXf+a5iySXvp
X-Received: by 10.107.3.160 with SMTP id e32mr21896ioi.52.1487205236947; Wed,
 15 Feb 2017 16:33:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 15 Feb 2017 16:33:56 -0800 (PST)
In-Reply-To: <20170215020851.awwddgprd7nsdbuv@genre.crustytoothpaste.net>
References: <20170215003423.20245-1-sbeller@google.com> <20170215003423.20245-15-sbeller@google.com>
 <20170215020851.awwddgprd7nsdbuv@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Feb 2017 16:33:56 -0800
Message-ID: <CAGZ79kbT2Gh70_OsE7d63pCxNSDb-RJBZmXsPKvkuRD9x__b9A@mail.gmail.com>
Subject: Re: [PATCH 14/14] builtin/checkout: add --recurse-submodules switch
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 6:08 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Tue, Feb 14, 2017 at 04:34:23PM -0800, Stefan Beller wrote:
>> +--[no-]recurse-submodules::
>> +     Using --recurse-submodules will update the content of all initialized
>> +     submodules according to the commit recorded in the superproject. If
>> +     local modifications in a submodule would be overwritten the checkout
>> +     will fail until `-f` is used. If nothing (or --no-recurse-submodules)
>
> I would say "unless" instead of "until".  "Until" implies an ongoing
> or repetitive action being interrupted, which isn't the case here.

eh, of course.
