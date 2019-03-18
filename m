Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E725220248
	for <e@80x24.org>; Mon, 18 Mar 2019 05:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfCRFXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 01:23:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52009 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfCRFXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 01:23:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id n19so11619241wmi.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UkU5drQ2sFR30cHb/I0aVpQdVeZXoN5eEZ1kEHup/Sk=;
        b=sCwi32xwj2LAaSYyGponaA2CE2olJcGS9EL/xUHVExGpd/6QFg8Pyds269AapB9O1i
         Q1s1cKHEWkSwmQV0hiVm3Om09txQL8gEjL4M/fSkE+Jnd9NP+8pDonilZZP+M+XOWqo3
         X27RVi1syr6D4CEpuR7nO651cjFjnriSGALesKMrLkVzJgB0D2LNpLofFf6gqlFvM7W1
         gIRfgbcc3vJQe5stMqJoiXfs29j86QSskqx8Msx+VpO6KD/yTTzZJyBXeAcWxacglaKw
         v2neupb60jv114qKLBBwAkjB+Isp6XtlXlRQmvCPVXj1ZnjyRFOQyBNb34qNUsNA0nTQ
         6alQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UkU5drQ2sFR30cHb/I0aVpQdVeZXoN5eEZ1kEHup/Sk=;
        b=F2XPePNus888ajsO0d0dmBwQG/j7WotPQkY+boF7bsZeoV2RlK3zgWk5iGAWryG5lE
         q2v3NVUnQHn4pFhIw1xuF1FWwxMaKfnemdFgrj3YZbf5TTztrLUxwgn+U0l+Tmk7kxr2
         DifRmPAMAy14sGlPbJIAtkDRjyqbX6wNpsJnVRPnIbLDg8oAK0ZRHmWiWg+zpCw548lm
         kYHYyzT68JOtzKfjqKAhqEz+WBB4WHizvb8/MG0ueAgyunAVhHYuEW+JYXawxptJk8iv
         S7w3JFOj4u66mEi3OdEiOXLF11cpll+UGXHK3vxp/g8y/dgLyC9mQKGwvxZkqliNsQyN
         advA==
X-Gm-Message-State: APjAAAV6Fa0fqSERl/R0Qbv6f7KWPXonKbfCSSRtGWE7ghuJebn1br3K
        I7L9MlLiMIXeBmTtpzx5JzM=
X-Google-Smtp-Source: APXvYqx7BGihCv0TggDoddusdJz6I4ZL0gcI8ZvGQAM4uDBlzOg6mKt+VPvJltK8HLhTSapUSAt4yQ==
X-Received: by 2002:a7b:cc18:: with SMTP id f24mr10310324wmh.42.1552886591615;
        Sun, 17 Mar 2019 22:23:11 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id q2sm20666782wrd.46.2019.03.17.22.23.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 22:23:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH/RFC] Use a higher range-diff --creation-factor for format-patch
References: <87y35g9l18.fsf@evledraar.gmail.com>
        <CAPig+cRMiEcXVRYrgp+B3tcDreh41-a5_k0zABe+HNce0G=Cyw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 14:23:09 +0900
In-Reply-To: <CAPig+cRMiEcXVRYrgp+B3tcDreh41-a5_k0zABe+HNce0G=Cyw@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 15 Mar 2019 15:00:56 -0400")
Message-ID: <xmqqzhps4uyq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> So, I'm fairly negative on this change. However, that doesn't mean I
> would oppose tweaking the value shared between the two programs (and
> also the default used by GitGitGadget, if it specifies it manually),
> though I defer to Dscho in that regard.

I do not think of a good reason why the command should behave
differently only when run from inside format-patch, and if we were
changing anything, perhaps raising it a bit for all may make sense.
I have yet to see range-diff getting confused and matching wrong
patches but often seee it being too conservative to match two
iterations of the same patch after a moderate amount of update.

I find myself passing "--creation-factor 99" or some absurdly
looking value when accepting a rerolled series.  The most recent was
the updated 'clean-up merge message with scissors' from Denton
[*1*].


[Footnote]

*1* <6716d28a5187c44c1d90f5ce840c44441f62352c.1552275703.git.liu.denton@gmail.com>
and <08426189b5a29b376581eb0172e52222ab22387a.1552817044.git.liu.denton@gmail.com>
do not line up without a high creation factor.
