Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA0192036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751515AbdKVBMK (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:12:10 -0500
Received: from mail-ua0-f175.google.com ([209.85.217.175]:45089 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdKVBMI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:12:08 -0500
Received: by mail-ua0-f175.google.com with SMTP id r11so9564964uah.12
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 17:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D6pboIiFxb2q4nCsGtaoywichzOsAReAscyQIsueT0k=;
        b=MeA90OA/Hek4APWagKvoVdtiflGfJnc2P8+wn5EVptbqHnmqaWy0fZkIgleWjz7a90
         V04hnJhd9Hl/tK/nJ8xvk0d3xvlFYVg9QyYVxoE8UBfJe7ybKfQVeqSRVsRNITwuRYd1
         XVBH0n8qQrVgyqdd5Po5ihHNnjVZNoBH5B2w62MDBA/u7y04c/HRxSq9TnGD5gBT5MKY
         XVXwNa9TYdyVErrAS3nSZVYQDTsWEP9yy/B41Y/+rxNrSgDbMdW0KkV+r1RwB6wVuvKk
         7HPAyTtAA6/TUPFwNdCrK4JQzEdxNVaYehsN5ZEi0/oK+oDakzKPjghSbpWQn+Q39iHA
         OUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D6pboIiFxb2q4nCsGtaoywichzOsAReAscyQIsueT0k=;
        b=FlukWCf1fJHJP2+l0pFiDSqrZ394Z8jn/bXgVY53ALYZoU/UtOLXeLnWVf1o9s0T1F
         zw1ud25A5EbUlgRkrwenzyHbGhtkGWjSQu7mIWOdd/hafIXyYebNXFEfTscU0uvHU/4X
         B70HisXJ07weLFhYpO0ZbIXARCUSqaEAni4J66dH+kHXRUaP4o2ZU6GZhq8pFhhMMZC/
         hfuG0yGgVE38msKJphKl0ST7Y6NzxKzLeZ/Z+ozj0hJlGODVX3WppZf7DyqLqDlDRpj5
         OzBU2LLx/V0hFmMjlyV8M6XyISQ7OzBLL/T1jtQxTifQoZP1URjcWTXQ9miKMbOBgKsK
         BFCg==
X-Gm-Message-State: AJaThX57wcMFW2S/C8GnRuoB73Bm7aLwbGEICKtC5KpBBsPF4Iirz5Tb
        h+pbiGpuWHNwYvbjCFAc8mbObArZyHa6hoNN9kpe+Q==
X-Google-Smtp-Source: AGs4zMZzZAGw+RtnX8vETmgi5DLnfv9Cnhbw24Ne+TFgsp9W734Jcba6nhEIBECcLHJhWq6KkTfsRzBAShonA876zkY=
X-Received: by 10.176.65.135 with SMTP id 7mr16523373uap.127.1511313126288;
 Tue, 21 Nov 2017 17:12:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Tue, 21 Nov 2017 17:12:05 -0800 (PST)
In-Reply-To: <CAGZ79kbVzDEv=rj7X6EhWZyAFd+fq+nwG8c+raqu9tXv_z9f4A@mail.gmail.com>
References: <20171121080059.32304-1-newren@gmail.com> <CAGZ79kbVzDEv=rj7X6EhWZyAFd+fq+nwG8c+raqu9tXv_z9f4A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Nov 2017 17:12:05 -0800
Message-ID: <CABPp-BFm7ZcYbie-n-ASmb6MDyJXW3G8YdtHRAzpVNgOvwK5MA@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] Add directory rename detection to git
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 4:42 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Nov 21, 2017 at 12:00 AM, Elijah Newren <newren@gmail.com> wrote:
>> This patchset introduces directory rename detection to merge-recursive; I'm
>> resubmitting just a few hours after my PATCHv2 because I didn't know about
>> the DEVELOPER=1 flag previously, and my code had a number of
>> warnings/errors.  I would have just submitted fixup/squash patches, but
>> when I checked, there sadly they cause merge conflicts when rebasing
>>
>> See https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
>> for the first series, design considerations, etc, and
>> https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/ for
>> v2.
>
> Thanks, I'll take a look!
>
> Protip: To make it easy for reviewers add an interdiff[1] between the different
> versions of the patch series, this can be done via tbdiff[2] for example,
> or in case you still have the old branch around or Junio has it queued already,
> you can do a diff against that branch.

Thanks!

Interesting; tbdiff looks cool.  Junio hasn't queued this series yet,
but it's easy enough to reconstruct the old one.  It does weigh in
pretty heavy, and I'm slighly worried about gmail mangling all the
lines, but I'm going to give it a shot anyway.  If it's too mangled,
I'll try to repost using git-send-email.  It does weigh in at over
1600 lines, so it's not small.


$ git tbdiff --no-color v2.15.0..detect-directory-renames-v1
origin/master..detect-directory-renames
 1: 054c9c1a76 !  1: a0abcb1378 Tighten and correct a few testcases
for merging and cherry-picking
    @@ -2,18 +2,21 @@

         Tighten and correct a few testcases for merging and cherry-picking

    -    t3501 had a testcase originally added to ensure cherry-pick wouldn't
    -    segfault when working with a dirty file involved in a rename.  While
    -    the segfault was fixed, there was another problem this test
demonstrated:
    -    namely, that git would overwrite a dirty file involved in a rename.
    -    Further, the test encoded a "successful merge" and overwriting of this
    -    file as correct behavior.  Modify the test so that it would still catch
    -    the segfault, but to require the correct behavior.
    +    t3501 had a testcase originally added in 05f2dfb965 (cherry-pick:
    +    demonstrate a segmentation fault, 2016-11-26) to ensure cherry-pick
    +    wouldn't segfault when working with a dirty file involved in a rename.
    +    While the segfault was fixed, there was another problem this test
    +    demonstrated: namely, that git would overwrite a dirty file
involved in a
    +    rename.  Further, the test encoded a "successful merge" and
overwriting of
    +    this file as correct behavior.  Modify the test so that it would still
    +    catch the segfault, but to require the correct behavior.  Mark it as
    +    test_expect_failure for now too, since this second bug is not
yet fixed.

    -    t7607 had a test specific to looking for a merge overwriting
a dirty file
    -    involved in a rename, but it too actually encoded what I would term
    -    incorrect behavior: it expected the merge to succeed.  Fix
that, and add
    -    a few more checks to make sure that the merge really does produce the
    +    t7607 had a test added in 30fd3a5425 (merge overwrites
unstaged changes in
    +    renamed file, 2012-04-15) specific to looking for a merge overwriting a
    +    dirty file involved in a rename, but it too actually encoded
what I would
    +    term incorrect behavior: it expected the merge to succeed.
Fix that, and
    +    add a few more checks to make sure that the merge really does
produce the
         expected results.

         Signed-off-by: Elijah Newren <newren@gmail.com>
 2: 80e8d435ad !  2: e8745c4f1b merge-recursive: fix logic ordering issue
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Fix logic ordering issue
    +    merge-recursive: fix logic ordering issue

         merge_trees() did a variety of work, including:
           * Calling get_unmerged() to get unmerged entries
 3: 2714320c37 !  3: 0ae4156994 merge-recursive: add explanation for
src_entry and dst_entry
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Add explanation for src_entry and dst_entry
    +    merge-recursive: add explanation for src_entry and dst_entry

         If I have to walk through the debugger and inspect the values found in
         here in order to figure out their meaning, despite having known these
    @@ -17,17 +17,14 @@
      struct rename {
          struct diff_filepair *pair;
     +    /*
    -+     * Because I keep forgetting every few years what src_entry and
    -+     * dst_entry are and have to walk through a debugger and puzzle
    -+     * through it to remind myself...
    ++     * Purpose of src_entry and dst_entry:
     +     *
     +     * If 'before' is renamed to 'after' then src_entry will contain
     +     * the versions of 'before' from the merge_base, HEAD, and MERGE in
    -+     * stages 1, 2, and 3; dst_entry will contain the versions of
    -+     * 'after' from the merge_base, HEAD, and MERGE in stages 1, 2, and
    -+     * 3.  Thus, we have a total of six modes and oids, though some
    -+     * will be null.  (Stage 0 is ignored; we're interested in handling
    -+     * conflicts.)
    ++     * stages 1, 2, and 3; dst_entry will contain the respective
    ++     * versions of 'after' in corresponding locations.  Thus, we have a
    ++     * total of six modes and oids, though some will be null.  (Stage 0
    ++     * is ignored; we're interested in handling conflicts.)
     +     *
     +     * Since we don't turn on break-rewrites by default, neither
     +     * src_entry nor dst_entry can have all three of their stages have
 4: 990ee6d921 < --:  ------- directory rename detection: basic testcases
 5: 4d2ec7d534 < --:  ------- directory rename detection: directory
splitting testcases
 6: 407a9b04fc < --:  ------- directory rename detection: testcases to
avoid taking detection too far
--:  ------- >  4: f13686ea6a directory rename detection: basic testcases
--:  ------- >  5: 16e7dea569 directory rename detection: directory
splitting testcases
--:  ------- >  6: 51d9a5b059 directory rename detection: testcases to
avoid taking detection too far
 7: ca6b39d08d !  7: 4b39f6bea3 directory rename detection: partially
renamed directory testcase/discussion
    @@ -45,60 +45,64 @@
     +
     +# Testcase 4a, Directory split, with original directory still present
     +#   (Related to testcase 1f)
    -+#   Commit A: z/{b,c,d,e}
    -+#   Commit B: y/{b,c,d}, z/e
    -+#   Commit C: z/{b,c,d,e,f}
    ++#   Commit O: z/{b,c,d,e}
    ++#   Commit A: y/{b,c,d}, z/e
    ++#   Commit B: z/{b,c,d,e,f}
     +#   Expected: y/{b,c,d}, z/{e,f}
     +#   NOTE: Even though most files from z moved to y, we don't
want f to follow.
     +
     +test_expect_success '4a-setup: Directory split, with original
directory still present' '
    -+    git rm -rf . &&
    -+    git clean -fdqx &&
    -+    rm -rf .git &&
    -+    git init &&
    ++    test_create_repo 4a &&
    ++    (
    ++        cd 4a &&
     +
    -+    mkdir z &&
    -+    echo b >z/b &&
    -+    echo c >z/c &&
    -+    echo d >z/d &&
    -+    echo e >z/e &&
    -+    git add z &&
    -+    test_tick &&
    -+    git commit -m "A" &&
    ++        mkdir z &&
    ++        echo b >z/b &&
    ++        echo c >z/c &&
    ++        echo d >z/d &&
    ++        echo e >z/e &&
    ++        git add z &&
    ++        test_tick &&
    ++        git commit -m "O" &&
     +
    -+    git branch A &&
    -+    git branch B &&
    -+    git branch C &&
    ++        git branch O &&
    ++        git branch A &&
    ++        git branch B &&
     +
    -+    git checkout B &&
    -+    mkdir y &&
    -+    git mv z/b y/ &&
    -+    git mv z/c y/ &&
    -+    git mv z/d y/ &&
    -+    test_tick &&
    -+    git commit -m "B" &&
    ++        git checkout A &&
    ++        mkdir y &&
    ++        git mv z/b y/ &&
    ++        git mv z/c y/ &&
    ++        git mv z/d y/ &&
    ++        test_tick &&
    ++        git commit -m "A" &&
     +
    -+    git checkout C &&
    -+    echo f >z/f &&
    -+    git add z/f &&
    -+    test_tick &&
    -+    git commit -m "C"
    ++        git checkout B &&
    ++        echo f >z/f &&
    ++        git add z/f &&
    ++        test_tick &&
    ++        git commit -m "B"
    ++    )
     +'
     +
     +test_expect_success '4a-check: Directory split, with original
directory still present' '
    -+    git checkout B^0 &&
    ++    (
    ++        cd 4a &&
     +
    -+    git merge -s recursive C^0 &&
    ++        git checkout A^0 &&
     +
    -+    test 5 -eq $(git ls-files -s | wc -l) &&
    -+    test 0 -eq $(git ls-files -u | wc -l) &&
    -+    test 0 -eq $(git ls-files -o | wc -l) &&
    ++        git merge -s recursive B^0 &&
     +
    -+    test $(git rev-parse HEAD:y/b) = $(git rev-parse A:z/b) &&
    -+    test $(git rev-parse HEAD:y/c) = $(git rev-parse A:z/c) &&
    -+    test $(git rev-parse HEAD:y/d) = $(git rev-parse A:z/d) &&
    -+    test $(git rev-parse HEAD:z/e) = $(git rev-parse A:z/e) &&
    -+    test $(git rev-parse HEAD:z/f) = $(git rev-parse C:z/f)
    ++        test 5 -eq $(git ls-files -s | wc -l) &&
    ++        test 0 -eq $(git ls-files -u | wc -l) &&
    ++        test 0 -eq $(git ls-files -o | wc -l) &&
    ++
    ++        git rev-parse >actual \
    ++            HEAD:y/b HEAD:y/c HEAD:y/d HEAD:z/e HEAD:z/f &&
    ++        git rev-parse >expect \
    ++            O:z/b O:z/c O:z/d O:z/e B:z/f &&
    ++        test_cmp expect actual
    ++    )
     +'
     +
     +###########################################################################
 8: 3a338bb00e < --:  ------- directory rename detection:
files/directories in the way of some renames
 9: 6361c3e908 < --:  ------- directory rename detection: testcases
checking which side did the rename
10: 498364bafb < --:  ------- directory rename detection: more
involved edge/corner testcases
11: 5d06e25db0 < --:  ------- directory rename detection: testcases
exploring possibly suboptimal merges
12: 779e8ac363 < --:  ------- directory rename detection:
miscellaneous testcases to complete coverage
13: 93061c9a96 < --:  ------- directory rename detection: tests for
handling overwriting untracked files
14: 9c2cec2f5b < --:  ------- directory rename detection: tests for
handling overwriting dirty files
--:  ------- >  8: 0668e65864 directory rename detection:
files/directories in the way of some renames
--:  ------- >  9: fcce655243 directory rename detection: testcases
checking which side did the rename
--:  ------- > 10: 04213cc213 directory rename detection: more
involved edge/corner testcases
--:  ------- > 11: 21992300aa directory rename detection: testcases
exploring possibly suboptimal merges
--:  ------- > 12: 727238bf64 directory rename detection:
miscellaneous testcases to complete coverage
--:  ------- > 13: 44b25c31e2 directory rename detection: tests for
handling overwriting untracked files
--:  ------- > 14: fa05a0240c directory rename detection: tests for
handling overwriting dirty files
15: 54acafcb6d ! 15: 131af0e3f2 merge-recursive: move the get_renames() function
    @@ -1,10 +1,10 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Move the get_renames() function
    +    merge-recursive: move the get_renames() function

    -    I want to re-use some other functions in the file without
moving those other
    -    functions or dealing with a handful of annoying split
function declarations
    -    and definitions.
    +    I want to re-use some other functions in the file without moving those
    +    other functions or dealing with a handful of annoying split function
    +    declarations and definitions.

         Signed-off-by: Elijah Newren <newren@gmail.com>

    @@ -37,8 +37,8 @@
     -        return renames;
     -
     -    diff_setup(&opts);
    --    DIFF_OPT_SET(&opts, RECURSIVE);
    --    DIFF_OPT_CLR(&opts, RENAME_EMPTY);
    +-    opts.flags.recursive = 1;
    +-    opts.flags.rename_empty = 0;
     -    opts.detect_rename = DIFF_DETECT_RENAME;
     -    opts.rename_limit = o->merge_rename_limit >= 0 ?
o->merge_rename_limit :
     -                o->diff_rename_limit >= 0 ? o->diff_rename_limit :
    @@ -113,8 +113,8 @@
     +        return renames;
     +
     +    diff_setup(&opts);
    -+    DIFF_OPT_SET(&opts, RECURSIVE);
    -+    DIFF_OPT_CLR(&opts, RENAME_EMPTY);
    ++    opts.flags.recursive = 1;
    ++    opts.flags.rename_empty = 0;
     +    opts.detect_rename = DIFF_DETECT_RENAME;
     +    opts.rename_limit = o->merge_rename_limit >= 0 ?
o->merge_rename_limit :
     +                o->diff_rename_limit >= 0 ? o->diff_rename_limit :
    @@ -131,6 +131,7 @@
     +        struct string_list_item *item;
     +        struct rename *re;
     +        struct diff_filepair *pair = diff_queued_diff.queue[i];
    ++
     +        if (pair->status != 'R') {
     +            diff_free_filepair(pair);
     +            continue;
16: 55d0103c72 ! 16: c7d1d15bec merge-recursive: introduce new
functions to handle rename logic
    @@ -1,12 +1,20 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Introduce new functions to handle rename logic
    +    merge-recursive: introduce new functions to handle rename logic

         The amount of logic in merge_trees() relative to renames was just a few
         lines, but split it out into new handle_renames() and cleanup_renames()
    -    functions to prepare for additional logic to be added to each.  No code
    -    or logic changes, just a new place to put stuff for when the rename
    -    detection gains additional checks.
    +    functions to prepare for additional logic to be added to
each.  No code or
    +    logic changes, just a new place to put stuff for when the
rename detection
    +    gains additional checks.
    +
    +    Note that process_renames() records pointers to various
information (such
    +    as diff_filepairs) into rename_conflict_info structs.  Even though the
    +    rename string_lists are not directly used once
handle_renames() completes,
    +    we should not immediately free the lists at the end of that function
    +    because they store the information referenced in the
rename_conflict_info,
    +    which is used later in process_entry().  Thus the reason for a separate
    +    cleanup_renames().

         Signed-off-by: Elijah Newren <newren@gmail.com>

    @@ -22,20 +30,16 @@
     +    struct string_list *merge_renames;
     +};
     +
    -+static struct rename_info *handle_renames(struct merge_options *o,
    -+                      struct tree *common,
    -+                      struct tree *head,
    -+                      struct tree *merge,
    -+                      struct string_list *entries,
    -+                      int *clean)
    ++static int handle_renames(struct merge_options *o,
    ++              struct tree *common,
    ++              struct tree *head,
    ++              struct tree *merge,
    ++              struct string_list *entries,
    ++              struct rename_info *ri)
     +{
    -+    struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));
    -+
    -+    rei->head_renames  = get_renames(o, head, common, head,
merge, entries);
    -+    rei->merge_renames = get_renames(o, merge, common, head,
merge, entries);
    -+    *clean = process_renames(o, rei->head_renames, rei->merge_renames);
    -+
    -+    return rei;
    ++    ri->head_renames  = get_renames(o, head, common, head,
merge, entries);
    ++    ri->merge_renames = get_renames(o, merge, common, head,
merge, entries);
    ++    return process_renames(o, ri->head_renames, ri->merge_renames);
     +}
     +
     +static void cleanup_renames(struct rename_info *re_info)
    @@ -45,8 +49,6 @@
     +
     +    free(re_info->head_renames);
     +    free(re_info->merge_renames);
    -+
    -+    free(re_info);
     +}
     +
      static struct object_id *stage_oid(const struct object_id *oid,
unsigned mode)
    @@ -58,7 +60,7 @@
          if (unmerged_cache()) {
     -        struct string_list *entries, *re_head, *re_merge;
     +        struct string_list *entries;
    -+        struct rename_info *re_info;
    ++        struct rename_info re_info;
              int i;
              /*
               * Only need the hashmap while processing entries, so
    @@ -69,7 +71,8 @@
     -        re_head  = get_renames(o, head, common, head, merge, entries);
     -        re_merge = get_renames(o, merge, common, head, merge, entries);
     -        clean = process_renames(o, re_head, re_merge);
    -+        re_info = handle_renames(o, common, head, merge, entries, &clean);
    ++        clean = handle_renames(o, common, head, merge, entries,
    ++                       &re_info);
              record_df_conflict_files(o, entries);
              if (clean < 0)
                  goto cleanup;
    @@ -79,7 +82,7 @@
      cleanup:
     -        string_list_clear(re_merge, 0);
     -        string_list_clear(re_head, 0);
    -+        cleanup_renames(re_info);
    ++        cleanup_renames(&re_info);
     +
              string_list_clear(entries, 1);
     +        free(entries);
17: 69de4f9cc8 < --:  ------- merge-recursive: Fix leaks of allocated
renames and diff_filepairs
18: ab86763c82 < --:  ------- merge-recursive: Make !o->detect_rename
codepath more obvious
--:  ------- > 17: 1ca5c22551 merge-recursive: fix leaks of allocated
renames and diff_filepairs
--:  ------- > 18: 57288cf7b1 merge-recursive: make !o->detect_rename
codepath more obvious
19: a92df27fb3 ! 19: fd6602a327 merge-recursive: split out code for
determining diff_filepairs
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Split out code for determining diff_filepairs
    +    merge-recursive: split out code for determining diff_filepairs

         Create a new function, get_diffpairs() to compute the diff_filepairs
         between two trees.  While these are currently only used in
    @@ -40,8 +40,8 @@
     -    renames = xcalloc(1, sizeof(struct string_list));
     -
          diff_setup(&opts);
    -     DIFF_OPT_SET(&opts, RECURSIVE);
    -     DIFF_OPT_CLR(&opts, RENAME_EMPTY);
    +     opts.flags.recursive = 1;
    +     opts.flags.rename_empty = 0;
     @@
          diffcore_std(&opts);
          if (opts.needed_rename_limit > o->needed_rename_limit)
    @@ -51,7 +51,7 @@
     +    ret = malloc(sizeof(struct diff_queue_struct));
     +    ret->queue = diff_queued_diff.queue;
     +    ret->nr = diff_queued_diff.nr;
    -+    // Ignore diff_queued_diff.alloc; we won't be changing the size at all
    ++    /* Ignore diff_queued_diff.alloc; we won't be changing size at all */
     +
     +    opts.output_format = DIFF_FORMAT_NO_OUTPUT;
     +    diff_queued_diff.nr = 0;
    @@ -85,9 +85,9 @@
              struct rename *re;
     -        struct diff_filepair *pair = diff_queued_diff.queue[i];
     +        struct diff_filepair *pair = pairs->queue[i];
    +
              if (pair->status != 'R') {
                  diff_free_filepair(pair);
    -             continue;
     @@
              item = string_list_insert(renames, pair->one->path);
              item->util = re;
    @@ -99,27 +99,30 @@
      }

     @@
    -                       int *clean)
    +               struct string_list *entries,
    +               struct rename_info *ri)
      {
    -     struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));
     +    struct diff_queue_struct *head_pairs, *merge_pairs;
    ++    int clean;
    ++
    +     ri->head_renames = NULL;
    +     ri->merge_renames = NULL;

    -     *clean = 1;
          if (!o->detect_rename)
    -         return NULL;
    +         return 1;

    --    rei->head_renames  = get_renames(o, head, common, head,
merge, entries);
    --    rei->merge_renames = get_renames(o, merge, common, head,
merge, entries);
    +-    ri->head_renames  = get_renames(o, head, common, head,
merge, entries);
    +-    ri->merge_renames = get_renames(o, merge, common, head,
merge, entries);
    +-    return process_renames(o, ri->head_renames, ri->merge_renames);
     +    head_pairs = get_diffpairs(o, common, head);
     +    merge_pairs = get_diffpairs(o, common, merge);
     +
    -+    rei->head_renames  = get_renames(o, head_pairs, head,
    ++    ri->head_renames  = get_renames(o, head_pairs, head,
     +                     common, head, merge, entries);
    -+    rei->merge_renames = get_renames(o, merge_pairs, merge,
    ++    ri->merge_renames = get_renames(o, merge_pairs, merge,
     +                     common, head, merge, entries);
    -     *clean = process_renames(o, rei->head_renames, rei->merge_renames);
    -
    -+cleanup:
    ++    clean = process_renames(o, ri->head_renames, ri->merge_renames);
    ++
     +    /*
     +     * Some cleanup is deferred until cleanup_renames() because the
     +     * data structures are still needed and referenced in
    @@ -131,6 +134,7 @@
     +    free(merge_pairs->queue);
     +    free(merge_pairs);
     +
    -     return rei;
    ++    return clean;
      }

    + static void cleanup_rename(struct string_list *rename)
20: fe8b73c07b ! 20: 8828dd4093 merge-recursive: add a new hashmap for
storing directory renames
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Add a new hashmap for storing directory renames
    +    merge-recursive: add a new hashmap for storing directory renames

         This just adds dir_rename_entry and the associated functions;
code using
         these will be added in subsequent commits.
    @@ -14,7 +14,8 @@
          return ignore_case ? strihash(path) : strhash(path);
      }

    -+static struct dir_rename_entry *dir_rename_find_entry(struct
hashmap *hashmap, char *dir)
    ++static struct dir_rename_entry *dir_rename_find_entry(struct
hashmap *hashmap,
    ++                              char *dir)
     +{
     +    struct dir_rename_entry key;
     +
    @@ -36,6 +37,16 @@
     +static void dir_rename_init(struct hashmap *map)
     +{
     +    hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);
    ++}
    ++
    ++static void dir_rename_entry_init(struct dir_rename_entry *entry,
    ++                  char *directory)
    ++{
    ++    hashmap_entry_init(entry, strhash(directory));
    ++    entry->dir = directory;
    ++    entry->non_unique_new_dir = 0;
    ++    entry->new_dir = NULL;
    ++    string_list_init(&entry->possible_new_dirs, 0);
     +}
     +
      static void flush_output(struct merge_options *o)
21: f720f90aea ! 21: f1d3b1f7ab merge-recursive: add get_directory_renames()
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Add get_directory_renames()
    +    merge-recursive: add get_directory_renames()

         This populates a list of directory renames for us.  The list of
         directory renames is not yet used, but will be in subsequent commits.
    @@ -15,7 +15,11 @@
      }

     +static void get_renamed_dir_portion(const char *old_path, const
char *new_path,
    -+                    char **old_dir, char **new_dir) {
    ++                    char **old_dir, char **new_dir)
    ++{
    ++    char *end_of_old, *end_of_new;
    ++    int old_len, new_len;
    ++
     +    *old_dir = NULL;
     +    *new_dir = NULL;
     +
    @@ -29,14 +33,15 @@
     +     * Also, if the basename of the file changed, we don't care.  We
     +     * want to know which portion of the directory, if any, changed.
     +     */
    -+    char *end_of_old = strrchr(old_path, '/');
    -+    char *end_of_new = strrchr(new_path, '/');
    ++    end_of_old = strrchr(old_path, '/');
    ++    end_of_new = strrchr(new_path, '/');
    ++
     +    if (end_of_old == NULL || end_of_new == NULL)
     +        return;
     +    while (*--end_of_new == *--end_of_old &&
     +           end_of_old != old_path &&
     +           end_of_new != new_path)
    -+        ; // Do nothing; all in the while loop
    ++        ; /* Do nothing; all in the while loop */
     +    /*
     +     * We've found the first non-matching character in the directory
     +     * paths.  That means the current directory we were comparing
    @@ -54,8 +59,8 @@
     +     * It may have been the case that old_path and new_path were the same
     +     * directory all along.  Don't claim a rename if they're the same.
     +     */
    -+    int old_len = end_of_old - old_path;
    -+    int new_len = end_of_new - new_path;
    ++    old_len = end_of_old - old_path;
    ++    new_len = end_of_new - new_path;
     +
     +    if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
     +        *old_dir = strndup(old_path, old_len);
    @@ -64,7 +69,8 @@
     +}
     +
     +static struct hashmap *get_directory_renames(struct
diff_queue_struct *pairs,
    -+                         struct tree *tree) {
    ++                         struct tree *tree)
    ++{
     +    struct hashmap *dir_renames;
     +    struct hashmap_iter iter;
     +    struct dir_rename_entry *entry;
    @@ -76,26 +82,26 @@
     +        struct string_list_item *item;
     +        int *count;
     +        struct diff_filepair *pair = pairs->queue[i];
    ++        char *old_dir, *new_dir;
     +
    -+        char *old_dir, *new_dir;
     +        get_renamed_dir_portion(pair->one->path, pair->two->path,
     +                    &old_dir,        &new_dir);
     +        if (!old_dir)
    -+            // Directory didn't change at all; ignore this one.
    ++            /* Directory didn't change at all; ignore this one. */
     +            continue;
     +
     +        entry = dir_rename_find_entry(dir_renames, old_dir);
     +        if (!entry) {
    -+            entry = xcalloc(1, sizeof(struct dir_rename_entry));
    -+            hashmap_entry_init(entry, strhash(old_dir));
    ++            entry = xmalloc(sizeof(struct dir_rename_entry));
    ++            dir_rename_entry_init(entry, old_dir);
     +            hashmap_put(dir_renames, entry);
    -+            entry->dir = old_dir;
     +        } else {
     +            free(old_dir);
     +        }
     +        item = string_list_lookup(&entry->possible_new_dirs, new_dir);
     +        if (!item) {
    -+            item = string_list_insert(&entry->possible_new_dirs, new_dir);
    ++            item = string_list_insert(&entry->possible_new_dirs,
    ++                          new_dir);
     +            item->util = xcalloc(1, sizeof(int));
     +        } else {
     +            free(new_dir);
    @@ -109,8 +115,10 @@
     +        int max = 0;
     +        int bad_max = 0;
     +        char *best = NULL;
    ++
     +        for (i = 0; i < entry->possible_new_dirs.nr; i++) {
     +            int *count = entry->possible_new_dirs.items[i].util;
    ++
     +            if (*count == max)
     +                bad_max = max;
     +            else if (*count > max) {
    @@ -136,15 +144,15 @@
       * Get information of all renames which occurred in 'pairs', making use of
       * any implicit directory renames inferred from the other side of history.
     @@
    +               struct rename_info *ri)
      {
    -     struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));
          struct diff_queue_struct *head_pairs, *merge_pairs;
     +    struct hashmap *dir_re_head, *dir_re_merge;
     +    struct hashmap_iter iter;
     +    struct dir_rename_entry *e;
    +     int clean;

    -     *clean = 1;
    -     if (!o->detect_rename)
    +     ri->head_renames = NULL;
     @@
          head_pairs = get_diffpairs(o, common, head);
          merge_pairs = get_diffpairs(o, common, merge);
    @@ -152,9 +160,9 @@
     +    dir_re_head = get_directory_renames(head_pairs, head);
     +    dir_re_merge = get_directory_renames(merge_pairs, merge);
     +
    -     rei->head_renames  = get_renames(o, head_pairs, head,
    +     ri->head_renames  = get_renames(o, head_pairs, head,
                           common, head, merge, entries);
    -     rei->merge_renames = get_renames(o, merge_pairs, merge,
    +     ri->merge_renames = get_renames(o, merge_pairs, merge,
     @@
           * process_entry().  But there are a few things we can free now.
           */
    @@ -165,7 +173,6 @@
     +        if (e->new_dir)
     +            free(e->new_dir);
     +        /* possible_new_dirs already cleared in get_directory_renames */
    -+        //string_list_clear(&e->possible_new_dirs, 1);
     +    }
     +    hashmap_free(dir_re_head, 1);
     +    free(dir_re_head);
    @@ -176,7 +183,6 @@
     +        if (e->new_dir)
     +            free(e->new_dir);
     +        /* possible_new_dirs already cleared in get_directory_renames */
    -+        //string_list_clear(&e->possible_new_dirs, 1);
     +    }
     +    hashmap_free(dir_re_merge, 1);
     +    free(dir_re_merge);
22: ad04489ad6 ! 22: ba1aa81d38 merge-recursive: check for directory
level conflicts
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Check for directory level conflicts
    +    merge-recursive: check for directory level conflicts

         Before trying to apply directory renames to paths within the given
         directories, we want to make sure that there aren't conflicts at the
    @@ -19,15 +19,15 @@
     +static int tree_has_path(struct tree *tree, const char *path)
     +{
     +    unsigned char hashy[20];
    -+    unsigned mode_o;
    ++    unsigned int mode_o;
     +
     +    return !get_tree_entry(tree->object.oid.hash, path,
     +                   hashy, &mode_o);
     +}
     +
      static void get_renamed_dir_portion(const char *old_path, const
char *new_path,
    -                     char **old_dir, char **new_dir) {
    -     *old_dir = NULL;
    +                     char **old_dir, char **new_dir)
    + {
     @@
          }
      }
    @@ -100,10 +100,10 @@
     +               !merge_ent->non_unique_new_dir) {
     +            /* 3. rename/rename(1to2) */
     +            /* We can assume it's not rename/rename(1to1) because
    -+             * that was case (1), already checked above.  But
    -+             * quickly test that assertion, just because.
    ++             * that was case (1), already checked above.  So we
    ++             * know that head_ent->new_dir and merge_ent->new_dir
    ++             * are different strings.
     +             */
    -+            assert(strcmp(head_ent->new_dir, merge_ent->new_dir));
     +            output(o, 1, _("CONFLICT (rename/rename): "
     +                       "Rename directory %s->%s in %s. "
     +                       "Rename directory %s->%s in %s"),
    @@ -132,8 +132,8 @@
     +}
     +
      static struct hashmap *get_directory_renames(struct
diff_queue_struct *pairs,
    -                          struct tree *tree) {
    -     struct hashmap *dir_renames;
    +                          struct tree *tree)
    + {
     @@
          dir_re_head = get_directory_renames(head_pairs, head);
          dir_re_merge = get_directory_renames(merge_pairs, merge);
    @@ -142,6 +142,6 @@
     +                     dir_re_head, head,
     +                     dir_re_merge, merge);
     +
    -     rei->head_renames  = get_renames(o, head_pairs, head,
    +     ri->head_renames  = get_renames(o, head_pairs, head,
                           common, head, merge, entries);
    -     rei->merge_renames = get_renames(o, merge_pairs, merge,
    +     ri->merge_renames = get_renames(o, merge_pairs, merge,
23: 83082ea5c6 ! 23: 96534fe595 merge-recursive: add a new hashmap for
storing file collisions
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Add a new hashmap for storing file collisions
    +    merge-recursive: add a new hashmap for storing file collisions

         Directory renames with the ability to merge directories opens up the
         possibility of add/add/add/.../add conflicts, if each of the N
    @@ -14,7 +14,7 @@
     --- a/merge-recursive.c
     +++ b/merge-recursive.c
     @@
    -     hashmap_init(map, (hashmap_cmp_fn) dir_rename_cmp, NULL, 0);
    +     string_list_init(&entry->possible_new_dirs, 0);
      }

     +static struct collision_entry *collision_find_entry(struct
hashmap *hashmap,
24: 02573ae17c ! 24: 66ada0e7c0 merge-recursive: add computation of
collisions due to dir rename & merging
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Add computation of collisions due to dir
rename & merging
    +    merge-recursive: add computation of collisions due to dir
rename & merging

         directory renaming and merging can cause one or more files to
be moved to
         where an existing file is, or to cause several files to all be moved to
    @@ -20,35 +20,38 @@
     + * Return a new string that replaces the beginning portion (which matches
     + * entry->dir), with entry->new_dir.  In perl-speak:
     + *   new_path_name = (old_path =~ s/entry->dir/entry->new_dir/);
    ++ * NOTE:
    ++ *   Caller must ensure that old_path starts with entry->dir + '/'.
     + */
     +static char *apply_dir_rename(struct dir_rename_entry *entry,
    -+                   const char *old_path) {
    ++                  const char *old_path)
    ++{
     +    char *new_path;
    -+    int oldlen, newlen;
    ++    int entrylen, oldlen, newlen;
     +
     +    if (entry->non_unique_new_dir)
     +        return NULL;
     +
    ++    entrylen = strlen(entry->new_dir);
     +    oldlen = strlen(entry->dir);
    -+    assert(strncmp(entry->dir, old_path, oldlen) == 0 &&
    -+           old_path[oldlen] == '/');
    -+    newlen = strlen(entry->new_dir) + (strlen(old_path) - oldlen) + 1;
    ++    newlen = entrylen + (strlen(old_path) - oldlen) + 1;
     +    new_path = malloc(newlen);
     +    strcpy(new_path, entry->new_dir);
    -+    strcpy(&new_path[strlen(new_path)], &old_path[oldlen]);
    ++    strcpy(&new_path[entrylen], &old_path[oldlen]);
     +
     +    return new_path;
     +}
     +
      static void get_renamed_dir_portion(const char *old_path, const
char *new_path,
    -                     char **old_dir, char **new_dir) {
    -     *old_dir = NULL;
    +                     char **old_dir, char **new_dir)
    + {
     @@
          return dir_renames;
      }

     +static struct dir_rename_entry *check_dir_renamed(const char *path,
    -+                          struct hashmap *dir_renames) {
    ++                          struct hashmap *dir_renames)
    ++{
     +    char temp[PATH_MAX];
     +    char *end;
     +    struct dir_rename_entry *entry;
    @@ -95,7 +98,8 @@
     +
     +        if (pair->status == 'D')
     +            continue;
    -+        dir_rename_ent = check_dir_renamed(pair->two->path, dir_renames);
    ++        dir_rename_ent = check_dir_renamed(pair->two->path,
    ++                           dir_renames);
     +        if (!dir_rename_ent)
     +            continue;
     +
    @@ -165,13 +169,14 @@
                           dir_re_head, head,
                           dir_re_merge, merge);

    --    rei->head_renames  = get_renames(o, head_pairs, head,
    -+    rei->head_renames  = get_renames(o, head_pairs,
    -+                     dir_re_merge, head,
    +-    ri->head_renames  = get_renames(o, head_pairs, head,
    +-                     common, head, merge, entries);
    +-    ri->merge_renames = get_renames(o, merge_pairs, merge,
    ++    ri->head_renames  = get_renames(o, head_pairs,
    ++                    dir_re_merge, head,
    ++                    common, head, merge, entries);
    ++    ri->merge_renames = get_renames(o, merge_pairs,
    ++                    dir_re_head, merge,
                           common, head, merge, entries);
    --    rei->merge_renames = get_renames(o, merge_pairs, merge,
    -+    rei->merge_renames = get_renames(o, merge_pairs,
    -+                     dir_re_head, merge,
    -                      common, head, merge, entries);
    -     *clean = process_renames(o, rei->head_renames, rei->merge_renames);
    +     clean = process_renames(o, ri->head_renames, ri->merge_renames);

25: 1bb7823ff5 ! 25: 0f49ea9449 merge-recursive: check for file level
conflicts then get new name
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Check for file level conflicts then get new name
    +    merge-recursive: check for file level conflicts then get new name

         Before trying to apply directory renames to paths within the given
         directories, we want to make sure that there aren't conflicts at the
    @@ -21,9 +21,11 @@
     + *   element1, element2, element3, ..., elementN
     + * to str.  If only one element, just write "element1" to str.
     + */
    -+static void comma_separated_list(char *str, struct string_list *slist) {
    ++static void comma_separated_list(char *str, struct string_list *slist)
    ++{
     +    int i;
    -+    for (i=0; i<slist->nr; i++) {
    ++
    ++    for (i = 0; i < slist->nr; i++) {
     +        str += sprintf(str, "%s", slist->items[i].string);
     +        if (i < slist->nr-1)
     +            str += sprintf(str, ", ");
    @@ -35,7 +37,7 @@
     + * level conflicts for the renamed location.  If there is a rename and
     + * there are no conflicts, return the new name.  Otherwise, return NULL.
     + */
    -+static char* handle_path_level_conflicts(struct merge_options *o,
    ++static char *handle_path_level_conflicts(struct merge_options *o,
     +                     const char *path,
     +                     struct dir_rename_entry *entry,
     +                     struct hashmap *collisions,
    @@ -44,6 +46,7 @@
     +    char *new_path = NULL;
     +    struct collision_entry *collision_ent;
     +    int clean = 1;
    ++    char *collision_paths;
     +
     +    /*
     +     * entry has the mapping of old directory name to new directory name
    @@ -53,7 +56,8 @@
     +
     +    if (!new_path) {
     +        /* This should only happen when entry->non_unique_new_dir set */
    -+        assert(entry->non_unique_new_dir);
    ++        if (!entry->non_unique_new_dir)
    ++            BUG("entry->non_unqiue_dir not set and !new_path");
     +        output(o, 1, _("CONFLICT (directory rename split): "
     +                   "Unclear where to place %s because directory "
     +                   "%s was renamed to multiple other directories, "
    @@ -68,9 +72,10 @@
     +     * The caller needs to have ensured that it has pre-populated
     +     * collisions with all paths that map to new_path.  Do a quick check
     +     * to ensure that's the case.
    -+      */
    ++     */
     +    collision_ent = collision_find_entry(collisions, new_path);
    -+    assert(collision_ent != NULL);
    ++    if (collision_ent == NULL)
    ++        BUG("collision_ent is NULL");
     +
     +    /*
     +     * Check for one-sided add/add/.../add conflicts, i.e.
    @@ -79,7 +84,8 @@
     +     * to put multiple paths into the same location.  Warn
     +     * and bail on directory renames for such paths.
     +     */
    -+    char collision_paths[(PATH_MAX+2) * collision_ent->source_files.nr];
    ++    collision_paths = malloc((PATH_MAX+2) *
collision_ent->source_files.nr);
    ++
     +    if (collision_ent->reported_already) {
     +        clean = 0;
     +    } else if (tree_has_path(tree, new_path)) {
    @@ -104,6 +110,7 @@
     +    }
     +
     +    /* Free memory we no longer need */
    ++    free(collision_paths);
     +    if (!clean && new_path) {
     +        free(new_path);
     +        return NULL;
    @@ -129,6 +136,8 @@
     +{
     +    char *new_path = NULL;
     +    struct dir_rename_entry *entry = check_dir_renamed(path, dir_renames);
    ++    struct dir_rename_entry *oentry = NULL;
    ++
     +    if (!entry)
     +        return new_path;
     +
    @@ -156,7 +165,6 @@
     +     * As it turns out, this also prevents N-way transient rename
     +     * confusion; See testcases 9c and 9d of t6043.
     +     */
    -+    struct dir_rename_entry *oentry = NULL;
     +    oentry = dir_rename_find_entry(dir_rename_exclusions, entry->new_dir);
     +    if (oentry) {
     +        output(o, 1, _("WARNING: Avoiding applying %s -> %s rename "
    @@ -193,76 +201,71 @@
              struct string_list_item *item;
              struct rename *re;
              struct diff_filepair *pair = pairs->queue[i];
    ++        char *new_path; /* non-NULL only with directory renames */
    +
     -        if (pair->status != 'R') {
    -+        char *new_path; // non-NULL only with directory renames
    -+
     +        if (pair->status == 'D') {
    -             diff_free_filepair(pair);
    -             continue;
    -         }
    ++            diff_free_filepair(pair);
    ++            continue;
    ++        }
     +        new_path = check_for_directory_rename(o, pair->two->path, tree,
     +                              dir_renames,
     +                              dir_rename_exclusions,
     +                              &collisions,
     +                              clean_merge);
     +        if (pair->status != 'R' && !new_path) {
    -+            diff_free_filepair(pair);
    -+            continue;
    -+        }
    +             diff_free_filepair(pair);
    +             continue;
    +         }
     +
              re = xmalloc(sizeof(*re));
              re->processed = 0;
              re->pair = pair;
     @@
    +     struct hashmap *dir_re_head, *dir_re_merge;
    +     struct hashmap_iter iter;
    +     struct dir_rename_entry *e;
    +-    int clean;
    ++    int clean = 1;
    +
    +     ri->head_renames = NULL;
    +     ri->merge_renames = NULL;
    +@@
                           dir_re_merge, merge);

    -     rei->head_renames  = get_renames(o, head_pairs,
    --                     dir_re_merge, head,
    +     ri->head_renames  = get_renames(o, head_pairs,
    +-                    dir_re_merge, head,
    +-                    common, head, merge, entries);
    ++                    dir_re_merge, dir_re_head, head,
    ++                    common, head, merge, entries,
    ++                    &clean);
    ++    if (clean < 0)
    ++        goto cleanup;
    +     ri->merge_renames = get_renames(o, merge_pairs,
    +-                    dir_re_head, merge,
     -                     common, head, merge, entries);
    -+                     dir_re_merge, dir_re_head, head,
    -+                     common, head, merge, entries,
    -+                     clean);
    -+    if (*clean < 0)
    +-    clean = process_renames(o, ri->head_renames, ri->merge_renames);
    ++                    dir_re_head, dir_re_merge, merge,
    ++                    common, head, merge, entries,
    ++                    &clean);
    ++    if (clean < 0)
     +        goto cleanup;
    -     rei->merge_renames = get_renames(o, merge_pairs,
    --                     dir_re_head, merge,
    --                     common, head, merge, entries);
    --    *clean = process_renames(o, rei->head_renames, rei->merge_renames);
    -+                     dir_re_head, dir_re_merge, merge,
    -+                     common, head, merge, entries,
    -+                     clean);
    -+    if (*clean < 0)
    -+        goto cleanup;
    -+    *clean &= process_renames(o, rei->head_renames, rei->merge_renames);
    -
    - cleanup:
    ++    clean &= process_renames(o, ri->head_renames, ri->merge_renames);
    +
    ++cleanup:
          /*
    -@@
    -         if (e->new_dir)
    -             free(e->new_dir);
    -         /* possible_new_dirs already cleared in get_directory_renames */
    --        //string_list_clear(&e->possible_new_dirs, 1);
    -     }
    -     hashmap_free(dir_re_head, 1);
    -     free(dir_re_head);
    -@@
    -         if (e->new_dir)
    -             free(e->new_dir);
    -         /* possible_new_dirs already cleared in get_directory_renames */
    --        //string_list_clear(&e->possible_new_dirs, 1);
    -     }
    -     hashmap_free(dir_re_merge, 1);
    -     free(dir_re_merge);
    +      * Some cleanup is deferred until cleanup_renames() because the
    +      * data structures are still needed and referenced in

     diff --git a/t/t6043-merge-rename-directories.sh
b/t/t6043-merge-rename-directories.sh
     --- a/t/t6043-merge-rename-directories.sh
     +++ b/t/t6043-merge-rename-directories.sh
     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '2a-check: Directory split into two on one
side, with equal numbers of paths' '
     +test_expect_success '2a-check: Directory split into two on one
side, with equal numbers of paths' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    +     (
    +         cd 2a &&
    +
26: c5180f2d23 ! 26: 996de01e67 merge-recursive: when comparing files,
don't include trees
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: When comparing files, don't include trees
    +    merge-recursive: when comparing files, don't include trees

         get_renames() would look up stage data that already existed (populated
         in get_unmerged(), taken from whatever unpack_trees() created), and if
    @@ -27,7 +27,7 @@
     +static int get_tree_entry_if_blob(const unsigned char *tree,
     +                  const char *path,
     +                  unsigned char *hashy,
    -+                  unsigned *mode_o)
    ++                  unsigned int *mode_o)
     +{
     +    int ret;
     +
27: f2f3bed14a ! 27: 07401ad0ff merge-recursive: apply necessary
modifications for directory renames
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Apply necessary modifications for directory renames
    +    merge-recursive: apply necessary modifications for directory renames

         This commit hooks together all the directory rename logic by making the
         necessary changes to the rename struct, it's dst_entry, and the
    @@ -36,6 +36,7 @@
     +                    const struct stage_data *stage_data)
     +{
     +    struct diff_filespec o, a, b;
    ++
     +    o.mode = stage_data->stages[1].mode;
     +    oidcpy(&o.oid, &stage_data->stages[1].oid);
     +
    @@ -154,18 +155,8 @@
     +         * case we can just allow the normal processing to happen
     +         * for it).
     +         */
    -+        if (!strcmp(pair->one->path, pair->two->path)) {
    -+            /*
    -+             * Paths should only match if this was initially a
    -+             * non-rename that is being turned into one by
    -+             * directory rename detection.
    -+             */
    -+            assert(pair->status != 'R');
    -+        } else {
    -+            assert(pair->status == 'R');
    ++        if (pair->status == 'R')
     +            re->dst_entry->processed = 1;
    -+            //string_list_remove(entries, pair->two->path, 0);
    -+        }
     +
     +        re->dst_entry = insert_stage_data(new_path,
     +                          o_tree, a_tree, b_tree,
    @@ -178,7 +169,9 @@
     +     * Update the stage_data with the information about the path we are
     +     * moving into place.  That slot will be empty and available for us
     +     * to write to because of the collision checks in
    -+     * handle_path_level_conflicts().
    ++     * handle_path_level_conflicts().  In other words,
    ++     * re->dst_entry->stages[stage].oid will be the null_oid, so it's
    ++     * open for us to write to.
     +     *
     +     * It may be tempting to actually update the index at this point as
     +     * well, using update_stages_for_stage_data(), but as per the big
    @@ -188,7 +181,6 @@
     +     * the various conflict_rename_*() functions update the index
     +     * explicitly rather than relying on unpack_trees() to have done it.
     +     */
    -+    assert(is_null_oid(&re->dst_entry->stages[stage].oid));
     +    get_tree_entry(tree->object.oid.hash,
     +               pair->two->path,
     +               re->dst_entry->stages[stage].oid.hash,
    @@ -232,11 +224,11 @@
              item = string_list_insert(renames, pair->one->path);
              item->util = re;
     +        if (new_path)
    -+              apply_directory_rename_modifications(o, pair, new_path,
    -+                                   re, tree, o_tree,
    -+                                   a_tree, b_tree,
    -+                                   entries,
    -+                                   clean_merge);
    ++            apply_directory_rename_modifications(o, pair, new_path,
    ++                                 re, tree, o_tree,
    ++                                 a_tree, b_tree,
    ++                                 entries,
    ++                                 clean_merge);
          }

          hashmap_iter_init(&collisions, &iter);
    @@ -281,227 +273,227 @@
     --- a/t/t6043-merge-rename-directories.sh
     +++ b/t/t6043-merge-rename-directories.sh
     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '1a-check: Simple directory rename detection' '
     +test_expect_success '1a-check: Simple directory rename detection' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 1a &&
    +
    +@@
    +     )
      '

     -test_expect_failure '1b-check: Merge a directory with another' '
     +test_expect_success '1b-check: Merge a directory with another' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 1b &&
    +
    +@@
    +     )
      '

     -test_expect_failure '1c-check: Transitive renaming' '
     +test_expect_success '1c-check: Transitive renaming' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 1c &&
    +
    +@@
    +     )
      '

     -test_expect_failure '1d-check: Directory renames cause a
rename/rename(2to1) conflict' '
     +test_expect_success '1d-check: Directory renames cause a
rename/rename(2to1) conflict' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 1d &&
    +
    +@@
    +     )
      '

     -test_expect_failure '1e-check: Renamed directory, with all files
being renamed too' '
     +test_expect_success '1e-check: Renamed directory, with all files
being renamed too' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 1e &&
    +
    +@@
    +     )
      '

     -test_expect_failure '1f-check: Split a directory into two other
directories' '
     +test_expect_success '1f-check: Split a directory into two other
directories' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 1f &&
    +
    +@@
    +     )
      '

     -test_expect_failure '5a-check: Merge directories, other side
adds files to original and target' '
     +test_expect_success '5a-check: Merge directories, other side
adds files to original and target' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 5a &&
    +
    +@@
    +     )
      '

     -test_expect_failure '5b-check: Rename/delete in order to get
add/add/add conflict' '
     +test_expect_success '5b-check: Rename/delete in order to get
add/add/add conflict' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 5b &&
    +
    +@@
    +     )
      '

     -test_expect_failure '5c-check: Transitive rename would cause
rename/rename/rename/add/add/add' '
     +test_expect_success '5c-check: Transitive rename would cause
rename/rename/rename/add/add/add' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 5c &&
    +
    +@@
    +     )
      '

     -test_expect_failure '5d-check: Directory/file/file conflict due
to directory rename' '
     +test_expect_success '5d-check: Directory/file/file conflict due
to directory rename' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 5d &&
    +
    +@@
    +     )
      '

     -test_expect_failure '7a-check: rename-dir vs. rename-dir (NOT
split evenly) PLUS add-other-file' '
     +test_expect_success '7a-check: rename-dir vs. rename-dir (NOT
split evenly) PLUS add-other-file' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 7a &&
    +
    +@@
    +     )
      '

     -test_expect_failure '7b-check: rename/rename(2to1), but only due
to transitive rename' '
     +test_expect_success '7b-check: rename/rename(2to1), but only due
to transitive rename' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 7b &&
    +
    +@@
    +     )
      '

     -test_expect_failure '7c-check: rename/rename(1to...2or3);
transitive rename may add complexity' '
     +test_expect_success '7c-check: rename/rename(1to...2or3);
transitive rename may add complexity' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 7c &&
    +
    +@@
    +     )
      '

     -test_expect_failure '7d-check: transitive rename involved in
rename/delete; how is it reported?' '
     +test_expect_success '7d-check: transitive rename involved in
rename/delete; how is it reported?' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 7d &&
    +
    +@@
    +     )
      '

     -test_expect_failure '7e-check: transitive rename in
