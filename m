Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2FC1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 12:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbfJHMb0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 08:31:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40224 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfJHMb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 08:31:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id m61so13884286qte.7
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 05:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HBGZzgjDUmCRk/EWN7WkM67CGoOjLa4xLaFfmPBPdc8=;
        b=Zbr3SW0nvYFWPTeE045B+tRJxWZfPQPvAD18zMvPq27dNMrKsnFUfgNiug0yrF6Q69
         GJtJDD1qCadDjdNN41gLdE1lqNeFeDzIHk632Smcwh+35RPEXHERPle2YCs3frOT7aOe
         25yJQRPY+2KPc8FEJunIB+fC6k8xKMzEAGoNE7d8O8/GHAqqHHXEbYi4XDq9+CeFtKtG
         u62TbW3kCyenY26QVh71W3K7kEbSx1F04byHcrmTi4mr/ENU4RmFUsuphOw1vAv/uU2c
         9WOcMJU2Uog7IMrisD5GEoDjebXjgPAMloZxSLiBlqYix3oCP96sdiIsr0XAGe77lKvw
         0loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HBGZzgjDUmCRk/EWN7WkM67CGoOjLa4xLaFfmPBPdc8=;
        b=IGirF32DF5sfLLP2HBYpq1lBGeV4V3RwaHTkmu1hqt0BWAauYOyTZdH4megaLQynDb
         UEJzNnhElbzeH1v6GqDTem/psRk8TiwUC1ooCAkFfJZgGUhMd0BgxxIzOChgp3PRSff5
         WPbBMB2CSLRy96Jx8EJ/7f7S1CsmqwMEeaTJi/RmAxs/Q9h0nYXmLWQ4lWPZKHyPRMvv
         lMVjdhqsA+LZEUqvg9Lfn6SmSBWtyjKVtL9oGqsn+shn4ZKGI+Dv3YWMxwpsTBrlVsnI
         zqOxhQ7OTsyPJ5Ao9eKju4pshKjEzEKcWafZDVwhZTrxfEIDbXzk4aisahqzDeXw9a9R
         N/TQ==
X-Gm-Message-State: APjAAAVN85b3rupQJHrC1SLPtvraso94xok8grLQSmZkTUtU4WIhz5Xn
        X5J/IdMf5kBqqTHdPEFAFbyzaHXbYJM=
X-Google-Smtp-Source: APXvYqzs805EblAjumcZ7eUFfXnyhGnpt2HLisaieeh8Sx4Uhr6eY8w2y6xpNJcCPNOlqUl3qz2M7g==
X-Received: by 2002:a0c:9ba8:: with SMTP id o40mr33070481qve.125.1570537885209;
        Tue, 08 Oct 2019 05:31:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1012:7abc:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id y4sm9076795qkl.107.2019.10.08.05.31.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 05:31:24 -0700 (PDT)
Subject: Re: [PATCH 08/15] t4015: abstract away SHA-1-specific constants
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20191005211209.18237-1-sandals@crustytoothpaste.net>
 <20191005211209.18237-9-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bbbd3152-b7ea-f59c-afff-6c0c5b5c9612@gmail.com>
Date:   Tue, 8 Oct 2019 08:31:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191005211209.18237-9-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/5/2019 5:12 PM, brian m. carlson wrote:
> Adjust the test so that it computes variables for object IDs instead of
> using hard-coded hashes.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t4015-diff-whitespace.sh | 89 +++++++++++++++++++++++---------------
>  1 file changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
> index 6b087df3dc..eadaf57262 100755
> --- a/t/t4015-diff-whitespace.sh
> +++ b/t/t4015-diff-whitespace.sh
> @@ -16,6 +16,7 @@ test_expect_success "Ray Lehtiniemi's example" '
>  	} while (0);
>  	EOF
>  	git update-index --add x &&
> +	before=$(git rev-parse --short $(git hash-object x)) &&

I see you are using $(git hash-object <name>) here (no printf). Seems
like you could use the same pattern in the previous patch.

-Stolee

