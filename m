Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD8941F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeLUQ2l (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:28:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46762 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbeLUQ2l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so5112824edt.13
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 08:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=K5qk1hW0MIsXnMG19agQtHd532aRP3KkBbRPUhnbizg=;
        b=iZwpPfsMCtmTg7Gp5SkO6wDMrWA3CRf3BzNEkFP81O/0GSzgEjQL79BjKBQw1380gO
         SgsStToJfeC5/UG0xaOc+1b31v1g02M0P4CSeBH+KPtGLg9vHDyokEAAvOpK5cVtLK0o
         h33FT/u5rYG4RDX4cZ3K4HuFWFfS6X5iBt/WG4quaDTdMJJLUV+oW1+VPJhAUkyu9hRM
         3LKrhWflSh7a08ifsORAhXt3EIqCi6UKVTyGRPhuTdjCHDw2C3z41Jm186MOcZht6lps
         LRjdRkHksq9QrvQJZ/BPwuxK9Wa/s2Ymu6jSgNxxFGQTB2M/RwwvdxOXB0uP2kBH+I0r
         6nGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K5qk1hW0MIsXnMG19agQtHd532aRP3KkBbRPUhnbizg=;
        b=a0E6ZVreq89ejTG9y8XqAJdGzu2a59HGwUo5CnRbPAW1MZytVxg0laUjd+ssa/NQLF
         huxTV4J3ErArjSaftEaITindW6CYjojirGGKffBpUxHH5KTIrkko5a+3+4VbD3J9lLAY
         S+J5clzNVlIEBVgXe9BdFyuoJ7QeeCFN+9mH1fXY0l44QRWOpfnxwe2I+dOOjNof4Ish
         TdRzsvjosz8c9vQFDoUGACqyH8HWNAvXkBN0dtWpdJT5jGT6VYcwl+F+B5PIh/4XdlQt
         0xh8uNeMMEgsnRCXFliNuZP0n9XjmW4cKtIoTv3whNIvHt5TsxIv8IWAIdp5cO/nGUUj
         jAuw==
X-Gm-Message-State: AA+aEWZtrrx9A80fV0Tgilwy6IVqopWicsgC9rRitY+jsbMsh1z3xCeX
        08VI9G6wqiZSwKFr62HT276Ft9gBywgdYw==
X-Google-Smtp-Source: AFSGD/Vpf7SQuw48Af3cvfx7gxY4lllHYAiXA+6po1PD1/jMw57GjOQQoLy5deiKQmPihskt9DolbQ==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr2929786edp.258.1545409717641;
        Fri, 21 Dec 2018 08:28:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x38sm6875442edx.24.2018.12.21.08.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:28:36 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:28:36 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 16:28:29 GMT
Message-Id: <pull.92.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/7] Create 'expire' and 'repack' verbs for git-multi-pack-index
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index provides a fast way to find an object among a large
list of pack-files. It stores a single pack-reference for each object id, so
duplicate objects are ignored. Among a list of pack-files storing the same
object, the most-recently modified one is used.

Create new subcommands for the multi-pack-index builtin.

 * 'git multi-pack-index expire': If we have a pack-file indexed by the
   multi-pack-index, but all objects in that pack are duplicated in
   more-recently modified packs, then delete that pack (and any others like
   it). Delete the reference to that pack in the multi-pack-index.
   
   
 * 'git multi-pack-index repack --batch-size=': Starting from the oldest
   pack-files covered by the multi-pack-index, find those whose on-disk size
   is below the batch size until we have a collection of packs whose sizes
   add up to the batch size. Create a new pack containing all objects that
   the multi-pack-index references to those packs.
   
   

This allows us to create a new pattern for repacking objects: run 'repack'.
After enough time has passed that all Git commands that started before the
last 'repack' are finished, run 'expire' again. This approach has some
advantages over the existing "repack everything" model:

 1. Incremental. We can repack a small batch of objects at a time, instead
    of repacking all reachable objects. We can also limit ourselves to the
    objects that do not appear in newer pack-files.
    
    
 2. Highly Available. By adding a new pack-file (and not deleting the old
    pack-files) we do not interrupt concurrent Git commands, and do not
    suffer performance degradation. By expiring only pack-files that have no
    referenced objects, we know that Git commands that are doing normal
    object lookups* will not be interrupted.
    
    
 3. Note: if someone concurrently runs a Git command that uses
    get_all_packs(), then that command could try to read the pack-files and
    pack-indexes that we are deleting during an expire command. Such
    commands are usually related to object maintenance (i.e. fsck, gc,
    pack-objects) or are related to less-often-used features (i.e.
    fast-import, http-backend, server-info).
    
    

We plan to use this approach in VFS for Git to do background maintenance of
the "shared object cache" which is a Git alternate directory filled with
packfiles containing commits and trees. We currently download pack-files on
an hourly basis to keep up-to-date with the central server. The cache
servers supply packs on an hourly and daily basis, so most of the hourly
packs become useless after a new daily pack is downloaded. The 'expire'
command would clear out most of those packs, but many will still remain with
fewer than 100 objects remaining. The 'repack' command (with a batch size of
1-3gb, probably) can condense the remaining packs in commands that run for
1-3 min at a time. Since the daily packs range from 100-250mb, we will also
combine and condense those packs.