rename/delete AND dirs in the way' '
     +test_expect_success '7e-check: transitive rename in
rename/delete AND dirs in the way' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 7e &&
    +
    +@@
    +     )
      '

     -test_expect_failure '8a-check: Dual-directory rename, one into
the others way' '
     +test_expect_success '8a-check: Dual-directory rename, one into
the others way' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 8a &&
    +
    +@@
    +     )
      '

     -test_expect_failure '8c-check: rename+modify/delete' '
     +test_expect_success '8c-check: rename+modify/delete' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 8c &&
    +
    +@@
    +     )
      '

     -test_expect_failure '8d-check: rename/delete...or not?' '
     +test_expect_success '8d-check: rename/delete...or not?' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 8d &&
    +
    +@@
    +     )
      '

     -test_expect_failure '8e-check: Both sides rename, one side adds
to original directory' '
     +test_expect_success '8e-check: Both sides rename, one side adds
to original directory' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out 2>err &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 8e &&
    +
    +@@
    +     )
      '

     -test_expect_failure '9a-check: Inner renamed directory within
outer renamed directory' '
     +test_expect_success '9a-check: Inner renamed directory within
outer renamed directory' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 9a &&
    +
    +@@
    +     )
      '

     -test_expect_failure '9b-check: Transitive rename with content merge' '
     +test_expect_success '9b-check: Transitive rename with content merge' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 9b &&
    +
    +@@
    +     )
      '

     -test_expect_failure '9c-check: Doubly transitive rename?' '
     +test_expect_success '9c-check: Doubly transitive rename?' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 9c &&
    +
    +@@
    +     )
      '

     -test_expect_failure '9d-check: N-way transitive rename?' '
     +test_expect_success '9d-check: N-way transitive rename?' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 9d &&
    +
    +@@
    +     )
      '

     -test_expect_failure '9e-check: N-to-1 whammo' '
     +test_expect_success '9e-check: N-to-1 whammo' '
    -     git checkout B^0 &&
    -
    -     test_must_fail git merge -s recursive C^0 >out &&
    -@@
    -     git commit -m "C"
    +     (
    +         cd 9e &&
    +
    +@@
    +     )
      '

     -test_expect_failure '9f-check: Renamed directory that only
