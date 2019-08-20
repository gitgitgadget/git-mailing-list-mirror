Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5DF31F461
	for <e@80x24.org>; Tue, 20 Aug 2019 22:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfHTWww (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 18:52:52 -0400
Received: from mail-vs1-f42.google.com ([209.85.217.42]:39534 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTWww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 18:52:52 -0400
Received: by mail-vs1-f42.google.com with SMTP id y62so81487vsb.6
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2OA2vA9hWzsUCl/rk+aX9SQh7CYNHWqEkAwHYD5bTUs=;
        b=UGQUPAxyBtkfaf/fSemSNQvHdcKLj78Xp2Cgn9eqmg0JN1kuGJX6JHZtqHYdcVD9kC
         bmWs0hG3lflHImgTb46pxfBdNanxhtD+1GsWC/bVDxyTzeu/SJW39BGA0VWLOomdd7wf
         vgmXATMpl/vA7m9EMRhRCFx4vWMDlElRv88nuxvRw0jns2EcmX8PA1jjRYv7m/kiFJsO
         irifbw14cOIovoplyBh2dx6CpaFy7yIET5pYlSDuClqN1lYCSo9fTgi+seMCd0aZOl2V
         d3txqoTe3xFM5exezgNB1Vq9uMEz3lX7xM2qmIreWTLHcNXHpJMcz226adNV7Aw960FO
         +2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2OA2vA9hWzsUCl/rk+aX9SQh7CYNHWqEkAwHYD5bTUs=;
        b=J4TfURmOboPfr5SHgV0bVTpLb49omSczqgLc2n5IfzJsV65+Bt0kBATbgTJ48lknjT
         RRCSZQOGwTOJdx83JDnqHPnCJjNK+XKvpYW4SxcJc9EVvebpw6MmzT5bFmcXNrSNrTHi
         H3TS/wLgEZSTg/5ubIaXMkrXSYRxXya3fEx9vEaVtCM8a2OETIpHDR3GqypRA0M2RDiy
         OABKGmqZbh3gItJ5RvMY1KWWJLzkpuwihZ5P9vGAmxrKTh0/oaH7u1EDUywyBAEvKkY4
         59cjlNqpYvQYfm2YUsvHnSka7FYAdVi/SqrzRzEdrWn4KBO8sTXce9r8rrCNCja+E9t3
         amBg==
X-Gm-Message-State: APjAAAUfhtNGrrLlGPbmo9+VygwOxTA6mU335B/VjKXKahZ/GoYHUBzL
        yUBkqhqNzlZcD8/SIBXTX9oLzXM29BMOvnLQZDBKPxw=
X-Google-Smtp-Source: APXvYqyMOtPRO2FC3QwaTvjfRTOn36OqXVO6KE9PmN3m4u8Sutb9s5Q8TjF1SywOU7LpkQYfS3VPTz0Gr+MITc7EivI=
X-Received: by 2002:a67:eb8c:: with SMTP id e12mr17847857vso.20.1566341571163;
 Tue, 20 Aug 2019 15:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALSvhyb7Td-ugzze9cSLXRjF78w=zE5=3yuMFZVeuXsCWLSjHg@mail.gmail.com>
 <CAE5ih78UOor3XT_hDofanoGUPLD1BC2y=pCbzF-Edm2mpRvjyQ@mail.gmail.com>
In-Reply-To: <CAE5ih78UOor3XT_hDofanoGUPLD1BC2y=pCbzF-Edm2mpRvjyQ@mail.gmail.com>
From:   Aaron Miller <aaronkmiller@gmail.com>
Date:   Tue, 20 Aug 2019 15:52:15 -0700
Message-ID: <CALSvhyagGHY+JOaygd5++-GbNYskd3ys9ZQH3ha1pkeJaKQp1Q@mail.gmail.com>
Subject: Re: git-p4: Clone p4 path with bidirectional integrations
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

> It's possible that running with "-v" might give a bit more information.

Here's the output from that. I've set git-p4.branchUser in this test
to avoid needlessly cluttering the output since I have a huge amount
of branches in my Perforce repo, but otherwise I used the exact script
which I've included later in this email:

Importing from //depot/testing/...@all into .
Reinitialized existing Git repository in
/home/amiller/Code/git-migration/repos/testing/.git/
Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']
Reading pipe: ['git', 'config', 'git-p4.branchUser']
Reading pipe: ['git', 'config', 'git-p4.user']
Reading pipe: ['git', 'config', 'git-p4.password']
Reading pipe: ['git', 'config', 'git-p4.port']
Reading pipe: ['git', 'config', 'git-p4.host']
Reading pipe: ['git', 'config', 'git-p4.client']
Reading pipe: ['git', 'config', '--int', 'git-p4.retries']
Reading pipe: ['git', 'config', '--int', 'git-p4.retries']
Opening pipe: ['p4', '-r', '3', '-G', 'login', '-s']
Opening pipe: p4 -r 3 -G branches -u amiller
Reading pipe: ['git', 'config', '--get-all', 'git-p4.branchList']
p4-git branches: []
initial parents: {}
Getting p4 changes for //depot/testing/...
Opening pipe: ['p4', '-r', '3', '-G', 'changes', '-m', '1']
Opening pipe: ['p4', '-r', '3', '-G', 'changes',
'//depot/testing/...@1,1048577']
Opening pipe: ['p4', '-r', '3', '-G', 'changes',
'//depot/testing/...@1048578,1206544']
Opening pipe: ['p4', '-r', '3', '-G', 'describe', '-s', '1206099']
Importing revision 1206099 (25%)Reading pipe: ['git', 'config',
'--bool', 'core.ignorecase']
branch is master

    Importing new branch testing/master
Opening pipe: ['p4', '-r', '3', '-G', 'changes',
'//depot/testing/master/...@1,1048577']
Opening pipe: ['p4', '-r', '3', '-G', 'changes',
'//depot/testing/master/...@1048578,1206098']

    Resuming with change 1206099
parent determined through known branches: staging
looking for initial parent for refs/remotes/p4/testing/master; current
parent is refs/remotes/p4/testing/staging
Creating temporary branch: refs/git-p4-tmp/1206099
commit into refs/git-p4-tmp/1206099
Reading pipe: ['git', 'config', '--bool', 'git-p4.keepEmptyCommits']
Opening pipe: ['p4', '-r', '3', '-G', '-x', '-', 'print']
//depot/testing/master/test1 --> test1 (0 MB)
checkpoint finished: progress checkpoint

Reading pipe: ['git', 'rev-list', '--reverse', '--no-merges',
'refs/remotes/p4/testing/staging']
fatal: ambiguous argument 'refs/remotes/p4/testing/staging': unknown
revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
Traceback (most recent call last):
  File "/home/amiller/.bin/git-p4.py", line 4173, in <module>
    main()
  File "/home/amiller/.bin/git-p4.py", line 4167, in main
    if not cmd.run(args):
  File "/home/amiller/.bin/git-p4.py", line 3923, in run
    if not P4Sync.run(self, depotPaths):
  File "/home/amiller/.bin/git-p4.py", line 3790, in run
    self.importChanges(changes)
  File "/home/amiller/.bin/git-p4.py", line 3451, in importChanges
    blob = self.searchParent(parent, branch, tempBranch)
  File "/home/amiller/.bin/git-p4.py", line 3374, in searchParent
    "--no-merges", parent]):
  File "/home/amiller/.bin/git-p4.py", line 237, in read_pipe_lines
    die('Command failed: %s' % str(c))
  File "/home/amiller/.bin/git-p4.py", line 165, in die
    raise Exception(msg)
Exception: Command failed: ['git', 'rev-list', '--reverse',
'--no-merges', 'refs/remotes/p4/testing/staging']


> Can you write a test case, or even just a shell script, that might
> help figure out what's going on.

No problem:

#!/bin/bash

# perforce setup - assumes PWD is mapped to //depot/...
mkdir -p testing/master
touch testing/master/test1
p4 add testing/master/test1
p4 submit -d 'test changelist 1'

p4 integrate //depot/testing/master/... //depot/testing/staging/...
p4 submit -d 'test changelist 2'

touch testing/staging/test2
p4 add testing/staging/test2
p4 submit -d 'test changelist 3'

p4 integrate //depot/testing/staging/... //depot/testing/master/...
p4 submit -d 'test changelist 4'

# clone with git-p4:
git init p4_git_test
cd p4_git_test
git config git-p4.branchList master:staging
git config --add git-p4.branchList staging:master
git p4 clone //depot/testing/...@all --detect-branches --verbose .


Thanks,
Aaron
