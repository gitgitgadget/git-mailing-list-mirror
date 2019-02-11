Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5DC61F453
	for <e@80x24.org>; Mon, 11 Feb 2019 23:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfBKX64 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 18:58:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfBKX64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 18:58:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so330339pgq.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 15:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wIL+y1tgFuP4ZBIDP/MfAGf4Yu8MAv2GHi/pBQ71oQ=;
        b=hHhq4b51RIXKlxyr5eK+8BGjqbhz9qWO9YoYIXVz+DMyDmTUlNBs1gIPaqueBX9oi9
         qvwn/Xp5ujQIiwcgO6mic3L8g80e0zubNd/ASE5KPcVRlhc9Vy3MHNyaCyh0N5e/M7BN
         tjuAoC2SNCfaxx02sPVfz3hfDRaULWcgkj1efCsOlTjyj/3HfHD/Bb+7NGNeXYpeVQ2o
         QEAaaWd21pnu78QjeiHo/a4V1zv4+qY2xHSVDaqCMS0P1vtFTfKv2zZ8gUphrWrGv4zO
         IlLRkUc+1KnYoWNgnjjfLqEMnyvdZ9lSSAygLnbEYyITbuN6ibMosKHyKM9aT2zAskX+
         p+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wIL+y1tgFuP4ZBIDP/MfAGf4Yu8MAv2GHi/pBQ71oQ=;
        b=WDe5iPdeAwrq66AB3aDNcPBGjkUu8uoQHFsCSjbz9o6iOwzxoNCusXycP5Qb09/IJR
         OHbvPeuijV3mhrTKw+/N7IcqFiuW2M33iWAwQp3gttbXFYAFDsrMDurXzsA55CQVSCTR
         PPYnO9gbzbYJHemrHhFl5K0jHdPnXqni2fDwdl5wq5L+rP6zQpXi5mOjHojza95fF50r
         ngffuM+vjDANsLo7ZB+uRxY8Jn06w7lSn1qAi1tyAkbmVId/Bl1xoxtjBrAhxGvzNNi9
         nSltnogsd9LkuWI5qpoNR6goXFOmhrD/KGnnuOJjDUSBqi88I2rSngRP9g9ZkASm/fyd
         oUkg==
X-Gm-Message-State: AHQUAuYh3cKEIzHR0Of/QHTbLY+RdyyPdnHyUXLqdqdoH4H8lx/l+zx2
        qFUvYAT3xh4s0cl5gXtN/TlolI4k
X-Google-Smtp-Source: AHgI3IbLqbG4IQUrCZRpwtHQQmEOReH86C+jx3xQz63h+f69SvPGL2o8R301j9wxD/pQUJj+Am6cxQ==
X-Received: by 2002:a63:480c:: with SMTP id v12mr853774pga.115.1549929535197;
        Mon, 11 Feb 2019 15:58:55 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 86sm18894357pfk.157.2019.02.11.15.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 15:58:54 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:58:53 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] protocol-capabilities.txt: document symref
Message-ID: <20190211235853.GA8714@google.com>
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> In 7171d8c15f ("upload-pack: send symbolic ref information as
> capability"), we added a symref capability to the pack protocol, but it
> was never documented. Adapt the patch notes from that commit and add
> them to the capabilities documentation.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/protocol-capabilities.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
