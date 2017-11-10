Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DAFD201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 03:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755801AbdKJDil (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 22:38:41 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:44328 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755783AbdKJDik (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 22:38:40 -0500
Received: by mail-pg0-f48.google.com with SMTP id j3so6455350pga.1
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 19:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L7EQWsBspzAfURLXXcUXQrp/EOdTpD5Jo1Z526oP8+M=;
        b=BGden6fIPDlGi/DtMLPDUKz/dZqbD+Kovcl49+UGF2m0KJ6nGUReC/tsySSS2CZBFM
         M3YF4vpobzRho8hfFkGFmWN06qeNOrUZthjbKc//kNNV/y2NCsxK/ooqOl0p6eiMnMI/
         5zG6NBo5+LqoTgCnqhY2PDlHLnUpW4zky8uwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L7EQWsBspzAfURLXXcUXQrp/EOdTpD5Jo1Z526oP8+M=;
        b=nJ7ooVx0TQge5eSCv1vVcLattLyYonEcj6UnhIu0+MiW5ilNpltK81qNHR98BkEbaw
         5uCjUQAAEqcjMkAvOAuTZr+9zDXoJCSuUlUR24+aGuROeOi5gp0kdWriUIJWWoMBusUE
         6QSUEmF3JfRt0o7VYFnTAs7JKWccgzTsXv0/m26kzB/kb58IIrRt1sF0MrgGxt/FR0Vj
         ReA4H7HvJqLuxWhkMQlbfgI+C1FWVcXJ0EhOkvDzX6JmfrA5lALNV479WKjf94DStoyz
         MTD7IZJn63FcKe6gHvR2dv+gYR1TipDEpT6ji8ZXfSP5mB+9r4yxYr14XLf5fWxz510j
         lMMw==
X-Gm-Message-State: AJaThX4MczPsBjyztr/yyO4jhYzQnOi6EdDads+3dU73QKRI/++BAgfD
        J75VDjJO9ujxRKiZRxP3fVoifg==
X-Google-Smtp-Source: ABhQp+SrOpStn9xMrhbtJdGThH8FBaEPNKhZOsVcK3cCMPzEf+4nnIfIm7uEWiLS+OhDHgW5BZfyLg==
X-Received: by 10.84.240.6 with SMTP id y6mr2607391plk.78.1510285119909;
        Thu, 09 Nov 2017 19:38:39 -0800 (PST)
Received: from localhost ([122.167.173.26])
        by smtp.gmail.com with ESMTPSA id m1sm15520867pfk.54.2017.11.09.19.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 19:38:38 -0800 (PST)
Date:   Fri, 10 Nov 2017 09:08:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Query] Separate hooks for Git worktrees
Message-ID: <20171110033837.GJ3297@vireshk-i7>
References: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
 <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09-11-17, 11:14, Stefan Beller wrote:
> The proposed approach above might be hacky but sounds as if
> it should work?

Yeah its hacky for sure, but it solved my problem. Thanks for your
help Stefan :)

-- 
viresh
