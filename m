Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 001A11F5A1
	for <e@80x24.org>; Tue, 12 Nov 2019 10:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLKii (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 05:38:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34635 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLKie (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id e6so17988422wrw.1
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 02:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BMibLNSI02aKNEz9BwUTvEFDYYQF0z4BbFgFQWAVqo=;
        b=g7SuYgfTs3ODDPr2xSxVS4LtCsPC8iUQ/1gJnDLTZDn5nhpggw1BTzNxON2jKTDtMI
         wvC8OhGzc9tokYiAkRUid6ftoFfuV2GGrYDxbbHjU0SnuX/q0SgDMPsEuyzP6wk+HQbv
         JF3WgRct7P6SEzDPJ5CDdS2k3qhNxGDUZyAE1GGJ3R7irsldetyNFsH9ezLtCYC9YwCE
         VwnJShJvYS7ZcCIQ7xP7sbsz5AKZ7kpsr68AJAkVOXWRTMb9Zi5z+1BWFX35m/GHLX0L
         /n6r8e5SPySDPu/avLaEXu1rc/UBFCN3zlWLsjJWhoY3RyToohccB+Y3OC1rICH9Bo+u
         S8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BMibLNSI02aKNEz9BwUTvEFDYYQF0z4BbFgFQWAVqo=;
        b=EzfT3u+tA7tC7C8mfShU+CdxOdaefz3fQz8rAw/eY/RWEg3GGBRvPFKpthrYQs7YbT
         nZL88sgptZPox/giX7eKfUZabR0x0G52246XVVkY8Lk5QuGPAi40SuivHAJgcquDrchX
         PgYGDL69Ksmfuhna8vRIxYCnUUvJno23AK8t+Q/YOl8G+Wx9DY0dRoL+ZvqzcRAV6EWC
         lvxI/MDk21OgBfcyVrR0hq+lAg+dbOa0leeDJo51v8vBemdWuk/416vNLSYmWIw3HDA2
         G9LXtBFRIJnB/QAms4LiqaSigFkocJBFZt+xuLi6FTCFoJymIVr7S4KRZVRssejttLFD
         pffA==
X-Gm-Message-State: APjAAAXkV52rLi6iZRpNWez/HWfn3XLdTiXDtzaqFw95LpDdd7AUKS80
        CFFbWB+13r97/ptuMh6cAyY=
X-Google-Smtp-Source: APXvYqwfPoJWC0ELQFtxr0fmKroGLKxjAWCSUsSBSAtrqYOPomMwix64Ji/qUNSGCaciyrGQhfYbRQ==
X-Received: by 2002:adf:9f43:: with SMTP id f3mr25251908wrg.76.1573555110235;
        Tue, 12 Nov 2019 02:38:30 -0800 (PST)
Received: from localhost.localdomain (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id f24sm2313759wmb.37.2019.11.12.02.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Nov 2019 02:38:29 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/13] name-rev: eliminate recursion
Date:   Tue, 12 Nov 2019 11:38:08 +0100
Message-Id: <20191112103821.30265-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.388.gde53c094ea
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git name-rev' is implemented using a recursive algorithm, and,
consequently, it can segfault in deep histories (e.g. WebKit), and
thanks to a test case demonstrating this limitation every test run
results in a dmesg entry logging the segfaulting git process.

This patch series eliminates the recursion.

Patches 1-5 are while-at-it cleanups I noticed on the way, and patch 6
improves test coverage.  Patches 7-11 are preparatory refactorings
that are supposed to make this series easier to follow, and make patch
12, the one finally eliminating the recursion, somewhat shorter, and
even much shorter when viewed with '--ignore-all-space'.  Patch 13
cleans up after those preparatory steps.

Changes since v1:

  - Patch 12 now eliminates the recursion using a LIFO 'prio_queue'
    instead of a 'commit_list' to avoid any performance penalty.

  - Commit message updates, clarifications, typofixes, missing
    signoffs, etc., most notably in patches 6 and 12.

  - Updated ASCII art history graphs.

  - Replaced the strbuf_suffix() cleanup in patch 3 with René's
    suggestion; now that patch needs his signoff.

  - Dropped the last two patches plugging memory leaks; René's plan
    to clean up memory ownership looked more promising, and that
    would make these two dropped patches moot anyway.

v1: https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail.com/T/#u

René Scharfe (1):
  name-rev: use strbuf_strip_suffix() in get_rev_name()

SZEDER Gábor (12):
  t6120-describe: correct test repo history graph in comment
  t6120-describe: modernize the 'check_describe' helper
  name-rev: avoid unnecessary cast in name_ref()
  name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
  t6120: add a test to cover inner conditions in 'git name-rev's
    name_rev()
  name-rev: extract creating/updating a 'struct name_rev' into a helper
  name-rev: pull out deref handling from the recursion
  name-rev: restructure parsing commits and applying date cutoff
  name-rev: restructure creating/updating 'struct rev_name' instances
  name-rev: drop name_rev()'s 'generation' and 'distance' parameters
  name-rev: eliminate recursion in name_rev()
  name-rev: cleanup name_ref()

 builtin/name-rev.c  | 147 +++++++++++++++++++++++++++++---------------
 t/t6120-describe.sh |  72 +++++++++++++++++-----
 2 files changed, 153 insertions(+), 66 deletions(-)

Range-diff:
 1:  673da20e3d !  1:  8d70ed050d t6120-describe: correct test repo history graph in comment
    @@ t/t6120-describe.sh
     -test_description='test describe
     +test_description='test describe'
     +
    -+#       ,---o----o----o-----.
    -+#      /   D,R   e           \
    -+#  o--o-----o-------------o---o----x
    -+#      \    B            /
    -+#       `---o----o----o-'
    -+#                A    c
    ++#  o---o-----o----o----o-------o----x
    ++#       \   D,R   e           /
    ++#        \---o-------------o-'
    ++#         \  B            /
    ++#          `-o----o----o-'
    ++#                 A    c
    ++#
    ++# First parent of a merge commit is on the same line, second parent below.
      
     -                       B
     -        .--------------o----o----o----x
 2:  05df899693 =  2:  3720b6859d t6120-describe: modernize the 'check_describe' helper
 3:  7b0227cfea !  3:  ad2f2eee68 name-rev: use strip_suffix() in get_rev_name()
    @@
      ## Metadata ##
    -Author: SZEDER Gábor <szeder.dev@gmail.com>
    +Author: René Scharfe <l.s.r@web.de>
     
      ## Commit message ##
    -    name-rev: use strip_suffix() in get_rev_name()
    +    name-rev: use strbuf_strip_suffix() in get_rev_name()
     
    -    Use strip_suffix() instead of open-coding it, making the code more
    -    idiomatic.
    +    get_name_rev() basically open-codes strip_suffix() before adding a
    +    string to a strbuf.
     
    +    Let's use the strbuf right from the beginning, i.e. add the whole
    +    string to the strbuf and then use strbuf_strip_suffix(), making the
    +    code more idiomatic.
    +
    +    [TODO: René's signoff!]
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## builtin/name-rev.c ##
    @@ builtin/name-rev.c: static const char *get_rev_name(const struct object *o, stru
     -		int len = strlen(n->tip_name);
     -		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
     -			len -= 2;
    -+		size_t len;
    -+		strip_suffix(n->tip_name, "^0", &len);
      		strbuf_reset(buf);
     -		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
    -+		strbuf_addf(buf, "%.*s~%d", (int) len, n->tip_name,
    -+			    n->generation);
    ++		strbuf_addstr(buf, n->tip_name);
    ++		strbuf_strip_suffix(buf, "^0");
    ++		strbuf_addf(buf, "~%d", n->generation);
      		return buf->buf;
      	}
      }
 4:  40faecdc2a =  4:  c86a2ae2d0 name-rev: avoid unnecessary cast in name_ref()
 5:  c71df3dadf =  5:  4fc960cc05 name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
 6:  1dcb76072f !  6:  1493cb4484 t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
    @@ Commit message
         looks like this:
     
           if (parent_number > 1) {
    -        if (generation > 0)
    -          // do stuff #1
    -        else
    -          // do stuff #2
    +          if (generation > 0)
    +              // branch #1
    +              new_name = ...
    +          else
    +              // branch #2
    +              new_name = ...
    +          name_rev(parent, new_name, ...);
           } else {
    -         // do stuff #3
    +          // branch #3
    +          name_rev(...);
           }
     
         These conditions are not covered properly in the test suite.  As far
    @@ Commit message
         command's output, because the repository used in that test script
         contains several branches and tags pointing somewhere into the middle
         of the commit DAG, and thus result in a better name for the
    -    to-be-named commit.  In an early version of this patch series I
    -    managed to mess up those conditions (every single one of them at
    -    once!), but the whole test suite still passed successfully.
    +    to-be-named commit.  This can hide bugs: e.g. by replacing the
    +    'new_name' parameter of the first recursive name_rev() call with
    +    'tip_name' (effectively making both branch #1 and #2 a noop) 'git
    +    name-rev --all' shows thousands of bogus names in the Git repository,
    +    but the whole test suite still passes successfully.  In an early
    +    version of a later patch in this series I managed to mess up all three
    +    branches (at once!), but the test suite still passed.
     
         So add a new test case that operates on the following history:
     
    -        -----------master
    -       /          /
    -      A----------M2
    -       \        /
    -        \---M1-C
    -         \ /
    -          B
    +      A--------------master
    +       \            /
    +        \----------M2
    +         \        /
    +          \---M1-C
    +           \ /
    +            B
     
    -    and names the commit 'B', where:
    +    and names the commit 'B' to make sure that all three branches are
    +    crucial to determine 'B's name:
     
    -      - The merge commit at master makes sure that the 'do stuff #3'
    -        affects the final name.
    +      - There is only a single ref, so all names are based on 'master',
    +        without any undesired interference from other refs.
     
    -      - The merge commit M2 make sure that the 'do stuff #1' part
    -        affects the final name.
    +      - Each time name_rev() follows the second parent of a merge commit,
    +        it appends "^2" to the name.  Following 'master's second parent
    +        right at the start ensures that all commits on the ancestry path
    +        from 'master' to 'B' have a different base name from the original
    +        'tip_name' of the very first name_rev() invocation.  Currently,
    +        while name_rev() is recursive, it doesn't matter, but it will be
    +        necessary to properly cover all three branches after the recursion
    +        is eliminated later in this series.
     
    -      - And M1 makes sure that the 'do stuff #2' part affects the final
    -        name.
    +      - Following 'M2's second parent makes sure that branch #2 (i.e. when
    +        'generation = 0') affects 'B's name.
    +
    +      - Following the only parent of the non-merge commit 'C' ensures that
    +        branch #3 affects 'B's name, and that it increments 'generation'.
    +
    +      - Coming from 'C' 'generation' is 1, thus following 'M1's second
    +        parent makes sure that branch #1 affects 'B's name.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## t/t6120-describe.sh ##
    -@@ t/t6120-describe.sh: test_expect_success 'describe complains about missing object' '
    - 	test_must_fail git describe $ZERO_OID
    +@@ t/t6120-describe.sh: test_expect_success 'name-rev a rev shortly after epoch' '
    + 	test_cmp expect actual
      '
      
    -+#   -----------master
    -+#  /          /
    -+# A----------M2
    -+#  \        /
    -+#   \---M1-C
    -+#    \ /
    -+#     B
    -+test_expect_success 'test' '
    ++# A--------------master
    ++#  \            /
    ++#   \----------M2
    ++#    \        /
    ++#     \---M1-C
    ++#      \ /
    ++#       B
    ++test_expect_success 'name-rev covers all conditions while looking at parents' '
     +	git init repo &&
     +	(
     +		cd repo &&
    @@ t/t6120-describe.sh: test_expect_success 'describe complains about missing objec
     +		git checkout master &&
     +		git merge --no-ff HEAD@{1} &&
     +
    -+		git log --graph --oneline &&
    -+
     +		echo "$B master^2^2~1^2" >expect &&
     +		git name-rev $B >actual &&
     +
 7:  bdd8378b06 =  7:  fc842e578b name-rev: extract creating/updating a 'struct name_rev' into a helper
 8:  ce21c351f9 !  8:  7f182503e2 name-rev: pull out deref handling from the recursion
    @@ Commit message
         Extract this condition from the recursion into name_rev()'s caller and
         drop the function's 'deref' parameter.  This makes eliminating the
         recursion a bit easier to follow, and it will be moved back into
    -    name_rev() after the recursion is elminated.
    +    name_rev() after the recursion is eliminated.
     
         Furthermore, drop the condition that die()s when both 'deref' and
         'generation' are non-null (which should have been a BUG() to begin
    @@ Commit message
     
         Note that this change reintroduces the memory leak that was plugged in
         in commit 5308224633 (name-rev: avoid leaking memory in the `deref`
    -    case, 2017-05-04), but a later patch in this series will plug it in
    -    again.
    +    case, 2017-05-04), but a later patch (name-rev: restructure
    +    creating/updating 'struct rev_name' instances) in this series will
    +    plug it in again.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
 9:  c8acc6b597 !  9:  0cdd40b75b name-rev: restructure parsing commits and applying date cutoff
    @@ Commit message
         name_rev() and name_rev() itself as it iterates over the parent
         commits.
     
    -    This makes eliminating the recursion a bit easier to follow, and it
    -    will be moved back to name_rev() after the recursion is eliminated.
    +    This makes eliminating the recursion a bit easier to follow, and the
    +    condition moved to name_ref() will be moved back to name_rev() after
    +    the recursion is eliminated.
     
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
10:  c731f27158 ! 10:  e1733e3c56 name-rev: restructure creating/updating 'struct rev_name' instances
    @@ Commit message
         At the beginning of the recursive name_rev() function it creates a new
         'struct rev_name' instance for each previously unvisited commit or, if
         this visit results in better name for an already visited commit, then
    -    updates the 'struct rev_name' instance attached to to the commit, or
    +    updates the 'struct rev_name' instance attached to the commit, or
         returns early.
     
         Restructure this so it's caller creates or updates the 'struct
    @@ Commit message
         parameter, i.e. both name_ref() before calling name_rev() and
         name_rev() itself as it iterates over the parent commits.
     
    -    This makes eliminating the recursion a bit easier to follow, and it
    -    will be moved back to name_rev() after the recursion is eliminated.
    +    This makes eliminating the recursion a bit easier to follow, and the
    +    condition moved to name_ref() will be moved back to name_rev() after
    +    the recursion is eliminated.
     
         This change also plugs the memory leak that was temporarily unplugged
         in the earlier "name-rev: pull out deref handling from the recursion"
11:  ba14bde230 ! 11:  bd6e2e6d87 name-rev: drop name_rev()'s 'generation' and 'distance' parameters
    @@ Commit message
         'taggerdate' and 'from_tag' parameters as well, but those parameters
         will be necessary later, after the recursion is eliminated.
     
    -    Drop name_rev()'s 'generation' and 'distance' parameters.
    +    Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## builtin/name-rev.c ##
     @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit *commit,
12:  2d03ac11f3 ! 12:  0cf63c6d64 name-rev: eliminate recursion in name_rev()
    @@ Commit message
         segfault when processing a deep history if it exhausts the available
         stack space.  E.g. running 'git name-rev --all' and 'git name-rev
         HEAD~100000' in the gcc, gecko-dev, llvm, and WebKit repositories
    -    results in segfaults on my machine.
    +    results in segfaults on my machine ('ulimit -s' reports 8192kB of
    +    stack size limit), and nowadays the former segfaults in the Linux repo
    +    as well (it reached the necessasry depth sometime between v5.3-rc4 and
    +    -rc5).
     
         Eliminate the recursion by inserting the interesting parents into a
    -    'commit_list' and iteratating until the list becomes empty.
    +    LIFO 'prio_queue' [1] and iterating until the queue becomes empty.
     
    -    Note that the order in which the parent commits are added to that list
    -    is important: they must be inserted at the beginning of the list, and
    -    their relative order must be kept as well, because otherwise
    -    performance suffers.
    +    Note that the parent commits must be added in reverse order to the
    +    LIFO 'prio_queue', so their relative order is preserved during
    +    processing, i.e. the first parent should come out first from the
    +    queue, because otherwise performance greatly suffers on mergy
    +    histories [2].
     
         The stacksize-limited test 'name-rev works in a deep repo' in
         't6120-describe.sh' demonstrated this issue and expected failure.  Now
    -    the recursion is gone, so flip it to expect success.
    -
    -    Also gone are the dmesg entries logging the segfault of the git
    -    process on every execution of the test suite.
    -
    -    Unfortunately, eliminating the recursion comes with a performance
    -    penaly: 'git name-rev --all' tends to be between 15-20% slower than
    -    before.
    +    the recursion is gone, so flip it to expect success.  Also gone are
    +    the dmesg entries logging the segfault of that segfaulting 'git
    +    name-rev' process on every execution of the test suite.
     
         Note that this slightly changes the order of lines in the output of
         'git name-rev --all', usually swapping two lines every 35 lines in
    @@ Commit message
     
         This patch is best viewed with '--ignore-all-space'.
     
    +    [1] Early versions of this patch used a 'commit_list', resulting in
    +        ~15% performance penalty for 'git name-rev --all' in 'linux.git',
    +        presumably because of the memory allocation and release for each
    +        insertion and removal. Using a LIFO 'prio_queue' has basically no
    +        effect on performance.
    +
    +    [2] We prefer shorter names, i.e. 'v0.1~234' is preferred over
    +        'v0.1^2~5', meaning that usually following the first parent of a
    +        merge results in the best name for its ancestors.  So when later
    +        we follow the remaining parent(s) of a merge, and reach an already
    +        named commit, then we usually find that we can't give that commit
    +        a better name, and thus we don't have to visit any of its
    +        ancestors again.
    +
    +        OTOH, if we were to follow the Nth parent of the merge first, then
    +        the name of all its ancestors would include a corresponding '^N'.
    +        Those are not the best names for those commits, so when later we
    +        reach an already named commit following the first parent of that
    +        merge, then we would have to update the name of that commit and
    +        the names of all of its ancestors as well.  Consequently, we would
    +        have to visit many commits several times, resulting in a
    +        significant slowdown.
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## builtin/name-rev.c ##
    +@@
    + #include "tag.h"
    + #include "refs.h"
    + #include "parse-options.h"
    ++#include "prio-queue.h"
    + #include "sha1-lookup.h"
    + #include "commit-slab.h"
    + 
     @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit *commit,
      		return NULL;
      }
    @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit
     -		parse_commit(parent);
     -		if (parent->date < cutoff)
     -			continue;
    -+	struct commit_list *list = NULL;
    ++	struct prio_queue queue;
    ++	struct commit *commit;
    ++	struct commit **parents_to_queue = NULL;
    ++	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
     +
    -+	commit_list_insert(start_commit, &list);
    ++	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
    ++	prio_queue_put(&queue, start_commit);
     +
    -+	while (list) {
    -+		struct commit *commit = pop_commit(&list);
    ++	while ((commit = prio_queue_get(&queue))) {
     +		struct rev_name *name = get_commit_rev_name(commit);
    -+		struct commit_list *parents, *new_parents = NULL;
    -+		struct commit_list **last_new_parent = &new_parents;
    ++		struct commit_list *parents;
     +		int parent_number = 1;
     +
    ++		parents_to_queue_nr = 0;
    ++
     +		for (parents = commit->parents;
     +				parents;
     +				parents = parents->next, parent_number++) {
    @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit
     -			distance = name->distance + 1;
     +			if (create_or_update_name(parent, new_name, taggerdate,
     +						  generation, distance,
    -+						  from_tag))
    -+				last_new_parent = commit_list_append(parent,
    -+						  last_new_parent);
    ++						  from_tag)) {
    ++				ALLOC_GROW(parents_to_queue,
    ++					   parents_to_queue_nr + 1,
    ++					   parents_to_queue_alloc);
    ++				parents_to_queue[parents_to_queue_nr] = parent;
    ++				parents_to_queue_nr++;
    ++			}
      		}
      
     -		if (create_or_update_name(parent, new_name, taggerdate,
     -					  generation, distance,
     -					  from_tag))
     -			name_rev(parent, new_name, taggerdate, from_tag);
    -+		*last_new_parent = list;
    -+		list = new_parents;
    ++		/* The first parent must come out first from the prio_queue */
    ++		while (parents_to_queue_nr)
    ++			prio_queue_put(&queue,
    ++				       parents_to_queue[--parents_to_queue_nr]);
      	}
    ++
    ++	clear_prio_queue(&queue);
    ++	free(parents_to_queue);
      }
      
    + static int subpath_matches(const char *path, const char *filter)
     
      ## t/t6120-describe.sh ##
     @@ t/t6120-describe.sh: test_expect_success 'describe tag object' '
13:  1ef69550ca ! 13:  316f7af43c name-rev: cleanup name_ref()
    @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit
     -		int from_tag)
     +		int from_tag, int deref)
      {
    - 	struct commit_list *list = NULL;
    + 	struct prio_queue queue;
    + 	struct commit *commit;
    + 	struct commit **parents_to_queue = NULL;
    + 	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
     +	char *to_free = NULL;
     +
     +	parse_commit(start_commit);
    @@ builtin/name-rev.c: static struct rev_name *create_or_update_name(struct commit
     +		return;
     +	}
      
    - 	commit_list_insert(start_commit, &list);
    - 
    + 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
    + 	prio_queue_put(&queue, start_commit);
     @@ builtin/name-rev.c: static int name_ref(const char *path, const struct object_id *oid, int flags, vo
      		if (taggerdate == TIME_MAX)
      			taggerdate = commit->date;
14:  9d513b3092 <  -:  ---------- name-rev: plug a memory leak in name_rev()
15:  8489abb62e <  -:  ---------- name-rev: plug a memory leak in name_rev() in the deref case
-- 
2.24.0.388.gde53c094ea

