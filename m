Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A972B2035E
	for <e@80x24.org>; Wed, 12 Jul 2017 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754564AbdGLVeO (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:34:14 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35130 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754535AbdGLVeN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:34:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id y28so3125372wrd.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P/7kCH4iel2/gxP1arfaVZKcuXCO4/IVuIWxm4UNA8I=;
        b=CqsUU4uo2EmCdVzN6RWZE1IrP7pneJdmnK7pHss0I/nSddigeDPBcfTHo4SonkerVk
         5KQUhI3p2/24o6lAKi2SfgPBYB1aFnqL1ikWI7MRJWdBW9aq91A3BcbUVzP52Nu/QLvK
         Y3QDA/2hgDVxItu855pbpAEjKMLRm9ChokgYLr5FxwvUYs13cLGDDy4fT2ptOnA5Y8Fs
         RcO1OmgFGkw7BEbtO2hqhaFbsB7tYePIRbgCsZc9SrPHaJDB5mw3NHWoeCiQwkUp7cbQ
         FIPNos5CJ8LhUzMIfe+rpb1bYIawdqjV+/3FzTDTbDro98DERdNi6lGLmNyeQdcXiBX7
         XNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P/7kCH4iel2/gxP1arfaVZKcuXCO4/IVuIWxm4UNA8I=;
        b=RkenOClkILBfSTfW+Dk2E5gPaHYDRPVy+ifZT2jNLXImrVH1bvk0Tt1e0aeZqRZCTV
         +4tbccOiTbJdTkWLcf2aD4bMyiZbMGwu59b98wQvSMTc3KL+CnGS0IEUj5Pnsj9I5BJm
         3Faa1ZRbICHV7Cdey/70p+STOJdWkAt8sdeanHQES3Samfa3p1Okl8MoeP/lEA3B+1Gj
         qQ/bi9YIqksMx03K3PNOsl58C4xFak65imfYumHB4W5WRFiZdUmcuhUQ8NePFABlwzhN
         9y8AXNOQgvCqggjbOcEFo1jeoB2qXGS6Pg4CvIXWExWxz/h/ntgUh0laDB+5Ca/CaMy7
         Efig==
X-Gm-Message-State: AIVw113N1wvBY14ZDLMkG0hKCydNN/YJyvlmMoefpgW06k2TDyjS0ESy
        OBfAIpt2CctSu7i3eD0=
X-Received: by 10.223.134.226 with SMTP id 31mr268049wry.63.1499895241741;
        Wed, 12 Jul 2017 14:34:01 -0700 (PDT)
Received: from [192.168.10.150] (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.googlemail.com with ESMTPSA id u18sm3126433wrc.14.2017.07.12.14.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 14:34:00 -0700 (PDT)
Subject: Re: [PATCH 3/3] interpret-trailers: add options for actions
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20170712134646.17179-1-bonzini@gnu.org>
 <20170712134646.17179-4-bonzini@gnu.org>
 <20170712141028.2d6beecc@twelve2.svl.corp.google.com>
From:   Paolo Bonzini <bonzini@gnu.org>
Message-ID: <02354996-dccc-b2fb-a3b5-aa819229caa0@gnu.org>
Date:   Wed, 12 Jul 2017 23:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170712141028.2d6beecc@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2017 23:10, Jonathan Tan wrote:
> When I would expect the last 2 commands to produce the same output. Maybe
> invoke set_where(where, NULL) when "unset" is true? And change set_where()
> accordingly. Same for the other two option parsing functions.

Sounds good, and I'll also add a test case of course.

In fact arg is already NULL if unset is true, so the code of the three
option parsing functions becomes simpler.

Thanks!

Paolo
