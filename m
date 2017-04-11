Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B0620970
	for <e@80x24.org>; Tue, 11 Apr 2017 17:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbdDKRyc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 13:54:32 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34990 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdDKRyb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 13:54:31 -0400
Received: by mail-pf0-f182.google.com with SMTP id i5so1918172pfc.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 10:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u7TtzNVNVHJMMZTjl0Xh7Zn491KRweyMqZlo2/Yrnr4=;
        b=kaz7h/qbxfHMHkXXTKpOhZtZV44VLSToM0qPnmGLa50+H5TIsDxFZDs3gCpCQkNBlF
         KCIet2DzJjG0DP3yusJYjRkA66Q6gTThNWrgo2pAaKnYIap0hEe4lNs5akRqtRNc9l+3
         gOy6Py0qXpegw4ra3NZWN4lyVUruPnF7VQjFXmMcQYzLMwDAoeg5ki495YShiy/ZxRSL
         cXDnsaoThyT/ZqMgDSIEKt5fnKW15c2IPvhIha405drcNzOlF++EvUVIcRQx6+mcu64a
         zB7RE1zzGUkQLzsZavmLLUSysxZ5N+K58koGY2vZ7VfG4Q0bvt4fb3XZOAPNwcTbrCI5
         1kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u7TtzNVNVHJMMZTjl0Xh7Zn491KRweyMqZlo2/Yrnr4=;
        b=Y3ucqwROJiVbjr+uvD6qejr/EkSvq5b5voPqaY8VKMVEPFJZGgfL2MXW4b7MRHCp++
         b5Dk/G70DZQ2o5o0B3CCxgYToI42p1jp9dan1/1evyJ6jogxIZfAwGIyeLQDxT65bH83
         ZERoCAosyUW0rgqx4S6RLg6QNTlVifx7UwBYM9ID9JzMfHar0sTg1JrWH0iS7kA7k5pj
         rtjj9upz8jYCe1/8m4EihmZwl9cETNM5YAu3OE9H7IcUpMFB59Set+sVHDRWqUH4z/b3
         +USOra5lpv3WTLoiVuwWFuWSnUoX3Z32OTPzR9lPNmJDJn3AIugB+YJ1NVuKKcHGGtxU
         O4rg==
X-Gm-Message-State: AN3rC/5cVHAceLdzoVmIS+wNpLQTbPm9PXDuLYgIR4jVAa4Hdyc6+wCmjR5IoakdHPWO83g1
X-Received: by 10.98.16.6 with SMTP id y6mr23738079pfi.210.1491933270250;
        Tue, 11 Apr 2017 10:54:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:9591:6d62:26a:6d59])
        by smtp.gmail.com with ESMTPSA id b8sm31880344pfk.39.2017.04.11.10.54.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 10:54:29 -0700 (PDT)
Date:   Tue, 11 Apr 2017 10:54:28 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 0/5] forking and threading
Message-ID: <20170411175428.GG36152@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170411173712.GN8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411173712.GN8741@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Jonathan Nieder wrote:
> Brandon Williams wrote:
> Jonathan Tan had an idea about how to side-step the issue: what if
> "grep" forks an appropriate set of child processes before creating any
> threads and then communicates with those children using pipes?
> Because no threads have been spawned yet in the children, the child
> processes can use ordinary run_command.  When run_command finishes,
> the child is still available to launch another command using
> run_command.

While that would be one way to solve the issue, I think that doing that
would require more work refactoring and make grep's code path more
complex than making the adjustments in run-command itself.

-- 
Brandon Williams
