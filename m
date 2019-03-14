Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF71A20248
	for <e@80x24.org>; Thu, 14 Mar 2019 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCNPdK (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 11:33:10 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44357 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCNPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 11:33:10 -0400
Received: by mail-ed1-f54.google.com with SMTP id x10so1834886edh.11
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zZcQyR58VQs57sPifUW9jvAxb1E97+NOUxPZYOUmuC8=;
        b=GkCwj2S5j7eZV7qHv1AzwBngnhRi3Pn5PGHIatVSRUAfAEOfK4f/MJ07A83D4pjzHI
         q3fjFDJgWYtZO33Gyc2Qkz2gr3KhGvFIvxRhHTLYEYCIdcqTIvqGgQgJYKb5ZfZbTCZk
         af/9f+PMRBBMyTFvkSjCzQC5JjeMnxjeONx2R2hdO2g2rMh6Gf0/sx3E/IZCM7oU3DGM
         /LwxiSHt1ZbYdnUi9Cc6loSbL4CL882mrQx6zfrp4eCRm5L3TLhj68R7NuUbiQbrxOzw
         DROGDjJoH7PmgG9jr4tF6OUd7wqDaSsaSxk9CEDfngxhCWTHODFy0IgcBLlqp357NGJ8
         YNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zZcQyR58VQs57sPifUW9jvAxb1E97+NOUxPZYOUmuC8=;
        b=AZ6eVTHiwDn4XJ1LeTi97aTio+qO+mlDfLEQkMZbhTVhqvL1ntx5UjGY14Uf7V2X6r
         OEqyof4U1TId2MeUcfVHDJPq5hTX2Mq44YZFl/u0x7BzQhVhoJHSj5DXPa3gbXW8/Bd8
         K3HVwMLvjNn4MSVLERgVICbEaFN+f2WXhILvZRChAj+US46eW4ux7kOtZolxRXfTcOvv
         mIKA8YqcrE0Fe1SskW+4LA5pXWU6hByaMlJSz6BXIe2rQlQOXpcELpo/KHrT+2qmwS2x
         UBPzBq9tU7NTVPVeLTAQykylcrs9d9uaXDsKDp6VypuHxBLffqSt4VRCfvUvnTKAmyZ+
         0uTg==
X-Gm-Message-State: APjAAAV6jI+cmFUJ/xPexTTUK96+Ijx/dhgCr3JY6UM1eA/JuL9NObC3
        7KfWMsshb4KrdXXue5X6/sIdqvAq
X-Google-Smtp-Source: APXvYqz+qeuE/gTpeGRCnNoLNZx+D+x77y2Eo8cokurWrdOz2/ykL92IQvZCRigbLpnYTgtZqvEhog==
X-Received: by 2002:aa7:c616:: with SMTP id h22mr5577194edq.39.1552577587590;
        Thu, 14 Mar 2019 08:33:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm1151753eja.70.2019.03.14.08.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 08:33:07 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:33:07 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 15:33:02 GMT
Message-Id: <pull.161.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/4] get_short_oid: cope with a possibly stale loose object cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Being rather a power user of the interactive rebase, I discovered recently
that one of my scripts ran into an odd problem where an interactive rebase
appended new commands to the todo list, and the interactive rebase failed to
validate the (short) OIDs. But when I tried to fix things via git rebase
--edit-todo, the interactive rebase had no longer any problem to validate
them.

