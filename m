Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FE8520248
	for <e@80x24.org>; Tue,  2 Apr 2019 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfDBA6E (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 20:58:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52363 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDBA6E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 20:58:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id a184so1341035wma.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 17:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5r90QCAHv5nmf8hYTnOLPAKU8Drz9XL2yStTETObLF0=;
        b=FQsnmLqm/JeNJ91/Gk01DPFDW5yOrGjvzce+teWnngrUKM+0fci2Igxjhse0ejirKM
         xd3zxuCyZNNW82zpB34g3PBHMPBqAal2kpwvX2R3zxbkTudhJIDxH25xSNluid76ba4a
         c12+npfPWGS7YewdJbYLRQHHlYXe4AbbyS0JXI0PIKQNPukHrzeuvW7K/Magl++78niZ
         Ov8gs40lIHKqs5MgWx4mWsW0wnuvSG91ZRagLD0FD2BJdM3ahCYOusQxX60t9qgy8fZx
         5v7xEWlnr+hvHlpLoqX7AvHtqdIN6S40DdIPWcmRwTd1om8ina1xE6jRFq4L9bsP028c
         K4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5r90QCAHv5nmf8hYTnOLPAKU8Drz9XL2yStTETObLF0=;
        b=ApDducvKgGDPwvqvmnVRj3c0SIbXXXcPXLb6WBChqnCwbjj5Zo4g/71CtUgXJRh6LN
         MVSewIZ3AXNoAoNBWk3xfGoVMjX8rPSGsDhH894lBTZKVnTD3TFSBsCqMA11eF2RX95s
         VYeMTGTkPO5BlNZcocZ5SGmns3a0b57zWhzY1PDXsO/lZ+kzFOq7yOtovUAWKKD0QXAI
         NWpgAp0MG5dVLrPDw6R6iqhksYWy1v/cIzmWEwYU0an3mhwoN1mnpvIwmMUA3wVKDRc4
         o8a4WdJTXrPms+VpK3ro19jALH6KhbWEKPSP3Uok6xBl+b79qiHVM57RuCMXCJ3LoFcS
         Jsew==
X-Gm-Message-State: APjAAAVpQP/S09WnMM+hA449q/OER977Y8ipzN3GggbXX9CiGVWaYR/5
        yxTCr6z5++hKpcLMvLEMbCU=
X-Google-Smtp-Source: APXvYqzCSSNDmdPz7AAIeN6T0bevKyAJwKPkXWOIfnkPzUOqB/CiUa7vm3NDQ/+jM2Dk0cRUpl2zXg==
X-Received: by 2002:a1c:be0e:: with SMTP id o14mr1376566wmf.11.1554166682283;
        Mon, 01 Apr 2019 17:58:02 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y125sm19590839wmc.39.2019.04.01.17.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 17:58:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/8] Do not use abbreviated options in tests
References: <pull.167.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Apr 2019 09:58:01 +0900
In-Reply-To: <pull.167.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Mon, 25 Mar 2019 11:14:17 -0700 (PDT)")
Message-ID: <xmqqy34tte92.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> We do not want to have tests that need to be changed by completely unrelated
> patch series, just because abbreviations that used to be unique are being
> made non-unique by said patch series.

Makes sense.

If we wanted to make sure that options in abbreviated form work
correctly, we should do so in dedicated parseopt-specific tests (and
we do in t0040, I think), not in tests for random other commands
that happens to feed options to them.

Will queue.
