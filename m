Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01EB1F424
	for <e@80x24.org>; Wed,  9 May 2018 02:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeEICNc (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:32 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42369 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933480AbeEICNa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id u6-v6so3339382pls.9
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BKtkWYLgHT1DNjYBtb2qll7Pt1+XwIckGQ2CV2TjG4U=;
        b=pvMGlDCr+EmeNlZnewBTooDlViZwBwyj/kh7vm9kv1VmWzcLThw2W6OutR2GIGDOaS
         v+83BQmvZRIPa+x1eKtWV5RmM7ecq3TKNVh8m26GuQrgn+pUYAtdFerAdi5dhJSlkSQG
         X15Z79LlJhhCtWavriuPkArLwM5o53XAWwYgz0A/lmeZB2j9W1HW2eHeIIp3giU2Z4If
         YbxZmM1GpyMibJqH/kPVghSzOzeo6sdiIOvr/ahYe72VJ9o6y+Ab3Baz1qGSvpThMx3b
         0vLXOpDaR6N+YD9ei+A1WZGN0afv0u2UVVPx8mfNPvDMWrbaFjlaMEtWLrcvVAvSepiE
         gsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BKtkWYLgHT1DNjYBtb2qll7Pt1+XwIckGQ2CV2TjG4U=;
        b=TkuiBxRc4G2VetKpcf2qTuJ3F7TqVhBosZ5uZIAlMvFdU9SvH17nU6ZvfCPyPm/KHL
         ncI/fnrRN/oioZGBb3FRTNmscFz+8jD8OtpTzjW/HCtu/tvxTwY1zhhRiBylEqxFnVAW
         5nNM3j0IAa/70INUJisrnDQnbPoN5cflWt16T8GThzm9/gYava50XReCy2vzt8q316EC
         GVZ5Xfe9imLgON2/n4PUDVrLvYny9AKmH5+KcoX8XL6pK7h80DEnlfg8gyDMg6eMsGke
         lAu9uuhsqDK7JS8tIGYMMBLMrtgm6JASeykQJLjEer0DNxUXq1P301QUunDCMLUn2r6Z
         6MVg==
X-Gm-Message-State: ALQs6tCW/rcEFIY5LMuOxrgeJDSNxif0GOi7yPTiEFtI5Fu0KuZv1r3J
        jrHMccaMAkADKd1L/yS0NJ6M291ytPA0wA==
X-Google-Smtp-Source: AB8JxZpr0zSSd/39rrsfOkhPK+x5qDdLdmf4weG7Czd6892Gk3fDxf4ZVxVcGT+HBkMQU/hyjZl6xQ==
X-Received: by 2002:a17:902:aa98:: with SMTP id d24-v6mr18226523plr.185.1525832008754;
        Tue, 08 May 2018 19:13:28 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id r84sm50632523pfa.125.2018.05.08.19.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:27 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:26 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 0/7] Teach '--column' to 'git-grep(1)'
Message-ID: <cover.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180421034530.GB24606@syl.local>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is my fifth re-roll of the series to add '--column' to
'git-grep(1)'.

The main changes are from a René's concerns in [1]. He points out that
'--column' with certain extended expressions can produce nonsense
(particularly because we leave the regmatch_t uninitialized).

> So at least the combination of extended matches and --column should error
> out.  Supporting it would be better, of course.  That could get tricky for
> negations, though (e.g. git grep --not -e foo).

I have opted for the die() option, instead of supporting extended
matches with --column. The problem with extended matches in this case is
that _sometimes_ --column can produce sensible results, and other times
it cannot.

For instance, an extended expression containing a single atom
has a known answer for --column, but one containing a negative atom does
only sometimes. Specifically: if an NOT atom is at the top-level, we
_never_ have a sensible answer for --column, but only sometimes do when
it is not at the top-level.

So, this leaves us two choices: (1) don't support --column and extended
expressions, or (2) support --column with extended expressions by not
printing columnar information when we don't have an answer. Option (2)
requires callers to perform deep inspection of their extended
expressions, and determine whether or not there is a answer that Git
could produce. This is too much to ask a caller to reasonably consider
when scripting. On the other hand, option (1) does not allow the caller
to do as much under certain circumstances, but simplifies their lives
when scripting, etc. For those reasons, let's pick (1).

Beyond that, here is a summary of what has changed since last time:

  * die() when given --extended, or compiling to an extended grammar,
    like in the case of 'git grep --column --not -e foo' [1].

  * Clarify patch 5/7 and indicate the intended purpose of supporting
    '--column' [2].

  * Clarify that '--column' gives a 1-indexed _byte_ offset, nothing
    else [3,5].

  * Remove a dangling reference to '--column-number' [4].

  * Clean up contrib/git-jump/README to Ævar's suggestion [6].


Thanks as always for your kind review.


Thanks,
Taylor

