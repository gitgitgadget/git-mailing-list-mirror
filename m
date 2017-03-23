Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7877120958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756142AbdCWVLR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:11:17 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34562 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754577AbdCWVLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:11:16 -0400
Received: by mail-pg0-f50.google.com with SMTP id 21so96575555pgg.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=piQ5Pt7aZcvUypJRLDdmGJs2zRotDyke7EDqHK8kygc=;
        b=VeN1HDcfFIzoGg9/wfv2nViIYf5i79cY3RX6nv8W7FJ6mss+WxhidU3JTGQp/OPfUd
         G2e5BdLwyXs3ixHvxQb6LP7r9vBe5vjT+ipBBzvKT1/5nyos1McH63hoW0dbZ9a0Bg6C
         nBhKKfx+2ZDl9JrNjj16bdGCGTSq+FTWZ63g+29IwatQCtkcX7GS2eJ2Uj/9t8PPi6Lh
         605N8zaNGkVIl+s8rNUPABtUPm8Fo7jE6iSoNY6NkEUdHtGRhmCvFccF0bUENDnUHOd8
         M2WA2eplrbKk6Qw8766m/0nsYChJ3NHixr3ViXGjsjNynMuSq76heUI3H5oi1HH705yv
         qhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=piQ5Pt7aZcvUypJRLDdmGJs2zRotDyke7EDqHK8kygc=;
        b=Q4jBmSzPC/+aYS83Stm97IX9TE2N1SLnA77Nt5+fMn1VLATW8B4emYeP3pZjiBLx41
         1fPRTWzw79qiG2spZFTvC3U1TaI9kT+QDn0Yu+FLlFHMvCebk9OCbj+kij+f0F4/zq4W
         wuMWwnH4GDBSC/IWP1QzZUgxniKRKkF0KjDfMxL1ZULMUHABeUPusHZ3LmnBCbO7T5Hn
         RAw5FV3xwkcGpewBHkSOyyw5xn09haLslQyxI2ut5jvKGgmuCysMaGTmBEcz9FIczQYx
         hI/k9iwdVbsOtj0juL2wtJtC71iI4Max/DVXlMryWKftERr1I8cH6L1zj2bzvKBT4cuA
         DnHA==
X-Gm-Message-State: AFeK/H1LwVDGzzqRGD7v0ujkfFcZVsuHtfS07iCVY3JwLgiUIrPIVdLqaw2BfwTGNqpxKxGaJMZjZY4XqCVLZuhE
X-Received: by 10.98.44.15 with SMTP id s15mr5314924pfs.161.1490303474878;
 Thu, 23 Mar 2017 14:11:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Thu, 23 Mar 2017 14:11:14 -0700 (PDT)
In-Reply-To: <20170323210924.26818-1-sbeller@google.com>
References: <20170323004329.15892-1-sbeller@google.com> <20170323210924.26818-1-sbeller@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 23 Mar 2017 14:11:14 -0700
Message-ID: <CAGZ79kZP6JhgcFQ5+Ytc6LexpA7C4EwR-7C0QZkiWhfrRCpd6g@mail.gmail.com>
Subject: Re: [PATCH 0/8] short status: improve reporting for submodule changes
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 2:09 PM, Stefan Beller <sbeller@google.com> wrote:
> v4:
> * broken down in a lot of tiny patches.
>

except for the first 2 patches, which are a rebase error :(

Please ignore.
