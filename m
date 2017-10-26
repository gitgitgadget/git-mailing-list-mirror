Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96C55202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 20:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdJZUzN (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 16:55:13 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:57095 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbdJZUzM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 16:55:12 -0400
Received: by mail-io0-f178.google.com with SMTP id m81so8298380ioi.13
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyDZFGXP9wNFm7drxmqXiI2dkXQ/8WZfuG5ZUm6Mar4=;
        b=IYOvS+cDWFkVdu4W/3+Y6vqiQLzAYYR+0xACYbWKelIGmvCRytVZPQRyTN9QM/B8oj
         DXiwYilAVUhw3d+NKjmpFm6yuo3D3L2P/LvUTsXtDmCCEYzSNBaZoqT3ROUkqwwswfAf
         QOaDmFN3gZ76QkzAp9PG+tCi7JYoxLm9fXDh7f7oJxJI2MWevM/0xLtew6SMJeSSh2bv
         Qs7MgHycK9oKVx1AHWCE+lj4Ztx69oDS4tmybOc9+lW0sRiU6IJoLtjZLvRvvBHmOIMu
         2eXKl5PNTA2/Yk0J8EnUFlFc2Gu8orSKKWO6j2OjCtp7D1RzxcdQI2/4zqCalq0CKCta
         9+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyDZFGXP9wNFm7drxmqXiI2dkXQ/8WZfuG5ZUm6Mar4=;
        b=p8vtiHGy6UW6KmHIvPk+L473Ru13OOx3y6oqav83+YVtRrx1C2eOpppzUm3DrfQ4T0
         YfygrJVFr29YCNeXuEP+8bPgshg0SdfLpcBFTaAWiWfdYxU7IdkIJjpxoHAJTYnF3319
         BqxHAkTWJdsVcrsGsa0CV2dGsc3wzMESFkU4wOWavYaHnx3uyEPy63VGQlBLZiy8z2qS
         2YCl7G3gu3kbC933T4tikvBZS+9wg9ZFNDZ2jtYkw767haEzmGeHSHy0ZucCfH1p3z0k
         Xu/bScFUG0mtJUX2Ufn10SXV4077qkmFPpw3ypJGmV15+YYrz1g5tKxJWZPmIncClEsT
         JJnA==
X-Gm-Message-State: AMCzsaUwq/U7tJmR89avbN+ByPirSzn3y2of7V6GFGJ2FSrs/3FbhaNP
        XFGDmA8uuQSD8f9JxzAsuEjai7eu
X-Google-Smtp-Source: ABhQp+Qt4l9DgGzajYQHqy0RfZj0yk0CvcLilAxMd9R0j8ejmzCSMq7VQwL0RgMwJXWPFbXlQSlUSg==
X-Received: by 10.36.249.73 with SMTP id l70mr364648ith.70.1509051311945;
        Thu, 26 Oct 2017 13:55:11 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i81sm95657itb.7.2017.10.26.13.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Oct 2017 13:55:11 -0700 (PDT)
Date:   Thu, 26 Oct 2017 13:55:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tag: add tag.gpgSign config option to force all tags be
 GPG-signed
Message-ID: <20171026205509.2ydjd3bai2l6pqxi@aiede.mtv.corp.google.com>
References: <20171026195516.3354-1-tigran.mkrtchyan@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171026195516.3354-1-tigran.mkrtchyan@desy.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Tigran Mkrtchyan wrote:

> In some workflows we have no control on how git command is executed,
> however a signed tags are required.

Don't leave me hanging: this leaves me super curious.  Can you tell me
more about these workflows?

Thanks and hope that helps,
Jonathan
