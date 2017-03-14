Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469AB201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 18:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdCNSla (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:41:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32868 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdCNSl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:41:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id v190so20170877pfb.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 11:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNKxFybFcyNYAuhYHhfIX8kHxMYa1B9H85TC8Dvcbkk=;
        b=h5Fcax+IEGo5GCCv++dh1OQP1VAvYPC2/gAgv/u8P1CRC+2MC/E0v1dnYYsMG+DygQ
         gb1givK2WsH9Y1b7BLj/SqinS3y/nDufYyO55rzaghua/1GlcYM/ADsmA4UvZ8Wvspw6
         xvQrnVz+Bgf7W9eBaHFUnt8vUpMKKndqSGaCZRIAivy0knGvzfg3/baHh5A1yI8MLZe3
         OcLbWoaLwRJ0w17NVoLCH9SE+GpoewtIv38UwzCMQQK4V5ZJLOuihlxgAaxDDHxSD3Gx
         P7smBU0r/0khXjQZ3U/1dIOBtBn1p8Gw3/9otjljj5tZLKsKk47BuuFnb6OnFJeud651
         b3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNKxFybFcyNYAuhYHhfIX8kHxMYa1B9H85TC8Dvcbkk=;
        b=XWvQa9DMpQxCXWYy6fEWKfbjQHwd9YpTqN5gmj5uJdTWeLVGQKOcI2NotSxo8U5LyH
         57eJAqqPA4waVMFyDqF/3k5UCs+TmS7IvjQwrIp5BBCyf7oOIpiZeaWDOfzr5W1oWtv+
         KUFywz9BzZcJUx8FU72itPyw52Vh8dP8p4/eZyMB8++ijuLjGnHcqiq4IrC/UWQzylxp
         FnTIlHM+9fbWk81Qsc9ox8oWucjD4e+eHrT6lHQxwnT0Z8CVb6KBiMM2CpDu6d9MZBVH
         Ci5bF4hRDYuEfFtacXuHmnX0JmGZSLX2pvWb15VVPOoNnadJ9bjelSWpVImBJWuHKDLE
         uCgA==
X-Gm-Message-State: AMke39mVNgpWk2Bo3HCTBnEbYViTFGa1J6ry0Ny0hSF7Uwkt+9Rf0MUQ/uzu/uYJb0hNLA==
X-Received: by 10.84.129.3 with SMTP id 3mr58714977plb.150.1489516888378;
        Tue, 14 Mar 2017 11:41:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:44b6:c180:5bab:cbd2])
        by smtp.gmail.com with ESMTPSA id j62sm40208372pgc.54.2017.03.14.11.41.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 11:41:27 -0700 (PDT)
Date:   Tue, 14 Mar 2017 11:41:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header
 file
Message-ID: <20170314184126.GJ26789@aiede.mtv.corp.google.com>
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170311222818.518541-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

[...]
> --- a/cache.h
> +++ b/cache.h
> @@ -10,8 +10,8 @@
>  #include "trace.h"
>  #include "string-list.h"
>  #include "pack-revindex.h"
> +#include "hash.h"
>  
> -#include SHA1_HEADER

For what it's worth, the bazel build tool doesn't like this
'#include SHA1_HEADER' either.  Your fix looks like a straightforward
fix and we never encouraged directly customizing SHA1_HEADER.

The other approaches discussed may also work but they don't add
anything for my application (nor yours, I'd think).  Conditional
#includes are a pretty normal thing so I am fine with this more
straightforward change.  So

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

That said, if someone is excited about one of the other approaches
then I don't object to them.

Thanks,
Jonathan
