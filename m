Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9EC43460
	for <git@archiver.kernel.org>; Thu, 20 May 2021 14:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96EE5613AA
	for <git@archiver.kernel.org>; Thu, 20 May 2021 14:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbhETOme (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 10:42:34 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:35493 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243132AbhETOlG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 10:41:06 -0400
Received: by mail-ej1-f46.google.com with SMTP id k14so22223813eji.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 07:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=HnbT/Sx3NnVr43ioYEhDqRPHehbQUY7BgehOgfpAkwc=;
        b=HJcnh2gV7innLL8c1NnE4Sd0ebYERKufPmRaParGtJtc5l7TN+1xwUEZFGCiRnOpxg
         xCXc+CqhXYOdBI6vkqVr5wP5KwugZw3028hF+UlJlN8DQxmeR9zhOmaMfRFV/nMzgnKF
         U7niGWQVzZVDBHEse9L44zDI9FpDN5ReC106liNdwx0MAlM+fNN1yeJ3SIMQTfXyzHZB
         eO9fVPDATzDJDtR/h5C9aajsBPpntNlirsD9wyrS70B4MsFA0eC0MBBQJQN/ao9n4ExI
         ++RS1a3BkRhSeChXlHPWtnTGKd/R7vz1fx8DnWjlBPDiU5dHn0tAmsQjDj0suj+3wg/+
         Vntg==
X-Gm-Message-State: AOAM530rBe3eaw5Ors2Fu/w+LLEjpKscNevmBPx4mqSWc4Z6f8bGwenS
        ndpbLtRgQZFSS59+d/XexLk=
X-Google-Smtp-Source: ABdhPJwqCXM9lKP7Hdo6tYFzNibReNdYeLsz4lMN4wMAqZpVC8HcR4Y1zkWpgBvf6Tp5jFEo/SWcQg==
X-Received: by 2002:a17:906:b74e:: with SMTP id fx14mr4995340ejb.104.1621521584498;
        Thu, 20 May 2021 07:39:44 -0700 (PDT)
Received: from rhea.home.vuxu.org ([2a01:4f8:c010:17cd:ea6a:64ff:fe4d:ff9e])
        by smtp.gmail.com with ESMTPSA id g11sm1673639edt.85.2021.05.20.07.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 07:39:43 -0700 (PDT)
Received: from localhost (rhea.home.vuxu.org [local])
        by rhea.home.vuxu.org (OpenSMTPD) with ESMTPA id e87d70be;
        Thu, 20 May 2021 14:39:42 +0000 (UTC)
From:   Leah Neukirchen <leah@vuxu.org>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v4] help: colorize man pages
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
Date:   Thu, 20 May 2021 16:39:42 +0200
In-Reply-To: <20210520040725.133848-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Wed, 19 May 2021 23:07:25 -0500")
Message-ID: <875yzda2q9.fsf@vuxu.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So, in order for this change to have any effect:
>
>  1. The user must use less
>  2. Not have the LESS variable set
>  3. Have color.ui enabled
>  4. Not have color.pager disabled
>  5. Not have color.man disabled
>  6. Not have NO_COLOR set
>  7. Not have git with stdout directed to a file

I can't review the code thoroughly right now, but if it works as
described here, +1 from me.

-- 
Leah Neukirchen  <leah@vuxu.org>  https://leahneukirchen.org
