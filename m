Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E843B1F404
	for <e@80x24.org>; Wed, 29 Aug 2018 21:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeH3BJb (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 21:09:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41575 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeH3BJb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 21:09:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so4967547edd.8
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqcyWcLMs/c3dBExoxNUwvuJCGTlPUkTrnYMcr+XFqE=;
        b=NJGKKFprjQFHvcFmBHc9tJCt5XzDS1qt4TsFNHuUgbZEaNU13XzjvR1Xf96FFVDDLv
         lUQdeblUdJotaY4sUz2QyeB66Lk+JSUBqc5FoGZAmM8E6QPLqCgI6fN1A1O7L034oQ6j
         Tr5P3HW6bF8hA8U0n0nAckCDOnxL0OJP+zKUA8G07tqaEYIfz3IEmLDSSEkFTYLYerig
         49LuZkt050k5yG9yooYlbTJWKX7BIENYrhXnDZiMQca6sGy6vJDJvPt6Im/BFqkIaYOB
         2TYtTmMKgsAwei+OybuFtwMm07xs/n3ao2cKJDN14yc/MTLEFbpNdW7hbSQrxS4A9oiM
         UySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqcyWcLMs/c3dBExoxNUwvuJCGTlPUkTrnYMcr+XFqE=;
        b=AqeOSgKtlXQEJSmTQWxr3HGFijK4/OTL5XNsBqE6jZJXRf1K98tWUqs+q6IrNsC3J+
         dnDyK86MVwUuuj6+0vB+2AuZJJQOzqLwO7OqNSVwFkgK2abkc8sbM/Rzi45yux889H8R
         7/jRPmC44oW0PuQeYr0jbGai+olCZsQ9xIBeEGfVjnr9j0gTHfKYm4bsQIzwK4Q3BtKP
         jdwg4RRSj3gyGvdqw16OvQk1972G0woiRz0pdhGSa3+0XkEMD1VK8stzSb8RPlGX8wE8
         WP3ikEOIwEY2BDFzkh/oGS4daNsj6z/8KPF8+nqZ7qCcX56WOcOFusOvvjvWwBPPgyn7
         shcg==
X-Gm-Message-State: APzg51AF6ln02dPV4jmfV3mdMP2tEHZ+iRH6pg8ve7nx/xkX8MvYe3sk
        KGOv6Fju2c41b8PfFeT6Q68sWvur8NWryfKpORYptSd5
X-Google-Smtp-Source: ANB0VdbAwoRp1QmhwNFJhzoBF5FtB7WgPqGsACgbVWxKsqgFcGoEJWlV6WC8NDw2YwJQOhRJwJ0AYA3qH+8HHD+YIbQ=
X-Received: by 2002:a50:b603:: with SMTP id b3-v6mr9629650ede.181.1535577048567;
 Wed, 29 Aug 2018 14:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180807230637.247200-1-bmwill@google.com> <20180808223323.79989-1-bmwill@google.com>
 <20180808223323.79989-3-bmwill@google.com> <20180809212602.GA11342@sigill.intra.peff.net>
 <20180814180406.GA86804@google.com> <CAGZ79kaLXcTeeM9AKvXi7X8WMd+vcyCM5n-Nz2igHkGJdXbSfg@mail.gmail.com>
 <20180829052519.GA17253@sigill.intra.peff.net> <CAGZ79kZv4BjRq=kq_1UeT2Kn38OZwYFgnMsTe6X_WP41=hBtSQ@mail.gmail.com>
 <20180829210348.GA29880@sigill.intra.peff.net>
In-Reply-To: <20180829210348.GA29880@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 29 Aug 2018 14:10:37 -0700
Message-ID: <CAGZ79kYJTWROYSGjEbdVBsEAkWkNE4QVCiPVfuMf75d13fXN6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: munge paths to submodule git directories
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, that makes even the capitalized "CON" issues go away. It's not a
> one-to-one mapping, though ("foo-" and "foo_" map to the same entity).

foo_ would map to foo__, and foo- would map to something else.
(foo- as we do not rewrite dashes, yet?)

>
> If we want that, too, I think something like url-encoding is fine, with
> the caveat that we simply urlencode _more_ things (i.e., anything not in
> [a-z_]).

Yeah I think we need more than url encoding now.
