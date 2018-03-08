Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE171F404
	for <e@80x24.org>; Thu,  8 Mar 2018 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934237AbeCHQBe (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 11:01:34 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36005 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935889AbeCHQBO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 11:01:14 -0500
Received: by mail-lf0-f43.google.com with SMTP id e28-v6so78145lfc.3
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=BYVvTSCn/MGVQtVvf219Q3qh/ihpSvTC3ryHaRd+mOg=;
        b=dZYxMyDePcFm1//HNfEp3OSuz/vFG4Ufa8PBTDD80dl0xj2Cies+jlf0CIHTdCsKTt
         fLhx0BwYlAZLgSUs19zkfwKhl+a8Cs70wf0h/XRIRyQtn1N5V+BSFaSpcNGvcnAtY03h
         9S4F8Ow3e+1ppfpDUfajEOxocJwaMMfFAO151IsRygi1fc/D58V/+q2y17kFZIi+thxN
         Dhe2/PF3ChFhYqBxQsbzItskTxW5oTEiE5zhbj4W5wTSckPpgjpJhtJPqDccBSZ5QfM/
         KRDRUDrM1aNxr1dNlZ244ukXB/qAMPNnZuMJGRBaF/ENkdil5yT+llqXO8Z2Eaj77Inx
         uhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=BYVvTSCn/MGVQtVvf219Q3qh/ihpSvTC3ryHaRd+mOg=;
        b=D3s+CG0bU8VWVT9WjyBrODGg5eivguFgGfw5tVylFXJDPRBsn35Fwlp1O9+AiABkCA
         elTpRl6lIUQCGl3mS+5n3ANu3WLPcIZWppq4YQ4uhCu91UVNbFfGqxi+5vu8NkY87B6C
         3ByX1jOYL0JNXqh/vm6IGad9wmu+8ubP32apErw+b6e5r01TaYOpdWd187KIBLMylbUK
         unIHqzF8EwtthP1O/v3QHez44iTre5Ets79jOrzibG/Gcpd4AoAYT4/wXTDyGNM08m5L
         jG7zlCeJisPtRYgLLiOcNxKbdAiny60w+9Sj+218qQOxx80tNKPlrZY/gfQhBsMDEZi9
         LBlA==
X-Gm-Message-State: APf1xPBavpViOJARmCgqBx5qxkyvm8tUMUgdk2tkfnqF9d8bFU1N5D7l
        iRMsnVMiUk3PQwp1EZAtCQiKv2yivm7W4KsfTkj/bwmx
X-Google-Smtp-Source: AG47ELu0PZZUs96wQc/JIJkKLo4GSh6wQWXOaIZzHGlooqO2X7kyZUJEgvDO4jfWnBs+kr4Deht6nouIMnZ1Y0yAI5k=
X-Received: by 10.46.129.144 with SMTP id e16mr19737196ljg.94.1520524873025;
 Thu, 08 Mar 2018 08:01:13 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.114.19 with HTTP; Thu, 8 Mar 2018 08:01:12 -0800 (PST)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Thu, 8 Mar 2018 10:01:12 -0600
X-Google-Sender-Auth: 6UwmiHjuXqz0H_CfEOp_JRyVPNs
Message-ID: <CAHd499Axo7HFviUJavigTZ6BGZCkj9iOSeNVndu1oPivkPv+5Q@mail.gmail.com>
Subject: Rename of file is causing changes to be lost
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm on Windows and core.ignorecase is set to 'true' when I clone/init
a repository. I've got a branch where I started making changes to a
file AND renamed it only to change its case. The changes I've made
were significant enough that git no longer detects a rename, instead
the files show up as "D" and "A" in git status (deleted then added).
To correct this, I do an interactive rebase to add an additional
commit before the first one to rename the file without changing it,
and *then* allow the second commit to change the file. The goal is
that rebase should detect the rename and automatically move the
changes in the (now) second commit to the newly named file. Here's a
MCVE (treat this as a script):

#/bin/bash
git init testgitrepo
cd testgitrepo/
git config core.ignorecase true # This is set by Windows for me, but
hopefully will allow this to repro on linux. Didn't test linux though.
echo "first change" > foo.txt
git add . && git commit -m 'first change'
git checkout -b topic
echo "second change" > foo.txt
git mv foo.txt FOO.txt
git add . && git commit -m 'second change'
git rebase -i master # Move line 1 to line 2, and put "x false" in line 1
git mv foo.txt FOO.txt && git commit -m 'rename foo'
git rebase --continue
git mergetool

After the rebase continue, you will get a conflict like so:

error: could not apply 527d208... second change

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

Could not apply 527d208... second change
CONFLICT (rename/delete): foo.txt deleted in 527d208... second change
and renamed to FOO.txt in HEAD. Version HEAD of FOO.txt left in tree.

The last command, `git mergetool` runs, giving you the option to pick
the Created (left) or Deleted (right) version of the file:

Left: The file is created, but selecting this erases the changes from
the "added" version on the remote (which is topic). Basically the
rename of only case confused git, and we lost the changes on the
remote version of the file
Right: File is deleted. Changes are still lost.

The ideal outcome is that the changes from the "added" version of the
file in the 2nd commit get carried over to the "renamed" version of
the file, which when you compare the two are named exactly the same
after the 1st commit is introduced. How can I solve this issue?
