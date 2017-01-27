Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1FB41F437
	for <e@80x24.org>; Fri, 27 Jan 2017 17:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbdA0Rir (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 12:38:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:51066 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933176AbdA0Rhc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 12:37:32 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MN1C4-1cZOLU3zTs-006eIf; Fri, 27
 Jan 2017 18:30:13 +0100
Date:   Fri, 27 Jan 2017 18:30:10 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 0/1] Support `git reset --stdin`
In-Reply-To: <cover.1485520718.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1485538197.git.johannes.schindelin@gmx.de>
References: <cover.1485520718.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6Y4KtOYEvN9S3fRZfSxSiwxjjF7rRzJpuWnsrPUn178IsmCxqBE
 L61Tt1EgYD141BgiAxrFxT7N1bxe7v31e2UeGmAc58hvbZ3u4RtriE6YfBceQnbXBvPqN39
 LBL/O0Np1m6LRkL0kDqYabYd/0bE7bQE6puT3ItxIpNMt69Zr92bZtEjLCaw7pCgkaeeL3F
 hXYn/sOny5/qfUEyRa2gw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MBNsMmFdam4=:ah+kbaR3Y8dX93jbDe/2rr
 mXhqcnXTU/GHHCzJom88RCLjtz5qFp/JGD+3Wx6Jph1P+7Ay9u2Ps9HVvwyiq5VlumwyOPOcE
 SdmOnNCkTNObDHBeUHmxD6S2ZMPsrwSeOq51fKCTa7KN03ym2VeSN3UNhWz9Q3RrR0n5u3lUs
 s/uCyr85gor5R03unZNo0rvYovu7wNRUqi85GWVpg83A8QVq2kjxnd+6ZqP7Wd18Ct7kHulFj
 6cXZ3vXJLs44G+WNZAcwoyIewXrDJG1ISYFqa7JxL+R/Gbn3vCa1lYxjnlIbuNpKF/LYLiHDd
 4kWDlfonLquRvqQgN69ema1JCFx7GK9tI23cgPhzJr+TOgPrWd+waS9DKTiF7F5cQ5UQPor8t
 0KruaKpkcwM4H7kQcgnEHxN/EUa3Zz43DdySlYgDyqQDMfT3gOI8+jut8N16QqlKy8lwBXxu0
 0j/GBMX7wTgdd86JOSlzuGusdu9NxX5BOYNSWgBnSh3X3xhVbbO48/5HGznNtDNLal5t5rvRf
 utjdlE06utYQul1Vkp0/yO4Pr3O+Wb/SZLKxKCyARRsiyBe2g6oZWC+k/VnUHWydN17XF0H+J
 PGRzpJ8wxtREcrKdjSXS2P/p7RwAQagg5wE8/cBkoYkyuK+2c63kgSSh4a0kq8Km5lXjiQyC1
 hqfH4c5hbNQc89GtcQFNTGgagmEdk7AxGK2mut7NGlpbXjhNLiDj7TGK7XXZ7UiRcbYNJXcnq
 u1LIRX1pP4tZD1HMOcKKcTW5Q58189rWrhhtbk4+fuTQVmZftLSXuJEurzDVYRQIZIYqeF4vN
 6Dl35tXSBnDQF+fUYq5LHg1WMFilA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This feature was missing, and made it cumbersome for third-party
tools to reset a lot of paths in one go.

Support for --stdin has been added, following builtin/checkout-index.c's
example.

Changes since v2:

- the documentation clarifies that --stdin does not treat the input as
  pathspecs

- the code now uses struct argv_array instead of rolling its own


Johannes Schindelin (1):
  reset: support the --stdin option

 Documentation/git-reset.txt | 10 ++++++++++
 builtin/reset.c             | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 t/t7107-reset-stdin.sh      | 33 +++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100755 t/t7107-reset-stdin.sh


base-commit: 4e59582ff70d299f5a88449891e78d15b4b3fabe
Published-As: https://github.com/dscho/git/releases/tag/reset-stdin-v3
Fetch-It-Via: git fetch https://github.com/dscho/git reset-stdin-v3

Interdiff vs v2:

 diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
 index abb71bb805..d319ed9b20 100644
 --- a/Documentation/git-reset.txt
 +++ b/Documentation/git-reset.txt
 @@ -100,7 +100,8 @@ OPTIONS
  
  --stdin::
  	Instead of taking list of paths from the command line,
 -	read list of paths from the standard input.  Paths are
 +	read list of paths from the standard input.  The paths are
 +	read verbatim, i.e. not handled as pathspecs.  Paths are
  	separated by LF (i.e. one path per line) by default.
  
  -z::
 diff --git a/builtin/reset.c b/builtin/reset.c
 index 1d3075b7ee..fe7723c179 100644
 --- a/builtin/reset.c
 +++ b/builtin/reset.c
 @@ -23,6 +23,7 @@
  #include "cache-tree.h"
  #include "strbuf.h"
  #include "quote.h"
 +#include "argv-array.h"
  
  static const char * const git_reset_usage[] = {
  	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"),
 @@ -271,8 +272,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
  {
  	int reset_type = NONE, update_ref_status = 0, quiet = 0;
  	int patch_mode = 0, nul_term_line = 0, read_from_stdin = 0, unborn;
 -	char **stdin_paths = NULL;
 -	int stdin_nr = 0, stdin_alloc = 0;
 +	struct argv_array stdin_paths = ARGV_ARRAY_INIT;
  	const char *rev;
  	struct object_id oid;
  	struct pathspec pathspec;
 @@ -325,18 +325,15 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
  					die(_("line is badly quoted"));
  				strbuf_swap(&buf, &unquoted);
  			}
 -			ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
 -			stdin_paths[stdin_nr++] = xstrdup(buf.buf);
 +			argv_array_push(&stdin_paths, buf.buf);
  			strbuf_reset(&buf);
  		}
  		strbuf_release(&unquoted);
  		strbuf_release(&buf);
  
 -		ALLOC_GROW(stdin_paths, stdin_nr + 1, stdin_alloc);
 -		stdin_paths[stdin_nr++] = NULL;
  		flags |= PATHSPEC_LITERAL_PATH;
  		parse_pathspec(&pathspec, 0, flags, prefix,
 -			       (const char **)stdin_paths);
 +			       stdin_paths.argv);
  
  	} else if (nul_term_line)
  		die(_("-z requires --stdin"));
 @@ -431,11 +428,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
  	if (!pathspec.nr)
  		remove_branch_state();
  
 -	if (stdin_paths) {
 -		while (stdin_nr)
 -			free(stdin_paths[--stdin_nr]);
 -		free(stdin_paths);
 -	}
 +	argv_array_clear(&stdin_paths);
  
  	return update_ref_status;
  }

-- 
2.11.1.windows.prerelease.2.9.g3014b57

