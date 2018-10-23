Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232971F453
	for <e@80x24.org>; Tue, 23 Oct 2018 04:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeJWMpp (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 08:45:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33015 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJWMpp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 08:45:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id u1-v6so39603wrn.0
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=44UjBsvq4iWhvYZbniIwjzJc6WF1hBYy5tFZwMup2nw=;
        b=CL+yLWcErP27YG8RJBhArvHIb45oUv+SDKnFQghs8qrVrFbHqahn1DdWNzFUKoK3Gg
         rrhEp4CGfP1/CTi2bv3YO8bAqkk2GbTsktVqoSvVGaDXoaIERQ/Z9igEJnZOJiz2Evc1
         Bm4/W1w9WFv4oy6BBefCkVgn2GwN0P+at89nM5jFmH5zfFRnGLMkgqMcZoGXYLuEtaBD
         K/xFlHNRXSK6lD+lFYe07l4HzaG6UGlgU4IRLOl0rvvlMk/SSmu0meF0wQTmLTvKLWD5
         DwNVVHJKXJ/43PVINA6ylhmnqf9yM9+C1IMYdrY4uq8fxRc0EOe+8hvJppmOxzzDGn2C
         5XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=44UjBsvq4iWhvYZbniIwjzJc6WF1hBYy5tFZwMup2nw=;
        b=XFBKbCHJLHZko9JPsrWuMycQ5gs2Jth0c0Pe3yaMsKYXrBUS/JsOZ4IKwsE5k521Ce
         2PppJCecHfNToWWvCtrw8C1MfJQmeNjBD8qWckvmEMH9aN+kcKLAKE0Q+GfiuBalUeR9
         kdHoQIl/oLSonsqg870fN4MqHrLBiG2KKVdonp3UK2jGTTZCu+DuMvnaW0lvVnB4rzAm
         FwCFfRfUZEv/K+dTqs0sIEFcuXZI8XEwrtJ865RdA+Ygeb9IRpFn6dm8ZZ29VcUEIWDX
         bZH9uD93T5jNEldMp4ga3m6zQnDJGjBJ1C3dIaKQKF3ba778u80V7g+l5ziPOxSM8jR/
         RG+g==
X-Gm-Message-State: ABuFfohkeffpXZxRwAWLa9dnov2Im0pE9eo959I0lBb7lVpAPo4k+awA
        IHz5Wq6VOgOv4954/NLwyhg=
X-Google-Smtp-Source: ACcGV61xWahOrZmrCUnVL2L3nI8OJvSaWiE0qrbxAt0/lUuhHxtS+UdURYtx87PXvwS72fZ/8FbHhA==
X-Received: by 2002:adf:e607:: with SMTP id p7-v6mr48086991wrm.254.1540268648519;
        Mon, 22 Oct 2018 21:24:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 77-v6sm411200wmv.6.2018.10.22.21.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 21:24:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: New semantic patches vs. in-flight topics [was: Re: [PATCH 00/19] Bring more repository handles into our code base]
References: <20181016233550.251311-1-sbeller@google.com>
        <20181022173935.GG30222@szeder.dev>
        <xmqqzhv5tx4m.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kaWaY+oxJfoMbsCcq6MZDPoq1OgOwK0a9mkKR7sUEOHpg@mail.gmail.com>
Date:   Tue, 23 Oct 2018 13:24:06 +0900
In-Reply-To: <CAGZ79kaWaY+oxJfoMbsCcq6MZDPoq1OgOwK0a9mkKR7sUEOHpg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 22 Oct 2018 17:26:40 -0700")
Message-ID: <xmqqva5ts32x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Am I overestimating or misunderstanding rerere here?

Yes.

> Would it be realistic for next and master branch instead of pu?
>
> I'd be wary for the master branch, as we may not want to rely on
> spatch without review. (It can produce funny white space issues,
> but seems to produce working/correct code)

Yes, that is why I think it is a bit too late to do the "fixup with
spatch" after merging to 'next' and 'master'.
