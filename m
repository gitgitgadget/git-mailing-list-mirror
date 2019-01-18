Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAAB01F453
	for <e@80x24.org>; Fri, 18 Jan 2019 19:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfARTXi (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 14:23:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52181 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfARTXh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 14:23:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so5551911wmj.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+z3gehVhCEtP6MAwHZRzLcfBbZWf6Id/4ZQHuO9kINo=;
        b=cPjZe1wtFCCsudqA2t4HznOmTskXPNuYDYBiJfilQ7TSd7tsN3KgvMkRogsdaqDsKQ
         u8mIbJgIeHOw57coCrVaycqfT6/1Z/y1tyKs0XsX3Qmi/dbPa5MUBvvXZ5SCoHLQ8xga
         WlkIQPNMUrKyWxySPXoLaGb5Ldjhz0UkWDk66HJLuaMF7al1eXfPEWFC3WMczd+N5d/M
         Q7esjbyIOyScT/1MG9NBvp151I+5SIAVr55brmAK2+VgxbsjVt2/eS92UY4z+AYMV3wD
         sVoDIwpX5BZhU4k1iFAZUe5eDf9DdLZSPKV+Fg0R1ll+fSrOrr5gc+phvfrPYxDU2m+3
         7dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+z3gehVhCEtP6MAwHZRzLcfBbZWf6Id/4ZQHuO9kINo=;
        b=lMrzQtZsGY3G8JWfPs8ubzU0mCw889n5e87R8q/+awsRkvQf6KMSRT1RFeTyBFQ6wZ
         KolFLFbYkqRQ4Hs9sBgkKmrJU+Xwu9pwR13eytSfCLweVUvi2u/1plYZ46wqqgxoDcxk
         i1zoHVysfSpS2dV/Zo4/dVBNBevKsyDEDYkercPbMh07+52Gdb7QnXvtWjx1knAgYjMi
         YCv27/Zp/JdVHaRPC4JC3u97On6qhOHDjwOAmnBAY2747JV46WA5vMtEM082kkibOYs8
         GyURHhB/YszAdbTDxHTmPcblfqs5IBqGLEKTEBI21NEWPmihB31Vhf+YtHeYuPu0QIP6
         4+5w==
X-Gm-Message-State: AJcUuke2RVpYbct+wX+fw2kdVtKePlprjOTCYDxQthT5OlSMrK9wgCAw
        eZWJKNLAwgrYUQI7Wt0SCzs=
X-Google-Smtp-Source: ALg8bN4Kn7ZyFCdanNntJk7RMT3tnzG6ApmOKVnoKnQVMC/HI9vRLHeuYdKza0UaeiMjok2Yl/WlBQ==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr327553wmj.91.1547839414905;
        Fri, 18 Jan 2019 11:23:34 -0800 (PST)
Received: from szeder.dev (x4dbd9ead.dyn.telefonica.de. [77.189.158.173])
        by smtp.gmail.com with ESMTPSA id o4sm80572669wrq.66.2019.01.18.11.23.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 11:23:34 -0800 (PST)
Date:   Fri, 18 Jan 2019 20:23:31 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, asottile@umich.edu,
        pclouds@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v1 1/2] checkout: add test to demonstrate regression with
 checkout -b on initial commit
Message-ID: <20190118192331.GN840@szeder.dev>
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <20190118185558.17688-1-peartben@gmail.com>
 <20190118185558.17688-2-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118185558.17688-2-peartben@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 01:55:57PM -0500, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>
> 
> Commit fa655d8411 checkout: optimize "git checkout -b <new_branch>" introduced

Style nit: fa655d8411 (checkout: optimize "git checkout -b
<new_branch>", 2018-08-16)

Furthermore, please wrap the commit message at a width of around 70 or
so chars.

> an unintentional change in behavior for 'checkout -b' after doing a
> 'clone --no-checkout'.  Add a test to demonstrate the changed behavior to be
> used in a later patch to verify the fix.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  t/t2018-checkout-branch.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 2131fb2a56..35999b3adb 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -198,4 +198,15 @@ test_expect_success 'checkout -B to the current branch works' '
>  	test_dirty_mergeable
>  '
>  
> +test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '

As this test is supposed to demonstrate a regression, this should be
test_expect_failure (to be flipped to test_expect_success in the next
patch fixing the regression).

> +	git init src &&
> +	echo hi > src/a &&

Style nit: no space between redirection and filename, but...

> +	git -C src add . &&
> +	git -C src commit -m "initial commit" &&

The above three lines could be replaced by a single

  test_commit -C src a

command.

> +	rev="$(git -C src rev-parse HEAD)" &&
> +	git clone --no-checkout src dest &&
> +	git -C dest checkout "$rev" -b branch &&
> +	test_must_fail test -f dest/a

And here the test should expect the file to be there even when
demonstrating the regression.

Please use the 'test_path_is_file' helper instead of 'test -f', as it
gives a useful error on failure.

> +'
> +
>  test_done
> -- 
> 2.19.1.gvfs.1.16.g9d1374d
> 
