Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671921F424
	for <e@80x24.org>; Wed, 25 Apr 2018 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbeDYOkN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 10:40:13 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:41757 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754703AbeDYOkK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 10:40:10 -0400
Received: by mail-qt0-f176.google.com with SMTP id d3-v6so27092866qth.8
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jjSaiVR2fZyuuyPQJ3e+HZRm9UcVTnVPSmxJ21HOItw=;
        b=M1mUQ596RIXW2lP7cZvlt6SGDCkUxcyiAZvC9EhMOAZlaCSmR62uxoaFOzX49R+xF+
         Cz0nc4KUbMmv6eJi2VUP4cH8KHf4OxoNnOYkaG8zgAme0F44puAWc5Y2IoGlBAKERR9M
         g6vBcT6P8fl6J64c1Jji+cS9VuXDTpGIVgcr8tpRX42OlZPkjNpXDu3AZ3A4C/RhQxp9
         kBSr8L1wC6Df+1OTaty5oWFqjsCS70nEL2QNbyq8TEaCxWjmxXnBg7S12loWh8GfBGZb
         4PSd4K8ybD83bNJDZdjWZ/DrwszeItcQQG1vgR7CZBcOziY+tcKugtRK7nt04lgeV0mH
         sAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jjSaiVR2fZyuuyPQJ3e+HZRm9UcVTnVPSmxJ21HOItw=;
        b=ZDE7qwecKwtoTvnOEeVk6zeVKbe00qFoXzX1vag0h5nyt5b4P1bqqilL3/CsNJrG+Y
         CxX7KdET/XYUWvY6w1Ecfg77820utM5JiHLSZNQS9M3m2B3oRhIsjm3SeJgMUF+KvDHp
         oh02i+ep+yXRfLswfH90b0M7s7JzNFRrGm6Op8ysDeKop2nhqiOd4JAGyGL7f3kKJ8F3
         YEJDg1OkJ9rCH0eihIgPLvKeRqTdZ4AHUCgRX9CAGn1R8siaIDQfs77WW2w1suuXaKwh
         kSzP2/pIkUd1TLiwEQFt8NsoxrSYW0LHz3qBPgdr6h5YQyFTqbqRZcgK8HyajRVpI4lO
         RQQA==
X-Gm-Message-State: ALQs6tB+oBobwgSLn0IQ64pS2zrSOuTK5x7sPY7LsoaGNnFiWUWzcSe9
        JPDepVUEeNPd+uMMPWiJfbE=
X-Google-Smtp-Source: AB8JxZo9HSRT2A+HaHB7/h7tS0i6kify5dwKgLNoomOlHlChLVgUWTKfeelo/N7ZKoOVebI58WTTqQ==
X-Received: by 10.12.191.170 with SMTP id s39mr8151109qvj.185.1524667209224;
        Wed, 25 Apr 2018 07:40:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u50-v6sm1623955qth.0.2018.04.25.07.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 07:40:08 -0700 (PDT)
Subject: Re: [PATCH v4 00/10] Compute and consume generation numbers
To:     Derrick Stolee <dstolee@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "peff@peff.net" <peff@peff.net>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>
References: <20180417170001.138464-1-dstolee@microsoft.com>
 <20180425143735.240183-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <527a8d47-15d4-78a1-4320-97ddc27bce48@gmail.com>
Date:   Wed, 25 Apr 2018 10:40:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425143735.240183-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As promised, here is the diff from v3.

Thanks,
-Stolee

-- >8 --

diff --git a/builtin/merge.c b/builtin/merge.c
index 7e1da6c6ea..b819756946 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1148,6 +1148,7 @@ int cmd_merge(int argc, const char **argv, const 
char *prefix)
         branch = branch_to_free = resolve_refdup("HEAD", 0, &head_oid, 
NULL);
         if (branch)
                 skip_prefix(branch, "refs/heads/", &branch);
+
         init_diff_ui_defaults();
         git_config(git_merge_config, NULL);

@@ -1156,7 +1157,6 @@ int cmd_merge(int argc, const char **argv, const 
char *prefix)
         else
                 head_commit = lookup_commit_or_die(&head_oid, "HEAD");

