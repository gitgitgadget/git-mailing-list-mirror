Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38C01F453
	for <e@80x24.org>; Thu, 21 Feb 2019 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfBUXPe (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 18:15:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38574 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfBUXPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 18:15:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so336626wrw.5
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 15:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iUUliVwtkRMlt59l0AXMgk5nsp/1S5qnXHdMpM2yImA=;
        b=rmCbcmkUKc5vKRd7XHPDvp+rsxOhxRLtm0Kxg3/i4PRpuPAFTuY8UOhvMvkjgBMFn5
         T7g2rH92oTtldxNjqmzftrfUby5p8laj7kV/aJ+52BJaizxpxo45BPQC7pmwfWKVvCtT
         cJonpQbYMVrl52SlnpdnpMSWhQlPbmdMkVOyXHAZwthIit/VffUjGFtTdt/cYMZcU9Ej
         imD2zl0YuJxh514ddGeCowHP5XwbM3DrH0wbBbADxAmbHRK/kphLb2DPn7VRyB1ElkWg
         zOW/IqtBe2WYTXv66d59tOiIKivR+DGj5iK8c9ubY0Ah2PQJZgjxwl91yjtMfOqHT9Bt
         POrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iUUliVwtkRMlt59l0AXMgk5nsp/1S5qnXHdMpM2yImA=;
        b=J2gs4vHta1sUKDiLKOf9IGfGFQnXJURpbgXr/Y/VzphnihH28KDO+RLusKErDIptgb
         Yiw7+WxyWO6rjpyKp3eg7aq8jnrdNHEpmrpMAuOg89XNheP4/bpV417lY/ekxU+VHJUu
         UTLcE86oBOQdiMDSU7K7OGk4bpU8+AeEntbbEq7A2lm42QUdSzR+ZO8wXZqolaqkHk4z
         9SSBZJTZahpQ6zkCMAATjZPumgTVMl7ZVHAq9GdN/icbyNxNf4UWjo5il78ccGXt16WT
         yaHLCqXjymzQg+MVJ7kGove8tskIblLGGNevP9MstYLuY6jQx7gJQ2gMhAAaHPFuHwUj
         LvWA==
X-Gm-Message-State: AHQUAua6W6gB5QoH0aysVXm5FaQ2XUHi9C+s/lxOi9LytZ9BXETqHjNZ
        mlrJnT576A8mm/mNRTTUv2s=
X-Google-Smtp-Source: AHgI3Ib9jWPd1HYHrTcN3AJsYbuhz1LjDx1271uEW9yobErIQurJgjvfoxYqhgM0uQ1UTh5W61lpOw==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr577835wrn.315.1550790932792;
        Thu, 21 Feb 2019 15:15:32 -0800 (PST)
Received: from szeder.dev (x4db54a94.dyn.telefonica.de. [77.181.74.148])
        by smtp.gmail.com with ESMTPSA id r70sm129024wme.46.2019.02.21.15.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 15:15:31 -0800 (PST)
Date:   Fri, 22 Feb 2019 00:15:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/8] commit-graph verify: detect inability to read the
 graph
Message-ID: <20190221231525.GA13328@szeder.dev>
References: <20190221223753.20070-1-avarab@gmail.com>
 <20190221223753.20070-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190221223753.20070-7-avarab@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 21, 2019 at 11:37:51PM +0100, Ævar Arnfjörð Bjarmason wrote:
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 0d012f55e5..1ee00fa333 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -400,6 +400,18 @@ corrupt_graph_and_verify() {
>  
>  }
>  
> +test_expect_success 'detect permission problem' '
> +	corrupt_graph_setup &&
> +	chmod 000 $objdir/info/commit-graph &&

This needs the POSIXPERM prereq.

> +
> +	# Skip as root, or in other cases (odd fs or OS) where a
> +	# "chmod 000 file" does not yield EACCES on e.g. "cat file"
> +	if ! test -r $objdir/info/commit-graph

And this condition would be unnecessary with the SANITY prereq.

> +	then
> +		corrupt_graph_verify "Could not open"
> +	fi
> +'
> +
>  test_expect_success 'detect too small' '
>  	corrupt_graph_setup &&
>  	echo "a small graph" >$objdir/info/commit-graph &&
> -- 
> 2.21.0.rc0.258.g878e2cd30e
> 
