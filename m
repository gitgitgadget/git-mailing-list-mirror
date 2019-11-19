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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB9A1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfKSQtB (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:49:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51229 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfKSQtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so3953523wme.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=D8RoCIIJZsmPYSVmTanFEulhosYsnLcctenQvGWOmTA=;
        b=IEvK0syS1ywFV1TWJ9EYkWfg+kSZ6553PBXKEvx/oS+t+awltqQEWDiYcofpgyqRO7
         FAiBdFI+K2IG6HTnrJVebpVF5Wl5QmmqvHR0rFgtFwY0en4K6DB3VLQYjs8ZhXLoJrzx
         vPGpCT+ngaRhRAqIv663YV6CYSeUSFq19uGZYhkT6CFLrLss0PpW0br2384GqvKTbRGu
         tG0uPWzNVpcwk7XdZ6uHmdxzhoqQ+patd7HhloS7/hPSsJCcKX7O/4zS0imY5EOaxchV
         Hda7+iIn0ifrDoW3V6uynnKSdaGDV4ioknLA1+ja69SeR77nXiNItIsWN+PDAwxhUI7U
         Opiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=D8RoCIIJZsmPYSVmTanFEulhosYsnLcctenQvGWOmTA=;
        b=SrTGMiStpnJkLc5UkYABSFik2wfUZRXAq9xpghComzOiqf/MmVjTedGvyUhkj1jF/f
         URYVQqt+5hAyFEE/crknOvxtqUDae31I+wIKixi3IZyPu/RYiPxi+qFtUD0sxRFOGNGz
         0x4TBGOXV2bzqxcz91qRSyUWJHtcdHhtPfqpP+uDVyolpBevP8LJQrKXpdsUm7khjiji
         ai+JQfQc+9Htqa4aGezvIg4e3EVcfkwlN8lq9j3bOfhZk+SkP7mv9MrVbBIWftwbAs+y
         a6X3Rnv+S6iwu3z9h4wPmcHC6mHK/cUsuUHIqRvLYvwTzi9duYzfoM8EiZxnVwKuTrxa
         b5jA==
X-Gm-Message-State: APjAAAWD36divD4zgSrirrMjhYGPfjJ8LERSXE/Ibf75ANFRqiGxRQwP
        npE8/d6kAY8q/+f6qb88fMXyl6uX5ec=
X-Google-Smtp-Source: APXvYqxSupIw0KF8V+HnJi2IZGdL/CQE7JDwO2Wc2MBFxeb7QnFBLu2IGRiVNhGLLg5V/QS/3oVqzg==
X-Received: by 2002:a1c:21c4:: with SMTP id h187mr7118943wmh.46.1574182136654;
        Tue, 19 Nov 2019 08:48:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c144sm3790148wmd.1.2019.11.19.08.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:48:56 -0800 (PST)
Message-Id: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 16:48:49 +0000
Subject: [PATCH v3 0/6] Add --pathspec-from-file option for reset, commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from V2:

1) Some polishing in documentation 2) = NULL removed from 
parse_pathspec_file()

Alexandr Miloslavskiy (6):
  parse-options.h: add new options `--pathspec-from-file`,
    `--pathspec-file-nul`
  pathspec: add new function to parse file
  doc: reset: synchronize <pathspec> description
  reset: support the `--pathspec-from-file` option
  doc: commit: synchronize <pathspec> description
  commit: support the --pathspec-from-file option

 Documentation/git-commit.txt    |  29 ++++--
 Documentation/git-reset.txt     |  48 +++++++---
 builtin/commit.c                |  25 +++++-
 builtin/reset.c                 |  25 +++++-
 parse-options.h                 |   2 +
 pathspec.c                      |  38 ++++++++
 pathspec.h                      |  10 +++
 t/t7107-reset-pathspec-file.sh  | 155 ++++++++++++++++++++++++++++++++
 t/t7526-commit-pathspec-file.sh | 130 +++++++++++++++++++++++++++
 9 files changed, 434 insertions(+), 28 deletions(-)
 create mode 100755 t/t7107-reset-pathspec-file.sh
 create mode 100755 t/t7526-commit-pathspec-file.sh


base-commit: da72936f544fec5a335e66432610e4cef4430991
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-445%2FSyntevoAlex%2F%230207_pathspec_from_file-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-445/SyntevoAlex/#0207_pathspec_from_file-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/445

