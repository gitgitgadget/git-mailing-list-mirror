Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D5841F453
	for <e@80x24.org>; Wed, 26 Sep 2018 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeI0EDv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:03:51 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:43886 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbeI0EDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:03:51 -0400
Received: by mail-wr1-f53.google.com with SMTP id z14-v6so407438wrs.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 14:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IJZouzbJpGvzSrrPPiGGyoyWajlcVG9vYtI7NGAeY8Q=;
        b=QR8crRJip6o4C7mkPQdoXP8W1/LGC6ltxcYxOMMIrolM1NpZrSEwJg7yfYKrrFhW98
         wlaEW91c1Ad70QXw30VKHSMX+rZlSrC+yDrIgqhqEuNT+f5PGipfghDqVJyRmW7dGtm8
         j1wshL8Ta10QjRbQp/OKyG0PyCEAKDLYTgmOVgx+lvS1FfNI9L0fnwI2XWb0JYU6eTEB
         N16RAmrg8nQcFIWeV5MxJ4Dg3YNBnZHM1qsJV/+yrA/Bt6sAcTd81MefL7y5GFKiOBYz
         d8ie/o1auu1WBvdizHbxC5EBMhizWa4C3FrSvUiHhfl2KhjvPY24MTBdBqiqldz8Mkxn
         xGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IJZouzbJpGvzSrrPPiGGyoyWajlcVG9vYtI7NGAeY8Q=;
        b=gDDR3/YK24EXDK2vXpXyLfi5iD1SFvh96dFOh8ISCOR9Wv+mvQFHb+e6IrD0dCuvqt
         RD05YBqW4UTnAY2MMRYEbpRwiP6oc2cCd/OhNeiJIvQEz05cMPYMCvfY+bnZsJAr4ndG
         9wnU762+isJskv07hdYwKYS+vfu04soOBHmWCpMGmGS6kXegH4fFrzL6HnPwxDGQ3qYx
         DmEo1vBaR3HoDrbAcphIM4/5zGyqLYxM+KpttiZ/cUVZh/CpVeIJw7DnZDoZvDWqbDtp
         5YmBizdXsE1bBjWbwcfIid/kVbQa0qCw1/qh8J28hLI9ssba+OrM/dKyR5dUJ77hrRNl
         I2GA==
X-Gm-Message-State: ABuFfogQGqjDCVOJcEu4gZedz7dgoEnmEj8kI7vLBcAgPxiImH0k1JtM
        wAG3K8eRnpZ6YwQdohygSGg=
X-Google-Smtp-Source: ACcGV628zs9csCL2EX0am3vZpn+J9Ii7L8I/HLNBdAGZlvwdY6jcyS92I2PUUIdvcdNUs5msTrtEqw==
X-Received: by 2002:adf:9031:: with SMTP id h46-v6mr6365647wrh.248.1537998530707;
        Wed, 26 Sep 2018 14:48:50 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z69-v6sm759052wmz.18.2018.09.26.14.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:48:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tacitus Aedifex <aedifex@sdf.org>
Cc:     git@vger.kernel.org
Subject: Re: Fixing constant preference prompts during tests
References: <20180926162638.GA28077@SDF.ORG>
        <xmqqh8icmb8l.fsf@gitster-ct.c.googlers.com>
        <20180926213703.GA22278@SDF.ORG>
Date:   Wed, 26 Sep 2018 14:48:49 -0700
In-Reply-To: <20180926213703.GA22278@SDF.ORG> (Tacitus Aedifex's message of
        "Wed, 26 Sep 2018 21:37:03 +0000")
Message-ID: <xmqqa7o4j5fi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tacitus Aedifex <aedifex@sdf.org> writes:

> It may be a little more complicated than this because looking at the
> tests it seems like they set up their own dummy user with dummy keys
> and use gpg directly.

Yes, that is """the test framework (t/test-lib.sh, t/lib-gpg.sh,
etc.)  tries to run our tests in a stable environment that is not
affected by real $HOME etc. owned by the user who happens to be
running the tests, but it could be that your copy of GnuPG may
require a bit more seeding than we do in our test framework to
squelch that preference prompt.""" part in my earlier response tried
to say.  We do not want your choice of gpg.program or what kind of
trust you have personally recorded in your ~/.gnupg/ affect how gpg
invoked inside our tests work.



