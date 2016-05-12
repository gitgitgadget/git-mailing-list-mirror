From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Thu, 12 May 2016 22:05:54 +0200
Message-ID: <CAP8UFD0XpEjVujeak3CyKFKHYnjKc+g_63EbNxRexm1oaRheZw@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<5734B805.8020504@kdbg.org>
	<xmqqr3d7f68l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 22:06:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wrz-0004Ts-9v
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 22:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbcELUF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 16:05:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35652 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcELUF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 16:05:56 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so17823893wme.2
        for <git@vger.kernel.org>; Thu, 12 May 2016 13:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=e8ZL6pZWf07MQLf1R2w657jOdzXGc7yor7RUmQH4Y2c=;
        b=MWo7RxWYlGI9RqqrgV6joOf/RfUY5ar/S7QapULJf9oEKvtzFaeWX4Z4EheGd/veTQ
         /e205+3n2Tl+1SnjtWLA6Qmly+zGTiSEzKE1M7RbD36gIH1/nbjOf32P7DqPNYWQgKQ5
         EkoTnpA+62L3wwVPQ/vT5JxI4rZwUQ+38RkA9ghwx8O+5CmWxfXHRvF93cv/ObpDEMdE
         Xj3t5KQVMdnrqdsUHNXPfCnrQDDKbH3FdlT2NWw04BGOScQcGXivQdTaybhG2mDbaX5O
         h2CSnCID6pAk8NeZSb3w3/fBjJizh0Pxf1WdfUKDbhfOap/Eqeqem6obOotyMvrz+Th1
         3WcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=e8ZL6pZWf07MQLf1R2w657jOdzXGc7yor7RUmQH4Y2c=;
        b=R2s6cx6oTvh8PqKVOZDnhWFBjdu1d+nWPf8ArlhmVHvM0pubvnOci3pt89x7z4TGe/
         9p2ENnmeyGdInJ2it1L+4t8YIBkCYPQKQFW9qIu6N0904rVMTCjciNFQ5wq9fOIXpXI4
         kPWJbLzNzvon6SXkMzi0jaDVCNwixg0lVwp5a2xZkDrM/qnSDOouON4GcJL37nJb2Tqj
         8Ecx5iFQruv4mAoy1LYOhdK46cVBS4RRqBBbjMEcF6wBFXQhVOO5xo0H9Z/NcOjRqFAe
         jS28qyA0FsJ7cB8ZoChSIYHMnjMeJTp7cUGhazopD2vF7c9aFtcujC49x/6GT74UX3CG
         V5Zw==
X-Gm-Message-State: AOPr4FVferWwQ0i9rH3M4/b5q2fJvNmJUvflh2LVMsCs4Q02PRREAI/J0Nq8uXs1ONkVjJAigEuqJG5Q66vhcw==
X-Received: by 10.194.117.70 with SMTP id kc6mr12928475wjb.94.1463083554770;
 Thu, 12 May 2016 13:05:54 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 12 May 2016 13:05:54 -0700 (PDT)
In-Reply-To: <xmqqr3d7f68l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294448>

On Thu, May 12, 2016 at 9:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> As Christian said in 00/94, this probably needs to go in steps, as I
> do not think anybody wants to review fouteen rounds of 90+ patch
> series.  I thought the early 40+ patches in the series were at least
> cursory reviewed already?

Yeah, Stefan said he was ok to give his Reviewed-by to v1 patches 01
to 47 and they haven't changed much from v1 to v2.

Here is the diff for those patches:

> git diff 57be628 66c994d
diff --git a/builtin/apply.c b/builtin/apply.c
index 787426f..67c64a5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -67,13 +67,15 @@ struct apply_state {
        /* --numstat does numeric diffstat, and doesn't actually apply */
        int numstat;

-       const char *fake_ancestor;
-
        int summary;
-
        int threeway;
-
        int no_add;
+       const char *fake_ancestor;
+       const char *patch_input_file;
+       struct string_list limit_by_name;
+       int has_include;
+       struct strbuf root;
+       struct string_list symlink_changes;

        /*
         *  --check turns on checking that the working tree matches the
@@ -85,11 +87,8 @@ struct apply_state {
        int check_index;

        int unidiff_zero;
-
        int update_index;
-
        int unsafe_paths;
-
        int line_termination;

        /*
@@ -113,19 +112,10 @@ struct apply_state {
         */
        struct string_list fn_table;

-       struct string_list symlink_changes;
-
        int p_value;
        int p_value_known;
        unsigned int p_context;

-       const char *patch_input_file;
-
-       struct string_list limit_by_name;
-       int has_include;
-
-       struct strbuf root;
-
        const char *whitespace_option;
        int whitespace_error;
        int squelch_whitespace_errors;
@@ -1626,7 +1616,7 @@ static void record_ws_error(struct apply_state *state,
                            unsigned result,
                            const char *line,
                            int len,
-                           int l_nr)
+                           int linenr)
 {
        char *err;

@@ -1640,7 +1630,7 @@ static void record_ws_error(struct apply_state *state,

        err = whitespace_error_string(result);
        fprintf(stderr, "%s:%d: %s.\n%.*s\n",
-               state->patch_input_file, l_nr, err, len, line);
+               state->patch_input_file, linenr, err, len, line);
        free(err);
 }

@@ -2445,7 +2435,7 @@ static int match_fragment(struct apply_state *state,
                          int match_beginning, int match_end)
 {
        int i;
-       char *fixed_buf, *orig, *target;
+       char *fixed_buf, *buf, *orig, *target;
        struct strbuf fixed;
        size_t fixed_len, postlen;
        int preimage_limit;
@@ -2506,7 +2496,6 @@ static int match_fragment(struct apply_state *state,
                 * There must be one non-blank context line that match
                 * a line before the end of img.
                 */
-               char *buf;
                char *buf_end;

                buf = preimage->buf;
@@ -4670,10 +4659,10 @@ static int option_parse_directory(const struct
option *opt,
        return 0;
 }

-static void init_apply_state(struct apply_state *state, const char *prefix_)
+static void init_apply_state(struct apply_state *state, const char *prefix)
 {
        memset(state, 0, sizeof(*state));
-       state->prefix = prefix_;
+       state->prefix = prefix;
        state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
        state->apply = 1;
        state->line_termination = '\n';
