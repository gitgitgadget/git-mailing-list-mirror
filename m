Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8401C6FA82
	for <git@archiver.kernel.org>; Sat, 10 Sep 2022 09:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIJJq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Sep 2022 05:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIJJq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Sep 2022 05:46:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670652DC8
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 02:46:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q63so3750128pga.9
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date;
        bh=qbpaXEnv8Q9OaGBXpVuC5y6KvqSXMOrxytWNuotNdMc=;
        b=d+3kJe3LOOuJSK3xlD3Hz9u+RejNRWAEcPD/dKBib6z7zYdP9V5B1n678h8+4iuaOO
         jNfN6li1xm282h+bFNRZ7IE6/SqWDnSHMMW0JzNN3Jc20MbgM4FS3jK6EfQCNW9ZOTbP
         uGYdkprcJ6NUd7y1CjMN36ogrPMuyf/S8ej45uD4s/1WHoKOR67Xj6EZc7NbNRf97o2s
         OGiZeIn4U1Ky+fu368/9Q1nLvAf0YO2PWtz0jnzx5eJ0ILIu+1ToP9DUZEZCLivLvpXJ
         DI9/GlyviMcpXNtqbj9PtNZuPGwKAWIFunJvHU/KscEVBGggQzjcu5m6hdjrjvGox7U5
         8GTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:date:message-id:subject:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qbpaXEnv8Q9OaGBXpVuC5y6KvqSXMOrxytWNuotNdMc=;
        b=fSg3Pi+E6LmiDBDnZMuHcvN3D/B152GHYP34vtGej53gOQiwz9bDO8WdzF/vJNzmgJ
         ZSZWdp0txrTrJ2bd71mV4AVdfcOiyhGwGaKMKKsDD7ih3dthYNQRgRS5h01FbvvMAjCW
         O/Luivm4BHlMJFAkWa5yThiuZ5lsBKrMleUf3+/BDv4eRmxFp793w03bzbQqlez3evNd
         rs0Ae8fGlFm/jiC4+4WFlGrFA+O7Mvv2licvQiYr3qZnVE15XhChTQKSFmRV7ac/vGiY
         8nYcGl0e5K55QfUOlR4WOT3WVmM4eXUT3LaImbZFV4IbQYGCO+0AZO9ygGVZOhar0mTB
         YXYg==
X-Gm-Message-State: ACgBeo22fiZGvvie/rZ/LDYm7vlWwmogVWW07yLWVDsW1h4dL9S7EObt
        VjYaj5u7QNGYWmc0fdrVNJbpxJjddWhk
X-Google-Smtp-Source: AA6agR5qGP53hbWffEYBPyeGsTbXEehNo9Gdc38Jpv4TlvRdJKBQu7O+NPSZgvENoUHWq9Qn22Zk9A==
X-Received: by 2002:a63:6683:0:b0:42b:34a5:e66f with SMTP id a125-20020a636683000000b0042b34a5e66fmr15994827pgc.117.1662803213334;
        Sat, 10 Sep 2022 02:46:53 -0700 (PDT)
Received: from smtpclient.apple ([46.248.130.164])
        by smtp.gmail.com with ESMTPSA id h17-20020a056a00001100b0052d4b0d0c74sm1271765pfk.70.2022.09.10.02.46.52
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2022 02:46:52 -0700 (PDT)
From:   Pharaoh <apollosoftware64@gmail.com>
Content-Type: multipart/mixed;
        boundary="Apple-Mail=_452D1B0F-5957-4F6F-9486-4E1BAF10335D"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Git Subtree Bug Report
Message-Id: <EC3D3822-0CA7-405A-9F88-22312414C856@gmail.com>
Date:   Sat, 10 Sep 2022 05:46:50 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_452D1B0F-5957-4F6F-9486-4E1BAF10335D
Content-Disposition: attachment;
	filename=git-bugreport-2022-09-10-0538.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="git-bugreport-2022-09-10-0538.txt"
Content-Transfer-Encoding: quoted-printable

hank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Used git subtree command normally, re-add subtree into parent =
repository.
Then I tried to push changes I commited inside subtree directory and it =
keeps saying git push using:  velocity dev/3.0.0
cache for 74edac9642c1318ff038da0ae5dc1d543d42624e already exists!

Issue can be found and report here as well: =
https://stackoverflow.com/questions/68761778/git-subtree-cache-exists
What did you expect to happen? (Expected behavior)
For subtree to push changes to remote
What happened instead? (Actual behavior)
Cache exist!
What's different between what you expected and what actually happened?
It used to work on older version and now it currently does not on this =
one.
Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.37.3
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Wed Aug 10 14:28:23 =
PDT 2022; root:xnu-8020.141.5~2/RELEASE_ARM64_T6000 arm64
compiler info: clang: 13.1.6 (clang-1316.0.21.2.5)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

--Apple-Mail=_452D1B0F-5957-4F6F-9486-4E1BAF10335D--
