Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7FEE1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 08:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756554AbeFSIPZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 04:15:25 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34616 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756384AbeFSIPX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 04:15:23 -0400
Received: by mail-yw0-f193.google.com with SMTP id b125-v6so6593303ywe.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 01:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFr69SbiOO8iLlzo4ejdbg4m/onrByrIm/DuIJVcVco=;
        b=SsVHwJBEOH+nUXHp3ABlnmGDWXVdHRu3BAgsojS9qBqp4eO3SssejbuT0dXbMFi3lQ
         r6rO++YLBWISd3/xS0uBwBnbJoPVbyKGCXARyXyc4kiaHos7r76Dd9HvwXUJ6+s79TcC
         GUG77zJDZGPqk6TcanImYVYJCykGSih9mDc4ERB2ZhMbPgdshXnSCZSmEBmekn6HMVaB
         rdZl+/SJrDTTsHYXeteSfwlFJN3YLisS9z8TTvCspy7nj0DqFmGCiUphpF7pfVrJZD9r
         +Mu58oaCF0NDOqJz49hyv1gcB673K4sY6rsfe4NrFMGPyTkmyjDcelm/d5DgtMg457if
         Y9uA==
X-Gm-Message-State: APt69E3BXl37O/ryxWRwwoYEcYO1gMtz3JYVl7BD+H/OJDul65atVMWu
        Rq5ARFd2N9X3snCq3guazFLAoXg/kOKJ6Br97Ls=
X-Google-Smtp-Source: ADUXVKIujkH3PFCyRpS4mrDKdv/kz0iGyF/IcQxirShh87qMpOsG7oiBRPSbBv1ICb+omXk8Nb/K58yCOtPDk97sUhc=
X-Received: by 2002:a81:6088:: with SMTP id u130-v6mr7791556ywb.418.1529396122673;
 Tue, 19 Jun 2018 01:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180619080411.6554-1-luke@diamand.org> <20180619080411.6554-2-luke@diamand.org>
 <20180619080411.6554-3-luke@diamand.org>
In-Reply-To: <20180619080411.6554-3-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jun 2018 04:15:11 -0400
Message-ID: <CAPig+cRE5_kqhXwFzWhi1xKgTfxcbMJNoisOuNvHCiGOMARunw@mail.gmail.com>
Subject: Re: [PATCH 2/6] git-p4: python3: replace dict.has_key(k) with "k in dict"
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, amazo@checkvideo.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 4:04 AM Luke Diamand <luke@diamand.org> wrote:
> Python3 does not have the dict.has_key() function, so replace all
> such calls with "k in dict". This will still work with python2.6
> and python2.7.
>
> Converted using 2to3 (plus some hand-editing)
>
> Signed-off-by: Luke Diamand <luke@diamand.org>
> ---
> diff --git a/git-p4.py b/git-p4.py
> @@ -3141,7 +3141,7 @@ def importP4Labels(self, stream, p4Labels):
> -            if change.has_key('change'):
> +            if 'change' in change:

Very existential.

All these changes look sensible (as one might expect from automated conversion).
