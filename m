Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 904AA1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 00:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeGDAFW (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 20:05:22 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:46103 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeGDAFV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 20:05:21 -0400
Received: by mail-yb0-f193.google.com with SMTP id s14-v6so1403341ybp.13
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=J57R1pFEtbXaBKXgOxFN5qIZ/jILBTnIqdjkSglfE9s=;
        b=FrX2GoxfOSlq8v+MJ1TbmUt5muaVtWXSLtSSncVTTds65CRg+ajw2rw3nkCusOTOXX
         oxVQSp3a4+k2gTB/cgDf+rxFhDcQHG9bNoHAUnTHOYwflZGCwL3vXkmvLwtHvQObJJxL
         Un6o7GvmOnF+v2lrs75tHwIbC3K+jWahqeucdpxVufAyzVjOJrqsKgaEBbijDCL4UXPS
         6NYwFFeWjjChHt4DAo5O240aghvIHuMONcmpdxGb0L4cAGQzTL7ZX4dYpisCX15ktcEA
         whus92/F6a7lCRXxb/v87IO6IoPBzUHP/v5SxMGiYIYOteIw3+HaGNMd3eSglOEwqOtG
         eGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J57R1pFEtbXaBKXgOxFN5qIZ/jILBTnIqdjkSglfE9s=;
        b=Ah5RHHtmMVD9YMIS2t8BhGzDNITt0elzlOiam5kOaYohdUxFWmkKXB3NPKSJHP5gDw
         /AQ4Cc3AaAYEw2oErabAp3hhISuI84vEBn32I/CYBRNOjHsYotBpK+c6KgvpSPbBd0Bm
         joZSVXTypc2/3YpaP5eA0J3DJ4V1VCm4A7jlnjTZtljMPs4P2nLX2MWxM6aGgxHaVakI
         5TKwK5H334fJLT+YmTPzdXQl8sbGgkQ7GnuMfFl4yI1bcgsw9LLPP7ZfG1EMci6NYj8i
         OUTj4nEaz8OGJSbQ2Qx0fyQOE4irFd+JHJrcizNZaRTbPyzcQ0OX5JkjLvnvaDM+JWGo
         5FMg==
X-Gm-Message-State: APt69E3dRGGoE+DKfpm4hoXCWwUHRE9w6d65xvPNl/94K1KxxpA0Jauk
        MtKlOlb0lbpQKwNE/jERf1J1skX8
X-Google-Smtp-Source: ADUXVKKTXIq07GvK8YNd/TSQay7xH5EcjZTra2Tio23O9xxJD4RXZzqsqZ5D43FNConurVPhY24pQA==
X-Received: by 2002:a25:6d06:: with SMTP id i6-v6mr16199497ybc.299.1530662720963;
        Tue, 03 Jul 2018 17:05:20 -0700 (PDT)
Received: from [10.20.131.237] ([70.63.112.210])
        by smtp.gmail.com with ESMTPSA id i64-v6sm841522ywd.80.2018.07.03.17.05.20
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 17:05:20 -0700 (PDT)
Subject: Re: [PATCH] ls-tree: make <tree-ish> optional
To:     git@vger.kernel.org
References: <26b538bd-df59-d9a6-460d-0b1042b35250@gmail.com>
 <20180703235337.31770-1-jyn514@gmail.com>
From:   Joshua Nelson <jyn514@gmail.com>
Message-ID: <368608dc-4351-541c-0236-9f5760ca5d97@gmail.com>
Date:   Tue, 3 Jul 2018 20:05:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703235337.31770-1-jyn514@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 07/03/2018 07:53 PM, Joshua Nelson wrote:
> diff --git a/t/t3104-ls-tree-optional-args.sh b/t/t3104-ls-tree-optional-args.sh
> new file mode 100755
> index 000000000..e9d8389bc
> --- /dev/null
> +++ b/t/t3104-ls-tree-optional-args.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +
> +test_description='ls-tree test (optional args)
> +
> +This test runs git-ls-tree with ambiguous positional options.'
> +
> +# cat appends newlines after every file
> +test_expect_success 'show HEAD when given no args' '
> +	if [ "$(git ls-tree)" != "$(cat expected1 expected2)" ]; then false; fi
> +'

I forgot to take out the comment about cat; it's not actually true, I
just happened to be using echo instead of printf when I wrote it.

Is it customary to send a new patch or second patch that builds on the
first? If I specify a commit range to git-send-email it sends both, not
just the latest.
