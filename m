Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 268B91F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 16:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKNQff (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 11:35:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53547 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfKNQff (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 11:35:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id u18so6362918wmc.3
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 08:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ErFpYDXepU56kNAWi7X4KncY4BgDyU9SZRqwwOkwPbM=;
        b=OB+ebftrAPlLS8vj95eZUQ/qrk9nc4Qzrm7PBYMIam4FDkv0bzxwYyuKR7bXl7kPjH
         X0ddzMIP5R5vcd1axIHM3QBaQ1ndxOlbAQWje2nYUDWuAhaBjDDCOxWZJMpZRy5u1bZk
         eg7+CK1Bv6zikxK1Dwp7/Ya3QKEHWq2+zglhcA876a/Hc81lLYM0DcIDmwxKHA7YB/t6
         4Df+0WLoOBYNzMTGx0Nqvruye9vQRVNChlHcexM8djNqTBSlhQqwgXEpizy/T4C7VK4t
         MCowORFM0unyRtmFlVDnLydhqph0TzKIHqdsY+p8D4iqV12eaP31VZCDWnjUqp+/jm7h
         tgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ErFpYDXepU56kNAWi7X4KncY4BgDyU9SZRqwwOkwPbM=;
        b=R6LaTjBF2oAJUiU6hqbGLPSUqlhonksf7hOYcegxfCz5RURa42pABEYvdUdfyR3tho
         2YU93aFy1U6TbODRU/gUZpZhL9QROc6eQ2qoggQpfiPqm0HEqtg/1NMjR7VaNJfebiH3
         sL+6CZsuyOIWhhTktDsAME78VRW+H98uCqBNyqzsCwkd2M94fS8/hAAlGXMvVXaZqg+8
         eaRAm9n0VTHwj4hKTZzCUcS4/FENeSzKz86FXQFGgZa9jIToivLi7JHtW2HxbC7OZjZL
         WJuvCl9wRenU2Rc/CX7A65fLWrq6TN8gN/apA/fMBwqjzOWjGL3hqpvfuYooHXVJuBLK
         64YQ==
X-Gm-Message-State: APjAAAUth59keW6ohTRx338sE1wmGRY7iAKJFivJxlaFJKS4sYQeMBhy
        sKL6p3T9zk+BAgjDHPv9PnA=
X-Google-Smtp-Source: APXvYqxD7uB2wVGKSExMlVTirk06OcZ0VIh06jWItzxXgIOpgchK3j3ZeAEjDitw4mjwF8EiAoqHgQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr9372759wmi.124.1573749331984;
        Thu, 14 Nov 2019 08:35:31 -0800 (PST)
Received: from szeder.dev (x4dbe5d0b.dyn.telefonica.de. [77.190.93.11])
        by smtp.gmail.com with ESMTPSA id m3sm8790149wrb.67.2019.11.14.08.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 08:35:30 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:35:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: coccinelle: merge two rules from flex_alloc.cocci
Message-ID: <20191114163527.GT4348@szeder.dev>
References: <f867512c-e5b2-6bca-2a37-2976f4c182bd@web.de>
 <20191112175926.GA41101@generichostname>
 <CAN0heSodNonkDK8AT9iJqmWLLCdO0OoHho0ijZOAmri5ren2dw@mail.gmail.com>
 <ff240bc1-ae2a-17e5-d149-2d08c5367e96@web.de>
 <CAN0heSqyGwkeGKv0m_gLDooaUp=gN2_tD7kJYNxeL7LALiPRhQ@mail.gmail.com>
 <1d08b49e-1f41-4290-a64b-dad9fd2288de@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d08b49e-1f41-4290-a64b-dad9fd2288de@web.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 14, 2019 at 09:15:47AM +0100, Markus Elfring wrote:
> > If you could have some before/after numbers, that would be cool.
> 
> Does any test infrastructure (or benchmarks) exist which you would trust for
> corresponding comparisons of software run time characteristics?

Yes, just run:

  make cocciclean
  time make contrib/coccinelle/flex_alloc.cocci.patch

before and after your changes, and include the timing results in the
commit message if there is a notable difference.  If it gets faster,
great!  If it gets slower, then update the commit message with a
convincing argument about why the change is worth the performance
penalty.

FWIW, I did just that with your "coccinelle: merge twelve rules from
object_id.cocci" patch [1], and the runtime went down from 2m48.610 to
2m34.395, a bit over 8% speedup. (with Ubuntu 16.04's Coccinelle
1.0.4)


[1] https://public-inbox.org/git/6c9962c0-67c1-e700-c145-793ce6498099@web.de/

