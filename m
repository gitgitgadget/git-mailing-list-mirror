Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1111B1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeBAUu4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 15:50:56 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:42237 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbeBAUut (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 15:50:49 -0500
Received: by mail-yw0-f182.google.com with SMTP id u17so11513779ywg.9
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 12:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6t/bC/GRMvv6xUigIYA8AdfOi3no3B/iXRIXURKafRU=;
        b=E0InDs5+RauCgs/NNW9g2r8vhZVl13uxmP6ZqOgbkPXY5HrkR9Nd3ko9WaHYeoYjV4
         h0QKRbpmobsP2cMNG3Kv/qXHxGttnqox/IeIkzrFAywOIBkldP1rHRPd5qgmO8UPrq3a
         MrQtHxrFW2LmhNI9jZmCkHNc6SKI8PP2pNAs5LpPjKy6U3hXEaBiOTmWSwvDPwPw6Hfl
         mqDmsMnCCKlecSYbbxk+1ztJXEw+Xw9M9CrpMBZwi6AJX4VvP7z60VqGwEZ9haDVgVW9
         HLEFJWnRWR94oaIQRPbLNwocWwM2ExreoI3o7DGeE3ayEkn8Qu297myCb/WQSrEUyW+r
         1d7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6t/bC/GRMvv6xUigIYA8AdfOi3no3B/iXRIXURKafRU=;
        b=JrqfaYVAOiuXdBgxSoXL4rOm5DC/Vh9iOVP2hqkJHi1WyYFOy+oXi8/N2pLjj/DwIp
         H2wBpZIalz/du9vMgOeDYLewM140R6S0WJDT3nz5G3mR04xt57VX6K8tT+QmHPoljcY9
         f2s+vBv+DB8mWA+TlDk41RzvCBbko9YrzzBV1L0PFw4irb7BP0tAnZ1AvvIvUs3lojI/
         HvhysQkZLbOIlYGdEF2nKpnwR0OX/Wx4s0sFy1ep/3Z0dXgfrhFw9cWtI22RjSlM6PKu
         TiWRbgzki6CtPaBltACe1Iy+qZidNBmKXdpFD9s+ZDfbpAHLXN7GImEiNg2ka5TpohyL
         Op2A==
X-Gm-Message-State: AKwxytcci8WuPWG6wPLRr19+7jqMMlecSGwVmRsBCqIYyDmiLZFqp3p6
        kP/0G3UxzrCUbkN5nZR+sZu6TC6cH39QU42lQgdorayy
X-Google-Smtp-Source: AH8x224nzawNbl+oHBKtN6ppftz8Q+MfX2pwcOOHUAwtOS5/ff8pZ6EnvKAxt8m7858E8zCU+AI+U+KuP/7j7bESQMo=
X-Received: by 10.37.163.198 with SMTP id e64mr26093396ybi.438.1517518248765;
 Thu, 01 Feb 2018 12:50:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 1 Feb 2018 12:50:48 -0800 (PST)
In-Reply-To: <006101d39b9c$77e8b820$67ba2860$@nexbridge.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180103001828.205012-12-bmwill@google.com>
 <d9a15c0a-35f3-8e9c-ddf2-34420ac7555b@jeffhostetler.com> <CAGZ79kZpD6m=5YP0dNuM70Yce=PyxLO6qr6aVpHKa_S9iyACww@mail.gmail.com>
 <005801d39b95$2bbc7600$83356200$@nexbridge.com> <20180201200826.GC138727@google.com>
 <006101d39b9c$77e8b820$67ba2860$@nexbridge.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Feb 2018 12:50:48 -0800
Message-ID: <CAGZ79kY-95gL1cxOXx7+9OGd6SyRSqwZRYUNv-SCW8Kcn3ZFSw@mail.gmail.com>
Subject: Re: [PATCH 11/26] serve: introduce git-serve
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 1, 2018 at 12:37 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:

>> I think that it would be too much of a change to up to 1MB lines at the
>> moment so I'm planning on leaving it right where it is :)
>
> In for a kilo, in for a tonne. Once we're way up there, it's not a problem
> or much of a difference. :)

What benefit does a larger buffer have?

I outlined the negatives above (large static buffer, issues with
progress meter).

And it seems to me that Brandon wants to keep this series as small as possible
w.r.t. bait for endless discussions and only deliver innovation, that solves the
immediate needs. Are there issues with too small buffers? (Can you link to
the performance measurements or an analysis?)
