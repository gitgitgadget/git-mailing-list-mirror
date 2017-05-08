Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC5F1FC44
	for <e@80x24.org>; Mon,  8 May 2017 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbdEHTON (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 15:14:13 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36433 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755164AbdEHTON (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 15:14:13 -0400
Received: by mail-qk0-f173.google.com with SMTP id u75so60716844qka.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Y7UKoNFoTFSSoj+J22d8IU1gpqizsmAQdbtHTGwfhy4=;
        b=dFnHE+uuSQjCr96IGn8sXnh+HnG5O/SgXldG2X0SuDPn0nUyLgfGOOZN7ewTKhB+5Z
         0WNLrHQG+Aeb4SsDgO65g7OqjM1wlg7fV3C8WIIt+altgvUGxyKN3ODQj/FdlL8V22bP
         3wSA6aOHv8Yl/36Av9E5gFx5xfmqy1kBkImuKwXEg3OyDRac8prGvU8HamPRE4ptgaoR
         rdr7g9VAUJTBAZoV6en+T09LXkQnNcwvl4UtTQ0l7ac3sWXxFQdBbpg3Rba86dNAe53j
         at+Ta3mLZFpznUi8KhP3FXiXZ23FhkxzEbm3rpopQkdSo+hKsNSGbG1WocnZ3foM4AoD
         FqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Y7UKoNFoTFSSoj+J22d8IU1gpqizsmAQdbtHTGwfhy4=;
        b=dT0/pPyqPj7LAY9ydHRB0zuvrOEAblu569stFUT+jIZjqR6WllH/9x2ZliYcGA2Fzf
         iyAB6stkNqPgIVcr8Sw8oO/eOyzrOuI5/zY6WdcJ5MtcpG7aRAmbXRBnlFICnXJhLEur
         EMw6g2rL2vnQal/+qeekVSVjLEhF0HlfZrF/xWsuh/Fg4CDvXeVOQFyoz9IXlRTj+ZJb
         ResompmyTHwgJdYUHezpKJVwO2QqN2Yo95mrHmAdmACwFQD1WgUSsBiIXm+RORI2ZU9C
         3rUlfq9YzMBGMXnbWc17Zee2sQJ5Vh54bnuJgre0+EpwHk1AZPLTR0m50SJ+54Jtu/8F
         wRdw==
X-Gm-Message-State: AODbwcAQisDo7/tBWlJen1sGE8u28ktc40WnMOC3mqsp/8XkD06cxg5K
        e8kt8p6oOuFybRQKzHTkIyHwldqKjqglRPg=
X-Received: by 10.55.119.2 with SMTP id s2mr13222118qkc.219.1494270851842;
 Mon, 08 May 2017 12:14:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.46.19 with HTTP; Mon, 8 May 2017 12:13:51 -0700 (PDT)
From:   Luciano Moreira <lucianomx@gmail.com>
Date:   Mon, 8 May 2017 16:13:51 -0300
Message-ID: <CAPmMLfj9NYP8LBt8KrMq3-dyTeCvUCheRaUiXtrGv2CG_fGQTw@mail.gmail.com>
Subject: Commits messages numbered only until 10 when squashed
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git version: 2.11.0

THE CASE:
I have 15 commit to be squashed (the hashes are real, but the commit
messages were changed for privacy). When it's rebase interactively
squashing all the 15 commits, the numbering goes from 1 to 10 and
after it starts again from 1 to 5.

- The first line says "This is a combination of 5 commits" but the
real amount of commit is 15.
- #5 coincidentally is the last commit in the concatenated messages to
build the new commit message
- The order of the commit messages joined were: 1, 2, 3, 4, 5, 6, 7,
8, 9, 10, 1, 2, 3, 4, 5

WHAT WAS DONE ?
git rebase -i 4e4f37c3~1

pick 4e4f37c3
s 72742a70
s db800d70
s 2bcd475a
s 5e5eb85f
s 4422b1e5
s af19b0e2
s 3d64165b
s faeb2ce9
s c7dc6b38
s edeff8d9
s bd451d5b
s 851bf828
s 9cae1f95
s b79466fb


WHEN THE COMMIT MESSAGE IS EDITED: The commit hashes are real, but the
messages were changed for privacy.

# This is a combination of 5 commits.
# This is the 1st commit message:
Terminal redim Ok.

Fix #64

# This is the commit message #2:

Script improved.


# This is the commit message #3:

Added some environment variables.

# This is the commit message #4:

Improved the redim command.

# This is the commit message #5:

+Fix

# This is the commit message #6:

Fixed header and footer.

# This is the commit message #7:

+fix

# This is the commit message #8:

+fix

# This is the commit message #9:

+fix

# This is the commit message #10:

+fix

# This is the commit message #1:

+fix

# This is the commit message #2:

+fix

# This is the commit message #3:

Changed some environment variables.

# This is the commit message #4:

+fix

# This is the commit message #5:

+fix

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
...

------
Luciano Moreira
