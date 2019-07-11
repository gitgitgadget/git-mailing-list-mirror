Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04E521F461
	for <e@80x24.org>; Thu, 11 Jul 2019 22:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfGKWKC (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 18:10:02 -0400
Received: from avasout04.plus.net ([212.159.14.19]:33086 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfGKWKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 18:10:02 -0400
Received: from [10.0.2.15] ([146.90.155.229])
        by smtp with ESMTPA
        id lhGJhvu7caslVlhGKhxNXn; Thu, 11 Jul 2019 23:10:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1562883001; bh=93KSrS8D0sFwKpLArgExzOl8/q+iAjJdxBI20R1k/68=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Qv19lWF1qZdN9gyU0ic0n7R/SQ30hkqhCIaEyxwE9b5chdvMvgyBPuBLaqzEph7I4
         s03VSQaxFKj88pgel+kT2GrZgbu4zsqkcp7Ot8Tzm92WaaK/Rtr5oPqSZGPYO0xbb8
         D9fVfgP3Y9+TZy14VLK0iKOqLMP0hnbale9CyIf2i3PJEMgoVGdsT4/RY8O02SZE9o
         IHNkV4aaLIxog+0SXYHCXWZZEm6JGYxScfVZKZ3bKkDGZChXjhu19Sy5gEzlIj4cNr
         HTAaaAzSl88EVlPg4JgTQm2CMTl/LajXKpT1VlxZihUTUJ+GvMcvZO52DI8686layz
         2WttECdNNtc5Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bfsVr9HB c=1 sm=1 tr=0
 a=vIuMZWos35SQ56IFzOfLHA==:117 a=vIuMZWos35SQ56IFzOfLHA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8
 a=pGLkceISAAAA:8 a=gu6fZOg2AAAA:8 a=Bf3zv8QtNuJS-Kl6_rAA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v4 00/14] output improvements for git range-diff
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
References: <20190708163315.29912-1-t.gummerer@gmail.com>
 <20190711160851.14380-1-t.gummerer@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fd594a29-0ae9-c06b-6cb9-6ae2804f8f44@ramsayjones.plus.com>
Date:   Thu, 11 Jul 2019 23:09:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711160851.14380-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGpidfPKEm2UZbRNV3KVu+kvQXrL/LN0S/phEQZknWAKxYDWAW4gLCdJqnHTXx9+lnBXYgouV17BZYeEeFCYz1qnFwpIbZ9xg8faRtCln4IegZoeBeU9
 zcnucA8tDx7ocEydJC0Ul6en7mYaIb13tm4bgMvidjKTG6G5vDPGGWcHZ/06DY1joaCB4m9RAPWpQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/07/2019 17:08, Thomas Gummerer wrote:
> Thanks Junio for the comment on the previous round [1].  This round
> reanmes the struct we're using in apply.c to 'struct gitdiff_data',
> and updates the commit message of 7/14 to reflect the new name of the
> renamed function.
> 
> [1]: https://public-inbox.org/git/20190708163315.29912-1-t.gummerer@gmail.com/
> 
> Thomas Gummerer (14):
>   apply: replace marc.info link with public-inbox
>   apply: only pass required data to skip_tree_prefix
>   apply: only pass required data to git_header_name
>   apply: only pass required data to check_header_line
>   apply: only pass required data to find_name_*
>   apply: only pass required data to gitdiff_* functions
>   apply: make parse_git_diff_header public
>   range-diff: fix function parameter indentation
>   range-diff: split lines manually
>   range-diff: don't remove funcname from inner diff
>   range-diff: suppress line count in outer diff
>   range-diff: add section header instead of diff header
>   range-diff: add filename to inner diff
>   range-diff: add headers to the outer hunk header
> 
>  apply.c                | 186 ++++++++++++++++++-----------------------
>  apply.h                |  48 +++++++++++
>  diff.c                 |   5 +-
>  diff.h                 |   1 +
>  range-diff.c           | 124 +++++++++++++++++++--------
>  t/t3206-range-diff.sh  | 124 ++++++++++++++++++++++-----
>  t/t3206/history.export |  84 ++++++++++++++++++-
>  7 files changed, 409 insertions(+), 163 deletions(-)


Yes, the patch I just sent related to the previous version of
this series. However, I believe it still applies to this version
(looking at the range-diff below).

ATB,
Ramsay Jones

> Range-diff against v3:
>  1:  ef2245edda =  1:  ef2245edda apply: replace marc.info link with public-inbox
>  2:  94578fa45c =  2:  94578fa45c apply: only pass required data to skip_tree_prefix
>  3:  988269a68e =  3:  988269a68e apply: only pass required data to git_header_name
>  4:  a2c1ef3f5f =  4:  a2c1ef3f5f apply: only pass required data to check_header_line
>  5:  0f4cfe21cb =  5:  0f4cfe21cb apply: only pass required data to find_name_*
>  6:  07a271518d !  6:  42665e5295 apply: only pass required data to gitdiff_* functions
>     @@ -28,7 +28,7 @@
>       #include "rerere.h"
>       #include "apply.h"
>       
>     -+struct parse_git_header_state {
>     ++struct gitdiff_data {
>      +	struct strbuf *root;
>      +	int linenr;
>      +	int p_value;
>     @@ -42,7 +42,7 @@
>       }
>       
>      -static int gitdiff_hdrend(struct apply_state *state,
>     -+static int gitdiff_hdrend(struct parse_git_header_state *state,
>     ++static int gitdiff_hdrend(struct gitdiff_data *state,
>       			  const char *line,
>       			  struct patch *patch)
>       {
>     @@ -51,7 +51,7 @@
>       #define DIFF_NEW_NAME 1
>       
>      -static int gitdiff_verify_name(struct apply_state *state,
>     -+static int gitdiff_verify_name(struct parse_git_header_state *state,
>     ++static int gitdiff_verify_name(struct gitdiff_data *state,
>       			       const char *line,
>       			       int isnull,
>       			       char **name,
>     @@ -77,7 +77,7 @@
>       }
>       
>      -static int gitdiff_oldname(struct apply_state *state,
>     -+static int gitdiff_oldname(struct parse_git_header_state *state,
>     ++static int gitdiff_oldname(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -86,7 +86,7 @@
>       }
>       
>      -static int gitdiff_newname(struct apply_state *state,
>     -+static int gitdiff_newname(struct parse_git_header_state *state,
>     ++static int gitdiff_newname(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -95,7 +95,7 @@
>       }
>       
>      -static int gitdiff_oldmode(struct apply_state *state,
>     -+static int gitdiff_oldmode(struct parse_git_header_state *state,
>     ++static int gitdiff_oldmode(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -103,7 +103,7 @@
>       }
>       
>      -static int gitdiff_newmode(struct apply_state *state,
>     -+static int gitdiff_newmode(struct parse_git_header_state *state,
>     ++static int gitdiff_newmode(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -111,7 +111,7 @@
>       }
>       
>      -static int gitdiff_delete(struct apply_state *state,
>     -+static int gitdiff_delete(struct parse_git_header_state *state,
>     ++static int gitdiff_delete(struct gitdiff_data *state,
>       			  const char *line,
>       			  struct patch *patch)
>       {
>     @@ -120,7 +120,7 @@
>       }
>       
>      -static int gitdiff_newfile(struct apply_state *state,
>     -+static int gitdiff_newfile(struct parse_git_header_state *state,
>     ++static int gitdiff_newfile(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -129,7 +129,7 @@
>       }
>       
>      -static int gitdiff_copysrc(struct apply_state *state,
>     -+static int gitdiff_copysrc(struct parse_git_header_state *state,
>     ++static int gitdiff_copysrc(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -141,7 +141,7 @@
>       }
>       
>      -static int gitdiff_copydst(struct apply_state *state,
>     -+static int gitdiff_copydst(struct parse_git_header_state *state,
>     ++static int gitdiff_copydst(struct gitdiff_data *state,
>       			   const char *line,
>       			   struct patch *patch)
>       {
>     @@ -153,7 +153,7 @@
>       }
>       
>      -static int gitdiff_renamesrc(struct apply_state *state,
>     -+static int gitdiff_renamesrc(struct parse_git_header_state *state,
>     ++static int gitdiff_renamesrc(struct gitdiff_data *state,
>       			     const char *line,
>       			     struct patch *patch)
>       {
>     @@ -165,7 +165,7 @@
>       }
>       
>      -static int gitdiff_renamedst(struct apply_state *state,
>     -+static int gitdiff_renamedst(struct parse_git_header_state *state,
>     ++static int gitdiff_renamedst(struct gitdiff_data *state,
>       			     const char *line,
>       			     struct patch *patch)
>       {
>     @@ -177,7 +177,7 @@
>       }
>       
>      -static int gitdiff_similarity(struct apply_state *state,
>     -+static int gitdiff_similarity(struct parse_git_header_state *state,
>     ++static int gitdiff_similarity(struct gitdiff_data *state,
>       			      const char *line,
>       			      struct patch *patch)
>       {
>     @@ -186,7 +186,7 @@
>       }
>       
>      -static int gitdiff_dissimilarity(struct apply_state *state,
>     -+static int gitdiff_dissimilarity(struct parse_git_header_state *state,
>     ++static int gitdiff_dissimilarity(struct gitdiff_data *state,
>       				 const char *line,
>       				 struct patch *patch)
>       {
>     @@ -195,7 +195,7 @@
>       }
>       
>      -static int gitdiff_index(struct apply_state *state,
>     -+static int gitdiff_index(struct parse_git_header_state *state,
>     ++static int gitdiff_index(struct gitdiff_data *state,
>       			 const char *line,
>       			 struct patch *patch)
>       {
>     @@ -204,7 +204,7 @@
>        * into the next diff. Tell the parser to break out.
>        */
>      -static int gitdiff_unrecognized(struct apply_state *state,
>     -+static int gitdiff_unrecognized(struct parse_git_header_state *state,
>     ++static int gitdiff_unrecognized(struct gitdiff_data *state,
>       				const char *line,
>       				struct patch *patch)
>       {
>     @@ -212,7 +212,7 @@
>       			    struct patch *patch)
>       {
>       	unsigned long offset;
>     -+	struct parse_git_header_state parse_hdr_state;
>     ++	struct gitdiff_data parse_hdr_state;
>       
>       	/* A git diff has explicit new/delete information, so we don't guess */
>       	patch->is_new = 0;
>     @@ -228,7 +228,7 @@
>       		static const struct opentry {
>       			const char *str;
>      -			int (*fn)(struct apply_state *, const char *, struct patch *);
>     -+			int (*fn)(struct parse_git_header_state *, const char *, struct patch *);
>     ++			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
>       		} optable[] = {
>       			{ "@@ -", gitdiff_hdrend },
>       			{ "--- ", gitdiff_oldname },
>  7:  9cb6732a5f !  7:  3068fda8a9 apply: make parse_git_header public
>     @@ -1,9 +1,12 @@
>      Author: Thomas Gummerer <t.gummerer@gmail.com>
>      
>     -    apply: make parse_git_header public
>     +    apply: make parse_git_diff_header public
>      
>     -    Make parse_git_header a "public" function in apply.h, so we can re-use
>     -    it in range-diff in a subsequent commit.
>     +    Make 'parse_git_header()' (renamed to 'parse_git_diff_header()') a
>     +    "public" function in apply.h, so we can re-use it in range-diff in a
>     +    subsequent commit.  We're renaming the function to make it clearer in
>     +    other parts of the codebase that we're talking about a diff header and
>     +    not just any header.
>      
>          Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>      
>     @@ -70,7 +73,7 @@
>      +			  struct patch *patch)
>       {
>       	unsigned long offset;
>     - 	struct parse_git_header_state parse_hdr_state;
>     + 	struct gitdiff_data parse_hdr_state;
>      @@
>       	 * or removing or adding empty files), so we get
>       	 * the default name from the header.
>     @@ -100,7 +103,7 @@
>      +	for (offset = len ; size > 0 ; offset += len, size -= len, line += len, (*linenr)++) {
>       		static const struct opentry {
>       			const char *str;
>     - 			int (*fn)(struct parse_git_header_state *, const char *, struct patch *);
>     + 			int (*fn)(struct gitdiff_data *, const char *, struct patch *);
>      @@
>       			res = p->fn(&parse_hdr_state, line + oplen, patch);
>       			if (res < 0)
>  8:  76a11ce995 =  8:  781d054cab range-diff: fix function parameter indentation
>  9:  6f70e7faa6 =  9:  68a2953310 range-diff: split lines manually
> 10:  6618cdff2c = 10:  8ae95d053b range-diff: don't remove funcname from inner diff
> 11:  2667df4fa5 = 11:  e572510c52 range-diff: suppress line count in outer diff
> 12:  47cd8c6733 = 12:  45605db760 range-diff: add section header instead of diff header
> 13:  f67fd5dd9a = 13:  89a27fbeaa range-diff: add filename to inner diff
> 14:  812893a5dc = 14:  8bee2c525f range-diff: add headers to the outer hunk header
> 
