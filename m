Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D594C20560
	for <e@80x24.org>; Thu, 26 Oct 2017 07:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbdJZHIS (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 03:08:18 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:51074 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdJZHIR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 03:08:17 -0400
Received: by mail-pg0-f42.google.com with SMTP id y5so1980089pgq.7
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zCD1TAsdiaHXY9Qm65b0CdJjDyGCF125wDbYL15k1qk=;
        b=tCecKi7HgsRNBT0Vgppb0BZJgWfvyZQtyi5Z0W6PfYudMIY3tGl75tkaTPwcPQJgnz
         GlCYhAMjc8y4FeE30PuBtwwcewPv1FWyOr54AtxnItpXBOEhzXcBhmVCnaVGwzmZmNm5
         pOcUBuYWFfzftEcJQ2zJ/0t/9QXthctkqb91nhFuBqRFYFNupBfwcBc0SSVp8lsqN2z0
         VsiJ0WSRTbNAwIpcUtZjwailBaK62uupP2hVx8G1t70eli2eunsZJTLsagDJn1VRNax7
         UXmnQbTEiciY5rdiTdeTmrTlUjJ6ANqiGmNtQHGYRSMbpybko9W3QO569Y9QP29c/I84
         d5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zCD1TAsdiaHXY9Qm65b0CdJjDyGCF125wDbYL15k1qk=;
        b=E5kyK+J1oMCM7FUUNsWkgqmaSlamco52SD6Zkbk8f0u/bMmZCOfeXJcZZLfnX8Om7J
         t1QCvBqpOfPBh1DDkUp55FS7496gKdgZ68cn7k9QVnE59MJhxY33haaStPmIA39Horjy
         UvhFWZkzKt/BIeXnTZTr8/JC7PAON5jTpzHftL+tvix02xhorzsJep87BEI2b4R1/A4r
         3HwDZNo/ATmf1AiIEHACHPUVI6fXJ6v3aqKdp3JbjYwai0/JaKjpxixG06mfp9r7wmhe
         AoVX3DovvORDOMCl2gqnkLBPLB+LqQWwWNiKs541MOa1Zh4R9dxOqbUpUc9tF4NHHfeV
         mTQA==
X-Gm-Message-State: AMCzsaU2uJc+dlXdXAu7MWhJKWvTeZI8fldgw9ds6NylgCcrLULHKvTy
        BWTfvki0uGxh4j4yGVOpB4666Q==
X-Google-Smtp-Source: ABhQp+Q9vXhCma3DZ16R43qMLQk8Q+kJtKgQQWYhMMl39PtJ4jkADkUCYAO4MeXZ/UssX9raTVrm7A==
X-Received: by 10.99.108.132 with SMTP id h126mr4116243pgc.434.1509001697046;
        Thu, 26 Oct 2017 00:08:17 -0700 (PDT)
Received: from [172.22.44.87] ([103.233.242.9])
        by smtp.gmail.com with ESMTPSA id i8sm7368039pgq.67.2017.10.26.00.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2017 00:08:16 -0700 (PDT)
Subject: Re: [PATCH] blame: add --fuzzy-lines command line option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
        bturner@atlassian.com
References: <20171026021929.1346-1-istephens@atlassian.com>
 <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com>
From:   Isabella Stephens <istephens@atlassian.com>
Message-ID: <fab198e6-a736-ff2c-1c37-719b07531942@atlassian.com>
Date:   Thu, 26 Oct 2017 18:08:12 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqtvyme8pg.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/10/17 5:15 pm, Junio C Hamano wrote:
> Isabella Stephens <istephens@atlassian.com> writes:
> 
>> If the -L option is used to specify a line range in git blame, and the
>> end of the range is past the end of the file, git will fail with a fatal
>> error. It may instead be desirable to perform a git blame for the line
>> numbers in the intersection of the file and the specified line range.
> 
> Even though erroring out upon such input was done as a deliberate
> design decision, in retrospect, I do not think the design decision
> made much sense.
> 
> The code already takes a nonsense input and tries to make best sense
> of it, e.g. "-L10,6" is interpreted as "-L6,10" instead of erroring
> out.  So if we were to do this kind of change, I suspect that it may
> be better to do so unconditionally without introducing a new option.
> 
> Thanks.
> 

Thanks for following up. I've sent through a version 2 of the patch 
without the command line option.
