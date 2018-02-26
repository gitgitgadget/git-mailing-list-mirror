Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9721F404
	for <e@80x24.org>; Mon, 26 Feb 2018 21:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBZV3X (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 16:29:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:38129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeBZV3W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 16:29:22 -0500
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M92ZJ-1f0YGi3wtB-00CPB3; Mon, 26
 Feb 2018 22:29:14 +0100
Date:   Mon, 26 Feb 2018 22:29:11 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 00/12] rebase -i: offer to recreate merge commits
In-Reply-To: <cover.1518307771.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1519680483.git.johannes.schindelin@gmx.de>
References: <cover.1518307771.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NOL/vyWwWJLOxw4wgIdSa6fEf9qw9cCPCxoTu0GTxaNa/Gzo47Q
 Y2XsUJiTEZLYRQVnBBbBQYEaTNk0fSoOxM2yNOOmYULAYQR7UvvxH3qkuWeYd01nNK0Lxlx
 KdqH6ecyAx/oY7Meh8k3AajWruXThXNMqsCZ9EMpJjx9Iii5Clz/yR/LyCLViMN8pa4pvgu
 58JQukqyk41DGLFNBhKPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l5fYoxAeIn4=:eGkmgRgxz2RUhgktjs1ke8
 oC+/3k7R9z97t3MOxEb6UOPR+WOlOT4ZjvpjpsnlS6ofGg9mUGw7rg8Ti780J3BVuM7Yw93Dv
 5jaPkY1YxeWTLCZrhEKSXBm5EAy5BwoBcmD7bZZZNjdOvXIQ+reb5SHoZb1f5AhWEJGuVFexO
 rrTmyAPqIG3NrW8/lENbxUqWshVDNfvIqjxhMbJ7eBsBCAdEdv2a4rP+dUqwsAyrie44010Y1
 iCaocdLw1mt1XNAQChiPUzZJH/q+Pd64nZKlNGSasBKUM4tkAdSJ+zA5rIlAKdocOu2WT9k8y
 5iaqGewCyTuwL1U6P+R7Lmn+s9yM8re8O8e4hkvgdP8u9skByfXOUHgGIIskWx//TEUuLFT1c
 o4IogX1ucepSueQWLqluyXut6+SU2Q33KOzAaABKY7LGjHygr0uPoX+GNRwQPdi94IGR8cX80
 Z/5WpYPf6epoJI0e2lVHaup2wcFRW9rcBjHzIbIoB6w42MKar2s6P6pFPXgsXa03O+HgSFJ0h
 ABdvDe/wb7f/SM5dPBHqyuHClTi57sKKdbgZoSV/nDtY6ci/8aGPgPT+L11hQxi5II3YFKLsT
 m0V92EJQynq3AGQ5BRMBXRwYez6yxAMQxPouxwrylmKhkz7rbY4pU4xe27ZSJmPHWOwuLNpmt
 dHuZCA2vZMV8ZyhDpKqB1Q6pL63zv9NPCb0ZES1LtG9re0kyRrsSRA+xGp2eFZf/lsEKM9P9v
 2ewblsJjfP38kINhQ7fi0mQ51ldlr83LO6XIVxMnSc2O83yIS8nwB5/Qa6MRCPfP5mv73N8wC
 APhfYVPX8ZfTGr+5XJwLvl4sMcLu4+MuTzEeKBkQ/9NDNpuhlUAGl8Ha3NSB22RIQQXHwls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once upon a time, I dreamt of an interactive rebase that would not
flatten branch structure, but instead recreate the commit topology
faithfully.

My original attempt was --preserve-merges, but that design was so
limited that I did not even enable it in interactive mode.

Subsequently, it *was* enabled in interactive mode, with the predictable
consequences: as the --preserve-merges design does not allow for
specifying the parents of merge commits explicitly, all the new commits'
parents are defined *implicitly* by the previous commit history, and
hence it is *not possible to even reorder commits*.

This design flaw cannot be fixed. Not without a complete re-design, at
least. This patch series offers such a re-design.

