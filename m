Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94AF81F453
	for <e@80x24.org>; Wed, 13 Feb 2019 04:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbfBME5O (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 23:57:14 -0500
Received: from mail-it1-f170.google.com ([209.85.166.170]:35785 "EHLO
        mail-it1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfBME5O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 23:57:14 -0500
Received: by mail-it1-f170.google.com with SMTP id v72so2767313itc.0
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 20:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ysar9F5fLNN2yVEBzzoKHeFrFjuiS/RVne5Yaud6jrw=;
        b=oLFtlAi/l4YxSnkVVQyVu5k6Q349kY5sl7UtdDvMQwT3ky62jQxRA0aPj8w1cP17xu
         RI6pNr7QaqfkDtoJ0GIH0Obh14MFnVcqikEq7DvpQ4d3uwZSocZd04b0su3jdztw3WgP
         L7+DwmIr1V3eqyHNmb7e5VNVY9BMRjodbZtODlPtguTq+NRM076QNPXJuiwHbcEv0B6S
         tk+2KIOWgfhpl/BwONyweOxtojmHBXGLkHID3CymafyQ/DqyRPKjUHvC6gzMUny1fujs
         R31qUPog5V37vr8+VO4BZvLSKx4vVfNPQKETVdFN0JfsxPyh/5zsIiDGggSAojfnRnJv
         Z9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ysar9F5fLNN2yVEBzzoKHeFrFjuiS/RVne5Yaud6jrw=;
        b=WtAJwUHA5GLlo2YvzQAErE1HI2PGLmx/bHbaowEznLJ1bF0CV6g6aPc8jNTRDgMy9e
         5W90aIHaxPbDX8GNvyhocalNqCw9jnNByk4L/I6bOKHlTxD7nPe50Lasgs1Oi40DFFb9
         dalZhD6nZAfZ1dBxg6egAKq+C++enxjfQtyjXbj8er7r3ocg58P1TBJIMjKuy7wEiSuM
         TQmd/M1/OAjvuH1dF/PqncyoeQ2eKh+J6KYL7oUQVOWNIE+AApQdztjaJetcvGxIQdnL
         NMFPIcDFDZ0/DWDskxruZJ0ND41g45Soof59Xr7CqyYnE+FMUDr9pxrOhXZ3oeaKmKid
         iR0g==
X-Gm-Message-State: AHQUAuY/S33URXk1LWtzcSlRwFXy5pHvYcgZyBaVHkV6WR7/zrEcfJJm
        2oVA23a0nWpE1d4woQIQKWwrxrGimNMNpSVfmCjcaN6RwIE=
X-Google-Smtp-Source: AHgI3IZW8wJ+YVzbijYCKaBkq/izpYyuq0OAcSk7+KLEosJvK1B82JjqsbQVjyy69p6aCzgmnHFrx0LanMZhFFLBUTU=
X-Received: by 2002:a24:5e05:: with SMTP id h5mr1271785itb.103.1550033833186;
 Tue, 12 Feb 2019 20:57:13 -0800 (PST)
MIME-Version: 1.0
From:   Petri Gynther <pgynther@google.com>
Date:   Tue, 12 Feb 2019 20:57:01 -0800
Message-ID: <CAGXr9JHb1hjtMamdWt=oDg_eeBEuiDcbzAx+1XpV+HvvX1xsaA@mail.gmail.com>
Subject: Feature request on git log --oneline <revision range> -- <path>...
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git developers:

Small feature request on:
git log --oneline <revision range> -- <path>...

Could we add an option to:
1) display all commits in <revision range> unconditionally
2) use a special marker (e.g. star) for commits that touch <path>...
and list the files from <path>... that this commit modified

Sample output:
git log --oneline (--annotated?) HEAD~5..HEAD -- Makefile kernel/printk/printk.c

  aaaabbbbccc1 uninteresting commit 1
* aaaabbbbccc2 fix Makefile
    Makefile
  aaaabbbbccc3 uninteresting commit 2
* aaaabbbbccc4 fix Makefile and printk()
    Makefile
    kernel/printk/printk.c
  aaaabbbbccc5 uninteresting commit 3

In other words:
- commits that don't touch <path>... are still listed (without special markers)
- commits that touch <path>... are listed with * prefix, and the files
from <path>... that the commit modified are listed below the commit

This is very useful for kernel LTS merges, when we want to know which
LTS patches in the merge chain actually touched the files that matter
for a specific build target.

Is this an easy add-on to git log?
