Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDC11F42D
	for <e@80x24.org>; Mon,  2 Apr 2018 23:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeDBXTo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 19:19:44 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:39636 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeDBXTn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 19:19:43 -0400
Received: by mail-wm0-f43.google.com with SMTP id f125so30592445wme.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KD7Bx4e+FshHwchb8PN3IgHGdwA7JgIuz6LcxS/2Yhs=;
        b=Kn+HxAglphNKxD5H7sj/W9SYAyBVGm2aAkZ4tNn5xGXyYP7jrsNhw2uWT9L8KvflFV
         Dq7p1zNkw6WE7Gcrl+2Z9jHHejgRl12P4g3/FeLsYn6MTlIYSp6khKbxKw74NyKGfAsL
         vGOqU0rCa8R6jbc6BboGzsewJCeHdpGddFPJJdRFSENowD9S8THEfARXTTj4ggiUF5HQ
         C3B/eFoDHwaZFdRJ//v8UDYMYs6baIWecMh7pRS3wF78BdcRxAG0iaYl5pc5Kay80uFa
         Rna8H7yEepiyZoG/fFigZ1Q/TH46g9+mIdz1/D36okUwizhGDqvE8SMhYa9FEOR1F2PX
         u03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KD7Bx4e+FshHwchb8PN3IgHGdwA7JgIuz6LcxS/2Yhs=;
        b=pJXfnKuRWsO/TXHOhOCOYUyIMU4vPAVCH23j/pweDe5iZVgHrNplOOh1znAMFJrpk3
         WqLY9CsbOMRlqb+BhrOEd5RKuyN8upWURF4+QQv6UzeWO46a9jPMUl5d4shahrQLUolT
         Aayv7+zElkAJNllcrCwfAEB0zy6s8ECqT8+n5atud4ALDyIZETnSuHTq7NEmqu7J9X2I
         HMou3Ic6kJ/piwi9qIIGEpWt/8zhMqnk1i4sKcTJllRCTwyBdlMgb15N9K417SwNBCj5
         h+DqFk6g49RAuF52wPY3k/YRQ4UTDdSFH3AVXWQJhyjgkSvbHHXObhRRiKakVK7VBUDg
         /xKQ==
X-Gm-Message-State: AElRT7FFS+d0a6QudlaMAy0bilgfSknQwZgylnzJN/2WkA8GNhJIgk/u
        f1UJsoBAxmfEH3ZcykC6Abs=
X-Google-Smtp-Source: AIpwx4+YD+a/iOCIpQd6lTDj4wQRWxoP3R54sevPcVdOTnC/gOAAHArLUgA54ljjV84BOaZJDlHnhQ==
X-Received: by 10.28.99.84 with SMTP id x81mr2377923wmb.8.1522711182279;
        Mon, 02 Apr 2018 16:19:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l73sm3918299wma.10.2018.04.02.16.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 16:19:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        git <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.17.0
References: <xmqq6059z9kz.fsf@gitster-ct.c.googlers.com>
        <014501d3cabc$e5f22370$b1d66a50$@nexbridge.com>
        <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com>
Date:   Mon, 02 Apr 2018 16:19:41 -0700
In-Reply-To: <CAGZ79kZOpwQFFf7CM1Msjat_bQXcuPb6eym7z28iU=8UYjfvDg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 2 Apr 2018 13:01:46 -0700")
Message-ID: <xmqqfu4dxkky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Patch at https://public-inbox.org/git/010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com/

Thanks for a pointer.  I think it was left behind and got forgotten
while waiting for a reroll and tying the loose ends.

I'll go offline for most of the rest of the week.  It would be
wonderful if Git 2.17 turns out to be flawless, but that is not a
realistic expectation.  Wishing for the second best, I'd very much
appreciate it if people worked hard to find and fix regressions and
collect materials for its first maintenance release 2.17.1 ;-)

Thanks.
