Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23C71F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732648AbfFMPTa (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:19:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36005 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733138AbfFMPTX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 11:19:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id u8so10561947wmm.1
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 08:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PNMKz9+IT76maURJOdKM+NVF9VRY+uieauUDIQzwypQ=;
        b=aMiLpdlzf8s9h3t9mc4UK5YbUUxVzcxcjWXaY4Su4emfLmhJ5U6WVf+IWk2BA6Io+K
         5gYGI1db8DYc68Cn4jO8IKKkPlAEoEq/HTyu0Dv1z9GBYxLknyonG1pK90zD5i44hJpr
         DGj9IGmNogKVfUs9hJd1u8ZQfuikqtWAOY2pDcuj5H2f1HJ8yZ5+QeuMvvFYXsO4bMVg
         mqZwYwyvZaOWxAc9VabugyrEdJh2ZmUVAC+S/r+iRIYGnbtlinep8vNJRqunUFz5bVZK
         t/ub1zzebrokChxRmJel88cNIl1uigRI7RvTNhgjP3qlSKKsK2nts4FViDF5DqfUJp5s
         EVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PNMKz9+IT76maURJOdKM+NVF9VRY+uieauUDIQzwypQ=;
        b=RSuhhH73XSNqiTOwJiN7+OaiihySoUHID2/lLbS8Kc4u3OwIf0vtk/1xfQQ1E8h1m6
         f8lFm0V+VNUykdYmkF85UxrKXUzTPUuSdjTPZ8R+qM37g3OsrgSIORIW3wxMBjxHqdek
         AEvQSZsWOzPrABD44KTMkbxGWCby3ZahbJSewYObLXbvN+GOjXDD9+ovt9gLvb9hZWiP
         M3qJFredOBBGvXSYDmmMQSOw3WwlRFal12vjx7B5vG/lZpKXWfg4z5SQJT1Jwmo66OfP
         K93exMKh0Xq9mR3zV3pCgF5I/0oLLh6yg6j190j6x7sDs+iQGcsy0M5FDyEeKVzgctT3
         2Jzg==
X-Gm-Message-State: APjAAAWK3k0+sqtHGsK3oflz9KP+JWhOMzA7gSBu3cz2/lf5GGmGCzGn
        MXEIcm9/d+5BNGJFWxBNG0s=
X-Google-Smtp-Source: APXvYqz5h9yVn2PLkCUKkCjAPsvlW/+8mEI/vJ/hQd0yHZRI72xa42hmQEZcyN454aVOreh+ivFqWA==
X-Received: by 2002:a7b:cb84:: with SMTP id m4mr4556155wmi.50.1560439160814;
        Thu, 13 Jun 2019 08:19:20 -0700 (PDT)
Received: from szeder.dev (x4dbd2f68.dyn.telefonica.de. [77.189.47.104])
        by smtp.gmail.com with ESMTPSA id a81sm268796wmh.3.2019.06.13.08.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 08:19:20 -0700 (PDT)
Date:   Thu, 13 Jun 2019 17:19:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        jacob.keller@gmail.com, newren@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v3 11/16] t: add tests for restore
Message-ID: <20190613151918.GB31952@szeder.dev>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
 <20190425094600.15673-12-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190425094600.15673-12-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 25, 2019 at 04:45:55PM +0700, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
> new file mode 100755
> index 0000000000..73ea13ede9
> --- /dev/null
> +++ b/t/t2070-restore.sh

> +test_expect_success 'restore --ignore-unmerged ignores unmerged entries' '
> +	git init unmerged &&
> +	(
> +		cd unmerged &&
> +		echo one >unmerged &&
> +		echo one >common &&
> +		git add unmerged common &&
> +		git commit -m common &&
> +		git switch -c first &&
> +		echo first >unmerged &&
> +		git commit -am first &&
> +		git switch -c second master &&
> +		echo second >unmerged &&
> +		git commit -am second &&
> +		test_must_fail git merge first &&
> +
> +		echo dirty >>common &&
> +		test_must_fail git restore . &&
> +
> +		git restore --ignore-unmerged --quiet . >output 2>&1 &&
> +		git diff common >diff-output &&
> +		: >empty &&
> +		test_cmp empty output &&
> +		test_cmp empty diff-output

Please use 'test_must_be_empty'.

(and perhaps 'git diff --exit-code common'?  dunno)

