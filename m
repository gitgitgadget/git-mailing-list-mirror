Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7FBC433EF
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 19:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiCETS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Mar 2022 14:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiCETSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Mar 2022 14:18:55 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C46D38BCD
        for <git@vger.kernel.org>; Sat,  5 Mar 2022 11:18:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id bc27so10234608pgb.4
        for <git@vger.kernel.org>; Sat, 05 Mar 2022 11:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=wPwOj/tyijlTfgjHGobOCjgnazJizudQcInhFIm7Nmg=;
        b=asUKpRpkXFa3s7/Mouw5WxLqZsNkaKB3SAb/YuqxQCtvx0Km+GvATbm+Sm4iBX7Pyu
         BB90BUU6bmxqQHVuET09R0WXEGnpOqgGB6E7oLcDvRiSxg7tlmw1vaI113fpNJ5IFXd9
         m8aylEvoJqwa5qxzzlzlX3yy74CipgQ77r7Nih9T2nBEuIc+uWoj1A1xW+ptRJrojCsx
         74N3+JtpF0/Afb6jkqSMaRsjJI8p6zP0eQaMHMR3d64QcecazJqpTRtJnuGBvKwny2D4
         XvUGfngvd8i0w/tVaxkSZJLdNL7O+clQ+/RMQkraHCn3xs1IIGJce2v6bjRtyunRiwRP
         cpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=wPwOj/tyijlTfgjHGobOCjgnazJizudQcInhFIm7Nmg=;
        b=A1xh/7BAJik/9s8GV8sGsUg7PQDt32XgyVCVr+uQMH971V8cm9sdr1CUHZYA7P80CQ
         7u+xgsash5rN2WY4Z0q3o2E81K4lQMOf05ZbL8WHRSykL3lUA+V3Pqvn4FCQKDYCNDLJ
         DbOC0/yutAlvnYzYvN4n81ADD+PXg2aOKy/zxvQiz8F/Y0pnq9hYV7pdI9zwHP1jowmE
         Ym92F2/IHMTfuk4JonK8s2c/xKaLY7CVgiYDBDXIbtkoHXzjojOO94rNNkwr8t/oWlKw
         uexYz987R52ZwjwkYbc5q3lppV3oRL/tY5eBgkZdKqDXebZIy4E4GmCqRYlhk8Ux/QKw
         RKew==
X-Gm-Message-State: AOAM531HvWotMJXQvaNV9hwx6jzhmymQkMkk3F20UGCIhmA25eui+Fa/
        lCb4FuAd/OdKfMSxnlxck2RsgXoGFBm9LvUA
X-Google-Smtp-Source: ABdhPJxo4KfIEZM/URsJ02JIsHZKJwDf4CcO5alAkjObqbFf7HSXI5OGUQb8wpC4BCCB5YcVn2pjKg==
X-Received: by 2002:a63:31ce:0:b0:34e:4052:1bce with SMTP id x197-20020a6331ce000000b0034e40521bcemr3661718pgx.459.1646507884748;
        Sat, 05 Mar 2022 11:18:04 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id s8-20020a056a0008c800b004f664655937sm10871710pfu.157.2022.03.05.11.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 11:18:04 -0800 (PST)
Message-ID: <6481bd49-eac9-9ebe-3d19-866107378f81@gmail.com>
Date:   Sun, 6 Mar 2022 00:48:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v4] userdiff: add builtin diff driver for Kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220305094004.250570-1-jaydeepjd.8914@gmail.com>
 <4118762b-e2f1-4f77-68f3-e61cbe65aff7@kdbg.org>
In-Reply-To: <4118762b-e2f1-4f77-68f3-e61cbe65aff7@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> > +	 /* method calls */
> > +	 "|[.][a-zA-Z()0-9]+"
> 
> This matches both .empty() as well as .125, but only the .5e part of
> .5e-3 and only the .find(x part of .find(x/2). Is that intended?

Oh. It completely missed my mind. Anyways, that method call regex is better gone.
For matching these,
Maybe we could just use cpp's regex for floating numbers starting with decimal point:

"|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"

Or maybe, we can make the current regex for floats and integers a bit more loose:

"|[0-9.][0-9_.]*([Ee][*-]?[0-9]+)?[FfLl]*" 

What do you think would be better?



> I find the desire to have method calls as an entire token a bit strange.
> In other languages, the last expression part is actually split into many
> tokens: . find ( x / 2 ).
> 
> BTW, I'm in no way saying that this must be changed (personally I do not
> care at all as I'm not writing Kotlin), so if you say that is how people
> want Kotlin code to be split with --word-diff, I will believe you.

Yes. The tokenisation does not make sense if its something like `X.find(2)`.
I think I should remove it.


> > +	 /* unary and binary operators */
> > +	 "|[-+*/<>%&^|=!]?=(=)?|--|\\+\\+|<<?=?|>>?=?|&&?|[|]?\\||\\|->\\*?|\\.\\*"),
> 
> Is the part
> 
> 	 "|\\|->\\*?|"
> 
> actually meant to be something else? Does Kotlin have the tokens "|->"
> and "|->*"?

Ah. yes. Kotlin does have "->" operator but not "|->". Also there are a few
more compound operators like ".." , "!!" etc which I forgot to add. I will add these in the next patch.
  
 
> A final minor nit: There is "|&&?|[|]?\\||" that could just be
> "|&&|\\|\\||" (remember: single character operators are matched implicitly).
> 

Yes. Right.


--
Thanks :]
Jaydeep
