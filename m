Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C14101F803
	for <e@80x24.org>; Wed,  9 Jan 2019 15:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfAIPyp (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:54:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53918 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731016AbfAIPyp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:54:45 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so8173837wmb.3
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kw9vceyU0Bq75Dh5xDpSivqzMqaAj93qkYIpM/dVb9g=;
        b=Gdg2bfrlGoM08FqST1oselv9BSSSio9DaCqyNsf1srOFVrS8XnzZTSbL/TrN1OF00W
         a7bn8hM7LmC9Lt9UIA98c4VFUB3VIJ8GC20FkJnqsjeDsUtHOlZrJvPU1P7lIS7H5tO/
         cTK0ZXLgGKwp1TiE7OwwOP1Ks8nS778ocFERD0XBWfWfnNa+t5D21ITQzSxT2KPvItE+
         1aqdIiCUx8ZEkJk/bJTiUtuigy7iP5yX84ZuhWfcty2GGUGCnh/m4xV+Igjmd2hssLaF
         ICNdTfLtMgs/Gj8UoH0qQcPNZmXVSAngNFhU/eay/rKXValeEkBUEdces3sOS+6ar80s
         JYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kw9vceyU0Bq75Dh5xDpSivqzMqaAj93qkYIpM/dVb9g=;
        b=ovqh3SEUkiY9OihdQS/XiFj4OOvSghPVXmE7bKZrNpE/WhJXFU3Jhji8wZ9mGHEM2e
         K9xM+Z/wDkxr0dO3/SshXdLcmJuvvc2EE4q1krFBDjtLTkdvoEbVS4l15nfNHeyRPrP3
         tQRqLBg/oWadWFfbLUZ1vPjpehl0rp4GxGYzBQZM4p4mRk+eh0hgxNIYZHhbaSagmTyX
         h8ndDrk3kLt87+a6COx4RYoUuzFnji4nfNHI/8pvx0YroEFLohehVxoBMSwZFmVmXJpj
         sq4DoJowfK82554dyuuHluKsASsp3uH5J/EjKhXdwsixmWOfM3mhiDQhYzMhbEMyMP7M
         Xlhw==
X-Gm-Message-State: AJcUukd2UGpW5BCGDYVQ3WfUDBi3JAmcNp6MBVK66+Hw3Xu26KiL+757
        9Ey5c8CChfZYldga5rHhZm0=
X-Google-Smtp-Source: ALg8bN5f6GWeVUCDSPbDgdZLx4JXlF+5erDeZU3yFhu1++hFoi/TUoWtLiHudhQ0jU17OT5Qjh+orw==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr6024825wmg.78.1547049283861;
        Wed, 09 Jan 2019 07:54:43 -0800 (PST)
Received: from szeder.dev (x4db906b6.dyn.telefonica.de. [77.185.6.182])
        by smtp.gmail.com with ESMTPSA id d4sm66501224wrp.89.2019.01.09.07.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:54:43 -0800 (PST)
Date:   Wed, 9 Jan 2019 16:54:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 6/9] multi-pack-index: implement 'expire' verb
Message-ID: <20190109155441.GH4673@szeder.dev>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
 <pull.92.v3.git.gitgitgadget@gmail.com>
 <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 09, 2019 at 07:21:16AM -0800, Derrick Stolee via GitGitGadget wrote:
> The 'git multi-pack-index expire' command ...

The subject line could use a s/verb/subcommand/.

