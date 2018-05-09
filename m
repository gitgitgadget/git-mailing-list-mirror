Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87F7C1F42E
	for <e@80x24.org>; Wed,  9 May 2018 16:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965624AbeEIQsQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:48:16 -0400
Received: from mail-ot0-f180.google.com ([74.125.82.180]:42001 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965609AbeEIQsN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:48:13 -0400
Received: by mail-ot0-f180.google.com with SMTP id l13-v6so40920119otk.9
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QysWGkS5V7au9mgKiF5SQPIokzrTzbRe+0ptx8ygRiY=;
        b=o2VbsPm0a81sHhC8BTDkMrnP+J9+ltbRuSmkpHBPY78HXpb29W76ojYPWjpuVZlTrc
         ZUm3OHUBNtVXcGqMhZFSFRsFDIUaZqGOAKylFurIxpKDMJHP7WMbypHKwuFKDaVTvBKm
         UZcQ8dMBGm6G4KGVhLeazy5y2+frZuEZ/L240WP7TcBI+3LfzkuEMriVHNVh5p8toPS7
         XryYvwEZEYZQTXqKZfaGR7kN/39dpbpw7XMOvJpRjEhG034SqimP4KbtZAthNxILbV3C
         Y4T3SVR5OTLLWjF72Le7GxQl+mwYQMYpy2rKaJo6gmDFTuNFWsVn06rpnZParCJiRv04
         0LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QysWGkS5V7au9mgKiF5SQPIokzrTzbRe+0ptx8ygRiY=;
        b=KDVjGV3NPT1W0Wi9H/RBcAg4V7ou8zGHGHXVToiAf3cI03pyAvJVes29N3t5gwpN5d
         s6PuuOVo/3jaDm9Izabj7HjLFYftvQWuwVFQe57VTF22BHuX0Nfy6dIJPVLOwxP5pk/S
         CjqGpVJK1uRFjLw3Badh4ydcKYXGivrwYQMvsgVz/Yw9dPC+nT7vI0/GHTSeC3umQkCR
         5nMj/u6FLxEAfYEuZCUdjQI9PXWlTFWb5lCHVwr9YOR5/uXy5VQtAg/YSZoHNmSZxNC8
         uUPphS9z1ae1Xukhh6YI0SQgW3n+sbdnsRdR2/CrnNiC255DBMEj8QlaHFanpgSgpbyE
         KKLw==
X-Gm-Message-State: ALQs6tCe7lLWemuHwfRi0hYt3Ey20/wK3Xpn/ErbaGcSyuzFqwBQH8G2
        tshcOSW6QWB4fpsLvjPVxIZ8
X-Google-Smtp-Source: AB8JxZp+y4dEpZWTWNO+jKjOyQSuPp6Ocanqso+k2zS3zqC2Bq80tZSolDRllCdNeAKBF38nBPWBWA==
X-Received: by 2002:a9d:2a68:: with SMTP id t95-v6mr34440003ota.320.1525884492971;
        Wed, 09 May 2018 09:48:12 -0700 (PDT)
Received: from qis-macbook-pro.pensando.io ([12.1.37.26])
        by smtp.gmail.com with ESMTPSA id q12-v6sm16401251otg.56.2018.05.09.09.48.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 09:48:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: regarding fix on "git clone $there $here"
From:   Leslie Wang <qiwa@pensando.io>
In-Reply-To: <xmqqin7xl446.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 9 May 2018 09:47:58 -0700
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F55100F9-134B-41DF-8707-AA9F354E68C4@pensando.io>
References: <2F384E33-2101-4D90-986B-FAE2FC2AD7C5@pensando.io>
 <xmqqin7xl446.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the confirmation. It is very helpful!

Best Regards
Leslie Wang



> On May 8, 2018, at 11:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Leslie Wang <qiwa@pensando.io> writes:
> 
>> At 2.14.1 or 2.15.1, if I run command like 
>> - mkdir /tmp/111
>> - git clone git@github.com:111/111 /tmp/111
>> 
>> because it will failure, then /tmp/111 will be removed automatically.
> 
> Yes, this was a (longstanding) bug that nobody bothered to fix for a
> long time.  As "git clone" did not create /tmp/111 but it was given
> to it by the external world, it shouldn't remove it upon failure.
> Of course, if you omit the "mkdir" in the above sequence and let
> "git clone" create /tmp/111, tne Git will remove it upon failure as
> part of the clean-up.
> 

