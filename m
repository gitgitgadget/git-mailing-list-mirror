Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240C71F462
	for <e@80x24.org>; Sat, 15 Jun 2019 13:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFONDD (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Jun 2019 09:03:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51860 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfFONDC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jun 2019 09:03:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so4980796wma.1
        for <git@vger.kernel.org>; Sat, 15 Jun 2019 06:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5uzVuTWqj1soOqCjj7NVlaT7vCnVw7clkLRApfjUYg=;
        b=E/oq3Xa4MXlgO1BJsJMiUXwBqPkaz1hWuLu79gKo8l2VWrEckn2zxX6S4XLd3N2ccQ
         eo2JU12rXvIIGXUIFJnft+SpHd04Viv+O49FIfUXfOZiVfhj/YWmJda6wh+/hKdqbk8F
         rL/dmiVNJedYqcOuNzX4nzzASBBJEiva59sa2d4k7COT6EvIw/RnxilpNpVHyKIm4PIQ
         PudRMZ1wZgyTNqo0OBCVQDABnuV7MP6W6ZShqZRyv03iHYc5Z0JTeQ7YUgOj6EY59GCT
         VwMN+HDvkfpd5sYh0jfBrjAf7sSt327bFTfgeqw0ezXiJ8RNjS731qL01gz140bYXgvA
         6gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5uzVuTWqj1soOqCjj7NVlaT7vCnVw7clkLRApfjUYg=;
        b=pbE5qXaz7Zfp7MkimJOJQ/2P+4hG3kuU/jcabeY4KRaDO2nAg1vyf3Wtwe0AJdOxyx
         YcgR8Shh48GNvoAGo78bnCNMRy7IK7iBr9FXL/qYrpnCYH7yD6Xt0gnq4TyXFEIEH5mi
         9nWyfGTTw538MUbNRjbMcEPLu3All28f/dLeyBl4K+lyHjvihqS/B1K5yzVqQ5CyF3EH
         2v4EXpepK1RUx36YtncNHQClEGx1sr6EUNFJJ5ESCycaViYXI7TBMyzDZGClB2zNfDVU
         /KeLAaoGIap+k0kCwKQY4juZmssd+vAa0QjAcI2mwou7UdLgmTrsMmH3DRPcmGyY7A0t
         AXSg==
X-Gm-Message-State: APjAAAVfx+Y/MSAjWzf/sJneVkXklWpFekiUBMFGaJCor4q2rxk3e7Yn
        cM4wAzyUGVVORh/Wm5XpND0=
X-Google-Smtp-Source: APXvYqxEqCYgWBW0g2UV9QTHhx5vwmhhsH/tUxYdm5Xsbe/EA2dS/ke5FH8XsMRoudtYAlH2QLYz6Q==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr11391725wma.118.1560603780738;
        Sat, 15 Jun 2019 06:03:00 -0700 (PDT)
Received: from [10.30.1.10] ([185.216.34.233])
        by smtp.gmail.com with ESMTPSA id x129sm8209402wmg.44.2019.06.15.06.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 06:02:59 -0700 (PDT)
Subject: Re: [PATCH] stash: fix show referencing stash index
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        ungureanupaulsebastian@gmail.com
References: <20190614074207.mxidz3h573mtd43x@glandium.org>
 <20190615112618.GC11340@hank.intra.tgummerer.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <78f730f1-d40e-1415-b6a6-4a1b224e7818@gmail.com>
Date:   Sat, 15 Jun 2019 15:02:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190615112618.GC11340@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/15/19 1:26 PM, Thomas Gummerer wrote:
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index ea30d5f6a0..3973cbda0e 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -708,6 +708,24 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
>  	git stash drop
>  '
>  
> +test_expect_success 'valid ref of the form "n", n >= N' '


If ref is valid, 'n < N' was probably meant here.