Turns out that I generated the objects during the interactive rebase (yes, I
implemented a 2-phase rebase
[https://github.com/git-for-windows/build-extra/blob/master/ever-green.sh]),
and that their hashes happened to share the first two hex digits with some
loose object that had already been read in the same interactive rebase run,
causing a now-stale loose object cache to be initialized for that 
.git/objects/?? subdirectory.

It was quite the, let's say, adventure, to track that one down.

Over at the companion PR for Git for Windows
[https://github.com/git-for-windows/git/pull/2121], I discussed this with
Peff (who introduced the loose object cache), and he pointed out that my
original solution was a bit too specific for the interactive rebase. He
suggested the current method of re-reading upon a missing object instead,
and explained patiently that this does not affect the code path for which
the loose object cache was introduced originally: to help with performance
issues on NFS when Git tries to find the same missing objects over and over
again.

The regression test still reflects what I need this fix for, and I would
rather keep it as-is (even if the fix is not about the interactive rebase
per se), as it really tests for the functionality that I really need to
continue to work. Since I (and other contributors touching the rebase code)
frequently run only the t34* subset of the test suite while developing git
rebase patches, I also want to keep the test case there, rather than putting
it in with other SHA1-specific disambiguation test cases in 
t1512-rev-parse-disambiguation.sh.

My only concern was that this might cause some performance regressions that
neither Peff nor I could think of, where get_oid() may run repeatedly into
missing objects by design, and where we should not blow away and recreate
the loose object cache all the time. But Peff dispelled my fears, pointing
out that get_oid() is already rather expensive and therefore avoided in hot
loops.

Changes since v1:

 * The added test case now properly quotes $GIT_REBASE_TODO (even if it does
   not contain spaces, it is simply safer to quote variable expansions in
   Bash always [https://mywiki.wooledge.org/Quotes].
 * The three lines to try again to disambiguate are no longer repeated.
   Instead, we use a Beautiful Goto.
 * The commit message of 2/2 does not stress lean on the loose object cache
   so much, but also talks about packs a bit more.

Johannes Schindelin (4):
  rebase -i: demonstrate obscure loose object cache bug
  sequencer: improve error message when an OID could not be parsed
  sequencer: move stale comment into correct location
  get_oid(): when an object was not found, try harder

 sequencer.c                 |  5 +++--
 sha1-name.c                 | 13 ++++++++++++-
 t/t3429-rebase-edit-todo.sh | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)


base-commit: e902e9bcae2010bc42648c80ab6adc6c5a16a4a5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-161%2Fdscho%2Frereading-todo-list-and-loose-object-cache-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-161/dscho/rereading-todo-list-and-loose-object-cache-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/161

Range-diff vs v1:

 1:  b3fcd37765 ! 1:  63ddb1dd04 rebase -i: demonstrate obscure loose object cache bug
     @@ -60,11 +60,11 @@
      +			"committer A U Thor <author@example.org> $1 +0000" \
      +			"" \
      +			"$1" |
     -+		  git hash-object -t commit -w --stdin))" >>$GIT_REBASE_TODO
     ++		  git hash-object -t commit -w --stdin))" >>"$GIT_REBASE_TODO"
      +
      +	shift
      +	test -z "$*" ||
     -+	echo "exec $0 $*" >>$GIT_REBASE_TODO
     ++	echo "exec $0 $*" >>"$GIT_REBASE_TODO"
      +	EOS
      +
      +	git rebase HEAD -x "./append-todo.sh 5 6"
 2:  d8c4a3dde5 = 2:  f0cbfacf9a sequencer: improve error message when an OID could not be parsed
 3:  d749c63170 = 3:  b55e14cd63 sequencer: move stale comment into correct location
 4:  994446236d ! 4:  41fc6eb9ba get_oid(): when an object was not found, try harder
     @@ -3,8 +3,9 @@
          get_oid(): when an object was not found, try harder
      
          It is quite possible that the loose object cache gets stale when new
     -    objects are written. In that case, get_oid() would potentially say that
     -    it cannot find a given object, even if it should find it.
     +    objects are written. Or that a new pack was installed. In those cases,
     +    get_oid() would potentially say that it cannot find a given object, even
     +    if it should find it.
      
          Let's blow away the loose object cache as well as the read packs and try
          again in that case.
     @@ -27,19 +28,31 @@
       --- a/sha1-name.c
       +++ b/sha1-name.c
      @@
     + 					 struct object_id *oid,
     + 					 unsigned flags)
     + {
     +-	int status;
     ++	int status, attempts = 0;
     + 	struct disambiguate_state ds;
     + 	int quietly = !!(flags & GET_OID_QUIETLY);
     + 
     +@@
     + 	else
     + 		ds.fn = default_disambiguate_hint;
     + 
     ++try_again:
     + 	find_short_object_filename(&ds);
       	find_short_packed_object(&ds);
       	status = finish_object_disambiguation(&ds, oid);
       
      +	/*
     -+	 * If we didn't find it, do the usual reprepare() slow-path,
     -+	 * since the object may have recently been added to the repository
     -+	 * or migrated from loose to packed.
     ++	 * If we did not find it, do the usual reprepare() slow-path, since the
     ++	 * object may have recently been added to the repository or migrated
     ++	 * from loose to packed.
      +	 */
     -+	if (status == MISSING_OBJECT) {
     ++	if (status == MISSING_OBJECT && !attempts++) {
      +		reprepare_packed_git(the_repository);
     -+		find_short_object_filename(&ds);
     -+		find_short_packed_object(&ds);
     -+		status = finish_object_disambiguation(&ds, oid);
     ++		goto try_again;
      +	}
      +
       	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {

-- 
gitgitgadget
