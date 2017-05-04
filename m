Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB4A20825
	for <e@80x24.org>; Thu,  4 May 2017 22:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbdEDWBZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32812 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbdEDWBW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:22 -0400
Received: by mail-wm0-f68.google.com with SMTP id y10so6205679wmh.0
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pEoj+G/D9lVvtjUZBAT+6r+0ko5z9fJiOHWrnuycOvc=;
        b=lw2PgB1gpnEmvRZeTI9oOtpRydLpknS5Su/T89R1Hq1yHRQ7OxFS0yrpKWZvv25god
         JCx8pUOchNkmERqCtbmAWjqLugD8dQ4TL+1wT3kSyf68yEsaSYD/OONtoz59A/TEco/Q
         nwOgufCa6BlEk0XO55ioemuYNm1SYT1hFl7Ksk4jsLwm21pDtgMrH3COMyxJfjZiWqfK
         E0ECIypgtW6yK6NkPS4P8nUwh3ceH0/2It4RFroiqk9ChzxgmxQO1E60oWLxMHXNuem4
         A2d5pGtV9JmMGf7lvt/y1ARB7SFFRrHNfzwerGn7RErZoVcT+RqNB9CFjHltl6K2IkyR
         eUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pEoj+G/D9lVvtjUZBAT+6r+0ko5z9fJiOHWrnuycOvc=;
        b=RFjrBfYwkH/NUiweVPacSyJeMZhSSerRtOwpBYsUg4euyMUZkCb0UijTr3mT9VTtRq
         BP1s2AQOn96Gadp2yJMwP5CSCWHrEWIQJFeAUFVqyIioKFFgqAgq3KsPNJHfRNVgYI+3
         CC4tpx48siq3ptdGJ7JmxtE7j0MP/zphkTXHo+mIWXNpu7lVv4ZZfQZ8yK5dMEOT/IJ6
         I/73aNIWkTFwqtI3WOGC/Hh8QASroxj3o131SPk2Ynctq/MMKHQVPhtnSwlkwyxLSGim
         Oooc5v97wT2hnHZ3nU//NBaSz8oQ8hRuH46euInOfHGbj1Mwes0heyY/bvyWADjS4fYg
         c29g==
X-Gm-Message-State: AODbwcBtlbG/FwqaVhShAWVC7RXvq7ZBysgSSc1fw1FTnbUPMY7Y9N1B
        5JC+QqfltGPp8A==
X-Received: by 10.28.209.138 with SMTP id i132mr3463398wmg.87.1493935280376;
        Thu, 04 May 2017 15:01:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?UTF-8?q?Ond=C5=99ej=20B=C3=ADlka?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/7] fixup! compat/regex: update the gawk regex engine from upstream
Date:   Thu,  4 May 2017 22:00:39 +0000
Message-Id: <20170504220043.25702-4-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 compat/regex/regcomp.c | 356 +++++++++++++++++++++++++++++--------------------
 1 file changed, 209 insertions(+), 147 deletions(-)

diff --git a/compat/regex/regcomp.c b/compat/regex/regcomp.c
index d8bde06f1a..a1fb2e400e 100644
--- a/compat/regex/regcomp.c
+++ b/compat/regex/regcomp.c
@@ -1,5 +1,12 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
 /* Extended regular expression matching and search library.
-   Copyright (C) 2002-2007,2009,2010 Free Software Foundation, Inc.
+   Copyright (C) 2002-2016 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Isamu Hasegawa <isamu@yamato.ibm.com>.
 
@@ -14,9 +21,20 @@
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifdef HAVE_STDINT_H
+#include <stdint.h>
+#endif
+
+#ifdef HAVE_STRINGS_H
+#include <strings.h>
+#endif
+
+#ifdef _LIBC
+# include <locale/weight.h>
+#endif
 
 static reg_errcode_t re_compile_internal (regex_t *preg, const char * pattern,
 					  size_t length, reg_syntax_t syntax);
@@ -126,7 +144,7 @@ static reg_errcode_t mark_opt_subexp (void *extra, bin_tree_t *node);
    POSIX doesn't require that we do anything for REG_NOERROR,
    but why not be nice?  */
 
-const char __re_error_msgid[] attribute_hidden =
+static const char __re_error_msgid[] =
   {
 #define REG_NOERROR_IDX	0
     gettext_noop ("Success")	/* REG_NOERROR */
@@ -150,9 +168,9 @@ const char __re_error_msgid[] attribute_hidden =
     gettext_noop ("Invalid back reference") /* REG_ESUBREG */
     "\0"
 #define REG_EBRACK_IDX	(REG_ESUBREG_IDX + sizeof "Invalid back reference")
-    gettext_noop ("Unmatched [ or [^")	/* REG_EBRACK */
+    gettext_noop ("Unmatched [, [^, [:, [., or [=")	/* REG_EBRACK */
     "\0"
-#define REG_EPAREN_IDX	(REG_EBRACK_IDX + sizeof "Unmatched [ or [^")
+#define REG_EPAREN_IDX	(REG_EBRACK_IDX + sizeof "Unmatched [, [^, [:, [., or [=")
     gettext_noop ("Unmatched ( or \\(") /* REG_EPAREN */
     "\0"
 #define REG_EBRACE_IDX	(REG_EPAREN_IDX + sizeof "Unmatched ( or \\(")
@@ -180,7 +198,7 @@ const char __re_error_msgid[] attribute_hidden =
     gettext_noop ("Unmatched ) or \\)") /* REG_ERPAREN */
   };
 
