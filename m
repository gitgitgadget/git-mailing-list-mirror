Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F7E20374
	for <e@80x24.org>; Tue, 16 Apr 2019 15:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfDPP0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 11:26:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39987 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPP0x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 11:26:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so27678669wre.7
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zeBuIbw2clP9WSPIPFpQdAOx6qewu7L0o71STys0T6E=;
        b=BKsgSk/d7ujvxUJG6SygUVHDUFSGEqb8h06GepYyF9QeU0XZ9MASfn0K5+7qUl1wus
         MxoPsLcqUtirxjLkMbK8atR6g78oAaoDhBNo0MkKJnFoMRq2T6+OEgS9wbHh079DhxcZ
         2Xju0XTHN3vgY/GzfWsEgxtgzatCq73cO8wmbHAPvmzLdU7loxOhDcpruCY7X2ohLMBj
         51ipvzmK5RaLAQtg/q9y1nlIX9+nvQGaVzaz8yayoLuxVvRY7kZE9eE9qbZSZVffgqc3
         yF+bDPX44f3lmzoQUe7R43xMSseMwk2Z/gpC0fCEUSNFqwunW/S4rB1zxFzlfIiMIPdW
         0U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zeBuIbw2clP9WSPIPFpQdAOx6qewu7L0o71STys0T6E=;
        b=gM7MqQv5flujITtNltNX3ionDZ3cMoqzIvYj0aLZ+ezoL32npW3pA5U/bWqlX1eWEC
         KWnkc6umPiZ6MD4pf0MOLe2qG7gXFFaW9vJTXvI8et3O8NEk72jJ3iQhEbcKJcxdONSN
         dxGx2JtpUoW6DrvUuzRPu3va1hlIfyyoDYEV+kC18uirtTVKUwU5QFvV8GJ3pGRNIE4Z
         IZkmWHSSnt5qQ7YSa7Cau1mJuwWjd+aaEEDD7t8gVOBtJGkZgGKy8+fqFv3qoda129Sd
         lyVNqWf4UzqqoZSYXWzKylXLydqUxl++ke7m8UAet0WcqDKJAclzRjQkvrEGL/Fbonmm
         lH5g==
X-Gm-Message-State: APjAAAUEB/pQAZpGkx5LXXqhV4bmvcbu3ICuab1S2ToYp6p0BFP5n/WF
        B+mTW4M4Hz/rVUTs6XCGPXk=
X-Google-Smtp-Source: APXvYqx0jPShehgBk9lqRGdliGXdYzMIhxTWACYYghVaeji9VOkfq3mvtrvpBNDcV36giPWT1AQ4HQ==
X-Received: by 2002:adf:fd0c:: with SMTP id e12mr18565566wrr.230.1555428412095;
        Tue, 16 Apr 2019 08:26:52 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v14sm69248058wrr.20.2019.04.16.08.26.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:26:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com>
        <87d0lmatr1.fsf@evledraar.gmail.com>
Date:   Wed, 17 Apr 2019 00:26:50 +0900
In-Reply-To: <87d0lmatr1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 16 Apr 2019 16:51:14 +0200")
Message-ID: <xmqqa7gqots5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Apr 16 2019, Junio C Hamano wrote:
>
>
>> * jc/gettext-test-fix (2019-04-15) 1 commit
>>  - gettext tests: export the restored GIT_TEST_GETTEXT_POISON
>>
>>  The GETTEXT_POISON test option has been quite broken ever since it
>>  was made runtime-tunable, which has been fixed.
>>
>>  Will merge to 'next'.
>
> LGTM, but AFAICT this patch of yours never got sent to the list,
> oversight?

I am reasonably sure that
<xmqqlg0bvppc.fsf_-_@gitster-ct.c.googlers.com> was sent with you on
CC: line.

