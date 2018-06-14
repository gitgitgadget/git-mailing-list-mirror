Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDBE1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755214AbeFNRPX (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:15:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50458 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755194AbeFNRPW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:15:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id e16-v6so11809492wmd.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vIMZSqmsaVseixM/prD+Pg+nWUrTJd5X+SePyxV/Ryg=;
        b=Y0KEymo2rgXEOqPBhRWVj7jds4J0oCigyN3/fg9UfiAgKolThvbX+9KfLj42+4veoT
         mGztiEzFE1HzEGf1yL6CDQ5s0+7c7fN4p8GKL3kj8BRMG7xGVMvCXvwl08bCuib7eHWX
         vf/66OHRL26OI5UyQtv9fa7BdKa3Jn9OEorw4mCA4tv4WhcQ09oA8+PV6M6v9++6qKvz
         TKSDDzgGsYH9/y1+bIUzhrGxbbRxP/UPy3adsIE/qtuCDWzF73DVcVDQKaxHoG3stqzm
         ZeD8J9APhlgRZi39bfcE1rkDXv6YWoCvcWgZot5aBNjxzB+kb+qJUK3prwKR3XywxtfY
         Ptng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vIMZSqmsaVseixM/prD+Pg+nWUrTJd5X+SePyxV/Ryg=;
        b=gsyTBRgkfyF9xTa7uEHZkZX7E00r8xcfX4qlXo0+EWvbDZvG2loOzEaOmaM01OAso8
         oKJhohHpt2D00madDEP3fbJQGqKbBvvYkS2W89+BJOPtT+lRc6dRoEwa18HeMVLIXd64
         RjH687Vhro61hffT1hFyfMTI5toPMG7iE6Twlqnxb/V5o5anfIjrmLbCo2MRuk5LqwjD
         TI5m4Adwxwfv2eIBpwZ2WDn9XaCSH1pKw8sVjOg5CdzXAuJDQj71dc6iVDJ5VPPOJwmS
         7PhGsX8OxRXnWK/febm11yAKqZi8qTf5TDnrHl4OrNgaxre1Bh8l+cdheDLKlPH2yM9T
         kR5g==
X-Gm-Message-State: APt69E2CakboeVaWN0e/BeOYSPDh0YDJUBrjVEL9gJNi9X0Fc+eOZ20d
        zMO20+uJsZz2tCcCcwic5Qg=
X-Google-Smtp-Source: ADUXVKJKEvsKh0jzShhlaUu7yySZPeQpKVcLzRINltsK/MwrivumbyRl4wkWlcKHS20aL8G4oZHy9A==
X-Received: by 2002:a1c:9a51:: with SMTP id c78-v6mr2495158wme.118.1528996520946;
        Thu, 14 Jun 2018 10:15:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q17-v6sm6694157wrs.5.2018.06.14.10.15.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:15:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Fix occasional test failures in http tests
References: <20180614123107.11608-1-szeder.dev@gmail.com>
Date:   Thu, 14 Jun 2018 10:15:18 -0700
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 14 Jun 2018 14:31:03 +0200")
Message-ID: <xmqqvaal47dl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> 't5561-http-backend.sh' is prone to occasional failures; luckily it's
> not 'git-http-backend's fault, but the test script is a bit racy.  I
> won't go into the details here, patch 4/4's commit message discusses
> it at length.  4/4 also fixes this issue, but I'm not particularly
> happy with that fix, the note attached to that patch explains why,
> along with possible alternatives, hence the RFC.

Interesting.

> Even if we settle for a different fix, I think the first two patches
> are worthy cleanups on their own right.

Yeah, the first two are unquestionally good.  

The sed expression of the second one could use sq around (instead of
dq) to lose hard-to-read backslash quoting from there, but it
probably is OK to keep the second one a pure "refactoring" patch,
and leave it to a separate "further cleanup" patch to make such a
change.

> SZEDER Gábor (4):
>   t5541: avoid empty line when truncating access log
>   t/lib-httpd: add the strip_access_log() helper function
>   t/lib-httpd: add minor and patch version to $HTTPD_VERSION
>   t/lib-httpd: sort log based on timestamp to avoid occasional failure
>
>  t/lib-httpd.sh              | 24 ++++++++++++++++++++++--
>  t/lib-httpd/apache.conf     |  5 +++++
>  t/t5541-http-push-smart.sh  | 17 +++--------------
>  t/t5551-http-fetch-smart.sh |  7 +------
>  t/t5561-http-backend.sh     |  7 +------
>  5 files changed, 32 insertions(+), 28 deletions(-)
