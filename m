Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A010E202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 14:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbdGLOrK (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 10:47:10 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33936 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdGLOrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 10:47:09 -0400
Received: by mail-qt0-f180.google.com with SMTP id 32so14249785qtv.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 07:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mXH782mdaWhDa03piyK7t3Qg1U+scIo2JlJNa8q17H0=;
        b=Q3AruGWRukY2zGHuffikJKIuKvZKIFKiOa+wEYbzttkd9RaeQMLDla30X0ciCzrj6m
         Uo2lE/4WwdPr+xpfrhMMH7QTNm94R32Dc0Fw1tNn+tWjWGQLO7p4vwvWC7vce5OCENFO
         75wMYqzKUs2FjkG3hap/Q2kInUWS8j0SOqj5/ieZH9fXsdtSz3INgjA9mVPOxfFfpWOp
         BMV0qGgexVZh8cj8hFJKRQ0y+8PSlJMX7FXrun/egzyRzEA2R20SLFhXnMVjCSdYFej9
         IAGopW6LF95PFIkG2BuDEpXdxHAhQulrzMTGKHGF3r2v53BkNngIpf94xsfRljZqrhJL
         BeBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mXH782mdaWhDa03piyK7t3Qg1U+scIo2JlJNa8q17H0=;
        b=NSh+k2B3sxslc5pupn4OgnjvD/jREpUm/9jgfOP8USXcOgGof5MvRRHCxzxcokakeq
         7ZMn56oireqx0IdLv74UP8/SkpVYefYLyU01zd09PFLypCUQdzun5AeOPUxTYV1uAdlw
         eicCiJA+hWUgwUJ8F1RL5kIS0/EFhloaC0ZyDIfFV6vR4Fg4zcq+w1FDFkDwSF017ZPH
         kr0/UBPsTrsj09uSXf3E2ov3VWvbPLWO31PniFjsQFg9a3Ipy7VDQauwnldgGEAmLeAn
         DRK8BzT/mGTs/2mDn7Cgq2qTDYf5S5NKsY2zHy2UmmbL+3qq4+kHKIuOKdOQ4cn/ksRU
         3dTg==
X-Gm-Message-State: AIVw112BHrCBV1D+iPBwuqrtd61J2mR4xrDo2QSLtRAYBSlNgPcqHRQW
        4uR/qSj7ENsGYGz+MJACMyv2FzF0sg==
X-Received: by 10.237.46.99 with SMTP id j90mr7290106qtd.76.1499870828612;
 Wed, 12 Jul 2017 07:47:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Wed, 12 Jul 2017 07:47:08 -0700 (PDT)
In-Reply-To: <20170712134646.17179-1-bonzini@gnu.org>
References: <20170712134646.17179-1-bonzini@gnu.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 12 Jul 2017 16:47:08 +0200
Message-ID: <CAP8UFD0bwb+Zeqn8Xg24J_Z639NiT3Awjzstk6o_L-Q+Wh+c0g@mail.gmail.com>
Subject: Re: [PATCH 0/3] interpret-trailers: add --where, --if-exists, --if-missing
To:     Paolo Bonzini <bonzini@gnu.org>
Cc:     git <git@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 3:46 PM, Paolo Bonzini <bonzini@gnu.org> wrote:
>
> These options are useful to experiment with "git interpret-trailers"
> without having to tinker with .gitconfig.  It can also be useful in the
> oddball case where you want a different placement for the trailer.
>
> The case that stimulated the creation of the patches was configuring
>
>      trailer.signed-off-by.where = end
>
> and then wanting "--where before" when a patch author forgets his
> Signed-off-by and provides it in a separate email.

Maybe you could have used the following to temporarily override the config:

git -c trailer.signed-off-by.where=before interpret-trailers ...

But it could be helpful and more straightforward to provide the
options you implemented.

I am not sure also if --where should override both "trailer.where" and
"trailer.<token>.where", or if should just override the former.
