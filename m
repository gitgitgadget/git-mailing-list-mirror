Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466A520248
	for <e@80x24.org>; Wed, 17 Apr 2019 12:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfDQMov (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 08:44:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37285 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfDQMov (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 08:44:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so31818080wrm.4
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN2H6u+R/BfnBpGDoVKXYiVdn7RTxj5lnzD3CPP1nM8=;
        b=nx4dSnbBSAN03/DX2eWL1nunGn1/QBREG6k60tgO2t0Jc0mff6jacs0D65jrNqvda6
         DJhxtHGkg8LrYZt62g43z8MBctuucQNOibJYVl87MzUrWtisguqT6V6y7MPPNH42qBEK
         7YfE7kz3KXj97ikIATN9zk+P8UbLLSKsZhXJxxL9pN5eGY72Xd5bWUbqENQV5i//lrcm
         giJP/RUIMO4KYnyn4T7kKy2QLjrCwXlV6038r40Sg9AMJAW3vrSNfp84q2GW4Bze73MZ
         LNu+oKixbK1aHBi/JY3Y+SoU1U47jWjDXQELk+rz3FjvWwmnPBREY6Fk0T4X8cOsbIP8
         PHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN2H6u+R/BfnBpGDoVKXYiVdn7RTxj5lnzD3CPP1nM8=;
        b=AjjGbW1u6/BL7RiutrSQoOid9ffgGgDvU4Vq9YAApspU6iBi0LdzIKFoaBX0KN9Dnw
         4FSxtpu8PYOfq6Q2F1brDxl65S+mKIBWngQvtGIKs9O6RCANbUcph7b44Ascrs5elU4+
         tfCUXH7iJFhfKosL5hSml3CjAsTZVcBeCsTIARuipuDR7LBiTJUG/4dl2hMQxqSDGIG1
         CAjUcUqXdlK27CZImTdQHFPCLPaN0/lsk3BhaQNqKLuq+eHvJCC0jt76dI6CUZg1kYxw
         SzNICEdJcIzReF9YXZaa1cM9pb8J/MW0YAkq9oe5bJnHet+y1tHWAgcYSuGymbq+ZSNU
         z6hg==
X-Gm-Message-State: APjAAAVuerftuxx/QC8Fq1xIV5j3Ymn9R2lhfBNGLrh0dGChHVioeZG5
        m5V6L+1PiZBh1RxAVSumWARkPQq0
X-Google-Smtp-Source: APXvYqxP21CfFvNCchLkRhyhrKUaoeiTQiHipgWcAEvGmzkL1+FoFxDYs8tt4TmPFoDLuulNLedlIw==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr26284908wrl.262.1555505088674;
        Wed, 17 Apr 2019 05:44:48 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d7sm3372063wmf.31.2019.04.17.05.44.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 05:44:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] parse-options: don't emit "ambiguous option" for aliases
Date:   Wed, 17 Apr 2019 14:44:38 +0200
Message-Id: <20190417124438.8191-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190325202329.26033-3-avarab@gmail.com>
References: <20190325202329.26033-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the option parsing machinery so that e.g. "clone --recurs ..."
doesn't error out because "clone" understands both "--recursive" and
"--recurse-submodules" to mean the same thing.

Initially "clone" just understood --recursive until the
--recurses-submodules alias was added in ccdd3da652 ("clone: Add the
--recurse-submodules option as alias for --recursive",
2010-11-04). Since bb62e0a99f ("clone: teach --recurse-submodules to
optionally take a pathspec", 2017-03-17) the longer form has been
promoted to the default.

But due to the way the options parsing machinery works this resulted
in the rather absurd situation of:

    $ git clone --recurs [...]
    error: ambiguous option: recurs (could be --recursive or --recurse-submodules)

Let's re-use the PARSE_OPT_NOCOMPLETE flag to mean "this option
doesn't contribute to abbreviation ambiguity". I was going to add a
new PARSE_OPT_NOABBREV flag, but it makes sense just to re-use
PARSE_OPT_NOCOMPLETE.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

See
https://public-inbox.org/git/20190325202329.26033-1-avarab@gmail.com/
for v1. There wasn't consensus for 1/2 there, but this used-to-be 2/2
seems like a no-brainer bugfix.

It conflicted with some recently-landed stuff in 'master', but now
cleanly applies to it and 'pu', and with pu's
GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS.

 builtin/clone.c          | 4 ++--
 parse-options.c          | 3 ++-
 parse-options.h          | 2 ++
 t/t0040-parse-options.sh | 5 +++++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..4dc26969a7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -100,8 +100,8 @@ static struct option builtin_clone_options[] = {
 		    N_("setup as shared repository")),
 	{ OPTION_CALLBACK, 0, "recursive", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
-	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, recurse_submodules_cb,
-	  (intptr_t)"." },
+	  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN | PARSE_OPT_NOCOMPLETE,
+	  recurse_submodules_cb, (intptr_t)"." },
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
diff --git a/parse-options.c b/parse-options.c
index cec74522e5..9899ce0171 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -292,7 +292,8 @@ static enum parse_opt_result parse_long_opt(
 		if (!rest) {
 			/* abbreviated? */
 			if (!(p->flags & PARSE_OPT_KEEP_UNKNOWN) &&
-			    !strncmp(long_name, arg, arg_end - arg)) {
+			    !strncmp(long_name, arg, arg_end - arg) &&
+			    !(options->flags & PARSE_OPT_NOCOMPLETE)) {
 is_abbreviated:
 				if (abbrev_option) {
 					/*
diff --git a/parse-options.h b/parse-options.h
index 74cce4e7fc..51c4b71ab0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -96,6 +96,8 @@ typedef enum parse_opt_result parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *				Useful for options with multiple parameters.
  *   PARSE_OPT_NOCOMPLETE: by default all visible options are completable
  *			   by git-completion.bash. This option suppresses that.
+ *			   Will also skip this option when abbreviation is
+ *			   considered.
  *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to
  *			 complete an option as --name= not --name even if
  *			 the option takes optional argument.
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index b8f366c442..e8f0371830 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -220,6 +220,11 @@ test_expect_success 'non ambiguous option (after two options it abbreviates)' '
 	test-tool parse-options --expect="string: 123" --st 123
 '
 
+test_expect_success 'NOCOMPLETE options do not contribute to abbreviation' '
+	test_when_finished "rm -rf A" &&
+	git clone --recurs . A
+'
+
 cat >typo.err <<\EOF
 error: did you mean `--boolean` (with two dashes ?)
 EOF
-- 
2.21.0.593.g511ec345e18

