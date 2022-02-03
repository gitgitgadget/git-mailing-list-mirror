Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3581DC433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349923AbiBCJ73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 04:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiBCJ72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 04:59:28 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F80FC061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 01:59:28 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m11so4676836edi.13
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 01:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6XXSW7BmL9iE2ohOvmOMnx5676NXGsH6Q9ZQw36e7KU=;
        b=W+HkL5BUd28Yp9T5O9jpc6queSYQMDRbdAK1VKsJ2W5q+RVs1Axw7XY8R68fbTH6FV
         E6mpHq64ZZ6SZS4z8C968Es96gf9Xxw5I0VtyXQ8xgYNHry+xMqmNqjagc8iE3R/o30b
         TEIutvZ20MDd1nlpythLBlgVIMg/ZnNxD3ATPh+ABIrOyOWJ9RcVvfY7pzZXvVJaVIQh
         C/LC+bWODuaiIIZ0ozLB5IFlcb/8PemwZ9JaAB1aigupUot9aREXSZQU9i9BYJgUaCqa
         FuVg3iALkePbeVdHYB1DSHz3rPN6B47tQ4LKrRaGbjyQKvoj/ij9OXAqaGihqpa8Y/qg
         jxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6XXSW7BmL9iE2ohOvmOMnx5676NXGsH6Q9ZQw36e7KU=;
        b=aC+Tv10Rd84nQwe/IpHbiYgEvaqUPBizCUarfEj48SZYY0d9Ck+dijl2oVOILMK1H7
         bYv7wSsnzG6jhTLpUklBAQRxd6uN706GEEKHl1ltDZ0taeQ2TLdzWH7Hd1GV7BTqp+/Q
         rQjw1iixvboTArHlYDL0HxAvAQVmrayLtPaB1LSZ6fSgZcGtP3LYwOI1ougUEmT7YTnQ
         Y8PmCVmv0L2tmZmZ2HgFqjlEJ/aRTEQ1Peb4YVRTxdqs8IRKA5nkyc3NMEG0neSix6/x
         Dle5e5JOMpjO9fAQBpCwh8i74YaxFienPpiEdNHrUjeA6dG4yWLuKpIkGA45trd6QEaW
         vnpA==
X-Gm-Message-State: AOAM530KTSb65obyL5W2bo8k3fbuBr+/pOWF8lsg686yCCKjtnx7D3uV
        6E+IWEp8F1dGn3WTf0xbaN8=
X-Google-Smtp-Source: ABdhPJzs1eEKUurJJxb05CnqGWFomEwtxjgKeikxDAatT8zrsudrvIEHEKlvC+ecFmCzHKq0nNRXfg==
X-Received: by 2002:aa7:c0d4:: with SMTP id j20mr34172050edp.319.1643882366463;
        Thu, 03 Feb 2022 01:59:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q10sm16642507ejn.3.2022.02.03.01.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 01:59:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFYth-004vVR-62;
        Thu, 03 Feb 2022 10:59:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: [Question] Translation Dictionary
Date:   Thu, 03 Feb 2022 10:54:58 +0100
References: <016401d81547$728834e0$57989ea0$@nexbridge.com>
 <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
Message-ID: <220203.86sft05kzm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 03 2022, Jean-No=C3=ABl Avila wrote:

> Hi Randall,
>
> I guess not all git translators are subscribed to the mailing list, as
> they mostly interact with Jiang. I put them in cc.
>
> For French, I try to maintain a glossary of terms in the header of the
> `fr.po` file, available here:
> https://github.com/git/git/blob/master/po/fr.po

I started trying to come up with something similar for the Icelandic
translation I plan on getting to any day now (for ~11 years and
counting).

I think it would be a really good addition to git to move this list into
a built-in or an option for "git help", something like:

    git i18n-terms

Or:

    git help --common-terms

It would help users that use a non-English a lot, since they could use
it as a reliable cheatsheet, and it would clearly help translators,
since it could be one of the first things they'd translate, to anchor
themselves when it comes to translating blob/tree/commit/tag etc.

If you're interested I can help you come up with that. Basically it
would be some "static" array with that table as C code with strings
marked with N_(). We could then add optional explanations as in
gitglossary(7) (and even eventually generate that documentation from
that code).

> Le 29/01/2022 =C3=A0 20:35, rsbecker@nexbridge.com a =C3=A9crit=C2=A0:
>> To the git translators.
>>
>> I was wondering whether there is an official translation dictionary for
>> git-related terms. At times, I am asked to provide presentations with an
>> initial translation to companies in various parts of the world. It would=
 be
>> nice to be able to follow the official set of terms used in git
>> translations. Does such a thing exist?
>>
>> Thanks,
>> Randall
>>
>> --
>> Brief whoami: NonStop&UNIX developer since approximately
>> UNIX(421664400)
>> NonStop(211288444200000000)
>> -- In real life, I talk too much.
>>
>>
>>

