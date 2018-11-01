Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E801F453
	for <e@80x24.org>; Thu,  1 Nov 2018 03:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeKAMin (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 08:38:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53532 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeKAMin (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 08:38:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so192999wmh.3
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 20:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=+ug7/5YoEZypMsTbBU3o/jfTYIWSA/ftXDGVYzTASVQ=;
        b=WoXbRWehUgKOip1j65zk4C1cYcy82AV6igMwlbbi2mxIU2gaxJ1OX/YlIJpYH6WY/y
         N0RJPE9JGpHfs6VhVpOt+FP7dfgYn5yfel7unzkupwyY47/HA93LszVw48gLDkr1R/jG
         AXZ0J1Ali28oCiHHjUrsqPjB0sM6bowc9CyekVQDGjChYNdizyL2fuAgm6DqRhaDCyBK
         uL4U5nGsr9k0sTR4XTMT0cLG5+4H6DhEd/9A3PUdbk3kiwOiF1JhECw0lZNzaJ5Ws404
         iSu++9Y6MpTJVFQEtiljNmzxJpVBKDuOpZeWYrHqVTRw7EEhfz1uepaO3W6tVAaOcGgA
         lkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=+ug7/5YoEZypMsTbBU3o/jfTYIWSA/ftXDGVYzTASVQ=;
        b=WFVtIx0UaaJxFJaB6W1NfQf5P0hpUtf5tHJzsBK6ESxh6FLnbclSwIia6EY6dmLM8p
         NgvJKtqBz2eu5OMoQmHoXz4wQ0HpppmmLxrJA+gsx6laU6C3mlPtKkSic2cF4SlEFalM
         ELWozd4A4WVnV77HgmUKo1RzCXzBELnJn2kS0EaG0hJoAHw7qcow+JEbCc5KhyJOXrZq
         Q/365O86+xX5RZGwLO6km1ZLeVqa+OvvhOSdZBv0VBiUolnW8oK8oje+plFKAf8+DUDr
         FrEuL/hRi76bHgq3SsNuovqsfKtIF/txZoH3kpR3fBLtS7oC+i8r8bJYkDYUxOAHsL3y
         RUaQ==
X-Gm-Message-State: AGRZ1gIhsj6gT7ZG7iIgtLMcTTy8qYDrCJsFNlja1CMp6B/kCMAHMRCc
        9S/ZfV9vrPHrCiX4tinJnSQ=
X-Google-Smtp-Source: AJdET5cRa7SbeVh4BFBSI3unWveRUaURctGjifvO/qB7jkc8qkrArb37tWwGi9VIVzI2/BEhq+uJlA==
X-Received: by 2002:a1c:2543:: with SMTP id l64-v6mr4379093wml.74.1541043455043;
        Wed, 31 Oct 2018 20:37:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t143-v6sm18179333wmt.2.2018.10.31.20.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 20:37:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/3] tests: mark those tests where "git fsck" fails at the end
References: <20181030232337.GC32038@sigill.intra.peff.net>
        <20181031124208.29451-3-avarab@gmail.com>
Date:   Thu, 01 Nov 2018 12:37:32 +0900
In-Reply-To: <20181031124208.29451-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 31 Oct 2018 12:42:07 +0000")
Message-ID: <xmqq36slv56r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Mark the tests where "git fsck" fails at the end with extra test code
> to check the fsck output. There fsck.{err,out} has been created for
> us.
>
> A later change will add the support for GIT_TEST_FSCK_TESTS. They're
> being added first to ensure the test suite will never fail with
> GIT_TEST_FSCK=true during bisect.

I am sympathetic to what step 3/3 (eh, rather, an earlier "let's not
leave the repository in corrupt state, as that would make it
inconvenient for us to later append new tests") wants to do, but not
this one---these markings at the end makes it inconvenient for us to
later add new tests to these script before them.

