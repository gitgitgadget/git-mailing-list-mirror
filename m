Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E3EF1F597
	for <e@80x24.org>; Fri,  3 Aug 2018 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbeHCUsf (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 16:48:35 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42870 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730588AbeHCUsf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 16:48:35 -0400
Received: by mail-wr1-f47.google.com with SMTP id e7-v6so6265655wrs.9
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 11:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=J8qOp9sa5khPpQyhjRCgSUtlksitY8tVcBp7RdMy1Go=;
        b=EeGCIW2ceTc3YTMC47LucZNplgKthvSU4Ker6mC1NfTGiA3EMwp1dLFhWjQ5D1hw7e
         9C43a6XAC0Ad3MlzdHYMHiPsuJNn56W5B2YubhnFynHUdOrYiu328p7FmnPtzvI8Nd5W
         KhDac3Yo7L7ZPqB6vyivEyRVd920YhDsJ29aWrZN4yl7GY7/N6E/pMswyb0LagsZjJ7U
         P7XBhwRbon0MOgQvab6q0370Dd5rTLFfmq/sM200DjUo05r3PUPtUcg3ZUkjv+asx+xK
         BJtb7dtoD2Wg5sR9W5CNxAQlAvlp8E0BYmgvVNFQ/wkQa3IFD3Bs7EYqm0W2eFOuiTPJ
         CphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=J8qOp9sa5khPpQyhjRCgSUtlksitY8tVcBp7RdMy1Go=;
        b=TjBbHW3vdPNsfnhX2i4hqOEv2Fp557oh2aKWzVhay7Muyuvfw/vDrPKs4bRmMIAJEW
         KScu21Xu0+gEq/MzH4LLhdqhA5Nxr9aVh0gKHkP6jlD/MlygXX4dxFQkbADZKUz4Bw/h
         c7yxE7xRqW59pd1ruQ62/1OMGRZ1iKsBlHhg7qhskztV9BnOZEtV2OvcfchXu3sJmoWa
         aSFuYM14reqf8tf3k3x4sOJFR9a0ylc2K9IGVvPeayy83BF7ccaRCraTmT/zwTs23XEa
         C0EQjybZnYOgyfBKdOggM5U26+NACuEPa6dxJjdaMHV8wcCNBmChVTOXEGnH8I9qAy9y
         jQhw==
X-Gm-Message-State: AOUpUlGFQZtqugQr5dfUGTEKWjFIUO6LG0aFl0/8M+zBJyhYCRW1NUSP
        RSYqH180QQ1eBJDNp2xYHnQ=
X-Google-Smtp-Source: AAOMgpchWznwJWexoYBxTyDrjOsZmiE9nDnZJti9TigyxHhlpjXHWXN3BETgkv4cCsPrJ7ayRLQ44g==
X-Received: by 2002:a5d:41c1:: with SMTP id e1-v6mr3350397wrq.25.1533322263889;
        Fri, 03 Aug 2018 11:51:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n14-v6sm66665wmc.14.2018.08.03.11.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 11:51:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <20180803180912.GD106068@genre.crustytoothpaste.net>
        <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
        <20180803184508.GE106068@genre.crustytoothpaste.net>
Date:   Fri, 03 Aug 2018 11:51:02 -0700
In-Reply-To: <20180803184508.GE106068@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Fri, 3 Aug 2018 18:45:08 +0000")
Message-ID: <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Aug 03, 2018 at 11:40:08AM -0700, Junio C Hamano wrote:
>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> 
>> > On Thu, Aug 02, 2018 at 04:02:36PM -0700, Junio C Hamano wrote:
>> >> --------------------------------------------------
>> >> [New Topics]
>> >
>> > I had expected to see
>> > <20180729192803.1047050-1-sandals@crustytoothpaste.net> (the refspec @
>> > handling) in this list, but I don't.  Were you expecting changes or
>> > additional feedback before picking it up?
>> 
>> Neither.  I just am not all that interested in seeing @ used for
>> HEAD in the first place, as I find it quite confusing.
>
> Okay.  Is that just in this case, or in general?  If nobody but me wants
> this feature, I'm fine dropping it.

That's the typical case of me saying something in a deliberatly
outrageous way so that we can hopefully see people from both sides.
