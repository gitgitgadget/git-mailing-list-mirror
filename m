Return-Path: <SRS0=3Zv9=35=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E011C2BA83
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF4720820
	for <git@archiver.kernel.org>; Sun,  9 Feb 2020 23:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR1+NKqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBIXPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 18:15:52 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35521 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgBIXPw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 18:15:52 -0500
Received: by mail-ot1-f44.google.com with SMTP id r16so4623944otd.2
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 15:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P2dbTeldtPyk8oZzT2hJTG3GhDjAUWgw58HWb5JL8eE=;
        b=lR1+NKqm6rxAwWJAlGtLy22L5CvAG0mz/TUYzuWkloXF0mH/wGhxjW2ScSOi86wkEk
         /wW0DQxas027Qu1C9hH2UIy7wX/OCsm1T41WtLWFbvHb1Dtwa4NZNgE/F9GT6+4ujYzB
         prU1LWEqhUTN8ZivBACjwBZuQdjGH32g1eLHABbELHvnq8r99n77iq5ZinuM3tl0qmLX
         LykCTHEwnT89sMW1io+TrznFV23Piasn6fmFOVUQn5tekKHL0b2mbSEXmSCeZJCZXxjC
         /3xc03RyzdzWbKwAe1oHbKX/+oWPas3jk1q9PGJEqYdouJG7X0eDPSVd10YKqaq6kJsl
         3Gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P2dbTeldtPyk8oZzT2hJTG3GhDjAUWgw58HWb5JL8eE=;
        b=J31UXzRlR29kuh+T9zPZn3YCJb1z3/jpnenrUrdz1mMIaoyzeOkeVTsDixcSjH/CZ3
         +xL94Yz7Cbz7V145zq19zvgvU0SHQWcF/ALPBzYTli/sE6U9A0+TCCL6qpSvzP4FMtl9
         chNlEy9+mOD1tCMtKwCbX8b0foO0HUvP6yoTJNlD3XW/OwGh9CqXiB5tc+SYFASGyUbk
         LWeVbnXSNQ8R5HkK0SE6s8+LQztiNl/QcYnHGeEqThvgAgbCthkCwCRErSzephEaeFyJ
         xwHzieTZ1N0xBljcxyz/lsF6NriUNHPnBG5MUuOBiVdDEg1V30uEtc7RAcDm5LUUQc5R
         +J7g==
X-Gm-Message-State: APjAAAU3+ayCmUSZot7AyuRJ3WF3EBtlB0IVzaoNo4uEfg6qVARTOURR
        C1t9m3t/3z3qUWVVW3fVQS8509ZNlacabNud95RGQ73S
X-Google-Smtp-Source: APXvYqzB22Ie146lbguMAJwBIzYVCSjWU/MIH8IkVgn29G3XXu3Cp6inpxKOn/EbDGT6BCzYx1eCL7VYxHR+P6Z1XhU=
X-Received: by 2002:a05:6830:14c9:: with SMTP id t9mr7827014otq.177.1581290151120;
 Sun, 09 Feb 2020 15:15:51 -0800 (PST)
MIME-Version: 1.0
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 10 Feb 2020 04:45:40 +0530
Message-ID: <CA+CkUQ84C59mw4shrg6aPAsf3aF_VDG+5AuDyMB=zgtCviBZdg@mail.gmail.com>
Subject: [GSoC] The Fake Doubt
To:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Cc:     johannes.schindelin@gmx.de, olyatelezhnaya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have been going through SoC Ideas[1], the project idea "Unify
ref-filter formats with other --pretty formats" attracted me a lot. As
far as I understood, the main aim of this is to get rid of duplication
of similar logic.

Currently, I'm going through `pretty.h` and `ref-filter.h`. Also, I
had gone through some past conversations. I found that Ogla Telezhnaya
did something similar in `cat-file`, that also worth going through.

Let me know If I'm going in right direction?

Thanks,
Hariom