-const size_t __re_error_msgid_idx[] attribute_hidden =
+static const size_t __re_error_msgid_idx[] =
   {
     REG_NOERROR_IDX,
     REG_NOMATCH_IDX,
@@ -204,20 +222,19 @@ const size_t __re_error_msgid_idx[] attribute_hidden =
 /* Entry points for GNU code.  */
 
 
-#ifdef ZOS_USS
-
-/* For ZOS USS we must define btowc */
-
-wchar_t 
+#ifndef HAVE_BTOWC
+wchar_t
 btowc (int c)
 {
    wchar_t wtmp[2];
    char tmp[2];
+   mbstate_t mbs;
 
+   memset(& mbs, 0, sizeof(mbs));
    tmp[0] = c;
    tmp[1] = 0;
 
-   mbtowc (wtmp, tmp, 1);
+   mbrtowc (wtmp, tmp, 1, & mbs);
    return wtmp[0];
 }
 #endif
@@ -226,12 +243,11 @@ btowc (int c)
    compiles PATTERN (of length LENGTH) and puts the result in BUFP.
    Returns 0 if the pattern was valid, otherwise an error string.
 
-   Assumes the `allocated' (and perhaps `buffer') and `translate' fields
+   Assumes the 'allocated' (and perhaps 'buffer') and 'translate' fields
    are set in BUFP on entry.  */
 
 const char *
-re_compile_pattern (const char *pattern,
-		    size_t length,
+re_compile_pattern (const char *pattern, size_t length,
 		    struct re_pattern_buffer *bufp)
 {
   reg_errcode_t ret;
@@ -254,7 +270,7 @@ re_compile_pattern (const char *pattern,
 weak_alias (__re_compile_pattern, re_compile_pattern)
 #endif
 
-/* Set by `re_set_syntax' to the current regexp syntax to recognize.  Can
+/* Set by 're_set_syntax' to the current regexp syntax to recognize.  Can
    also be assigned to arbitrarily: each pattern buffer stores its own
    syntax, so it can be changed between regex compilations.  */
 /* This has no initializer because initialized variables in Emacs
@@ -303,8 +319,8 @@ weak_alias (__re_compile_fastmap, re_compile_fastmap)
 #endif
 
 static inline void
-__attribute ((always_inline))
-re_set_fastmap (char *fastmap, int icase, int ch)
+__attribute__ ((always_inline))
+re_set_fastmap (char *fastmap, bool icase, int ch)
 {
   fastmap[ch] = 1;
   if (icase)
@@ -318,7 +334,7 @@ static void
 re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
 			 char *fastmap)
 {
-  volatile re_dfa_t *dfa = (re_dfa_t *) bufp->buffer;
+  re_dfa_t *dfa = (re_dfa_t *) bufp->buffer;
   int node_cnt;
   int icase = (dfa->mb_cur_max == 1 && (bufp->syntax & RE_ICASE));
   for (node_cnt = 0; node_cnt < init_state->nodes.nelem; ++node_cnt)
@@ -332,14 +348,15 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
 #ifdef RE_ENABLE_I18N
 	  if ((bufp->syntax & RE_ICASE) && dfa->mb_cur_max > 1)
 	    {
-	      unsigned char *buf = re_malloc (unsigned char, dfa->mb_cur_max), *p;
+	      unsigned char buf[MB_LEN_MAX];
+	      unsigned char *p;
 	      wchar_t wc;
 	      mbstate_t state;
 
 	      p = buf;
 	      *p++ = dfa->nodes[node].opr.c;
 	      while (++node < dfa->nodes_len
-		     && dfa->nodes[node].type == CHARACTER
+		     &&	dfa->nodes[node].type == CHARACTER
 		     && dfa->nodes[node].mb_partial)
 		*p++ = dfa->nodes[node].opr.c;
 	      memset (&state, '\0', sizeof (state));
@@ -348,7 +365,6 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
 		  && (__wcrtomb ((char *) buf, towlower (wc), &state)
 		      != (size_t) -1))
 		re_set_fastmap (fastmap, 0, buf[0]);
-	      re_free (buf);
 	    }
 #endif
 	}
@@ -450,15 +466,15 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
    PREG is a regex_t *.  We do not expect any fields to be initialized,
    since POSIX says we shouldn't.  Thus, we set
 
-     `buffer' to the compiled pattern;
-     `used' to the length of the compiled pattern;
-     `syntax' to RE_SYNTAX_POSIX_EXTENDED if the
+     'buffer' to the compiled pattern;
+     'used' to the length of the compiled pattern;
+     'syntax' to RE_SYNTAX_POSIX_EXTENDED if the
        REG_EXTENDED bit in CFLAGS is set; otherwise, to
        RE_SYNTAX_POSIX_BASIC;
-     `newline_anchor' to REG_NEWLINE being set in CFLAGS;
-     `fastmap' to an allocated space for the fastmap;
-     `fastmap_accurate' to zero;
-     `re_nsub' to the number of subexpressions in PATTERN.
+     'newline_anchor' to REG_NEWLINE being set in CFLAGS;
+     'fastmap' to an allocated space for the fastmap;
+     'fastmap_accurate' to zero;
+     're_nsub' to the number of subexpressions in PATTERN.
 
    PATTERN is the address of the pattern string.
 
@@ -481,9 +497,7 @@ re_compile_fastmap_iter (regex_t *bufp, const re_dfastate_t *init_state,
    the return codes and their meanings.)  */
 
 int
-regcomp (regex_t *__restrict preg,
-	 const char *__restrict pattern,
-	 int cflags)
+regcomp (regex_t *__restrict preg, const char *__restrict pattern, int cflags)
 {
   reg_errcode_t ret;
   reg_syntax_t syntax = ((cflags & REG_EXTENDED) ? RE_SYNTAX_POSIX_EXTENDED
@@ -542,8 +556,8 @@ weak_alias (__regcomp, regcomp)
    from either regcomp or regexec.   We don't use PREG here.  */
 
 size_t
-regerror(int errcode, const regex_t *__restrict preg,
-	 char *__restrict errbuf, size_t errbuf_size)
+regerror (int errcode, const regex_t *__restrict preg, char *__restrict errbuf,
+	  size_t errbuf_size)
 {
   const char *msg;
   size_t msg_size;
@@ -565,8 +579,12 @@ regerror(int errcode, const regex_t *__restrict preg,
     {
       if (BE (msg_size > errbuf_size, 0))
 	{
+#if defined HAVE_MEMPCPY || defined _LIBC
+	  *((char *) __mempcpy (errbuf, msg, errbuf_size - 1)) = '\0';
+#else
 	  memcpy (errbuf, msg, errbuf_size - 1);
 	  errbuf[errbuf_size - 1] = 0;
+#endif
 	}
       else
 	memcpy (errbuf, msg, msg_size);
@@ -679,8 +697,7 @@ char *
    regcomp/regexec above without link errors.  */
 weak_function
 # endif
-re_comp (s)
-     const char *s;
+re_comp (const char *s)
 {
   reg_errcode_t ret;
   char *fastmap;
@@ -709,7 +726,7 @@ re_comp (s)
 				 + __re_error_msgid_idx[(int) REG_ESPACE]);
     }
 
-  /* Since `re_exec' always passes NULL for the `regs' argument, we
+  /* Since 're_exec' always passes NULL for the 'regs' argument, we
      don't need to initialize the pattern buffer fields which affect it.  */
 
   /* Match anchors at newlines.  */
@@ -787,7 +804,7 @@ re_compile_internal (regex_t *preg, const char * pattern, size_t length,
   __libc_lock_init (dfa->lock);
 
   err = re_string_construct (&regexp, pattern, length, preg->translate,
-			     syntax & RE_ICASE, dfa);
+			     (syntax & RE_ICASE) != 0, dfa);
   if (BE (err != REG_NOERROR, 0))
     {
     re_compile_internal_free_return:
@@ -886,20 +903,9 @@ init_dfa (re_dfa_t *dfa, size_t pat_len)
     codeset_name = strchr (codeset_name, '.') + 1;
 # endif
 
-  /* strcasecmp isn't a standard interface. brute force check */
-#if 0
   if (strcasecmp (codeset_name, "UTF-8") == 0
       || strcasecmp (codeset_name, "UTF8") == 0)
     dfa->is_utf8 = 1;
-#else
-  if (   (codeset_name[0] == 'U' || codeset_name[0] == 'u')
-      && (codeset_name[1] == 'T' || codeset_name[1] == 't')
-      && (codeset_name[2] == 'F' || codeset_name[2] == 'f')
-      && (codeset_name[3] == '-'
-          ? codeset_name[4] == '8' && codeset_name[5] == '\0'
-          : codeset_name[3] == '8' && codeset_name[4] == '\0'))
-    dfa->is_utf8 = 1;
-#endif
 
   /* We check exhaustively in the loop below if this charset is a
      superset of ASCII.  */
@@ -964,6 +970,39 @@ init_word_char (re_dfa_t *dfa)
 {
   int i, j, ch;
   dfa->word_ops_used = 1;
+#ifndef GAWK
+  if (BE (dfa->map_notascii == 0, 1))
+    {
+      if (sizeof (dfa->word_char[0]) == 8)
+	{
+          /* The extra temporaries here avoid "implicitly truncated"
+             warnings in the case when this is dead code, i.e. 32-bit.  */
+          const uint64_t wc0 = UINT64_C (0x03ff000000000000);
+          const uint64_t wc1 = UINT64_C (0x07fffffe87fffffe);
+	  dfa->word_char[0] = wc0;
+	  dfa->word_char[1] = wc1;
+	  i = 2;
+	}
+      else if (sizeof (dfa->word_char[0]) == 4)
+	{
+	  dfa->word_char[0] = UINT32_C (0x00000000);
+	  dfa->word_char[1] = UINT32_C (0x03ff0000);
+	  dfa->word_char[2] = UINT32_C (0x87fffffe);
+	  dfa->word_char[3] = UINT32_C (0x07fffffe);
+	  i = 4;
+	}
+      else
+	abort ();
+      ch = 128;
+
+      if (BE (dfa->is_utf8, 1))
+	{
+	  memset (&dfa->word_char[i], '\0', (SBC_MAX - ch) / 8);
+	  return;
+	}
+    }
+#endif
+
   for (i = 0, ch = 0; i < BITSET_WORDS; ++i)
     for (j = 0; j < BITSET_WORD_BITS; ++j, ++ch)
       if (isalnum (ch) || ch == '_')
@@ -1162,7 +1201,12 @@ analyze (regex_t *preg)
 	  || dfa->eclosures == NULL, 0))
     return REG_ESPACE;
 
-  dfa->subexp_map = re_malloc (int, preg->re_nsub);
+  /* some malloc()-checkers don't like zero allocations */
+  if (preg->re_nsub > 0)
+    dfa->subexp_map = re_malloc (int, preg->re_nsub);
+  else
+    dfa->subexp_map = NULL;
+
   if (dfa->subexp_map != NULL)
     {
       int i;
@@ -1510,7 +1554,7 @@ duplicate_node_closure (re_dfa_t *dfa, int top_org_node, int top_clone_node,
 	     destination.  */
 	  org_dest = dfa->edests[org_node].elems[0];
 	  re_node_set_empty (dfa->edests + clone_node);
-	  /* If the node is root_node itself, it means the epsilon clsoure
+	  /* If the node is root_node itself, it means the epsilon closure
 	     has a loop.   Then tie it to the destination of the root_node.  */
 	  if (org_node == root_node && clone_node != org_node)
 	    {
@@ -1519,7 +1563,7 @@ duplicate_node_closure (re_dfa_t *dfa, int top_org_node, int top_clone_node,
 		return REG_ESPACE;
 	      break;
 	    }
-	  /* In case of the node has another constraint, add it.  */
+	  /* In case the node has another constraint, append it.  */
 	  constraint |= dfa->nodes[org_node].constraint;
 	  clone_dest = duplicate_node (dfa, org_dest, constraint);
 	  if (BE (clone_dest == -1, 0))
@@ -1662,7 +1706,7 @@ calc_eclosure (re_dfa_t *dfa)
       /* If we have already calculated, skip it.  */
       if (dfa->eclosures[node_idx].nelem != 0)
 	continue;
-      /* Calculate epsilon closure of `node_idx'.  */
+      /* Calculate epsilon closure of 'node_idx'.  */
       err = calc_eclosure_iter (&eclosure_elem, dfa, node_idx, 1);
       if (BE (err != REG_NOERROR, 0))
 	return err;
@@ -1729,11 +1773,11 @@ calc_eclosure_iter (re_node_set *new_set, re_dfa_t *dfa, int node, int root)
 	  }
 	else
 	  eclosure_elem = dfa->eclosures[edest];
-	/* Merge the epsilon closure of `edest'.  */
+	/* Merge the epsilon closure of 'edest'.  */
 	err = re_node_set_merge (&eclosure, &eclosure_elem);
 	if (BE (err != REG_NOERROR, 0))
 	  return err;
-	/* If the epsilon closure of `edest' is incomplete,
+	/* If the epsilon closure of 'edest' is incomplete,
 	   the epsilon closure of this node is also incomplete.  */
 	if (dfa->eclosures[edest].nelem == 0)
 	  {
@@ -2095,7 +2139,7 @@ peek_token_bracket (re_token_t *token, re_string_t *input, reg_syntax_t syntax)
 
 /* Entry point of the parser.
    Parse the regular expression REGEXP and return the structure tree.
-   If an error has occurred, ERR is set by error code, and return NULL.
+   If an error occurs, ERR is set by error code, and return NULL.
    This function build the following tree, from regular expression <reg_exp>:
 	   CAT
 	   / \
@@ -2137,7 +2181,7 @@ parse (re_string_t *regexp, regex_t *preg, reg_syntax_t syntax,
 	  /   \
    <branch1> <branch2>
 
-   ALT means alternative, which represents the operator `|'.  */
+   ALT means alternative, which represents the operator '|'.  */
 
 static bin_tree_t *
 parse_reg_exp (re_string_t *regexp, regex_t *preg, re_token_t *token,
@@ -2145,6 +2189,7 @@ parse_reg_exp (re_string_t *regexp, regex_t *preg, re_token_t *token,
 {
   re_dfa_t *dfa = (re_dfa_t *) preg->buffer;
   bin_tree_t *tree, *branch = NULL;
+  bitset_word_t initial_bkref_map = dfa->completed_bkref_map;
   tree = parse_branch (regexp, preg, token, syntax, nest, err);
   if (BE (*err != REG_NOERROR && tree == NULL, 0))
     return NULL;
@@ -2155,9 +2200,16 @@ parse_reg_exp (re_string_t *regexp, regex_t *preg, re_token_t *token,
       if (token->type != OP_ALT && token->type != END_OF_RE
 	  && (nest == 0 || token->type != OP_CLOSE_SUBEXP))
 	{
+	  bitset_word_t accumulated_bkref_map = dfa->completed_bkref_map;
+	  dfa->completed_bkref_map = initial_bkref_map;
 	  branch = parse_branch (regexp, preg, token, syntax, nest, err);
 	  if (BE (*err != REG_NOERROR && branch == NULL, 0))
-	    return NULL;
+	    {
+	      if (tree != NULL)
+		postorder (tree, free_tree, NULL);
+	      return NULL;
+	    }
+	  dfa->completed_bkref_map |= accumulated_bkref_map;
 	}
       else
 	branch = NULL;
@@ -2196,16 +2248,21 @@ parse_branch (re_string_t *regexp, regex_t *preg, re_token_t *token,
       exp = parse_expression (regexp, preg, token, syntax, nest, err);
       if (BE (*err != REG_NOERROR && exp == NULL, 0))
 	{
+	  if (tree != NULL)
+	    postorder (tree, free_tree, NULL);
 	  return NULL;
 	}
       if (tree != NULL && exp != NULL)
 	{
-	  tree = create_tree (dfa, tree, exp, CONCAT);
-	  if (tree == NULL)
+	  bin_tree_t *newtree = create_tree (dfa, tree, exp, CONCAT);
+	  if (newtree == NULL)
 	    {
+	      postorder (exp, free_tree, NULL);
+	      postorder (tree, free_tree, NULL);
 	      *err = REG_ESPACE;
 	      return NULL;
 	    }
+	  tree = newtree;
 	}
       else if (tree == NULL)
 	tree = exp;
@@ -2413,14 +2470,21 @@ parse_expression (re_string_t *regexp, regex_t *preg, re_token_t *token,
   while (token->type == OP_DUP_ASTERISK || token->type == OP_DUP_PLUS
 	 || token->type == OP_DUP_QUESTION || token->type == OP_OPEN_DUP_NUM)
     {
-      tree = parse_dup_op (tree, regexp, dfa, token, syntax, err);
-      if (BE (*err != REG_NOERROR && tree == NULL, 0))
-	return NULL;
+      bin_tree_t *dup_tree = parse_dup_op (tree, regexp, dfa, token, syntax, err);
+      if (BE (*err != REG_NOERROR && dup_tree == NULL, 0))
+	{
+	  if (tree != NULL)
+	    postorder (tree, free_tree, NULL);
+	  return NULL;
+	}
+      tree = dup_tree;
       /* In BRE consecutive duplications are not allowed.  */
       if ((syntax & RE_CONTEXT_INVALID_DUP)
 	  && (token->type == OP_DUP_ASTERISK
 	      || token->type == OP_OPEN_DUP_NUM))
 	{
+	  if (tree != NULL)
+	    postorder (tree, free_tree, NULL);
 	  *err = REG_BADRPT;
 	  return NULL;
 	}
@@ -2454,7 +2518,11 @@ parse_sub_exp (re_string_t *regexp, regex_t *preg, re_token_t *token,
     {
       tree = parse_reg_exp (regexp, preg, token, syntax, nest, err);
       if (BE (*err == REG_NOERROR && token->type != OP_CLOSE_SUBEXP, 0))
-	*err = REG_EPAREN;
+	{
+	  if (tree != NULL)
+	    postorder (tree, free_tree, NULL);
+	  *err = REG_EPAREN;
+	}
       if (BE (*err != REG_NOERROR, 0))
 	return NULL;
     }
@@ -2480,13 +2548,7 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
 {
   bin_tree_t *tree = NULL, *old_tree = NULL;
   int i, start, end, start_idx = re_string_cur_idx (regexp);
-#ifndef RE_TOKEN_INIT_BUG
   re_token_t start_token = *token;
-#else
-  re_token_t start_token;
-
-  memcpy ((void *) &start_token, (void *) token, sizeof start_token);
-#endif
 
   if (token->type == OP_OPEN_DUP_NUM)
     {
@@ -2571,13 +2633,15 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
 
       /* Duplicate ELEM before it is marked optional.  */
       elem = duplicate_tree (elem, dfa);
+      if (BE (elem == NULL, 0))
+        goto parse_dup_op_espace;
       old_tree = tree;
     }
   else
     old_tree = NULL;
 
   if (elem->token.type == SUBEXP)
-    postorder (elem, mark_opt_subexp, (void *) (intptr_t) elem->token.opr.idx);
+    postorder (elem, mark_opt_subexp, (void *) (long) elem->token.opr.idx);
 
   tree = create_tree (dfa, elem, NULL, (end == -1 ? OP_DUP_ASTERISK : OP_ALT));
   if (BE (tree == NULL, 0))
@@ -2623,11 +2687,12 @@ parse_dup_op (bin_tree_t *elem, re_string_t *regexp, re_dfa_t *dfa,
 static reg_errcode_t
 internal_function
 # ifdef RE_ENABLE_I18N
-build_range_exp (bitset_t sbcset, re_charset_t *mbcset, int *range_alloc,
-		 bracket_elem_t *start_elem, bracket_elem_t *end_elem)
+build_range_exp (reg_syntax_t syntax, bitset_t sbcset, re_charset_t *mbcset,
+		int *range_alloc, bracket_elem_t *start_elem,
+		bracket_elem_t *end_elem)
 # else /* not RE_ENABLE_I18N */
-build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
-		 bracket_elem_t *end_elem)
+build_range_exp (reg_syntax_t syntax, bitset_t sbcset,
+		bracket_elem_t *start_elem, bracket_elem_t *end_elem)
 # endif /* not RE_ENABLE_I18N */
 {
   unsigned int start_ch, end_ch;
@@ -2650,7 +2715,6 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
     wchar_t wc;
     wint_t start_wc;
     wint_t end_wc;
-    wchar_t cmp_buf[6] = {L'\0', L'\0', L'\0', L'\0', L'\0', L'\0'};
 
     start_ch = ((start_elem->type == SB_CHAR) ? start_elem->opr.ch
 		: ((start_elem->type == COLL_SYM) ? start_elem->opr.name[0]
@@ -2676,9 +2740,7 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
 #endif
     if (start_wc == WEOF || end_wc == WEOF)
       return REG_ECOLLATE;
-    cmp_buf[0] = start_wc;
-    cmp_buf[4] = end_wc;
-    if (wcscoll (cmp_buf, cmp_buf + 4) > 0)
+    else if (BE ((syntax & RE_NO_EMPTY_RANGES) && start_wc > end_wc, 0))
       return REG_ERANGE;
 
     /* Got valid collation sequence values, add them as a new entry.
@@ -2705,7 +2767,14 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
 					new_nranges);
 
 	    if (BE (new_array_start == NULL || new_array_end == NULL, 0))
-	      return REG_ESPACE;
+              {
+                 /* if one is not NULL, free it to avoid leaks */
+                 if (new_array_start != NULL)
+                     re_free(new_array_start);
+                 if (new_array_end != NULL)
+                     re_free(new_array_end);
+	         return REG_ESPACE;
+	      }
 
 	    mbcset->range_starts = new_array_start;
 	    mbcset->range_ends = new_array_end;
@@ -2719,10 +2788,8 @@ build_range_exp (bitset_t sbcset, bracket_elem_t *start_elem,
     /* Build the table for single byte characters.  */
     for (wc = 0; wc < SBC_MAX; ++wc)
       {
-	cmp_buf[2] = wc;
-	if (wcscoll (cmp_buf, cmp_buf + 2) <= 0
-	    && wcscoll (cmp_buf + 2, cmp_buf + 4) <= 0)
-	  bitset_set (sbcset, wc);
+         if (start_wc <= wc && wc <= end_wc)
+           bitset_set (sbcset, wc);
       }
   }
 # else /* not RE_ENABLE_I18N */
@@ -2789,41 +2856,30 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
   const unsigned char *extra;
 
   /* Local function for parse_bracket_exp used in _LIBC environment.
-     Seek the collating symbol entry correspondings to NAME.
-     Return the index of the symbol in the SYMB_TABLE.  */
+     Seek the collating symbol entry corresponding to NAME.
+     Return the index of the symbol in the SYMB_TABLE,
+     or -1 if not found.  */
 
   auto inline int32_t
-  __attribute ((always_inline))
-  seek_collating_symbol_entry (name, name_len)
-	 const unsigned char *name;
-	 size_t name_len;
+  __attribute__ ((always_inline))
+  seek_collating_symbol_entry (const unsigned char *name, size_t name_len)
     {
-      int32_t hash = elem_hash ((const char *) name, name_len);
-      int32_t elem = hash % table_size;
-      if (symb_table[2 * elem] != 0)
-	{
-	  int32_t second = hash % (table_size - 2) + 1;
-
-	  do
-	    {
-	      /* First compare the hashing value.  */
-	      if (symb_table[2 * elem] == hash
-		  /* Compare the length of the name.  */
-		  && name_len == extra[symb_table[2 * elem + 1]]
-		  /* Compare the name.  */
-		  && memcmp (name, &extra[symb_table[2 * elem + 1] + 1],
-			     name_len) == 0)
-		{
-		  /* Yep, this is the entry.  */
-		  break;
-		}
+      int32_t elem;
 
-	      /* Next entry.  */
-	      elem += second;
-	    }
-	  while (symb_table[2 * elem] != 0);
-	}
-      return elem;
+      for (elem = 0; elem < table_size; elem++)
+	if (symb_table[2 * elem] != 0)
+	  {
+	    int32_t idx = symb_table[2 * elem + 1];
+	    /* Skip the name of collating element name.  */
+	    idx += 1 + extra[idx];
+	    if (/* Compare the length of the name.  */
+		name_len == extra[idx]
+		/* Compare the name.  */
+		&& memcmp (name, &extra[idx + 1], name_len) == 0)
+	      /* Yep, this is the entry.  */
+	      return elem;
+	  }
+      return -1;
     }
 
   /* Local function for parse_bracket_exp used in _LIBC environment.
@@ -2831,9 +2887,8 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      Return the value if succeeded, UINT_MAX otherwise.  */
 
   auto inline unsigned int
-  __attribute ((always_inline))
-  lookup_collation_sequence_value (br_elem)
-	 bracket_elem_t *br_elem;
+  __attribute__ ((always_inline))
+  lookup_collation_sequence_value (bracket_elem_t *br_elem)
     {
       if (br_elem->type == SB_CHAR)
 	{
@@ -2861,7 +2916,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
 	      int32_t elem, idx;
 	      elem = seek_collating_symbol_entry (br_elem->opr.name,
 						  sym_name_len);
-	      if (symb_table[2 * elem] != 0)
+	      if (elem != -1)
 		{
 		  /* We found the entry.  */
 		  idx = symb_table[2 * elem + 1];
@@ -2879,7 +2934,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
 		  /* Return the collation sequence value.  */
 		  return *(unsigned int *) (extra + idx);
 		}
-	      else if (symb_table[2 * elem] == 0 && sym_name_len == 1)
+	      else if (sym_name_len == 1)
 		{
 		  /* No valid character.  Match it as a single byte
 		     character.  */
@@ -2900,12 +2955,9 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      update it.  */
 
   auto inline reg_errcode_t
-  __attribute ((always_inline))
-  build_range_exp (sbcset, mbcset, range_alloc, start_elem, end_elem)
-	 re_charset_t *mbcset;
-	 int *range_alloc;
-	 bitset_t sbcset;
-	 bracket_elem_t *start_elem, *end_elem;
+  __attribute__ ((always_inline))
+  build_range_exp (bitset_t sbcset, re_charset_t *mbcset, int *range_alloc,
+		   bracket_elem_t *start_elem, bracket_elem_t *end_elem)
     {
       unsigned int ch;
       uint32_t start_collseq;
@@ -2983,26 +3035,23 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
      pointer argument since we may update it.  */
 
   auto inline reg_errcode_t
-  __attribute ((always_inline))
-  build_collating_symbol (sbcset, mbcset, coll_sym_alloc, name)
-	 re_charset_t *mbcset;
-	 int *coll_sym_alloc;
-	 bitset_t sbcset;
-	 const unsigned char *name;
+  __attribute__ ((always_inline))
+  build_collating_symbol (bitset_t sbcset, re_charset_t *mbcset,
+			  int *coll_sym_alloc, const unsigned char *name)
     {
       int32_t elem, idx;
       size_t name_len = strlen ((const char *) name);
       if (nrules != 0)
 	{
 	  elem = seek_collating_symbol_entry (name, name_len);
-	  if (symb_table[2 * elem] != 0)
+	  if (elem != -1)
 	    {
 	      /* We found the entry.  */
 	      idx = symb_table[2 * elem + 1];
 	      /* Skip the name of collating element name.  */
 	      idx += 1 + extra[idx];
 	    }
-	  else if (symb_table[2 * elem] == 0 && name_len == 1)
+	  else if (name_len == 1)
 	    {
 	      /* No valid character, treat it as a normal
 		 character.  */
@@ -3082,6 +3131,10 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
   if (BE (sbcset == NULL, 0))
 #endif /* RE_ENABLE_I18N */
     {
+      re_free (sbcset);
+#ifdef RE_ENABLE_I18N
+      re_free (mbcset);
+#endif
       *err = REG_ESPACE;
       return NULL;
     }
@@ -3123,6 +3176,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
       re_token_t token2;
 
       start_elem.opr.name = start_name_buf;
+      start_elem.type = COLL_SYM;
       ret = parse_bracket_element (&start_elem, regexp, token, token_len, dfa,
 				   syntax, first_round);
       if (BE (ret != REG_NOERROR, 0))
@@ -3166,6 +3220,7 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
       if (is_range_exp == 1)
 	{
 	  end_elem.opr.name = end_name_buf;
+	  end_elem.type = COLL_SYM;
 	  ret = parse_bracket_element (&end_elem, regexp, &token2, token_len2,
 				       dfa, syntax, 1);
 	  if (BE (ret != REG_NOERROR, 0))
@@ -3177,15 +3232,15 @@ parse_bracket_exp (re_string_t *regexp, re_dfa_t *dfa, re_token_t *token,
 	  token_len = peek_token_bracket (token, regexp, syntax);
 
 #ifdef _LIBC
-	  *err = build_range_exp (sbcset, mbcset, &range_alloc,
+	  *err = build_range_exp (syntax, sbcset, mbcset, &range_alloc,
 				  &start_elem, &end_elem);
 #else
 # ifdef RE_ENABLE_I18N
-	  *err = build_range_exp (sbcset,
+	  *err = build_range_exp (syntax, sbcset,
 				  dfa->mb_cur_max > 1 ? mbcset : NULL,
 				  &range_alloc, &start_elem, &end_elem);
 # else
-	  *err = build_range_exp (sbcset, &start_elem, &end_elem);
+	  *err = build_range_exp (syntax, sbcset, &start_elem, &end_elem);
 # endif
 #endif /* RE_ENABLE_I18N */
 	  if (BE (*err != REG_NOERROR, 0))
@@ -3439,8 +3494,6 @@ build_equiv_class (bitset_t sbcset, const unsigned char *name)
       int32_t idx1, idx2;
       unsigned int ch;
       size_t len;
-      /* This #include defines a local function!  */
-# include <locale/weight.h>
       /* Calculate the index for equivalence class.  */
       cp = name;
       table = (const int32_t *) _NL_CURRENT (LC_COLLATE, _NL_COLLATE_TABLEMB);
@@ -3450,19 +3503,19 @@ build_equiv_class (bitset_t sbcset, const unsigned char *name)
 						   _NL_COLLATE_EXTRAMB);
       indirect = (const int32_t *) _NL_CURRENT (LC_COLLATE,
 						_NL_COLLATE_INDIRECTMB);
-      idx1 = findidx (&cp);
-      if (BE (idx1 == 0 || cp < name + strlen ((const char *) name), 0))
+      idx1 = findidx (table, indirect, extra, &cp, -1);
+      if (BE (idx1 == 0 || *cp != '\0', 0))
 	/* This isn't a valid character.  */
 	return REG_ECOLLATE;
 
-      /* Build single byte matcing table for this equivalence class.  */
+      /* Build single byte matching table for this equivalence class.  */
       char_buf[1] = (unsigned char) '\0';
       len = weights[idx1 & 0xffffff];
       for (ch = 0; ch < SBC_MAX; ++ch)
 	{
 	  char_buf[0] = ch;
 	  cp = char_buf;
-	  idx2 = findidx (&cp);
+	  idx2 = findidx (table, indirect, extra, &cp, 1);
 /*
 	  idx2 = table[ch];
 */
@@ -3630,6 +3683,13 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
   if (BE (sbcset == NULL, 0))
 #endif /* not RE_ENABLE_I18N */
     {
+      /* if one is not NULL, free it to avoid leaks */
+      if (sbcset != NULL)
+         free(sbcset);
+#ifdef RE_ENABLE_I18N
+      if (mbcset != NULL)
+         free(mbcset);
+#endif
       *err = REG_ESPACE;
       return NULL;
     }
@@ -3672,6 +3732,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
 #endif
 
   /* Build a tree for simple bracket.  */
+  memset(& br_token, 0, sizeof(br_token));	/* silence "not initialized" errors froms static checkers */
   br_token.type = SIMPLE_BRACKET;
   br_token.opr.sbcset = sbcset;
   tree = create_token_tree (dfa, NULL, NULL, &br_token);
@@ -3715,7 +3776,7 @@ build_charclass_op (re_dfa_t *dfa, RE_TRANSLATE_TYPE trans,
 /* This is intended for the expressions like "a{1,3}".
    Fetch a number from `input', and return the number.
    Return -1, if the number field is empty like "{,1}".
-   Return -2, if an error has occurred.  */
+   Return -2, If an error is occured.  */
 
 static int
 fetch_number (re_string_t *input, re_token_t *token, reg_syntax_t syntax)
@@ -3762,6 +3823,7 @@ create_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
 	     re_token_type_t type)
 {
   re_token_t t;
+  memset(& t, 0, sizeof(t));	/* silence "not initialized" errors froms static checkers */
   t.type = type;
   return create_token_tree (dfa, left, right, &t);
 }
@@ -3806,7 +3868,7 @@ create_token_tree (re_dfa_t *dfa, bin_tree_t *left, bin_tree_t *right,
 static reg_errcode_t
 mark_opt_subexp (void *extra, bin_tree_t *node)
 {
-  int idx = (int) (intptr_t) extra;
+  int idx = (int) (long) extra;
   if (node->token.type == SUBEXP && node->token.opr.idx == idx)
     node->token.opt_subexp = 1;
 
-- 
2.11.0

