Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2ECC433EF
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 20:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7C460FDA
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 20:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344603AbhJQU6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 16:58:19 -0400
Received: from smtpout2.vodafonemail.de ([145.253.239.133]:60010 "EHLO
        smtpout2.vodafonemail.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbhJQU6S (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 16:58:18 -0400
Received: from mailbackend01 (balancer6.mediabeam.com [10.110.254.6])
        by smtpout2.vodafonemail.de (Postfix) with ESMTP id 1BEB461756
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 22:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vodafonemail.de;
        s=vfde-smtpout-mb-15sep; t=1634504167;
        bh=Hxn8d3HsJj4xoLCzWQPXNJu4Kpan4e1x2LisRKEnfn4=;
        h=From:To:Date:Subject;
        b=q9iqFI6OnHOie7mzd1vFF81+EYwIMsn9aoN2QPfGKLqxZKRB1FJuoVs64I4WzTYZl
         Tc98wpZj3LZEjI/TtcllgOe21zqyTlRjNBYG7tsCE77wdCJ7pNLMZ6wvTvX/LCk5Fr
         ExlxVyC/iwwA+F2ptbiWvup1V1InLbyXsh0q9A2A=
From:   some-java-user-99206970363698485155@vodafonemail.de
To:     git@vger.kernel.org
Message-ID: <a5a41a53a50448a0829dc3bb8681f5bc@vodafonemail.de>
Date:   Sun, 17 Oct 2021 22:56:05 +0200
X-Priority: 3
Subject: Suggestion: Allow .gitattributes to specify executable mode
MIME-Version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

some build systems have script files with certain specific names which =
are always intended to be executable=2E
For example Gradle has a `gradlew` file, and Maven has a (currently uno=
fficial) `mvnw` file=2E

For Windows users these script files often cause problems when checked =
in with Git and used by a CI (continuous
integration) system running Linux=2E The CI build usually fails because=
 the script files do not have the executable
flag set (Windows does not have this concept)=2E

Would it be possible to extend the `=2Egitattributes` file to allow spe=
cifying that files should automatically get
the executable flag when added to the index? For example Gradle's `grad=
le init` command already creates a
`=2Egitattributes` file; it could then add such a default entry to ease=
 development for Windows users to make sure
they add the `gradlew` script file with the correct file mode=2E

Assuming the flag is called `exec`, Gradle could then create the follow=
ing `=2Egitattributes` entry:
```
gradlew    text exec
```

It might also help with questions such as https://stackoverflow=2Ecom/q=
/14267441=2E

What do you think?

My C knowledge is rather limited, and I am not familiar with the Git so=
urce, so unfortunately I cannot submit a
patch for this=2E

Kind regards


