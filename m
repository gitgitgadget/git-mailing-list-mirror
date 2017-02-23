Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0631201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 00:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934361AbdBWA0T (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 19:26:19 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:36769 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932426AbdBWA0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 19:26:17 -0500
Received: by mail-it0-f54.google.com with SMTP id h10so148293827ith.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 16:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MEF65HXbXM1L7ZI37Op2BDfNK3EbBA8Q8/ftX3J9bFU=;
        b=EZSvsQKv0yov+iw0BqlijvcWsSJYnpNUNfXjDfijan1Rs+y+sFta9p07XXo5a49Bev
         XtyYW/hQlVvbo88htLLvFGurwBI/gn4Cu6k+fsDe51cumQiwLg0uEwAmo5qA41y7C3L0
         bkzxsn/Jf3mqYZMJICkMIAIAmdz+H0hXZqlsUlEjx+0wnJLGXr+zACr/CJ7UpzfYl/dG
         SvCLLRmpao8gyarKGEJG8mOuzjNK7QLDNDGYvaKIBNskNrl1bOb1KJ02FbTxMaWI2ZhQ
         pY/Prqt6lKFthETg7iniob4ECF85wurFEb81xsQ1bWZsaue/e6WGMroU463uSKjlufcx
         0BDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MEF65HXbXM1L7ZI37Op2BDfNK3EbBA8Q8/ftX3J9bFU=;
        b=S+aDUY66icMOHa26SCcM4vX9700bqEuEQ59r/GZKDRdLbswrBJdp76pB6Xq57i1ldV
         mTpbSzSE0Gx+/2UgHSBlPS3gc9TYLiDChWWpwdy4sLUN8aZZKehwxysCVcXgP7PBAcwH
         daX5WTlDIyCDNpGvUGmyrvSaJx1ByacIL7wDgOeINAsLDI3/KGzogtUSZnU3Wk8OgKu+
         3w0/9RuzlqPcYo+lbhBJPcv7ZpT3Vsu1zCa6s/LM7wvYCfQj3y9i5afDi7jAFnCquciW
         E5vVS7rTULJ4AswA3C7w9qPwSaaK3nVeZGFzRz9T8m2F2XOTzWvThZ9B+OOHb0OT+KLO
         3uhA==
X-Gm-Message-State: AMke39k7nrugokuUMhGLPYmNNB6fphO9e7r9iTcxZvydP5hCKaFhSlyRT/R0J1wSUAMNrEYH3uLc+c11Pdfn5Tfy
X-Received: by 10.36.65.4 with SMTP id x4mr1352301ita.69.1487809492235; Wed,
 22 Feb 2017 16:24:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Wed, 22 Feb 2017 16:24:51 -0800 (PST)
In-Reply-To: <F50FAF9C5F724A87B5424494262E1BAD@PhilipOakley>
References: <20170221231815.4123-1-sbeller@google.com> <F50FAF9C5F724A87B5424494262E1BAD@PhilipOakley>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 22 Feb 2017 16:24:51 -0800
Message-ID: <CAGZ79kYXyk=giuM6CnU=gnvkCw3aaVEn=WbJ6tjhn8kZumrmTA@mail.gmail.com>
Subject: Re: [PATCH] submodule init: warn about falling back to a local path
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Shawn Pearce <sop@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 7:01 AM, Philip Oakley <philipoakley@iee.org> wrote:
>
> Would a note in the user docs about the fallback you list above also be
> useful?

duh! yes it would! Will look at the documentation and reroll.
