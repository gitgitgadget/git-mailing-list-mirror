Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A30620372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdJFWBF (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:01:05 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:56474 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbdJFWBF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:01:05 -0400
Received: by mail-pf0-f169.google.com with SMTP id g65so10152433pfe.13
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pB7yE2FO1zBxuoOrj74Y4YyFD7QDIbpfo8ISYaSwtJo=;
        b=LeA7xHY+yMGxvaU6KMv83aUy8gaRgiA3OAaUjhgE245YMyEib5VDRmCwGe8sJqh/Rz
         vbAa5ZEMqsOsbPXEChLPIy2Njyoat3p8Ukw/K1YUS5imds1FIGRuSWvZQEqzTpVRgNh+
         bcq9kZYrC9nVq85V4XdhJBYNt1hnWbFqnppDqpTI5/NGiTNKIkO9ULZY6UGK76nmHcCo
         oiHyGpjfhChlkP5YPWWQpfrc93/SaFeRbFaooWZ6+CFi/bKyh+WtVetFqteFo9d62XKR
         r1egL18pjX+FML+3GEaTJymRaE1zGDLBpe8ieS0WiiFZT2C4w8LUCIoFpwarP5GZCVGx
         10aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pB7yE2FO1zBxuoOrj74Y4YyFD7QDIbpfo8ISYaSwtJo=;
        b=uIkkslqFC7bCmX3kNj8ClPevvD0LLk8CZnVY9FNAQ/JoI1EtyLAhkDnqPKOVnOOK+5
         QS8CxPufmbvEhfwud06MF4Xx5EScY2bmVnE7x6wfalKadpZ8AMuyOlNL/WVNa79hK7nv
         7I4CcONvS369czwRLwfgvrrjn1ibMnBICZRmAlpn9yACS2KRA1FwfMZ8uwnXG8VI5Rzq
         TE8XINITapitnA01uqNgBLSWrTvSBVlWLBRAeRIlVVIPfnleFi3jnwW1oI9MPgbo0LFc
         n1JQyTSPWVXgOqYTj792H1fpDLeOTkPEHG3QkRcSSeGWlDf8LEEprI9VhHYyjXoL8ofI
         MNxw==
X-Gm-Message-State: AMCzsaWBLoKcrhCsbFUHTZ07D1bcxN7PZzSI0F1jkVGYu7HRS3QqLPRP
        v0jgPKosMcw1AXvesB4IL/s=
X-Google-Smtp-Source: AOwi7QB1X0417AFtmw7lHMBP2kX9j6bU0+iSr/GcMzQAhrO9kR4qQLsInHHMvtrd4+kbkGbQ5/CySw==
X-Received: by 10.159.197.67 with SMTP id d3mr114882plo.433.1507327264392;
        Fri, 06 Oct 2017 15:01:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:78c3:3d0d:a9b5:4320])
        by smtp.gmail.com with ESMTPSA id n129sm4592314pfn.78.2017.10.06.15.01.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 15:01:03 -0700 (PDT)
Date:   Fri, 6 Oct 2017 15:01:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] tests: fix diff order arguments in test_cmp
Message-ID: <20171006220101.GZ19555@aiede.mtv.corp.google.com>
References: <20171006190006.19623-1-sbeller@google.com>
 <20171006190006.19623-2-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006190006.19623-2-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Fix the argument order for test_cmp. When given the expected
> result first the diff shows the actual output with '+' and the
> expectation with '-', which is the convention for our tests.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Yes, this should make the output from failing tests easier to take in
at a glance.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

How did you find these?  E.g. is there a grep pattern that reviewers
can use to repeat your results?
