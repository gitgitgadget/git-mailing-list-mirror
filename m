Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18E041F404
	for <e@80x24.org>; Thu, 16 Aug 2018 17:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeHPUBd (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 16:01:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54919 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeHPUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 16:01:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so5124697wmb.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=q99JM+WepU/F0D8LMBlcxGxm5ayHVqkKMPoIWbCRd7s=;
        b=hl6dXN1Y0YnxT7cOr3CQLSjh2fH/T79Nu8rP8EfgtIdmKutBIA+YnyfeV82ZxXLx3K
         zWwa4WVWRAE4QRW7fNLWr0smkZ0AGp/OrVrUNcFrTDfvW0CDeDYTvDVWSqJWypcevqBJ
         Lf0VW0M4EasAGGkb4GWMKgHOu3/r1oV6Lzg2frzJdTtCHw/oRsm+q18QhGxVBsl/5HAi
         5MC//p2i3ebks0eA0jF+E7BZwhuHH9M8EunJMUIK3/qvvAIO7sq9/6J2LJsDvrzORPgZ
         9lhBQk/n783i/YKlo0ADFSS0r2i2pqL9PkJe0l24/NAU86mkwQqFYkdqQbGmeoqizoG7
         FSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=q99JM+WepU/F0D8LMBlcxGxm5ayHVqkKMPoIWbCRd7s=;
        b=BrdxHkQMXdeTrdQ/xOFWonoyoPnxNICggmTUpIJbS1mO8oE1KIYUnk/N0m4xo+Uvgs
         z3NenjeMpScNfaVNfcmT9JzfsyTnUjv8RXy4dTq+QQEgi6K+PpXYtw23kunWCrMX/C2S
         scKmOtl503IUK5SkIDBq5MaA5vxOdGiwvW3gcwl+y2B6XriIjajc+ZnLW7n/4hHUaGoV
         BsnhD7JVDLfOQJxfh4IGal6wtbX8vbGT7mBgKeQq95lWRXYl7mMsPck9SSFCLg5piKlS
         N7WIZ46/KFUky+uwenzBPIoBHtrZ7F3tvBBkvz8yhjpwUlOPyUO1qlm7SWRX66gkWpiM
         N3dQ==
X-Gm-Message-State: AOUpUlGcYNxlQenVQTjsrNCkK+SW33TqJSVH+gM+iEtLzYV9RLFP33Tq
        ODNlMeU++g/QuKceBD+WJcw=
X-Google-Smtp-Source: AA+uWPyHjK049PyVZqSPuYi0/DlXmBe0JuEwVC53vhxMF3KZ2r8iDBmr9v41SMq/Xhr++EQiOwAB9A==
X-Received: by 2002:a1c:588c:: with SMTP id m134-v6mr14642289wmb.154.1534438909958;
        Thu, 16 Aug 2018 10:01:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e133-v6sm3164395wma.33.2018.08.16.10.01.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 10:01:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com, tboegi@web.de
Subject: Re: [PATCH] config.txt: clarify core.checkStat = minimal
References: <CACsJy8AYQL3oDLyt14eJ1emynngqKQv9GXju56gU9u4mHrFHOg@mail.gmail.com>
        <20180816155647.10459-1-pclouds@gmail.com>
Date:   Thu, 16 Aug 2018 10:01:48 -0700
In-Reply-To: <20180816155647.10459-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 16 Aug 2018 17:56:47 +0200")
Message-ID: <xmqqin4afdoj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The description of this key does not really tell what 'minimal' mode
> checks exactly. More information about this mode can be found in the
> commit message of c08e4d5b5c (Enable minimal stat checking -
> 2013-01-22).
>

While I agree that we need to do _something_, I am not sure if this
change adds sufficient value.  I _think_ those who wonder if they
want to configure this want to know what are _not_ looked at
(relative to the "default") more than what are _still_ looked at,
partly because the description of "default" is already bogus and
says "check all fields", which is horrible for two reasons.  It is
unclear what are in "all" fields in the first place, and also we do
not look at all fields (e.g. we do not look at atime for obvious
reasons).

So perhaps

	When this configuration variable is missing or is set to
	`default`, many fields in the stat structure are checked to
	detect if a file has been modified since Git looked at it.
	Among these fields, when this configuration variable is set
	to `minimal`, sub-second part of mtime and ctime, the uid
	and gid of the owner of the file, the inode number (and the
	device number, if Git was compiled to use it), are excluded
	from the check, leaving only the whole-second part of mtime
	(and ctime, if `core.trustCtime` is set) and the filesize to
	be checked.

or something?

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/config.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fd8d27e761..5c41314dd5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -466,6 +466,8 @@ core.checkStat::
>  	and work tree. The user can set this to 'default' or
>  	'minimal'. Default (or explicitly 'default'), is to check
>  	all fields, including the sub-second part of mtime and ctime.
> +	'minimal' only checks size and the whole second part of mtime
> +	and ctime.
>  
>  core.quotePath::
>  	Commands that output paths (e.g. 'ls-files', 'diff'), will
