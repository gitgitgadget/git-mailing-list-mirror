Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5F420248
	for <e@80x24.org>; Thu,  7 Mar 2019 00:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCGAT2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 19:19:28 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]:33322 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGAT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 19:19:28 -0500
Received: by mail-wm1-f48.google.com with SMTP id c13so5555495wmb.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 16:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1X9Ag4igZX2T2uF5ZM5UDPI1cCNjjx4uER/PNlcWFu8=;
        b=Sm+QhoLlzqFX7wUuWuVBh23V4iRsN+JbIBbss5u1aJ/Yin3cm+xFEbpSley0BDvQUk
         5YTQ14duLg/bS3LW/sYNdGXvkWncfrURRqYuywziql1lWiXQE7iwLUlancEUYYq7LcFx
         Yqnw8Vk9ZdtoH4YHC8wv1Kq866CjnB0B6ofKF1jvK5vszxBGIpLSl/N7+efYqQlWF/lj
         CfSbvkBnvVpXCMSlrDSoz/EI0CNatiX73fKG+YBCPk7agBEfjyQ6owfXOmp5yX510y4Q
         fxbyMNbW9Cljn19xLbB1oBwB0FT3OIP4QqDeADx6XgZlYUrlwORrhdWzhCMdQd7nDlcs
         7Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1X9Ag4igZX2T2uF5ZM5UDPI1cCNjjx4uER/PNlcWFu8=;
        b=E0pc7TtCnmpC2oLg/MuUi1MW4N3g/GuTsDkJSoF6xKKw43g9UtDkpzHK3BIszTwC+w
         3/JDoH5VMgiLzY1JX8rVMpU7NBdwtBvuYZkpzclZEaBGvPw9ZqmgQueIVOf8b2TKbi2c
         74keRGDNXfKOQjP/ptn6H2xAAatpZe4cexrKuHcWZDbyDt7q5Ge9BXlaNaUw9IzGKZMC
         0b5205hh23Ppz1GnaBA/bE8HZQpYJBnIOAjTCzZmNhi4+t8hTiVM0qS7z3XH0xducptw
         ErUGyO1kVbkBao82aImaykVwmdbZFJJE27FVhyAq3Asrm5WSqEE4eLaEYFn4xfF5Y63w
         SMvw==
X-Gm-Message-State: APjAAAWirzFXJq2fF0WIQSXwTT/N+BV31kU//7mlgtGrX6e8V/oglh5E
        vxlpgvUmsm8PoQr/1qUvZmE=
X-Google-Smtp-Source: APXvYqxKPmzIBHw3Z/Sf1tDAq5Du+Jl1W8cd9FvTfvPswKicRq5oQeDT6afJ+krXhLezXwn4sc4kFQ==
X-Received: by 2002:a7b:cbd1:: with SMTP id n17mr3807250wmi.21.1551917965834;
        Wed, 06 Mar 2019 16:19:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p6sm7784429wre.63.2019.03.06.16.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 16:19:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <20190306181038.140413-1-jonathantanmy@google.com>
Date:   Thu, 07 Mar 2019 09:19:24 +0900
In-Reply-To: <20190306181038.140413-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 6 Mar 2019 10:10:38 -0800")
Message-ID: <xmqqzhq7o7sj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> * jt/test-protocol-version (2019-02-06) 8 commits
>>  - t5552: compensate for v2 filtering ref adv.
>>  - tests: fix protocol version for overspecifications
>>  - t5700: only run with protocol version 1
>>  - t5512: compensate for v0 only sending HEAD symrefs
>>  - t5503: fix overspecification of trace expectation
>>  - tests: always test fetch of unreachable with v0
>>  - tests: define GIT_TEST_PROTOCOL_VERSION
>>  - Merge branch 'js/protocol-advertise-multi' into jt/test-protocol-version
>>  (this branch uses js/protocol-advertise-multi.)
>> 
>>  Help developers by making it easier to run most of the tests under
>>  different versions of over-the-wire protocols.
>> 
>>  Blocked by js/protocol-advertise-multi
>
> I sent out a new version, on master, that avoids the block:
>
> https://public-inbox.org/git/cover.1551131153.git.jonathantanmy@google.com/
>
> It is mostly the same except with one new patch.

Thanks.
