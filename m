Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143A61F454
	for <e@80x24.org>; Fri, 28 Sep 2018 10:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeI1Q7B (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 12:59:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39775 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729242AbeI1Q7A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 12:59:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id q8-v6so1669413wmq.4
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 03:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ha0lPWYOctM5LLNpn3UUIXQtoaCifxai5a0thc3xzMw=;
        b=kJ6isWImB2vp8a7ie3z6mDchBviMJZ4HQu/dsQrni+qW+jRr9SkiDYflDRCwrUR1HM
         dbjZfwglx2AKNRNZ0wgl6B3hdYr0LdfD/jHdORMkUpHDfzrPVMIOAh14RdX5cWdsZFMk
         z573zrrYRR/Zi989IxT5zx1bjTgQpQoHCQdVaAs7UL6zWZnoUbTvM2ex9iw8emw16bgR
         D1vl2YL8DV6ETNrhUcJWOBlKUAFUIMqs5L2lo9G7zSxr4fy3QrdltOpwt5MKvywhIo0g
         BkHLbAAjCLwkRWMPNm0t3AjCekTojmZen78qN/l7sxELOeqQKebv8z5tMXhXnHDRpbnA
         9FfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ha0lPWYOctM5LLNpn3UUIXQtoaCifxai5a0thc3xzMw=;
        b=DoPmKZaIjfU31B0ltoE4OARr/SBfUWTaK1NjGrdTnIeE29/Gt1zpe98jitxDY4F7bn
         66As0AG92EeSiCTn3QJWOfz46xuubq1+msMZRnwzaeoMYex1WBPetp4GObfheww9DO8h
         7RlWdRBEQB3v1AUvkj1Om22E8+qo+Ff6DtpAFvnbo3+9YuPqhChRvO+xe4XBUrt3WIJA
         wUdsU5meXq2erWYUq95QZRRrGFNGch6sVLfF8aqmQPZVamJsyHW1aoAiedbNb2gtyg5c
         UocykQfiImKnSoLlchncbrCzw+P6P41yrjLgtXoqY70d6EuZmQGbUK4S1u5C6zLfzf9q
         djEw==
X-Gm-Message-State: ABuFfoi+IilKhjiYwaWkWoSm1CVbNp7+PJZ5n6c+zM+T3UeFNVCIUUcj
        Vg1asT3orVi8+1Mak6F5WqY=
X-Google-Smtp-Source: ACcGV63H9QKhPyLm3sNpt3NeQ9BUGSyYkSRy0aIJ49qPytC7b0x1oI3L8t6X9jkp0kHdstnppQGQkA==
X-Received: by 2002:a1c:b709:: with SMTP id h9-v6mr1219557wmf.130.1538130951155;
        Fri, 28 Sep 2018 03:35:51 -0700 (PDT)
Received: from localhost (x4db1ef73.dyn.telefonica.de. [77.177.239.115])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4025444wrq.7.2018.09.28.03.35.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 03:35:50 -0700 (PDT)
Date:   Fri, 28 Sep 2018 12:35:48 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v5 7/8] t0410: test fetching from many promisor remotes
Message-ID: <20180928103548.GC23446@localhost>
References: <20180925115341.19248-1-chriscool@tuxfamily.org>
 <20180925115341.19248-8-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925115341.19248-8-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 01:53:40PM +0200, Christian Couder wrote:
> From: Christian Couder <christian.couder@gmail.com>
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t0410-partial-clone.sh | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 8b32be6417..3fbd8d919e 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -170,6 +170,28 @@ test_expect_success 'fetching of missing objects' '
>  	git verify-pack --verbose "$IDX" | grep "$HASH"
>  '
>  
> +test_expect_success 'fetching of missing objects from another odb remote' '
> +	git clone "file://$(pwd)/server" server2 &&
> +	test_commit -C server2 bar &&
> +	git -C server2 repack -a -d --write-bitmap-index &&
> +	HASH2=$(git -C server2 rev-parse bar) &&
> +
> +	git -C repo remote add server2 "file://$(pwd)/server2" &&
> +	git -C repo config odb.magic2.promisorRemote server2 &&
> +	git -C repo cat-file -p "$HASH2" &&
> +
> +	git -C repo fetch server2 &&
> +	rm -rf repo/.git/objects/* &&
> +	git -C repo cat-file -p "$HASH2" &&
> +
> +	# Ensure that the .promisor file is written, and check that its
> +	# associated packfile contains the object
> +	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
> +	test_line_count = 1 promisorlist &&
> +	IDX=$(cat promisorlist | sed "s/promisor$/idx/") &&

You could drop the unnecessary 'cat', 'sed' is capable to open a file
on its own.

> +	git verify-pack --verbose "$IDX" | grep "$HASH2"

Don't run a git command, especially one with "verify" in its name,
upstream of a pipe, because the pipe hides the git command's exit
code.

> +'
