Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4254A20248
	for <e@80x24.org>; Sat, 30 Mar 2019 19:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfC3Tir (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 15:38:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39984 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbfC3Tiq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 15:38:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so6701701wre.7
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 12:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xcjg7IM8gFGAbSZIGxK0kr03qbNI6pY1+eUx2sq9sW4=;
        b=ens7r86UUKoYlvZ2znEcieuhNDq3S5By3sa8aVEdINBi3lvt88nIIybsIWnPCZyOQD
         cm25DwhSar0WvWRROTN7Pf/N7bhj6PIqIXOnExZ9ZZTcreLredZC9zTg/Vyi7GEIr6t/
         dPEHSGwm++n+Q8oHCr4wv6JjliK/Fj6u/hxUcTJTAaPrVXnVrFJQ3FX+QUJ32tEHrXHG
         XGSrMLMjnJ+pEdI1Mq1XZIP9XrOtZBXIDEcC/ACrl95iDNbs6vh9X0NGoPYWlQ8mqi66
         YKm1CEK5vQTBBWX8dsO/VK04RRvaDSsjiCcZMhkjc9A+p3QInFuMGWFTqcpXSn9DLXnn
         2iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xcjg7IM8gFGAbSZIGxK0kr03qbNI6pY1+eUx2sq9sW4=;
        b=BE3/WaL4h8EkzdbEXBcRXFHCo1ch0pDi/EZ6NGzfDDbYI8wxWVKukF1yYONaih5xCH
         pog8JZc6HvaCcsgo/Uq90rC+Dl1lTdxq8VPO+2uPft/dFBloFNidMJ4JC0qaFBjYfZ7s
         /EK5yoU8UjaDqYJCM6IBpx8ZHBMkw4wRN8hOH8HQiZoWNcROLLTaTNoD+KmMVTY/QKT3
         46v+R+reAy08x+JgE4/cYawlcJplsekvGYE5JsJKtGSfsFKe58Ne1AFSccCEdBFeahLs
         RiegI6nThVax7tYcy/P+fdqCQ9DAGOJmmR7bKHNafAv9dxRjKX4X0ZjsvzB5bS6/xDlj
         s7ig==
X-Gm-Message-State: APjAAAX96O0ke3QJ5Rklv5xcpOvmBJDwAWvhNdugNGc/SeAXL0X0Fg8N
        gc23rn9PhqzHkvGbGkGQ2Fa2NeLh
X-Google-Smtp-Source: APXvYqzXFP9zm7q31DCIviPm30d3/OOZDB97dgRx5d0MEr+3j8aByQSzpKktErPwICsiLouOYkMygA==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr28450661wrw.174.1553974725318;
        Sat, 30 Mar 2019 12:38:45 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id n189sm7267894wmb.28.2019.03.30.12.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 12:38:43 -0700 (PDT)
Date:   Sat, 30 Mar 2019 19:38:42 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [GSoC][PATCH v4 4/5] t0000: use test_cmp instead of "test"
 builtin
Message-ID: <20190330193842.GR32487@hank.intra.tgummerer.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
 <731463ed9892c283b6acb0ce69e097769e43de62.1553954776.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731463ed9892c283b6acb0ce69e097769e43de62.1553954776.git.ttjtftx@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Jonathan Chang wrote:
> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> ---
>  t/t0000-basic.sh | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 3de13daabe..49923c5ff1 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1118,16 +1118,18 @@ P=$(test_oid root)
>  
>  test_expect_success 'git commit-tree records the correct tree in a commit' '
>  	commit0=$(echo NO | git commit-tree $P) &&
> -	git show --pretty=raw $commit0 >actual &&

This line has been introduced in a previous commit.  If the file was
called 'output' there already, I think that patch would be just as
understandable, but this diff would be a little less noisy.

> -	tree=$(sed -n -e "s/^tree //p" -e "/^author /q" actual) &&
> -	test "z$tree" = "z$P"
> +	git show --pretty=raw $commit0 >output &&
> +	echo "$P" >expect &&
> +	sed -n -e "s/^tree //p" -e "/^author /q" output >actual &&

I'd find it a bit more natural to either first create the expect file,
and then do the 'git show' and 'sed' invocations in two subsequent
lines, or do them first, and then create the expect files, rather than
interleaving them.

I'm not sure either of these by itself is worth a new iteration,
unless there is also something else to fix up.  But it's something
that you might want to keep in mind for future patches.

> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'git commit-tree records the correct parent in a commit' '
>  	commit1=$(echo NO | git commit-tree $P -p $commit0) &&
> -	git show --pretty=raw $commit1 >actual &&
> -	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual) &&
> -	test "z$commit0" = "z$parent"
> +	git show --pretty=raw $commit1 >output &&
> +	echo "$commit0" >expect &&
> +	sed -n -e "s/^parent //p" -e "/^author /q" output >actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'git commit-tree omits duplicated parent in a commit' '
> -- 
> 2.21.0
> 
