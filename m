Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D813F1F462
	for <e@80x24.org>; Fri, 24 May 2019 19:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391360AbfEXTLz (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 15:11:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47046 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbfEXTLy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 15:11:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id o11so920880pgm.13
        for <git@vger.kernel.org>; Fri, 24 May 2019 12:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkEhpvVyBP8BIrWoAYgcTe5JbjLX5VxRrZIOCZo3Zhw=;
        b=mQ0Kz6joGkqjyWe91rjg3Q+YEOStLrolpsOL3HPGZq4rQFNJA//lxLDTHoKwDEUXwg
         v5VtKDrAAYB4mTWUCganKgwj5jE+mkFez360TU+tq8xbaWy2iqKowOVr8TRCkJYG1Wzl
         YtPHHpeYAlTCVByaTSXvVwDbGZQ8uaumKjQgp5Sm6VdjeWMOlj6iaOPgFYZgZLTnGeBF
         PUWBadwTeFmOfHvwlUmC9GstxetW2KwC5NECNbeDXvtU5eS9shTZTSWD2oTsaQzyTOqg
         HAlu2B40SlhZ4aaJYEMWVeVcSbV96QFTZv3GyUEKL4z+Y2QUlOSuT2f3LVFzmxpDk5hq
         unjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkEhpvVyBP8BIrWoAYgcTe5JbjLX5VxRrZIOCZo3Zhw=;
        b=NJM/tWSWZ+2i1YYRLPkT5SQKCmUrp5Thq1X6ZRuD114T7TsqeACT/hdxz1Ct1s5pFa
         uJuZZAVARM+8ZDVo59wr+zcwuKN79aerMYtKRqZk9oXVR183ontBIfMEbVYYmFT/JkYc
         rOEyWySmih6Wfd7VmRcJL4yVBHY+v5kvkTjkm292w2xiR8UlGYAfzEWpf2K/pFHtr6dG
         TO+L7TLhnDh1n67RMhh/ONj0PTARVrAcougonXs6a91I9XSVATYX0o8s2gLO0b+7GUFr
         ecLXfvFgOUXWD/lry+1BDntR+BgxJhIq8yckF0EDL7YBQNa4lZczQRzy7zmkY1r5N0sy
         FwSg==
X-Gm-Message-State: APjAAAWlbayDBibeAsOwDoKZHCyRvx596c07rVeOJWf04coMjip/DGIJ
        y7iaHgEDF5UCHHmDAPJ5UP3sOPwd
X-Google-Smtp-Source: APXvYqx8n4o4gAVY4DgMXjO5DaC2uRsnSK6uX1mhs9sBHlspjijB+W1ymo9R1WlSOjjVXanmPR/ZFA==
X-Received: by 2002:a63:eb0d:: with SMTP id t13mr9987143pgh.37.1558725113640;
        Fri, 24 May 2019 12:11:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id o1sm8342207pfa.66.2019.05.24.12.11.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 12:11:52 -0700 (PDT)
Date:   Fri, 24 May 2019 12:11:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: send server options after command
Message-ID: <20190524191151.GA14606@google.com>
References: <20190522200822.176870-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522200822.176870-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> Currently, if any server options are specified during a protocol v2
> fetch, server options will be sent before "command=fetch". Write server
> options to the request buffer in send_fetch_request() so that the
> components of the request are sent in the correct order.
>
> The protocol documentation states that the command must come first. The
> Git server implementation in serve.c (see process_request() in that
> file) tolerates any order of command and capability, which is perhaps
> why we haven't noticed this. This was noticed when testing against a
> JGit server implementation, which follows the documentation in this
> regard.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oh, dear.  Thanks for fixing it.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

6e98305985 (clone: send server options when using protocol v2,
2019-04-12) is part of release candidates, but it looks like we caught
this in time to get the fix in before the release.

Should we add an interop test for this to t/interop/?

Thanks,
Jonathan
