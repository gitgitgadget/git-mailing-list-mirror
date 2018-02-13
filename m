Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF151F404
	for <e@80x24.org>; Tue, 13 Feb 2018 18:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965585AbeBMSlT (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 13:41:19 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32910 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965530AbeBMSlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 13:41:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id g12so471581pgs.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 10:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsbDhMLP2IhoPg5sutBpoNwdEUfK3vSroPzqnuvlbeU=;
        b=ZoYiYch0gVFQfh1x27mzsjAdOFUfGl18B3Yg9I1TE7f4mLZAqUxzs+X20V68VsbPML
         Ws92qgUpb3/jtf/OEtU8vIfZJYzrp/3L9zvpc/rcP17BSnZD3Ub7Y/5+gE+MwNht857J
         E/OUYj0cUZNGiFnEO29GgLxu/VM+IFpgrObXozrlt7FaRnzMOsybu+X0DfWOKvYFcPXQ
         ZVDuIPqbIO7WYUahJLiNLdHFaw10OFz8NNvYe0s+ajXlYRX3O/pBuXN7P/A1nHinxYEs
         WKWqOqjGLkhgoRHhQkJtTwprEAhUn1KUNAKNYZwIvbLpnxtpKN4GiHdwjJJFdaHtsiIH
         ApNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsbDhMLP2IhoPg5sutBpoNwdEUfK3vSroPzqnuvlbeU=;
        b=FsvbgK2m4BKsWi+9REeZ8Tbt3Xyaq9zvUQKHFjJymOpfznz+ohl7hUNtRL8BzpvO9j
         +MjBLPKUCZ3bHRIizWNdHiiHy1TQ7NLQrepOBgrRU3J2uZ6C+aZTuoZdy6kRVn5CkCb7
         3aPdYZ+8L7MyZz5RpFXoBIv+ujDmV8M2nuPOkYtRkH+1JYsjwnrUB9osk/wIT6qwD4Db
         tGikJAfi7U4inDZHldNtvSpsIBKJUP+Dn8I/utC0izWX2wO/lI8ZEyu83bYuiqKfnrjO
         cgbFq9bQMkWOpGWBGabt3vGrb8dPvz5omgn01UX8r2979kSUCLVVmB0FWioWj1/8OLjW
         K+nA==
X-Gm-Message-State: APf1xPBDb+xTXDYPpybBUG73zqbGo6CZQ8ReRnva9EwTKKJXoKj2Lx9Z
        33FgOXjSBWACjcq6JSpF4VxXR3Vf7/g=
X-Google-Smtp-Source: AH8x227nGMDI1v0APxcpzUXA8bN2S9LapafQZZnLhpA4UVD1z6sTcDvDsQkheZ5Pd49BDc3oF7b/rQ==
X-Received: by 10.99.113.7 with SMTP id m7mr1700624pgc.403.1518547277850;
        Tue, 13 Feb 2018 10:41:17 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x26sm31170005pfi.141.2018.02.13.10.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 10:41:16 -0800 (PST)
Date:   Tue, 13 Feb 2018 10:41:15 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] docs/interpret-trailers: fix agreement error
Message-Id: <20180213104115.073a239b95a1b868809d08bb@google.com>
In-Reply-To: <20180213022352.23742-1-sandals@crustytoothpaste.net>
References: <20180208025614.872885-1-sandals@crustytoothpaste.net>
        <20180213022352.23742-1-sandals@crustytoothpaste.net>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Feb 2018 02:23:52 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> In the description of git interpret-trailers, we describe "a group…of
> lines" that have certain characteristics.  Ensure both options
> describing this group use a singular verb for parallelism.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-interpret-trailers.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index 9dd19a1dd9..ff446f15f7 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -51,7 +51,7 @@ with only spaces at the end of the commit message part, one blank line
>  will be added before the new trailer.
>  
>  Existing trailers are extracted from the input message by looking for
> -a group of one or more lines that (i) are all trailers, or (ii) contains at
> +a group of one or more lines that (i) is all trailers, or (ii) contains at
>  least one Git-generated or user-configured trailer and consists of at
>  least 25% trailers.
>  The group must be preceded by one or more empty (or whitespace-only) lines.

This looks good to me, thanks.
