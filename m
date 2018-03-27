Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 317C41F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752299AbeC0XEs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:04:48 -0400
Received: from mail-pl0-f46.google.com ([209.85.160.46]:42421 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeC0XEr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:04:47 -0400
Received: by mail-pl0-f46.google.com with SMTP id g20-v6so367416plo.9
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+AwBzo9ppn1Tce3TUZvXmGpMwOiEUNUCOlURrKOxvd4=;
        b=k09YIG7w/y4VIl2W1P9BmNlcGKZxFMGzcuJyNxgPkHjVT82oJh3UVjq64K4GQSsBs6
         phjBI41oGMWjJCMSgtxY3obZ0+atiQUCg8J3Vuzlb/bE3a8WK8JIsZxzctkg+wofbZ43
         Rb+LgfJIvHK6WOkUKHYZ+WOt7QHLVkzBUX80PBptx+DxyAz8Nvt/KKw8ghyovgrW25+l
         PCHXXWUGYKXyh4XBYvnehwJdAIBXFhkYKimHB4aJFMvdUwgLqzeggrsoyXxfCB0FRH6Q
         icnpyoburCfdnY1POv4wevSGkhnDDWOo0EQUPtBt/pOWYF9d27C3Ocw9lRt4V4ysPNwA
         39Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+AwBzo9ppn1Tce3TUZvXmGpMwOiEUNUCOlURrKOxvd4=;
        b=TSsCNpwwjyxWhWnd7Cia965kX/ND4wYgugOdFFBssEvWiCStVbUYmWmffYaEjnQj91
         G7PEIglH1A05SO8fxYvNiSnm7+QEyf/HjdJesOF+62rDFTGzCu+n2YX2MLBmHMMDYXkP
         TYnJKH+mGjhu3e4MyvnQyi5LSemxs5GaXzEWG1gyrjdBK5ZVfb+ls0clYX8H0qdNOMnh
         K30iizjVzHyNG3eZZqoHjsl1vhmFDTiuxwAnPSUnoaze4L/dlIYi35tQH9zfR0R9KzGO
         SIQuFXnvWzkQKI9ZJP9LUmK3781qd7ez0J7aEOdRuhoQPxDCW04zZpkhGOOPCZzLKk+O
         qtDg==
X-Gm-Message-State: AElRT7HgYhePSiN38DQWRgQCiVv6pOvZN7sKsU8KD+GTmsuRxm0KJhcU
        SGtK24tQ7E54O3C6waSKMf4Kvg==
X-Google-Smtp-Source: AIpwx4/urZjlLpp1FPlpfNYz/MbCswf2djp4NQwnOHYmm0n+dybLhLXD3pUVziMmnZ07FR+C7MaLHg==
X-Received: by 2002:a17:902:6bc1:: with SMTP id m1-v6mr1209388plt.239.1522191885569;
        Tue, 27 Mar 2018 16:04:45 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 81sm5207424pfl.92.2018.03.27.16.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 16:04:44 -0700 (PDT)
Date:   Tue, 27 Mar 2018 16:04:43 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, seanwbehan@riseup.net, bmwill@google.com,
        hvoigt@hvoigt.net
Subject: Re: [PATCH 3/5] submodule-config: add repository argument to
 submodule_from_{name, path}
Message-Id: <20180327160443.5034f7db908c08fe3c301ab9@google.com>
In-Reply-To: <20180327213918.77851-4-sbeller@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
        <20180327213918.77851-4-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Mar 2018 14:39:16 -0700
Stefan Beller <sbeller@google.com> wrote:

> -extern const struct submodule *submodule_from_name(
> +extern const struct submodule *submodule_from_name(struct repository *r,
>  		const struct object_id *commit_or_tree, const char *name);
> -extern const struct submodule *submodule_from_path(
> +extern const struct submodule *submodule_from_path(struct repository *r,
>  		const struct object_id *commit_or_tree, const char *path);

There is a recent change to CodingGuidelines that states to not include
"extern" in 89a9f2c862 ("CodingGuidelines: mention "static" and
"extern"", 2018-02-08), so consider removing "extern" since you're
already changing this file.

Other than that,

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
