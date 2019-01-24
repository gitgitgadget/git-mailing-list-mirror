Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 924A91F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfAXVPf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:15:35 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:45288 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAXVPf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:35 -0500
Received: by mail-lj1-f175.google.com with SMTP id s5-v6so6521827ljd.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=awEfy8rugroQj3z/cDgI4ldVvyEYiTt++t5UwzX6weY=;
        b=HY/fwsI+/DeJ6Zxoabl0j5WS6h4AhAYAOkskEYWA0P2yr0u+of3OP25lXv97Qj2XRB
         JMS87nk31Z9Yndq4Jwws2RCLKg6i8a5esoO50eIaQTyvVKSvAzylgbO/j9T1g7wYD6gI
         SIwUlI//oioUs7XUnRhXmW53mW7B7bQCQxZ+pZINsDT0VoF6msszsXNKupCot7BXZS2N
         C7RBRfMhRYhU7r+cQj/tgrQegAMNcktJtDxuARnGHmaDfIh6WxzMTl0d4IVtiX96GGhg
         KTw3U+nUe1vGscoj9lnmIcIuX46JoXHfXnPzGzLOMGsrh4MoDAyinazVWFXiIo7uEuaA
         2E4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=awEfy8rugroQj3z/cDgI4ldVvyEYiTt++t5UwzX6weY=;
        b=kAPKsZu/lkRSt4GRdSanBXr6U6Rs6q3gxCYzoNtwzdysTTgj61sWmShL27bIw5wGYe
         r2iDp1cGg/yoyyDP9y2PEThWQB4QjSmAZi9+CmZbUDb1R0PHtlS54E8npD84oTMWpfdd
         H/i3EYbOG2bVT/w1NEo4WXIPcf04+WYwzTeIQ8OlFQLRE6/Qzz2ogUQQWwRjj4ktbuDC
         x6hV9sZnlpQAwCVPB/s/gQ7DYg5sghmXoIfW+notu60RVGMg7qcE7FAYsg3c1EISPH/C
         ogvQfKm4Ptkd/czMiw7XjuTlWAxMZTcQ91fB42B4YQQ6BIRjGchBjCmTKszVz0ZE5sTa
         u7nw==
X-Gm-Message-State: AJcUukfiIz8nfcRLiJQFO2TheEr8WRJbpPNj4YlkJP/LJvOrKNKp/oJ4
        NiItVHpLOs3tbw+Dln2Wn5uztWu+6bZP1oURGv0IqvY3EbM=
X-Google-Smtp-Source: ALg8bN7GaHAzRc9iDybgfeHiJulb+EBmh2eX3lwl3o9itrxVeJmUwVuKzpqPBUuPP94IEx/fedSbQHZwoT8ggg49mkk=
X-Received: by 2002:a2e:3603:: with SMTP id d3-v6mr6811968lja.46.1548364532720;
 Thu, 24 Jan 2019 13:15:32 -0800 (PST)
MIME-Version: 1.0
From:   Nikita Bobko <nikitabobko@gmail.com>
Date:   Fri, 25 Jan 2019 00:15:21 +0300
Message-ID: <CAMJzOtyieMX1WiXy72sWZPSW6kcBF__-Q7wDULRSyHrOuG6RbA@mail.gmail.com>
Subject: git status confusing message while conflicts in interactive rebase
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When have conflict in interactive rebase then git write such message:
    Auto-merging hey
    CONFLICT (content): Merge conflict in hey
    error: could not apply cd79304... 4
    Resolve all conflicts manually, mark them as resolved with
    "git add/rm <conflicted_files>", then run "git rebase --continue".
    You can instead skip this commit: run "git rebase --skip".
    To abort and get back to the state before "git rebase", run "git
rebase --abort".
    Could not apply cd79304... 4

 So git have conflict while trying to apply cd79304... 4. But `git
status` shows this message:
    interactive rebase in progress; onto a6c8075
    Last commands done (2 commands done):
       pick 0da8253 2
       pick cd79304 4
    Next command to do (1 remaining command):
       pick 47d5ec2 3
      (use "git rebase --edit-todo" to view and edit)
    You are currently rebasing branch 'master' on 'a6c8075'.
      (fix conflicts and then run "git rebase --continue")
      (use "git rebase --skip" to skip this patch)
      (use "git rebase --abort" to check out the original branch)

    Unmerged paths:
      (use "git reset HEAD <file>..." to unstage)
      (use "git add <file>..." to mark resolution)

    both modified:   hey

    no changes added to commit (use "git add" and/or "git commit -a")

And there it said that "cd79304 4" is already picked and it's in
section "Last commands done". So it's a little bit confusing.
Maybe it's better to exclude commit on which user has conflict from
"Last commands done" section. And write separate sentence containing
message like "Conflict on cd79304 4".
