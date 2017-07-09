Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D132035A
	for <e@80x24.org>; Sun,  9 Jul 2017 20:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbdGIUnJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 16:43:09 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36261 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbdGIUnI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 16:43:08 -0400
Received: by mail-oi0-f44.google.com with SMTP id x187so60745976oig.3
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RFyC/D/eR5r2zrVpcTFV/93kgZuBZSq+VF8K5s0mdjE=;
        b=BfE3VGjdQ2A4/D7yks6FpgUT3ajFTgSAYACzLQM2auMY6Bq37K09OYemyIpwWxTZ8Q
         MGcsvjT15PYjeJ0VCyEJ/SreNgOSJqZ4i0tVW8+BSAAgA1C1iSNNMKW8cKYPnaHbPPjN
         XpvuTMTOO5JghTS2BRBlwBKOCzlkZ2FGF7rO+UYJyebnzMC+d+8q4aqBUJBLVp2ADp4Q
         puh5gtDTWznD8/GH7LUjNKHIYv67EHgpl06/3lqnWpXziM+G9qYc8xOSkMs/hR5pMovJ
         NU0zS2yQ6JdcnkfuCB1uoVXtPBReiiqwu+qRKEE1UrLwh1FZ0Gs1nzFbzjsv9E07daPo
         ZX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RFyC/D/eR5r2zrVpcTFV/93kgZuBZSq+VF8K5s0mdjE=;
        b=ZRgOoZIxFZhC5TyTx3AykClPk+nhu20SvVRNczGODe8NrTNEsRULr6b96qP7OmpxWf
         cZ8lcwrZ3ql36saCWewh0A3uEfMIF+dWoWGt1fNeWUytIgBwataLaTXGw2wqAqBV+0M3
         oPkTlvd7noL+ovnqGjlxRxHdGXc+RV1C2r3oP0xH5k8ZhYdaTizaW0FGTbR06W1XTHVY
         3NEDHzr6WmFghCWtab4PiY8wCCFlZKPMpGyv8uXXZEW5EOPs2F50beWuBhx+f85O12yR
         JipcCKG84+TEiKX2QJc+dE5L8Q4pRzSTdwVz3kQlJrTTySuKfqqsj0Yqf4lz0VubpJro
         xhgg==
X-Gm-Message-State: AIVw1130i0AHvM282t3RYQ+GV0dNrak/a1ZX8kQOGHgpQL3ao84BRf3b
        AVQCPM7QuKHw4m56EvettuAE6UnaD7+JVKc=
X-Received: by 10.202.73.207 with SMTP id w198mr7428314oia.217.1499632987390;
 Sun, 09 Jul 2017 13:43:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.29.161 with HTTP; Sun, 9 Jul 2017 13:42:47 -0700 (PDT)
From:   Steve Kallestad <kallestad@gmail.com>
Date:   Sun, 9 Jul 2017 13:42:47 -0700
Message-ID: <CALs7=Px4nqr6LhOTEQY80WbahRRuaKut-Us5tP7Puda0kb5EdQ@mail.gmail.com>
Subject: Bug - Dirty submodule differences between OSX/Ubuntu
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Referencing: https://gitlab.com/python-mode-devs/python-mode/issues/36

I reported a bug because when adding the python-mode repo as a
submodule in my project, it shows as "dirty".

The maintainers of that module reported back that my bug cannot be reproduced.

I upgraded my local install to 2.13.2 on OSX El Capitan.

I tried to re-create the issue, and did so successfully.

I created a docker container using ubuntu:latest as the base,
installed git and tried to recreate the issue.

git on ubuntu does not show the submodule as dirty.

I upgraded ubuntu's git to 2.13.2 and git still does not show the
submodule as dirty.

Here is how to reproduce this problem:

mkdir test
cd test
git init
git submodule add https://gitlab.com/python-mode-devs/python-mode.git
python-mode.el
git commit -m 'initial commit'
git status

On ubuntu:
On branch master
nothing to commit, working tree clean

On OSX:
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)
  (commit or discard the untracked or modified content in submodules)

    modified:   python-mode.el (modified content)

no changes added to commit (use "git add" and/or "git commit -a")

---
change into the submodule directory and run status
cd python-mode.el
git status

On ubuntu:
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean

On OSX:
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    deleted:    EXTENSIONS

no changes added to commit (use "git add" and/or "git commit -a")

---
This is a bug because the upstream repo maintainers cannot fix the
problem if they cannot see it.  dirty/clean reporting  should be the
consistent across all operating systems.
