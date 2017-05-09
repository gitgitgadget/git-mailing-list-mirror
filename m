Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0CA41FDEA
	for <e@80x24.org>; Tue,  9 May 2017 13:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbdEINDX (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 09:03:23 -0400
Received: from [195.159.176.226] ([195.159.176.226]:34836 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1754168AbdEINDU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 09:03:20 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d84n7-0008PN-Ml
        for git@vger.kernel.org; Tue, 09 May 2017 15:03:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Harry Putnam <reader@newsguy.com>
Subject: [noob] is this normal behavior
Date:   Tue, 09 May 2017 09:02:56 -0400
Organization: Still searching...
Message-ID: <868tm6w5bz.fsf@local.lan>
Mime-Version: 1.0
Content-Type: text/plain
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
Cancel-Lock: sha1:1RTmcCVDN327E02W8s1+hcVICcE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Setup: Running openindiana (hipster) a solaris 11 open source branch
       git 2.12.2
       
I've recently moved from mercurial to git mainly because git appears
to receive the most development and the heaviest use.

I'm using git with hold over behavior developed from my time using cvs
long ago.

I keep a hierarchy of directories and files that mirrors the structure
on the OS where git is installed [just where ever tracked files are
located on OS] not the entire structure.

I keep a git repo on the same OS that is created by rsyncing  the
BUFFERED hierarchy into a git repo

Many of the BUFFERED files are symlinked to there places in the OS

Some are not because certain files being symlinked seemed to cause
permissions type problems on the OS.  In those cases they are
periodically copied to the BUFFER hierarchy 

So, not to get too tangled up in explaining my setup... tracked files
change in the buffer area or new files are created there.

Periodically I rsync the files in BUFFER over the files in git repo

And record the changes thru normal git operations

git status
git add (when needed)
git commit

,----
| Aside:
| While I would welcome comments or suggestions about using a setup like
| this, that is not the subject of this post.
`----

This is my most recent attempt at learning and using git but I have
done a few tries before.

I'm noticing behavior I do not recall seeing in earlier attempts.

rsyncing the buffer over the git repo is now producing a result where
`git status' shows any changed or added files as modified or new but
all need to be added before a commit can take place, not just the new
ones.

Shouldn't files that changed but are already being tracked just show
up as modified and not need adding?

That is, if I have the file ~/.bashrc, which is really a symlink to
BUFFER/OS/export/home/reader/.bashrc

  And is tracked in git repo as REPO/OS/export/home/reader/.bashrc

When;
  BUFFER/OS/export/home/reader/.bashrc

is edited.

Then  rsynced like below:
  BUFFER <root of rsync is here> /OS/export/home/reader/.bashrc
over
  GITREPO <root of rsync> /OS/export/home/reader.bashrc

Thereby changing the repo file in place

Since that file is already being tracked; shouldn't `git status' show
that file as modified but ready to be committed instead of a file that
is modified but needs to be added before a commit can happen?

Another side of this is that a `git diff FILE' only works before an
`git add .' operation is done.

That is, if I run `git diff FILE' AFTER `git add' .. no diff is
reported, even though it is not committed yet.

So, for example: if I'm committing and in the vi buffer of the commit
and want to see a diff of FILE to aid my log notes.

 git diff FILE will report nothing whatever.

Is that expected behavior?

