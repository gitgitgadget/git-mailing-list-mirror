Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4792A2021E
	for <e@80x24.org>; Tue, 15 Nov 2016 23:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbcKOXeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 18:34:07 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36138 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbcKOXeG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 18:34:06 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so71596910pgc.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 15:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjLwV2Mp2p7LCfQsyeBnnqiubVYccF2rCVusumx78Rc=;
        b=OlsitxAUsrx1u4aRpn8Kwl7Fa8VGnPPiMDBZMG0Ie1Y7o4McSbXxMWphimzjrr9c0X
         inMf/3Pxs4ziPqpQZ+WPDpq2ZbwWgBZBhiqQPHHGUXhJ9V+ZF+WVnflxy87IJJwiC/Mp
         o1EslVkeKtdt/8oaX3uR7qS2t+AOvEewMdrLLIPGl67DmUT/bN7cSRqOu360/q8tg0VK
         b5ZIeWQja5T8YIvQ1Oi6W2rI1IMKC8notw4pU8/0Q2WrtsS6HL6Xpz/MYN88e9QCEYKB
         /XiLQsE6WNkSbfzoDVLpGaySLJz+t7Kx1b48O/CSLlfpKst1FDTT58rZ3L1ji3u1nWPL
         1rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjLwV2Mp2p7LCfQsyeBnnqiubVYccF2rCVusumx78Rc=;
        b=Ztsijwc2WJTA4CTg2p7SMGsquciNrYhz7D+ZBZt1KZcSHxyMVOhVJ/8zifSiXHwHkc
         gwvBAb9dtgrYtq2a58HcZUOTqlYpszvcVGqbXfTxd5DplHjrFXLi1PTSUrlLxu09E2PJ
         QB5G8fS3gWaM7M0Fu0BrwPsgKI5pogAQxVG+nqBn0+iGkF1c1T5dp8w9tLEleZYzljKK
         WlN6nAiZvSJ6jUqzfdYB28KuIRaw7srHWsa0L4Bl/UyvNMzjM2dlqH4JVriUcWrJdvQa
         yDWl1C7eLRqmw+Tb61nq4W2QSZ1l/39B3bUA0IJ1pHwsdQ4Lbj1d/2YXi3nO8vw6WjM+
         84TA==
X-Gm-Message-State: ABUngvcOaIFxwQgdKjOpF/fpu5/bPI2XiQhzIjs5ci/4fjFebFWBLzunYU5ipJ+NYBc7qHiS
X-Received: by 10.98.36.195 with SMTP id k64mr196673pfk.126.1479252845979;
        Tue, 15 Nov 2016 15:34:05 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id q12sm46463528pfj.18.2016.11.15.15.34.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 15:34:05 -0800 (PST)
Date:   Tue, 15 Nov 2016 15:34:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 07/16] update submodules: introduce
 submodule_is_interesting
Message-ID: <20161115233404.GD66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-8-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-8-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> +/**
> + * When updating the working tree, do we need to check if the submodule needs
> + * updating. We do not require a check if we are already sure that the
> + * submodule doesn't need updating, e.g. when we are not interested in submodules
> + * or the submodule is marked uninteresting by being not initialized.
> + */

The first sentence seems a bit awkward.  It seems like its worded as a
question, maybe drop the 'do'?

-- 
Brandon Williams
