Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18C70201A0
	for <e@80x24.org>; Fri, 12 May 2017 01:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932220AbdELBSW (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 21:18:22 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34658 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932207AbdELBSW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 21:18:22 -0400
Received: by mail-pf0-f181.google.com with SMTP id e64so21951439pfd.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 18:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5PU9w4PtTGPW++RBbF0HUxbQ9G0Oul7JIK5Mqu3U3fQ=;
        b=ebZbF5KUecdspvlVpFFrCD3icYxDXUcHJDnJHpRhSAd+JIWURJqGIeDmIPvo3ICGzp
         GQ5HVcB8iYOyiiYManU+uJe2GKNDMyfgXmm64YgHEqq5olMZKEXeuyuJtdCP3pspYT6i
         9fyzDbOmLebfxYRpLa/wkREOSsyxVmIJEWcK1HhjEFrwOAT8KEZ/Ik8ntc6MtJKjYQeX
         adcrqCppJK/nnR9ah0GfmApdDePwPQCvutCmJZgFnQUlay0u3fRE1ay3UOJlonZ2Dhtf
         wfU9zQpNTA2kITZ86+RFw3j24aXufWDs2xEGPD0tTml5fqHONHo9UQGVGwy6f6Z7C6tq
         8PSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5PU9w4PtTGPW++RBbF0HUxbQ9G0Oul7JIK5Mqu3U3fQ=;
        b=HDRwarXSKAsCvSGLD/b4Be9iWBIkCy8TAVyfUjHwPNMHuxHa5yNO29iBFVaNlo82mP
         vDbQ68/eHW8HbKhfgQ3lMC/Jggyl8qcKfnmw/gPTwP//zHQf+Vc7MSL4RssJafAwbolI
         W3fYryuSMpsRhmYmB7lvu07+LHqKFRbNfoRKIBwGHzlaDmJRS1tXP2wAHSI7AQ/uFkou
         JtyQKXHx+mtLfdkQQlE3I9eC3CGGqLDZEE30o+DqEAGgix8GFgJcxEE5rHCzFHUtQnuE
         RsgDKegi2h8n4R/brS3eju2W8bnb7ZkGNRAn4Oa1ee+BWUwEFFWFfDwCG23B4eHhzeVU
         ibqw==
X-Gm-Message-State: AODbwcCJ6q8Ax/h+iQs/RZpwtW54XEsuqxnm8/tUg8o1WTuf5flZO3oR
        iRubmDq3XxeNhs8szV8=
X-Received: by 10.99.36.199 with SMTP id k190mr1503737pgk.83.1494551900487;
        Thu, 11 May 2017 18:18:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id d83sm2453173pfe.40.2017.05.11.18.18.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 18:18:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] compat/regex: fix compilation on Windows
References: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
Date:   Fri, 12 May 2017 10:18:19 +0900
In-Reply-To: <6a6782863a74432094a1d7fba7f2477991ef2d16.1494510612.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 11 May 2017 15:50:21 +0200
        (CEST)")
Message-ID: <xmqqd1be98kk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The real issue here is that GNU awk's regex implementation assumes a bit
> too much about the relative sizes of pointers and long integers. What they
> really want is to use intptr_t.

Good.  I got annoyed enough to do the same myself before opening my
mailbox.  One thing that is curious about your version is that it
still has "#include <stdint.h>" behind HAVE_STDINT_H; when I tried
to compile an equivalent of your change last night, the compilation
failed because intptr_t wasn't available without exposing <stdint.h>

Where is Windows build getting its intptr_t, I wonder.
