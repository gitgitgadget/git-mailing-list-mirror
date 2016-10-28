Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0712022A
	for <e@80x24.org>; Fri, 28 Oct 2016 09:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935408AbcJ1JcX (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 05:32:23 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37253 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936477AbcJ1JcU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 05:32:20 -0400
Received: by mail-wm0-f49.google.com with SMTP id 140so66958211wmv.0
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pelly-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Ds0C1OvEIG7O/thL8bDTXdbw50GhFGp4JrcQFZpN/0A=;
        b=gLbOoStHu/Bnx2r5zHvHdACcAACkoYZlp2N0wwIP+heGw5ZFlxzLI3/yKS/XFkSTAN
         Z7l1uGH9qZN1UXthQHQpK8ny1iyEpmVGdMPLKsbcGbvrsbAR3qXWZ4JDnymGbcrioU00
         k6RM80wOMp3V5WIGvb8OVnVJoPMKEy8qLPxrJOvFq3vzsIBiEPupKRxzCxqhTV7fAKD0
         oP3/ptv2ebFmKc/QHMq8dMiZ906mPUJ9nWPb5VHOdPNH4IqZextzS+wI9SqeJuC1qM33
         jY5bD15Gm1zNZWf2k5itJDNFgvWHrHlPGnYAhRWiUiCOLU2tjG9uE8wc9TX6UjYbzF1C
         eYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Ds0C1OvEIG7O/thL8bDTXdbw50GhFGp4JrcQFZpN/0A=;
        b=FheZ6tWvDGv1TxzLcCgyfd1eMCPeKsAgRdIUvi28/BoO6KY72BNU9eYmXiMqUuAkeq
         iBoX/8/C5dQeGi6SpQ+94o0yrmo6gGMUJZZl9+8piGBcVDlMHCV7esNWFFST3dDF4Vyw
         OyRulciw4XOiiUL9OUWAKeIcrvB6Okp0VDLDjOxzNLAuI0cwt7WWFT9ftDFtkvYTJDQy
         ndZt9vi6r7APIbh+Tc2psLQhkrbV4YgSZPKSRVlv5oH8AKbGzM/oBwLpyTtX1ZuH0xyr
         EWK5c8dt/24MOyxj/g2QeI50H4KjQR7UOjWnUE4RebprVfPhrGydxn3eoa9jnnWrWCy2
         Yfmg==
X-Gm-Message-State: ABUngvfSz/Hr6yZ6KpGfckgrZQbBXSHtVRG5pYJGV4X+37ZbYAfdXlAL8WolIGLMWQBGZQ==
X-Received: by 10.28.130.199 with SMTP id e190mr1320538wmd.110.1477647133134;
        Fri, 28 Oct 2016 02:32:13 -0700 (PDT)
Received: from [10.3.1.6] ([49.50.252.82])
        by smtp.googlemail.com with ESMTPSA id xq9sm13127265wjb.35.2016.10.28.02.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Oct 2016 02:32:12 -0700 (PDT)
Subject: Re: Expanding Includes in .gitignore
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
 <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
 <xmqqwpgt2ng2.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Aaron Pelly <aaron@pelly.co>
Message-ID: <cc23eece-d693-9e40-78fe-3bafe6bcad3a@pelly.co>
Date:   Fri, 28 Oct 2016 22:32:07 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqwpgt2ng2.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/10/16 15:54, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> However, as I said elsewhere, I'm not convinced this feature is all that
>> helpful for in-repository .gitignore files, and I think it does
>> introduce compatibility complications. People with older git will not
>> respect your .gitignore.d files. Whereas $GIT_DIR/info is purely a local
>> matter.
> 
> As I do not see the point of making in-tree .gitignore to a forest
> of .gitignore.d/ at all, compatibility complications is not worth
> even thinking about, I would have to say.

Well; that saves some work. :)

I do not suggesting making this mandatory. I think it adds value and it
is a common and understood mechanism. But, if it is abhorrent, consider:

There is precedent for including files in git-config. This could be
extended to ignore files. The code is not similar, but the concept is. I
could live with it.

Or how about a new githook that can intelligently create or return the
details? This would be my least favourite option unless it was
configured in an obvious place.

Finally, if this is a bad-idea, as I asked in the beginning, I will
consider the equine expired, cease flagellation and apologise for the noise.

