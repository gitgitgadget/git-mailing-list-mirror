Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 464171F97E
	for <e@80x24.org>; Thu, 23 Aug 2018 09:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbeHWMnH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 08:43:07 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:45594 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbeHWMnG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 08:43:06 -0400
Received: by mail-yw1-f47.google.com with SMTP id p206-v6so1693940ywg.12
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 02:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QX8LUIgFPaIax3wJsgRh7+2mAZ0WQOD/qLd2XB1oe5E=;
        b=vRhPu9E1p5g4T648LtdEjCKURiFfQxMlOmVRV444243EFGr6BM3kqwAEOi3dY4R0Xd
         kpzqlgiU7WRHNbjixrMNo2Vg0EIbICemDTPbSb7xeph38/Z312dUuauS7+5kn4OGAzCA
         Zm7OJZyA9I5n5gYdn7dlUmSmKFwIxiOq998+k61D7yzWceKJATmadEt0ChrVuPhv5BwE
         1YpocgMKVJiWrKu0BnPe8aZOSoNU5Bq9HnI7Wzw+Rfb9WQwspgcxc7TDj7Q9atKb/v2J
         aLnoRlamf3OzhLA7pY3QPU+acUE/SL9qv6Dsn6yiy48cTQ4dMn98UU7VhhX5sOuAFmzG
         Bhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QX8LUIgFPaIax3wJsgRh7+2mAZ0WQOD/qLd2XB1oe5E=;
        b=NuZhYYi+Sic/EP3tuzpxn3T5y/PghU2aQOD11d7eXxiUkV8/YagMptbPjuhObUREqR
         xQwtE94R5DzbbN3VC1hTsiLQkgUgjdXySnI4N0yZqHb2UhOHqZsPjPSBeE9M98RFsOHV
         5ZlGRNAXE2UkopOLDFHZF3hSU+JE8fgbtyADasZ2eSkybulC4bzg2hDZdX8lPYW3m0IC
         50mdXuU9KRLzwHHxMe7VctSj81kBAYcPa1p7PY2kA9Nj2iqxqr/6KNC8yr2j/LJcGE89
         JyJV+WCkA7XD6KPc4MbJbMCQKXMQ/Xh6olhMIi86UnoYSFj8K34inF2DP1MWbx69XRdI
         w+Yg==
X-Gm-Message-State: APzg51DWyyiUpCkffSUGfzaH3qtRlrEwDMK7420WzAJgULUn15q4SfkU
        gYgWvWDfpLPk2Hwcv2GfpidymP38KAUs/R5XuX46sCaw
X-Google-Smtp-Source: ANB0VdaZEhWswL3PAkgKQJdRFLM1X00Pmgy9TFLRHyuQbPzhLGiJFe+6gL4vknfQQSiuiRRdKBbAXpkXpt7ASyqO06A=
X-Received: by 2002:a81:7d46:: with SMTP id y67-v6mr2175208ywc.457.1535015660172;
 Thu, 23 Aug 2018 02:14:20 -0700 (PDT)
MIME-Version: 1.0
From:   Timothee Cour <timothee.cour@gmail.com>
Date:   Thu, 23 Aug 2018 02:13:54 -0700
Message-ID: <CANri+EwMTwtmg9NMe6XBg=wVdsmW51MbkpfWtBQ+KT8KMjJryQ@mail.gmail.com>
Subject: how to output absolute paths in git diff?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This has all the context:
https://stackoverflow.com/questions/22698505/how-to-show-full-paths-in-git-diff

I'd like `--show-abs-path` to show absolute paths in:
git diff --show-abs-path args...

eg:
git diff --no-index `get_file1` `get_file2`
could show:
--- a/Users/timothee/temp/ripgrep/help0.txt
+++ b/help1.txt

* passing '--dst-prefix=$PWD' and '--src-prefix=$PWD' doesn't help
because path arguments could be absolute, so it'll create
$PWD/Users/timothee/temp/ripgrep/help0.txt (wrong)

* passing '--dst-prefix=.' will behave weirdly, replacing leading `/`
by `.` (seems wrong)
diff --git .Users/timothee/temp/ripgrep/help0.txt b/help1.txt

NOTE: I'm invoking the `git diff` command via a more complicated case
(with multiple arguments including git diff flags and git diff files),
so it's awkward for me to parse which arguments correspond to a file
vs a flag (ie prevents easily converting input file arguments to
absolute paths), but `git` could do it easily via a flag, eg
`--show-abs-path`
