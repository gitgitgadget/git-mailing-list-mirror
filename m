Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94BC1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbeHABVu (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 21:21:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34324 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732817AbeHABVu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 21:21:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so9843079pgv.1
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sSlSveeX2xb1GeFqFVVlIudBZMSNpwzW1XH9i6g3Rb8=;
        b=Fh/mtjZ69tnrP+Uvf+MGzqX9aZ4cXTLyr+pBEVjuEIe6cY+jRQEPwg4AJz5QfKNWlY
         r9Q5naK6vgdGO8b9t7LlESqW9F4f6TG0JdxpK9QNTlp6JFJTXa+QaA1hrhaZER/KzFuW
         ObwDqXhYLNBB2ATIVLnzNJYrmVa6hI+iC5FO6UaxyP+7hNrXlP7SHz/RuGSmCjILqg+u
         nrIEKnuskLj+8dUZ4RrjDsgknwOtMZIbyjYHxjfaHPh9md7kgJQGZV28BF2sInBMdcwd
         n+FS2A2ZkyyMiLy7rJklr5uftUabAnrLW6LrCpa7j88FI9BYTVnoosTP65ZMuNX3whXF
         tH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sSlSveeX2xb1GeFqFVVlIudBZMSNpwzW1XH9i6g3Rb8=;
        b=AGTgr8wwlPTG5y6V6JirjjVcJTYv/xX5fCrJcwKZf0sVfg7TxfmMRo0ALXwnF27J+q
         dvqWQW41z0YrBl+WysQaQ0OLkZqUnsKkt9VWIU9tRWEyJeCJCDNBx79bjgYDS8Tm/vim
         aQ52vDiNwU3KWrcrjitUAG600EV9KCZM9xpyQPx8/s4mpBBU7253DMg4xsYa2A38fw7c
         RjnIOoyyeJvzPuLXeFor6OYK8LnuOMXryEiDl4FH9zIylzXSRLH9N/PHoxeO+jtPYLFP
         BiNGh2CFHNUVBYCxXviZYhYO0wvGrVxDoYnXakKV+ZWiMSVkZM5zUCTY9pmq1p01Aouo
         4mXQ==
X-Gm-Message-State: AOUpUlGftYvaKq0X0JrHfdp7qrZRR29S9oFl6zhysNSX0dQdDdbjzKVo
        ib4wezWbl+PNn6HmMliMELs=
X-Google-Smtp-Source: AAOMgpcuDmyBaPXba5hB8XBQ/mbLvybkgTs6YhJmjG8J8tqjS00RvWJkTJhNUKOpfn4+Jl6j/wz9Mw==
X-Received: by 2002:a62:6547:: with SMTP id z68-v6mr24442356pfb.20.1533080348161;
        Tue, 31 Jul 2018 16:39:08 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 84-v6sm37875504pfj.33.2018.07.31.16.39.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 16:39:07 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:39:06 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
Subject: Re: [PATCH] t1404: increase core.packedRefsTimeout to avoid
 occasional test failure
Message-ID: <20180731233906.GB113554@aiede.svl.corp.google.com>
References: <20180731233248.25482-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180731233248.25482-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:

> While 3secs timeout seems plenty, and indeed is sufficient in most
> cases, on rare occasions it's just not quite enough: I saw this test
> fail in Travis CI build jobs two, maybe three times because 'git
> update-ref' timed out.

I suspect these tests will fail with valgrind (just because valgrind
makes things super slow).  Would it be safe to use timeout=-1?

Thanks,
Jonathan