contained immediate subdirs' '
     +test_expect_success '9f-check: Renamed directory that only
contained immediate subdirs' '
    -     git checkout B^0 &&
    -
    -     git merge -s recursive C^0 &&
    +     (
    +         cd 9f &&
    +
28: 2b31d16009 ! 28: fafa66de08 merge-recursive: avoid clobbering
untracked files with directory renames
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Avoid clobbering untracked files with
directory renames
    +    merge-recursive: avoid clobbering untracked files with
directory renames

         Signed-off-by: Elijah Newren <newren@gmail.com>

    @@ -13,6 +13,7 @@

     +    if (!o->call_depth && would_lose_untracked(dest->path)) {
     +        char *alt_path = unique_path(o, dest->path, rename_branch);
    ++
     +        output(o, 1, _("Error: Refusing to lose untracked file at %s; "
     +                   "writing to %s instead."),
     +               dest->path, alt_path);
    @@ -47,9 +48,11 @@
                  dst_name = unique_path(o, rename->path, cur_branch);
                  output(o, 1, _("%s is a directory in %s adding as %s
instead"),
                         rename->path, other_branch, dst_name);
    -+        } else if (!o->call_depth && would_lose_untracked(rename->path)) {
    ++        } else if (!o->call_depth &&
    ++               would_lose_untracked(rename->path)) {
     +            dst_name = unique_path(o, rename->path, cur_branch);
    -+            output(o, 1, _("Refusing to lose untracked file at
%s; adding as %s instead"),
    ++            output(o, 1, _("Refusing to lose untracked file at %s; "
    ++                       "adding as %s instead"),
     +                   rename->path, dst_name);
              }
          }
    @@ -79,29 +82,29 @@
     --- a/t/t6043-merge-rename-directories.sh
     +++ b/t/t6043-merge-rename-directories.sh
     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '10b-check: Overwrite untracked with dir
rename + delete' '
     +test_expect_success '10b-check: Overwrite untracked with dir
rename + delete' '
    -     git checkout B^0 &&
    -     echo very >y/c &&
    -     echo important >y/d &&
    +     (
    +         cd 10b &&
    +
     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '10c-check: Overwrite untracked with dir
rename/rename(1to2)' '
     +test_expect_success '10c-check: Overwrite untracked with dir
rename/rename(1to2)' '
    -     git checkout B^0 &&
    -     echo important >y/c &&
    +     (
    +         cd 10c &&

     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '10d-check: Delete untracked with dir
rename/rename(2to1)' '
     +test_expect_success '10d-check: Delete untracked with dir
rename/rename(2to1)' '
    -     git checkout B^0 &&
    -     echo important >y/wham &&
    +     (
    +         cd 10d &&

29: 48becdc226 ! 29: 9ab0339ebb merge-recursive: fix overwriting dirty
files involved in renames
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Fix overwriting dirty files involved in renames
    +    merge-recursive: fix overwriting dirty files involved in renames

         This fixes an issue that existed before my directory rename detection
         patches that affects both normal renames and renames implied by
    @@ -55,7 +55,12 @@

     -    rc = unpack_trees(3, t, &opts);
     +    rc = unpack_trees(3, t, &o->unpack_opts);
    -+    o->unpack_opts.src_index = &the_index; // unpack_trees
NULLifies src_index, but it's used in verify_uptodate, so set it back
    ++    /*
    ++     * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
    ++     * so set to the new index which will usually have modification
    ++     * timestamp info copied over.
    ++     */
    ++    o->unpack_opts.src_index = &the_index;
          cache_tree_free(&active_cache_tree);
          return rc;
      }
    @@ -66,10 +71,10 @@
     +static int was_dirty(struct merge_options *o, const char *path)
     +{
     +    struct cache_entry *ce;
    -+
     +    int dirty = 1;
    ++
     +    if (o->call_depth || !was_tracked(path))
    -+      return !dirty;
    ++        return !dirty;
     +
     +    ce = cache_file_exists(path, strlen(path), ignore_case);
     +    dirty = (ce->ce_stat_data.sd_mtime.sec > 0 &&
    @@ -103,18 +108,17 @@

     +static int conflict_rename_normal(struct merge_options *o,
     +                  const char *path,
    -+                  struct object_id *o_oid, unsigned o_mode,
    -+                  struct object_id *a_oid, unsigned a_mode,
    -+                  struct object_id *b_oid, unsigned b_mode,
    ++                  struct object_id *o_oid, unsigned int o_mode,
    ++                  struct object_id *a_oid, unsigned int a_mode,
    ++                  struct object_id *b_oid, unsigned int b_mode,
     +                  struct rename_conflict_info *ci)
     +{
     +    int clean_merge;
     +    int file_in_the_way = 0;
     +
     +    if (was_dirty(o, path)) {
    -+            file_in_the_way = 1;
    -+            output(o, 1, _("Refusing to lose dirty file at %s"),
    -+                   path);
    ++        file_in_the_way = 1;
    ++        output(o, 1, _("Refusing to lose dirty file at %s"), path);
     +    }
     +
     +    /* Merge the content and write it out */
    @@ -201,13 +205,13 @@
     --- a/t/t6043-merge-rename-directories.sh
     +++ b/t/t6043-merge-rename-directories.sh
     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '11a-check: Avoid losing dirty contents with
simple rename' '
     +test_expect_success '11a-check: Avoid losing dirty contents with
simple rename' '
    -     git checkout B^0 &&
    -     echo stuff >>z/c &&
    +     (
    +         cd 11a &&


     diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
30: 2a68d42ff9 ! 30: feb4781c7a merge-recursive: fix remaining
directory rename + dirty overwrite cases
    @@ -1,6 +1,6 @@
     Author: Elijah Newren <newren@gmail.com>

    -    merge-recursive: Fix remaining directory rename + dirty overwrite cases
    +    merge-recursive: fix remaining directory rename + dirty overwrite cases

         Signed-off-by: Elijah Newren <newren@gmail.com>

    @@ -70,38 +70,38 @@
     --- a/t/t6043-merge-rename-directories.sh
     +++ b/t/t6043-merge-rename-directories.sh
     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '11b-check: Avoid losing dirty file involved
in directory rename' '
     +test_expect_success '11b-check: Avoid losing dirty file involved
in directory rename' '
    -     git checkout B^0 &&
    -     echo stuff >>z/c &&
    +     (
    +         cd 11b &&

     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '11d-check: Avoid losing not-uptodate with
rename + D/F conflict' '
     +test_expect_success '11d-check: Avoid losing not-uptodate with
rename + D/F conflict' '
    -     git checkout B^0 &&
    -     echo stuff >>z/c &&
    +     (
    +         cd 11d &&

     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '11e-check: Avoid deleting not-uptodate with
dir rename/rename(1to2)/add' '
     +test_expect_success '11e-check: Avoid deleting not-uptodate with
dir rename/rename(1to2)/add' '
    -     git checkout B^0 &&
    -     echo mods >>y/c &&
    +     (
    +         cd 11e &&

     @@
    -     git commit -m "C"
    +     )
      '

     -test_expect_failure '11f-check: Avoid deleting not-uptodate with
dir rename/rename(2to1)' '
     +test_expect_success '11f-check: Avoid deleting not-uptodate with
dir rename/rename(2to1)' '
    -     git checkout B^0 &&
    -     echo important >>y/wham &&
    +     (
    +         cd 11f &&

--:  ------- > 31: 29975384e0 directory rename detection: new
testcases showcasing a pair of bugs
--:  ------- > 32: b084ea16ac merge-recursive: avoid spurious
rename/rename conflict from dir renames
--:  ------- > 33: 62ce55426d merge-recursive: ensure we write updates
for directory-renamed file
