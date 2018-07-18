Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA38C1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 23:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeGRXnj (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 19:43:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32781 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbeGRXnj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 19:43:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so6204959wrp.0
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CWfjRMsLPQvz0lf97IRq7jyOOCmE/pQmo+m111gXumw=;
        b=Ek1U110YkQTMvxGUtR2fFgD6arZmFy/mHWtyE5egj33Qh+HodxgoHe3IpS7cgAmyyg
         iBsRXqU86WKVP1BJXFXmzOfbyx9BYTT21usjR2sy6YC9ladI2S/QT5tg22pWFFhdPYSB
         kUeR1/oy1Q0NahfHlE9XOtivZUmUWjq3xa5nSDS3jMOeyqt+mDuucTb6nZX5z5D6Emzl
         s3eKu3339MALr1dLXR6jU4cjBh5XJvZNk2ngeLVfgNB+BSU9JUQmbtJP2JKQyDBEeYTt
         x9xBtm6WX2ie75oo1nOlo5nEw4ArjK+91oO6D5BgVx9H4lENuoltqpZqz8BzUVroXZhW
         O5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWfjRMsLPQvz0lf97IRq7jyOOCmE/pQmo+m111gXumw=;
        b=jB3p94/INSH4W2IJjWnJputU6p6ciDNMtXCODBFXG6eFFkYPA99Da92TpmrF276u6K
         JWzGCXkc1U7ULKOh/2VzpmB1e5uo2avSMq0kf0ufdkO5bw8fgM192yRoKVvAbncD3Qa9
         u84Qoj1pCvoHMwvYHsFDU7aCBctI1BKK0SkdkynKHCc1PMVATBxzzAGlrPMLI25L14ni
         6YTNduJUZmjB5MsHfM6eL5ePEyEO53xAw86Xi6j3eTHRmWORagBY4d7kC2JmLqMXe6Um
         pIUtc7/FAN4S0lU1ApOI/g7M9qmRynR82/qoMTSk8SXceOSA5MhkbZdsYAfb/AXPuA21
         I58Q==
X-Gm-Message-State: AOUpUlErBilQXOjnAJjH1goUpKF0htCaxsnqdRudgCtqYj/Peb1KeGu4
        rgSSQiZmzjCD1HKM9vKhoh2S2OFV
X-Google-Smtp-Source: AAOMgpcUdYTJH8mRw2EiZ9ddiDcicDov0GrybceaIh5cEb6XRMm1McZKJQbne85L6uRGPwzBJ1lb1Q==
X-Received: by 2002:adf:ebc3:: with SMTP id v3-v6mr5708848wrn.33.1531955010808;
        Wed, 18 Jul 2018 16:03:30 -0700 (PDT)
Received: from [192.168.0.137] ([82.78.255.161])
        by smtp.gmail.com with ESMTPSA id m17-v6sm7615623wrg.65.2018.07.18.16.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:03:30 -0700 (PDT)
Subject: Re: [RFC PATCH 0/6] Add gentle alternative for `get_oid()`
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
 <CACsJy8AEDmyg1XpgXc5KgKdG33t2SeOHw56tEgL_VVXh1Bcprg@mail.gmail.com>
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Message-ID: <8ebfad3c-7009-d0cc-2ef8-54ebac6783f9@gmail.com>
Date:   Thu, 19 Jul 2018 02:03:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8AEDmyg1XpgXc5KgKdG33t2SeOHw56tEgL_VVXh1Bcprg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On 17.07.2018 20:45, Duy Nguyen wrote:
> Since get_oid() callers must handle failure when it returns non-zero,
> I would say "gently" is already implied by get_oid() and we could just
> convert those die() to error() or warning(). Unless some of those
> die() are very special that we need to choose which call sites should
> go "even gentler" where some sites should still die()?

Of course, "gently" is already implied by `get_oid()` to some extent.

 From the beginning I tried to follow the safer method to do that.
Changing `die()` into `error()` or `warning()` and handling the
error in the caller function not only would mean a harder patch
to read, but could also introduce some regressions since some of
the functions in the call graph of `get_oid()` are used by other
functions as well.

I think that it might be a good idea, but I am not entirely sure.
The codebase is pretty complex and this might make it harder to
follow. I am not able to give a clear answer, but thank you for
taking time to look over these patches!

Best,
Paul
