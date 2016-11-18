Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CAC41FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 21:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbcKRVeG (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 16:34:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36372 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbcKRVeG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 16:34:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id m203so10241827wma.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 13:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7C69ftbH+yyVHZ+kMmpXnngD75Kg9YqbEwHY0gCS7pE=;
        b=iujXnVKqdq9k86KXdViXMA3fQZOfe+/fwHV+/h1dScwj514YJGGxLwEdN4aBbyyCUK
         5heHa2xH20GrsLFR1dsTiwDd6xQW8gYaTZnqUFnxe9LRWccXq0s357xaaxLgtOUL5ZkA
         RyN+uXqHu/DktV2AU+cpHkGiDCwoo7AiAZDT2TOxrl/kRSpvPrC4cgoW3jHKxrWBfMaW
         mk+oEN1LUbxvfkYhLAYtZt96nB6F8W8MZuNtOhxjc3Zomd6Dkj5iH2dsjviDREOdG2mc
         hQdfdIC6NAzOXq7bK7NwIUOifPr+DMDuSYS5+F0KlN0Gb3w310i9j123KfwThs2vUhil
         W9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=7C69ftbH+yyVHZ+kMmpXnngD75Kg9YqbEwHY0gCS7pE=;
        b=Rc/c20IgSxJ2LLWoSsLR7dZJhvDt2+A8AJeVqg2OWnvNwIb7Kb0kXffGqgI1K+KHut
         avu9GGHAdcXAQ/+BGQwzAOGlG3lJf/bm24AAclc0P3QJfhrRxvIbNKXeaLwYhJ/Smcip
         xNT5fEEwESXXW9xol9W/QyxQCPY/tPrBpSZOpYziv/FaircJWAAXCF0h8l1sIddHogl3
         dEDvTxbY6EKNE4SJ1Ow33SykgbOR9XAbJOje5xhdNxnF36h3erTNROqLYr00fpSEGtED
         xsYDDA5fa8HFcyRD3n1vAGDPKhDh6Ipz6XJ6Sj5XbPJXQaz1fZzC1deIw6ZHXsuqOqrO
         Dy/Q==
X-Gm-Message-State: AKaTC018bOF9Y92jJm2x4fqmDOJg+sn21cx1MNRyK7K5xPS9e7RB8MfJ8u+v36VxuAshhQ==
X-Received: by 10.194.172.42 with SMTP id az10mr1125393wjc.145.1479504844273;
        Fri, 18 Nov 2016 13:34:04 -0800 (PST)
Received: from [192.168.1.26] (acuy2.neoplus.adsl.tpnet.pl. [83.11.104.2])
        by smtp.googlemail.com with ESMTPSA id m145sm5410126wma.3.2016.11.18.13.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Nov 2016 13:34:03 -0800 (PST)
Subject: Re: [PATCH v7 09/17] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
To:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
References: <20161108201211.25213-1-Karthik.188@gmail.com>
 <20161108201211.25213-10-Karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ce2862d5-874b-f244-f9b3-f74e18f7ad42@gmail.com>
Date:   Fri, 18 Nov 2016 22:34:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <20161108201211.25213-10-Karthik.188@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 08.11.2016 o 21:12, Karthik Nayak pisze:
[...]
 
> Add tests for %(symref) and %(symref:short) while we're here.

That's nice.

> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
[...]

> +test_expect_success 'Add symbolic ref for the following tests' '
> +	git symbolic-ref refs/heads/sym refs/heads/master
> +'
> +
> +cat >expected <<EOF
> +refs/heads/master
> +EOF

This should be inside the relevant test, not outside.  In other
patches in this series you are putting setup together with the
rest of test, by using "cat >expected <<-\EOF".

> +
> +test_expect_success 'Verify usage of %(symref) atom' '
> +	git for-each-ref --format="%(symref)" refs/heads/sym > actual &&

This should be spelled " >actual", rather than " > actual"; there
should be no space between redirection and file name.

> +	test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +heads/master
> +EOF
> +
> +test_expect_success 'Verify usage of %(symref:short) atom' '
> +	git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
> +	test_cmp expected actual
> +'

Same here.

> +
>  test_done
> 

-- 
Jakub Narębski

