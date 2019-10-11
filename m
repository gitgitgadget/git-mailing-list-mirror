Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7701F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbfJKRuQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 13:50:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53727 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKRuP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 13:50:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so11260766wmd.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sff7CQHXukZFLmZMFjM4DkeH0d2CeUEee3wKcUgjZvA=;
        b=XLqcYvq0ePYvfQLk8+2jXWT+Zf+EXgm92Jcrk6BCppyD6UwIDkiUYGfVN5NDk3Jrql
         JiF2IfTi4iCNSGaObcg7g3Pyucwu0Eb9KarFKx8ZcQ9F4E/2i9EgEWxeWwZgwphwCp/A
         7+GXEDAKnvD3li3lGA49MfLbBbDKA0xFzPIOtKNKjSGPAQ3gLPcgdbf62874Flkjw7rX
         8UMbHjvVyXpNrtEb+BwwtG5PX2mjvqAD8QqFCqWHqe0t5Qer519XzirM1OSagZHcAtFx
         hEc7MLYY4ICuXEPNgFYX17w/Gz/qBoeUuDoNJ+aWqDij0r237wao2ruHxi5tWopaCpeY
         RfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sff7CQHXukZFLmZMFjM4DkeH0d2CeUEee3wKcUgjZvA=;
        b=MijPhQhhFwx4N9+1NyRBVTxXb1LheP1hY5UF1b3uAENyUVhoyx5l1hjZvsow5sWlDc
         FTph67HmiEpC60TAEL0B3FlQT5v1h9fKDMgZbWoRsQ0BBB3ERgLlKU+bXrx0FdtpmnwT
         EluHz0ya28gM4VKfGkNFOSAzHQI2txrDR9dOA84+nMlZIKaYod4yOGE04FDdiQBtpfg3
         Xu1uXSpPM8666mpPsGTrQT4sXyMXQVhlWd/v9sZMUO8QASbd98pKyuci9yhmu7yvdXGD
         5a+uw9QbdWrVnQtfSvPqi2F6dfFdNI94I135/Cb2fiYlGkyOAUbd4EYxZEkLn9JU9XnZ
         MQPw==
X-Gm-Message-State: APjAAAWYMt1z6RMUai/bF9+Vfmzw3kVlZxOTM77/rw+5xKTK3GNrmtBN
        FbQKhclRwlLu4wKa5787lRo=
X-Google-Smtp-Source: APXvYqxvPqXrg0vwA+HfCNcWZ0vGaWKtf8dkd+jwhVkeSJrJIu5Ssr+4WG9+ZzVRXmZfHnLGeff7Ng==
X-Received: by 2002:a1c:9a43:: with SMTP id c64mr4112047wme.20.1570816213444;
        Fri, 11 Oct 2019 10:50:13 -0700 (PDT)
Received: from szeder.dev (x4db30d3a.dyn.telefonica.de. [77.179.13.58])
        by smtp.gmail.com with ESMTPSA id y1sm4081704wrw.6.2019.10.11.10.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 10:50:12 -0700 (PDT)
Date:   Fri, 11 Oct 2019 19:50:10 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v5] documentation: add tutorial for object walking
Message-ID: <20191011175010.GO29845@szeder.dev>
References: <20190806231952.39155-1-emilyshaffer@google.com>
 <20191010151932.2716-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010151932.2716-1-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 08:19:32AM -0700, Emily Shaffer wrote:
> diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
> new file mode 100644
> index 0000000000..7085f17072
> --- /dev/null
> +++ b/Documentation/MyFirstObjectWalk.txt
> @@ -0,0 +1,905 @@
> +My First Object Walk
> +======================

In our CI builds [1] Asciidoctor complains about the above line like
this:

  asciidoctor: WARNING: MyFirstObjectWalk.txt: line 2: unterminated example block

I have no idea what it is trying to say, but I suspect that it
complains about the length of that '=====' line not matching the
length of the previous title line.  I kicked off a build with the
'====' line shortened, and it did silence that warning, and the build
succeeded.

Note, however, that we recently had a patch [2] that argued that a
different header notation is better, at least for the Git User Manual.
I'm not sure whether that applies for this tutorial as well; just
mentioning it for consideration.


[1] https://travis-ci.org/git/git/jobs/596474664#L1192
[2] fd5b820d9c (user-manual.txt: change header notation, 2019-09-22)

