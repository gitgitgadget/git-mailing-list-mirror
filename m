Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED35720248
	for <e@80x24.org>; Thu,  4 Apr 2019 20:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfDDU2S (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 16:28:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37000 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbfDDU2S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 16:28:18 -0400
Received: by mail-pl1-f196.google.com with SMTP id w23so1721611ply.4
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHZTn76pEIV+2racdgYoMSmjqznLK13Z9TW4f0ou4Lc=;
        b=T2dpEcLMlWr456iruOOuGRVhwgqkvHxnhzy8Zyx/03GCcWOvwrQPGnV1fnM2tq7/qs
         B/lXSeFsEq9peGM1e461HcK3XxJxG+6nBTlAGw5w7U3leg73ceWLvrtqPUkPn30O0KGK
         0gE5W4wDVEoba6I1+j6Q9mbFJwMFpFwjAd7aSqsVLk6G/nPCySqyFZnteiklG3n+NfVO
         R/cE7JLgdohoI9hapoMG0BZug2Kyyj6imB+P4meANZ+TJKKPWD5YrkZgjsjBdh73Sp42
         cEQbR9p55GyaOqxFAqzpOvKXLZjAyuR52h9XKX6520+vKSxfPJdUxaXb+2pNyL6fdZxH
         3Mig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHZTn76pEIV+2racdgYoMSmjqznLK13Z9TW4f0ou4Lc=;
        b=Gv2w3XXzvQqZyOKYitHITtPm/kFAsXNkcKDgA480/F2KhIjKEq+RWuxszDmarKOuXF
         0MDWExTdiKIoQRPdnnOlyiJvacuOTHtpOR+vAW/TR4CZN+dP1CgaUw5WNdefzpd9p6xZ
         A86I+wzbUdgN/RyO31P2IZovrAzZgsmqEvH8C3N8g3rGVnvvKZX8n1eZkIvHaH10HfXH
         VzUW/zgegdVBLxqEr+VeVk9Ry1aUREEMkFaGcDdAQiMmY9fZVRNJXuymqaDKsYKN/Xs5
         fIMrNnbeuueMTnUaR74pclDUOKHJ9/ogEAxJ1SscK7XO2ThdskRhL6z+Sii0edC0G72T
         z7Fw==
X-Gm-Message-State: APjAAAW5Y4Y8SYjzB+t5kVzczlsBZgD9DpT7iv3rOsJtyBXCM3G4Et9F
        snNZ0gUJK2gHGRXVHmiEfuTw2VY0
X-Google-Smtp-Source: APXvYqypD+ZbKdB0g7iItLZiMKBIrHiKowz1a83exRu2rGUTzA4bm52BhX+eNsJQmx+0eBE83TBx8g==
X-Received: by 2002:a17:902:290b:: with SMTP id g11mr8592726plb.269.1554409697122;
        Thu, 04 Apr 2019 13:28:17 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id x24sm26744268pfn.128.2019.04.04.13.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:28:16 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:28:14 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/4] t3431: add rebase --fork-point tests
Message-ID: <20190404202814.GA1290@dev-l>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234ac9f024bf4e6b4944fd8f3912cf6367cf828b.1554151449.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 01:51:57PM -0700, Denton Liu wrote:
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  t/t3431-rebase-fork-point.sh | 53 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100755 t/t3431-rebase-fork-point.sh
> 
> diff --git a/t/t3431-rebase-fork-point.sh b/t/t3431-rebase-fork-point.sh
> new file mode 100755
> index 0000000000..8e2483b73e
> --- /dev/null
> +++ b/t/t3431-rebase-fork-point.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2019 Denton Liu
> +#
> +
> +test_description='git rebase --fork-point test'
> +
> +. ./test-lib.sh
> +
> +# A---B---D---E       (master)
> +#     \
> +#      C*---F---G (side)
> +#
> +# C was formerly part of master but is side out

Sorry, small typo. We should probably fix this before it gets merged
into next.

This should read "C was formerly part of master but master was rewound
to remove C"

Thanks,

Denton

> +#
> +test_expect_success setup '
> +	test_commit A &&
> +	test_commit B &&
> +	test_commit C &&
> +	git branch -t side &&
> +	git reset --hard HEAD^ &&
> +	test_commit D &&
> +	test_commit E &&
> +	git checkout side &&
> +	test_commit F &&
> +	test_commit G
> +'
> +
> +test_rebase() {
> +	expected="$1" &&
> +	shift &&
> +	test_expect_success "git rebase $@" "
> +		git checkout master &&
> +		git reset --hard E &&
> +		git checkout side &&
> +		git reset --hard G &&
> +		git rebase $@ &&
> +		test_write_lines $expected >expect &&
> +		git log --pretty=%s >actual &&
> +		test_cmp expect actual
> +	"
> +}
> +
> +test_rebase 'G F E D B A' ''
> +test_rebase 'G F D B A' '--onto D'
> +test_rebase 'G F C E D B A' '--no-fork-point'
> +test_rebase 'G F C D B A' '--no-fork-point --onto D'
> +test_rebase 'G F E D B A' '--fork-point refs/heads/master'
> +test_rebase 'G F D B A' '--fork-point --onto D refs/heads/master'
> +test_rebase 'G F C E D B A' 'refs/heads/master'
> +test_rebase 'G F C D B A' '--onto D refs/heads/master'
> +
> +test_done
> -- 
> 2.21.0.695.gaf8658f249
> 
