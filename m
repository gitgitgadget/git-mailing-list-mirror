Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22ACA1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 14:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfJKOqz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 10:46:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43685 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKOqz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 10:46:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id j18so12228732wrq.10
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zUvaddg15GedM3GUO7aIE7HTqw5GmlW7t+hjuoyjLFY=;
        b=SBlv14JZLlYuRcAufPufrDtzPQQxMbChs/uNuMLQEZqh0HfIvhGP+fSMpLiTcXBPH9
         oFXbcv+kKuDSxiOPHjc0yW2l/UevFaOzoNdEBTp8GwlwAebx3wZRxLHiSUi87oTmm1ON
         mg/Za23VRk89F3FsIZ/ECp7Wvud2mYhlW9JGge/nMQ6zJcFNFG81ik4Tp1iHgAdemrk4
         h8Q1krdZFn5y/XnNXHz6FrEkuqbkfmVIsgrfJS+0u/qwrhBADHpZ2PEoNc3PlMi/snjh
         p35lZSx5a2ztu8pZS913zQkgbYWGa+GadZZgLx2S8dNM1/uMaC6v5+hOKHLiTCcBIIvr
         gpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zUvaddg15GedM3GUO7aIE7HTqw5GmlW7t+hjuoyjLFY=;
        b=dKlo4RO0SC7aGZNbH3gNtnh3BPeaDSj+GcpvyDNDvpXvBOrxc7phCnKAE63ZtrX9T8
         1p6CmkhCz9nVFFGDioIGCiOeLjcLSf9n02WS8GOOHfEpQTV7JNL8h9I9Aigy3YJyjxF2
         lowFQA4VtgtqXgAe0y5NG7pgI2nk5f0kROEm5GGt849yMYmNIoPGt2LQoj/vus5yxsT0
         isIietlvlVr8p8NGcJFDJPtwSMbBDdrPdGNcqqAW8OfwHm6w2YSUdLlmKdcYmA5eWynD
         b5Bmj6QkiMCC+/evcjHMPL7qguJ1DI/WDQ20YExwqvo/jbUYYAzk4XoOS2W55BOGx58t
         mcIA==
X-Gm-Message-State: APjAAAVpqsat9D27I6S9YG65DL+DiejqsvNMXzPy/w8VrddWyRcXdqXk
        ST6mImpzqn9NoA2p+q8e5FSzMnOL
X-Google-Smtp-Source: APXvYqwJxQ01Kz3E3tBwYtEHr4T/mHHhNTShLZW5o+UcEnz64shxKO08MUoMPxVc+TkRHuqgy2PI8w==
X-Received: by 2002:a5d:4a03:: with SMTP id m3mr1988216wrq.359.1570805213702;
        Fri, 11 Oct 2019 07:46:53 -0700 (PDT)
Received: from szeder.dev (x4db30d3a.dyn.telefonica.de. [77.179.13.58])
        by smtp.gmail.com with ESMTPSA id v7sm9141120wrr.4.2019.10.11.07.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 07:46:52 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:46:50 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] format-patch: create leading components of output
 directory
Message-ID: <20191011144650.GM29845@szeder.dev>
References: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 10:36:41AM +0200, Bert Wesarg wrote:
> Changes in v4:
>  * based on dl/format-patch-doc-test-cleanup and adopt it

Thanks...  but here I am nitpicking again, sorry :)

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 72b09896cf..9facc3a79e 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1606,6 +1606,29 @@ test_expect_success 'From line has expected format' '
>  	test_cmp from filtered
>  '
>  
> +test_expect_success 'format-patch -o with no leading directories' '
> +	rm -fr patches &&
> +	git format-patch -o patches master..side &&
> +	count=$(git rev-list --count master..side) &&
> +	ls patches >list &&
> +	test_line_count = $count list
> +'
> +
> +test_expect_success 'format-patch -o with leading existing directories' '
> +	git format-patch -o patches/side master..side &&

The previous test case creates the 'patches' directory and leaves it
behind, and this test implicitly relies on that directory to check
that 'format-patch -o' can deal with already existing directories.  So
if the previous test case were to fail early or were not run at all
(e.g. './t4014-format-patch.sh -r 1,137'), then that directory
wouldn't exist, and, consequently, this test case would not check what
it was supposed to.

I think it would be better to be more explicit and self-contained
about it, and create a leading directory in this test case:

   mkdir existing-dir &&
   git format-patch -o existing-dir/side master..size &&
   ls existing-dir/side >list &&

> +	count=$(git rev-list --count master..side) &&
> +	ls patches/side >list &&
> +	test_line_count = $count list
> +'
> +
> +test_expect_success 'format-patch -o with leading non-existing directories' '
> +	rm -fr patches &&
> +	git format-patch -o patches/side master..side &&
> +	count=$(git rev-list --count master..side) &&
> +	ls patches/side >list &&
> +	test_line_count = $count list
> +'
> +
>  test_expect_success 'format-patch format.outputDirectory option' '
>  	test_config format.outputDirectory patches &&
>  	rm -fr patches &&
> -- 
> 2.23.0.13.g28bc381d7c
> 
