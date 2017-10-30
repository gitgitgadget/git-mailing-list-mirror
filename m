Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75251FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752449AbdJ3QIX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:08:23 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:48880 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdJ3QIW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:08:22 -0400
Received: by mail-qt0-f174.google.com with SMTP id f8so17036672qta.5
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xpo/MuJz1hLxhPiFdDV3HrmA8A+hLoBDu/6O8VpejY4=;
        b=ltXcTNGkKr1VuKXi9qSwFtk8WVy6O5Uhj57yw2jFmvpGQg32Uiu4CFTVJWlXwPIwTu
         8FWdJdjsq1pBkOwawqMIFxK6BeXFASqjRhnfMOCeV1xxWeXLFko99ik9TKArMD14zolM
         DMTzoOjklBXrZWbEd2fubJ0o0efBWOBFUgKJXiqvcDeQirnQA3j3kwvMLvJkp0uA41Is
         mV2bGIvlDd5sVqQCAp3Grh3E6BoLdO7YCD308rkwOOl8dP52PR6U8ee/ALmeoUerrjzR
         +7NVc0NfsE524XjIo4SDPZ+nrAtCaAwMCA2ZDXsfuRcjTau6NPA4cg0AuKgJ9RrHYdpn
         vU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xpo/MuJz1hLxhPiFdDV3HrmA8A+hLoBDu/6O8VpejY4=;
        b=sJi9+ZdvRnrc1n7bd9wJq/FH6n+x9X+JdEZ3hrJDnMcr9IrODh0eeKkZnt4Pi1jMIg
         uRbvC6R4l7qvPjcxE1RU+mej10YflzqfaQK4xgvRlgYQidmSFlhjoK1KQ/soNOOus70n
         2UlVkyVtPA/HLMcVqkEFRSo/eePnKdSGrKIvaB0LFofAOiOVNpJv80fr2UeGDMTRdcED
         USFS9WvM8ATGwWuUvuoPZFCcpEIf5KhgpNEslHoIQmBeKtMkG7bHwUpdVoNpak6Bqd2C
         2GCcSl8W3yqugbOrS/yYKNNKfgSOl7TU9g40JU+IYcnvV+UW71RdpCc5xsTyYmp881hN
         2E+A==
X-Gm-Message-State: AMCzsaWO2+O+a9K1PDvE9wSVZOQ9nCEl7aE6ZuDoiZP7Op+GV6o+kcLW
        Rg7ZWgWjRQWSBWyOX0f635gcKGH5u59m5Pt2taFFNw==
X-Google-Smtp-Source: ABhQp+Ra5gt3+sbvNmgjULBxaO+G5C+85xBq22fMvGaTiD0RTasT+fkBhVKcjAv6Uf9LUTuyhu1+SeplE4ZBmBnKnmQ=
X-Received: by 10.237.53.137 with SMTP id c9mr15812485qte.125.1509379701601;
 Mon, 30 Oct 2017 09:08:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 09:08:20 -0700 (PDT)
In-Reply-To: <20171028181239.59458-2-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net> <20171028181239.59458-2-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 09:08:20 -0700
Message-ID: <CAGZ79kZdAvP5HWk4XqqUYdkorvEvoWYR32T3frrmnTXetU45Xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] setup: expose enumerated repo info
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 11:12 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> We enumerate several different items as part of struct
> repository_format, but then actually set up those values using the
> global variables we've initialized from them.  Instead, let's pass a
> pointer to the structure down to the code where we enumerate these
> values, so we can later on use those values directly to perform setup.
>
> This technique makes it easier for us to determine additional items
> about the repository format (such as the hash algorithm) and then use
> them for setup later on, without needing to add additional global
> variables.  We can't avoid using the existing global variables since
> they're intricately intertwined with how things work at the moment, but
> this improves things for the future.

yup. looks good to me.

Thanks,
Stefan
