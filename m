Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6CE1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 12:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfJUMX3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 08:23:29 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:39159 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 08:23:29 -0400
Received: by mail-oi1-f175.google.com with SMTP id w144so10841116oia.6
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubjVEnolkCaa1dbxHy9H3Ej2x5fvCojYAXxFzCtMrFg=;
        b=efArYJadMYmgsd5P5ReFH/jx4Z7JfM2OtZHdtflrVRKP4qFLWxkHt2SPSaKKrFalGw
         XPbsC1P2I8W7NtKFifpEocEFzUdTYA56o0Fcrhf9xTi4FFDrQtf97S4Wh2hziPI1Tidg
         8uFFZE5UFhus6AyHMtyMu+C7ucbOCe7MnIuW9qwDnMKc4QpHXUoCIOdvRLIkKqgcO081
         CKFCSQqVmLdbhI79Y/gTWXFbfi6RPkW267Ztu6Jt4LpqWw22YPbtJ1G+kFPyZWDi0p95
         7z/RruS/cohffcYvcAWcne6WRAf276vOQTNDNgYOStcXz2MRhrNiTfvyduPcqd0r6Moj
         E2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubjVEnolkCaa1dbxHy9H3Ej2x5fvCojYAXxFzCtMrFg=;
        b=lhszpyFPeu20Xi2iI2VTTi8a1Jr8GVELHCc1ZMDjVCKDr2CGex53D0ul+9r1+9aFER
         2hLJOM8PJ4Vg6/k0Sgu2dLve2/Ii90gfdQDexAXO/F4gD37Ev7s2XVe5CS3WWSj6gnFA
         4GBX6mYr427IcxmN7c54P6ZLjSCWTvCbsazVih9R+9rsQevGNR/oNH3P2pbq7W8Qe0Am
         WJTTk3DV7m9rC4tRVzczyoDfofPqhaeyKabiU6QiOopEM9SA1vFz2CgPFXZ+jzqRQ04M
         6lexVebht7JcskD0OsK7oA0ogpA2zBFAMsafN0RloiHfYe/3LOFfHxX9QnhcZRXy9dxU
         CdmA==
X-Gm-Message-State: APjAAAW4zKGc/tXsPLhRgvdNUdxn17IlLndWWNhBMl9yQNeq9lzWlfR4
        vvkQUIc8f9MDS0ZRDvJX0pdTIkIe
X-Google-Smtp-Source: APXvYqwXShLfnMEXnGcgTEDV8bYt2FKUxEIhD5gr7BISHIRw5ppqIT6enGpWBDXtCTI5EHAQMJfg9Q==
X-Received: by 2002:aca:6701:: with SMTP id z1mr14775517oix.64.1571660608448;
        Mon, 21 Oct 2019 05:23:28 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.25])
        by smtp.gmail.com with ESMTPSA id s1sm4028995otd.49.2019.10.21.05.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 05:23:27 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
X-Google-Original-From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
To:     Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.24.0 round #1
Date:   Mon, 21 Oct 2019 20:23:16 +0800
Message-Id: <20191021122316.56219-1-zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.23.0.3.g72fac68ab1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <worldhello.net@gmail.com>

Hi,

Git v2.24.0-rc0 has been released, and it's time to start new round of git l10n.
This time there are 35 updated messages need to be translated since last update:

    l10n: git.pot: v2.24.0 round 1 (35 new, 16 removed)
    
    Generate po/git.pot from v2.24.0-rc0 for git v2.24.0 l10n round 1.
    
    Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>

You can get it from the usual place:

    https://github.com/git-l10n/git-po/

As how to update your XX.po and help to translate Git, please see
"Updating a XX.po file" and other sections in "po/README" file.

--
Jiang Xin
