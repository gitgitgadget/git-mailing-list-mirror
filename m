Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D33591F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 10:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeJKRpp (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 13:45:45 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:51750 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbeJKRpp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 13:45:45 -0400
Received: by mail-it1-f173.google.com with SMTP id 74-v6so12636091itw.1
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 03:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dana-is.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=+8+6jgXS0bwm3em7tmC2t33LaTnJW9/y+vn+pmtf2zg=;
        b=Lk4k4IdtPQ1QxQiRzDpT7JOxya0WXIkFmsABw+d0gZW6jmbYbwokNOTWusAOHiHb1S
         fsTDu5qKGxJUqXwSatWe4/TNXlZOaaMOUR1I5GkmlBHRvecKJUEy1TMKkm4E0ALaacWP
         1USgpRtkciuHWg7jmKbCItD975AJWoOJgvJHm21QW5zdFoXQNeD6iplb/p1gb6W69qZN
         70bxhBNUbIHGtYuEBSiZhAlKntIJE15FRJF22cfdurX1JLL148BoesZZR8W/9jLDYeF0
         AgaGMCFPcYGQLvISGEB3nxD/qyS3am8xQA+WbKfW3ewboDvx5WIbxTJZ5HKIfh4xzyA/
         2CcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=+8+6jgXS0bwm3em7tmC2t33LaTnJW9/y+vn+pmtf2zg=;
        b=oZjTWhv8ckEZvIyywoYb4AkLc+W5nDHxboQ/7PXND0KPix3/KflfptWWRr2X923iE7
         mcp/Btd3oXOi4k8rY/1iglJppxQP6e9pXgouE97YtwL1OWsKkOc2zBoUlN4WhVK8M5Gb
         AIe4vm+MQv++fmYiEkYKIo+OefPFb2ecxvnMt+g/rO+y5XWKKaj6sm/Wu7KeOXSBGL5d
         fmIkupsVBMp2pYMbQAeIwTRzQ7klThLSJv0eq7lDomUwl7/O2nnZYctyQq9PQtwJ2fUZ
         y0qgWwuodnTSm5uC0R815m/UmS/Et1q+c8Hqrh1bXcidkB0cgfZjizoWGZo03oMQtDIu
         IPSQ==
X-Gm-Message-State: ABuFfogUhlAwYd0tZcyePIVkAZXVA6D8lCb/n9TspzPRsdYEmtF1oTjQ
        +Xu8qtCQb/lCJeTSfKPPxB8U56EUYUQ=
X-Google-Smtp-Source: ACcGV62hWAFALnwa+tD+OUmiKwMm618FhxZOk7jFuhkC3AYSX5l79yJbtUlkJz1Zp7XwRuIVDj3Kcg==
X-Received: by 2002:a24:83c1:: with SMTP id d184-v6mr874029ite.16.1539253147181;
        Thu, 11 Oct 2018 03:19:07 -0700 (PDT)
Received: from heartswap.lan.dana.is (173-21-17-19.client.mchsi.com. [173.21.17.19])
        by smtp.gmail.com with ESMTPSA id o18-v6sm7882216ioa.83.2018.10.11.03.19.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 03:19:06 -0700 (PDT)
From:   dana <dana@dana.is>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: [BUG] gitignore documentation inconsistent with actual behaviour
Message-Id: <C16A9F17-0375-42F9-90A9-A92C9F3D8BBA@dana.is>
Date:   Thu, 11 Oct 2018 05:19:06 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm a contributor to ripgrep, which is a grep-like tool that supports =
using
gitignore files to control which files are searched in a repo (or any =
other
directory tree). ripgrep's support for the patterns in these files is =
based on
git's official documentation, as seen here:

  https://git-scm.com/docs/gitignore

One of the most common reports on the ripgrep bug tracker is that it =
does not
allow patterns like the following real-world examples, where a ** is =
used along
with other text within the same path component:

  **/**$$*.java
  **.orig
  **local.properties
  !**.sha1

The reason it doesn't allow them is that the gitignore documentation =
explicitly
states that they're invalid:

  A leading "**" followed by a slash means match in all directories...

  A trailing "/**" matches everything inside...

  A slash followed by two consecutive asterisks then a slash matches =
zero or
  more directories...

  Other consecutive asterisks are considered invalid.

git itself happily accepts these patterns, however, apparently treating =
the **
like a single * without fnmatch(3)'s FNM_PATHNAME flag set (in other =
words, it
matches / as a regular character, thus crossing directory boundaries).

ripgrep's developer is loathe to reverse-engineer this undocumented =
behaviour,
and so the reports keep coming, both for ripgrep itself and for =
down-stream
consumers of it and its ignore crate (including most notably Microsoft's =
VS Code
editor).

My request: Assuming that git's actual handling of these patterns is =
intended,
would it be possible to make it 'official' and explicitly add it to the
documentation?

References (the first one is the main bug):

https://github.com/BurntSushi/ripgrep/issues/373
https://github.com/BurntSushi/ripgrep/issues/507
https://github.com/BurntSushi/ripgrep/issues/859
https://github.com/BurntSushi/ripgrep/issues/945
https://github.com/BurntSushi/ripgrep/issues/1080
https://github.com/BurntSushi/ripgrep/issues/1082
https://github.com/Microsoft/vscode/issues/24050

dana

