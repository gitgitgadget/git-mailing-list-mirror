Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13F661F407
	for <e@80x24.org>; Wed, 13 Dec 2017 21:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753463AbdLMVUc (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 16:20:32 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:41935 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbdLMVUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 16:20:31 -0500
Received: by mail-wm0-f52.google.com with SMTP id g75so7689212wme.0
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 13:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W968l95oZEyIj+DB7IB0VMedofV60x+24AKKh2gyRPU=;
        b=q3Gp5447h31m8yV4/hFVv4Y8uizeac0eRDStAUr4Z4s8FK6+ObCA5EL2XGpmTJyAKr
         CMoOdRf+CtEd9M5c19c6xNlxkCSIbygoaPZfV5uu5TPq7l8c1RvYaYKDUeFeHeKdZ8dt
         m4+C32fB4RkuLGqPd5REgoapm6hK9yV0MXtXl1jrailxurNrdwbdU2zBJAQcyAC2mw2L
         RPBMIJB/rM5NCZMItBY4GyPpfQnu8n3vRw5lXSVb4KEJh+6Hqo/ZvjmKuM37DyvLW4J0
         NRYQVAP3FfCRN/kfVIQAnDYOTji3LURKaWnxXuY7M2jWyW+A+2+hbD2nvyyrpNN+yLRy
         q5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W968l95oZEyIj+DB7IB0VMedofV60x+24AKKh2gyRPU=;
        b=HnUKeJbUX4dVc8aV/gmLlwlVVVGTBb23ZmOVBGft9Ra1BWlC53e9g3TuOLdOZCnKn7
         Jnev1+/hKdiFos60PUmoV9l7t5Eg1Sd+WGxqTUL0uGzY0Ph1+85QuECoBGIHZEPd0oXv
         di/6Bdb/fjRTNDFET6hBvaK2I1fdI5LHvG3m2SJ9mfujqx0WEm4uTsOswjNY59+0xY1E
         chV0uYlxy3QP9XQLXcewHeM8KiwMqSMbWI1/KlusMLvQzA9iq4AhFABw2bYbvgY+d57e
         C5oOWoGuJI80LFnCcaopAWTL7DBpyP5pQGb132hyGwghwk5qsej6XHPBwBxRFU0hXRbu
         5Qsw==
X-Gm-Message-State: AKGB3mIhvbC/unMxd2bkRsjzAB5u5M7LNIeydW2+Ee6KncxJM8MtYIiE
        bfstLW51WxJ3S7fFjAA3Yc8qHGAM
X-Google-Smtp-Source: ACJfBosL8nCQlvuVjIXziuzqGYmNyTePQJWmplTjc3qa8IteLwv+6NRT0Ck9oSVPscu60wsJlDXiGg==
X-Received: by 10.80.146.81 with SMTP id j17mr9320852eda.159.1513200030196;
        Wed, 13 Dec 2017 13:20:30 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id x28sm2251443edd.0.2017.12.13.13.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Dec 2017 13:20:29 -0800 (PST)
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
To:     Reid Price <reid.price@gmail.com>
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <0692d5b8-5fc7-c34c-0712-11a913267441@gmail.com>
Date:   Wed, 13 Dec 2017 22:20:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Reid,

On 13/12/2017 18:32, Reid Price wrote:
> 
> When running 'git stash push <subdir>' if there are both tracked and
> untracked files in this subdirectory, the tracked files are stashed
> but the untracked files are discarded.

I can reproduce this as well (git version 2.15.1.windows.2).

For what it`s worth, using `git stash save <subdir>` instead seems to 
(still) work as expected... but on the other hand, `git-stash`[1] 
manpage seems not to mention this usage ("save" with "pathspec")?

Regards, Buga

[1] https://git-scm.com/docs/git-stash
