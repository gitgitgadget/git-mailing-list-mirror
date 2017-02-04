Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F8A1F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 17:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbdBDRO7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 12:14:59 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36255 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdBDRO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 12:14:59 -0500
Received: by mail-wm0-f47.google.com with SMTP id c85so74791244wmi.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=4pgMAhCcIuwvsMYyf0QZ+Ma/b5y7Mya1AD3mxmJY36g=;
        b=ic3DcV9gmV4rMjG/EhrNbxTgxf4gCnsPUmtMiVDccyyvvlmBoZ8hh0SmIGNhK3HHP9
         lTcdzkAc9/ETKhny+IXVU+qnoSO9rH14/TvpvRPrI7ovCQaRq2tYrwW6e7m8xnrPEc1c
         HMJDSFmfbftuaxj62LsQoQkUNqA+iXQCcKPWqIUPK9E50YSojY5NMp+FBIrULNi8ii2i
         c2Io5R23FIfZMRA8p7Ihj8yC62PNdIMwyoCQn1SuD1GIGBl0zNl4hgNolQflbbflIcDK
         vwdFdUc7w/MGJTa2/7orPg/7HOTKoRSCWD4Htu4W7k/P0bG2X0brI0Lj18Pk9ZYmiuj7
         JXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=4pgMAhCcIuwvsMYyf0QZ+Ma/b5y7Mya1AD3mxmJY36g=;
        b=gvj00FYXDJIU61Qdy11FE3jfI0pvPdkETEpb5/bgyu1r0i1XrGA7XqwkV09vkvXd6F
         kQI9ql6kxUz3U1LgTinnIoOTufRLhk9M1dqzBO+1vp+dcYS0ttoj8olpj4BxYsHSkmtp
         ol+RWkSOUmO331KTUAxW7ZO5NVwAKb1TqvYMD49tuuSScqUEUh2li66NVLfAVCkdvP5y
         5ZrqCTcE6vt4mLSMubk4V1MP2qAx10Ht7b5Awr24Dqz5u4mnZiJiPZkzeH9xGU29fAgY
         D123WFhNAjTd12RbGq7TLMCJKglrJz0C9johIjiqrP55+lzUf1OdnndQoym+IKSAD0gE
         0pjQ==
X-Gm-Message-State: AMke39n6olxa0c6BPOefbJrUGDRFlOKkbAtjzbqpRDbcYmoxrm5FzP81J2KYQNV3JrXmEw==
X-Received: by 10.28.27.69 with SMTP id b66mr2354615wmb.50.1486228497524;
        Sat, 04 Feb 2017 09:14:57 -0800 (PST)
Received: from ?IPv6:2a02:810d:1f00:1234:7d0c:6545:3a00:13a3? ([2a02:810d:1f00:1234:7d0c:6545:3a00:13a3])
        by smtp.googlemail.com with ESMTPSA id y65sm3483971wmb.5.2017.02.04.09.14.56
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Feb 2017 09:14:56 -0800 (PST)
From:   "matthias.serfling" <matthias.serfling@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: git-gui ignores core.hookspath
Message-Id: <AEECE1EB-FF99-48C2-8072-D89D39EA7B9A@googlemail.com>
Date:   Sat, 4 Feb 2017 18:14:56 +0100
To:     git@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I=E2=80=99m running on=20

$ git --version --build-options
git version 2.11.0.windows.3
built from commit: e11df2efb3072fe73153442589129d2eb8d9ea02
sizeof-long: 4
machine: x86_64


and trying to use core.hookspath with git-gui in my local repository in =
windows cmd shell=20
$ cmd.exe /c ver
Microsoft Windows [Version 6.1.7601]
I have defined a pre-commit hook and set the path to it using =
core.hookspath, but when commiting in git gui it is not considered.=20


Commiting directly on the cmd shell using git commit -a -m "ndkfnj" it =
works perfectly.

Thanks for any advice or bugfix=
