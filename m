Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B53D41F404
	for <e@80x24.org>; Wed, 18 Apr 2018 21:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeDRVZ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 17:25:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34053 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeDRVZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 17:25:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id d19-v6so8545256wre.1
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ni6DcJbjVJObgeQwRTbwCmwR+69jtSv6fC6JBouvWXI=;
        b=DrJJmYxjCZNPIQ9qYT1ZYJNhtKowTDGFprWVkGqaWFuCW1RCQqOkS+SPwqPFCSYjIN
         pA1s5xo3f/nicTmhSoDcBIgAg6OyOGeDnKuSw1MgU+e/ykHjOxODdI36yp11xuj7jlz5
         8We6Nw6YpSvEf8p5CakJX38hRqukXLZqbdyJtXQ856WHpyEu2ZJyEux+KEatz5WpcS0x
         4y6YH4gNKrVM+trDn1KnuMpAvwms/AAv57E7SC6TL4wwQJVd3jNNvIX0YZBsNAzHTj2Y
         0vI457Iu3ficV5IkFEznqHr2AF+SmO+2ANb5X15zHY/WxvFnmIe8GD9cx8pusoW1AkSD
         DmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ni6DcJbjVJObgeQwRTbwCmwR+69jtSv6fC6JBouvWXI=;
        b=NGQggM+jI1kC6mncaR9d05mITHr3b4+ffDSvNeJMp7c/RAk8eDT+g88D8inzhdPwsU
         j/GqZI605QdaX3gC5Jw1BTPLN12sDeu3R0fH0EdS2/vFNcE9jEwxG7CAuoJVlak5Xw/Z
         wHcrU2QgNQeK+e2QH90rEjzXzstEkfLnedKi7lh5WIa2chbHQ9zxiuoXQmbtYzy+Pte1
         3CFQuFZ0yT2wKom8+tDlGZuuSwDui0m+k/nXOdXMiIKyAT1VDBQYmr0vJtonhalnVZja
         eMXJHVJWp56lvvB792lD9Cz1rKzzwJ4zxkfiLpd+KgVcIoWqKYF2KXJkD5bUstowv4HG
         Q/ZA==
X-Gm-Message-State: ALQs6tDclIkzQqXBQjBA55g4zz3+aXekCtdI3SJ+K6Lw73Lw4SwEpoYk
        x19NmSXD1BTZtIRPgOD/8xs=
X-Google-Smtp-Source: AIpwx49G8dx+OtHvEe9uii0r3WNBCL2NTbggXWIdV7RGyxp1xYoYem5y/hccs7/EHU1UViatYLGPBQ==
X-Received: by 2002:adf:8ea5:: with SMTP id q34-v6mr2556321wrb.245.1524086757539;
        Wed, 18 Apr 2018 14:25:57 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n49-v6sm3088318wrn.50.2018.04.18.14.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 14:25:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "alexmv\@dropbox.com" <alexmv@dropbox.com>,
        "blees\@dcon.de" <blees@dcon.de>,
        "bmwill\@google.com" <bmwill@google.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>,
        "martin.agren\@gmail.com" <martin.agren@gmail.com>
Subject: Re: [PATCH v3 0/2] fsexcludes: Add programmatic way to exclude files
References: <20180410210408.13788-1-benpeart@microsoft.com>
        <20180413122218.1756-1-benpeart@microsoft.com>
        <0de30972-b0a2-67e8-7cff-c19daf9ece8b@gmail.com>
Date:   Thu, 19 Apr 2018 06:25:56 +0900
In-Reply-To: <0de30972-b0a2-67e8-7cff-c19daf9ece8b@gmail.com> (Ben Peart's
        message of "Wed, 18 Apr 2018 11:31:15 -0400")
Message-ID: <xmqqin8ogqaj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> I found a bug with how this patch series deals with untracked
> files. I'm going to retract this patch until I have time to create a
> new test case to demonstrate the bug and come up with a good fix.
>
> Ben

Thanks.