Think of --recreate-merges as "--preserve-merges done right". It
introduces new verbs for the todo list, `label`, `reset` and `merge`.
For a commit topology like this:

            A - B - C
              \   /
                D

the generated todo list would look like this:

            # branch D
            pick 0123 A
            label branch-point
            pick 1234 D
            label D

            reset branch-point
            pick 2345 B
            merge -C 3456 D # C

There are more patches in the pipeline, based on this patch series, but
left for later in the interest of reviewable patch series: one mini
series to use the sequencer even for `git rebase -i --root`, and another
one to add support for octopus merges to --recreate-merges.

Changes since v3:

- (sorry for the broken iteration v4)

- fixed a grammar error in "introduce the `merge` command"'s commit message.

- fixed a couple of resource leaks in safe_append() and do_reset(), pointed
  out by Eric Sunshine.


Johannes Schindelin (11):
  sequencer: avoid using errno clobbered by rollback_lock_file()
  sequencer: make rearrange_squash() a bit more obvious
  sequencer: introduce new commands to reset the revision
  sequencer: introduce the `merge` command
  sequencer: fast-forward merge commits, if possible
  rebase-helper --make-script: introduce a flag to recreate merges
  rebase: introduce the --recreate-merges option
  sequencer: make refs generated by the `label` command worktree-local
  sequencer: handle post-rewrite for merge commands
  pull: accept --rebase=recreate to recreate the branch topology
  rebase -i: introduce --recreate-merges=[no-]rebase-cousins

Stefan Beller (1):
  git-rebase--interactive: clarify arguments

 Documentation/config.txt               |   8 +
 Documentation/git-pull.txt             |   5 +-
 Documentation/git-rebase.txt           |  14 +-
 builtin/pull.c                         |  14 +-
 builtin/rebase--helper.c               |  13 +-
 builtin/remote.c                       |   2 +
 contrib/completion/git-completion.bash |   4 +-
 git-rebase--interactive.sh             |  22 +-
 git-rebase.sh                          |  16 +
 refs.c                                 |   3 +-
 sequencer.c                            | 742 ++++++++++++++++++++++++++++++++-
 sequencer.h                            |   7 +
 t/t3430-rebase-recreate-merges.sh      | 208 +++++++++
 13 files changed, 1027 insertions(+), 31 deletions(-)
 create mode 100755 t/t3430-rebase-recreate-merges.sh


base-commit: e3a80781f5932f5fea12a49eb06f3ade4ed8945c
Published-As: https://github.com/dscho/git/releases/tag/recreate-merges-v5
Fetch-It-Via: git fetch https://github.com/dscho/git recreate-merges-v5

Interdiff vs v4:
 diff --git a/sequencer.c b/sequencer.c
 index 63ae71a7512..b2bf63029d4 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2514,14 +2514,17 @@ static int safe_append(const char *filename, const char *fmt, ...)
  
  	if (write_in_full(fd, buf.buf, buf.len) < 0) {
  		error_errno(_("could not write to '%s'"), filename);
 +		strbuf_release(&buf);
  		rollback_lock_file(&lock);
  		return -1;
  	}
  	if (commit_lock_file(&lock) < 0) {
 +		strbuf_release(&buf);
  		rollback_lock_file(&lock);
  		return error(_("failed to finalize '%s'"), filename);
  	}
  
 +	strbuf_release(&buf);
  	return 0;
  }
  
 @@ -2601,8 +2604,11 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
  	unpack_tree_opts.update = 1;
  	unpack_tree_opts.reset = 1;
  
 -	if (read_cache_unmerged())
 +	if (read_cache_unmerged()) {
 +		rollback_lock_file(&lock);
 +		strbuf_release(&ref_name);
  		return error_resolve_conflict(_(action_name(opts)));
 +	}
  
  	if (!fill_tree_descriptor(&desc, &oid)) {
  		error(_("failed to find tree of %s"), oid_to_hex(&oid));
-- 
2.16.1.windows.4

