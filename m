Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEE01F404
	for <e@80x24.org>; Thu, 19 Apr 2018 05:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDSFKp (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 01:10:45 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46042 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751565AbeDSFKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 01:10:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id u11-v6so10307375wri.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 22:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JTE2+tNTHkvpsmJrqcasXZ8txCLWmMoOwWLCYQnCf6w=;
        b=ekN2B//T08HJ3fEnBKB2OxA7l2PWWAnDDlr9rWQ3L4QNAlIuUwBv3PJx1aEkKB6GjZ
         KKiLaDLWBO4IRUaba4hFxEyhwFhKKLUAyskHmm9wd97qnKbFUpEx8VInRNBhic7JhN0U
         OdUGenEaAMTJiSP7lhokvkGpE8MHk1J4m3Zn8F4U3K7g0Mfoc1DPFZW9HnH7h+qwTum0
         iqwx9LpixHB8MjuGca7Db0bwi40Qi1d35GmAmp7VmK7sL7zBgBZp3H7AOw+toZHhBNSi
         gXMORrSygRa9K+1Ii7GSjYcewHQLs9rXdKxUsCgMdUZI+DD/89Pd2zZJkfVlAKYZPpeX
         Wqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JTE2+tNTHkvpsmJrqcasXZ8txCLWmMoOwWLCYQnCf6w=;
        b=kJuqYRfPXV1QSPjImVGBkN9FSRnJnAapfccG9V9Hbb39kXifwJc5lVmW6BbCoZIyw1
         ofSpL6O7zxw/fI8jbUiEXmkWL4aNRcFTXKjT/eCXInAGTwFENMklfGXl0VyJKMt490Pj
         Tj1NG8CcQotH7ALDQbvflbB/5q73kUxj0/E8MhHTSjG8erIJ8fQ0UmAHdBDJPWxFLhkZ
         vfged2k8mStm0mnnOuDCmneXGb58qz9bFNDedMA8feGPrYCEzLzHIJ9o9HK7hrl3ERE0
         3DfeluLK1N/VPqPUg7Kwr+G5jvteD0uu79/iJDsFVWqg2bhVHIGL2pM26Ufzz6uJpXyO
         Sk8w==
X-Gm-Message-State: ALQs6tB5/S2h3hh/Uji0AsxjMfxJ8xeuYj20w21pwjMburJtIWT53wfZ
        m2J2alm9vZSLemy0vqeBEkA=
X-Google-Smtp-Source: AIpwx48gBnYzcVHbl1fl7j7U0xYqWoAgU3xk0tjNAFy2yHfOL12V76+DmIVfAxZErIROho6nXfQpsw==
X-Received: by 10.28.23.149 with SMTP id 143mr3619584wmx.0.1524114643037;
        Wed, 18 Apr 2018 22:10:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m16sm3679423wmb.42.2018.04.18.22.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Apr 2018 22:10:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: Silly "git gc" UI issue.
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
        <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com>
        <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
        <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com>
        <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
Date:   Thu, 19 Apr 2018 14:10:40 +0900
In-Reply-To: <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 18 Apr 2018 19:29:47 -0700")
Message-ID: <xmqqh8o7eq7j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Maybe something like the attached patch? Then I get:
> ...
>     [torvalds@i7 linux]$ time git gc --prune=npw
>     fatal: Failed to parse prune expiry value npw
>
>     real        0m0.004s
>     user        0m0.002s
>     sys         0m0.002s
>
> and you could smush it into your commit (if you want my sign-off, take it)
>
>               Linus
>
>  builtin/gc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 3e67124ea..a4b20aaaf 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -354,6 +354,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	const char *name;
>  	pid_t pid;
>  	int daemonized = 0;
> +	timestamp_t dummy;
>  
>  	struct option builtin_gc_options[] = {
>  		OPT__QUIET(&quiet, N_("suppress progress reporting")),
> @@ -392,6 +393,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (argc > 0)
>  		usage_with_options(builtin_gc_usage, builtin_gc_options);
>  
> +	if (parse_expiry_date(prune_expire, &dummy))
> +		die(_("Failed to parse prune expiry value %s"), prune_expire);
> +

At this point prune_expire could be NULL, so the if() needs a bit
tightening, but otherwise it looks good.

Here is the final one (at least for today).

-- >8 --
Subject: [PATCH] parseopt: handle malformed --expire arguments nicer

A few commands that parse --expire=<time> command line option behave
silly when given nonsense input.  For example

    $ git prune --no-expire
    Segmentation falut
    $ git prune --expire=npw; echo $?
    129

Both come from parse_opt_expiry_date_cb().

The former is because the function is not prepared to see arg==NULL
(for "--no-expire", it is a norm; "--expire" at the end of the
command line could be made to pass NULL, if it is told that the
argument is optional, but we don't so we do not have to worry about
that case).

The latter is because it does not check the value returned from  the
underlying parse_expiry_date().

This seems to be a recent regression introduced while we attempted
to avoid spewing the entire usage message when given a correct
option but with an invalid value at 3bb0923f ("parse-options: do not
show usage upon invalid option value", 2018-03-22).  Before that, we
didn't fail silently but showed a full usage help (which arguably is
not all that better).

Also catch this error early when "git gc --prune=<expiration>" is
misspelled by doing a dummy parsing before the main body of "gc"
that is time consuming even begins.  Otherwise, we'd spend time to
pack objects and then later have "git prune" first notice the error.
Aborting "gc" in the middle that way is not harmful but is ugly and
can be avoided.

Helped-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c       |  4 ++++
 parse-options-cb.c |  6 +++++-
 t/t5304-prune.sh   | 10 ++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c5eae0edf..858aa444e1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -353,6 +353,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
+	timestamp_t dummy;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
@@ -388,6 +389,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc > 0)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
+	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
+		die(_("Failed to parse prune expiry value %s"), prune_expire);
+
 	if (aggressive) {
 		argv_array_push(&repack, "-f");
 		if (aggressive_depth > 0)
diff --git a/parse-options-cb.c b/parse-options-cb.c
index c6679cb2cd..872627eafe 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -38,7 +38,11 @@ int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
 int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 			     int unset)
 {
-	return parse_expiry_date(arg, (timestamp_t *)opt->value);
+	if (unset)
+		arg = "never";
+	if (parse_expiry_date(arg, (timestamp_t *)opt->value))
+		die("malformed expiration date '%s'", arg);
+	return 0;
 }
 
 int parse_opt_color_flag_cb(const struct option *opt, const char *arg,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 6694c19a1e..af69cdc112 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -320,4 +320,14 @@ test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
 	test_cmp expected actual
 '
 
+test_expect_success 'prune: handle expire option correctly' '
+	test_must_fail git prune --expire 2>error &&
+	test_i18ngrep "requires a value" error &&
+
+	test_must_fail git prune --expire=nyah 2>error &&
+	test_i18ngrep "malformed expiration" error &&
+
+	git prune --no-expire
+'
+
 test_done
-- 
2.17.0-252-gfe0a9eaf31

