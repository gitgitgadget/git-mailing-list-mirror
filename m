Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C34A51F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937241AbeE3IEV (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:04:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42738 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936032AbeE3IEP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:04:15 -0400
Received: by mail-io0-f196.google.com with SMTP id a10-v6so20600546ioc.9
        for <git@vger.kernel.org>; Wed, 30 May 2018 01:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Szi5WKZymqWS/qVtX2A5NdNlu01/GaCZT8mgPyRLtbs=;
        b=dm5oZpuBHjQPQOq3u1ypuhueSAIspNo2qW6gmzUj2fjF8ENnulf7gh2fYdAINP9CY/
         VfEMLU0OuXMEzKjsdY4tmVgnbcFJH7ksLUF4Rs8H/IGBlAf8ZpmMIXPgO4yeJErVsqSw
         QYEDawAIuyVjWav5BBEytQbQSiTj5c/BT8XHD5Q0G+loWw72wzK80YFxIgmk3B7wnQPT
         bCiZTshVO2H9TV4zleC8QXpXlhpY/xbE6OXM7LI6Ok8YiDIqcedgl22rUQ3z+HmniI9z
         ADxtQ21sPYdahxy5fsIXW5nnX8qvCR1uN26Ag6P7qpH7nJEPhkaid2Nao+OCQ52Hhcu0
         fozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Szi5WKZymqWS/qVtX2A5NdNlu01/GaCZT8mgPyRLtbs=;
        b=re/3BfdHEtgvHdoHfHF2/KjVBcfQdX6LhddCvCeJuLEyLaVDGyzV7nYlAHhoLoDBJv
         X55OLzL/wmdgHqG/OlixL+KyP2iXhQaRlOR2TNzSMIFY5isiLFBXCGnZGwydEekFMtEW
         RpZI7ffhZiZSvcYV2781p0drwCbMxq5KCDi62El9HwMYVow7znFa/j+Q+YTz+cZbisx8
         m+THlAxORN6L8lFq5oRXwmnUvsIwlAAl/igUzimknggST9pEW1ZZyq2DA/OtzJsP4REM
         VuRgHogpfKRLTRsX0PA8Lnu1t30s/wr158uJa1GuNh3w5rDXAmz626yGUdA6SiR1uLMR
         hJLg==
X-Gm-Message-State: ALKqPwcztAgxEsGwfQRc0NSX1l6nhYMako3IE4sO2tDIpakowiyTHKxw
        hIisTw4tPm7AWTKmHzqmYSpnVg==
X-Google-Smtp-Source: ADUXVKLoZ4vlntrbBnFd1MYUqzPUBQbCkBIRnu3DfB3u7Tx589Q7OzCd5BRnetqOp1r59fPl3VfDmA==
X-Received: by 2002:a6b:8cc7:: with SMTP id o190-v6mr1296032iod.148.1527667452119;
        Wed, 30 May 2018 01:04:12 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id t9-v6sm17447561ioa.82.2018.05.30.01.04.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 30 May 2018 01:04:11 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
Date:   Wed, 30 May 2018 04:03:20 -0400
Message-Id: <20180530080325.37520-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.17.1.1235.ge295dfb56e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
git-branch-diff[1] which computes differences between two versions of a
patch series. Such a diff can be a useful aid for reviewers when
inserted into a cover letter. However, doing so requires manual
generation (invoking git-branch-diff) and copy/pasting the result into
the cover letter.

This series fully automates the process by adding a --range-diff option
to git-format-patch. It is RFC for a couple reasons:

* The final name for the 'tbdiff' replacement has not yet been nailed
  down. The name git-branch-diff is moribund[2]; Dscho favors merging
  the functionality into git-branch as a new --diff option[3]; others
  prefer a standalone command named git-range-diff or
  git-series-diff[4] or similar.

* I have some ideas for future enhancements and want to be careful not
  to lock in a UI which doesn't mesh well with them (though I think the
  current UI turned out reasonably well). First, I foresee a
  complementary --interdiff option for inserting an interdiff-style diff
  for cases when that style is easier to read or simply more
  appropriate. Second, although the current patch series only supports
  --range-diff for the cover letter, some people insert interdiff- or
  tbdiff-style diffs (indented) into the commentary section of
  standalone patches. Although this often makes for a noisy mess, it is
  periodically useful.

This series is built atop js/branch-diff in 'pu'.

[1]: https://public-inbox.org/git/cover.1525448066.git.johannes.schindelin@gmx.de/
[2]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1805061401260.77@tvgsbejvaqbjf.bet/
[3]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet/
[4]: https://public-inbox.org/git/xmqqin7gzbkb.fsf@gitster-ct.c.googlers.com/

Eric Sunshine (5):
  format-patch: allow additional generated content in
    make_cover_letter()
  format-patch: add --range-diff option to embed diff in cover letter
  format-patch: extend --range-diff to accept revision range
  format-patch: teach --range-diff to respect -v/--reroll-count
  format-patch: add --creation-weight tweak for --range-diff

 Documentation/git-format-patch.txt |  18 +++++
 builtin/log.c                      | 119 ++++++++++++++++++++++++-----
 t/t7910-branch-diff.sh             |  16 ++++
 3 files changed, 132 insertions(+), 21 deletions(-)

-- 
2.17.1.1235.ge295dfb56e

