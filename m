Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC40E207D6
	for <e@80x24.org>; Thu,  4 May 2017 22:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbdEDWBc (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 18:01:32 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36264 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752400AbdEDWBb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 18:01:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so2693617wrc.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0MANRvA2kWRC4anL82T9N9v0HiTqQqBJuRTP5IYPH9U=;
        b=Z2Ch2arXqeIbWjyV40O604N0RPYtpCs8oCbAUmeroosx7EbEVEh7YEQ+AL5kVeB6Y6
         t+A1mO8FWPpSmm9vK1ph3wOH1gWIwFADAwrg82WVMC9MgbjQrrcCQN7/KgrQRRy9Ckeh
         bRVpNYI5GkMadS1Ttpokpsjz8DCLs3u2ButP/sObgXW/oCai1POM6NJMA0UKFWRi6POm
         1oak31Du1TXXGMtgyRYkoSA4apyw0Df94dahfX3vW0/XU6Ihlbhzs1KQAcHf6PumlTRa
         xs17NKw8RTpNzTRRHZOdRAXyxwaoNh/mK4QLwdWI9q6H6Su0fDXFWytO3v2xGnu8D9/2
         mUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0MANRvA2kWRC4anL82T9N9v0HiTqQqBJuRTP5IYPH9U=;
        b=nhqzuEn3BImG25XNhCZ6mTgl8B+fWnd78720AVuHzqgOpMUaXCM7Bs6f/5qLPbda9B
         eBNaeOEqnEr98bbh4qGmcleNX7QsRnOyqdwfb6AEinbnuoSWRJWq45F+MN6EpfQqvjRj
         K9cbGGZ2cu1kMInxhHXAg9c1sxq4lpGTZPSmQfrrdbU1V3Rb7WW50WEqc4hnJ0HGULaE
         c9FhF3CQPI7v5EIEWJf7YpIwyriPmgDl3Gv8VV+RutAl7oR2CVjovWaf3HStED3tDyk8
         gYzeO8IPObPkQ5e6EjISBkro5Je5x10eHRgVkWqCcZvunGmECxLOjW1A7+hY+SEjDw6Z
         gx7Q==
X-Gm-Message-State: AN3rC/6wdRi2b3RQonSK/blc71NerZdoCZYsI/SpgFyfzYZNCaeBnkVE
        qxto9of4PUZFmw==
X-Received: by 10.223.131.196 with SMTP id 62mr17413058wre.162.1493935289572;
        Thu, 04 May 2017 15:01:29 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w136sm2424680wmd.0.2017.05.04.15.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 15:01:28 -0700 (PDT)
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
Subject: [PATCH 5/7] fixup! compat/regex: update the gawk regex engine from upstream
Date:   Thu,  4 May 2017 22:00:41 +0000
Message-Id: <20170504220043.25702-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170504220043.25702-1-avarab@gmail.com>
References: <20170504220043.25702-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 compat/regex/regex_internal.c | 118 +++++++++++++++++++++++++-----------------
 compat/regex/regex_internal.h | 118 ++++++++++++++++++++++++++----------------
 2 files changed, 144 insertions(+), 92 deletions(-)

diff --git a/compat/regex/regex_internal.c b/compat/regex/regex_internal.c
index d4121f2f4f..6d766114a1 100644
--- a/compat/regex/regex_internal.c
+++ b/compat/regex/regex_internal.c
@@ -1,5 +1,12 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
 /* Extended regular expression matching and search library.
-   Copyright (C) 2002-2006, 2010 Free Software Foundation, Inc.
+   Copyright (C) 2002-2016 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Isamu Hasegawa <isamu@yamato.ibm.com>.
 
@@ -14,9 +21,8 @@
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-   02110-1301 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
 static void re_string_construct_common (const char *str, int len,
 					re_string_t *pstr,
@@ -45,7 +51,7 @@ MAX(size_t a, size_t b)
    re_string_reconstruct before using the object.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_string_allocate (re_string_t *pstr, const char *str, int len, int init_len,
 		    RE_TRANSLATE_TYPE trans, int icase, const re_dfa_t *dfa)
 {
@@ -73,7 +79,7 @@ re_string_allocate (re_string_t *pstr, const char *str, int len, int init_len,
 /* This function allocate the buffers, and initialize them.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_string_construct (re_string_t *pstr, const char *str, int len,
 		     RE_TRANSLATE_TYPE trans, int icase, const re_dfa_t *dfa)
 {
@@ -136,7 +142,7 @@ re_string_construct (re_string_t *pstr, const char *str, int len,
 /* Helper functions for re_string_allocate, and re_string_construct.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_string_realloc_buffers (re_string_t *pstr, int new_buf_len)
 {
 #ifdef RE_ENABLE_I18N
@@ -246,13 +252,8 @@ build_wcs_buffer (re_string_t *pstr)
       else
 	p = (const char *) pstr->raw_mbs + pstr->raw_mbs_idx + byte_idx;
       mbclen = __mbrtowc (&wc, p, remain_len, &pstr->cur_state);
-      if (BE (mbclen == (size_t) -2, 0))
-	{
-	  /* The buffer doesn't have enough space, finish to build.  */
-	  pstr->cur_state = prev_st;
-	  break;
-	}
-      else if (BE (mbclen == (size_t) -1 || mbclen == 0, 0))
+      if (BE (mbclen == (size_t) -1 || mbclen == 0
+	      || (mbclen == (size_t) -2 && pstr->bufs_len >= pstr->len), 0))
 	{
 	  /* We treat these cases as a singlebyte character.  */
 	  mbclen = 1;
@@ -261,6 +262,12 @@ build_wcs_buffer (re_string_t *pstr)
 	    wc = pstr->trans[wc];
 	  pstr->cur_state = prev_st;
 	}
