Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 795EC1F462
	for <e@80x24.org>; Sun, 16 Jun 2019 19:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfFPTCI (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 15:02:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41911 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfFPTCI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 15:02:08 -0400
Received: by mail-io1-f68.google.com with SMTP id w25so16540507ioc.8
        for <git@vger.kernel.org>; Sun, 16 Jun 2019 12:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZ+g9eyFGLzeQ/8b2lwmaZF1KWozpN7+9Czn5Moq7LA=;
        b=fERo7j0uki6LzGzNxBTQDU47wBGRjfPO9iyc/Iq4N/rGJnh+YqMR1i2aBvSD4NDkSJ
         CA6FXYj4GNElI8eWYm/Qy2MOMHU1ZRv6tZm6vuFixctqx+9+11WsOMQEoLLHQbZ+fmFS
         /AFxtbzzZZwhc4ixcRMonu/rv6EZ6cA5t4eaCqkSzPdtcHznAW8h3RhSPZNYW8p+GWlS
         /orFjvOZgGDzJlGeErsMNOzcbaHXGYBdkR4vqiTzAag4CwPTTYu+nzKbxYOj1Llg65se
         H/UXXaht72POSpEG/XlUWySRf9v7JamKvQHY4r7q3wdbRBhAo+gDQHixTkmZ0+qj66XL
         kuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZ+g9eyFGLzeQ/8b2lwmaZF1KWozpN7+9Czn5Moq7LA=;
        b=CYqpg4WQtCXmi78AVfE1xuom3xFSu2cC3AdbIWcy4sFxIGa68U6SNcpopoVzc1aOxQ
         XHib9ZkwJP916b0IO6+8sQw2wCJfJ7Sdq5Jvo8zghp1O+fHqZ8UFUWsLI9jOKOtshhGR
         4xCozZaMgwSFkeg97RiQHiUNay+mj6M8xhccfVTqT3bcFcW5+ZHkvfRyaIQ/ijrhFysz
         s9AjvBOds91ESCAZJtn6D/7/ObeAPpwdR0yPC9li/wUt7YvAs+5LlKpoH0nlSk43mtIc
         /eDeJ4zDNQmuqHgKh84dW7Q4f13iA0f9qo9nrcjExVNA1e0Bq/OaF/q81zK2bD9W13sp
         II3Q==
X-Gm-Message-State: APjAAAWs4K5YJOSg6aU4V9SBPuUvZGYImN6karKmIgI6SC2AYbOhfrVj
        8EP+GTPHjymg5MJ3G6Rzlmc=
X-Google-Smtp-Source: APXvYqzul/TzOQp2ZXaY/haW5FhusYABpjZgQGhXnS3p/GklOVA6txvRhGwbGBQTD1L75k56bd8P1A==
X-Received: by 2002:a6b:e00b:: with SMTP id z11mr16198054iog.27.1560711725965;
        Sun, 16 Jun 2019 12:02:05 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id j23sm8985530ioo.6.2019.06.16.12.02.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 12:02:04 -0700 (PDT)
Date:   Sun, 16 Jun 2019 15:02:02 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     michael@platin.gs
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] Use an intermediate file between between git blame and
 sed to avoid git blame's exit code being hidden.
Message-ID: <20190616190202.GA15262@archbookpro.localdomain>
References: <20190615184039.3711-1-michael@platin.gs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615184039.3711-1-michael@platin.gs>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the patch, Michael!

On Sat, Jun 15, 2019 at 07:40:39PM +0100, michael@platin.gs wrote:
> Subject: [PATCH] Use an intermediate file between between git blame and sed to avoid git blame's exit code being hidden.

For your commit message, the usual convention is to first specify the
area you're working on followed by a colon and a brief summary.
Typically, the subject starts with a lowercase character and also
doesn't end with any punctuation. See [[describe-changes]] under
Documentation/SubmittingPatches for more details.

For yours, I would reword your commit message to something like

	t8014: avoid git command in upstream pipe
	
	Use an intermediate file between between git blame and sed to avoid
	git blame's exit code being hidden.

In addition, your commit message is missing a sign-off line. You can add
one by passing `-s` to git commit but you should read about what it
means in [[sign-off]] in SubmittingPatches.

> From: Michael Platings <michael@platin.gs>
> 
> ---
>  t/t8014-blame-ignore-fuzzy.sh | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t8014-blame-ignore-fuzzy.sh b/t/t8014-blame-ignore-fuzzy.sh
> index 1ff59624e9..13f3313710 100755
> --- a/t/t8014-blame-ignore-fuzzy.sh
> +++ b/t/t8014-blame-ignore-fuzzy.sh
> @@ -332,7 +332,9 @@ test_expect_success setup '
>  for i in $(test_seq 2 $last_test); do
>  	eval title="\$title$i"
>  	test_expect_success "$title" \
> -	"git blame -M9 --ignore-rev $IGNOREME $i | sed -e \"$pick_author\" >actual && test_cmp expected$i actual"
> +	"git blame -M9 --ignore-rev $IGNOREME $i >output &&
> +	sed -e \"$pick_author\" <output >actual &&

We should take advantage of the fact that sed can open its own input
here. So we should drop the `<` and just pass the filename to sed. Same
applies to the below.

Thanks,

Denton

> +	test_cmp expected$i actual"
>  done
>  
>  # This invoked a null pointer dereference when the chunk callback was called
> @@ -357,7 +359,8 @@ test_expect_success 'Diff chunks with no suspects' '
>  
>  	test_write_lines 1 1 >expected &&
>  
> -	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file | sed -e "$pick_author" >actual &&
> +	git blame --ignore-rev $REV_2 --ignore-rev $REV_3 file >output &&
> +	sed -e "$pick_author" <output >actual &&
>  
>  	test_cmp expected actual
>  	'
> @@ -387,7 +390,8 @@ test_expect_success 'position matching' '
>  
>  	test_write_lines 1 1 2 2 >expected &&
>  
> -	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 | sed -e "$pick_author" >actual &&
> +	git blame --ignore-rev $REV_3 --ignore-rev $REV_4 file2 >output &&
> +	sed -e "$pick_author" <output >actual &&
>  
>  	test_cmp expected actual
>  	'
> @@ -424,7 +428,8 @@ test_expect_success 'preserve order' '
>  
>  	test_write_lines 1 2 3 >expected &&
>  
> -	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 | sed -e "$pick_author" >actual &&
> +	git blame --ignore-rev $REV_4 --ignore-rev $REV_5 file3 >output &&
> +	sed -e "$pick_author" <output >actual &&
>  
>  	test_cmp expected actual
>  	'
> -- 
> 2.21.0
> 