Range-diff vs v2:

 1:  2dfaccf0d5 = 1:  19b80326ea parse-options.h: add new options `--pathspec-from-file`, `--pathspec-file-nul`
 2:  96697ba072 ! 2:  55a7c6ec3c pathspec: add new function to parse file
     @@ -45,7 +45,7 @@
      +						       strbuf_getline;
      +	struct strbuf buf = STRBUF_INIT;
      +	struct strbuf unquoted = STRBUF_INIT;
     -+	FILE *in = NULL;
     ++	FILE *in;
      +
      +	if (!strcmp(file, "-"))
      +		in = stdin;
 3:  f961a5155a ! 3:  d9f32e523c doc: reset: unify <pathspec> description
     @@ -1,8 +1,8 @@
      Author: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     -    doc: reset: unify <pathspec> description
     +    doc: reset: synchronize <pathspec> description
      
     -    Synchronize it to `git add`, which has a pretty good description.
     +    `git add` shows an example of good writing, follow it.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     @@ -21,18 +21,17 @@
       
       DESCRIPTION
      @@
     - In the third form, set the current branch head (`HEAD`) to `<commit>`,
       optionally modifying index and working tree to match.
       The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
     -+The <pathspec> is used to limit the paths affected by the operation
     -+(see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
       
      -'git reset' [-q] [<tree-ish>] [--] <paths>...::
      -	This form resets the index entries for all `<paths>` to their
     +-	state at `<tree-ish>`.  (It does not affect the working tree or
     +-	the current branch.)
      +'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
     -+	This form resets the index entries for all `<pathspec>` to their
     - 	state at `<tree-ish>`.  (It does not affect the working tree or
     - 	the current branch.)
     ++	This form resets the index entries for all paths that match the
     ++	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
     ++	the working tree or the current branch.)
       +
      -This means that `git reset <paths>` is the opposite of `git add
      -<paths>`. This command is equivalent to
     @@ -54,6 +53,20 @@
       	Interactively select hunks in the difference between the index
       	and `<tree-ish>` (defaults to `HEAD`).  The chosen hunks are applied
       	in reverse to the index.
     +@@
     + 	`reset.quiet` config option. `--quiet` and `--no-quiet` will
     + 	override the default behavior.
     + 
     ++\--::
     ++	Do not interpret any more arguments as options.
     ++
     ++<pathspec>...::
     ++	Limits the paths affected by the operation.
     +++
     ++For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
     + 
     + EXAMPLES
     + --------
      
       diff --git a/builtin/reset.c b/builtin/reset.c
       --- a/builtin/reset.c
 4:  d72d4f16b5 ! 4:  8a10ff881b reset: support the `--pathspec-from-file` option
     @@ -31,15 +31,13 @@
      +In the last form, set the current branch head (`HEAD`) to `<commit>`,
       optionally modifying index and working tree to match.
       The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
     - The <pathspec> is used to limit the paths affected by the operation
     - (see the entry for 'pathspec' in linkgit:gitglossary[7] for more details).
       
       'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
     --	This form resets the index entries for all `<pathspec>` to their
     +-	This form resets the index entries for all paths that match the
      +'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
     -+	These forms reset the index entries matching pathspec to their
     - 	state at `<tree-ish>`.  (It does not affect the working tree or
     - 	the current branch.)
     ++	These forms reset the index entries for all paths that match the
     + 	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
     + 	the working tree or the current branch.)
       +
      @@
       	`reset.quiet` config option. `--quiet` and `--no-quiet` will
     @@ -55,10 +53,12 @@
      +
      +--pathspec-file-nul::
      +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
     -+	separated with NUL character and are not expected to be quoted.
     ++	separated with NUL character and all other characters are taken
     ++	literally (including newlines and quotes).
     ++
     + \--::
     + 	Do not interpret any more arguments as options.
       
     - EXAMPLES
     - --------
      
       diff --git a/builtin/reset.c b/builtin/reset.c
       --- a/builtin/reset.c
     @@ -241,7 +241,7 @@
      +	printf "\"file\\101.t\"" >list &&
      +	# Note: "git reset" has not yet learned to fail on wrong pathspecs
      +	git reset --pathspec-from-file=list --pathspec-file-nul &&
     -+	
     ++
      +	cat >expect <<-\EOF &&
      +	 D fileA.t
      +	EOF
 5:  20c4495fd3 ! 5:  0b79797e77 doc: commit: unify <pathspec> description
     @@ -1,8 +1,8 @@
      Author: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
      
     -    doc: commit: unify <pathspec> description
     +    doc: commit: synchronize <pathspec> description
      
     -    Synchronize it to `git add`, which has a pretty good description.
     +    `git add` shows an example of good writing, follow it.
          This also better disambiguates <file>... header.
      
          Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
     @@ -35,8 +35,7 @@
      +	already added to the index. The contents of these files are also
      +	staged for the next commit on top of what have been staged before.
      ++
     -+For more details about the <pathspec> syntax, see the 'pathspec' entry
     -+in linkgit:gitglossary[7].
     ++For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
       
       :git-commit: 1
       include::date-formats.txt[]
 6:  cb5fc9b14d ! 6:  7e48212002 commit: support the --pathspec-from-file option
     @@ -25,10 +25,9 @@
       DESCRIPTION
       -----------
      @@
     - 	the last commit without committing changes that have
       	already been staged. If used together with `--allow-empty`
       	paths are also not required, and an empty commit will be created.
     -+	
     + 
      +--pathspec-from-file=<file>::
      +	Pathspec is passed in `<file>` instead of commandline args. If
      +	`<file>` is exactly `-` then standard input is used. Pathspec
     @@ -39,10 +38,12 @@
      +
      +--pathspec-file-nul::
      +	Only meaningful with `--pathspec-from-file`. Pathspec elements are
     -+	separated with NUL character and are not expected to be quoted.
     - 
     ++	separated with NUL character and all other characters are taken
     ++	literally (including newlines and quotes).
     ++
       -u[<mode>]::
       --untracked-files[=<mode>]::
     + 	Show untracked files.
      
       diff --git a/builtin/commit.c b/builtin/commit.c
       --- a/builtin/commit.c
     @@ -118,7 +119,7 @@
      +test_expect_success setup '
      +	test_commit file0 &&
      +	git tag checkpoint &&
     -+	
     ++
      +	echo A >fileA.t &&
      +	echo B >fileB.t &&
      +	echo C >fileC.t &&

-- 
gitgitgadget
