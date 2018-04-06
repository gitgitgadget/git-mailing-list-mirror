Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B92A71F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDFFc4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:32:56 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:41411 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750749AbeDFFcz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:32:55 -0400
Received: by mail-pf0-f171.google.com with SMTP id a2so7535516pff.8
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XeDb0kcP7fIPRsRvtasGL/Zr8tP+jtZEpKraWmD/Rnk=;
        b=R03BnQe9IsSpK2/gcuXdWMWE23RmRiF/TaOzOX1bNX8rqkN1VM3oNEhQ7vI56v9kuW
         Cs0LNJNNDGuYDDNSvNmk6yemRaeWcaCRrlH0Z36ZNTNdmcOSIXWDtFJkSpa8OVDJi2gM
         A5o9t7pkURO7ONtQ+D3/3I6qcESOTw05V57+A1kg6Ma8smr9f7dwwsLpq90kMYg7DuBh
         aHd+FW39EHG1OSoZ6NVFZ+1PMjgBBbdFtGXDuTw//DJt4BQdSRM66S/k1/iKGPVhOCTq
         tW6zkCaX/T89z9bgDM13LkLWAXWTwOQjnW9pNZxIkC83v2KDdQCWdX8OwGqt74Zd0FkO
         3vQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeDb0kcP7fIPRsRvtasGL/Zr8tP+jtZEpKraWmD/Rnk=;
        b=dA7VX26o0P5LhUSVVju3RVx98HQ+hfPPJNY6SLdia0j847tR+bOt55FRG6T2KTz5t3
         eDn/a18KUs0Fs4ped21h8pw9xxGK1rms8nTHXw6u5E3OxMJ7bVGSM8HW9BV9YprRxDmo
         0BdQtgiyjzvHrETbIh5Zg6TImlDHJO4PpbH1TNa2I8xQL0FG/HJeRhRkFbN5Ef4TeskL
         k9cK5LUBE0PYahsAbRS9yVMxy3A6vDz3/V4JDdLOn3JsJu48qQvSiljsLzrgPAc6ejfN
         Krldv9AvIVp243ir5m9QECxNfM2EbzvU3NZdoSMTQl1vIKoj6ZtOZgU0jBb7v3cNN+Q4
         ldFg==
X-Gm-Message-State: AElRT7EBK1Y4y8aqNUnqH/C0VYbxR1G+LSSvndUiG49ZLCJs/x/ekes7
        rBN8YGTsRUuS1bXGjCTlPaYCozaX0qA=
X-Google-Smtp-Source: AIpwx48EdqiwAdboxIMAjWJHFGFpzmJtu2HwaRyIK32PL6se0fRHjZHmg/RPxkzOiuYP2Z/7X/J4mw==
X-Received: by 10.98.194.142 with SMTP id w14mr19300734pfk.226.1522992774671;
        Thu, 05 Apr 2018 22:32:54 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id y191sm18649585pgd.63.2018.04.05.22.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:32:53 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:32:52 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v5 0/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180406053252.GA61207@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <20180406052901.GB60769@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406052901.GB60769@syl.local>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 10:29:01PM -0700, Taylor Blau wrote:
> Hi,

Ack. Clearly I am still getting used to things outside of Git LFS. I have sent
this topic in response to my series to add "--default" instead of the
appropriate series.

I'll avoid re-sending it in an effort to reduce further noise. In the meantime,
thanks for understanding my silly mistakes.


Thanks,
Taylor
