Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5801F517
	for <e@80x24.org>; Mon,  4 Jun 2018 17:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750997AbeFDRC7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 13:02:59 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36927 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDRC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 13:02:58 -0400
Received: by mail-qt0-f173.google.com with SMTP id q13-v6so41310338qtp.4
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 10:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Jp0Z7kheJ6pbW3g9Sb0H0Wbl0wfP5FDQAoaHnrRFO/M=;
        b=DIRlN9e0UenZnaJiUsG5GQqgLoUTOBs0iKZhPFyoSAMSlGwVBKKbJo6RMAujorpu6p
         Pu4tjsmOPi6KqBNBPQjyv5pFM3Iu7VXZggm9FSJBr7bg3GmBDQTc0Sd51N33S/u1rQy7
         2Z9RenI4H4Brs3oplSoaHkz6KCe4dPswrWh0YZj2xU7llfipbFPZxGYp3gX9GBQV06v1
         lqwQTYfSN72RWbWxHle3izeTGA3X8VjBHMTKlwQFCBKqEKdB2QXOoboUu63oJjUKyqQ9
         wAL7mo6ly5BS5pciYDpGd4p4X3q/Xk7F8wcl5bCaG6kxeL40DjKyz9MNgyqoFGlItDUP
         ssDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Jp0Z7kheJ6pbW3g9Sb0H0Wbl0wfP5FDQAoaHnrRFO/M=;
        b=rVOSISWCCFQ0n3541RCWhGC/bjZOvuwDu3UsrXYvKHLMXJs1Fu/bnJGy836c2XnaRZ
         ClxuiL74Lug64swgwDRjlmtbK5xlSLcCnUq6EdjUI8lA7TxEUoe7D7ln6pGqP5kvqeFY
         D32yVt3cPD8DLp2fLkS42G4UQKTR8EiTEVg6bK2cHoCwidzOFqdnEf20ZJByQYdnR0lW
         +0tMjbDds74WJiWiK4e9pUJdvcogu8EjFwA05kPaSrU9hIHjKiXguG8YoirLxl2XoIVZ
         At/NQ8L6oTLlS3fsYIA0YvJ0DM4JRI5JrvVmT+iUnTolTsXiY6C2EHMqzc3FBoV59gwE
         NY5A==
X-Gm-Message-State: ALKqPwfIwJFgei1SFLTAkFXpbCzXZHkcmGGT7aCTEmq5Eu8gqKd1p1Ri
        M4VS9s4RvZfQOeeQ1mZJRJo=
X-Google-Smtp-Source: ADUXVKK5Ly0pBWOqQKnTMLO0tKJcTPwGiOkH4E9nqK1Jdmn7P/7YqWbqc6wmHxyxONTqLl7XtJ7c6g==
X-Received: by 2002:a0c:d06b:: with SMTP id d40-v6mr20892649qvh.213.1528131777340;
        Mon, 04 Jun 2018 10:02:57 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:6990:e1e1:697d:a15? ([2001:4898:8010:0:52c6:e1e1:697d:a15])
        by smtp.gmail.com with ESMTPSA id h3-v6sm33960043qkf.86.2018.06.04.10.02.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jun 2018 10:02:56 -0700 (PDT)
Subject: Re: [PATCH v4 00/21] Integrate commit-graph into 'fsck' and 'gc'
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5d8dd51f-db7c-9da6-c21b-6e537251eddc@gmail.com>
Date:   Mon, 4 Jun 2018 13:02:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry I forgot to --in-reply-to the previous version [1]

[1] 
https://public-inbox.org/git/20180524162504.158394-1-dstolee@microsoft.com/T/#u

On 6/4/2018 12:52 PM, Derrick Stolee wrote:
> Thanks for the feedback on v3. There were several small cleanups, but
> perhaps the biggest change is the addition of "commit-graph: use
> string-list API for input" which makes "commit-graph: add '--reachable'
> option" much simpler.
>
> The inter-diff is still reasonably large, but I'll send it in a
> follow-up PR.

s/PR/message

Here is that diff:


diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9a3abd87e7..d2eb3c8e9b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -900,7 +900,8 @@ the `GIT_NOTES_REF` environment variable.  See 
linkgit:git-notes[1].

  core.commitGraph::
         Enable git commit graph feature. Allows reading from the
-       commit-graph file.
+       commit-graph file. See `gc.commitGraph` for automatically
+       maintaining the file.

  core.sparseCheckout::
         Enable "sparse checkout" feature. See section "Sparse checkout" in
@@ -1554,10 +1555,11 @@ gc.autoDetach::
         if the system supports it. Default is true.

  gc.commitGraph::
