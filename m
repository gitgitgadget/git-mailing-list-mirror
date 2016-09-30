Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CDD9207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 18:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933366AbcI3Svf (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 14:51:35 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32970 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932875AbcI3Svd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 14:51:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id w11so7735058oia.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2016 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/MF5mC2ur97qXMKeJ5W84v4fzEg7OMr867VEGyUUdVU=;
        b=faVMtrEEu36g2Vk34qciSmf4tG84NgZt7OFXMWEfB0mT3+DqAY88yUXvaVNgKXFNcQ
         DhCKWY8BNJXWAN8wkE70FiEjto3nyC6R4qYsSt+Q/33YCqbfidL+MSEQprl42qApcue5
         JuCdo8Of8S9GviVXLxHmNUfGyxS8qFY+LaWmhME+dFWBI9jtRM1RG7tPhp9VguCAWP37
         MnMhVowyKfpYbfnPckIepjJNV7Pmk0+umB2HZ9CVddcTCIlm0CK9fmCLYU2KMV3S1I5C
         GeDaD4UcDdY8paO5xI1XwDw0BqPMC2KNKrZ8JM7fcqPFD4apIZ9IaDA2Ol7xTz/LumHO
         PdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/MF5mC2ur97qXMKeJ5W84v4fzEg7OMr867VEGyUUdVU=;
        b=Z4IIg/U+Sdl8ES+1Z+luI8gBcvjkEJjo4WWGLRAGrYDrLFMPDPTV+1u9v08IHEY6q0
         Rheoz0Zvj2UBDrr+vhuQYkQcs3Tuhwsk5o8JO6Wd3gxbbkdOCV+6S5Z3sykGbVKHkD24
         IlSfOnz/Odv6dcGewUHUSoUWdoYYb9pSEvlE/UD4Sc1JvnxVnJnEz/KSqrjPeaqigVzF
         9J3FgFRc9rc95feCJCyrkuCeQQLk8turG6AYN5IU8fTQeuinP+Yr2vfH5CYzAggFRj8I
         JvzLnclr+Vsu7HoNb2+EScj79aSChvPHf7QazFMNQ3q5RpZmFNNfah352YdNzv5Nlu3m
         tIHw==
X-Gm-Message-State: AA6/9RnH7drphacAbexrNrKAtbDxiOcP3vm20lpsSYg+L9y36qX4Y2amCmgsTIiModcqM2HfhlFzsZwss+IiSA==
X-Received: by 10.202.175.208 with SMTP id y199mr8470085oie.86.1475261476905;
 Fri, 30 Sep 2016 11:51:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Fri, 30 Sep 2016 11:51:15 -0700 (PDT)
In-Reply-To: <xmqqmvip9qo7.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
 <xmqqtwcyavou.fsf@gitster.mtv.corp.google.com> <xmqqoa36auyx.fsf@gitster.mtv.corp.google.com>
 <xmqqeg42au5w.fsf@gitster.mtv.corp.google.com> <xmqqmvip9qo7.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Sep 2016 11:51:15 -0700
X-Google-Sender-Auth: 6685ycl2_X_u3O6uzjoZIZMleyU
Message-ID: <CA+55aFyDqYCBCvw0MjZ8fNhaVbRSjsSXNDH--unYkoeJNwVcVg@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 11:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> There is another instance buried deep in an obscure macro.  A
> minimum fix may look like this, but I really hope somebody else
> finds a better approach.

Heh. Yeah, that's just ugly. I assume this is why the odd git fetch
pretty-printing test was off by one column..

Considering that TRANSPORT_SUMMARY and TRANSPORT_SUMMARY_WIDTH are
both used in exactly one place each, I'd suggest getting rid of that
crazy macro, and just expanding it in those places to avoid these
kinds of crazy "hiding variables inside complex defines thning".

And maybe just deciding to hardcode TRANSPORT_SUMMARY_WIDTH to 17
(which was it's original default value and presumably is what the test
is effectively hardcoded for too), and avoiding that complexity
entirely.

                Linus
