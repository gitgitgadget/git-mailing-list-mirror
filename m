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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CA651F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 12:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbeKPWl4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 17:41:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35098 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbeKPWlz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 17:41:55 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so7828324wrb.2
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 04:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4OGr3Cx/1ItKnT5eccNtjt2OJowhqz2pZuwUzthjKPg=;
        b=aRpVblQTBXVp8yR/dcWRDDY5aBqZARzhPYH33XH9yX1NvMksEwI5qdI8R7hT8nXp8H
         ubwa6H2lRZd6tJF+fV/0Dj31tr6KdAyBRAb3h9APd7w8d8Cy8JewzeNOuer80Phbj/Zk
         waGp6IE6Fh0rKoF3H6R64PJqlUUV1bj1wCVMOGu8wX2/a+Iky736vnLH60vGaJI6Cuei
         n1S5J6VYocp6TpGdR+IFj2HvvPeUA0GpWVUJGS7JEE+RFCIaukEdG0Acnb2b3wxJS6bu
         v+EYTVX2YbN+deH3bbOMgoF2LcmcRl89aHK853Vnm5KvcaSN+4h7lGgGd49jcWKODSk5
         keEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4OGr3Cx/1ItKnT5eccNtjt2OJowhqz2pZuwUzthjKPg=;
        b=EZ8bG/DauJldLXhB/5R9MdQUKIwhw9w28ewmuonzm23A3ra8vXNGk6FmaOWjjn1SoT
         LYw6c0a2ANvPe25383vSmYrlj88UUDDrZN8R9xSX7qnWWbyxFqwXorgkfQYN3BQMsyt0
         qR/D/Q7vdQdvBFoyM+4cDkPxBlxQ8YYUf+RBrZp1GGbZxpYgJ4bupIzJwjwO8AKxEbCY
         wTQSr3k99XojI/VgpmIO7e9wHZM+td3KhMpHPJqXylIs8IM8rZKhUjzdFoAzsYeqbwsl
         aYjkieSTwsv2IQbxH9yLUe1oIbQD4rYoDNSTA/i5ZM93z42KKoKCZiTY9VYuWd3AkSTe
         SqvA==
X-Gm-Message-State: AGRZ1gIB5S0DwelMkKYgSgEtFLjqZf4e4uBLsAbObUMfeQMoBJmOPfHD
        if+YMSn7wKulsEMML7/cDFU=
X-Google-Smtp-Source: AJdET5c2PW5gTtja9ILqOgthh68LdfwCQUXocsZJiVkLt1I8eqOnxD1qj3RoUVbJm0XGPYGXqLjG8g==
X-Received: by 2002:adf:bbc5:: with SMTP id z5-v6mr9245975wrg.183.1542371383665;
        Fri, 16 Nov 2018 04:29:43 -0800 (PST)
Received: from szeder.dev (x4db1f8e7.dyn.telefonica.de. [77.177.248.231])
        by smtp.gmail.com with ESMTPSA id s81sm10881916wmf.14.2018.11.16.04.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 04:29:42 -0800 (PST)
Date:   Fri, 16 Nov 2018 13:29:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 11/11] fast-export: add a --show-original-ids option
 to show original names
Message-ID: <20181116122940.GL30222@szeder.dev>
References: <20181114002600.29233-1-newren@gmail.com>
 <20181116075956.27047-1-newren@gmail.com>
 <20181116075956.27047-12-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116075956.27047-12-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 11:59:56PM -0800, Elijah Newren wrote:

> diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
> index d7d73061d0..5690fe2810 100755
> --- a/t/t9350-fast-export.sh
> +++ b/t/t9350-fast-export.sh
> @@ -77,6 +77,23 @@ test_expect_success 'fast-export --reference-excluded-parents master~2..master'
>  		 test $MASTER = $(git rev-parse --verify refs/heads/rewrite))
>  '
>  
> +test_expect_success 'fast-export --show-original-ids' '
> +
> +	git fast-export --show-original-ids master >output &&
> +	grep ^original-oid output| sed -e s/^original-oid.// | sort >actual &&

Nit: 'sed' can do what this 'grep' does:

  sed -n -e s/^original-oid.//p output | sort >actual &&

thus sparing a process.

> +	git rev-list --objects master muss >objects-and-names &&
> +	awk "{print \$1}" objects-and-names | sort >commits-trees-blobs &&
> +	comm -23 actual commits-trees-blobs >unfound &&
> +	test_must_be_empty unfound
> +'
> +
> +test_expect_success 'fast-export --show-original-ids | git fast-import' '
> +
> +	git fast-export --show-original-ids master muss | git fast-import --quiet &&
> +	test $MASTER = $(git rev-parse --verify refs/heads/master) &&
> +	test $MUSS = $(git rev-parse --verify refs/tags/muss)
> +'
> +
>  test_expect_success 'iso-8859-1' '
>  
>  	git config i18n.commitencoding ISO8859-1 &&
> -- 
> 2.19.1.1063.g1796373474.dirty
> 
