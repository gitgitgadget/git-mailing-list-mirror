Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0FEC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 13:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiD0NvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 09:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiD0NvB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 09:51:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B7E7E
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 06:47:51 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id q8so1569495oif.13
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=66I//Lt0djylS8P4eLiNUJ1sJtcEXD6uf8QGkdQ3L2A=;
        b=cwCXY3gOH/71lF7EXNTwaICG/lmQJWDFijFRoGFiUmGYcfTjYjo0jLo3m3Lb68qnzX
         4cfAdWzhK4dfmPxEX6Lv0xf8zSfVW1bo3rjHvlAKIIavpXgQiuUCOBCaaYEOxrq5AslZ
         xMrgeeRANLPRDNSV5BOn/tTCLv+n8XSz9WB9pjOtUBhtsCFmbzFQ1FG6e6Ww4l/feK3k
         7dhE3dFO1gRawsNPXlOQ1QD5xYDSf5OqCuv0V5bnLsyxTpKeDxe5S/174QnDRK+uH9kJ
         OBuJv3F3mHGgXr0ba+gZfKi2N0vhCIXO+o9WgpmXoqMIsOJ9g+OF2fIHU6rDpnmP08dk
         pS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=66I//Lt0djylS8P4eLiNUJ1sJtcEXD6uf8QGkdQ3L2A=;
        b=MYuBRWE8TdpzP7VoDsSTMmArL9goQJAv0BXB7wqp0FnboecPnwVsV0zSbC78qT5+oG
         SlrTrVia3BZRvnePwYnvo3iBrc470QsIwaZ6ogg/4yiUuKD1emK4xAcVJe1UR0MeBUCi
         52t5+4OWjVNDhLqFS7UWh1LSFZk4KaU/GIzGj5VY4fu1XlGR+3KCAzmHxQKVPKDAGCrK
         lcLonT8T6RWU8Uwd5MtS5H05dQREJXGMDktEBrUu/IZwWYnMZqW4FR97y5TOa6qm6+tG
         uDTmlss5Cz2hdzRZDRu4Hf8l9Fwxf0q6Uq0Guf6xa5yLfPBHFtWiYp0/CaJodXkAe6xM
         bSAQ==
X-Gm-Message-State: AOAM533YU+cxcnBJk7DAc67lK72m5n8MQ/pHv6+WqJz68lKojtRsguHs
        evay1S1E5J/D0EVwLIwQRwhd
X-Google-Smtp-Source: ABdhPJxEWFpZ5IOShDnzznsLESmWdlISjszXDKOwKQZKYojjHBLygmr9HCJfkpZcQXwIqaxPdIbw0Q==
X-Received: by 2002:a05:6808:1928:b0:325:2113:59c5 with SMTP id bf40-20020a056808192800b00325211359c5mr7816809oib.136.1651067270270;
        Wed, 27 Apr 2022 06:47:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:397f:4d1:8fe5:ea5e? ([2600:1700:e72:80a0:397f:4d1:8fe5:ea5e])
        by smtp.gmail.com with ESMTPSA id 62-20020a9d0dc4000000b00605db31d0b7sm738962ots.2.2022.04.27.06.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 06:47:49 -0700 (PDT)
Message-ID: <bb28d9d3-8152-b6cf-6717-df8534e2871b@github.com>
Date:   Wed, 27 Apr 2022 09:47:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 0/5] Sparse index integration with 'git show'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
 <xmqqmtg7pntg.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqmtg7pntg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2022 4:55 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This ":" syntax is shared by other commands like "git rev-parse", but we are
>> not adding those integrations at this point.
> 
> This has been the most curious thing since the initial round.  The
> changes in the series are mostly about the code that parses the
> ":<path>" syntax and yield an object name (when exists) or give an
> error messages (otherwise) and die, before the computed object name
> gets used by "git show", or any other command that takes an object
> name from the command line.
> 
> I guess what has been confusing me was the phrase "integration",
> that you seem to be using to refer only to the final step of setting
> require_full_index to 0, while that is the least interesting part of
> a series like this one.  The work done in patches 3/ and 4/ that
> paves the way to allow us to set the require_full_index to 0 in any
> command that needs to work with the ":<path>" syntax is much more
> interesting part of the series, and when viewed from that angle, the
> series is not about preparing "show" but about ":<path>" syntax to
> work better with the sparse index.

In general, yes, we do need to be teaching different parts of the codebase
about the sparse index. The way I've been tracking that progress is by
which builtins can stop expanding a sparse index to a full one upon parse.
This progress indicator also matches the testing strategy, which focuses
on preserving behavior for top-level Git commands (and checking that they
don't expand the sparse index when they don't need to).

I understand your thought that it would be better to sell the series to
reviewers by the interesting pieces under the hood that are changing. I
think this is one of the first times where only one of these systems is
sufficient to make an entire builtin (or two) work with the sparse index.

I'll keep this in mind for pitching future updates.

Thanks,
-Stolee