[1]: https://public-inbox.org/git/d030b4ee-5a92-4863-a29c-de2642bfae8d@web.de
[2]: https://public-inbox.org/git/CACsJy8BdJ0=gWZQVfSqy-vjtZVT4uZNzRaPYxRYxx2WNzaLodw@mail.gmail.com
[3]: https://public-inbox.org/git/20bc9baf-a85e-f00e-859e-e796ab4324f6@talktalk.net
[4]: https://public-inbox.org/git/87efioy8f9.fsf@evledraar.gmail.com
[5]: https://public-inbox.org/git/xmqqk1sfpn9j.fsf@gitster-ct.c.googlers.com
[6]: https://public-inbox.org/git/87d0y8y84q.fsf@evledraar.gmail.com/

Taylor Blau (7):
  Documentation/config.txt: camel-case lineNumber for consistency
  grep.c: expose matched column in match_line()
  grep.[ch]: extend grep_opt to allow showing matched column
  grep.c: display column number of first match
  builtin/grep.c: add '--column' option to 'git-grep(1)'
  grep.c: add configuration variables to show matched option
  contrib/git-jump/git-jump: jump to match column in addition to line

 Documentation/config.txt   |  7 ++++++-
 Documentation/git-grep.txt |  9 +++++++-
 builtin/grep.c             |  4 ++++
 contrib/git-jump/README    | 12 +++++++++--
 contrib/git-jump/git-jump  |  2 +-
 grep.c                     | 42 ++++++++++++++++++++++++++++++--------
 grep.h                     |  2 ++
 t/t7810-grep.sh            | 32 +++++++++++++++++++++++++++++
 8 files changed, 96 insertions(+), 14 deletions(-)

Inter-diff (since v5):

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index d451cd8883..dc8f76ce99 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -173,7 +173,8 @@ providing this option will cause it to die.
 	Prefix the line number to matching lines.

 --column::
-	Prefix the 1-indexed column number of the first match on non-context lines.
+	Prefix the 1-indexed byte-offset of the first match on non-context lines. This
+	option is incompatible with '--invert-match', and extended expressions.

 -l::
 --files-with-matches::
diff --git a/builtin/grep.c b/builtin/grep.c
index 5c83f17759..f9f516dfc4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1112,6 +1112,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		hit = grep_objects(&opt, &pathspec, the_repository, &list);
 	}

+	if (opt.columnnum && opt.invert)
+		die(_("--column and --invert-match cannot be combined"));
+
 	if (num_threads)
 		hit |= wait_all();
 	if (hit && show_in_pager)
diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 7630e16854..2f618a7f97 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -25,6 +25,13 @@ git-jump will feed this to the editor:
 foo.c:2: printf("hello word!\n");
 -----------------------------------

+Or, when running 'git jump grep', column numbers will also be emitted,
+e.g. `git jump grep "hello"` would return:
+
+-----------------------------------
+foo.c:2:9: printf("hello word!\n");
+-----------------------------------
+
 Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.
@@ -35,7 +42,8 @@ Git-jump can generate four types of interesting lists:

   2. The beginning of any merge conflict markers.

-  3. Any grep matches, including the column of the first match on a line.
+  3. Any grep matches, including the column of the first match on a
+     line.

   4. Any whitespace errors detected by `git diff --check`.

@@ -65,7 +73,7 @@ git jump grep foo_bar
 git jump grep -i foo_bar

 # use the silver searcher for git jump grep
-git config jump.grepCmd "ag"
+git config jump.grepCmd "ag --column"
 --------------------------------------------------


diff --git a/grep.c b/grep.c
index 37bb39a4a8..5d904810ad 100644
--- a/grep.c
+++ b/grep.c
@@ -1001,6 +1001,9 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 	else if (!opt->extended && !opt->debug)
 		return;

+	if (opt->columnnum && opt->extended)
+		die(_("--column and extended expressions cannot be combined"));
+
 	p = opt->pattern_list;
 	if (p)
 		opt->pattern_expression = compile_pattern_expr(&p);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index a03c3416e7..aa56b21ed9 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -110,7 +110,7 @@ do
 		test_cmp expected actual
 	'

-	test_expect_success "grep -w $L (with --{line,column}-number)" '
+	test_expect_success "grep -w $L (with --line-number, --column)" '
 		{
 			echo ${HC}file:1:5:foo mmap bar
 			echo ${HC}file:3:14:foo_mmap bar mmap
@@ -1612,4 +1612,14 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '

+test_expect_success 'grep does not allow --column, --invert-match' '
+	test_must_fail git grep --column --invert-match pat 2>err &&
+	test_i18ngrep "\-\-column and \-\-invert-match cannot be combined" err
+'
+
+test_expect_success 'grep does not allow --column, extended' '
+	test_must_fail git grep --column --not -e pat 2>err &&
+	test_i18ngrep "\-\-column and extended expressions cannot be combined" err
+'
+
 test_done

--
2.17.0
