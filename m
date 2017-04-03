Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160CE2096C
	for <e@80x24.org>; Mon,  3 Apr 2017 04:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750974AbdDCEMw (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 00:12:52 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33396 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbdDCEMv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 00:12:51 -0400
Received: by mail-oi0-f53.google.com with SMTP id b187so112605360oif.0
        for <git@vger.kernel.org>; Sun, 02 Apr 2017 21:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=EgM6Mf4KMPmJwS71gDlHA2aQq2+gCnNzXtU/na9Ywos=;
        b=pbBsx09kKMS3BB3l92LrN2RQdxMGUMFJhZN/nu633QVY51aFkg79+QtMBmtfXhYG3h
         eeqXXZd18cOAbCep9eUV3PaTv3YsFOLHhPl+Dk6i7cR8G3tw1T46km136Az+ZBej5YHO
         E1cVclAtFMqvIg+9dM+jgobiwmSPWDpO/B3IMBey7HZpHJhwIAzBeNPjiXVj42v0uslS
         GlfJ0nlWu1RADpz45MaRQg7wOgnsS2bYeBQzdUYEFNhgvQ2G/oXMVW8okOU/fuNqOX89
         NgOPq+HrSve7ckYg2XXU5MqshBFyZQ7W4TCp81naeOELOtNH3+H6CKUdeTpdxlhpJZXJ
         5aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=EgM6Mf4KMPmJwS71gDlHA2aQq2+gCnNzXtU/na9Ywos=;
        b=Lecvl73hfts7iMtTajk9PubDuJ79aI6/IB8flcAhSlkulAt++fsboDFo/6O3icJBNV
         vZgrR8XEn1RDL/NlH9Xaf5V/B0IlRCLWZFotw1pTjwZpEyTFJ2iPGisTt6dLMP0ra02R
         cfq9+7RNtRw311YFh/k69FqahWsiP52YNOcMdglkwnI3Ho4HKjrzbrffyRdbn5B4GxrC
         7/sQ4ASrE0ZUlyHoHqYwwaS6wN4ulK2hOdgsbinTFqGSNA7uTM5qXhW2fHA9Lj0YCAcr
         AvBe6k0o+mV4judchauidKWY0rPEpz67/zagMPBYqcbSgwa6fEw/HVS1RhJCHh08evnz
         B2tQ==
X-Gm-Message-State: AFeK/H1Y5VJq1MgslTMxs7o/TA4nqWq/N9mMPYyBAMJIFBC6Ur700w138mCB/Sj5nY4ag9YpyT/Km+nlVbA9cQ==
X-Received: by 10.157.8.197 with SMTP id 63mr7660297otf.123.1491192770727;
 Sun, 02 Apr 2017 21:12:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.31.131 with HTTP; Sun, 2 Apr 2017 21:12:50 -0700 (PDT)
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Mon, 3 Apr 2017 00:12:50 -0400
Message-ID: <CAH8yC8kPWuB0zYp7g_PO7x-Kn5RpzKpvbGvyV+2mt_buaJb3zQ@mail.gmail.com>
Subject: chmod: changing permissions of `blib/arch/auto/Git': Operation not permitted
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is kind of unusual. I'm seeing it under Debian 7 on a ci20 mipsel
dev-board when building/installing Git 2.12.2:

...
317 translated messages.
    GEN gitk-wish
307 translated messages.
    SUBDIR perl
chmod: changing permissions of `blib/lib': Operation not permitted
chmod: changing permissions of `blib/arch': Operation not
permittedmake[2]: *** [blib/lib/.exists] Error 1
make[2]: *** Waiting for unfinished jobs....

make[2]: *** [blib/arch/.exists] Error 1
chmod: changing permissions of `blib/arch/auto/Git': Operation not permitted
make[2]: *** [blib/arch/auto/Git/.exists] Error 1
chmod: changing permissions of `blib/lib/auto/Git': Operation not permitted
make[2]: *** [blib/lib/auto/Git/.exists] Error 1
make[1]: *** [all] Error 2
make: *** [all] Error 2
    SUBDIR git-gui
    SUBDIR gitk-git
...


When I check permissions:

$ ls -Al git-2.12.2/perl/blib/bin/
total 0
-rw-r--r-- 1 root root 0 Apr  3 05:06 .exists

It appears one of the Git processes is creating the directory
structure git-2.12.2/perl/... It also appears to be doing it under
sudo/root since I build under my account.

Jeff
