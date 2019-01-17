Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F27611F453
	for <e@80x24.org>; Thu, 17 Jan 2019 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfAQVSn (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 16:18:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52114 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfAQVSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 16:18:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2588732wmj.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 13:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NxqellCPr4aMem2/6Gj+4rwIHz/LJKJRGI0DTRjoBoQ=;
        b=iCpsswYFwM+qdTskSk8BwJORIpzM9BkB7f5q5RXL/276IPMfxrK/moiEA/YpIvDX92
         ADJhgLTQk/MQkEeEMn7+30g47UsdcGHT+3EG4+Up7fPh1OHPRlMGmc6X2eauAucWPAR1
         N4BaN+3HWwwwohiCGw4d/IKxZtddrbJaKsqCcmx5hbAZSLhYU1qIzc38X6ustxI7jveu
         c9NWefMU6jIid0NBcTbueJzPCXwgnEV4WFHs9Dwt/YRl+Cxxwc/eQRSmt+ObL9coOngx
         6tDI8ExoFUGOHaMg7XvYUNFIQikhoYXrwZq+H3VhEKSycen0BKOMUX0QCIihTS5LJPsF
         9PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NxqellCPr4aMem2/6Gj+4rwIHz/LJKJRGI0DTRjoBoQ=;
        b=dOfftWGO01l57jDTIfxS3Err8GjnFmNnZC0+AlJzjfw2HxGICpkWZBeUyzrS69FMxv
         EKkHX31rWfpBUWGfelj0hB7THadhndvvNjl3ekGzDQGpjBlnqEbaJSxpX44qKEaN2dDj
         AuXVF8395AEiD5uuG2CvSHK3S6E7esvFbekzbcOJ+aKMs+t8CrboRI+VK1DWWgO2OsGA
         FKhHVdAZlabvNbJqjK5OE3ehMpRd0pnqOy1uBgOXbNewTDWI7FRBwhtQup3/eOKqalkS
         /yKAXhVb8E70teGsrIIZ5Xf10BxcGJUSIjDImWmeO+l6k+vWHtQzXUoJ7DW8MNZgrk7L
         nWxg==
X-Gm-Message-State: AJcUukfbhOxvydwMyiPSPYr7MOlMiTJHlur7B3ebWQw3ATl6jfU29ioZ
        faFHAkLPNMFRWsH4zHP/LIPHWGaE
X-Google-Smtp-Source: ALg8bN6GbTrXtg8p9KGpu03rXkq25ua7HWYgKISTGZRz5s8AC7p3jwKxAOxLso9Te4eCrWpbYgiRKA==
X-Received: by 2002:a1c:2c6:: with SMTP id 189mr12870082wmc.21.1547759920122;
        Thu, 17 Jan 2019 13:18:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l20sm168583295wrb.93.2019.01.17.13.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 13:18:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     avarab@gmail.com, git@vger.kernel.org
Subject: Re: [WIP 0/8] Trying to revive GIT_TEST_PROTOCOL_VERSION
References: <87o98f4ol6.fsf@evledraar.gmail.com>
        <20190117183727.260298-1-jonathantanmy@google.com>
Date:   Thu, 17 Jan 2019 13:18:39 -0800
In-Reply-To: <20190117183727.260298-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 17 Jan 2019 10:37:27 -0800")
Message-ID: <xmqqfttrm18w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> I'm happy to have you pick that up as you've done here, especially since
>> you're actually working on v2 and I'm not, so you can more easily know
>> what it conflicts with etc. I just wanted to have it in one way or
>> another, i.e. be able to deploy v2 and assert that "next + custom
>> patches" doesn't break something for v2.
>> 
>> I think [CC: Junio] that we shouldn't be concerned about an addition of
>> GIT_TEST_PROTOCOL_VERSION patches in any form breaking the test suite
>> under GIT_TEST_PROTOCOL_VERSION=2, and just be concerned about the
>> default GIT_TEST_PROTOCOL_VERSION= case. I.e. if we have v2 patches
>> in-flight that break things no big deal, we can always circle back and
>> fix those things or annotate the tests.
>
> That sounds good to me. My main concern is that this will end up being
> dead code (if we have too many tests that fail with
> GIT_TEST_PROTOCOL_VERSION=2 and no one bothers with it anymore), but I
> don't think that will happen - in this patch set, I have eliminated a
> lot of false failures and strove to give reasons for the
> GIT_TEST_PROTOCOL_VERSION= annotations, and I think there's interest
> (well, at least from me) in investigating the remaining apparent bugs.

Yup, sounds good to me, too.
