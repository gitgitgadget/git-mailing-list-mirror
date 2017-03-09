Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F4129202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbdCISUz (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 13:20:55 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36079 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754906AbdCISUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 13:20:52 -0500
Received: by mail-pg0-f51.google.com with SMTP id g2so11783711pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 10:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bCqF4BIC7BORdW0JQmE2tJ4ZlDLHRUFBYGs7BlEnT7Q=;
        b=InfUnqqb8yU2e5nzye1arasj19/2WEJMIHYRhqTjthVmhVGgpj5WhUKg4SLYgQrqMt
         XPXNyUgP7LERnw7ljcW/DSzfYCIxbA/c+kqGjTO7tuXmpD+kFiL5AEJmmR8HP9Bey0Kr
         8q7458t+NTGsdIcyXsmJKTT2L72K1OyfQuNEKcRvoM/vBJTs1vqbYvHiUurRkJqynNBi
         Wm3XIIwmWQ5dVvpnJJnXtRiKcgF73mugFTDGP/0/SS5hvOJfmKV7rEYl5rZ/2su1vl4E
         nKOgb1cCvUY0h2Os5qOTUuIcufrevkb/gpWMAZkfaNSmkefc/olHDJ5PnwyH8OQ+zaB0
         q1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bCqF4BIC7BORdW0JQmE2tJ4ZlDLHRUFBYGs7BlEnT7Q=;
        b=LTuxtBM+X0p/n8eAYPARHK8enFKF5Grlqs2GuwLaaoaRk8QFqxiKLDiRzNFPYj/vEx
         KBzNqvZDXP6hx33thccv0xVZ5EpBmHG1qFss/ym7r49u5vqCiYdjprFqmp4q5cPq4JBG
         pV5nFLtJCJq3HF6pa6O12G+Gkek8OHuKSXERxXzxPjeNrfA2avFstX+srWQFSlUUN21q
         h+yeVkcKLwBWEJjW3FAQzL5ywS90j6unoo2nASgSuAbSbhF+xpYQDhivC2w+wduFs3FD
         yo/MuBG62hX0gOa+asTCUoncKr6u8g/F5c29y6mHHW25h3eoxcH9/nRga95coeKF8hzE
         fuQw==
X-Gm-Message-State: AMke39kEuK5EI+9nzUmgSyvJ9Vk0z1lNTBrfMc0AitYRN8ZhdENp+L4kZr39d1rMyqAaWif+
X-Received: by 10.98.1.10 with SMTP id 10mr15582691pfb.117.1489083569609;
        Thu, 09 Mar 2017 10:19:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id v4sm13847598pfb.36.2017.03.09.10.19.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 10:19:28 -0800 (PST)
Date:   Thu, 9 Mar 2017 10:19:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Valery Tolstov <me@vtolstov.org>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com
Subject: Re: [PATCH v2 0/2] Remove duplicate code from module_clone()
Message-ID: <20170309181927.GG153031@google.com>
References: <20170309002818.GA153031@google.com>
 <20170309005636.20254-1-me@vtolstov.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170309005636.20254-1-me@vtolstov.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/09, Valery Tolstov wrote:
> > The usual protocol would be to rebase off of Stefan's series and build
> > on that (assuming you have a dependency against his series), indicating
> > that you are doing as such in your cover letter.
> 
> So, should I send only my patch, or current format (patch and dependency) 
> is acceptalbe?

What you did here should be fine.  I was just pointing that out for future
series that you send out to the list.

-- 
Brandon Williams