+      else if (BE (mbclen == (size_t) -2, 0))
+	{
+	  /* The buffer doesn't have enough space, finish to build.  */
+	  pstr->cur_state = prev_st;
+	  break;
+	}
 
       /* Write wide character and padding.  */
       pstr->wcs[byte_idx++] = wc;
@@ -276,7 +283,7 @@ build_wcs_buffer (re_string_t *pstr)
    but for REG_ICASE.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 build_wcs_upper_buffer (re_string_t *pstr)
 {
   mbstate_t prev_st;
@@ -326,7 +333,7 @@ build_wcs_upper_buffer (re_string_t *pstr)
 		  size_t mbcdlen;
 
 		  wcu = towupper (wc);
-		  mbcdlen = wcrtomb (buf, wcu, &prev_st);
+		  mbcdlen = __wcrtomb (buf, wcu, &prev_st);
 		  if (BE (mbclen == mbcdlen, 1))
 		    memcpy (pstr->mbs + byte_idx, buf, mbclen);
 		  else
@@ -343,9 +350,11 @@ build_wcs_upper_buffer (re_string_t *pstr)
 	      for (remain_len = byte_idx + mbclen - 1; byte_idx < remain_len ;)
 		pstr->wcs[byte_idx++] = WEOF;
 	    }
-	  else if (mbclen == (size_t) -1 || mbclen == 0)
+	  else if (mbclen == (size_t) -1 || mbclen == 0
+		   || (mbclen == (size_t) -2 && pstr->bufs_len >= pstr->len))
 	    {
-	      /* It is an invalid character or '\0'.  Just use the byte.  */
+	      /* It is an invalid character, an incomplete character
+		 at the end of the string, or '\0'.  Just use the byte.  */
 	      int ch = pstr->raw_mbs[pstr->raw_mbs_idx + byte_idx];
 	      pstr->mbs[byte_idx] = ch;
 	      /* And also cast it to wide char.  */
@@ -458,7 +467,8 @@ build_wcs_upper_buffer (re_string_t *pstr)
 	    for (remain_len = byte_idx + mbclen - 1; byte_idx < remain_len ;)
 	      pstr->wcs[byte_idx++] = WEOF;
 	  }
