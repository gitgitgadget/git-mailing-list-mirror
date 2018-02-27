Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2DF51F404
	for <e@80x24.org>; Tue, 27 Feb 2018 05:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeB0F5w (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 00:57:52 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:46976 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeB0F5u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 00:57:50 -0500
Received: by mail-io0-f194.google.com with SMTP id p78so19870785iod.13
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 21:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AvxBgfdvxF1W3vA5AZzk3vqyeKqeQXiW5GylF3bxWBc=;
        b=keuej1SiHskziRy5jV6Yspzr4q+7/XzCT0marzxgsKBG1euDGfqgbl0jlZGz23LQuj
         ASPNk1tQa9vzl2DbH1a7N9XHZmzibPyP0IbQjeH/J+ZfYvNpUfHVnTHLXSu6ZeeZq/Nc
         5Ve/H4q9Vc+qSJiIVXlorqb3DYiMfRwii2jJU4rdb41beib/F1QuNkrItTHVT/kKvDg/
         1zuTzGvQtIVN2+3ON1q/SD0o9uTK4h2nygxqtW3Yh3yNkDtnpyKONVz7zpFNr44pwhnk
         IcVfTDFN/52rsOi8CMg1PpjeYxwnKUiORQdeqV0tchJyLTxXBZsEii4RXY/JOemLdXIN
         2sfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AvxBgfdvxF1W3vA5AZzk3vqyeKqeQXiW5GylF3bxWBc=;
        b=hf6LKikRlINPBoUEStQHN1XBQelINdN9cFA8A+mtE0jZcWhQLjK0ZmzklDilA0nY5X
         Dc59WQTU+ZX7gJw0gMxwXcLhdCMnOQF1Q3R+y82fUowwgv8ddu9TgCcNHThno/QaCoSM
         efx7l+UkMc7O+zkAL0U6/GLSXUo2PCA+h1mRmsABGqGG2U6hQarjruA4Xc7IRV4/QdtT
         QBvS7cWJLAzlOv5g9n40Np0BFQG61EQtpIPBtrhnSAzejSM8OzScijQtCuAUZmcaKLPT
         S0s3Zh22k9cmtmNUXJpmmKT3IjpGqRN3p0BNAw8chmMN1esbC2uIQdLqjHfr+vs6VwOf
         gf/w==
X-Gm-Message-State: APf1xPDydeFrWSC6sezMPmklDLBSYTb9PbvsJozdum0NE5+qrsoyO9HU
        NXMd2111UlZpSMCmzLHRYQ4=
X-Google-Smtp-Source: AG47ELtRgfr/KQBTmdrIWDJvuhRBsxLkwzNvK3tRDDk7CV0fPN7a7dXe3LjRp7V6eOvUYYwiVfw6YA==
X-Received: by 10.107.157.146 with SMTP id g140mr14337856ioe.5.1519711070062;
        Mon, 26 Feb 2018 21:57:50 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id g69sm6560608ita.9.2018.02.26.21.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 21:57:49 -0800 (PST)
Date:   Mon, 26 Feb 2018 21:57:46 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 02/35] pkt-line: introduce struct packet_reader
Message-ID: <20180227055746.GC65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-3-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-3-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Sometimes it is advantageous to be able to peek the next packet line
> without consuming it (e.g. to be able to determine the protocol version
> a server is speaking).  In order to do that introduce 'struct
> packet_reader' which is an abstraction around the normal packet reading
> logic.  This enables a caller to be able to peek a single line at a time
> using 'packet_reader_peek()' and having a caller consume a line by
> calling 'packet_reader_read()'.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pkt-line.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  pkt-line.h | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)

I like it!

The questions and nits from
https://public-inbox.org/git/20180213004937.GB42272@aiede.svl.corp.google.com/
still apply.  In particular, the ownership of the buffers inside the
'struct packet_reader' is still unclear; could the packet_reader create
its own (strbuf) buffers so that the contract around them (who is allowed
to write to them; who is responsible for freeing them) is more obvious?

Thanks,
Jonathan
