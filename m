Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668C3ECAAD5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 18:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIBS7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 14:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIBS7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 14:59:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF065F490F
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 11:59:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q15so2745695pfn.11
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=g9Rn3/vC04rfHgmkUGr3oHRdYcvjNjrD2DNniqhQgC4=;
        b=Qi1S4Aity+QUJrR9wt7n4ppE7pfacULT+1YyCP3nX2Ns6e4fNszU6YIV8iCvFnkSef
         l+2mpGEJTaOhia7S8acMnXC6lBGyfzIDdhqVqca/GwFE1KCnt0Z8bSURzSYlhnzmJwIR
         jpbd+BrlcC8uRpOqHxRc/qwo9fXFTaEHrWRjo5j2DenaNuwFUjisoDZPG1fGEGgIdC1R
         r+XFbvtfN5O6INk2WCR1APDH3GMKOakidt8m9ixf6Evk9i2BtSDf+goQTLBuPczd0SCf
         MLTkCaVii04A7qyHQ9Bp3ewAQfh1hfDa0QxA48fRwC2GOgQ1b+t61Tjv3J5yhkCRKy1O
         /SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=g9Rn3/vC04rfHgmkUGr3oHRdYcvjNjrD2DNniqhQgC4=;
        b=G6O5jch2wKrrQMJTY2q7F9z1tfP2MepaxMI5tNiMmZX/GAd/II6mgdWmbBy5fv/z3a
         VpX9D31tgheFRENepa4QG422+cAyp78oT89jukmqMtIvTpLuxvLj3AvCVXiC6tAwXN1C
         BtPY9TZqDMPiS4G4ig5XAJQnlZDRjZOkm3o/ydYWhYlyjAu9bHewcP3Kt7z8Yy1KQf01
         qVyS8m3fL4Guv9OU8wOgo9SBRbNpxR6dayC/WQdGSHHlzGczlMz8g6posLmacBPTD4oe
         02t6U8JUc0JXE2UR7BTGEpcEkr1bml+SBzjzVUg2q7zuCQKqI6oGDnPYeqqMhxsS/V83
         ZvjQ==
X-Gm-Message-State: ACgBeo3gBlSuyJZFe1+j7nNVFvnEgNqPnAeQ+HA+fjEPGNB1S+DZC0pL
        BJzYwfniSL4jAgsh5eACJVw=
X-Google-Smtp-Source: AA6agR7+vvDCoZbVvvDTigjm3V0SOqIGJ2PbC32NBB/DW/ou3LzwtUpEfRs3k60Kt3LO19helz1Qpg==
X-Received: by 2002:a63:c149:0:b0:42b:96de:1e31 with SMTP id p9-20020a63c149000000b0042b96de1e31mr26343498pgi.369.1662145159098;
        Fri, 02 Sep 2022 11:59:19 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f64100b001728d7c831asm1961361plg.142.2022.09.02.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:59:18 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Julia Ramer <gitprplr@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] embargoed releases: also describe the git-security list
 and the process
References: <pull.1345.git.1662071998812.gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 11:59:18 -0700
In-Reply-To: <pull.1345.git.1662071998812.gitgitgadget@gmail.com> (Julia Ramer
        via GitGitGadget's message of "Thu, 01 Sep 2022 22:39:58 +0000")
Message-ID: <xmqqwnal7gc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/howto/coordinate-embargoed-releases.txt b/Documentation/howto/coordinate-embargoed-releases.txt
> index 601aae88e9a..43400fd6025 100644
> --- a/Documentation/howto/coordinate-embargoed-releases.txt
> +++ b/Documentation/howto/coordinate-embargoed-releases.txt
> @@ -1,6 +1,121 @@
>  Content-type: text/asciidoc
> -Abstract: When a critical vulnerability is discovered and fixed, we follow this
> - script to coordinate a public release.
> +Abstract: When a vulnerability is reported, we follow these guidelines to
> + assess the vulnerability, create and review a fix, and coordinate embargoed
> + security releases.
> +
> +The `git-security` mailing list
> +===============================

Dissapointingly, addition of these two new "=====" underlined
sections breaks the documentation build, which broke mi build
locally as well as GitHub CI [*1*]

 * https://github.com/git/git/runs/8162258928?check_suite_focus=true#step:4:658

Fix should hopefully be trivial, keep the original title line 

    How we coordinate embargoed releases
    ====================================

intact, and make these two new sections underlined with "-----",
demoting their subsections one level down accordingly.

But I care more about procedural gap because this should have been
something the submitter could have noticed at their end.  I somehow
trusted that GitGitGadget would run preflight CI tests before
accepting /submit, but if not, perhaps we should?

Thanks.
