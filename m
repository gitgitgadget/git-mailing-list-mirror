Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE59B2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbdJJSO6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:14:58 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:50154 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbdJJSO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:14:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id l188so18065482pfc.6
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yl0o3LH0m89+I7KGD0yw7aSKygwLMg2CFhvSmXiN/7A=;
        b=Yr4gDvbiOOUbpnWYYJkdM0IfnkGSO5Oup8wKq9j5qjj4jjRp6ND5eWGWuZUfv3kBTF
         yAY44nA7LtxabzHT6NOLMzTcrVxsh9qILvXPWDyDn7MJLqUKN0wL1k5IiJbZHsYA7Y04
         LcnJzFb70kARk83nBUcNjEfldvh/8jttl89F8AyP8RtrGHR7bTK6ZTJPO09+URFRzyNa
         poapEXxX8uBHhDH/jReKxZ+08wYr75aq/qEBg9P3EgIF4riJUApgZlPhaep+MSvDwU0i
         vSd3UQ0qIP3dwu49yjuEQe+In5MpZtQr/9g8mGTVLLAmYDbn3HSs9Vs4pMU+0jMvCdHV
         sR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yl0o3LH0m89+I7KGD0yw7aSKygwLMg2CFhvSmXiN/7A=;
        b=G7IccGz7BOhBYQA156e1T9481FjrH4eLrRTRh0JArh4nzAVp1yiL9DicunhUaBygx6
         S5q/4AqIrl3hSsO18n6UpVCv421dlwndyGTVdu5ZsIUvOOcEDBrGZTgXzGwswPph2OYE
         XY4fxnggT6F2D/QCj6NN8T4VK7NyRveykt9257lLRJsR80Oe4m5YMkcFhmmAgQDHJDDi
         Q3ISf03CbeMCTBwWJzrnGKzXM5H/oItjGhnr5e22Ihv3B19rVBkHl7MoiMT2n6MNrb6H
         AaEV74lgDMYzHmqI9db1xMNnA2++tY9wxxSSfGzjVmlCduIojFNf2RO/uvSiyBny4LrU
         imzQ==
X-Gm-Message-State: AMCzsaXUgPv+2nJbk+RN10JuJmIfs5MdFrP+lHK3KzzhXZ5CnVUA4MnW
        /9S3RJf3A94Fm3qng/CRbbN0jQ==
X-Google-Smtp-Source: AOwi7QDv6b4EwkrV09voJVXkJYZo/ScVHCGJpmugSwEqIm1q6IcgDyoiYQLYGdXyarjGDC6oG8annQ==
X-Received: by 10.99.99.71 with SMTP id x68mr13260433pgb.334.1507659295297;
        Tue, 10 Oct 2017 11:14:55 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:961:a8fe:b03f:d840])
        by smtp.gmail.com with ESMTPSA id b23sm23911651pfm.148.2017.10.10.11.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 11:14:54 -0700 (PDT)
Date:   Tue, 10 Oct 2017 11:14:53 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 01/10] connect: in ref advertisement, shallows are
 last
Message-Id: <20171010111453.21d858dc38d8bfe6590c3579@google.com>
In-Reply-To: <20171003201507.3589-2-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-2-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Oct 2017 13:14:58 -0700
Brandon Williams <bmwill@google.com> wrote:

> +static int process_dummy_ref(void)
> +{
> +	struct object_id oid;
> +	const char *name;
> +
> +	if (parse_oid_hex(packet_buffer, &oid, &name))
> +		return 0;
> +	if (*name != ' ')
> +		return 0;
> +	name++;
> +
> +	return !oidcmp(&null_oid, &oid) && !strcmp(name, "capabilities^{}");
> +}

Nit: If you're planning to parse_oid_hex, you can strcmp with
" capabilities^{}" directly (note the space at the start) instead of
first checking for ' ' then "capabilities^{}".