Updates in V2:

 * Added a method, unlink_pack_path() to remove packfiles, but with the
   additional check for a .keep file. This borrows logic from 
   builtin/repack.c.
   
   
 * Modified documentation and commit messages to replace 'verb' with
   'subcommand'. Simplified the documentation. (I left 'verbs' in the title
   of the cover letter for consistency.)
   
   

Thanks, -Stolee

Derrick Stolee (7):
  repack: refactor pack deletion for future use
  Docs: rearrange subcommands for multi-pack-index
  multi-pack-index: prepare for 'expire' subcommand
  midx: refactor permutation logic
  multi-pack-index: implement 'expire' verb
  multi-pack-index: prepare 'repack' subcommand
  midx: implement midx_repack()

 Documentation/git-multi-pack-index.txt |  26 ++-
 builtin/multi-pack-index.c             |  12 +-
 builtin/repack.c                       |  14 +-
 midx.c                                 | 217 +++++++++++++++++++++++--
 midx.h                                 |   2 +
 packfile.c                             |  28 ++++
 packfile.h                             |   7 +
 t/t5319-multi-pack-index.sh            |  98 +++++++++++
 8 files changed, 376 insertions(+), 28 deletions(-)


base-commit: 26aa9fc81d4c7f6c3b456a29da0b7ec72e5c6595
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-92%2Fderrickstolee%2Fmidx-expire%2Fupstream-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-92/derrickstolee/midx-expire/upstream-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/92

