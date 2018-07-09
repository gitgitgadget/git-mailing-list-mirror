Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2C71F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGIUGB (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:06:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50680 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGIUGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:06:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so22374161wmc.0
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SfZx6yf0lzzlrKTNfaKS3++UuW2LJmbKeVqg/4XzTqg=;
        b=njAvKdE+LPZwXERa2zH6b+L66CDcaIWscdrNrPRtOrr8xWn2+nJ/iv17BRLeLnWyG0
         lrgBEPINkYYBJmRCjqH2FQyeIY9jW4JIIGb10taUOvCavc5HwW/B0tz/qQb6JVUg5s3p
         IXaisndX/mo+tDodlrlBmxqZj5XpyfL0ZJ9+gNEx3jK7tb7wBBu+A1G2q5bWvQ1GzCod
         ZsYVCxojVgGmUpFq6J35enZWWd2Qz2FX7TdSsow+aH9Wm7Z9UsLDWOv2tQGatUuBynMJ
         HmRV456PN3SMFNcHGqfBYqNvJ0HaowAdczGXKk6JaC19SbDpesO5BPMKENkDRTql7LwJ
         r6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SfZx6yf0lzzlrKTNfaKS3++UuW2LJmbKeVqg/4XzTqg=;
        b=fR0l/pYxyaCQu6/YZEudrj8H2Y38QI4LniSdC1ffI2eWYRTIdv0KdmXFvW0UMFnyr4
         uPnoyfzJH1j4rNR4TkZI1gHZatzm88ek1KO5FsPpvrVxJ/gUNKwwLpiRl7fBqUGHRRH7
         lL57kG7LmOJTdn9Cfl0fztLiluiSicRJc2pmImUk06aazeOdg9qje88Uo/l26XF1rwgG
         AA4ffgogDu1aniy1VfY6HuIlLk3mROt4l+yN7c80FkH81dnLzUaNeiOGNecK84S1jDJ6
         T9DGH1LGM6s/IuEJ7SHdGS2ipguYqrVnQNA6EaqHFa7i8aIy9cDpXyPYKIpOpDrvmab0
         gocw==
X-Gm-Message-State: APt69E3wDQJ3HiPi/9v5pKmjyHFvsjipGBa+4ogH/XCLL9FPauEQx10g
        SO8RQEOGVQo05WYdtyUEGF8=
X-Google-Smtp-Source: AAOMgpffaIIUvUr8OCzV/LzRrA7+f4lhQiXhjpo5MAhc0Soax6zxkFKj8yGNc/qZIsMjKW7PeM2xhQ==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr12415091wme.141.1531166758535;
        Mon, 09 Jul 2018 13:05:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w135-v6sm45119793wme.7.2018.07.09.13.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 13:05:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Harding <dharding@living180.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
References: <20180708184110.14792-1-dharding@living180.net>
        <20180708184110.14792-3-dharding@living180.net>
        <20180708210200.GA4573@genre.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.1807090944400.75@tvgsbejvaqbjf.bet>
        <13a876a2-7fbc-de05-2e82-814c782e8a80@living180.net>
Date:   Mon, 09 Jul 2018 13:05:57 -0700
In-Reply-To: <13a876a2-7fbc-de05-2e82-814c782e8a80@living180.net> (Daniel
        Harding's message of "Mon, 9 Jul 2018 21:22:22 +0300")
Message-ID: <xmqqpnzwcgyi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Harding <dharding@living180.net> writes:

> One question about my original patch - there I had replaced a "grep
> -v" call with a "git stripspace" call in the 'generate correct todo
> list' test.  Is relying on "git stripspace" in a test acceptable, or
> should external text manipulation tools like grep, sed etc. be
> preferred?

I think trusting stripspace is OK here.  Even though this test is
not about stripspace (i.e. trying to catch breakage in stripspace),
if we broke it, we'll notice it as a side effect of running this
test ;-).
