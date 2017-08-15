Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6E631F667
	for <e@80x24.org>; Tue, 15 Aug 2017 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbdHOJbT (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 05:31:19 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:37285 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdHOJbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 05:31:18 -0400
Received: by mail-pg0-f42.google.com with SMTP id y129so2842113pgy.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/Y/hFK3pFBNWAlp1LfmrJ0UCWO2Jm3G8wv3UY7BSVWs=;
        b=DLX1VLBCwGGFXZzLF769DetXs1jYIoj7LQa/tcsSu5f2cpGR6M9PjWXKtbDqgZiQTA
         0gSjtn7DsQ5A11m/ncnoMff8ocdQvXJT8NBViHpCOToRMZIDhtPxYsKVg5475IJQN/30
         Gchbahp4a6b4y41WxsWbEAUoGxtJR79vMKSVWAFLBcQIBslY/rQb5WIf0G9NO/TLeUuG
         Ij6d8BpIF2JTGAzYjNtwEG+fsNw0ZNz0Y8rr5l+RLcB8XqPWoTKh3uPVjvk1o8jhHEaI
         LwjLuIvvqN8nZHjeqXwlZTtkGgS0Z/lPdJD4423OOVcefO9Ztgws3egW5Fm11U9WB28r
         Rmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/Y/hFK3pFBNWAlp1LfmrJ0UCWO2Jm3G8wv3UY7BSVWs=;
        b=r01RSYLR9ef0YSOjuroI7FpuDu89udxNeyx5JSpI/dNYO4TsgQ0H74fRwEHxltEK1+
         8ngKGeEnqa3SChbypxSHBe3zHzKwgCpwAfIAOFdl3Anctq50GllNWAa+pdpSSuOpPHXN
         /qwlIsxDhsBAFfqQcmKolQ9J71fAJDKJkWRRaPQRsghogcjSlWmm0y4LBljc/AvPU+c5
         jM3IfE981qxRQNOquMHN9lDS/R8AB0nx8KMYh8hx5DiZNZicFqEaB+XdUYnLUVvsd1Ll
         J9pprgnv3DEgM1DYv1KsGRb9Pg+Cn6VcbfQhWM3mFzGUzoy3fh+b12wpZC10SlRl+d7H
         S3KQ==
X-Gm-Message-State: AHYfb5itxZ5UsYug5RjjUEowGOwe345WTMqo3CVzXzrK8gr/cfB9cOP0
        T7TF+O4X8N4qQ/BKRGY=
X-Received: by 10.84.130.9 with SMTP id 9mr30545431plc.388.1502789478290;
        Tue, 15 Aug 2017 02:31:18 -0700 (PDT)
Received: from ?IPv6:2405:204:700b:d138:d4f3:b513:ec16:b5d5? ([2405:204:700b:d138:d4f3:b513:ec16:b5d5])
        by smtp.gmail.com with ESMTPSA id d3sm15921056pgf.75.2017.08.15.02.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 02:31:17 -0700 (PDT)
Subject: Re: [PATCH] hook: use correct logical variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170711141111.7538-3-kaarticsivaraam91196@gmail.com>
 <20170814084646.30781-1-kaarticsivaraam91196@gmail.com>
 <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <d8f05833-43e3-cfd2-8463-4dd6f7bad5d7@gmail.com>
Date:   Tue, 15 Aug 2017 15:02:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp66ui5h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 14 August 2017 11:49 PM, Junio C Hamano wrote:
> I tend to agree with "Anyways" above ;-) simply because I found the
> long paragraph more confusing than enlightening, leaving me wonder
> "why is the user using different settings for author and committer
> name" at the end, which _is_ an irrelevant point in the issue being
> addressed.
This is typically the reason I didn't add the big paragraph to the log 
message.

---
Kaartic
