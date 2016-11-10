Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7844320229
	for <e@80x24.org>; Thu, 10 Nov 2016 19:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbcKJTC3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 14:02:29 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36146 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755081AbcKJTC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 14:02:28 -0500
Received: by mail-yb0-f195.google.com with SMTP id d128so5272912ybh.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ukhm2IS/Ug+Ycj2jT0dVUkvIkfgfdDfJg1/AADKksFU=;
        b=u23WRNzKjhMvowzvassVrmImhVh7ufkJFg/vsfOYbGrL8WQ3FRQbzVh8giXdtkqnk2
         E/Q43Nic7Qrkl1no1pY3Li08ZcV6msZrntXoXDgw9mwyYCYHY50cxcP/Ff0IfUgQRdux
         tpzlVdoAAPlgXV0N7kzDYUNheY5JRlEsLxrPW/OY4LnYKrTHsvjj/bPAg33ggym6jnlv
         AE+aj2HS/SjrklxnfYFoZrGhQBzNWvnjRIyIvnh4sZhosYFIh/86EzOhHQME2jhL4dIN
         oX/SH4+dUNjbEgi4i0pk37Shig/5dZiltaKeSFznMo1Ry/Fq53bJqxWrK+rih5FsMuCw
         GKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ukhm2IS/Ug+Ycj2jT0dVUkvIkfgfdDfJg1/AADKksFU=;
        b=Kos1JkxJ1lqM+bVCYWNGnl/WEXhfJtBViz9Kie4F959sFrQtoyrUtDmdSwhEs/AM9G
         I29ZjPvEhGn13Xrz48OBqvwz3rk9XeAV7Vk1sdU+jO+Uxk2o8LxHpQrkz0znXPegrzWA
         O7exlnjgb6P60HHJL4yAto9cma5SCdPI5e2GXhPHWYPyVeWcRBArNZtRLm2E2qwMid2G
         pBK26XeTfkCVo6ejURX0Li+SXOQiOp44g2Q7QQRa51OVlHccnRxFOX1pIW4MrgpwV5bO
         8EAGHgqzwfYBhVNgAv6ePNCPQOKDzZ1K06GtpKUHHyTQz4+OXoEL3NdZOvKuhGbkAyBC
         QbkA==
X-Gm-Message-State: ABUngve6ymgfAJCNix5YtUcSMpmI1hvRMji4Wt0L7HpOpFx5zqHPM+7LkuknCgNyVQOecpCqoe7MY/PUyUP3Lg==
X-Received: by 10.37.27.212 with SMTP id b203mr6889463ybb.126.1478804547970;
 Thu, 10 Nov 2016 11:02:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Thu, 10 Nov 2016 11:01:57 -0800 (PST)
In-Reply-To: <CA+P7+xo4M5g15B7zKzC-zJvd6O0Wfpks142-+C8tAqTfyEJ+nA@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-6-Karthik.188@gmail.com>
 <CA+P7+xo4M5g15B7zKzC-zJvd6O0Wfpks142-+C8tAqTfyEJ+nA@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Fri, 11 Nov 2016 00:31:57 +0530
Message-ID: <CAOLa=ZQk9kKcYAQ=CXFwDhvg=pyeSaZk+s1pHafY8cvuxzWeEA@mail.gmail.com>
Subject: Re: [PATCH v7 05/17] ref-filter: move get_head_description() from branch.c
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 5:01 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>
>>
>> -               if (starts_with(name, "refname"))
>> +               if (starts_with(name, "refname")) {
>>                         refname = ref->refname;
>> -               else if (starts_with(name, "symref"))
>> +                       if (ref->kind & FILTER_REFS_DETACHED_HEAD)
>> +                               refname = get_head_description();
>
> Since this (I think?) changes behavior of refname would it make sense
> to add a test for this?
>

At the moment there is no way to check this, since this option is not used by
git for-each-ref or git tag (both of which completely use ref-filter
ATM). This is
however tested as eventually git branch uses ref-filter.

-- 
Regards,
Karthik Nayak
