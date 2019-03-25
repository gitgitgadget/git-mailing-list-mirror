Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C1820248
	for <e@80x24.org>; Mon, 25 Mar 2019 12:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfCYMIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 08:08:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42716 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731069AbfCYMIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 08:08:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so6336612wrx.9
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sqm/0P9NoRW86ke2T7iokr9pE3KWl9VxIT+IDOokl1E=;
        b=cmzMX2SP9G0ckd6e4cw0eEKvlOuSLM7HzbVi/YpJLzDtCFCwn/hQGsECIKtVwln9DY
         MKLOwanVu58RSJr//REwc1x/31tjxtn7Ud2ok8TT0kNrvI7fRHeTZZOQM8hfkZFE23p9
         rEbiTT1HIq5hNPX5kMh/V0Cn+P0TfZoqHftRRbvyAnXFGteUDVRrNxInRfC//YegZ8RH
         cLxsqdyHKTvPtFsHxtIvZugl9MrcxM1ZLxUk3XoG4Aegnhi7SXXtotGDrIjvuvPhwaS4
         jt1L01RZoSyigpAQb+KEfV9FDN9mSF9XSQRdjlKlFuaMbdxvJZGnsU9WczBAUgCvnz5T
         fN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sqm/0P9NoRW86ke2T7iokr9pE3KWl9VxIT+IDOokl1E=;
        b=PR/aZN+TQGZbEMLBTeUFIn9ofMzLOKpiOg7Ns24ww62PvTwLaICf4oka+wKUbQW5bX
         BeXFnIfoAiK7LeBQZkGSX7dgXZRoAip9eNilcPDgpt2a2sJhr+45DEHH3U0AReJQYkmX
         qhlFMqMMvQBQAihx02lQ1g5iRLsa9OGanvo+3QaLhMSxJe2i3J8IXTrk+qxXURr6lbqQ
         3GqpRhijuREme42X21me5BJm//Mns5e+4A4+8aKEbOOBo1e5WUEAgOEJBQIwjpwXfb8k
         7H9tvgf7aBZc3KTk5sYCtXLpHVmoQHI2RM8SCXwDj32YdQY04p2MzqnmEded+7cCB2E/
         5oeQ==
X-Gm-Message-State: APjAAAXxVQCT1RzuKnbssUjvV1agANusEZX3nbXcoefi/mShxRHubxR0
        jrFgI+EbkRV/WaFPjWIm277NQJmf
X-Google-Smtp-Source: APXvYqx/KHZPfmCphPdKXQjUT6z1jqs9oj8ldneJ8CryqQVl3ULEti/9iQVPzBYjKq63xYy50tsS0Q==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr16160574wrm.52.1553515723234;
        Mon, 25 Mar 2019 05:08:43 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n188sm15339464wme.13.2019.03.25.05.08.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 05:08:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/8] commit-graph: segfault & other fixes for broken graphs
Date:   Mon, 25 Mar 2019 13:08:26 +0100
Message-Id: <20190325120834.15529-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314214740.23360-1-avarab@gmail.com>
References: <20190314214740.23360-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v3 fixes issues raised by Ramsay in
https://public-inbox.org/git/1908832c-8dd0-377e-917b-acb33b00273c@ramsayjones.plus.com/

While I was at it I changed a die("Whatevs") to
die("whatevs"). I.e. start with lower-case as discussed in other
places on-list recently.

The range-diff looks scarier than this v2..v3 really is. There's no
code changes aside from the s/0/NULL/ in one place, but marking a
couple of functions as "static" required moving them around, and
removing their entry from the corresponding *.h file.

Ævar Arnfjörð Bjarmason (8):
  commit-graph tests: split up corrupt_graph_and_verify()
  commit-graph tests: test a graph that's too small
  commit-graph: fix segfault on e.g. "git status"
  commit-graph: don't early exit(1) on e.g. "git status"
  commit-graph: don't pass filename to load_commit_graph_one_fd_st()
  commit-graph verify: detect inability to read the graph
  commit-graph write: don't die if the existing graph is corrupt
  commit-graph: improve & i18n error messages

 builtin/commit-graph.c  |  23 +++++--
 commit-graph.c          | 132 +++++++++++++++++++++++++++-------------
 commit-graph.h          |   4 +-
 commit.h                |   6 ++
 t/t5318-commit-graph.sh |  42 +++++++++++--
 5 files changed, 153 insertions(+), 54 deletions(-)

