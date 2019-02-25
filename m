Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51BBA20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBYUC3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:02:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42571 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:02:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so4973619pgl.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bf5dA/PodRpYMYU+a2JTwgxCHDbD0bmTUyuYb+VFHOY=;
        b=KGZng0BJBZIIdvpcfuxn0N1pnpp01+QSMano7u+VCBsB6ijdZxqUVQmlr/ZaWcnjFk
         aMyYHU4nGNG6d9Ccrd25WpADybplZZa6kO0NIL2AGqfGTGLaiQgyGPrUbwuvBSvsBCop
         XW4BYBWmVJMWCHX+LSUAND/RAX44XP74nvMwIcIG0Gt+02NIucwuJl7kdyQzHFgN0RFw
         yt8W5q5o5PZQMYf8l2iVM1BrEFw+BmEFVlkRWfRzfcE2S83J+qC4qFPc5B8U0xkYQ698
         TOuVOkcEQLPa+A3ayNfSkiadHg+k9NPDV9rjEuSIcCPCZtIJ4XgYv93IbCB0cH4aoU8O
         Hkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bf5dA/PodRpYMYU+a2JTwgxCHDbD0bmTUyuYb+VFHOY=;
        b=sy4bNwaj/ZMN0QbqbxuwrtebBR8n0zE+PnhimXTTHjaKo2ykDviOZLrJq81RRayBuN
         6qKaljrBkwIIj6/AiUtAvOzShcFW8tRGZGlsZt2Dw3PIpFB2WuI1uJUWKQpQUJRUpEKv
         ZcDVLoaWZF7BgeZy4hGJwvWMwtIm9T69F9qGGhrAIMrmtXlE8rqvp9sWRFfQ+Ae818oD
         9qURBLTDdltdCHDrV1uUe7GooqezTrNC8gaw5mvZXgmOfRxr17RtslAWxQeCCtNiR987
         aUGUfeU5eu7nU3wCIjz3VMk7oHhBzB0B9+Gt8ojLGmq5i79MfHxNw6NKiuTK6+cl6CKM
         iftQ==
X-Gm-Message-State: AHQUAuaTmW/C/WzctMPspSqxqRCeTT07WV40DJOsxfQENqdZW5dvdgce
        tuebMzbB1+capaS8hJxrai7ITL0O
X-Google-Smtp-Source: AHgI3Ibw8jvu+cUaQ2RbTe1o2Y8Z6rr9t2OnmGHUqnBGWVUkFtyNvI2+s4ud3dMregdvZElen2IyEA==
X-Received: by 2002:a63:29c9:: with SMTP id p192mr17615253pgp.176.1551124947830;
        Mon, 25 Feb 2019 12:02:27 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id d16sm12852448pgj.21.2019.02.25.12.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 12:02:27 -0800 (PST)
Date:   Mon, 25 Feb 2019 12:02:25 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] mingw: drop MakeMaker reference
Message-ID: <20190225200225.GA16965@google.com>
References: <pull.146.git.gitgitgadget@gmail.com>
 <061093e2f000829a560e7bcce1dc86cb6babbca5.1551122830.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061093e2f000829a560e7bcce1dc86cb6babbca5.1551122830.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 20d2a30f8ffe (Makefile: replace perl/Makefile.PL with simple make
> rules, 2017-12-10), Git stopped using MakeMaker. Therefore, that
> definition in the MINGW-specific section became useless.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)

Yay!

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Is there a way to automate checking for make variables that are set
but never used?

Thanks,
Jonathan
