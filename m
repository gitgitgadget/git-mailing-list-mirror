Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79FB1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 08:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfJ2IpD (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 04:45:03 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:43849 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfJ2IpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 04:45:03 -0400
Received: by mail-pg1-f176.google.com with SMTP id l24so9020430pgh.10
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 01:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FE0/f/yalRP4xfeR0D3V4Qlcl6iHx4fBCdMKzYLuLjk=;
        b=Q3D6Nvy3C/Eba62/n4QQRCxii2ipEKqnHweQHGAT7cdJSHH5mM/eFKJ9vqDEVcEqn9
         YXbImz2HCkngS3GU2QoQJ4WVjtjNZX+nj2DP9XOmM6O0fC77LtckWgfp8ggueqJTLlf6
         SzLKzHgTD0MnJsC8BAHpE8GqmEmom/Vs0t9HFyXmd+vK9QC9D64Qya0SsoBAwfndur8W
         RIcax3I6gcfj/r4rp0toueVRMJqQLX9E+lqJtlI52R9WKiGqHsHX4SEewSL4YnALI04D
         /hI7XNiXPEMu1HZIks4t1NHR5M7Poq4nNfZPpvV0euCN6do1zINtM8tUBHzArm/FASuH
         c05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FE0/f/yalRP4xfeR0D3V4Qlcl6iHx4fBCdMKzYLuLjk=;
        b=VJ2iCwXRm4oMHW3gDnWU/eQ6QMR1ae3vbOECGxnmlk7UVMdJwZOQkmIdhuVSI5GaTr
         jVc/cNy6BfGFRcmSnrHlclgGZnDHmoHv5Y+KhoiXkCraal7be64V2S+i2DQr2xJhoQoW
         45wl7x8OFJ3PFxgRHHQSlz9rMEHymY+ljgdSyhXWefhy1Xn5eVMYETR+0v6DUfDpZbu1
         kLOsya4m8p83xzYJB1ABFA/8QxzxYReMYdzXVpwOePEUKirq5eJ/dEq0ur7FnadbsrCr
         Rf3tGHoiFYdhCwbSHKHeCBOy5jrj/4jrXS37NVTYKmhxcm92xxnLBRN6fNWXgVcRyqW7
         5qsw==
X-Gm-Message-State: APjAAAVVxLmFkYaCjobu/GImPIgi+D9r6DLrmXb+iG9b5xinXQt+8YjK
        Dc5Ml63WKlp9nBe5SL/YNig=
X-Google-Smtp-Source: APXvYqxds/2uTXdeL47EwD0HruNmBY6mAQwPoq+uZ61p/xc0uqqKhaAcmjaF1hgl8+r4lm1zxJCfew==
X-Received: by 2002:a62:ae10:: with SMTP id q16mr14901394pff.7.1572338702722;
        Tue, 29 Oct 2019 01:45:02 -0700 (PDT)
Received: from generichostname ([2601:646:280:1b30:80db:d816:4d15:ae2a])
        by smtp.gmail.com with ESMTPSA id 16sm9936836pfc.21.2019.10.29.01.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 01:45:02 -0700 (PDT)
Date:   Tue, 29 Oct 2019 01:45:00 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2019, #06; Thu, 24)
Message-ID: <20191029084500.GA1579611@generichostname>
References: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0emfzrv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Since you use these What's Cooking messages to generate your release
notes:

On Thu, Oct 24, 2019 at 03:01:08PM +0900, Junio C Hamano wrote:
> * dl/apply-3way-diff3 (2019-10-24) 5 commits
>   (merged to 'next' on 2019-10-24 at 84e27d28b6)
>  + apply: respect merge.conflictStyle in --3way
>  + t4108: demonstrate bug in apply
>  + t4108: use `test_config` instead of `git config`
>  + t4108: remove git command upstream of pipe
>  + t4108: replace create_file with test_write_lines
> 
>  "git apply --3way" learned to honor merge.conflictsStyle

s/conflictsStyle/conflictStyle/

Thanks,

Denton

>  configuration variable, like merges would.
> 
>  Will cook in 'next'.
