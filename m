Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE16C1F407
	for <e@80x24.org>; Mon, 11 Dec 2017 00:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752228AbdLKANy (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 19:13:54 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:38239 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdLKANx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Dec 2017 19:13:53 -0500
Received: by mail-oi0-f46.google.com with SMTP id s9so10544550oie.5
        for <git@vger.kernel.org>; Sun, 10 Dec 2017 16:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=y8/vN7xQHYG5VeMWLCLUg7UNYA5EUnijBGnEvNA3rGY=;
        b=dP9EuWILlsi9X5tZ5ldGd+yGvfPlpzoErDEkKeSW5DlBTooJytFxhPgZYoZ2mNYj/O
         ZKiuwIzFhYYzEqU4Jvhqnh0VfGxZHkKlmih1RtUGjyGlMsS4J1H1noU6Qe+/j4llD6Hx
         QmX6aGKJffkAByFiUEk1yoYs6VSsTrjyEUyOgMYg4eXwbBO27xEHDOWAbxpyIgR/Ldvk
         dWOQDSGJeYd2GP5opHyqXeKyXIEqWYElCGIvZMNKoVebnYAYSU4//4DFSfuhJvAioqVy
         hZoeLFq4+KuBJWVn/4EXhjk+GcekYCZRVogVpev3daOayyyGaQj31hOS4HsLWLpLHU70
         SkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=y8/vN7xQHYG5VeMWLCLUg7UNYA5EUnijBGnEvNA3rGY=;
        b=H63CE0oimZrmR286FQD4+0a0IpUrwFrDJGnBeIe/rcHRSJzLsb7+U7B5S+I9vuI0In
         H3pT/kVgo/Q2zFRCKorA4lqNBs8Forxq1HmIKt5CNGOSDK20/HGYb4J6vAEuPSlHW4y+
         qTPhZ3sdA8LYCwIsprujrYTvZYu9NfF9fnyAPDVvfUmGKMSMIniLMDJQTEi4wS8UyMR3
         XOounVhQAQlrZsPZ6/ertz5Wb7Tk3MydB9WuXW03YuPWx38osuvkEaymBbuB+YBveR1k
         t0hDiiWptveHoh7/xzm3TtJm/II3xNW560jnp+boZ2t0/RAOiJ/4SPMkwPfXjCQXPH6q
         qkhw==
X-Gm-Message-State: AJaThX6SkJMdSMhUBO2vbF+PoGEPxyb4Zq7G6wv7Oi40x575nVHWlb6I
        iU95EdcGB2TPT2ASi3yzHmIzRbAvWV9Rk4/XP0iu7KVM
X-Google-Smtp-Source: AGs4zMa7OxyVZbL59U5tIo4j33uBBBrQj0Sp0CsvBXjYTLKNY99usxBImmqoefWalkHy6qZHjUVAZFc9QZ13N4UpYkk=
X-Received: by 10.202.178.196 with SMTP id b187mr30136582oif.264.1512951232967;
 Sun, 10 Dec 2017 16:13:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.202.87.215 with HTTP; Sun, 10 Dec 2017 16:13:32 -0800 (PST)
Reply-To: eduncan911@gmail.com
From:   Eric Duncan <eduncan911@gmail.com>
Date:   Sun, 10 Dec 2017 19:13:32 -0500
Message-ID: <CACaqnaSSuUKBBRfmQMswaY9nzMzU=j_0k6GMN3R4=YLA9Z1=JA@mail.gmail.com>
Subject: Bug: "git status --porcelain --show-stash" does not show stash count
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using:

   $ git version
    git version 2.15.1

Running without --porcelain shows the correct stash count:

    $ git status --show-stash
    On branch feature-Enable-Unmarshaling-Support
    Untracked files:
      (use "git add <file>..." to include in what will be committed)

            testdata/

    nothing added to commit but untracked files present (use "git add" to track)
    Your stash currently has 1 entry

Notice the last line in that output, "Your stash currently has 1 entry."

But the output when adding --porcelain does not output anything for
stash counts:

    $ git status --porcelain --show-stash
    ?? testdata/

Version 2 does not either:

    $ git status --porcelain=2 --show-stash
    ? testdata/

Also, the --short option seems to be a shortcut to --porcelain with
color coding (and still doesn't show the stash count):

    $ git status --short --show-stash
    ?? testdata/

I would expect something like "SS 1" or "S  1" to show stashes with a
count of 1.

Thanks!
Eric