Range-diff vs v1:

 -:  ---------- > 1:  a697df120c repack: refactor pack deletion for future use
 -:  ---------- > 2:  55df6b20ff Docs: rearrange subcommands for multi-pack-index
 1:  1e34b48a20 ! 3:  2529afe89e multi-pack-index: prepare for 'expire' verb
     @@ -1,6 +1,6 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    multi-pack-index: prepare for 'expire' verb
     +    multi-pack-index: prepare for 'expire' subcommand
      
          The multi-pack-index tracks objects in a collection of pack-files.
          Only one copy of each object is indexed, using the modified time
     @@ -8,12 +8,12 @@
          have a pack-file with no referenced objects because all objects
          have a duplicate in a newer pack-file.
      
     -    Introduce a new 'expire' verb to the multi-pack-index builtin.
     -    This verb will delete these unused pack-files and rewrite the
     +    Introduce a new 'expire' subcommand to the multi-pack-index builtin.
     +    This subcommand will delete these unused pack-files and rewrite the
          multi-pack-index to no longer refer to those files. More details
          about the specifics will follow as the method is implemented.
      
     -    Add a test that verifies the 'expire' verb is correctly wired,
     +    Add a test that verifies the 'expire' subcommand is correctly wired,
          but will still be valid when the verb is implemented. Specifically,
          create a set of packs that should all have referenced objects and
          should not be removed during an 'expire' operation.
     @@ -24,16 +24,13 @@
      --- a/Documentation/git-multi-pack-index.txt
      +++ b/Documentation/git-multi-pack-index.txt
      @@
     - 	When given as the verb, verify the contents of the MIDX file
     - 	at `<dir>/packs/multi-pack-index`.
     + verify::
     + 	Verify the contents of the MIDX file.
       
      +expire::
     -+	When given as the verb, delete the pack-files that are tracked
     -+	by the MIDX file at `<dir>/packs/multi-pack-index` but have
     -+	no objects referenced by the MIDX. All objects in these pack-
     -+	files have another copy in a more-recently modified pack-file.
     -+	Rewrite the MIDX file afterward to remove all references to
     -+	these pack-files.
     ++	Delete the pack-files that are tracked 	by the MIDX file, but
     ++	have no objects referenced by the MIDX. Rewrite the MIDX file
     ++	afterward to remove all references to these pack-files.
      +
       
       EXAMPLES
 2:  8f496ccb46 = 4:  0c29a242fe midx: refactor permutation logic
 3:  244bdf2a6f ! 5:  1c4af93f5e multi-pack-index: implement 'expire' verb
     @@ -75,6 +75,7 @@
      +					drop_index++;
      +					i--;
      +					missing_drops++;
     ++					continue;
      +				}
      +			}
      +
     @@ -114,8 +115,6 @@
       {
      -	return 0;
      +	uint32_t i, *count, result = 0;
     -+	size_t dirlen;
     -+	struct strbuf buf = STRBUF_INIT;
      +	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
      +	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
      +
     @@ -128,31 +127,27 @@
      +		count[pack_int_id]++;
      +	}
      +
     -+	strbuf_addstr(&buf, object_dir);
     -+	strbuf_addstr(&buf, "/pack/");
     -+	dirlen = buf.len;
     -+
      +	for (i = 0; i < m->num_packs; i++) {
     ++		char *pack_name;
     ++
      +		if (count[i])
      +			continue;
      +
     -+		if (m->packs[i]) {
     -+			close_pack(m->packs[i]);
     -+			m->packs[i] = NULL;
     -+		}
     ++		if (prepare_midx_pack(m, i))
     ++			continue;
      +
     -+		string_list_insert(&packs_to_drop, m->pack_names[i]);
     ++		if (m->packs[i]->pack_keep)
     ++			continue;
      +
     -+		strbuf_setlen(&buf, dirlen);
     -+		strbuf_addstr(&buf, m->pack_names[i]);
     -+		unlink(buf.buf);
     ++		pack_name = xstrdup(m->packs[i]->pack_name);
     ++		close_pack(m->packs[i]);
     ++		FREE_AND_NULL(m->packs[i]);
      +
     -+		strip_suffix_mem(buf.buf, &buf.len, "idx");
     -+		strbuf_addstr(&buf, "pack");
     -+		unlink(buf.buf);
     ++		string_list_insert(&packs_to_drop, m->pack_names[i]);
     ++		unlink_pack_path(pack_name, 0);
     ++		free(pack_name);
      +	}
      +
     -+	strbuf_release(&buf);
      +	free(count);
      +
      +	if (packs_to_drop.nr)
 4:  72b2139591 ! 6:  af08e21c97 multi-pack-index: prepare 'repack' verb
     @@ -1,6 +1,6 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    multi-pack-index: prepare 'repack' verb
     +    multi-pack-index: prepare 'repack' subcommand
      
          In an environment where the multi-pack-index is useful, it is due
          to many pack-files and an inability to repack the object store
     @@ -10,16 +10,16 @@
          to ensure the object store is highly available and the repack
          operation does not interrupt concurrent git commands.
      
     -    Introduce a 'repack' verb to 'git multi-pack-index' that takes a
     -    '--batch-size' option. The verb will inspect the multi-pack-index
     -    for referenced pack-files whose size is smaller than the batch
     -    size, until collecting a list of pack-files whose sizes sum to
     -    larger than the batch size. Then, a new pack-file will be created
     -    containing the objects from those pack-files that are referenced
     -    by the multi-pack-index. The resulting pack is likely to actually
     -    be smaller than the batch size due to compression and the fact
     -    that there may be objects in the pack-files that have duplicate
     -    copies in other pack-files.
     +    Introduce a 'repack' subcommand to 'git multi-pack-index' that
     +    takes a '--batch-size' option. The verb will inspect the
     +    multi-pack-index for referenced pack-files whose size is smaller
     +    than the batch size, until collecting a list of pack-files whose
     +    sizes sum to larger than the batch size. Then, a new pack-file
     +    will be created containing the objects from those pack-files that
     +    are referenced by the multi-pack-index. The resulting pack is
     +    likely to actually be smaller than the batch size due to
     +    compression and the fact that there may be objects in the pack-
     +    files that have duplicate copies in other pack-files.
      
          The current change introduces the command-line arguments, and we
          add a test that ensures we parse these options properly. Since
     @@ -32,20 +32,19 @@
      --- a/Documentation/git-multi-pack-index.txt
      +++ b/Documentation/git-multi-pack-index.txt
      @@
     - 	Rewrite the MIDX file afterward to remove all references to
     - 	these pack-files.
     + 	have no objects referenced by the MIDX. Rewrite the MIDX file
     + 	afterward to remove all references to these pack-files.
       
      +repack::
     -+	When given as the verb, collect a batch of pack-files whose
     -+	size are all at most the size given by --batch-size, but
     -+	whose sizes sum to larger than --batch-size. The batch is
     -+	selected by greedily adding small pack-files starting with
     -+	the oldest pack-files that fit the size. Create a new pack-
     -+	file containing the objects the multi-pack-index indexes
     -+	into thos pack-files, and rewrite the multi-pack-index to
     -+	contain that pack-file. A later run of 'git multi-pack-index
     -+	expire' will delete the pack-files that were part of this
     -+	batch.
     ++	Collect a batch of pack-files whose size are all at most the
     ++	size given by --batch-size, but whose sizes sum to larger
     ++	than --batch-size. The batch is selected by greedily adding
     ++	small pack-files starting with the oldest pack-files that fit
     ++	the size. Create a new pack-file containing the objects the
     ++	multi-pack-index indexes into those pack-files, and rewrite
     ++	the multi-pack-index to contain that pack-file. A later run
     ++	of 'git multi-pack-index expire' will delete the pack-files
     ++	that were part of this batch.
      +
       
       EXAMPLES
     @@ -123,7 +122,7 @@
       	)
       '
       
     -+test_expect_success 'repack does not create any packs' '
     ++test_expect_success 'repack with minimum size does not alter existing packs' '
      +	(
      +		cd dup &&
      +		ls .git/objects/pack >expect &&
 5:  41ef671ec8 = 7:  bef7aa007c midx: implement midx_repack()

-- 
gitgitgadget
