Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1A620A40
	for <e@80x24.org>; Tue,  5 Dec 2017 18:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbdLESQt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 13:16:49 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:37724 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdLESQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 13:16:48 -0500
Received: by mail-it0-f46.google.com with SMTP id d137so3709799itc.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yl5IUNnh8q0G+bZ2pIpLFF6a5fPe2/oe9sWlY3ZLWJM=;
        b=By37tFNdkww/P8nDd/coNcndzA085aHSK/N6lNIAZy3uJh9axYz1ebn35i9N8l/e/P
         oW3k09yUO/wDur10cHaF0MzhLCPFoiGqxUtGohZ88zRzsX8ysDLtzA4a294+DmjRA6NR
         p1VGsT63ggKC/4upbquIAqzQx9PkgYaILP2MQAlJ/lvVAJZ9chKdsjt18/xo9l0Z4ota
         8ZgzP8m1Hgg15PlvDZxJ6QAYqcsaG3VNHYOsOJ0NI2l5LXAPUlK4Iy//knz4FXC7zfCM
         POX23fm9ISXSIRlGEUud0MY2OaZIOwg5Vpv7mIbSRdYzYg+eTRYECsS51SxoSmST+gcB
         CoSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yl5IUNnh8q0G+bZ2pIpLFF6a5fPe2/oe9sWlY3ZLWJM=;
        b=Lw/rtJnrIvNetn7bUwZbS332Sw0dH0o5ENe+geyuHmbTP4DtjPDL5asGT2BjAzJKS0
         1EhQawNi2AFGghj9dUY0cfUabFdRHcCLxy87bk1TSNROLUkAFgE4Y/XpSDN4C0Vu5nUp
         2edIDvqZ5LWIaVA3z6Z6uldAHKjKQtGvR76nIXvLpUZFNY94UEJ7B3Md2/o1MQxINF02
         wntOWutgvrRZjUXanZ9BujVjONWwJMP2HcXpNgqDiRzdT+bH+g1iOjHNgL11jz+1e4z6
         Hm2wlH5bBqCYbyqimHDEyJOVQS5l1j3caQRJyYepO3aI/Edm2I0PYdcR7ZC1EU6EjwjR
         /FSA==
X-Gm-Message-State: AKGB3mIvVlG7uD4iyngKdqP6HMxqic/G3JkhM/Ihn9b/xWGWw/k2rfEl
        2KFTW7q0fu1SKumtWq9H3IM2Gw==
X-Google-Smtp-Source: AGs4zMb2k/UJq4LcKDluVlS83bnT1DFntZUd+LcPNs2ChCA6Ff+CPz0Rhr6dHmsPZgGZ4lRgfUUQLA==
X-Received: by 10.36.221.216 with SMTP id t207mr10095673itf.112.1512497807576;
        Tue, 05 Dec 2017 10:16:47 -0800 (PST)
Received: from google.com ([2620:0:100e:422:f83a:9bb:41ed:d5e6])
        by smtp.gmail.com with ESMTPSA id m91sm280761iod.76.2017.12.05.10.16.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 Dec 2017 10:16:46 -0800 (PST)
Date:   Tue, 5 Dec 2017 10:16:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ben Boeckel <ben.boeckel@kitware.com>
Cc:     git@vger.kernel.org, brad.king@kitware.com
Subject: Re: gitattributes not read for diff-tree anymore in 2.15?
Message-ID: <20171205181645.GA159917@google.com>
References: <20171204212255.GA19059@megas.kitware.com>
 <20171204230355.GA52452@google.com>
 <20171205154244.GA16581@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205154244.GA16581@megas.kitware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Ben Boeckel wrote:
> On Mon, Dec 04, 2017 at 15:03:55 -0800, Brandon Williams wrote:
> > Reading the attributes files should be done regardless if the gitmodules
> > file is read.  The gitmodules file should only come into play if you are
> > dealing with submodules.
> 
> Yeah, it doesn't seem to make sense why this commit breaks us, but there
> it is *shrug*.

While it doesn't make the most sense, I still wouldn't be surprised if I
missed something when writing that patch that inadvertently caused an
issue.

> 
> > Do you mind providing a reproduction recipe with expected outcome vs
> > actual outcome and I can take a closer look.
> 
> I'll work on one. It isn't as simple as I thought it was :) . The setup
> we do before running the checks is apparently involved as running it
> from the command line is not exhibiting the difference.
> 
> --Ben

Perfect, thanks!

-- 
Brandon Williams