-	else if (mbclen == (size_t) -1 || mbclen == 0)
+	else if (mbclen == (size_t) -1 || mbclen == 0
+		 || (mbclen == (size_t) -2 && pstr->bufs_len >= pstr->len))
 	  {
 	    /* It is an invalid character or '\0'.  Just use the byte.  */
 	    int ch = pstr->raw_mbs[pstr->raw_mbs_idx + src_idx];
@@ -505,11 +515,11 @@ re_string_skip_chars (re_string_t *pstr, int new_raw_idx, wint_t *last_wc)
        rawbuf_idx < new_raw_idx;)
     {
       wchar_t wc2;
-      int remain_len = pstr->len - rawbuf_idx;
+      int remain_len = pstr->raw_len - rawbuf_idx;
       prev_st = pstr->cur_state;
       mbclen = __mbrtowc (&wc2, (const char *) pstr->raw_mbs + rawbuf_idx,
 			  remain_len, &pstr->cur_state);
-      if (BE (mbclen == (size_t) -2 || mbclen == (size_t) -1 || mbclen == 0, 0))
+      if (BE ((ssize_t) mbclen <= 0, 0))
 	{
 	  /* We treat these cases as a single byte character.  */
 	  if (mbclen == 0 || remain_len == 0)
@@ -577,7 +587,7 @@ re_string_translate_buffer (re_string_t *pstr)
    convert to upper case in case of REG_ICASE, apply translation.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 {
   int offset = idx - pstr->raw_mbs_idx;
@@ -685,7 +695,7 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 			 pstr->valid_len - offset);
 	      pstr->valid_len -= offset;
 	      pstr->valid_raw_len -= offset;
-#if DEBUG
+#if defined DEBUG && DEBUG
 	      assert (pstr->valid_len > 0);
 #endif
 	    }
@@ -741,16 +751,18 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 			  unsigned char buf[6];
 			  size_t mbclen;
 
+			  const unsigned char *pp = p;
 			  if (BE (pstr->trans != NULL, 0))
 			    {
 			      int i = mlen < 6 ? mlen : 6;
 			      while (--i >= 0)
 				buf[i] = pstr->trans[p[i]];
+			      pp = buf;
 			    }
 			  /* XXX Don't use mbrtowc, we know which conversion
 			     to use (UTF-8 -> UCS4).  */
 			  memset (&cur_state, 0, sizeof (cur_state));
-			  mbclen = __mbrtowc (&wc2, (const char *) p, mlen,
+			  mbclen = __mbrtowc (&wc2, (const char *) pp, mlen,
 					      &cur_state);
 			  if (raw + offset - p <= mbclen
 			      && mbclen < (size_t) -2)
@@ -835,7 +847,7 @@ re_string_reconstruct (re_string_t *pstr, int idx, int eflags)
 }
 
 static unsigned char
-internal_function __attribute ((pure))
+internal_function __attribute__ ((__pure__))
 re_string_peek_byte_case (const re_string_t *pstr, int idx)
 {
   int ch, off;
@@ -871,7 +883,7 @@ re_string_peek_byte_case (const re_string_t *pstr, int idx)
 }
 
 static unsigned char
-internal_function __attribute ((pure))
+internal_function
 re_string_fetch_byte_case (re_string_t *pstr)
 {
   if (BE (!pstr->mbs_allocated, 1))
@@ -940,7 +952,7 @@ re_string_context_at (const re_string_t *input, int idx, int eflags)
       int wc_idx = idx;
       while(input->wcs[wc_idx] == WEOF)
 	{
-#ifdef DEBUG
+#if defined DEBUG && DEBUG
 	  /* It must not happen.  */
 	  assert (wc_idx >= 0);
 #endif
@@ -967,7 +979,7 @@ re_string_context_at (const re_string_t *input, int idx, int eflags)
 /* Functions for set operation.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_alloc (re_node_set *set, int size)
 {
   /*
@@ -989,7 +1001,7 @@ re_node_set_alloc (re_node_set *set, int size)
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_init_1 (re_node_set *set, int elem)
 {
   set->alloc = 1;
@@ -1005,7 +1017,7 @@ re_node_set_init_1 (re_node_set *set, int elem)
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_init_2 (re_node_set *set, int elem1, int elem2)
 {
   set->alloc = 2;
@@ -1035,7 +1047,7 @@ re_node_set_init_2 (re_node_set *set, int elem1, int elem2)
 }
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_init_copy (re_node_set *dest, const re_node_set *src)
 {
   dest->nelem = src->nelem;
@@ -1060,7 +1072,7 @@ re_node_set_init_copy (re_node_set *dest, const re_node_set *src)
    Note: We assume dest->elems is NULL, when dest->alloc is 0.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_add_intersect (re_node_set *dest, const re_node_set *src1,
 			   const re_node_set *src2)
 {
@@ -1151,7 +1163,7 @@ re_node_set_add_intersect (re_node_set *dest, const re_node_set *src1,
    DEST. Return value indicate the error code or REG_NOERROR if succeeded.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_init_union (re_node_set *dest, const re_node_set *src1,
 			const re_node_set *src2)
 {
@@ -1204,7 +1216,7 @@ re_node_set_init_union (re_node_set *dest, const re_node_set *src1,
    DEST. Return value indicate the error code or REG_NOERROR if succeeded.  */
 
 static reg_errcode_t
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_merge (re_node_set *dest, const re_node_set *src)
 {
   int is, id, sbase, delta;
@@ -1284,10 +1296,10 @@ re_node_set_merge (re_node_set *dest, const re_node_set *src)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have ELEM.
-   return -1 if an error has occurred, return 1 otherwise.  */
+   return -1 if an error is occured, return 1 otherwise.  */
 
 static int
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_insert (re_node_set *set, int elem)
 {
   int idx;
@@ -1341,10 +1353,10 @@ re_node_set_insert (re_node_set *set, int elem)
 
 /* Insert the new element ELEM to the re_node_set* SET.
    SET should not already have any element greater than or equal to ELEM.
-   Return -1 if an error has occurred, return 1 otherwise.  */
+   Return -1 if an error is occured, return 1 otherwise.  */
 
 static int
-internal_function
+internal_function __attribute_warn_unused_result__
 re_node_set_insert_last (re_node_set *set, int elem)
 {
   /* Realloc if we need.  */
@@ -1367,7 +1379,7 @@ re_node_set_insert_last (re_node_set *set, int elem)
    return 1 if SET1 and SET2 are equivalent, return 0 otherwise.  */
 
 static int
-internal_function __attribute ((pure))
+internal_function __attribute__ ((__pure__))
 re_node_set_compare (const re_node_set *set1, const re_node_set *set2)
 {
   int i;
@@ -1382,7 +1394,7 @@ re_node_set_compare (const re_node_set *set1, const re_node_set *set2)
 /* Return (idx + 1) if SET contains the element ELEM, return 0 otherwise.  */
 
 static int
-internal_function __attribute ((pure))
+internal_function __attribute__ ((__pure__))
 re_node_set_contains (const re_node_set *set, int elem)
 {
   unsigned int idx, right, mid;
@@ -1416,7 +1428,7 @@ re_node_set_remove_at (re_node_set *set, int idx)
 
 
 /* Add the token TOKEN to dfa->nodes, and return the index of the token.
-   Or return -1, if an error has occurred.  */
+   Or return -1, if an error will be occured.  */
 
 static int
 internal_function
@@ -1446,7 +1458,18 @@ re_dfa_add_node (re_dfa_t *dfa, re_token_t token)
       new_eclosures = re_realloc (dfa->eclosures, re_node_set, new_nodes_alloc);
       if (BE (new_nexts == NULL || new_indices == NULL
 	      || new_edests == NULL || new_eclosures == NULL, 0))
-	return -1;
+        {
+	   /* if any are not NULL, free them, avoid leaks */
+	   if (new_nexts != NULL)
+              re_free(new_nexts);
+	   if (new_indices != NULL)
+              re_free(new_indices);
+	   if (new_edests != NULL)
+              re_free(new_edests);
+	   if (new_eclosures != NULL)
+              re_free(new_eclosures);
+	   return -1;
+	}
       dfa->nexts = new_nexts;
       dfa->org_indices = new_indices;
       dfa->edests = new_edests;
@@ -1486,7 +1509,7 @@ calc_state_hash (const re_node_set *nodes, unsigned int context)
 	   optimization.  */
 
 static re_dfastate_t *
-internal_function
+internal_function __attribute_warn_unused_result__
 re_acquire_state (reg_errcode_t *err, const re_dfa_t *dfa,
 		  const re_node_set *nodes)
 {
@@ -1530,7 +1553,7 @@ re_acquire_state (reg_errcode_t *err, const re_dfa_t *dfa,
 	   optimization.  */
 
 static re_dfastate_t *
-internal_function
+internal_function __attribute_warn_unused_result__
 re_acquire_state_context (reg_errcode_t *err, const re_dfa_t *dfa,
 			  const re_node_set *nodes, unsigned int context)
 {
@@ -1567,6 +1590,7 @@ re_acquire_state_context (reg_errcode_t *err, const re_dfa_t *dfa,
    indicates the error code if failed.  */
 
 static reg_errcode_t
+__attribute_warn_unused_result__
 register_state (const re_dfa_t *dfa, re_dfastate_t *newstate,
 		unsigned int hash)
 {
@@ -1617,11 +1641,11 @@ free_state (re_dfastate_t *state)
   re_free (state);
 }
 
-/* Create the new state which is independ of contexts.
+/* Create the new state which is independent of contexts.
    Return the new state if succeeded, otherwise return NULL.  */
 
 static re_dfastate_t *
-internal_function
+internal_function __attribute_warn_unused_result__
 create_ci_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
 		    unsigned int hash)
 {
@@ -1671,7 +1695,7 @@ create_ci_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
    Return the new state if succeeded, otherwise return NULL.  */
 
 static re_dfastate_t *
-internal_function
+internal_function __attribute_warn_unused_result__
 create_cd_newstate (const re_dfa_t *dfa, const re_node_set *nodes,
 		    unsigned int context, unsigned int hash)
 {
diff --git a/compat/regex/regex_internal.h b/compat/regex/regex_internal.h
index 4184d7f5a6..9c88a6a57b 100644
--- a/compat/regex/regex_internal.h
+++ b/compat/regex/regex_internal.h
@@ -1,5 +1,12 @@
+/*
+ * This is git.git's copy of gawk.git's regex engine. Please see that
+ * project for the latest version & to submit patches to this code,
+ * and git.git's compat/regex/README for information on how git's copy
+ * of this code is maintained.
+ */
+
 /* Extended regular expression matching and search library.
-   Copyright (C) 2002-2005, 2007, 2008, 2010 Free Software Foundation, Inc.
+   Copyright (C) 2002-2016 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
    Contributed by Isamu Hasegawa <isamu@yamato.ibm.com>.
 
@@ -14,9 +21,8 @@
    Lesser General Public License for more details.
 
    You should have received a copy of the GNU Lesser General Public
-   License along with the GNU C Library; if not, write to the Free
-   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
-   02111-1307 USA.  */
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
 
 #ifndef _REGEX_INTERNAL_H
 #define _REGEX_INTERNAL_H 1
@@ -42,13 +48,14 @@
 #if defined HAVE_STDBOOL_H || defined _LIBC
 # include <stdbool.h>
 #endif /* HAVE_STDBOOL_H || _LIBC */
-#if !defined(ZOS_USS)
 #if defined HAVE_STDINT_H || defined _LIBC
 # include <stdint.h>
 #endif /* HAVE_STDINT_H || _LIBC */
-#endif /* !ZOS_USS */
+ 
+#include "intprops.h"
+
 #if defined _LIBC
-# include <bits/libc-lock.h>
+# include <libc-lock.h>
 #else
 # define __libc_lock_define(CLASS,NAME)
 # define __libc_lock_init(NAME) do { } while (0)
@@ -80,7 +87,6 @@ is_blank (int c)
 # ifndef _RE_DEFINE_LOCALE_FUNCTIONS
 #  define _RE_DEFINE_LOCALE_FUNCTIONS 1
 #   include <locale/localeinfo.h>
-#   include <locale/elem-hash.h>
 #   include <locale/coll-lookup.h>
 # endif
 #endif
@@ -91,7 +97,7 @@ is_blank (int c)
 # ifdef _LIBC
 #  undef gettext
 #  define gettext(msgid) \
-  INTUSE(__dcgettext) (_libc_intl_domainname, msgid, LC_MESSAGES)
+  __dcgettext (_libc_intl_domainname, msgid, LC_MESSAGES)
 # endif
 #else
 # define gettext(msgid) (msgid)
@@ -108,14 +114,7 @@ is_blank (int c)
 # define SIZE_MAX ((size_t) -1)
 #endif
 
-#ifndef NO_MBSUPPORT
-#include "mbsupport.h" /* gawk */
-#endif
-#ifndef MB_CUR_MAX
-#define MB_CUR_MAX 1
-#endif
-
-#if (defined MBS_SUPPORT) || _LIBC
+#if ! defined(__DJGPP__) && (defined(GAWK) || _LIBC)
 # define RE_ENABLE_I18N
 #endif
 
@@ -154,17 +153,20 @@ is_blank (int c)
 # define __mempcpy mempcpy
 # define __wcrtomb wcrtomb
 # define __regfree regfree
-# define attribute_hidden
 #endif /* not _LIBC */
 
-#ifdef __GNUC__
-# define __attribute(arg) __attribute__ (arg)
-#else
-# define __attribute(arg)
+#if __GNUC__ < 3 + (__GNUC_MINOR__ < 1)
+# define __attribute__(arg)
 #endif
 
-extern const char __re_error_msgid[] attribute_hidden;
-extern const size_t __re_error_msgid_idx[] attribute_hidden;
+#ifdef GAWK
+/*
+ * Instead of trying to figure out which GCC version introduced
+ * this symbol, just define it out and be done.
+ */
+# undef __attribute_warn_unused_result__
+# define __attribute_warn_unused_result__
+#endif
 
 /* An integer used to represent a set of bits.  It must be unsigned,
    and must be at least as wide as unsigned int.  */
@@ -414,7 +416,7 @@ typedef struct re_dfa_t re_dfa_t;
 
 #ifndef _LIBC
 # ifdef __i386__
-#  define internal_function   __attribute ((regparm (3), stdcall))
+#  define internal_function   __attribute__ ((regparm (3), stdcall))
 # else
 #  define internal_function
 # endif
@@ -433,7 +435,7 @@ static void build_upper_buffer (re_string_t *pstr) internal_function;
 static void re_string_translate_buffer (re_string_t *pstr) internal_function;
 static unsigned int re_string_context_at (const re_string_t *input, int idx,
 					  int eflags)
-     internal_function __attribute ((pure));
+     internal_function __attribute__ ((pure));
 #endif
 #define re_string_peek_byte(pstr, offset) \
   ((pstr)->mbs[(pstr)->cur_idx + offset])
@@ -454,26 +456,50 @@ static unsigned int re_string_context_at (const re_string_t *input, int idx,
 
 #ifndef _LIBC
 # if HAVE_ALLOCA
-#  if (_MSC_VER)
-#   include <malloc.h>
-#   define __libc_use_alloca(n) 0
-#  else
-#   include <alloca.h>
+#  include <alloca.h>
 /* The OS usually guarantees only one guard page at the bottom of the stack,
    and a page size can be as small as 4096 bytes.  So we cannot safely
    allocate anything larger than 4096 bytes.  Also care for the possibility
    of a few compiler-allocated temporary stack slots.  */
 #  define __libc_use_alloca(n) ((n) < 4032)
-#  endif
 # else
 /* alloca is implemented with malloc, so just use malloc.  */
 #  define __libc_use_alloca(n) 0
 # endif
 #endif
 
+/*
+ * GAWK checks for zero-size allocations everywhere else,
+ * do it here too.
+ */
+#ifndef GAWK
 #define re_malloc(t,n) ((t *) malloc ((n) * sizeof (t)))
-/* SunOS 4.1.x realloc doesn't accept null pointers: pre-Standard C. Sigh. */
-#define re_realloc(p,t,n) ((p != NULL) ? (t *) realloc (p,(n)*sizeof(t)) : (t *) calloc(n,sizeof(t)))
+#define re_realloc(p,t,n) ((t *) realloc (p, (n) * sizeof (t)))
+#else
+static void *
+test_malloc(size_t count, const char *file, size_t line)
+{
+	if (count == 0) {
+		fprintf(stderr, "%s:%lu: allocation of zero bytes\n",
+				file, (unsigned long) line);
+		exit(1);
+	}
+	return malloc(count);
+}
+
+static void *
+test_realloc(void *p, size_t count, const char *file, size_t line)
+{
+	if (count == 0) {
+		fprintf(stderr, "%s:%lu: reallocation of zero bytes\n",
+				file, (unsigned long) line);
+		exit(1);
+	}
+	return realloc(p, count);
+}
+#define re_malloc(t,n) ((t *) test_malloc (((n) * sizeof (t)), __FILE__, __LINE__))
+#define re_realloc(p,t,n) ((t *) test_realloc (p, (n) * sizeof (t), __FILE__, __LINE__))
+#endif
 #define re_free(p) free (p)
 
 struct bin_tree_t
@@ -729,7 +755,7 @@ typedef struct
 
 
 /* Inline functions for bitset operation.  */
-static inline void
+static void __attribute__ ((unused))
 bitset_not (bitset_t set)
 {
   int bitset_i;
@@ -737,7 +763,7 @@ bitset_not (bitset_t set)
     set[bitset_i] = ~set[bitset_i];
 }
 
-static inline void
+static void __attribute__ ((unused))
 bitset_merge (bitset_t dest, const bitset_t src)
 {
   int bitset_i;
@@ -745,7 +771,7 @@ bitset_merge (bitset_t dest, const bitset_t src)
     dest[bitset_i] |= src[bitset_i];
 }
 
-static inline void
+static void __attribute__ ((unused))
 bitset_mask (bitset_t dest, const bitset_t src)
 {
   int bitset_i;
@@ -755,8 +781,8 @@ bitset_mask (bitset_t dest, const bitset_t src)
 
 #ifdef RE_ENABLE_I18N
 /* Inline functions for re_string.  */
-static inline int
-internal_function __attribute ((pure))
+static int
+internal_function __attribute__ ((pure, unused))
 re_string_char_size_at (const re_string_t *pstr, int idx)
 {
   int byte_idx;
@@ -768,8 +794,8 @@ re_string_char_size_at (const re_string_t *pstr, int idx)
   return byte_idx;
 }
 
-static inline wint_t
-internal_function __attribute ((pure))
+static wint_t
+internal_function __attribute__ ((pure, unused))
 re_string_wchar_at (const re_string_t *pstr, int idx)
 {
   if (pstr->mb_cur_max == 1)
@@ -778,15 +804,17 @@ re_string_wchar_at (const re_string_t *pstr, int idx)
 }
 
 # ifndef NOT_IN_libc
+#  ifdef _LIBC
+#   include <locale/weight.h>
+#  endif
+
 static int
-internal_function __attribute ((pure))
+internal_function __attribute__ ((pure, unused))
 re_string_elem_size_at (const re_string_t *pstr, int idx)
 {
 #  ifdef _LIBC
   const unsigned char *p, *extra;
   const int32_t *table, *indirect;
-  int32_t tmp;
-#   include <locale/weight.h>
   uint_fast32_t nrules = _NL_CURRENT_WORD (LC_COLLATE, _NL_COLLATE_NRULES);
 
   if (nrules != 0)
@@ -797,7 +825,7 @@ re_string_elem_size_at (const re_string_t *pstr, int idx)
       indirect = (const int32_t *) _NL_CURRENT (LC_COLLATE,
 						_NL_COLLATE_INDIRECTMB);
       p = pstr->mbs + idx;
-      tmp = findidx (&p);
+      findidx (table, indirect, extra, &p, pstr->len - idx);
       return p - pstr->mbs - idx;
     }
   else
-- 
2.11.0

