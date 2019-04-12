Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C7720248
	for <e@80x24.org>; Fri, 12 Apr 2019 07:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfDLHFU (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 03:05:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37876 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfDLHFT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 03:05:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so9622398wmf.2
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BsgzNDtfEUG59//hw1vMaWw/5APSTrwtiHBXlPh1xyQ=;
        b=dBWhbmikvknsD9MLmdqZq1bFjava2LdJ2Pr1G9uvdcP/g278iutPqfJF0R5kHCiFJR
         XsD3NVVPPJQlcbJPEB7p3L2iIqchs6o0D+IT04LbWI2OGkXKoDLDx+fgIWePpiqEznLR
         dZn7sK4A8h4YoEi5ZxkqhLOhoTAqEY2iknb/S7bdRii+USJbR4mew9bfo5aOxwidmVPt
         eGNsefBW6wzeK6oLcrnPb9mhz44tcl1iT5ZOZjBWR9Tc0BCqKwoA23ZyexRK2PBE9nxm
         UKwg0fklHi1+4BQLywdy0VRFVKtVDHz80I2RAQ7eXwjS0YWezfUvm+b73TMV8TncwyFE
         xQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BsgzNDtfEUG59//hw1vMaWw/5APSTrwtiHBXlPh1xyQ=;
        b=tkSViPuvg+npw4guLS+cPT0JVLUVSuaFlArPYmJmKwJVMTRUxm5HHy9gHexWIpFJCQ
         3iO18KSrqr/Fq8cR8eHcJmcwm3EOepwXVeoGwH3U9kGaczZc2je/nJiRHIOzH7Cq/s7y
         cIjYz42m0vpnMYJG2TqqSOzuSp1we05+gGtB6dfcIN9spg3eCbtucYRMrnsdUhyGSbCm
         rwG29e2BEiigw4n/Evf7yWJ5xfbpOnLmInH+Aoh7jJDrkSh/XQqFXUw5M9FfxdZz5l/4
         mxTiYGwpdautiw4kZ+zuSoBp3AKDZQHpMIMW5hCTsgFLDlufd0hwWVimnZx5e8owi8zv
         Djqg==
X-Gm-Message-State: APjAAAXGsZhVHk2cavr9U7EBbUmCyZr1mQ2lRh72s1Wutf8SJPAEYRR6
        cmSoEdNiTAZw6jf03G6KuLyGHWgqEmw=
X-Google-Smtp-Source: APXvYqx0QNX785M+4k2P/i4Uus5PT4oxaY7Xx1/qWriDikZ+fY+9Xnlv85jGcNQplWKifvsHqz0DDg==
X-Received: by 2002:a7b:ca49:: with SMTP id m9mr9371975wml.61.1555052717844;
        Fri, 12 Apr 2019 00:05:17 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y197sm10533668wmd.34.2019.04.12.00.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 00:05:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     ron <ronazek@protonmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git merge should report an actual syntax error when a semicolon is used instead of space for specifying multiple branches
References: <fQ_n3UAoz-yQ8MMCgPLhVDqkMCqpXQ2Dk34IZgksKIQ1B3Sig_T70nPI5mI0z9z2A5ZLdk5ooUYnAJelV-7eMNrnCr4V73Rz87pP1arR8WA=@protonmail.com>
Date:   Fri, 12 Apr 2019 16:05:16 +0900
In-Reply-To: <fQ_n3UAoz-yQ8MMCgPLhVDqkMCqpXQ2Dk34IZgksKIQ1B3Sig_T70nPI5mI0z9z2A5ZLdk5ooUYnAJelV-7eMNrnCr4V73Rz87pP1arR8WA=@protonmail.com>
        (ron's message of "Thu, 11 Apr 2019 01:12:51 +0000")
Message-ID: <xmqqsgunya8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ron <ronazek@protonmail.com> writes:

> ... And it may not be uncommon since it comes from the fact that
> git merge normally follows git fetch where semicolon is supported
> as per normal.

I do not know what "git fetch" uses semicolon for here.  Care to
elaborate?
