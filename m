Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D1AF1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 11:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfAWLLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 06:11:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38822 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfAWLLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 06:11:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so1553362wml.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 03:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nDMntuz5QFW2UxqwDtQSse7tnWINhr/XmYr4Eirj1VQ=;
        b=i+a8cO+AOfeJ9la3LfraUvAzL9huXEitfi0U2JtDJDyjUJ64SoSvCl1Yd5GUFDBP7/
         UP9OcjGLCwe7kbGWgxhZuw8vG8pFps9t9vRE39WNtoDttOAtCTPKaG82G78KCyFobnwS
         wMncj+XTzPcq/g6Ica26xtuirdrfSQB/UsfeauD7qmDaFSBOM7/flCfWhGdOHW7lU0Zv
         NwGsyUzDpZ14P3wSHz0+0OCeuyh+YirTvynliAZ1rLLSFVN4GnUeEVGZuUg+h0/H7r6z
         tpM8S0ViRbQRn6XGCbE7e4+6DI6WM5CTTAuEEsz45wEdwd0sqkrjyUcbIDBuBnwby+tx
         kH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDMntuz5QFW2UxqwDtQSse7tnWINhr/XmYr4Eirj1VQ=;
        b=fWOmNy5w74mKQ5j3H9rCHfPQu+53tnXcrHW8PaSEpWFaIreg2PClbpagwViB2G9/og
         GtANgxIyjgb1oc7/6OAevb/CemMH7igUmjphI57q4eQcuj05wT8vwnNExPAFy0hvcRL2
         ZKGRY0ywbndO2sozz++oexnJkR/lM1EOlLQY+Z9+cP7UvyPHH5OgzHtLgCixiI51qNx1
         nBF/R30aHR82It9saXtqOABR0MR88xNJOpk/EnBP7Frxr93vbagYxNerHG4B9dzJ+er0
         neggVC//f7rnh5vaImyRicJ9a1nwoMI1dGAgGOEazY2OWcsGAHXBO2msOQ/O7Xfy0KSo
         z90g==
X-Gm-Message-State: AJcUukf8eS3o+oR3gBQ33yi9lzJrSgY6DdkHdUiGm3mL7tro9nIEw6Ga
        t7Hf90Ud2GLC63aFxve7Pq0=
X-Google-Smtp-Source: ALg8bN5/reGkZZ4Vy+aeMnQk2QFG/JI0rBvc9O3iOo60oWI2bWDbsL9PIPC/0u414SYmkh8pK7Y1xQ==
X-Received: by 2002:a1c:ac85:: with SMTP id v127mr2081569wme.62.1548241880324;
        Wed, 23 Jan 2019 03:11:20 -0800 (PST)
Received: from szeder.dev (x4db59613.dyn.telefonica.de. [77.181.150.19])
        by smtp.gmail.com with ESMTPSA id y138sm65198759wmc.16.2019.01.23.03.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 03:11:19 -0800 (PST)
Date:   Wed, 23 Jan 2019 12:11:17 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     David Turner <novalis@novalis.org>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1512: test ambiguous cat-file --batch and --batch-output
Message-ID: <20190123111117.GS840@szeder.dev>
References: <20190118033845.s2vlrb3wd3m2jfzu@dcvr>
 <a7307f431e2231dd420a0190a22aa38094cd593f.camel@novalis.org>
 <20190118104519.fqpzirux5qulkcwa@dcvr>
 <672a6fb9e480becbfcb5df23ae37193784811b6b.camel@novalis.org>
 <20190118222629.3nvcos24gmi6xe4i@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118222629.3nvcos24gmi6xe4i@dcvr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 18, 2019 at 10:26:29PM +0000, Eric Wong wrote:
> Test the new "ambiguous" result from cat-file --batch and
> --batch-check.  This is in t1512 instead of t1006 since
> we need a repo with ambiguous object_id names.
> 
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  t/t1512-rev-parse-disambiguation.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
> index e4d5b56014..b0819630c9 100755
> --- a/t/t1512-rev-parse-disambiguation.sh
> +++ b/t/t1512-rev-parse-disambiguation.sh
> @@ -388,4 +388,14 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguous commits are printed by type first
>  	done
>  '
>  
> +test_expect_success 'cat-file --batch and --batch-check show ambiguous' '
> +	echo "0000 ambiguous" >expect &&
> +	echo 0000 | git cat-file --batch-check >actual 2>err &&
> +	test_cmp expect actual &&
> +	grep hint: err &&
> +	echo 0000 | git cat-file --batch >actual 2>err &&
> +	test_cmp expect actual &&
> +	grep hint: err

The 'git cat-file's error message and hints are translated, so they
should be checked by 'test_i18ngrep' instead of plain old grep.

> +'
> +
>  test_done
> -- 
> EW
