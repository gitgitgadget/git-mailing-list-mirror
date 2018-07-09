Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B4DA1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 16:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeGIQ0A (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 12:26:00 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38484 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754459AbeGIQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 12:25:59 -0400
Received: by mail-wm0-f54.google.com with SMTP id 69-v6so21269776wmf.3
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Lnog0SocHsPajkMDJ3dVEhqgllSrroukfNU9udvkznI=;
        b=b5w/51xu92WUCryzJivK1gL1fUnVAqybZKfZek8W49+CJJvqvgtyJ6TS5+yta5XVg9
         qRzmC1RMOaezucfF0l22N2ROY8oHwlDm2gHN8+w+/pYPZmbEcPM1Kq8Koln+N0MFNC3x
         weaHenIPv1Jk2aJFpcMGEoP42SxgwHWNXC72ljfHBUUtypZr57WI0oRDt3m3h8kS61XF
         45/cVilAgvsQcTxuGWkDn9G0/EkXmBRrjwAqDtfS9+4AHsAkogdU9CeZ1mEfEx07L+wA
         j3nVZoX74YbBK8FD4wphghSNX36aT5rjnVSvwjpuaj/KVaGb/ndf20Ss61hgAiJ6Z/n9
         MSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Lnog0SocHsPajkMDJ3dVEhqgllSrroukfNU9udvkznI=;
        b=iCuQ6rRIEbWtktnAKZBRfsCibQG4shfkErgINAjK4ue4z8aDp/vV/F///mkVIrlY61
         EfDybu97lO4fAYWI80wi9Xo/RBUCkDTma/W8pVIpZZ2HMFu86aLXdJpF2TK7k79QqEWR
         ITtOtMiVnzvaCK3jq1SmCZWqkrIfiqnu1B1qSCK0DH/2ChDSWPen6APFNHh7L6FPkf3/
         nSAQ8g3mJfdubqPu5rlasQCXWw66NbBYM0/p3V3nx3c0sV4kG37sp2mnPQBJlFXFu1I+
         zgcmqFalQ9KJCHDr7JT/bpbvyw814OecstXSttm/ycr7kkHPnd2fHFEnE1S7UgEnm4Oj
         52Vg==
X-Gm-Message-State: APt69E3SpvSapD0xCIYBhC2T6Z+lhnNOZxnF4Q5q3c7CVwk6vCbzLZh2
        QmvW66NUKx7dRtKdRoRd4pY=
X-Google-Smtp-Source: AAOMgpf6CBgtrG5XST9Wi377hzqM3fwRy0memwUJsUrkRcn+0ohei63vDbxwTxHmjiWKESI0hOYh9g==
X-Received: by 2002:a1c:b18a:: with SMTP id a132-v6mr11779182wmf.18.1531153558063;
        Mon, 09 Jul 2018 09:25:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g4-v6sm12872614wrq.32.2018.07.09.09.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:25:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Compile cleanly in pedantic mode
References: <20180708144342.11922-1-dev+git@drbeat.li>
Date:   Mon, 09 Jul 2018 09:25:57 -0700
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li> (Beat Bolli's message
        of "Sun, 8 Jul 2018 16:43:36 +0200")
Message-ID: <xmqqh8l8fka2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Beat Bolli <dev+git@drbeat.li> writes:

> While developing 6aaded550 ("builtin/config: work around an unsized
> array forward declaration", 2018-07-05), I have compiled Git with
> CFLAGS="-std=c99 -pedantic".

Nice.  I also pretty recently realized that I stopped building with
the pedantic option by accident, probably when DEVELOPER build knob
was added to the main Makefile, and have been disturbed by these
failures.
