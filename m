Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB99020248
	for <e@80x24.org>; Sun, 24 Mar 2019 13:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCXNDo (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 09:03:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55912 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfCXNDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 09:03:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id o25so6221187wmf.5
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=50g11kJoRfaiC5xWielm80uP31ikohiLuZRKdC8ZfhQ=;
        b=IoGyHeWr/3/K+x+KHeCEuzKu5Jq48EWs+VU+aF+n56Eneh5wKEKSQ1JdAxr/EOlY6J
         vG1MZ7soJjZY7XatadgDwNEKF2r0Gw8u0yejEq8W+YBb9PmOXTBEMbgTeQeyAB58MKaI
         TJZiEt+K8hF/k6eY0txx5mJ3zs/SYO9vk/grjEI67AhHsqeIw2QGVH85ahd6vW9LdNRK
         +uHFOS6HdWjCF6MuiNFks24a3uexsd7yOPxyNGY9Xvbx+Jexop93ALWPtwNyrwJlz6uV
         NO2dSi4Zr+sOF84V6zi4E+mM+YmymmN8S7F/I+WSuL9aQ3xEih02jn5kVnbBgw5XA1L+
         DH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=50g11kJoRfaiC5xWielm80uP31ikohiLuZRKdC8ZfhQ=;
        b=oHh0GFbKZZ3dpT6kDFZaG7zQFATx6g3cmCz9MV4xjW20t2Ucqf5Fdce4rTBy4mxy8k
         Zkg+wpTRs8uAxpK/iNz679YoV1uRstZB3ahc1uxKSx7NZN4yywb1112MpnBgqShKxTtn
         yJHU9dFJuGq8t5cZPJCpultX03R1qXhaB5EyZ85wIcLfybvdPAtSoh+NPyi/tH1sBqOX
         /ywveaxT7rAl2/ZFWy01ksfpgOCdJVfKO6EqQjG3sJgjncdHaaVZixZAsjcYKSCMJV+r
         X3J66Swnln0rHLgPz6HWOJ7vyg9cP9YfncoJqvau1xY9XZXOSH2KDlNk8uaLWswSVgM4
         7A6Q==
X-Gm-Message-State: APjAAAVYfm3SSw0eSFW5WoelPAx6xKUJfWxEtqR45zp688+wz3jk6zE5
        PbxFPnSHx14fY6N75gbKpcU=
X-Google-Smtp-Source: APXvYqxng118HsEkwkn2Uj7HM9hyO4n03s3K6k/czQ2GU0Nb6fb5ZL2t+58tfd0Nh4MeQm8Q+BpEUQ==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr2601815wmi.141.1553432622426;
        Sun, 24 Mar 2019 06:03:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 93sm29566023wrh.15.2019.03.24.06.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 06:03:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
References: <20190323041332.9743-1-alexhenrie24@gmail.com>
Date:   Sun, 24 Mar 2019 22:03:41 +0900
In-Reply-To: <20190323041332.9743-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 22 Mar 2019 22:13:32 -0600")
Message-ID: <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Having --pretty=medium as the default almost always makes the graph too
> difficult to follow.
>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---

I too thought that "--graph" should make "--oneline" the default
back when I originally accepted the patch series that introduced the
"--graph" feature, but with frequent use of "--graph" myself, I
stopped being sure that "--oneline" should be the default long time
ago.  I find that the default level of prettiness goes reasonably
well with the "--graph" option.

This would be something that needs a long transition period if
somebody really wants to force people to adapt to it.  I am not sure
if the complication is worth it.