Range-diff:
1:  2f8ba0adf8 = 1:  83ff92a39d commit-graph tests: split up corrupt_graph_and_verify()
2:  800b17edde = 2:  b9170c35e6 commit-graph tests: test a graph that's too small
3:  7083ab81c7 ! 3:  daf38a9af7 commit-graph: fix segfault on e.g. "git status"
    @@ -58,20 +58,10 @@
      --- a/commit-graph.c
      +++ b/commit-graph.c
     @@
    - 		last_chunk_offset = chunk_offset;
    - 	}
    - 
    -+	if (verify_commit_graph_lite(graph))
    -+		return NULL;
    -+
    - 	return graph;
    + 	return ret;
      }
      
    -@@
    - #define GENERATION_ZERO_EXISTS 1
    - #define GENERATION_NUMBER_EXISTS 2
    - 
    -+int verify_commit_graph_lite(struct commit_graph *g)
    ++static int verify_commit_graph_lite(struct commit_graph *g)
     +{
     +	/*
     +	 * Basic validation shared between parse_commit_graph()
    @@ -101,9 +91,19 @@
     +	return 0;
     +}
     +
    - int verify_commit_graph(struct repository *r, struct commit_graph *g)
    + struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    + 					size_t graph_size)
      {
    - 	uint32_t i, cur_fanout_pos = 0;
    +@@
    + 		last_chunk_offset = chunk_offset;
    + 	}
    + 
    ++	if (verify_commit_graph_lite(graph))
    ++		return NULL;
    ++
    + 	return graph;
    + }
    + 
     @@
      		return 1;
      	}
    @@ -122,18 +122,6 @@
      		return verify_commit_graph_error;
      
     
    - diff --git a/commit-graph.h b/commit-graph.h
    - --- a/commit-graph.h
    - +++ b/commit-graph.h
    -@@
    - 			struct string_list *commit_hex,
    - 			int append, int report_progress);
    - 
    -+int verify_commit_graph_lite(struct commit_graph *g);
    - int verify_commit_graph(struct repository *r, struct commit_graph *g);
    - 
    - void close_commit_graph(struct repository *);
    -
      diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
      --- a/t/t5318-commit-graph.sh
      +++ b/t/t5318-commit-graph.sh
4:  d00564ae89 ! 4:  3d7d8c4deb commit-graph: don't early exit(1) on e.g. "git status"
    @@ -29,7 +29,15 @@
         passed to that function for the the "graph file %s is too small" error
         message.
     
    +    This leaves load_commit_graph_one() unused by everything except the
    +    internal prepare_commit_graph_one() function, so let's mark it as
    +    "static". If someone needs it in the future we can remove the "static"
    +    attribute. I could also rewrite its sole remaining
    +    user ("prepare_commit_graph_one()") to use
    +    load_commit_graph_one_fd_st() instead, but let's leave it at this.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
    +    Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
     
      diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
      --- a/builtin/commit-graph.c
    @@ -131,7 +139,7 @@
      		close(fd);
     -		die(_("graph file %s is too small"), graph_file);
     +		error(_("graph file %s is too small"), graph_file);
    -+		return 0;
    ++		return NULL;
      	}
      	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
      	ret = parse_commit_graph(graph_map, fd, graph_size);
    @@ -143,9 +151,11 @@
      	}
      
      	return ret;
    +@@
    + 	return graph;
      }
      
    -+struct commit_graph *load_commit_graph_one(const char *graph_file)
    ++static struct commit_graph *load_commit_graph_one(const char *graph_file)
     +{
     +
     +	struct stat st;
    @@ -158,9 +168,9 @@
     +	return load_commit_graph_one_fd_st(graph_file, fd, &st);
     +}
     +
    - struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    - 					size_t graph_size)
    + static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
      {
    + 	char *graph_name;
     
      diff --git a/commit-graph.h b/commit-graph.h
      --- a/commit-graph.h
    @@ -174,9 +184,10 @@
      /*
       * Given a commit struct, try to fill the commit struct info, including:
     @@
    + 	const unsigned char *chunk_extra_edges;
      };
      
    - struct commit_graph *load_commit_graph_one(const char *graph_file);
    +-struct commit_graph *load_commit_graph_one(const char *graph_file);
     +struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
     +						 int fd, struct stat *st);
      
5:  25ee185bf7 ! 5:  15687fb21f commit-graph: don't pass filename to load_commit_graph_one_fd_st()
    @@ -59,7 +59,7 @@
      		close(fd);
     -		error(_("graph file %s is too small"), graph_file);
     +		error(_("commit-graph file is too small"));
    - 		return 0;
    + 		return NULL;
      	}
      	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
     @@
    @@ -70,15 +70,15 @@
     +	return load_commit_graph_one_fd_st(fd, &st);
      }
      
    - struct commit_graph *parse_commit_graph(void *graph_map, int fd,
    + static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
     
      diff --git a/commit-graph.h b/commit-graph.h
      --- a/commit-graph.h
      +++ b/commit-graph.h
     @@
    + 	const unsigned char *chunk_extra_edges;
      };
      
    - struct commit_graph *load_commit_graph_one(const char *graph_file);
     -struct commit_graph *load_commit_graph_one_fd_st(const char *graph_file,
     -						 int fd, struct stat *st);
     +struct commit_graph *load_commit_graph_one_fd_st(int fd, struct stat *st);
6:  7619b46987 = 6:  30145c2dca commit-graph verify: detect inability to read the graph
7:  17ee4fc050 ! 7:  51e3aa651b commit-graph write: don't die if the existing graph is corrupt
    @@ -57,7 +57,7 @@
      	int config_value;
      
     +	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD, 0))
    -+		die("Dying as requested by the '%s' variable on commit-graph load!",
    ++		die("dying as requested by the '%s' variable on commit-graph load!",
     +		    GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD);
     +
      	if (r->objects->commit_graph_attempted)
8:  29ab2895b7 = 8:  e7c801f73b commit-graph: improve & i18n error messages
-- 
2.21.0.360.g471c308f928

