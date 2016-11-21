Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B441FA65
	for <e@80x24.org>; Mon, 21 Nov 2016 21:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754236AbcKUV4Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 16:56:25 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35474 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753252AbcKUV4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 16:56:24 -0500
Received: by mail-pg0-f45.google.com with SMTP id p66so134454798pga.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 13:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCki3h8RpgzhcbTr2DVtrCKzG/35yQzBkK5AplDqChI=;
        b=nD5Sfp8+LKER3Px8GRDSymm/Fi8DcfTQnyRoKUvAvY51LHW+oXqVv4X8U7tCBl4Yju
         K0yXCUwEvS6Ufiu8GkfOUpY/J5m+TcFv7SIap51v6dfduW17t3Tyhh204EGONhNlnCX+
         2NADonMVWOGElVaaAfolfThPoFcb+eVyuKkIRZXEk/KpZ2O/eP3gTXkpyKyQcxiBR2CT
         n/Ru3w5y1ZfTf+G9pOrIE5K4sOhtEt99A0v/oKm7o+iQwslANmsEdFD/ClpHbXakNqmU
         cTDM71v6bYDLkiANfoF19wFr8hKaOif9JQpWF6blANya7p2b8Gm4ZASSA55ZLLWGAdZI
         nH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCki3h8RpgzhcbTr2DVtrCKzG/35yQzBkK5AplDqChI=;
        b=GcHZSkzjGJkTBh7u/S8Huj2fJCwcB4w6K9lZ2LErNEkZRHSFUpTqBYoXk12O5VYiSc
         Oi3LbxBfNXdDPBFsD3ZeN6OID90fE6FX+BtQWctJyBaOmzQfaqdeU2dFfHsFmTxOympZ
         bLLFibuMTni15jGcPFmaZ0S1zbfGCyh7N/qOQyP3nCL9rwu3b+jxyOXIbpa7g6LlP27/
         njMjqxZWbKpnN2w1Q57693XRli9itnlSb+P1/zSm1fPIILPwXIxMVR5fq44VCpioQkio
         Ws9CBewtf3GfBBB8mbTkmhcHPWAXCP3M8/IkFEcg/0I65ec3lbJBYcJAM+7VLXfVx5fc
         TGbA==
X-Gm-Message-State: AKaTC02x31QuJv5hoxMevUeSxe9TGOmhEZwg17XXdXrLEEgVN9vLMpDs4MrtyjA8LichCiZk
X-Received: by 10.98.35.5 with SMTP id j5mr20849356pfj.91.1479765383562;
        Mon, 21 Nov 2016 13:56:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:9837:5b20:fc2:14ed])
        by smtp.gmail.com with ESMTPSA id t21sm39743765pfa.1.2016.11.21.13.56.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 13:56:22 -0800 (PST)
Date:   Mon, 21 Nov 2016 13:56:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Jens.Lehmann@web.de, hvoigt@hvoigt.net
Subject: Re: [PATCH 3/3] submodule--helper: add intern-git-dir function
Message-ID: <20161121215621.GB149321@google.com>
References: <20161121204146.13665-1-sbeller@google.com>
 <20161121204146.13665-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161121204146.13665-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Stefan Beller wrote:
> diff --git a/t/t7412-submodule-interngitdirs.sh b/t/t7412-submodule-interngitdirs.sh
> new file mode 100755
> index 0000000000..8938a4c8b7
> --- /dev/null
> +++ b/t/t7412-submodule-interngitdirs.sh
> @@ -0,0 +1,41 @@
> +#!/bin/sh
> +
> +test_description='Test submodule interngitdirs
> +
> +This test verifies that `git submodue interngitdirs` moves a submodules git
> +directory into the superproject.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup a real submodule' '
> +	git init sub1 &&
> +	test_commit -C sub1 first &&
> +	git submodule add ./sub1 &&
> +	test_tick &&
> +	git commit -m superproject
> +'
> +
> +test_expect_success 'intern the git dir' '
> +	git submodule interngitdirs &&
> +	test -f sub1/.git &&
> +	test -d .git/modules/sub1 &&
> +	# check that we did not break the repository:
> +	git status
> +'
> +
> +test_expect_success 'setup a gitlink with missing .gitmodules entry' '
> +	git init sub2 &&
> +	test_commit -C sub2 first &&
> +	git add sub2 &&
> +	git commit -m superproject
> +'
> +
> +test_expect_success 'intern the git dir fails for incomplete submodules' '
> +	test_must_fail git submodule interngitdirs &&
> +	# check that we did not break the repository:
> +	git status
> +'
> +
> +test_done
> +

Could we add a test which has nested submodules that need to be
migrated?  Hopfully its just as easy as adding the test :)

-- 
Brandon Williams
