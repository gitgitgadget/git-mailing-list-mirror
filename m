From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 00/49] libify apply and use lib in am, part 1
Date: Tue, 24 May 2016 10:59:58 +0200
Message-ID: <CAP8UFD0oU4BM=k=+9ijz86ZH8o63i3EVxqL-XMZaZKdyD7_x-w@mail.gmail.com>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 11:00:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b58CA-0007Hp-7N
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 11:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbcEXJAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 05:00:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36682 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbcEXJAA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 05:00:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id q62so4005116wmg.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=m5CPc0GD1qowIm4mr3nhGXli1+NeZ9DYoY5Z/Vdn8DY=;
        b=oa9V24bHt4veFCVUFRwxYNmlTIAK0Bw15i+2EkqHZLkKYTatx6ndAojqgfpdtm8w3N
         zmYVQR+RTEvBEhfPMnyci+PMf4/8oZe9ibWEKT014lXeuQ0X+oZJ09j7zxUeTlz3o4o7
         snePQivglk6lfKpGekYsssoX+Mfeb1ihtIn5XxbLBW116g+CE9qtcWiKGEjhcGnl7q0F
         eFBZKO87yiFRQB9z6Ea/bbJufkJhIIQFkGuSNYE0AVM+irzDuqguRTa8+OKscLP/LpKq
         p+gIWNu0HTUrtG3kcOu5E513UMgUE4aiWy3lotH9DReIjAG9x0kqhwCu0TZDLiucp0bO
         Mf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=m5CPc0GD1qowIm4mr3nhGXli1+NeZ9DYoY5Z/Vdn8DY=;
        b=SYABgGMVgHf6Bu//+iZn8/4C4gB+OFLGC2Ah/w0hw7g7ZcdU7waWGXvTAxFQaYy++d
         +JY8tpa3TGr2U6bS0e1Lx49KoefjnxjqotGxuamp/wjyttaB4qGXDScWn6FBSXRsQN11
         HMwWarN9SSUc9s3dlLthKUBktELPjgBwGeg+MVujXQazY1eWixeLq2TFPB2Y0p9sNU7t
         m77XAQ4iOkzV7cd9ieBMIb8DGU1oBzInruu+FFyeeuZjULvi592l5HT61POnpc3towba
         T7oalzgC5qPEoX78u8149G9cRy3c3QaBq/MJtmM20IVO0fI0qjWE82KsZ7KEK1G2Rewc
         CAVw==
X-Gm-Message-State: ALyK8tLEBwA8VETi955gj01yW26mGT3A8ZTMBBNOGfQ94Ujpa0z1qTkrKQtnMmsoz4C9OlExVORESqjlZN/P6w==
X-Received: by 10.28.98.215 with SMTP id w206mr12258025wmb.79.1464080398801;
 Tue, 24 May 2016 01:59:58 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 24 May 2016 01:59:58 -0700 (PDT)
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295480>

On Tue, May 24, 2016 at 10:10 AM, Christian Couder
<christian.couder@gmail.com> wrote:
>
> I will send a diff between this version and the 50 first patches of v2
> soon as a reply to this email.

Here is the diff:

diff --git a/builtin/apply.c b/builtin/apply.c
index ec55768..c1c5592 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -59,44 +59,44 @@ struct apply_state {
     struct lock_file *lock_file;
     int newfd;

-    int apply;
+    /* These control what gets looked at and modified */
+    int apply; /* this is not a dry-run */
+    int cached; /* apply to the index only */
+    int check; /* preimage must match working tree, don't actually apply */
+    int check_index; /* preimage must match the indexed version */
+    int update_index; /* check_index && apply */
+
+    /* These control cosmetic aspect of the output */
+    int diffstat; /* just show a diffstat, and don't actually apply */
+    int numstat; /* just show a numeric diffstat, and don't actually apply */
+    int summary; /* just report creation, deletion, etc, and don't
actually apply */
+
+    /* These boolean parameters control how the apply is done */
     int allow_overlap;
     int apply_in_reverse;
     int apply_with_reject;
     int apply_verbosely;
-
-    /* --cached updates only the cache without ever touching the
working tree. */
-    int cached;
-
-    /* --stat does just a diffstat, and doesn't actually apply */
-    int diffstat;
-
-    /* --numstat does numeric diffstat, and doesn't actually apply */
-    int numstat;
-
-    int summary;
-    int threeway;
     int no_add;
+    int threeway;
+    int unidiff_zero;
+    int unsafe_paths;
+
+    /* Other non boolean parameters */
     const char *fake_ancestor;
     const char *patch_input_file;
-    struct string_list limit_by_name;
-    int has_include;
+    int line_termination;
     struct strbuf root;
-    struct string_list symlink_changes;
-
-    /*
-     *  --check turns on checking that the working tree matches the
-     *    files that are being modified, but doesn't apply the patch
-     */
-    int check;
+    int p_value;
+    int p_value_known;
+    unsigned int p_context;

-    /* --index updates the cache as well. */
-    int check_index;
+    /* Exclude and include path parameters */
+    struct string_list limit_by_name;
+    int has_include;

-    int unidiff_zero;
-    int update_index;
-    int unsafe_paths;
-    int line_termination;
+    /* Various "current state" */
+    int linenr; /* current line number */
+    struct string_list symlink_changes; /* we have to track symlinks */

     /*
      * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -106,30 +106,19 @@ struct apply_state {
     int max_change;
     int max_len;

-    /*
-     * Various "current state", notably line numbers and what
-     * file (and how) we're patching right now.. The "is_xxxx"
-     * things are flags, where -1 means "don't know yet".
-     */
-    int linenr;
-
     /*
      * Records filenames that have been touched, in order to handle
      * the case where more than one patches touch the same file.
      */
     struct string_list fn_table;
-
-    int p_value;
-    int p_value_known;
-    unsigned int p_context;

+    /* These control whitespace errors */
+    enum ws_error_action ws_error_action;
+    enum ws_ignore ws_ignore_action;
     const char *whitespace_option;
     int whitespace_error;
     int squelch_whitespace_errors;
     int applied_after_fixing_ws;
-
-    enum ws_error_action ws_error_action;
-    enum ws_ignore ws_ignore_action;
 };

 static const char * const apply_usage[] = {
@@ -4688,6 +4677,15 @@ static void init_apply_state(struct apply_state *state,
         parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
 }

+static void clear_apply_state(struct apply_state *state)
+{
+    string_list_clear(&state->limit_by_name, 0);
+    string_list_clear(&state->symlink_changes, 0);
+    strbuf_release(&state->root);
+
+    /* &state->fn_table is cleared at the end of apply_patch() */
+}
+
 static void check_apply_state(struct apply_state *state, int force_apply)
 {
     int is_not_gitdir = !startup_info->have_repository;
@@ -4790,6 +4788,7 @@ int cmd_apply(int argc, const char **argv, const
char *prefix)
 {
     int force_apply = 0;
     int options = 0;
+    int ret;
     struct apply_state state;

     struct option builtin_apply_options[] = {
@@ -4868,5 +4867,9 @@ int cmd_apply(int argc, const char **argv, const
char *prefix)

     check_apply_state(&state, force_apply);

-    return apply_all_patches(&state, argc, argv, options);
+    ret = apply_all_patches(&state, argc, argv, options);
+
+    clear_apply_state(&state);
+
+    return ret;
 }
