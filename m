Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB8BD1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeH0Xbf (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 19:31:35 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53458 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0Xbf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 19:31:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id b19-v6so100508wme.3
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLUhrTVr6KD2csYpIRgZRIfXf/uW+padv33TC4s0j1s=;
        b=TOlA9gVtE1xvG6mFVg+Vbb5q7m4rjou3lbTwfhc384Wj5er0rokZvAHh9hV2G2HoNY
         TEeLIvwnMoWsVGrJBVJXjKTA8ICzsB9Fqvtx9Z06xDotzdHvwO0Kb8bXHZ/rtHBmmb3f
         9Yol5LzZ16o85uQiaRhxwc0wQ/46Nz6iqd4w2Y+3ueeEhBj6CGP0KTi3TZ6xdI2P60M0
         KpRw4sNt2q8w1vjRwD+8CH8Y39M5uxTVIVyNi7QiKPhxGYIpJx4hjTFINUP/XvvorzEq
         tGTPqwDeAUxfSlzr3rMGYxGE6Pih1lVeww6TqZsa5UkvF7RfcZ471xNUt150+g7At+rh
         w8Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nLUhrTVr6KD2csYpIRgZRIfXf/uW+padv33TC4s0j1s=;
        b=QD9EW2cNamFTTvRPP//8nKw3jHkOit+hm2q1dslY8U7lpAcEa9FmdQx/hhw2/F2mX1
         FRgnDCFL3sGsKceiIQTf0GdD4z/0q5tM+/nWNq1vttvhIoEZeO9dq3yhueX4XoXUHSrS
         /3IzE9OBrO1omvvBoQqrRweCoT8UPTOuOdFqgl4suVN9u4kUn27okM80LJleCLuhkBt/
         9eN3NMpRSKKfm5QFWe2psnq8zgViERKbnsdevlu3FnXGa2cl08ceLOchjk/1KLaR2Gk6
         bS6x9RH2BP1uOEM3PyBSGixhkESLs8RmwO3dJWg1NWnWuDiqTwW5VEc5P9cIMFcRPMcN
         Jqog==
X-Gm-Message-State: APzg51ArxsZbHgRiF7gGqvxrwr4rSOpyWH4rEIqa+iGcy+tprLOCYIvk
        3FfrDiWQ0zccV6f8s7gwLjCQAoPuBh4=
X-Google-Smtp-Source: ANB0VdaQApInVd/XvGFjTSAhUOB7NmHZZevekf0M6xfhYme9bVCVef0EArNsHHXi1q8cIsVf1PwTyw==
X-Received: by 2002:a1c:c44a:: with SMTP id u71-v6mr6405230wmf.43.1535399013437;
        Mon, 27 Aug 2018 12:43:33 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q135-v6sm121958wmd.4.2018.08.27.12.43.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 12:43:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/7] use oidset for skiplist + docs + tests + comment support
Date:   Mon, 27 Aug 2018 19:43:16 +0000
Message-Id: <20180827194323.17055-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27 2018, René Scharfe wrote:

> Am 27.08.2018 um 09:37 schrieb Ævar Arnfjörð Bjarmason:
>> 
>> On Sat, Aug 25 2018, René Scharfe wrote:
>> [...]
>> Now, I like yours much better. I'm just saying that currently the
>> patch/commit message combo is confusing about *what* it's
>> doing. I.e. let's not mix up the correction of docs that were always
>> wrong with a non-change in the user facing implementation, and some
>> internal optimization all in one patch.
>
> Now you have me confused.  Unsorted lists were always accepted, but the
> documentation asked for a sorted one anyway, probably to avoid sorting
> it with every use.  Switching the underlying data structure makes that a
> moot point -- sortedness is no longer a concern at all -- not in the
> code, and not for users.
>
> Inviting users to run the array implementation with unsorted lists is
> not incorrect, but it also doesn't help anyone.  We could clarify that
> sorted lists are preferred or recommended instead of required.  I don't
> see value in perfecting the documentation of a quirk just before
> removing it, though.

I think it's easier to clarify step-by-step with code, so here's an my
version of a v3 which implements what I was suggesting, but then of
course while doing it I found other stuff to fix, changes since your
v2:

René Scharfe (2):
  fsck: use strbuf_getline() to read skiplist file

None to the code.

I changed some docs I add in earlier patches to now describe behavior
in a past tense (and the s/sorted // change is earlier), and to change
the docs to say that sorting the list on-disk is now pointless for
optimization purposes, but did something in the past.

  fsck: use oidset for skiplist

There is now a test for the bug you were fixing in your 1/2.

Ævar Arnfjörð Bjarmason (5):
  fsck tests: setup of bogus commit object

Fixing some test redundancies while I'm at it.

  fsck tests: add a test for no skipList input

We didn't test the most basic skipList invocation, fixed while I was
at it...

  fsck: document and test sorted skipList input

Test that sorted & unsorted skipList input, and document that in the
past we said this was required, but it never was, but what (ever so
slight) optimization this gives us.

  fsck: document and test commented & empty line skipList input

We don't support comments or empty lines. Add tests for this not
working, and explicitly document that it doesn't work (I for one tried
it).

  fsck: support comments & empty lines in skipList

Ignoring comments and empty lines is very useful for a file format
that might be human-edited (I maintain one such file). Support that,
and document & test for it.

 Documentation/config.txt        | 22 ++++++++++----
 fsck.c                          | 48 ++++++++++-------------------
 fsck.h                          |  8 +++--
 t/t5504-fetch-receive-strict.sh | 53 ++++++++++++++++++++++++++++++---
 4 files changed, 86 insertions(+), 45 deletions(-)

-- 
2.19.0.rc0.228.g281dcd1b4d0

