Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24F21F4C1
	for <e@80x24.org>; Thu, 10 Oct 2019 20:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfJJUUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 16:20:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46362 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 16:20:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id q5so4586801pfg.13;
        Thu, 10 Oct 2019 13:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HDVmujbDqRNTupbPg1FcdO/E+hLzrVokCYE2p01+T0=;
        b=IiV+kqWQLywVkBvffN9yqDsU4z+bJXOBHgfEgYZK6zell8U8XUnrclNIxGqfQsx6qN
         5LwNB8THyZF9XAPHCyaxHT5Edd8dzatUy+dastaAAWRcAJzcwmaqUtflFARPG0fRYzRM
         upznnqx78HenplJm2N9CQKO6ZajebMk4ESdGl91wx25ZAaAO6/qN2CvCUXucxfbn3GTn
         x34LW9qkjSlQfayCSBMBis/Ik/hMbrPByWl0MlDdvbn+p8yIX4qexRhoL53T/IKeDiCu
         Xd3Qa+BGQkwDfPU/i+x3P3AsXOdQo1Nnte8IhdUByE1wMyLanfnEjYvmfIfLeVsPYBwv
         9jXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HDVmujbDqRNTupbPg1FcdO/E+hLzrVokCYE2p01+T0=;
        b=K4plUyeM5XGgnnl58etfWQgeW32i5qQu9pP1t7VJ1YT1qqL2BnC8Yq9JFAH4/0bMDp
         xJYmnEjXyjkHMIo9LHCZ25eolCzut7uuMDdvOYDPLSq5hZdr8HOmSThvG3ZA6LhUBCM+
         uxT08eUi+w5EnkOBJUro0HIMJHBMK+seaSJYT7PfI/gsPmYThecYVYB5xHO/XGRgka0N
         QTMJiPcQ5kUUvrdsJIiNCwX793n3KCF9M/EPstUMsG4G2+dZx/t44WQjvRNe81h1H9XX
         dJ0WAxaA6KJmQBxATAg1wtztl9ndQr9YFyQVLNgkzzwyXsWO0+wlfWBp64CimGiTQi0t
         EswA==
X-Gm-Message-State: APjAAAUIYIvvY4+oPCsjVruGup1IbycUJHHQXNoJ+5lAlWaCGae7q7zC
        L/AB0598c3zsG+YVGXOFppoST+E6
X-Google-Smtp-Source: APXvYqxch6ne0QQBydBAasqccj3p1gvKHRVYakAknqiVbNFqUu+H8YKP2iHz7HM9xWcpwQpHscenxA==
X-Received: by 2002:a17:90a:c382:: with SMTP id h2mr12907894pjt.110.1570738851703;
        Thu, 10 Oct 2019 13:20:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f17sm5881872pgd.8.2019.10.10.13.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:20:50 -0700 (PDT)
Date:   Thu, 10 Oct 2019 13:20:49 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     patchwork@lists.ozlabs.org
Cc:     workflows@vger.kernel.org, git@vger.kernel.org
Subject: Re: RFE: use patchwork to submit a patch
Message-ID: <20191010202049.GB191800@google.com>
References: <20191010144150.hqiosvwolm3lmzp5@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010144150.hqiosvwolm3lmzp5@chatter.i7.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: git)
Hi,

Konstantin Ryabitsev wrote[1]:

> How I envision this would work:
>
> - user creates an account (which requires a mail confirmation)
> - they choose a "submit patch" option from the menu
> - the patch submission screen has a succession of screens:

Interesting!  This reminds me a bit of https://gitgitgadget.github.io
(except using patchwork instead of github pull requests as substrate).

That leads me to wonder: should these kinds of tools share some code?
Are there any subtleties that web-to-mail patch submission interfaces
have in common or can learn from each other?

Thanks,
Jonathan

[1] https://lore.kernel.org/workflows/20191010144150.hqiosvwolm3lmzp5@chatter.i7.local/
