Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7383C1F404
	for <e@80x24.org>; Mon,  1 Jan 2018 21:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeAAVv0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 16:51:26 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36680 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeAAVvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 16:51:25 -0500
Received: by mail-qk0-f195.google.com with SMTP id g123so27789124qka.3
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RzOKZpmMcZyir0u2SZqechqj7b1rPmhSC3mvDvZAYvY=;
        b=LRyKz3Fe1Qfyd72W2RsL4hzE9AB1xx6WlFQHzUQAAfpZSEIuV7zcY+iS63/NEC8PLd
         EaKIbwaaD3BRfbKPMzKp5Ltx0jQpEcn8oG7ypBKoduwkog4ouqa2+db3XoHPqYSxK8sr
         MtkFrxKl5i+bz2LBLFGggoLY38w/FrG8wwbgB6HwddqR7LPxGodF93JGO8Zz5zVrKglE
         LV7vu9VgbPgLrAGCnSj7WVq0dCc5BOryUswiDf8cdzk6PQ8TYKPR2gpZpDyt7iyc8Q7z
         +fk8HdQS9igCJeEPpjJQww7/rzYiGdyiPInoEMLn2SKYXeMpHbNF2yG0xZ6VMUOkR1uw
         cXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RzOKZpmMcZyir0u2SZqechqj7b1rPmhSC3mvDvZAYvY=;
        b=jeRkG7RVApXUg33TeJ61WwKxKTM2Er32OBPMQwvG93/5vqCA6B/L2Sf8C7UKo6B85K
         hDoDJEhkFB2EMCxbyzjG83Kr1aabHNF5Sw9Q+YE3d0f/IjPlUTjpsLU7aVMZ8//Q5kBK
         9tpTH9rgkgCp2wdzna3I/oxqH8zsbuDoySrjNgIolXUbhI9F6OfF78tfWeiZonYGes1J
         36v5yi4BptP5CXLT7SadGuGcL8tICbNwzUJQVz7G+pj+KyBWxAc4WHuNHJAxxpZ/esOA
         Ela/+MeIyP7e9jVky+4j3iuWDjuiPB/4Rwce+grG9fQCp7fE5IAx6TwsQmKZZdEnJCBX
         W3ag==
X-Gm-Message-State: AKGB3mLD1bUNbFv0Hum2odnFrqr1qnuAXl+9y2kzADF/WAwK9mhwI93a
        4mculzhdhI6NjgCio3QKIupaTTqk9MkndIVHr+MMUg==
X-Google-Smtp-Source: ACJfBoupmTS1YQXWVEJdmEvL6lm/TpOEHtmNz1eokurpufWBD+vkYmrzQSsVGTqqg3cRxGIfm6iUSv5dFokmPB0tHfU=
X-Received: by 10.55.38.81 with SMTP id y78mr39420474qkg.132.1514843484405;
 Mon, 01 Jan 2018 13:51:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Mon, 1 Jan 2018 13:51:24 -0800 (PST)
In-Reply-To: <004701d38346$7dd4be00$797e3a00$@nexbridge.com>
References: <004701d38346$7dd4be00$797e3a00$@nexbridge.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 1 Jan 2018 16:51:24 -0500
X-Google-Sender-Auth: uD-bEFkOoXJr9SG2-o9rRi3MkIc
Message-ID: <CAPig+cQ_H20ON0usig-FWj7YVF_AOR_yvBRhXJeFmRv_w7pZAw@mail.gmail.com>
Subject: Re: [Bug] NO_INTPTR_T not being honoured in compat/regex/regcomp.c
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 1, 2018 at 4:21 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> * I have defined NO_INTPTR_T = UnfortunatelyYes in config.mak.uname for my
> platform. The c99 compiler I have does not define it.
> * The code compiles except for compat/regex/regcomp.c - not sure why this is
> being used since I have also *not* defined NO_REGEX because regex is sane
> here.

Presumably you're compiling for NonStop? config.mak.uname defines
NO_REGEX for that platform (it also defines NO_INTPTR_T). git-blame
points at 6c109904bc (Port to HP NonStop, 2012-09-19).