-
         if (branch_mergeoptions)
                 parse_branch_merge_options(branch_mergeoptions);
         argc = parse_options(argc, argv, prefix, builtin_merge_options,
diff --git a/commit-graph.c b/commit-graph.c
index 21e853c21a..aebd242def 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -257,7 +257,7 @@ static int fill_commit_in_graph(struct commit *item, 
struct commit_graph *g, uin
         uint32_t *parent_data_ptr;
         uint64_t date_low, date_high;
         struct commit_list **pptr;
-       const unsigned char *commit_data = g->chunk_commit_data + 
GRAPH_DATA_WIDTH * pos;
+       const unsigned char *commit_data = g->chunk_commit_data + 
(g->hash_len + 16) * pos;

         item->object.parsed = 1;
         item->graph_pos = pos;
@@ -304,7 +304,7 @@ static int find_commit_in_graph(struct commit *item, 
struct commit_graph *g, uin
                 *pos = item->graph_pos;
                 return 1;
         } else {
-               return bsearch_graph(commit_graph, &(item->object.oid), 
pos);
+               return bsearch_graph(g, &(item->object.oid), pos);
         }
  }

@@ -312,10 +312,10 @@ int parse_commit_in_graph(struct commit *item)
  {
         uint32_t pos;

-       if (item->object.parsed)
-               return 0;
         if (!core_commit_graph)
                 return 0;
+       if (item->object.parsed)
+               return 1;
         prepare_commit_graph();
         if (commit_graph && find_commit_in_graph(item, commit_graph, &pos))
                 return fill_commit_in_graph(item, commit_graph, pos);
@@ -454,9 +454,8 @@ static void write_graph_chunk_data(struct hashfile 
*f, int hash_len,
                 else
                         packedDate[0] = 0;

-               if ((*list)->generation != GENERATION_NUMBER_INFINITY) {
+               if ((*list)->generation != GENERATION_NUMBER_INFINITY)
                         packedDate[0] |= htonl((*list)->generation << 2);
-               }

                 packedDate[1] = htonl((*list)->date);
                 hashwrite(f, packedDate, 8);
diff --git a/commit.c b/commit.c
index 9ef6f699bd..e2e16ea1a7 100644
--- a/commit.c
+++ b/commit.c
@@ -653,7 +653,7 @@ int compare_commits_by_gen_then_commit_date(const 
void *a_, const void *b_, void
         else if (a->generation > b->generation)
                 return -1;

-       /* use date as a heuristic when generataions are equal */
+       /* use date as a heuristic when generations are equal */
         if (a->date < b->date)
                 return 1;
         else if (a->date > b->date)
@@ -1078,7 +1078,7 @@ int in_merge_bases_many(struct commit *commit, int 
nr_reference, struct commit *
         }

         if (commit->generation > min_generation)
-               return 0;
+               return ret;

         bases = paint_down_to_common(commit, nr_reference, reference, 
commit->generation);
         if (commit->object.flags & PARENT2)
diff --git a/ref-filter.c b/ref-filter.c
index e2fea6d635..fb35067fc9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,7 @@
  #include "trailer.h"
  #include "wt-status.h"
  #include "commit-slab.h"
+#include "commit-graph.h"

  static struct ref_msg {
         const char *gone;
@@ -1582,7 +1583,7 @@ static int in_commit_list(const struct commit_list 
*want, struct commit *c)
  }

  /*
- * Test whether the candidate or one of its parents is contained in the 
list.
+ * Test whether the candidate is contained in the list.
   * Do not recurse to find out, though, but return -1 if inconclusive.
   */
  static enum contains_result contains_test(struct commit *candidate,
@@ -1629,7 +1630,7 @@ static enum contains_result 
contains_tag_algo(struct commit *candidate,

         for (p = want; p; p = p->next) {
                 struct commit *c = p->item;
-               parse_commit_or_die(c);
+               load_commit_graph_info(c);
                 if (c->generation < cutoff)
                         cutoff = c->generation;
         }


