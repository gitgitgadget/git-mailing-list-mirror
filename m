Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0643D1F78F
	for <e@80x24.org>; Mon,  1 May 2017 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762706AbdEAQzZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 12:55:25 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36360 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762697AbdEAQzX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 12:55:23 -0400
Received: by mail-pf0-f177.google.com with SMTP id q66so32643571pfi.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 09:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xVgRdpRoGLhjDUswizOc3917bk3/+mcjZBoDrSYEZKg=;
        b=j+7ZHVjTli6fxgcex26q7ZjmDThstgZd2zNvWEQKBX9Qxh/zrKaq9Fnhw9kiuGhT4l
         9tk9yxRXll/qDu36hLvmW4sk6uqtO3YF1yrmGVeF41sqWz9dN7CLo5uvcaEUi2cwZqAh
         KkT1Yf/kOfyRzq7t1MTNWJPx/kb1Mjkwe8FZwUs1kyFTJMERyI1paLGJiQ1T7vV9Kam5
         jtD0SD8WmPLfKxDE2svFHVzFxE7mNjZwcd+1+90DWgCvEibu3GOVnEO0bgm+J6xsNGKH
         7BuD2jJneccDf4LwJ1DKZJdtP7ULwyoF51HjDgxmZC1a8VPfWNgaQEHMcCq0HG86vlwW
         cxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xVgRdpRoGLhjDUswizOc3917bk3/+mcjZBoDrSYEZKg=;
        b=bj4c66BNfJJGlZlWCTqkYLUVfJCZuSeGwEXCBMAR2KjvZ4OjaQU67sUSn5IgtWUyso
         9CmTv5xkzyw5OnB7MZlwl2pE5GCjAxFlN7bDREJfuxf3bi6DKZkkNVf+Dfu3OkyU4r3K
         Bs4Zs615Ruo8A/pWE3Vv/i8mvk9EL3lAD1tHWYe+4PIwuyulZj7OT5ev2b69AF0hU7S5
         mAI701GnY9h4VhU9gWzOTKx3XWSm3q0pRdhBM1YYzOvvHD6/QYswXnS8BV0DLqA+JX54
         uvu3VGOkce56asX00uT3CPmIZl1CcNxubd4FdA8d5wXiBwEueaeHaCxJ18SliIwAI03C
         usbA==
X-Gm-Message-State: AN3rC/4SqXv2pc41bYtwD6wrK/fI85ceDVeH+m9IY15G7QcBYTcu8e7T
        rxJZCWR574hSL0P0XxXZlQ==
X-Received: by 10.99.49.87 with SMTP id x84mr15269473pgx.128.1493657717704;
        Mon, 01 May 2017 09:55:17 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6d87:7989:6a8d:cab9])
        by smtp.gmail.com with ESMTPSA id e72sm21241385pfk.17.2017.05.01.09.55.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 09:55:16 -0700 (PDT)
Date:   Mon, 1 May 2017 09:55:15 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] submodule: improve submodule_has_commits
Message-ID: <20170501165515.GE39135@google.com>
References: <20170428235402.162251-1-bmwill@google.com>
 <20170428235402.162251-6-bmwill@google.com>
 <CAGZ79kZzpyw0ijiM12TwMHAx1Ung-xKPEm2rVY9803hvk=+UMQ@mail.gmail.com>
 <20170430231434.GA70010@google.com>
 <CAGZ79ka=gALFrzj1OpL9tifiS7eSOSVAMfxY3gD3T6o-teJuaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka=gALFrzj1OpL9tifiS7eSOSVAMfxY3gD3T6o-teJuaA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/01, Stefan Beller wrote:
> On Sun, Apr 30, 2017 at 4:14 PM, Brandon Williams <bmwill@google.com> wrote:
> 
> > This hunk of logic is essentially a copy and paste from elsewhere in the
> > file.  Essentially both code paths were essentially doing the same thing
> > (checking if a submodule has a commit) but one of the code paths included
> > this logic to ensure that it was reachable from a ref in the submodule.
> > In order to merge the two code paths, I included that logic here.
> 
> yes, I get that. The question is whether the other code path omitted the check
> intentionally or just missed it (Is it a bug or feature to have this
> check in that code
> path now)?

I'd take a look at Junio's response.  This check more than likely needs
to be included.

-- 
Brandon Williams
