Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 761A51F859
	for <e@80x24.org>; Fri, 19 Aug 2016 23:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755048AbcHSXwn (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 19:52:43 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:37097 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754598AbcHSXwn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 19:52:43 -0400
Received: by mail-it0-f49.google.com with SMTP id f6so38338190ith.0
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LhcQoXxfo6IW23HH2R8UpBOjPVI14YvNCExHVa6acXs=;
        b=Ewn9x084/KLRgmQ2WJuyxjXVqPA3bC92QcpwtwEx383HRZwNx3hEohgin7qCycoVSg
         Rjo2yaH8QA6rxVLxF05DNsNSaxWr1KGle2lmzxJi4fO8wVbvJ7ff0RJ9w4MYKEmC2SVU
         14PPA9MVCnwrwCqzmm4RmVpi3ijSGpMbk7hDS0hZpQyqOP92x8zGYKQ7lKO2G59ZMo8H
         BKU3gYhZSRpVwkUaZx80QauOUfA6MN03p986Kjykgl4NsrPwM6IkPnNrB7+Xsh3vNGSm
         +skCiJCko28uyOweMWFKk1lWTrdD3l5UoDwHXelXBuKduUyL9Q9D03oXjwh9XschfvQ6
         uqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LhcQoXxfo6IW23HH2R8UpBOjPVI14YvNCExHVa6acXs=;
        b=M7mUkIMVUTbZJdku6hAu9PHXlgEWF13jKxsSBedb0j1zryYfmloMq1fvfR8vb3ymFC
         BaVdLY5VT8tacZ4sgz13yb1SvC0aA3YnoU9cFMP6fFKiUcMelhvnap4AGUd45yIzTbu9
         1jErW6X/dK5Dz4Tftz2N5zZtyGUGxxJsnQ5iAj5W0FrWgU238KCEqUb6NRD2Et578UdT
         IinvY3YJcleTPX35XvkVacz9sV0RZV8wOUgN1WsbUOlwYErK51HYVuzjk3fuZExs+Bab
         O3c0wLwMZCRrces4BSNvjyfWxsVelUumopXlu4hXFcM9QjgZM3lVt2OYJs2QZd51ipPA
         zx9A==
X-Gm-Message-State: AEkoouv6CFqn1FVQRsI2UDQwoxBtULWr1EDgz0lMUm+CzWxcxDDPvbRC8ZB6wW2ROg0NQl6oyK6fwH39ge+mC+nU
X-Received: by 10.36.92.206 with SMTP id q197mr9371378itb.46.1471650365271;
 Fri, 19 Aug 2016 16:46:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 19 Aug 2016 16:46:04 -0700 (PDT)
In-Reply-To: <xmqq4m6h69wz.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m6h69wz.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Aug 2016 16:46:04 -0700
Message-ID: <CAGZ79ka3QEMUV6YYa74UZPZXQA1hnbCCZOCG9jZt1BPjJ0Kb8Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #07; Thu, 18)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/submodule-clone-rr (2016-08-17) 8 commits
>  - clone: recursive and reference option triggers submodule alternates
>  - clone: implement optional references
>  - clone: clarify option_reference as required
>  - clone: factor out checking for an alternate path
>  - submodule--helper update-clone: allow multiple references
>  - submodule--helper module-clone: allow multiple references
>  - t7408: merge short tests, factor out testing method
>  - t7408: modernize style
>
>  I spotted a last-minute bug in v5, which is not a very good sign
>  (it shows that nobody is reviewing).  Any more comments?

nobody except you ;)
