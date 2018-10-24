Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C411F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeJXL7G (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:59:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55640 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXL7G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:59:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id s10-v6so1678471wmc.5
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ehD5q+ekHMEnwNf/EgJ/7KwqpNvFIgbgUYNB2GcukFI=;
        b=ocDGNQehACxVN0B5fNi3RIwwbRrI31AzvxFKmf0rhTDa5ax9z/25RJ7cwCNo7IHYbQ
         KfV11CJq2OySR+0Ql/TclI5k4JJwOXCEwMXPb5NNWTtidsWuvIgAEQT6BvDwMrL87Efo
         8HA4fHyKhj3zrzCPFMkmGegK2q8GQekfwjfVUNO7Fo9v0QLRzpPnu876G55yUiapgX2l
         wvI74CbxBP7VJoxOpsQ6Ma7rGmSooWSJYvPYdtCR4mi/zmcdB+uZ1hefyoDTFy6OjRUg
         gOHTjAdEGJxhRXdEoSBHiCPFYp487q8xYNjVre7vkrnGHykdtogvvXanDunzKWRfzsgx
         2ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ehD5q+ekHMEnwNf/EgJ/7KwqpNvFIgbgUYNB2GcukFI=;
        b=kMeSdAYsjoUPo/IWWQhAIeM6HI/EiE7Y6zpHqRhqadOph7RoMHg0WmhzUqwC60swbD
         /VrYYXBa1bRBDS3+v58hUaTrD02fh8kkOxaZZEl4wA7fjctnZ/QD0sAWMs2aw9SvgWDt
         AV1G7kI2F+agvNn+D3L4ZfEEwMvb/9vXKq/9DquSYbhRtmWJJQGLKYGozwI8ab+oxr5h
         yBLMoZUtfMqn0Kk7fqy5TTnc2hsZ17Db2ASZTbNr7W/sbdqW3b6tF6+jwDXLaeIkLi5Z
         F09N00UZjbKPQGCkkLnocn0ELlQsygXTu0pViLudLPkNWf0cndvqgxxQpm7l6MgCr7+c
         e68w==
X-Gm-Message-State: AGRZ1gIs6uG2VqFfIAZowdhz050bEmsHHDJStkASw3VZzfkFifQaaL50
        KlOKdUFD9X2v7RP97YOMTTbMF/slM08=
X-Google-Smtp-Source: AJdET5eOQ+QBZcTirJaiR2Pqf6WVdsMG23JP/DvtGnxTN2opU4E91gxBUsVJtMEnmJK4PP8lpOyACA==
X-Received: by 2002:a1c:3b89:: with SMTP id i131-v6mr428266wma.27.1540344702673;
        Tue, 23 Oct 2018 18:31:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j203-v6sm4937273wmd.46.2018.10.23.18.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 18:31:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@comcast.net>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        pclouds@gmail.com, peff@peff.net, jonathantanmy@google.com,
        jeffhost@microsoft.com
Subject: Re: [RFC 2/2] exclude-promisor-objects: declare when option is allowed
References: <cover.1540256910.git.matvore@google.com>
        <931421945c040ba4518d91f7af9f386d0136bd2f.1540256910.git.matvore@google.com>
        <xmqqin1ts11h.fsf@gitster-ct.c.googlers.com>
        <alpine.DEB.2.21.1810231053550.56374@matvore-linux.svl.corp.google.com>
Date:   Wed, 24 Oct 2018 10:31:40 +0900
In-Reply-To: <alpine.DEB.2.21.1810231053550.56374@matvore-linux.svl.corp.google.com>
        (Matthew DeVore's message of "Tue, 23 Oct 2018 10:55:49 -0700 (PDT)")
Message-ID: <xmqqva5sqgeb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@comcast.net> writes:

> On Tue, 23 Oct 2018, Junio C Hamano wrote:
>
>> Not really.  We were already doing a controlled failure via die(),
>> so these two tests would not have caught the problem in the code
>> before the fix in this patch.
>>
>
> BUG is apparently considered a "wrong" failure and not a controlled one
> by test_must_fail. I just double-checked that the tests fail without
> this patch.

Ah, I was testing a wrong codepath.  Yes, it does call BUG("..."),
which is a prettier-looking abort(), but I somehow thought it was
doing die("BUG: ...").

In any case, thanks for the fix.
