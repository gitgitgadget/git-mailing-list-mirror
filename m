Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E460620193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965927AbcHDUzv (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:55:51 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33896 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965916AbcHDUzt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:55:49 -0400
Received: by mail-yw0-f194.google.com with SMTP id j12so20768909ywb.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 13:55:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gvhLxS9yjXGRtrsBHv3+QHto6697ORh4CTeD+qKD2qA=;
        b=CljZv5yGV1bl+Q2cpMpHWnNou2iMJH3Yxk3uHkS+i4LFUKySVc99ikPlZ6R+ph6BV8
         /DIhul5Tr5M9EDYyLq4NQ/YskN5bMU4AWig+H3/ZbZIX1x5ySl7QZJySxzXj/a3TJ4q2
         vZqEaguEFaJ9Z7qxWcfo3pQYoUsG36RjLNfrLtZ1iTurDqYNy+zdG8Z6u1sR6MQU16xM
         r8YDvzOoz27zEH/9IXpmlwaCSJgfZczdZ73Ieeevz/3IRkS8LK0UtMmFfVXmWNfeLCCm
         5RVty77eZHy4LCuL/8mM76pxZJ8ODT9iCWMmT9drt8Av+i8j66EmuFVbzDM1XbanYXML
         /IdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gvhLxS9yjXGRtrsBHv3+QHto6697ORh4CTeD+qKD2qA=;
        b=CekYAvH6BFBCOv6LXDGADSS0ssGytXf4+UigDGFyBR0rBdgH79lHWb/ZXFy1NmZCTl
         xJDObiff1htB8ax4oDVlMeU6d5iRPjVrWbXDzCo31U7cNp8uBbxTBTdHoFWWQvgS1Xwy
         OQHw7SKg1D31lgEX7rGCtafF0v8e+7RnCTMzxI9UyjpQRsr8m8Ql1ympKBYMu5fJddwO
         o+Kgb8mU9JEw9KGZpS4a9l8azwXOvAb7bIAa19RIYxNBwvKhyDxdTh10q9T3RbRgrD+7
         tcbkTKT35nGdH2MImA0MyQYkR6UHU+zGe6/Q8JAST9TOG7H+ZcouZaUxmiB/3LTHqUvy
         5tGQ==
X-Gm-Message-State: AEkooutTNgYTtKzIxfw1VyIA8gse1M7xX//RWl786jYfJmJ096foTxEQ1zNfe2UCa6IxZoHJzVZUpOSaYRm4eQ==
X-Received: by 10.129.76.79 with SMTP id z76mr57308653ywa.33.1470344148102;
 Thu, 04 Aug 2016 13:55:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Thu, 4 Aug 2016 13:55:47 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Fri, 5 Aug 2016 02:25:47 +0530
Message-ID: <CAFZEwPO9yJT4hB_ottDu7Cft-a2OLvXRpXYOVODwNxMjO_h-0g@mail.gmail.com>
Subject: [GSOC Update] Week 113
To:	Git List <git@vger.kernel.org>
Cc:	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

================= SUMMARY ===================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


================ INTRODUCTION  ===================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


=================== Updates ======================
Things which were done in this week:

 * I have converted bisect_start() but there is a bug which I am still working
   on which conflicts with the `--term-bad` and `--term-good` of
   `--bisect-terms` subcommand. A RFC has been sent to the list[2]. Junio
   provided some reviews on it. A resend can be expected soonish.

================== NEXT STEPS ====================
Things which would be done in the coming week:

 * Resend all patches according to Junio's review.

 * bisect_next() has become a top priority because it would then help
   converting bisect_auto_next() and then it can be called by other important
   functions like bisect_start().

 * Following that I will convert bisect_auto_start()

 * Then bisect_replay().

============ My Patches (GSoC project only) ==========

 * My current work is sent out to the mailing list here[2] which contains
   the whole conversion. The latter 2 patches still need a lot of
   development.

[1]: https://github.com/pranitbauva1997/git
[2]: http://www.spinics.net/lists/git/msg282332.html

Regards,
Pranit Bauva
