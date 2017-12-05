Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DE720A40
	for <e@80x24.org>; Tue,  5 Dec 2017 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdLET5V (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 14:57:21 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44007 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751112AbdLET5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 14:57:19 -0500
Received: by mail-qt0-f181.google.com with SMTP id w10so3653310qtb.10
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 11:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JwCqbGAoclroGMU/+iLSp2QUKVlZe6BNoAeP5OMzVR8=;
        b=E4dr+8p2mUUTNk26oI7hCWvRwUvwK7X2Tz/BTYiUNRZhsgfKhKKh6tI7YVkNHsp9k6
         6IWR+xrVVJLEvchnmWJDpKH55FszJSQSwTeiXJOBa26/89w4xkd0EqH5RxAhPzrc4+LD
         m6wt/gRS4A7EE5Z9plLPSVirVIV3tPZUC8GeF7hzckweUHs5PUcn3u5BshKMn/RvX0Tm
         HyIGtwrjpnql/S4lbgiSWx9cMqv252FVwWpBVOwGOYkbOZoxRoEoUwlva8pAQ+HtDV7x
         6c1V3cXivXawYIHXFUMAS8aiNJEbluoFn5n2XYuUgMfu2Qrx5XUZ4IpcIXe11/orm3bL
         D+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JwCqbGAoclroGMU/+iLSp2QUKVlZe6BNoAeP5OMzVR8=;
        b=muth7oVYbweQ/n+sXwLew0thgm8+jHv2nKtoivLDc49C7RYQid3NGyDioeA5xLtn/4
         ne3bH5YWOjeWZmwVMQ/A98s/ra3KLhFKcpbG/ub2RkbrREfxNiSvlHV9gLTEyMUl4NMV
         h0GgAzJ3SvkTXyve7lnS+jWnQijm2OqDVW2/WuwABg6kHxU/yXNg37hkIrlcB4GuGacw
         qjIyZZtDAaaJ84zZR7xEz1jOvupkBKT1J9lf0FmG8nc+f/hTeIeyLCnrYmLTGmrcdmWB
         bj/TpLTNMumxUIpRZfAQWeLsP8vuNu0ED9SmrMb1/CRIkrPU8q3DEjGUoUMbHmKCFQRb
         0riQ==
X-Gm-Message-State: AKGB3mLj+FUdSv93qM2xk/E4FIGGI02vybZRmxM+/IgWeTucUc2iTtkL
        d8GSQC9g/W4Ei2ipBYdfamfO1SqgMBr3WaWqSX8kVw==
X-Google-Smtp-Source: AGs4zMZv1u7g6LGwaVB68SN1Bv0eVKGimuUrcXn56Vo8xqEYiv/nVYXAL0ho9sn7vnv0MkeKaHFFgu8YNjoPm+JBaUo=
X-Received: by 10.237.42.22 with SMTP id c22mr2637484qtd.162.1512503838872;
 Tue, 05 Dec 2017 11:57:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Tue, 5 Dec 2017 11:57:18 -0800 (PST)
In-Reply-To: <14e821d45e4ac2faea1f9023d43c43c4675672e7.1512168087.git.jonathantanmy@google.com>
References: <cover.1512168087.git.jonathantanmy@google.com> <14e821d45e4ac2faea1f9023d43c43c4675672e7.1512168087.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 5 Dec 2017 11:57:18 -0800
Message-ID: <CAGZ79kZgzWRSmXv0JOryhYKU7gnZw2DvEK7e7MXjv7MWCF6T7Q@mail.gmail.com>
Subject: Re: [WIP 1/2] submodule: refactor acquisition of superproject info
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 1, 2017 at 2:50 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  submodule.c | 76 +++++++++++++++++++++++++++++++++++++------------------------
>  submodule.h |  3 +++


This patch reads very similar to [1], which was a preparation part of the series
"[RFC PATCH 0/4] git-status reports relation to superproject"; there
we also need
the same information about the superproject. I'll take a closer look
and compare these
two patches if it turns out we want to go this way long term.

[1] https://public-inbox.org/git/20171108195509.7839-3-sbeller@google.com/
