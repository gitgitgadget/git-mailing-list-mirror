Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54D051F453
	for <e@80x24.org>; Fri, 21 Sep 2018 20:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391584AbeIVBvw (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 21:51:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42730 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391089AbeIVBvv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 21:51:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id z8-v6so2947569qto.9
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=azm2GEOTJYPxLjcwFC0e2O7FdbpG6r2gpbhIiHhyD48=;
        b=dig8zuddoNzyMVW4u8y1nSJewfgExFPXzkxcVntqvWfyf8Dqx3iC5BDz30VnuRyxYw
         UJr+R0hwQ27zbBH3Yrrhp5fDJyfeN0t8cJoQfZ9y48Z7P2CTohkZwxwnajNKeZ9L+sVr
         8dTn2L2P2ZcYvcHoRE2PdADvLTMmYM6EsjqBQ1dlEZetjbHYZ2gXVCGbtHjB8u12S9xg
         5Qv06VoaiDy1qVUsDT+0Df2FKbdQNbrASyVsWGj4lLrwutkYbOCrhlENXUZvBk/r+7Qx
         cTvK60ECq9//E5LRTcBm5OEnw1BbLS/yg9kXtEk8FH91UxBipDMdAAR7vkXc21ljHqtk
         5+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=azm2GEOTJYPxLjcwFC0e2O7FdbpG6r2gpbhIiHhyD48=;
        b=CzvuejLOjLwjBs3gP+xQueLve8/Q9RRN8shfWV6hZPCMU+xQpfF965Jh8/Fh34JQqt
         NRUMJo9FMPe7XIN7KnhrXcBdOI/B0Wleq6fCZuwjGEM7Rv1WDTkguiDquJa2uzrQelPw
         4T5a9lWksexzVngvOo30n+inLkHQCqmpnzBD8xvhi5wfuB+tE+9gBBRDh0HNLW6cNqBK
         RuCq/1Eh4z9vEz2lgjTfBFR6U3PpIBAGrD9A2gBam45uMmcVNkGJ6SdxRAsaHpeVs7TR
         C8zY5/uvPjiyM+pvy6NIhhA2A0nGpdaQc2aIlGTSSbVbytnGGMHsS9QiYTvdrdsuH+4x
         FfqA==
X-Gm-Message-State: APzg51DLeZrbyTCB0kqwmchkD6FiEkXtflLDipwEPZ7p+T6DJsQzx2Iq
        VRCqg9eHoupsbFVfiiyh4/4=
X-Google-Smtp-Source: ANB0Vdb4jBqafXFCFRJXvB0h3qruSGwqgpdHG9D4PKyY5HdyKJPMTDOuzLy0EttpH6kTY36SoyQoVw==
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr33873381qtb.75.1537560086127;
        Fri, 21 Sep 2018 13:01:26 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id l49-v6sm5425149qta.45.2018.09.21.13.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:01:25 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] commit-graph write: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180907182954.2413-2-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <60aae3d6-35b2-94fb-afd7-6978e935a4f7@gmail.com>
Date:   Fri, 21 Sep 2018 16:01:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180907182954.2413-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2018 2:29 PM, Ævar Arnfjörð Bjarmason wrote:
> -void write_commit_graph_reachable(const char *obj_dir, int append);
> +void write_commit_graph_reachable(const char *obj_dir, int append,
> +				  int report_progress);
>   void write_commit_graph(const char *obj_dir,
>   			struct string_list *pack_indexes,
>   			struct string_list *commit_hex,
> -			int append);
> +			int append, int report_progress);
>   
>   int verify_commit_graph(struct repository *r, struct commit_graph *g);
>   

Junio,

The above prototype change seems to have created a semantic conflict 
with ds/commit-graph-tests (859fdc "commit-graph: define 
GIT_TEST_COMMIT_GRAPH") because when GIT_TEST_COMMIT_GRAPH is set, we 
call write_commit_graph_reachable() but the final parameter was resolved 
to be "1" instead of "0".

This causes t3420-rebase-autostash.sh to fail, as that test watches the 
full output of the rebase command, including commit runs. The following 
patch fixes the problem, but could probably be squashed into a merge or 
other commit.

Thanks,

-Stolee

-->8--

From: Derrick Stolee <dstolee@microsoft.com>
Date: Fri, 21 Sep 2018 19:57:36 +0000
Subject: [PATCH] commit: quietly write commit-graph in tests

The GIT_TEST_COMMIT_GRAPH environment variable causes git-commit to
write a commit-graph file on every execution. Recently, we added
progress output when writing the commit-graph. This conflicts with
some expected output during some tests, so avoid writing progress
if writing a commit-graph this way.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
  builtin/commit.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 2a49ab4917..764664d832 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1660,7 +1660,7 @@ int cmd_commit(int argc, const char **argv, const 
char *prefix)
                       "not exceeded, and then \"git reset HEAD\" to 
recover."));

         if (git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
- write_commit_graph_reachable(get_object_directory(), 0, 1);
+ write_commit_graph_reachable(get_object_directory(), 0, 0);

         rerere(0);
         run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
--
2.19.0

