Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD93E209A9
	for <e@80x24.org>; Tue, 20 Sep 2016 19:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbcITTe0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 15:34:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34822 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcITTeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 15:34:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id 133so5033756wmq.2
        for <git@vger.kernel.org>; Tue, 20 Sep 2016 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ThkY/G/mf+Ie7ZJ/ta0wXwFbVYm/2LC7bQvp2G9RiJM=;
        b=Y+cHOZWJ0uzTcX2t9isUh/GotFzbohExdeI2paeZijGGFjVOAxB/dkmR+hN6L09Ywl
         c+KYQTQHIloA9gSkeaungwBy1dmz/vXqVbiSPwIp49XsNV3/OqapoMyxz6fcemIchpzR
         JH5iPfxtPwVtSfdOvnKK/NwCzXe00NRCfFqkk3yILsLSL2L9VZMRVflggmLNQpNtcPS9
         7bMyivGCSe5X3NBz53erTELSlU5r4rOzgJ+9WbmMVtaJcB0ZmQhmRma2UivtP2RTbX1A
         erKyR4aGaUJPeN4SejuNwLqIhFTeuzxegjG+hBzmgKXCe0zKdAhZzoD8OV9Wq6VhCq9C
         2umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ThkY/G/mf+Ie7ZJ/ta0wXwFbVYm/2LC7bQvp2G9RiJM=;
        b=MW6uU+0SH1/jRv2T66WDVcU3UmrpFUIMlem/o0QbFuS7vNunEMetF97VDe78pAyy5Z
         NtFQaQreLzcvjQninLw2R4QMx9FU1tEskDJ/ARPXwltHRwnoZv91fN25o5C4D1DP4b5r
         MhczcJlHieALvq7zfgWaNw5MuH/xLQB5uOMj4p162IEJhh1rHAc5xBMlUcZdNS55BSwy
         XXvs+wzj+5h/gnlzrAJlIdCj58Gqkovp74sphcbpA5ygtddnVaJcL9R2+9TLfYQhgphu
         SSn+YKOHu3oTzVIHsPoeD7zw/X2jz6XLcsTUEc1Jky2mvie6rv+GZrxrZKRjFfc3D+HT
         I6GA==
X-Gm-Message-State: AE9vXwM4zewrnjs/LtSY48ps+cmGgFA4QygA0Hr8DIRN3HNOdTkHIfOIi+ZFIwxioNJNGg==
X-Received: by 10.28.113.16 with SMTP id m16mr4500804wmc.29.1474400063792;
        Tue, 20 Sep 2016 12:34:23 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id uw3sm29927796wjb.21.2016.09.20.12.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Sep 2016 12:34:22 -0700 (PDT)
Date:   Tue, 20 Sep 2016 20:34:44 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH tg/add-chmod+x-fix 2/2] t3700-add: protect one --chmod=+x
 test with POSIXPERM
Message-ID: <20160920193444.GG8254@hank>
References: <cee3c784-8f03-c524-2f67-d35cb3755a41@kdbg.org>
 <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5effaf36-d017-3ff1-1de1-d9b303c04f23@kdbg.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 09/20, Johannes Sixt wrote:
> A recently introduced test checks the result of 'git status' after
> setting the executable bit on a file. This check does not yield the
> expected result when the filesystem does not support the executable bit
> (and core.filemode is false). Skip the test case.

Thanks for cleaning up my mess.  The patch looks correct to me.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  I am surprised that add --chmod=+x changes only the index, but not
>  the file on disk!?!

I *think* --chmod is mainly thought of as a convenience for git users
on a filesystem that doesn't have an executable flag.  So it was
introduced this way as the permissions on the file system don't matter
in that case.  A change of that behaviour may make sense for this
though.

>  t/t3700-add.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 16ab2da..13e0dd2 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -361,7 +361,7 @@ test_expect_success 'git add --chmod=[+-]x changes index with already added file
>  	test_mode_in_index 100644 xfoo3
>  '
>  
> -test_expect_success 'file status is changed after git add --chmod=+x' '
> +test_expect_success POSIXPERM 'file status is changed after git add --chmod=+x' '
>  	echo "AM foo4" >expected &&
>  	echo foo >foo4 &&
>  	git add foo4 &&
> -- 
> 2.10.0.85.gea34e30
> 

-- 
Thomas
