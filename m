Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B551F404
	for <e@80x24.org>; Sat, 15 Sep 2018 00:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeIOF6I (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 01:58:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44120 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeIOF6I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 01:58:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id 36-v6so6251204oth.11
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 17:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=abpvxrXXmQd9/6WQtDjalUqKyJMV7etRnkfKbyUZI2s=;
        b=sai1I4ajgPVQaxP7FfXHkwd2RPA82T9eAHOPkK8RuR4GBUF4lwnL++98GM5x+FqTSb
         V0RuR3Is6MjQAjqD79QAWlH0izCAo/qEYdwIvHzOeJ2JuCl7YaVyAKWm7zKb2AJnp6/I
         kQ/SLxnzh5if8/wUiPCFSuQn4pQ0u+rW9DXg0uEQYKjo4A8fV/wyfL919X0n4Z4jV6IT
         AqpStZo+SxRpiBh7YhoWHV5D8IfF9VwGS1wblnjm1IoFNTEk0jiSi1Nl+o4Tc1EXXJnc
         cA+rOKA9H95STE1Rv7a9WJqOniX/gQaWLV8KgOsl76GvbsaVlO04va0RclmYOofC+tR9
         2IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=abpvxrXXmQd9/6WQtDjalUqKyJMV7etRnkfKbyUZI2s=;
        b=MSdGHc+Y2dNZi7uU4nT9zIfrnSNNb3SwCFZgUrtyoGHsVo/l1fYOP4G1jna3a3kMQw
         VGqLjSMGSYD7c5izuYecZ/GB8Cph89ylkF1z15xAPx7jxsGsTurCLHPzJeMSRaRM3Tvj
         V0GIN/kV6t9nwTuMm9MHXb3R/omObGMS+KQKcnbg3cFF6+ohEtW8teTu/fDmJpjXUQ3W
         14MO7HL9UTr31xexsPAetOIyhk1MwDkQSvnO0HuNW5eggFXtfVtveV6uGbI+Ga3vBm1G
         m5TGOJ3OSpQopx2Cq97TIIktUq0Bt7dqp7p1x5ZlPZLUugrN2XUUstsuoK0EUBrEgxsG
         AFOA==
X-Gm-Message-State: APzg51BZ13YNarBfGSac8S7sf+I/uNgklnh624UlUmM46l21zBlrz8zT
        sgqTwWIFBygH1ofEEXx80TSaQvQKAcfXPv3y8CVk
X-Google-Smtp-Source: ANB0VdalpJGcVG2532ytkqBkEGIKVIPxyNe6CaYrO3SaJ9OLqsj4dRfCxbvMblIqz+MXCychl4Qv54GiLhpSCXo0alo=
X-Received: by 2002:a9d:4b89:: with SMTP id k9-v6mr6226801otf.227.1536972076968;
 Fri, 14 Sep 2018 17:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536885967.git.matvore@google.com>
 <edba3791caf8bacc2f722f7874369f6776ecffe0.1536885967.git.matvore@google.com>
 <xmqqr2hwasgv.fsf@gitster-ct.c.googlers.com> <xmqqmuskas3a.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuskas3a.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 14 Sep 2018 17:41:04 -0700
Message-ID: <CAMfpvhLLd+rC+vD4Sj-ojRGS6_GF84PAEQt8TCVCfp4JHST+oQ@mail.gmail.com>
Subject: Re: [PATCH v8 7/7] list-objects-filter: implement filter tree:0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Break line after pipe "|", not before, and lose the backslash.  You
> > do not need to over-indent the command on the downstream of the
> > pipe, i.e.
> >
> >       awk ... |
> >       xargs -n1 git -C ... &&
> >
> > Same comment applies elsewhere in this patch, not limited to this file.
> >
> >> +    sort fetched_types -u >unique_types.observed &&
> >
> > Make it a habit not to add dashed options after real arguments, i.e.
> >
> >       sort -u fetched_types
> >
Done. I'm not sure why I made this mistake, since I usually prefer to
order flags before positional args. I didn't actually clean this up in
existing code as I did other mistakes, since it is very hard to find
and do thoroughly.

> >> +    echo commit >unique_types.expected &&
> >> +    test_cmp unique_types.observed unique_types.expected &&
> >
> > Always compare "expect" with "actual", not in the reverse order, i.e.
> >
> >       test_cmp expect actual
> >
> > not
> >
> >       test_cmp actual expect
> >
Done.

> > This is important because test_cmp reports failures by showing you
> > an output of "diff expect actual" and from "sh t5616-part*.sh -v"
> > you can see what additional/excess things were produced by the test
> > over what is expected, prefixed with "+", and what your code failed
> > to produce are shown prefixed with "-".
Hmm... I didn't know aout the -v flag. That's quite good to know, thanks!

>
> I notice that patches to other files like 6112 in this series also
> spread the above mistakes from existing lines.  Please do not view
> what you see in these two test scripts before you start touching as
> a good example to follow---rather, treat them as antipattern X-<.
> 5616 is not as bad as 6112, but they both need to be cleaned up.
>
> We could alternatively do a post clean-up, but ideally we should
> first have a clean-up patch before this series to co.

I cleaned up existing tests in a new patchset here:
https://public-inbox.org/git/cover.1536969438.git.matvore@google.com/T/#t
- that new patch corrects the pipe placement and test_cmp argument
ordering.

There is no dependency between this patchset and the new one, though I
assume you want to commit the clean-up once first so maintain
consistency.

Here is an interdiff for this particular patch series (I replaced \t
with 8 spaces so it would be readable after my mail client mangles
it):

diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 14f251de4..e8da2e858 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -30,7 +30,6 @@ static int gently_parse_list_objects_filter(

         if (filter_options->choice) {
                 if (errbuf) {
-                        strbuf_init(errbuf, 0);
                         strbuf_addstr(
                                 errbuf,
                                 _("multiple filter-specs cannot be combined"));
@@ -54,7 +53,6 @@ static int gently_parse_list_objects_filter(
                 unsigned long depth;
                 if (!git_parse_ulong(v0, &depth) || depth != 0) {
                         if (errbuf) {
-                                strbuf_init(errbuf, 0);
                                 strbuf_addstr(
                                         errbuf,
                                         _("only 'tree:0' is supported"));
@@ -85,10 +83,9 @@ static int gently_parse_list_objects_filter(
                 return 0;
         }

-        if (errbuf) {
-                strbuf_init(errbuf, 0);
+        if (errbuf)
                 strbuf_addf(errbuf, "invalid filter-spec '%s'", arg);
-        }
+
         memset(filter_options, 0, sizeof(*filter_options));
         return 1;
 }
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index f02b9ae37..5bc5b4445 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -216,7 +216,7 @@ test_expect_success 'missing non-root tree object
and rev-list' '
         rm -rf repo &&
         test_create_repo repo &&
         mkdir repo/dir &&
-        echo foo > repo/dir/foo &&
+        echo foo >repo/dir/foo &&
         git -C repo add dir/foo &&
         git -C repo commit -m "commit dir/foo" &&

diff --git a/t/t5317-pack-objects-filter-objects.sh
b/t/t5317-pack-objects-filter-objects.sh
index 7a4d49ea1..510d3537f 100755
--- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -61,7 +61,7 @@ test_expect_success 'verify normal and blob:none
packfiles have same commits/tre

 test_expect_success 'get an error for missing tree object' '
         git init r5 &&
-        echo foo > r5/foo &&
+        echo foo >r5/foo &&
         git -C r5 add foo &&
         git -C r5 commit -m "foo" &&
         del=$(git -C r5 rev-parse HEAD^{tree} | sed "s|..|&/|") &&
@@ -97,7 +97,7 @@ test_expect_success 'grab tree directly when using tree:0' '
         git -C r1 verify-pack -v ../commitsonly.pack >objs &&
         awk "/tree|blob/{print \$1}" objs >trees_and_blobs &&
         git -C r1 rev-parse HEAD: >expected &&
-        test_cmp trees_and_blobs expected
+        test_cmp expected trees_and_blobs
 '

 # Test blob:limit=<n>[kmg] filter.
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8eeb85fbc..7b6294ca5 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -169,11 +169,12 @@ test_expect_success 'use fsck before and after
manually fetching a missing subtr

         # Make sure we only have commits, and all trees and blobs are missing.
         git -C dst rev-list master --missing=allow-any --objects
>fetched_objects &&
-        awk -f print_1.awk fetched_objects \
-                | xargs -n1 git -C dst cat-file -t >fetched_types &&
-        sort fetched_types -u >unique_types.observed &&
+        awk -f print_1.awk fetched_objects |
+        xargs -n1 git -C dst cat-file -t >fetched_types &&
+
+        sort -u fetched_types >unique_types.observed &&
         echo commit >unique_types.expected &&
-        test_cmp unique_types.observed unique_types.expected &&
+        test_cmp unique_types.expected unique_types.observed &&

         # Auto-fetch a tree with cat-file.
         git -C dst cat-file -p $SUBTREE >tree_contents &&
@@ -185,11 +186,13 @@ test_expect_success 'use fsck before and after
manually fetching a missing subtr
         # Auto-fetch all remaining trees and blobs with --missing=error
         git -C dst rev-list master --missing=error --objects
>fetched_objects &&
         test_line_count = 70 fetched_objects &&
-        awk -f print_1.awk fetched_objects \
-                | xargs -n1 git -C dst cat-file -t >fetched_types &&
-        sort fetched_types -u >unique_types.observed &&
+
+        awk -f print_1.awk fetched_objects |
+        xargs -n1 git -C dst cat-file -t >fetched_types &&
+
+        sort -u fetched_types >unique_types.observed &&
         printf "blob\ncommit\ntree\n" >unique_types.expected &&
-        test_cmp unique_types.observed unique_types.expected
+        test_cmp unique_types.expected unique_types.observed
 '

 test_expect_success 'partial clone fetches blobs pointed to by refs
even if normally filtered out' '
diff --git a/t/t6112-rev-list-filters-objects.sh
b/t/t6112-rev-list-filters-objects.sh
index a989a7082..6e5c41a68 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -31,11 +31,13 @@ test_expect_success 'verify blob:none omits all 5 blobs' '
 '

 test_expect_success 'specify blob explicitly prevents filtering' '
-        file_3=$(git -C r1 ls-files -s file.3 \
-                | awk -f print_2.awk) &&
-        file_4=$(git -C r1 ls-files -s file.4 \
-                | awk -f print_2.awk) &&
-        git -C r1 rev-list HEAD --objects --filter=blob:none HEAD
$file_3 >observed &&
+        file_3=$(git -C r1 ls-files -s file.3 |
+                 awk -f print_2.awk) &&
+
+        file_4=$(git -C r1 ls-files -s file.4 |
+                 awk -f print_2.awk) &&
+
+        git -C r1 rev-list --objects --filter=blob:none HEAD $file_3
>observed &&
         grep -q "$file_3" observed &&
         test_must_fail grep -q "$file_4" observed
 '
@@ -225,13 +227,14 @@ test_expect_success 'rev-list W/ --missing=print
and --missing=allow-any for tre
 # Test tree:0 filter.

 test_expect_success 'verify tree:0 includes trees in "filtered" output' '
-        git -C r3 rev-list HEAD --quiet --objects
--filter-print-omitted --filter=tree:0 \
-                | awk -f print_1.awk \
-                | sed s/~// \
-                | xargs -n1 git -C r3 cat-file -t \
-                | sort -u >filtered_types &&
-        printf "blob\ntree\n" > expected &&
-        test_cmp filtered_types expected
+        git -C r3 rev-list HEAD --quiet --objects
--filter-print-omitted --filter=tree:0 |
+        awk -f print_1.awk |
+        sed s/~// |
+        xargs -n1 git -C r3 cat-file -t |
+        sort -u >filtered_types &&
+
+        printf "blob\ntree\n" >expected &&
+        test_cmp expected filtered_types
 '

 # Delete some loose objects and use rev-list, but WITHOUT any filtering.
