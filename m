Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6D5F1F42D
	for <e@80x24.org>; Mon, 28 May 2018 20:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934055AbeE1Usx (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 16:48:53 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:45856 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932451AbeE1Usw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 16:48:52 -0400
Received: by mail-ua0-f182.google.com with SMTP id j5-v6so8595010uak.12
        for <git@vger.kernel.org>; Mon, 28 May 2018 13:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3ImcHHGgaHzsbZ6DgYQ6tRMwYQycy+R34Pn8TtqbeNw=;
        b=hUbTwVpFO7zF0SsM7eFSwwozC9/ZcNSEMPlClOrmkEoInwrgAs8lC5KKDnK3rrX0y/
         fGTlflTEhBOkGDsBjOvDYIJ6mNeA/s04smzN0jIrc+aBqKupjqaGSga0d35EyOEun1oj
         qR+zZ5N72OqiyzBp2vxTvSBFE4K4Twpz9gYbj6XG8BdnAbAZWba+ivLHOLmAX7Cas2+7
         uexof3gzd35QodbwbIQtliPmRiRmwXWHbK1UxXjntIrG604bB5PvYQBDoizfU2HekAic
         zGxwp97QN2ume1EsCNyU+hC5PbK4oARa7uvHowYT4iPLlNhYQEQ3VhLrBvIRcBFSDExG
         JZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3ImcHHGgaHzsbZ6DgYQ6tRMwYQycy+R34Pn8TtqbeNw=;
        b=rgKevnA9EFzWqZWPqKRcPzqElhNNn1k8YH7xuly/fLc7ExEdfLKWZdofetGz2awiPX
         jp9vvvd1EQhorPuj176Ds8zG5+B5jDnPmtQditJ1vSpsJy9fm2sC9n72rUIXrGhpw9nP
         BgT6DfLbk5EgHLv4ME9DY9Oj9MuwidWgTOh6gn15/dxfmcO+KcXTcRnbLVfD9r+ELFSa
         UyxVDkPGlDcyES+LxUZbIsG7caar2OlNGYQQzIPwRVKVWfUFcgxlmOi/8tCNgCDyGA3F
         TMgXc+zW5bumZq8+ECOzIeT9ivXaFHFlGcdmu/yFafRKn8dfbM3QiCcvAcuSmifRDPOg
         JsbQ==
X-Gm-Message-State: ALKqPwdzz8xtXKQheXT1UlppopFAGoc6WEpdt0o9cmzQt8NkP+8YoE/b
        sZASlKqVbar3qTQxNk3oczixE3xP5ds6v4JnNiAYcg==
X-Google-Smtp-Source: AB8JxZqo4/oKNXVvdj5HepB6IQx3AOgZG9RGZwvRQg51s/Xh/O7DdQyeJ1NMWfJVcow67W+Tu/w10OubFJpjSm9+KcU=
X-Received: by 2002:ab0:a1a:: with SMTP id q26-v6mr9538264uah.23.1527540530866;
 Mon, 28 May 2018 13:48:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 28 May 2018 13:48:50
 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 May 2018 13:48:50 -0700
Message-ID: <CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com>
Subject: RFC: Merge-related plans
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

I have some merge-related plans (and work in progress) that I'd like
to get some feedback on in order to find what order would be best to
address things in, if there are special steps I should take while
approaching some of the bigger items, and even if folks disagree with
any of the plans.


Currently, I would like to:

A) Fix cases where directory rename detection does not work with
   rebase/am due to how they call merge-recursive.

   Notes: Could just wait for D & E to land before fixing.
   Alternatively, email RFC to list now explaining issues and how the
   fix has performance implications; poll for opinions on whether to
   fix before or after D.

B) Implement a remerge-diff ability (compare a merge commit to what an
   "automatic merge" would look like)[1].

   Notes: Possibly for cherry-picks and reverts too.  Depends on C &
   E.

C) Modify/extend how path-based and mode-based conflicts are
   communicated to the user.

   Notes: Particularly important as a mechanism for handling
   challenges[2] with implementing the remerge-diff ability.  Need to
   send RFC to list with ideas to get feedback.

D) Improve merge performance.

   Notes: Includes 4-5 specific optimizations[5], some of which I
   expect to be somewhat invasive and thus may make more sense to just
   make part of the new merge strategy implemented in E.  Biggest
   optimization depends on F.

E) Write a new merge strategy meant to replace merge-recursive.

   Notes: Suggested by Junio[3][4].  Depends on F & G.

F) Make file collision conflict types more consistent.

   Notes: Specifically, make rename/rename(2to1) & rename/add
   conflicts behave more like add/add[6][7].  Depends on part of G.
   Would prefer H to be accepted first.

G) Improve merge-related portion of testsuite.

   Notes: Intended to help test new merge strategy with more
   confidence.  Will include approximately a dozen edge and corner
   cases where merge-recursive currently falls short.  Started at [8];
   see also [9].

H) Miscellaneous code cleanups irritating me while working on other
   changes[10].


My current plan was to work roughly in reverse, from H to A.  Some questions:

  * Does any of this look objectionable?
  * Should I post RFC questions on A and C earlier?
  * Should I split D and G?  (Current plan was to keep D together, but
    split G into five short slightly inter-dependent topics)
  * E is kind of big.  Are there any specific things folks would like to see
    with how that is handled?


Thanks,
Elijah


[1] https://bugs.chromium.org/p/git/issues/detail?id=12 [remerge-diff]
[2] https://public-inbox.org/git/CABPp-BEsTOZ-tCvG1y5a0qPB8xJLLa0obyTU===mBgXC1jXgFA@mail.gmail.com/
    [remerge-diff challenges]
[3] https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/
    [Ideal world merge strategy]
[4] https://public-inbox.org/git/xmqqk1ydkbx0.fsf@gitster.mtv.corp.google.com/
    [New strategy]
[5] Some of which are included in
    https://public-inbox.org/git/20171120221944.15431-1-newren@gmail.com/
    [perf improvements]
[6] https://public-inbox.org/git/CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com/
    [discussion of add/add conflict resolution]
[7] https://public-inbox.org/git/20180305171125.22331-1-newren@gmail.com/
    [file collision consistency RFC series]
[8] https://public-inbox.org/git/20180524070439.6367-1-newren@gmail.com/
    [testcase cleanup]
[9] https://public-inbox.org/git/CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com/
    [weird corner cases]
[10] https://public-inbox.org/git/20180522004327.13085-1-newren@gmail.com/
     [code cleanups]
