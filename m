Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A61F1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 13:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbeKSXyp (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 18:54:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37627 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbeKSXyp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 18:54:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id j10so17854769wru.4
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 05:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7i0ABmXHarbHE+FrbphKrwnDk0UNyLzjQ6VVOi1hfsc=;
        b=MSPJqFRle/K6jgIaCRZaa9jn7wbA2Rbz4mZF5ejLWMWMMOfySpWZnSMnqayUBnEBXk
         DFUGrFYURHrwsqtgLrVIrAQ/efjngGHkrwy3UKlxKUXJRevwVsPDKSDUC9Z5vtAXbgWT
         zmaXnEPfnWpT0kgM6diGjjWBi6RemN6HsoG0/kX118o7YsMp1rJiMUKH/ZrnrY6T7o/O
         Pi6OX2nKhMUrZXA5aFe3X/KwBRYJx/NPSp5muGG4MT+ZVnEKwBGYz/DjLOIgpqxEU11+
         4GaMdtG6KCRxFs1oSKzUHEZwLeQ8X8Oyrh9bBAhQ+AEFF+TpMpj40E7XuN6eX+wUkdkr
         AspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7i0ABmXHarbHE+FrbphKrwnDk0UNyLzjQ6VVOi1hfsc=;
        b=d4jNQIr9H557IaXv3KO+DhZgWI0Axwl40zgrDKW9VEy1WzYHZ2c6fHlsWl1+vMaRQz
         bHClJCi9pY+nErpX9xFon/UDFHgu6Xxz9GczmgOlUwsxrT/fg5/4DahXuZVTXCqZ2U+B
         JyUQ1m+6+eh1UMtDG25xuBeVDmVPq+GfpXXm5ll1lhpLaK1d8ZYY8GMaftyGYVh21oKw
         xwiuHyQpEWf4vkSGtMVw43BqbDlK0P0LKAkA4kfDHgZuenCd/71K8pQZyHNm5ctBxIII
         W/KgEuLbiw10+rb08jXIHslAzTsszR5H1+ukjiZ6wj/+mP0GOUFJEm+mteGGb5pAZdr3
         hRZQ==
X-Gm-Message-State: AGRZ1gKrZmqM8hep+SXRcr1J1oZey+Xb7RFuxZLtmVRXZtqIDMsbyhn/
        YeyIuGlgZPxXAeJ2WMfKpyU=
X-Google-Smtp-Source: AJdET5fGZz6A2ZtTULIZDMQQBST1tEKeocmOQ9oKhHXEh9RpxgD+/Wlo88gKP87P0LyU+PIm4AARRA==
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr17248601wre.94.1542634265560;
        Mon, 19 Nov 2018 05:31:05 -0800 (PST)
Received: from szeder.dev (x4db04f16.dyn.telefonica.de. [77.176.79.22])
        by smtp.gmail.com with ESMTPSA id f192sm8103417wmd.12.2018.11.19.05.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 05:31:05 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:31:02 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: make 'test_cmp_rev' more informative
 on failure
Message-ID: <20181119133102.GS30222@szeder.dev>
References: <20181119132818.3116-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119132818.3116-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 02:28:18PM +0100, SZEDER Gábor wrote:
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index d158c8d0bf..fc84db67a1 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -854,9 +854,23 @@ test_must_be_empty () {
>  
>  # Tests that its two parameters refer to the same revision
>  test_cmp_rev () {
> -	git rev-parse --verify "$1" >expect.rev &&
> -	git rev-parse --verify "$2" >actual.rev &&
> -	test_cmp expect.rev actual.rev
> +	if test $# != 2
> +	then
> +		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"

And this here is another "bug in the test script" error that should be
turned into:

  BUG "test_cmp_rev requires two revisions, but got $#"

See: https://public-inbox.org/git/20181119131326.2435-1-szeder.dev@gmail.com/

