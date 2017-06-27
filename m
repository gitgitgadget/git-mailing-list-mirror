Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1086620401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbdF0Tdl (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:33:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36394 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752646AbdF0Tdk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:33:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so5941659pfk.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dMFlr3hArMHOHWLyGkJAEXQub0VoAx6Ztmvj5jGc6vI=;
        b=vTTZ1G7uvv1eHhN/zv6fcw6rz80gsimMKbTc2YvNdcEOiVbcPT5ONDGBi1GI3ltw3W
         iTtVSyVYl8rFXiR/CdquVgAB1vnMuTP8ZgPUArW3q5yG3xrlCmRacQpw7lUM3X5WUHGh
         f6vDiynwMS2gbp+YgJPdYaBOe0ruLj1GgxxCrpU198JcNglNJhI95TtElCBDvllCncnL
         7XVxV7h/H5EXERF3ZAAGvBvGATR9bMdh8p0TnUbYss8I08SnKUVT+NEBaDi2Q/cwd5In
         Hp+QT4fzCm6pVOvAJHDEeP3IajOmwfHwom+8wbfb1kqQrBqMNCETGHDxM+RDwry7exlf
         D2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dMFlr3hArMHOHWLyGkJAEXQub0VoAx6Ztmvj5jGc6vI=;
        b=mS/+RfjKPAZvcrzKramvmHdUX1sd0QJZz5sH+OPRw5hu8D5+TUxClnI7mssbIvKHsE
         S9dLjxBI3fekV8M7jXFxusNgAi9f+FRtMplH0AWanlQL4clRhIHZpmTxE0TaPI8N6p3j
         NsbcQLB5pUmbhWv8XOYCl3q4vqnGX9XO2a1Zdep40IKTRp/UueDH9dWkOod81zHpdJBr
         e4r1Zj2f5zlh9geJqqUiG72A2SCpulvu5Xb1Qj2nWWtQNmmSH1SG29oBGMuJ7wfJHAXk
         6xu9Ysimtg548LM9M46JIpLgLJUw/fDUJKg73dY93dvIGgPgOh64M3qMhlU8UnwPSxty
         4c9g==
X-Gm-Message-State: AKS2vOwWePB1DGwAZVmAAjKh4aYnwIimSGpiHTjY9pZi/B8ByiMPM250
        JP2Kz/E9WHp2sA==
X-Received: by 10.99.140.79 with SMTP id q15mr6745122pgn.140.1498592019220;
        Tue, 27 Jun 2017 12:33:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id g15sm99143pfe.70.2017.06.27.12.33.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 12:33:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
        <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
        <87wp7xjo5x.fsf@gmail.com>
        <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 12:33:37 -0700
In-Reply-To: <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Jun 2017 12:10:10 -0700")
Message-ID: <xmqq37al1azy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if the approach like the following might be cleaner to
> extend as we find other oddball platforms.
>
>     #undef __SHA1DC_BYTE_ORDER
>     #if defined(_BYTE_ORDER)
>     #define __SHA1DC_BYTE_ORDER _BYTE_ORDER
>     #elif defined(__BYTE_ORDER)
>     #define __SHA1DC_BYTE_ORDER __BYTE_ORDER
>     #elif defined(__BYTE_ORDER__))
>     #define __SHA1DC_BYTE_ORDER __BYTE_ORDER__
>     #endif
>
>     #ifdef __SHA1DC_BYTE_ORDER
>      #undef __SHA1DC_BIG_ENDIAN
>      /* do the same for variations of BIG_ENDIAN constant */
>      #if defined(_BIG_ENDIAN)
> 	...
>      #endif
>
>      #if __SHA1DC_BYTE_ORDER == __SHA1DC_BIG_ENDIAN
>      #define SHA1DC_BIGENDIAN
>      #endif
>     #else
>      /* 
>       * as the platform does not use "compare BYTE-ORDER with
>       * BIG_ENDIAN macro" strategy, defined-ness of BIG_ENDIAN
>       * may be usable as a sign that it is a big-endian box.
>       */
>     #endif

IF the above turns out to be a good approach, it may be better to
determine the __SHA1DC_BIG_ENDIAN outside #ifdef __SHA1DC_BYTE_ORDER
block.  That makes the resulting #if/#endif nest shallower; the last
part for platforms that uses defined-ness of BIG_ENDIAN (with
underscore variants) needs to know __SHA1DC_BYTE_ORDER anyway.

So in short, two preparatory blocks followed by the real thing,
something along the lines of...

        #undef __SHA1DC_BYTE_ORDER
        /* set the above from BYTE_ORDER with underscore */

        #undef __SHA1DC_BIG_ENDIAN
        /* set the above from BIG_ENDIAN with underscore */

        #undef SHA1DC_BIGENDIAN
        #if defined(__SHA1DC_BYTE_ORDER)
        # if defined(__SHA1DC_BIG_ENDIAN)
        #  if __SHA1DC_BYTE_ORDER == __SHA1DC_BIG_ENDIAN
        #   define SHA1DC_BIGENDIAN
        #  endif
        # endif
        #else

          /* other heuristics like processor bits here */

        /* 
         * the platform does not compare BYTE-ORDER with BIG-ENDIAN
         * so take the definedness of BIG-ENDIAN as the sign that
         * the box is big endian.
         */
        # if defined(__SHA1DC_BIG_ENDIAN)
        #  define SHA1DC_BIGENDIAN
        # endif
        #endif
