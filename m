Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0F3D1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 16:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfGHQhz (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 12:37:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35181 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGHQhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 12:37:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so9278582wrm.2
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evsUiZ60yig0mHGxQITOH79Pt4wZQUTQuOHxFzRKJ5k=;
        b=cGYWECK4Jo0iSDUkYVN8t7Mw3BeyA1dEpi02gKDxIQ8qLCYXYFWLRL8dO8UTnJlQfr
         NR6S5eSPIsO18OdiyGs1Tu4N+Fv1klaiPRRE8RVlr5rQajEmD2lYKLhfUwJIHiOTWhXg
         +fKXC/8qquSBgt3be6XFNoBne7bfIGpE0HjXkcQHSiEIrhe9ncbDSR6Q4tkEz7tt3ftV
         lU3uvokE2/kAwwJ+i+tw+W+ANl9J1Q7Rj0EXsmMXpztqIy70Ztts7MwFDunpcbgD7trH
         Fh/MLbtOZQx6YkLcaedH6iCPNK95kcmjmhApLAHPZLjgMBG+FKPKDdbc3CjszqkvHh2+
         Dgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evsUiZ60yig0mHGxQITOH79Pt4wZQUTQuOHxFzRKJ5k=;
        b=f6s6/BuEihhHV8iYmJvy0o9nMwdUCpQ5ft15HZO/H4lBccW+D+LUJXQDWtLfMcPaQ5
         LfjWCRYFIbgilunOMk1w+pXLJfCyzshPf+Uq1n5nO/ZJ/YB5RMkHheq81N404HQbHpWt
         tJsRgpOrhHWaIlW2gLnX0O2yT/LCdkRkfThsWAg+RXREJJXg/A7/aMjIZkcYpNKgrHdv
         h2CVzWfrtmf9ahO4M4aOZd/NeCg4eV+OI5ijblzeR9AruzPPAgdafzRxtAQZNAqAkSGW
         mCsoEltwmYfSPA7CQF0gPtfTB1SR694NouUE03+wTqBQBR3trCY62hdOOlNyzrC78Iik
         o6gw==
X-Gm-Message-State: APjAAAUm+4JRnlWRoefAR96qQ8HRSxj1PU2Ul0ObHTxqXyHLK/fCfrJG
        RwPqUBwZYMo6LIa7mw2DNZ3X2P/9
X-Google-Smtp-Source: APXvYqw9pgC8y2UAc1BI3alCwHHq60MGixlD7S4VRqLu8rPD5YM6qsORnkishQZz7coPmlbx61YkGg==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr4771626wrs.44.1562603870393;
        Mon, 08 Jul 2019 09:37:50 -0700 (PDT)
Received: from localhost ([95.148.214.18])
        by smtp.gmail.com with ESMTPSA id t24sm106010wmj.14.2019.07.08.09.37.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:37:49 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 00/14] output improvements for git range-diff
Date:   Mon,  8 Jul 2019 17:33:01 +0100
Message-Id: <20190708163315.29912-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a
In-Reply-To: <20190705170630.27500-1-t.gummerer@gmail.com>
References: <20190705170630.27500-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Dscho for the review of the previous round [1].  This rounds
addresses all the comments from that review.

In particular

- update commit messages where necessary.
- rename the function in apply.c to 'parse_git_diff_header()'
- code cleanups in 09/14
- fix a memory leak introduced in 09/14
- be less strict about parsing hunk headers, so the new code isn't
  more strict than it was before
- give more information when we are unable to parse the git diff
  header

[1]: https://public-inbox.org/git/20190705170630.27500-1-t.gummerer@gmail.com/

