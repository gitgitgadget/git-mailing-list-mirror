Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8861F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 13:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbfJANkK (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 09:40:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41894 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388415AbfJANkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 09:40:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id 206so5073480ybc.8
        for <git@vger.kernel.org>; Tue, 01 Oct 2019 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=48Cc9Zgb5+ZW+/YJahp8B3ELKd23/Y5cjtDma+BhywM=;
        b=J5KvK5zqhdqYY/kabvvtnXt79ugz4aLTtUExJhLJ8+8jZta7oLempE/j7YNoD29D4L
         fNkB+lx5aHQTMjY59kwNTlFv/MFKbzCmrhwNzXR7WI+49NX7in7PVHuy6FLDect1ZnB8
         7rLqUlBSEQXj+OYDp152Oz+sINHnPM0VrnksaumV8cs/h2prM4G/+/CQJXZN8R5XfSPs
         N6+5H/wi0vZZQEte5LolZ/Pob3qI+ohpbBOpBe/uBuqOheDMyf6ewuxO43x7hvuwhZ3B
         20G8d543vp2+UNDXbLkOWeio+gxH4iANDH7QgPOgTdM1rhQGoImoljgPC+oCpPRxAkXb
         EF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=48Cc9Zgb5+ZW+/YJahp8B3ELKd23/Y5cjtDma+BhywM=;
        b=U7WPyx5xOqVJJFfsG8ynZ4Qhzj3mtr9DWi1JQ2AwNEFZL5tXl94W7i+YiBxk9F8feZ
         jaeNkr4GlIT/Gk8jcVAKs7SG5Qvy9FPBei6IvqcHx9WLzSQx/stXY43cywgcDjx8JCrg
         bWkaMeqRx3s72iq52JeGwlGzAJUlFPX+jrHxCCVlI76EvuxIaV4qKiWW3q0P+Esob7jh
         3cSF9GD68V1pSA3s+s/Du0tVNb9RgfBFRrt0jUeDbDOEYi+HDkDR9XwSvB2Etl6i/MkK
         nj+635VNEG7wI674ccuDpLmxIEY+IlE9YF1fwDcVi+i0b3jaQaAc322yKbtXRmrCL+wk
         Ezrg==
X-Gm-Message-State: APjAAAWdT2CvU6S+azDcjcfRXZJxhqBA02I9qqa9uqfBbeZ3GTkVNqhu
        GrAnondbhzoNI/Ixb5zF5/9xbLI2DAs=
X-Google-Smtp-Source: APXvYqzjkDUQrwjiMaRmzf6BVjvufx75w7p9hRtJi1q2z5WCpSDpDWEM42hVxjvZDfV3Ii2ZF52gOA==
X-Received: by 2002:a25:2109:: with SMTP id h9mr7162556ybh.27.1569937209736;
        Tue, 01 Oct 2019 06:40:09 -0700 (PDT)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id d4sm3520816ywf.69.2019.10.01.06.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 06:40:09 -0700 (PDT)
Subject: Re: [PATCH v2 00/11] New sparse-checkout builtin and "cone" mode
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.316.git.gitgitgadget@gmail.com>
 <pull.316.v2.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <47186f02-164d-fa41-f65c-05a197e4a046@gmail.com>
Date:   Tue, 1 Oct 2019 09:40:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <pull.316.v2.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 10:43 AM, Derrick Stolee via GitGitGadget wrote:
> This series makes the sparse-checkout feature more user-friendly. While
> there, I also present a way to use a limited set of patterns to gain a
> significant performance boost in very large repositories.
> 
> Sparse-checkout is only documented as a subsection of the read-tree docs
> [1], which makes the feature hard to discover. Users have trouble navigating
> the feature, especially at clone time [2], and have even resorted to
> creating their own helper tools [3].
> 
> This series attempts to solve these problems using a new builtin.

I haven't heard anything about this series since Elijah's careful
review of the RFC. There are definitely areas where this can be
made more robust, but I'd like to save those for a follow-up series.

Junio: I know you didn't track this in the recent "what's cooking"
list, and I don't expect you to take it until I re-roll v3 to
include the .gitignore interaction I already pointed out.

Thanks,
-Stolee
