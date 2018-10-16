Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B071F453
	for <e@80x24.org>; Tue, 16 Oct 2018 04:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeJPMgL (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 08:36:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39571 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeJPMgL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 08:36:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so23756671wrb.6
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gDq8DTaJ8ZW2V87V0vn0N/YxJook7DICXv8D+wKfnPs=;
        b=SD+sx1IuFMtwFL0d0VTbA1Hc21FereW4v2QmAs/hiC8rmEajrNlx3Ts9xCBmQ/4xj7
         WuKMXxdkJwKx1Tssg87JI9wDxv/BGeNLUb/kkGHbLRHTfD8Mv3N7pHXfItEsLa4/dfsE
         ETq9laDh4X151zS6geEL5LaPDSFpn8p0eQ0MYl8rNiXzU61R+WdLAnCFHXTS0xiqqOPR
         K6tk8/QmxZxzgUrzo1UqvXepAH0gEXOzvWoA5RaT6JL55kkkQUtSfMKYNpLWOgK5Jbaf
         3hbrt4JBqPRCHPqED+wXdnW/CmNxHezSi9vMsNs32pKtDXxIVk53FyVdkHCXC+sGstDS
         Lt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gDq8DTaJ8ZW2V87V0vn0N/YxJook7DICXv8D+wKfnPs=;
        b=jnrPIrkahJ41RgagpSGZvMm9ZZ1vXRmDmbLsw3vxYUJOYolysvCnHtWJT0KeHOWImL
         UIn6dZpqjlbGR9X0LjHtD6vmI4AS9MIdvP8ejF6CKinIUGAeUvpt3d8LmejUa3dMppga
         Y2wlZPgf/xnn6gNSf7NrYS3BhOFEPIDegvKm9ylNYIUcBs3NOo3xeoOT1uji6/FUyuXY
         h9DGGkwpLhCvCIk68ybHC9zWE5Q9KlEDnNOU11fobMD9qJL1SKk2zT4yrB9ssDJeqvh+
         afBYv7Q76RuoTD63XPRZkaIRPp90blLVIA99sv+9Of+TwR5VoRfObB9qD99cTW9lyotZ
         xdQA==
X-Gm-Message-State: ABuFfohX5rK0Fk/F35j/FJvJhuDoECIm5DYsf2TrZB5pbzxUtn5+a6aP
        ++jVyO9og4wBzZkJPplk1pY=
X-Google-Smtp-Source: ACcGV63pUrCfHWjqurClYWAIDrj9GJnWgpY5PdmJuEvtR5I2KCHOyG5u4p1+FPzQkpby9YAo9lYapg==
X-Received: by 2002:adf:bc13:: with SMTP id s19-v6mr17995515wrg.255.1539665257848;
        Mon, 15 Oct 2018 21:47:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c13-v6sm9584999wrm.50.2018.10.15.21.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 21:47:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
References: <pull.31.git.gitgitgadget@gmail.com>
        <8736t7dzan.fsf@evledraar.gmail.com>
Date:   Tue, 16 Oct 2018 13:47:35 +0900
In-Reply-To: <8736t7dzan.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 15 Oct 2018 17:06:56 +0200")
Message-ID: <xmqqh8hm1orc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I have not reviewed this in any detail, but incorporating this in some
> form or other seems like a no-brainer to me.
>
> If we have "free" (from the perspective of the project) CPU being
> offered by various CI setups let's use it.

Somebody else said in a separate subthread that there are people who
want to limit the CI, and if we pick this we may want to retire
Travis.  Naively I'd say the more the merrier (i.e. agreeing with
your above statement), but I may be missing something.