Thomas Gummerer (14):
  apply: replace marc.info link with public-inbox
  apply: only pass required data to skip_tree_prefix
  apply: only pass required data to git_header_name
  apply: only pass required data to check_header_line
  apply: only pass required data to find_name_*
  apply: only pass required data to gitdiff_* functions
  apply: make parse_git_header public
  range-diff: fix function parameter indentation
  range-diff: split lines manually
  range-diff: don't remove funcname from inner diff
  range-diff: suppress line count in outer diff
  range-diff: add section header instead of diff header
  range-diff: add filename to inner diff
  range-diff: add headers to the outer hunk header

 apply.c                | 186 ++++++++++++++++++-----------------------
 apply.h                |  48 +++++++++++
 diff.c                 |   5 +-
 diff.h                 |   1 +
 range-diff.c           | 124 +++++++++++++++++++--------
 t/t3206-range-diff.sh  | 124 ++++++++++++++++++++++-----
 t/t3206/history.export |  84 ++++++++++++++++++-
 7 files changed, 409 insertions(+), 163 deletions(-)

Range-diff against v2:
 1:  ef2245edda =  1:  ef2245edda apply: replace marc.info link with public-inbox
 2:  94578fa45c =  2:  94578fa45c apply: only pass required data to skip_tree_prefix
 3:  988269a68e =  3:  988269a68e apply: only pass required data to git_header_name
 4:  a2c1ef3f5f =  4:  a2c1ef3f5f apply: only pass required data to check_header_line
 5:  0f4cfe21cb =  5:  0f4cfe21cb apply: only pass required data to find_name_*
 6:  7f1d7a4569 !  6:  07a271518d apply: only pass required data to gitdiff_* functions
    @@ Commit message
         we want functions in the callchain of 'parse_git_header()' to only
         take arguments they really need.
     
    +    As these functions are called in a loop using their function pointers,
    +    each function needs to be passed all the parameters even if only one
    +    of the functions actually needs it.  We therefore pass this data along
    +    in a struct to avoid adding too many unused parameters to each
    +    function and making the code very verbose in the process.
    +
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
      ## apply.c ##
 7:  a5af8b0845 !  7:  9cb6732a5f apply: make parse_git_header public
    @@ apply.c: struct fragment {
      {
      	while (list) {
     @@ apply.c: static int check_header_line(int linenr, struct patch *patch)
    + 	return 0;
      }
      
    - /* Verify that we recognize the lines following a git header */
    +-/* Verify that we recognize the lines following a git header */
     -static int parse_git_header(struct apply_state *state,
     -			    const char *line,
     -			    int len,
     -			    unsigned int size,
     -			    struct patch *patch)
    -+int parse_git_header(struct strbuf *root,
    -+		     int *linenr,
    -+		     int p_value,
    -+		     const char *line,
    -+		     int len,
    -+		     unsigned int size,
    -+		     struct patch *patch)
    ++int parse_git_diff_header(struct strbuf *root,
    ++			  int *linenr,
    ++			  int p_value,
    ++			  const char *line,
    ++			  int len,
    ++			  unsigned int size,
    ++			  struct patch *patch)
      {
      	unsigned long offset;
      	struct parse_git_header_state parse_hdr_state;
    @@ apply.c: static int find_header(struct apply_state *state,
      		 */
      		if (!memcmp("diff --git ", line, 11)) {
     -			int git_hdr_len = parse_git_header(state, line, len, size, patch);
    -+			int git_hdr_len = parse_git_header(&state->root, &state->linenr,
    -+							   state->p_value, line, len,
    -+							   size, patch);
    ++			int git_hdr_len = parse_git_diff_header(&state->root, &state->linenr,
    ++								state->p_value, line, len,
    ++								size, patch);
      			if (git_hdr_len < 0)
      				return -128;
      			if (git_hdr_len <= len)
    @@ apply.h: int init_apply_state(struct apply_state *state,
      int check_apply_state(struct apply_state *state, int force_apply);
      
     +/*
    -+ * Parse a get header, starting at line.  Fills the relevant metadata
    -+ * information in 'struct patch'.
    ++ * Parse a git diff header, starting at line.  Fills the relevant
    ++ * metadata information in 'struct patch'.
     + *
     + * Returns -1 on failure, the length of the parsed header otherwise.
     + */
    -+int parse_git_header(struct strbuf *root,
    -+		     int *linenr,
    -+		     int p_value,
    -+		     const char *line,
    -+		     int len,
    -+		     unsigned int size,
    -+		     struct patch *patch);
    ++int parse_git_diff_header(struct strbuf *root,
    ++			  int *linenr,
    ++			  int p_value,
    ++			  const char *line,
    ++			  int len,
    ++			  unsigned int size,
    ++			  struct patch *patch);
     +
      /*
       * Some aspects of the apply behavior are controlled by the following
 8:  1f25bb1002 =  8:  76a11ce995 range-diff: fix function parameter indentation
 9:  01ed0f2a6a !  9:  6f70e7faa6 range-diff: split lines manually
    @@ Commit message
     
         Currently range-diff uses the 'strbuf_getline()' function for doing
         its line by line processing.  In a future patch we want to do parts of
    -    that parsing using the 'parse_git_header()' function, which does
    -    requires reading parts of the input from that function, which doesn't
    -    use strbufs.
    +    that parsing using the 'parse_git_diff_header()' function.  That
    +    function does its own line by line reading of the input, and doesn't
    +    use strbufs.  This doesn't match with how we do the line-by-line
    +    processing in range-diff currently.
     
         Switch range-diff to do our own line by line parsing, so we can re-use
    -    the parse_git_header function later.
    +    the 'parse_git_diff_header()' function later.
     
         Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
     
    @@ range-diff.c: struct patch_util {
      	struct object_id oid;
      };
      
    -+static unsigned long linelen(const char *buffer, unsigned long size)
    ++static size_t find_end_of_line(char *buffer, unsigned long size)
     +{
    -+	unsigned long len = 0;
    -+	while (size--) {
    -+		len++;
    -+		if (*buffer++ == '\n')
    -+			break;
    -+	}
    -+	return len;
    ++	char *eol = memchr(buffer, '\n', size);
    ++
    ++	if (!eol)
    ++		return size;
    ++
    ++	*eol = '\0';
    ++	return eol + 1 - buffer;
     +}
     +
      /*
    @@ range-diff.c: struct patch_util {
      	struct child_process cp = CHILD_PROCESS_INIT;
     -	FILE *in;
     -	struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
    -+	struct strbuf buf = STRBUF_INIT, file = STRBUF_INIT;
    ++	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
      	struct patch_util *util = NULL;
      	int in_header = 1;
     +	char *line;
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      		return error_errno(_("could not start `log`"));
     -	in = fdopen(cp.out, "r");
     -	if (!in) {
    --		error_errno(_("could not read `log` output"));
    --		finish_command(&cp);
    --		return -1;
    --	}
    -+	strbuf_read(&file, cp.out, 0);
    ++	if (strbuf_read(&contents, cp.out, 0) < 0) {
    + 		error_errno(_("could not read `log` output"));
    + 		finish_command(&cp);
    + 		return -1;
    + 	}
      
     -	while (strbuf_getline(&line, in) != EOF) {
    -+	line = strbuf_detach(&file, &size);
    ++	line = contents.buf;
    ++	size = contents.len;
     +	for (offset = 0; size > 0; offset += len, size -= len, line += len) {
      		const char *p;
      
     -		if (skip_prefix(line.buf, "commit ", &p)) {
    -+		len = linelen(line, size);
    ++		len = find_end_of_line(line, size);
     +		line[len - 1] = '\0';
     +		if (skip_prefix(line, "commit ", &p)) {
      			if (util) {
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      				strbuf_release(&buf);
     -				strbuf_release(&line);
     -				fclose(in);
    ++				strbuf_release(&contents);
      				finish_command(&cp);
      				return -1;
      			}
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      	}
     -	fclose(in);
     -	strbuf_release(&line);
    ++	strbuf_release(&contents);
      
      	if (util)
      		string_list_append(list, buf.buf)->util = util;
10:  044a79868b ! 10:  6618cdff2c range-diff: don't remove funcname from inner diff
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
     -			strbuf_addstr(&buf, "@@");
     -		else if (!line[0] || starts_with(line, "index "))
     +		} else if (skip_prefix(line, "@@ ", &p)) {
    -+			if (!(p = strstr(p, "@@")))
    -+				die(_("invalid hunk header in inner diff"));
    -+			strbuf_addstr(&buf, p);
    ++			p = strstr(p, "@@");
    ++			strbuf_addstr(&buf, p ? p : "@@");
     +		} else if (!line[0] || starts_with(line, "index "))
      			/*
      			 * A completely blank (not ' \n', which is context)
11:  69654fe76d = 11:  2667df4fa5 range-diff: suppress line count in outer diff
12:  c38f929b9a ! 12:  47cd8c6733 range-diff: add section header instead of diff header
    @@ Commit message
         noisy.  However the diff of a single line is concise and should be
         easier to understand.
     
    -    Additionaly, this allows us to add these range diff section headers to
    +    Additionally, this allows us to add these range diff section headers to
         the outer diffs hunk headers using a custom userdiff pattern, which
         should help making the range-diff more readable.
     
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      		}
      
      		if (starts_with(line, "diff --git")) {
    -+			struct patch patch;
    ++			struct patch patch = { 0 };
     +			struct strbuf root = STRBUF_INIT;
     +			int linenr = 0;
     +
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      				util->diff_offset = buf.len;
     -			strbuf_addch(&buf, ' ');
     -			strbuf_addstr(&buf, line);
    -+			memset(&patch, 0, sizeof(patch));
     +			line[len - 1] = '\n';
    -+			len = parse_git_header(&root, &linenr, 1, line,
    -+					       len, size, &patch);
    ++			len = parse_git_diff_header(&root, &linenr, 1, line,
    ++						    len, size, &patch);
     +			if (len < 0)
    -+				die(_("could not parse git header"));
    ++				die(_("could not parse git header '%.*s'"), (int)len, line);
     +			strbuf_addstr(&buf, " ## ");
     +			if (patch.is_new > 0)
     +				strbuf_addf(&buf, "%s (new)", patch.new_name);
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      			if (starts_with(line, "Author: ")) {
      				strbuf_addstr(&buf, line);
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list)
    - 			if (!(p = strstr(p, "@@")))
    - 				die(_("invalid hunk header in inner diff"));
    - 			strbuf_addstr(&buf, p);
    + 		} else if (skip_prefix(line, "@@ ", &p)) {
    + 			p = strstr(p, "@@");
    + 			strbuf_addstr(&buf, p ? p : "@@");
     -		} else if (!line[0] || starts_with(line, "index "))
     +		} else if (!line[0])
      			/*
13:  6df03ecdcf ! 13:  f67fd5dd9a range-diff: add filename to inner diff
    @@ Commit message
     
      ## range-diff.c ##
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list)
    - 	struct strbuf buf = STRBUF_INIT, file = STRBUF_INIT;
    + 	struct strbuf buf = STRBUF_INIT, contents = STRBUF_INIT;
      	struct patch_util *util = NULL;
      	int in_header = 1;
     -	char *line;
    @@ range-diff.c: static int read_patches(const char *range, struct string_list *lis
      			    patch.old_mode != patch.new_mode)
      				strbuf_addf(&buf, " (mode change %06o => %06o)",
     @@ range-diff.c: static int read_patches(const char *range, struct string_list *list)
    + 			continue;
      		} else if (skip_prefix(line, "@@ ", &p)) {
    - 			if (!(p = strstr(p, "@@")))
    - 				die(_("invalid hunk header in inner diff"));
    --			strbuf_addstr(&buf, p);
    + 			p = strstr(p, "@@");
    +-			strbuf_addstr(&buf, p ? p : "@@");
     +			strbuf_addstr(&buf, "@@");
     +			if (current_filename && p[2])
     +				strbuf_addf(&buf, " %s:", current_filename);
    -+			strbuf_addstr(&buf, p + 2);
    ++			if (p)
    ++				strbuf_addstr(&buf, p + 2);
      		} else if (!line[0])
      			/*
      			 * A completely blank (not ' \n', which is context)
14:  5ceef49035 = 14:  812893a5dc range-diff: add headers to the outer hunk header

-- 
2.22.0.510.g264f2c817a
