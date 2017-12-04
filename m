Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 575D720C13
	for <e@80x24.org>; Mon,  4 Dec 2017 23:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbdLDXD7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:03:59 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:45031 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdLDXD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:03:58 -0500
Received: by mail-it0-f65.google.com with SMTP id b5so16965103itc.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 15:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=73DYDM7N1/SNT0UGSzkyUXi+hjxHJMgVWLHvBkCE8nM=;
        b=fuT7FXsrbu1k4fxpL8K0DnZF+5fze6jc5I6OU/03tsO5P1jNUhWT2dgf+O9GsRJcO9
         UBfiFLrj+S37SlkqRt4EOhKNiG6ZfjkMmZoyxxHSTiAHJAwFGSEJBZo4JsH0lofP6T1w
         ZyFwPJcDF3yzjyQmB7UdoVKwYxKoCU13cosXK0QV3sJoh8BUx7wSPdN+l10DhO9+BiDh
         U7tbGDbmlEqQzH9M4+K/RTgxIiFI1X6qtc6ycIq/M4acQR58LIkNqYrqaBEvhh+y9NA6
         MnZpamuWlTa/Ky0tj7vD+CBJH2RX1UpfL0MzCEKnIjaJMHRJmNJldoVnMCmS1lr9fM0M
         uHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=73DYDM7N1/SNT0UGSzkyUXi+hjxHJMgVWLHvBkCE8nM=;
        b=rBhPOlFUFZ071oNVnAqq5CKDfjbtar2kX8AwyY3quzvevtqbUfck1wTppjr4YBWIB3
         bTLmqnjP23LDCJhHmiVn1Z4Kad5vhUxgoeTLqWa0bv7mhNpLRihQWTEU58gxcDojI7PR
         OJ0HFqAcsRjnnZjvQvJxiqAM2NXxX/xGLS6PcgWcDsk3mq7KMrTDHe8nC0VT51IVt3f0
         sfapj6P+TaQTYSeG/n6KRBeTMmCxHL4s84Io6whBTdz/XsxhLSwzZc5sQdkP3yTudBo+
         DIe82PXZSd6r4xjtR2zcyHQjuQCgSsu5ayCHPUz9WX+HMutS860Qn6CgMk58DiC/vxN5
         Z++g==
X-Gm-Message-State: AKGB3mKsks1VDS+uEOcLdgYMAXzZGg+dYHY7Ut/0oeq5aY86UrL8W+i8
        +hpl7+yt2enYGMoyXkJWk2Bgu2a8gv8=
X-Google-Smtp-Source: AGs4zMaZexiVwxVn1/7kcZFI/+WpYoqpGKJAuVFIYHPdnX9YDc0DxVHNSY10tvyJaNgrDmeNhcKgcg==
X-Received: by 10.107.53.130 with SMTP id k2mr5269688ioo.293.1512428637771;
        Mon, 04 Dec 2017 15:03:57 -0800 (PST)
Received: from google.com ([2620:0:100e:422:f83a:9bb:41ed:d5e6])
        by smtp.gmail.com with ESMTPSA id x16sm5397305ioi.62.2017.12.04.15.03.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 04 Dec 2017 15:03:56 -0800 (PST)
Date:   Mon, 4 Dec 2017 15:03:55 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ben Boeckel <ben.boeckel@kitware.com>
Cc:     git@vger.kernel.org, brad.king@kitware.com
Subject: Re: gitattributes not read for diff-tree anymore in 2.15?
Message-ID: <20171204230355.GA52452@google.com>
References: <20171204212255.GA19059@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171204212255.GA19059@megas.kitware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/04, Ben Boeckel wrote:
> Hi,
> 
> I've bisected a failure in our test suite to this commit:
> 
>     commit 557a5998df19faf8641acfc5b6b1c3c2ba64dca9 (HEAD, refs/bisect/bad)
>     Author: Brandon Williams <bmwill@google.com>
>     Date:   Thu Aug 3 11:20:00 2017 -0700
> 
>         submodule: remove gitmodules_config
> 
>         Now that the submodule-config subsystem can lazily read the gitmodules
>         file we no longer need to explicitly pre-read the gitmodules by calling
>         'gitmodules_config()' so let's remove it.
> 
>         Signed-off-by: Brandon Williams <bmwill@google.com>
>         Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> Which is tags/v2.15.0-rc0~120^2.
> 
> Our test suite is in a Rust project here:
> 
>     https://gitlab.kitware.com/utils/rust-git-checks
> 
> and the failing test(s) can be run using:
> 
>     cargo test whitespace_all_ignored
> 
> The test checks that when `.gitattributes` says that whitespace errors
> should be ignored, they aren't reported as errors. My guess is that not
> reading the gitmodules configuration also skips reading attributes
> files. Is this reasoning correct?
> 
> Thanks,
> 
> --Ben

Reading the attributes files should be done regardless if the gitmodules
file is read.  The gitmodules file should only come into play if you are
dealing with submodules.

Do you mind providing a reproduction recipe with expected outcome vs
actual outcome and I can take a closer look.

-- 
Brandon Williams
