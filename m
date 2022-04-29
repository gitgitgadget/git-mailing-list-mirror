Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3990BC433F5
	for <git@archiver.kernel.org>; Fri, 29 Apr 2022 18:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380108AbiD2Snr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Apr 2022 14:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379081AbiD2Snp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Apr 2022 14:43:45 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C312604
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 11:40:26 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf4b91212so94239777b3.8
        for <git@vger.kernel.org>; Fri, 29 Apr 2022 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wsdW+F/3TYU4Z54QdBea1J8iI7q+Y1fZQ2feRNJQkus=;
        b=BWLOJ71OnOWLjyPn4bdOnU3zG5Wtx3usXM+gEUntUL9kzbVjVJp1HDaLlArMJaIY5g
         l9LIp52t9d6cvENjydFOkA1ZY9zzr2voiO2mT4yw741VjZ6VIWr3MOPHmckpmQi7wRxo
         FLcIaGDNuHPXRwryqQNhgQpoR+uSneCwUtpiMevBm1XHUb0ya53yZl4AhPoQwu2/Lm5y
         wG/ANt+kzb5fwY3t0rxQKh3GYRWz7P3nwh4g7XKcwwZS/rW9nFOO9wh8nFfz9RoaTvL9
         kKR6qw15DSBPYwaz/CHyLSJM2UKfPcHEsMvznmwnigBjKJCgWrFOkX1bVNBVnUllQKRF
         0gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wsdW+F/3TYU4Z54QdBea1J8iI7q+Y1fZQ2feRNJQkus=;
        b=bpK3lCde7DkbOR6XFRo8hV5PapruMpPGxbbOunZe2TXhDqxdzE5bpsRgIBVTgV3ZwA
         0hoa4r/Hh1+hb8NMccTgqPPiO2bXF1xi0Za2KOaETxIacAg6qS4U4aUJ44YTsh2r5Uqj
         FubeZRz5S9f7raxGWPaD4h0hE6yohOPNAma8BEEKTW4avJ3jBnrBrFiLuejhndIFUaHZ
         ywJXtLg/AmM96arY41r/jS8gw2OlOFr23MxrAXvaRzE2xo9OR7SJx72WBHzUgqHCx44e
         Ye1bF4DNjfoVUZr97wSPKSnDNuBlQlji96DnuyGxM0ZC7nlyc4YQAfVuDYeUBrI6/f2C
         9C4g==
X-Gm-Message-State: AOAM531yF9Vc5RGv8+2k/qzjJAFWU1e9XkxSBVdpAtpx9LTG4PskE9oz
        em55WkqDUG8OHpb4xjE7EQpQo/hA8JE9Hgi6p/IKm/QHaEE=
X-Google-Smtp-Source: ABdhPJzMk0JnAURj3dm+u90mvF6lZ8t3YLU2qV3LoRn+OpOFd2Aw642ictdqTibP0FY+2Yt85WaCINqXmihaJxTdJDQ=
X-Received: by 2002:a0d:d9c1:0:b0:2f4:e463:5dcd with SMTP id
 b184-20020a0dd9c1000000b002f4e4635dcdmr673151ywe.108.1651257625429; Fri, 29
 Apr 2022 11:40:25 -0700 (PDT)
MIME-Version: 1.0
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Fri, 29 Apr 2022 14:40:14 -0400
Message-ID: <CAKepmajpJ0Nhr0SPNicg6djhH36f+dT_SHrb7pOEK7J0eXYuFA@mail.gmail.com>
Subject: git not compiling under MSYS2
To:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I just installed MSYS2, cloned the git repo from
https://github.com/git/git and then tried to build from the "MSYS2
MinGW Clang x64" prompt.  Of course this was a clean MSYS2 install, so
I had to first install for myself vim, git to download the repo and
for the build: make and gcc.  However, after running the make command,
I'm still getting errors:

------------->8------------->8------------->8------------->8------------->8=
------------->8------------->8-------------
$ make
make: curl-config: No such file or directory
    CC fuzz-commit-graph.o
In file included from git-compat-util.h:219,
                 from commit-graph.h:4,
                 from fuzz-commit-graph.c:1:
compat/win32/dirent.h:13:21: error: =E2=80=98MAX_PATH=E2=80=99 undeclared h=
ere (not in
a function); did you mean =E2=80=98O_PATH=E2=80=99?
   13 |         char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8
conversion) */
      |                     ^~~~~~~~
      |                     O_PATH
In file included from commit-graph.h:4,
                 from fuzz-commit-graph.c:1:
git-compat-util.h:329: warning: "basename" redefined
  329 | #define basename gitbasename
      |
In file included from git-compat-util.h:209,
                 from commit-graph.h:4,
                 from fuzz-commit-graph.c:1:
/usr/include/string.h:171: note: this is the location of the previous defin=
ition
  171 | # define basename basename
      |
In file included from commit-graph.h:4,
                 from fuzz-commit-graph.c:1:
git-compat-util.h:336:10: fatal error: iconv.h: No such file or directory
  336 | #include <iconv.h>
      |          ^~~~~~~~~
compilation terminated.
make: *** [Makefile:2569: fuzz-commit-graph.o] Error 1
-------------8<-------------8<-------------8<-------------8<-------------8<=
-------------8<-------------8<-------------

Anyone have any idea why it's not building?

Thanks,


A
