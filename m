Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BC101F406
	for <e@80x24.org>; Thu, 17 May 2018 00:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751481AbeEQApe (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 20:45:34 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:35889 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbeEQApd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 20:45:33 -0400
Received: by mail-io0-f170.google.com with SMTP id d73-v6so15279iog.3
        for <git@vger.kernel.org>; Wed, 16 May 2018 17:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anmol.io; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Xp77kTbE6kBRE1rfJHJYhumlIQzuVH8mKeu/bF/p0h4=;
        b=TCrkLAc7sNCZiEtE5lpBwukxGxNFCfcoEWzYuGU0f86z6EuexLz4SleiyqOoTFORy8
         z0BA8tPhnVhyriy9FjCk3ThvCbHJ2wJxMg3+8UDwktznYJWHJZgeAsrEsaHHOZKNKJb2
         R6bNSbqukK+vOv1IRXCMf2rasPHwUXZgcXTCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Xp77kTbE6kBRE1rfJHJYhumlIQzuVH8mKeu/bF/p0h4=;
        b=JLlXCEYELv3huEo5/U/wBTX1cRskzw/JXyql6Y2HLo3G2Zdy4Iel6UQhnS5/t7muZe
         NP81ZWNGrW6ZmceGpIj/3KsbadaQ6GMPV9doJscKgxHkQG9b5n8ly78Ph895DJ/x3UwG
         qhOq2De6PcAoYkpBXpuB5t2VTOqUctgLNLZQsqLZV10Ckx3U6dO7FEU4J8DgB84sCvWE
         ByKeGe0jWyGXm/53ArE2T8vaWFERRAbZFiNQBBTd270HZnqlBw4nWer+XVNuQmItLMUf
         j5Ibjnq4U5OXg2P6mR/g3Li/SFWpWJfjX0lsJyaSv0YBuqN2Po0wpu2CtKsDX4GGKbvH
         Nf0g==
X-Gm-Message-State: ALKqPwfnPTrVlWKWenBnHdU2T0s7wZBK8D/JQN1cfVq9hJBWHZc+mx0Y
        XKdXI8ChKKcnyhKcN777gB3ETdXGsgs=
X-Google-Smtp-Source: AB8JxZqYwmHRnabXyiyoktSYyf7YoXaHVodkVZRXftyD50z9YFlNQ2wfCjrW5IJ74tHA5SV4wyu+7Q==
X-Received: by 2002:a6b:c006:: with SMTP id q6-v6mr3584693iof.61.1526517932857;
        Wed, 16 May 2018 17:45:32 -0700 (PDT)
Received: from ?IPv6:2607:fea8:4da0:8ef:e99c:ab48:8a83:1f8c? ([2607:fea8:4da0:8ef:e99c:ab48:8a83:1f8c])
        by smtp.gmail.com with ESMTPSA id e133-v6sm2050516iof.28.2018.05.16.17.45.32
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 17:45:32 -0700 (PDT)
From:   Anmol Sethi <me@anmol.io>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Add option to git to ignore binary files unless force added
Message-Id: <285692D0-1DE8-4CAF-9BCE-F1A04D5C66B5@anmol.io>
Date:   Wed, 16 May 2018 20:45:32 -0400
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think it=E2=80=99d be great to have an option to have git ignore =
binary files. My repositories are always source only, committing a =
binary is always a mistake. At the moment, I have to configure the =
.gitignore to ignore every binary file and that gets tedious. Having git =
ignore all binary files would be great.

This could be achieved via an option in .gitconfig or maybe a special =
line in .gitignore.

I just want to never accidentally commit a binary again.

--=20
Best,
Anmol

