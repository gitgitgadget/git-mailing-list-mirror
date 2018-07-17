Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D1031F597
	for <e@80x24.org>; Tue, 17 Jul 2018 09:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbeGQKUf (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 06:20:35 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35158 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbeGQKUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 06:20:34 -0400
Received: by mail-ed1-f46.google.com with SMTP id b10-v6so675195edi.2
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 02:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=83/oM5DqtN4z5TUfuHem/s5Y5MNJiOrFVo5ttdOajvI=;
        b=m1ziMewGTGZvxwcnX/WjYMDDFIB2mTGgaO4McEgrnlV/qJh9g2GMCttMRTlKMWdAlG
         O1KRcj5av5n3l3ebVSBv24dEKW0C3yIW3eH20r3c/WEyT5fUZJBc/TFehVOA/sgJbDdE
         goal7JJ1LnIiE9zVcqFBXOoS/naBy3bDu81UhggeoYSuIPvpeqMIFRp1qNNFrDfGVPRf
         o1xERKXldA12LlWAycMYteiXyKp130Xq3KeX0KyHyEhuLYVyuMTATQmViv74d+sD9p7Y
         hvsVOaBIxQDZJjn+1n9toA/09MZmerKztEX5ftlxcxdMjzu3DOM+G88/1n0pohCU3aA4
         +GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=83/oM5DqtN4z5TUfuHem/s5Y5MNJiOrFVo5ttdOajvI=;
        b=WeMBfxcrgpXPXmnhpsK0krSAbLCwbNfdyrpRIlo5uarkErjHZzTt5LMpm34z5beahB
         dbzDgBPryD5d+dkkCNul/FeexhJrdjOjl1O8vm2qHRfEyqte/Kn/mSKmdznWaymviOQh
         ZoPFXvNvlM1cF/vw11jrInGmTRjTJabYuDqrzhxkDsC3110BtkaqNvMjd4DtC4HV7XY5
         5oRp2WnmmVm0ZqllXq2IayxDonNR2hX1UH9hCM/MFKtPBef1wwOZpOVdg8HHVGvYRp0s
         Jc1BNXC1yjhf7GUSPQb+iyL2mYh8OtdAeC2kOu0IA5im6YcclKyptJ9ircvrm3OSK3yE
         O5VA==
X-Gm-Message-State: AOUpUlFlC6prPOvB8TMdkTeCH79zRnE6q2apKU3vpU18yyPAHUftfDQV
        klnIjIFEEba7/3dak9eViIOi1C6K
X-Google-Smtp-Source: AAOMgpelvXL1bPJIi+inSQiP+MssPchPWJh5qUEga9hIck5uAUmK4cgq789knVPe4guaPoGBWIv7wQ==
X-Received: by 2002:a50:ba6e:: with SMTP id 43-v6mr1689112eds.292.1531820926330;
        Tue, 17 Jul 2018 02:48:46 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id k32-v6sm320379edc.85.2018.07.17.02.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 02:48:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "J. Paul Reed" <preed@sigkill.com>
Cc:     git@vger.kernel.org
Subject: Re: Are clone/checkout operations deterministic?
References: <20180717091429.GA31043@sigkill.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180717091429.GA31043@sigkill.com>
Date:   Tue, 17 Jul 2018 11:48:45 +0200
Message-ID: <87bmb6chvm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 17 2018, J. Paul Reed wrote:

> Hey Git Devs,
>
> I have a bit of an odd question: do git clone/checkout operations have a
> deterministic ordering?
>
> That is: are files guaranteed to be laid down onto disk in any specific
> (and deterministic) order as a clone and/or checkout operations occurs?
> (And if so, is it alphabetical order? Depth-first? Something else?)
>
> In case the answer is different (and I'd guess that it might be?), I'm
> mostly interested in the initial clone case... but it would be great to
> know if, indeed, the answer is different for just-checkouts too.
>
> I did some cursory googling, but nothing hopped out at me as an answer to
> this question.

In practice I think clone, checkout, reset etc. always work in the same
order you see with `git ls-tree -r --name-only HEAD`, but as far as I
know this has never been guaranteed or documented, and shouldn't be
relied on.

E.g. there's probably cases where writing files in parallel is going to
be faster than writing them sequentially. We don't have such a mode just
because nobody's written a patch for it, but having that patch would
break any assumptions of our current order.