-       If true, then gc will rewrite the commit-graph file after any
-       change to the object database. If '--auto' is used, then the
-       commit-graph will not be updated unless the threshold is met.
-       See linkgit:git-commit-graph[1] for details.
+       If true, then gc will rewrite the commit-graph file when
+       linkgit:git-gc[1] is run. When using linkgit:git-gc[1]
+       '--auto' the commit-graph will be updated if housekeeping is
+       required. Default is false. See linkgit:git-commit-graph[1]
+       for details.

  gc.logExpiry::
         If the file gc.log exists, then `git gc --auto` won't run
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 17dd654a59..a6526b3592 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -119,9 +119,9 @@ The optional configuration variable `gc.packRefs` 
determines if
  it within all non-bare repos or it can be set to a boolean value.
  This defaults to true.

-The optional configuration variable 'gc.commitGraph' determines if
-'git gc' runs 'git commit-graph write'. This can be set to a boolean
-value. This defaults to false.
+The optional configuration variable `gc.commitGraph` determines if
+'git gc' should run 'git commit-graph write'. This can be set to a
+boolean value. This defaults to false.

  The optional configuration variable `gc.aggressiveWindow` controls how
  much time is spent optimizing the delta compression of the objects in
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 20ce6437ae..76423b3fa5 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -39,7 +39,7 @@ static struct opts_commit_graph {

  static int graph_verify(int argc, const char **argv)
  {
-       struct commit_graph *graph = 0;
+       struct commit_graph *graph = NULL;
         char *graph_name;

         static struct option builtin_commit_graph_verify_options[] = {
@@ -119,13 +119,9 @@ static int graph_read(int argc, const char **argv)

  static int graph_write(int argc, const char **argv)
  {
-       const char **pack_indexes = NULL;
-       int packs_nr = 0;
-       const char **commit_hex = NULL;
-       int commits_nr = 0;
-       const char **lines = NULL;
-       int lines_nr = 0;
-       int lines_alloc = 0;
+       struct string_list *pack_indexes = NULL;
+       struct string_list *commit_hex = NULL;
+       struct string_list lines;

         static struct option builtin_commit_graph_write_options[] = {
                 OPT_STRING(0, "object-dir", &opts.obj_dir,
@@ -158,32 +154,23 @@ static int graph_write(int argc, const char **argv)

         if (opts.stdin_packs || opts.stdin_commits) {
                 struct strbuf buf = STRBUF_INIT;
-               lines_nr = 0;
-               lines_alloc = 128;
-               ALLOC_ARRAY(lines, lines_alloc);
-
-               while (strbuf_getline(&buf, stdin) != EOF) {
-                       ALLOC_GROW(lines, lines_nr + 1, lines_alloc);
-                       lines[lines_nr++] = strbuf_detach(&buf, NULL);
-               }
-
-               if (opts.stdin_packs) {
-                       pack_indexes = lines;
-                       packs_nr = lines_nr;
-               }
-               if (opts.stdin_commits) {
-                       commit_hex = lines;
-                       commits_nr = lines_nr;
-               }
+               string_list_init(&lines, 0);
+
+               while (strbuf_getline(&buf, stdin) != EOF)
+                       string_list_append(&lines, strbuf_detach(&buf, 
NULL));
+
+               if (opts.stdin_packs)
+                       pack_indexes = &lines;
+               if (opts.stdin_commits)
+                       commit_hex = &lines;
         }

         write_commit_graph(opts.obj_dir,
                            pack_indexes,
-                          packs_nr,
                            commit_hex,
-                          commits_nr,
                            opts.append);

+       string_list_clear(&lines, 0);
         return 0;
  }

@@ -207,10 +194,10 @@ int cmd_commit_graph(int argc, const char **argv, 
const char *prefix)
                              PARSE_OPT_STOP_AT_NON_OPTION);

         if (argc > 0) {
-               if (!strcmp(argv[0], "verify"))
-                       return graph_verify(argc, argv);
                 if (!strcmp(argv[0], "read"))
                         return graph_read(argc, argv);
+               if (!strcmp(argv[0], "verify"))
+                       return graph_verify(argc, argv);
                 if (!strcmp(argv[0], "write"))
                         return graph_write(argc, argv);
         }
diff --git a/commit-graph.c b/commit-graph.c
index 057d734926..946bcfa98c 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,5 +1,6 @@
  #include "cache.h"
  #include "config.h"
+#include "dir.h"
  #include "git-compat-util.h"
  #include "lockfile.h"
  #include "pack.h"
@@ -652,42 +653,26 @@ static void compute_generation_numbers(struct 
packed_commit_list* commits)
         }
  }

-struct hex_list {
-       char **hex_strs;
-       int hex_nr;
-       int hex_alloc;
-};
-
  static int add_ref_to_list(const char *refname,
                            const struct object_id *oid,
                            int flags, void *cb_data)
  {
-       struct hex_list *list = (struct hex_list*)cb_data;
-
-       ALLOC_GROW(list->hex_strs, list->hex_nr + 1, list->hex_alloc);
-       list->hex_strs[list->hex_nr] = xcalloc(GIT_MAX_HEXSZ + 1, 1);
-       strcpy(list->hex_strs[list->hex_nr], oid_to_hex(oid));
-       list->hex_nr++;
+       struct string_list *list = (struct string_list*)cb_data;
+       string_list_append(list, oid_to_hex(oid));
         return 0;
  }

  void write_commit_graph_reachable(const char *obj_dir, int append)
  {
-       struct hex_list list;
-       list.hex_nr = 0;
-       list.hex_alloc = 128;
-       ALLOC_ARRAY(list.hex_strs, list.hex_alloc);
-
+       struct string_list list;
+       string_list_init(&list, 1);
         for_each_ref(add_ref_to_list, &list);
-
-       write_commit_graph(obj_dir, NULL, 0, (const char 
**)list.hex_strs, list.hex_nr, append);
+       write_commit_graph(obj_dir, NULL, &list, append);
  }

  void write_commit_graph(const char *obj_dir,
-                       const char **pack_indexes,
-                       int nr_packs,
-                       const char **commit_hex,
-                       int nr_commits,
+                       struct string_list *pack_indexes,
+                       struct string_list *commit_hex,
                         int append)
  {
         struct packed_oid_list oids;
@@ -695,7 +680,6 @@ void write_commit_graph(const char *obj_dir,
         struct hashfile *f;
         uint32_t i, count_distinct = 0;
         char *graph_name;
-       int fd;
         struct lock_file lk = LOCK_INIT;
         uint32_t chunk_ids[5];
         uint64_t chunk_offsets[5];
@@ -729,10 +713,10 @@ void write_commit_graph(const char *obj_dir,
                 int dirlen;
                 strbuf_addf(&packname, "%s/pack/", obj_dir);
                 dirlen = packname.len;
-               for (i = 0; i < nr_packs; i++) {
+               for (i = 0; i < pack_indexes->nr; i++) {
                         struct packed_git *p;
                         strbuf_setlen(&packname, dirlen);
-                       strbuf_addstr(&packname, pack_indexes[i]);
+                       strbuf_addstr(&packname, 
pack_indexes->items[i].string);
                         p = add_packed_git(packname.buf, packname.len, 1);
                         if (!p)
                                 die("error adding pack %s", packname.buf);
@@ -745,12 +729,13 @@ void write_commit_graph(const char *obj_dir,
         }

         if (commit_hex) {
-               for (i = 0; i < nr_commits; i++) {
+               for (i = 0; i < commit_hex->nr; i++) {
                         const char *end;
                         struct object_id oid;
                         struct commit *result;

-                       if (commit_hex[i] && 
parse_oid_hex(commit_hex[i], &oid, &end))
+                       if (commit_hex->items[i].string &&
+ parse_oid_hex(commit_hex->items[i].string, &oid, &end))
                                 continue;

                         result = lookup_commit_reference_gently(&oid, 1);
@@ -809,23 +794,11 @@ void write_commit_graph(const char *obj_dir,
         compute_generation_numbers(&commits);

         graph_name = get_commit_graph_filename(obj_dir);
-       fd = hold_lock_file_for_update(&lk, graph_name, 0);
-
-       if (fd < 0) {
-               struct strbuf folder = STRBUF_INIT;
-               strbuf_addstr(&folder, graph_name);
-               strbuf_setlen(&folder, strrchr(folder.buf, '/') - 
folder.buf);
-
-               if (mkdir(folder.buf, 0777) < 0)
-                       die_errno(_("cannot mkdir %s"), folder.buf);
-               strbuf_release(&folder);
-
-               fd = hold_lock_file_for_update(&lk, graph_name, 
LOCK_DIE_ON_ERROR);
-
-               if (fd < 0)
-                       die_errno("unable to create '%s'", graph_name);
-       }
+       if (safe_create_leading_directories(graph_name))
+               die_errno(_("unable to create leading directories of %s"),
+                         graph_name);

+       hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
         f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);

         hashwrite_be32(f, GRAPH_SIGNATURE);
@@ -879,21 +852,22 @@ static int verify_commit_graph_error;
  static void graph_report(const char *fmt, ...)
  {
         va_list ap;
-       struct strbuf sb = STRBUF_INIT;
         verify_commit_graph_error = 1;

         va_start(ap, fmt);
-       strbuf_vaddf(&sb, fmt, ap);
-
-       fprintf(stderr, "%s\n", sb.buf);
-       strbuf_release(&sb);
+       vfprintf(stderr, fmt, ap);
+       fprintf(stderr, "\n");
         va_end(ap);
  }

+#define GENERATION_ZERO_EXISTS 1
+#define GENERATION_NUMBER_EXISTS 2
+
  int verify_commit_graph(struct commit_graph *g)
  {
         uint32_t i, cur_fanout_pos = 0;
         struct object_id prev_oid, cur_oid, checksum;
+       int generation_zero = 0;
         struct hashfile *f;
         int devnull;

@@ -1012,6 +986,18 @@ int verify_commit_graph(struct commit_graph *g)
                         graph_report("commit-graph parent list for 
commit %s terminates early",
                                      oid_to_hex(&cur_oid));

+               if (!graph_commit->generation) {
+                       if (generation_zero == GENERATION_NUMBER_EXISTS)
+                               graph_report("commit-graph has 
generation number zero for commit %s, but non-zero elsewhere",
+ oid_to_hex(&cur_oid));
+                       generation_zero = GENERATION_ZERO_EXISTS;
+               } else if (generation_zero == GENERATION_ZERO_EXISTS)
+                       graph_report("commit-graph has non-zero 
generation number for commit %s, but zero elsewhere",
+                                    oid_to_hex(&cur_oid));
+
+               if (generation_zero == GENERATION_ZERO_EXISTS)
+                       continue;
+
                 /*
                  * If one of our parents has generation 
GENERATION_NUMBER_MAX, then
                  * our generation is also GENERATION_NUMBER_MAX. 
Decrement to avoid
diff --git a/commit-graph.h b/commit-graph.h
index 9a06a5f188..ee20f5e280 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -2,6 +2,7 @@
  #define COMMIT_GRAPH_H

  #include "git-compat-util.h"
+#include "string-list.h"

  char *get_commit_graph_filename(const char *obj_dir);

@@ -48,10 +49,8 @@ struct commit_graph *load_commit_graph_one(const char 
*graph_file);

  void write_commit_graph_reachable(const char *obj_dir, int append);
  void write_commit_graph(const char *obj_dir,
-                       const char **pack_indexes,
-                       int nr_packs,
-                       const char **commit_hex,
-                       int nr_commits,
+                       struct string_list *pack_indexes,
+                       struct string_list *commit_hex,
                         int append);

  int verify_commit_graph(struct commit_graph *g);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index d20b17586f..b24e8b6689 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -33,8 +33,8 @@ test_expect_success 'create commits and repack' '
  '

  graph_git_two_modes() {
-       git -c core.graph=true $1 >output
-       git -c core.graph=false $1 >expect
+       git -c core.commitGraph=true $1 >output
+       git -c core.commitGraph=false $1 >expect
         test_cmp output expect
  }

@@ -245,7 +245,7 @@ test_expect_success 'perform fast-forward merge in 
full repo' '
         test_cmp expect output
  '

-test_expect_success 'check that gc clears commit-graph' '
+test_expect_success 'check that gc computes commit-graph' '
         cd "$TRASH_DIRECTORY/full" &&
         git commit --allow-empty -m "blank" &&
         git commit-graph write --reachable &&
@@ -281,29 +281,29 @@ GRAPH_CHUNK_LOOKUP_OFFSET=8
  GRAPH_CHUNK_LOOKUP_WIDTH=12
  GRAPH_CHUNK_LOOKUP_ROWS=5
  GRAPH_BYTE_OID_FANOUT_ID=$GRAPH_CHUNK_LOOKUP_OFFSET
-GRAPH_BYTE_OID_LOOKUP_ID=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
-                             1 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
-GRAPH_BYTE_COMMIT_DATA_ID=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
-                               2 \* $GRAPH_CHUNK_LOOKUP_WIDTH`
-GRAPH_FANOUT_OFFSET=`expr $GRAPH_CHUNK_LOOKUP_OFFSET + \
-                         $GRAPH_CHUNK_LOOKUP_WIDTH \* 
$GRAPH_CHUNK_LOOKUP_ROWS`
-GRAPH_BYTE_FANOUT1=`expr $GRAPH_FANOUT_OFFSET + 4 \* 4`
-GRAPH_BYTE_FANOUT2=`expr $GRAPH_FANOUT_OFFSET + 4 \* 255`
-GRAPH_OID_LOOKUP_OFFSET=`expr $GRAPH_FANOUT_OFFSET + 4 \* 256`
-GRAPH_BYTE_OID_LOOKUP_ORDER=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN 
\* 8`
-GRAPH_BYTE_OID_LOOKUP_MISSING=`expr $GRAPH_OID_LOOKUP_OFFSET + 
$HASH_LEN \* 4 + 10`
-GRAPH_COMMIT_DATA_OFFSET=`expr $GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 
$NUM_COMMITS`
+GRAPH_BYTE_OID_LOOKUP_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+                           1 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_BYTE_COMMIT_DATA_ID=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+                            2 \* $GRAPH_CHUNK_LOOKUP_WIDTH))
+GRAPH_FANOUT_OFFSET=$(($GRAPH_CHUNK_LOOKUP_OFFSET + \
+                      $GRAPH_CHUNK_LOOKUP_WIDTH \* 
$GRAPH_CHUNK_LOOKUP_ROWS))
+GRAPH_BYTE_FANOUT1=$(($GRAPH_FANOUT_OFFSET + 4 \* 4))
+GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 \* 255))
+GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 \* 256))
+GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 8))
+GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN 
\* 4 + 10))
+GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN \* 
$NUM_COMMITS))
  GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
-GRAPH_BYTE_COMMIT_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN`
-GRAPH_BYTE_COMMIT_EXTRA_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + 
$HASH_LEN + 4`
-GRAPH_BYTE_COMMIT_WRONG_PARENT=`expr $GRAPH_COMMIT_DATA_OFFSET + 
$HASH_LEN + 3`
-GRAPH_BYTE_COMMIT_GENERATION=`expr $GRAPH_COMMIT_DATA_OFFSET + 
$HASH_LEN + 8`
-GRAPH_BYTE_COMMIT_DATE=`expr $GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12`
-GRAPH_COMMIT_DATA_WIDTH=`expr $HASH_LEN + 16`
-GRAPH_OCTOPUS_DATA_OFFSET=`expr $GRAPH_COMMIT_DATA_OFFSET + \
-                               $GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS`
-GRAPH_BYTE_OCTOPUS=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4`
-GRAPH_BYTE_FOOTER=`expr $GRAPH_OCTOPUS_DATA_OFFSET + 4 \* 
$NUM_OCTOPUS_EDGES`
+GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
+GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN 
+ 4))
+GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN 
+ 3))
+GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 
11))
+GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
+GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
+GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
+                            $GRAPH_COMMIT_DATA_WIDTH \* $NUM_COMMITS))
+GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
+GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 \* $NUM_OCTOPUS_EDGES))

  # usage: corrupt_graph_and_verify <position> <data> <string>
  # Manipulates the commit-graph file at the position
@@ -320,7 +320,7 @@ corrupt_graph_and_verify() {
         printf "$data" | dd of="$objdir/info/commit-graph" bs=1 
seek="$pos" conv=notrunc &&
         test_must_fail git commit-graph verify 2>test_err &&
         grep -v "^+" test_err >err
-       grep "$grepstr" err
+       test_i18ngrep "$grepstr" err
  }

  test_expect_success 'detect bad signature' '
@@ -338,9 +338,9 @@ test_expect_success 'detect bad hash version' '
                 "hash version"
  '

-test_expect_success 'detect bad chunk count' '
+test_expect_success 'detect low chunk count' '
         corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\02" \
-               "missing the Commit Data chunk"
+               "missing the .* chunk"
  '

  test_expect_success 'detect missing OID fanout chunk' '
@@ -363,7 +363,7 @@ test_expect_success 'detect incorrect fanout' '
                 "fanout value"
  '

-test_expect_success 'detect incorrect fanout' '
+test_expect_success 'detect incorrect fanout final value' '
         corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
                 "fanout value"
  '
@@ -393,14 +393,19 @@ test_expect_success 'detect extra parent int-id' '
                 "is too long"
  '

-test_expect_success 'detect incorrect tree OID' '
+test_expect_success 'detect wrong parent' '
         corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_WRONG_PARENT "\01" \
                 "commit-graph parent for"
  '

+test_expect_success 'detect incorrect generation number' '
+       corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\070" \
+               "generation for commit"
+'
+
  test_expect_success 'detect incorrect generation number' '
         corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-               "generation"
+               "non-zero generation number"
  '

  test_expect_success 'detect incorrect commit date' '

