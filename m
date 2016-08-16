Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7612022C
	for <e@80x24.org>; Tue, 16 Aug 2016 16:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbcHPQzk (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:55:40 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38208 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbcHPQzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:55:39 -0400
Received: by mail-it0-f45.google.com with SMTP id n128so37897518ith.1
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 09:55:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=TiIoA9ukbvwr/W7mjaSRXO2wIS4MZbnIhsJ+XXJpxQ0=;
        b=CaOdBpZ30B5hjOU717G5npjKP8qG3KxR7ljk50DYe7lc6QcjzSv7FKgbvjYxvfgl/E
         yT7vDqZqN8LPWUJ5t/6pLeB94fuCFKcGbHoewAdJGb2RP1ucvvuyAMzQ/uIMKY+XCPHp
         E1wPaqdQQby8LbalGBGVHSVSm+AS+KMPbqKcf4UuysGQ0WWpKsfm/XiqxEIkWJx2KiqA
         EvduGnb313lx5K/Zo99SSiLE2yF1j8oCMZF3qlaO9rZFmoqlbXwZ1Cxf5iwVrq4ybNt2
         9R/JyGsTQjEg/5Xj64587D3wEERjFwSEKglgzhEvbpi6O6bo5T9DeMpl98VDKgdfRLuh
         SXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TiIoA9ukbvwr/W7mjaSRXO2wIS4MZbnIhsJ+XXJpxQ0=;
        b=SulDL2JP92NO6MLahbuSyb/AGD+/f1OUcFlPts7MZbStitYN5l++LwOsAcKEIY1Ain
         7ettAw6WZSGSECVsKEU+yfZd4rJE0kktcwKEEfRElRqdnwPxQKRjFI09S5ws+ZxrDLZn
         Iwj6NGgH0HsWtR+Tdc3OVcwDsJypJNM54nbNl/kGuvw7DPArRcYiWt35xb8Souk07zgq
         9OqIeimKaDXyqcgup9mHI6R1L4ltsr866JYcQEPdYmPNEiA5u3qKfmb5GDt1sF1P9i2e
         8/VDjbthPjvrkzQbmLMQpXmjIxKPFMeQYxgvQmPAMBzRrLquMkCcBlfN6gKBjo0FkGMj
         V9gA==
X-Gm-Message-State: AEkoouvThHo/B9azO/zAaX8+aVGNkrwxEkBRZaJS9XZoHYrxMZfuFJz83hiRBEtpHB+tu1LsLa0afq46OxlsBXk9
X-Received: by 10.36.92.206 with SMTP id q197mr23339787itb.46.1471366538777;
 Tue, 16 Aug 2016 09:55:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 16 Aug 2016 09:55:38 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 16 Aug 2016 09:55:38 -0700
Message-ID: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
Subject: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
To:	meta@public-inbox.org, "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> BTW in light of the discussion we are having elsewhere I just need to
> point out that it was *dramatically* faster for me to edit run-command.c,
> find "hooks/" and adjust the code manually than it would have been to save
> the diff and apply it.
>
> That's because I do not have advanced tooling on top of email (and I also
> could not handle mutt, so I am stuck with a not-really-scriptable email
> client).
>
> Just sayin'.

I ran into the same problem, just for a larger patch, so I figured I can
download that from the public inbox and git-am it locally.
So I maneuvered to the cover letter of the patch series I am interested in[1]
and downloaded the series as a mbox.gz[2].

However git-am choked on the cover-letter with:
> Patch is empty. Was it split wrong?
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".

The way forward from here was to `git am --skip` the first mail (the
cover letter)
and the rest got applied cleanly.

So as a discussion starter:
* Should git am skip a patch 00/XX automatically ?
  It is obviously a cover letter, which may be text only or
  has an intra diff to a prior version. Neither is what we want for now.
  Although there is this other discussion of storing the cover letter,
  so maybe an empty patch that is numbered 0 is fine to skip for now?
  Once the discussion settles whether we want to store it in
  branch.<name>.description or as an empty commit at the end or at the beginning

* Should the public-inbox offer another link to patches 1-n, without
  the cover letter? Or should it add instructions:

        If this is a patch series you can apply it locally as:
        curl <link> >tmpXXX
        git am tmpXXX && git am --skip && git am --continue

I tend to favor the first option of Git learning how to process the
cover letter more easily.

Thanks,
Stefan


[1] https://public-inbox.org/git/20160815230702.30817-1-jacob.e.keller@intel.com/
[2] https://public-inbox.org/git/20160815230702.30817-1-jacob.e.keller@intel.com/t.mbox.gz
as found in
> Thread overview: 4+ messages in thread (expand / mbox.gz / Atom feed / [top])
> 2016-08-15 23:06 Jacob Keller [this message]
> 2016-08-15 23:07 ` [PATCH v6 1/3] diff.c: remove output_prefix_length field Jacob Keller
> 2016-08-15 23:07 ` [PATCH v6 2/3] graph: add support for --line-prefix on all graph-aware output Jacob Keller
> 2016-08-15 23:07 ` [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display submodule diff Jacob Keller
