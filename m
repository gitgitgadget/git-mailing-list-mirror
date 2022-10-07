Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C61C433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 21:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJGVzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJGVzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 17:55:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6616911A24
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 14:55:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r142so494851iod.11
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 14:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xb/ioRAfp/ku7Z6INBI5ivcpGcPJ9cC85muDw5HVnu0=;
        b=sG2GODk65j3S9tLMj7GXCm8Qax7K6BgRhri01NGjOHdx5u18gONP0eOBFJd7psUW6G
         SUUXJEmzWLxiYoSkO8ejPUE3zMEm2FB3mqU592joH5S/wTk8xOen2XN0jbdljHkAdrIY
         MY/wQNxSozJhRhTqek/RqypDR0VBhrYAoRlVdZrsEsWxgHNTbWk8Kd4E4BbpIbOymotH
         zUeuA+dUXwnsAv9Rj3ouI3tBCsahYUKXoR1qzdG3iHmAydCPyznsmzcFJP3kWbxokbMM
         1gUPRTlaS2jQvOfRTdYysHrHh04TD9FY0IJmZ5ioAPQ+Wr36iPL+sSyxHVp4I5Dwvk/m
         r1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb/ioRAfp/ku7Z6INBI5ivcpGcPJ9cC85muDw5HVnu0=;
        b=USxl76u/XW6q+SzuYCTeKUoq+hs+ZiIkSPvfQ2fQezotpTYXhodvHvLoJcRbk5LRqh
         +VvhijCDKs3mpLNmsQf4jjTCe8DTB+ydSf8u2sW4Xof396T9mxsaH0RrF+x9FpfkVvHE
         HvU+/0afbXOKU2esVQxdPurHzhSXwft6gIynP8qxGRzgvw2Rvc1RNSVSLzOd2pZH3UmN
         m/GuZ+Pe5Ia96DXm8Qz2sQ7pRNsQUV3eo9lyaHvqquBLtCLUXveHRkEAREMsh88865+n
         7Du50N6sC9stXXOolRGc2rKDVq2bY56iyUT5+uPkTxFEbFrGrc8tlzAaGdpKGFRE9+lm
         9CTA==
X-Gm-Message-State: ACrzQf3lRR/PtsfZtJq7mcCW1JgeSJ7kSq7f8bUUzOhBBNldcg1GOz7E
        uztc1KR0C6luM7Vg/s8VjNLyLPZbhv9n8A==
X-Google-Smtp-Source: AMsMyM7e338gpzg9EBt0ddAdYGmWyS80Nbxr6db8/APLetg6ktgQnpnbQmVFb3V6d9UDa+Ul7XoDGg==
X-Received: by 2002:a02:ceb5:0:b0:363:381d:6f2b with SMTP id z21-20020a02ceb5000000b00363381d6f2bmr3636679jaq.166.1665179703690;
        Fri, 07 Oct 2022 14:55:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d68-20020a6bcd47000000b006a11760aebbsm1402020iog.36.2022.10.07.14.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 14:55:03 -0700 (PDT)
Date:   Fri, 7 Oct 2022 17:55:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] SubmittingPatches: use usual capitalization in the log
 message body
Message-ID: <Y0CgNr8UF8kPkn4E@nand.local>
References: <xmqqedvjfqx1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedvjfqx1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 07, 2022 at 11:07:54AM -0700, Junio C Hamano wrote:
> ---
>  Documentation/SubmittingPatches | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, looks good to me. Hopefully readers of SubmittingPatches will
take note ;-).

Thanks,
Taylor
