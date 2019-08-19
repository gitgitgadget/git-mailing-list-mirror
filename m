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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1491F461
	for <e@80x24.org>; Mon, 19 Aug 2019 23:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfHSXws (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 19:52:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46182 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfHSXwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 19:52:47 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so8205378iog.13
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 16:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=SIP6aHYaUagiXQo72FL0gpjersnXuH9r5mqVWcdnRrE=;
        b=f24ogDl2e0Ry6LFnUUzlU+9yzTQsmJgSz2yh0nGZ2ywYoo67uKUjdc0weP3iblNdCY
         0YmiWds8AHKVVCeB3N6SX6S4MK2L9LwZcJw5CFHvocH8gMt7+EWc0diNPMnq0d5U0ExR
         5XAzDhykL1RX+PJlahiZHFlAe1XrkhqldyXQd/UXumtQHWwwArj6sllTIraNSWjMI7gb
         Bd+fIefkvqKYxGYJ5SDzV3KZheGJR69tKaVaDKsPx/QsHLk/jPnlxfpNpMIxMGB2frJ+
         uMETM3XzLYMK+XsVrHtOAI9PQzB/5aggq6PL9YK2y2oamvNxLnr6n1LFwIg32vop+3sv
         RNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SIP6aHYaUagiXQo72FL0gpjersnXuH9r5mqVWcdnRrE=;
        b=K0Ls5CDERPfIgqW968YVD6y7p8p5MuUDDXEU8rnMG72bmuibXXC6YkHyGi45a7ZrAI
         /MuaL18eBWjZ1g1LLH85lKZdfh5gsvklVjfMZBRk8GyphGxacHEWi+NxAOGBAbkF/2LQ
         +NffCFUODL9TaG732VZt9k+QjOrZOWxzY/U8KStHT3f6XV4gVFAN64IGBX6PA8U4dtHd
         8EfLynW6M59EzZPYMr0zho7PkTb/TdWD9KCZuNuK1K+qQOr1MUPrO+s52oAXFa1OjLQ/
         Zha/MJHjXUpjQO5bz3+rOfzA/Ddw+xL9jvPzdqIRPJCE9nkdFgRqxlJdO9ZtjtBAJc3H
         7BiQ==
X-Gm-Message-State: APjAAAVCmXrlCQPyRLvErPHe2MiqNn2hLClMMdFDTl0i+a8mwO3CyVeL
        IE6fnB0jglyAljFAntuwKNvjDjX6
X-Google-Smtp-Source: APXvYqwCKNu+ICiJmAZ77mS6Tk/+xnq6jMuBZgt/SVgettNnm6hWKsSY7tbRc0vuwRgHf98O16Zkcg==
X-Received: by 2002:a6b:6f17:: with SMTP id k23mr2587776ioc.25.1566258765926;
        Mon, 19 Aug 2019 16:52:45 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id p9sm17000012ios.1.2019.08.19.16.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:52:45 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:52:43 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] format-patch: learn --infer-cover-subject option
Message-ID: <cover.1566258525.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Eric. I've incorporated all of your suggestions
and, while I was doing that, I found a couple more places for cleanup.

Currently, format-patch only puts "*** SUBJECT HERE ***" when a cover
letter is generated. However, it is already smart enough to be able to
populate the cover letter with the branch description so there's no
reason why it cannot populate the subject as well.

Teach format-patch the --infer-cover-subject and corresponding
format.inferCoverSubject configuration option which will read the
subject from the branch description using the same rules as for a commit
message (that is, it will expect a subject line followed by a blank
line).

Also includes some other cleanup along the way.

This was based on patches 1-3 of an earlier patchset I sent[1].

Changes since v1:

* Incorporate Eric's suggestions for cleanup in all patches

* Add patch 3/4 to make it clear what is the default value for
  format.coverLetter (since format.inferCoverSubject was borrowed from
  this config but it also did not state what the default value was)

* In 1/4, rename all instances of "expected" to "expect"

[1]: https://public-inbox.org/git/cover.1558492582.git.liu.denton@gmail.com/


Denton Liu (4):
  t4014: clean up style
  Doc: add more detail for git-format-patch
  config/format.txt: make clear the default value of format.coverLetter
  format-patch: learn --infer-cover-letter option

 Documentation/config/format.txt    |   7 +-
 Documentation/git-format-patch.txt |  27 +-
 builtin/log.c                      |  56 ++-
 t/t4014-format-patch.sh            | 766 ++++++++++++++++-------------
 4 files changed, 481 insertions(+), 375 deletions(-)

Range-diff against v1:
1:  058f877c34 ! 1:  76a0a274fd t4014: clean up style
    @@ Commit message
         Change here-docs from `<<\EOF` to `<<-\EOF` so that they can be indented
         along with the rest of the test case.
     
    -    Finally, refactor to remove Git commands upstream of pipe. This way, if
    -    an invocation of a Git command fails, the return code won't be lost.
    -    Keep upstream non-Git commands since we have to assume a base level of
    -    sanity.
    +    Convert all instances of `cnt=$(... | wc -l) && test $cnt = N` into
    +    uses of `test_line_count()`.
    +
    +    For style, move the ending sq of test cases onto its own line whenever
    +    they do not conform.
    +
    +    Rename output files from "expected" to "expect" to conform with the
    +    usual convention.
    +
    +    Finally, refactor to remove Git commands upstream of pipe as well as Git
    +    commands that are in a non-variable-assignment subshell (e.g. `echo
    +    "base-commit: $(git rev-parse HEAD)"`. This way, if an invocation of a
    +    Git command fails, the return code won't be lost. Keep upstream non-Git
    +    commands since we have to assume a base level of sanity.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ t/t4014-format-patch.sh: test_expect_success setup '
      	test_tick &&
      	git commit -m "Master accepts moral equivalent of #2" &&
      
    +@@ t/t4014-format-patch.sh: test_expect_success setup '
    + test_expect_success "format-patch --ignore-if-in-upstream" '
    + 
    + 	git format-patch --stdout master..side >patch0 &&
    +-	cnt=$(grep "^From " patch0 | wc -l) &&
    +-	test $cnt = 3
    +-
    ++	grep "^From " patch0 >from0 &&
    ++	test_line_count = 3 from0
    + '
    + 
    + test_expect_success "format-patch --ignore-if-in-upstream" '
    + 
    + 	git format-patch --stdout \
    + 		--ignore-if-in-upstream master..side >patch1 &&
    +-	cnt=$(grep "^From " patch1 | wc -l) &&
    +-	test $cnt = 2
    +-
    ++	grep "^From " patch1 >from1 &&
    ++	test_line_count = 2 from1
    + '
    + 
    + test_expect_success "format-patch --ignore-if-in-upstream handles tags" '
    + 	git tag -a v1 -m tag side &&
    + 	git tag -a v2 -m tag master &&
    + 	git format-patch --stdout --ignore-if-in-upstream v2..v1 >patch1 &&
    +-	cnt=$(grep "^From " patch1 | wc -l) &&
    +-	test $cnt = 2
    ++	grep "^From " patch1 >from1 &&
    ++	test_line_count = 2 from1
    + '
    + 
    + test_expect_success "format-patch doesn't consider merge commits" '
     @@ t/t4014-format-patch.sh: test_expect_success "format-patch doesn't consider merge commits" '
      	git checkout -b merger master &&
      	test_tick &&
      	git merge --no-ff slave &&
     -	cnt=$(git format-patch -3 --stdout | grep "^From " | wc -l) &&
    -+	cnt=$(git format-patch -3 --stdout >patch && grep "^From " patch | wc -l) &&
    - 	test $cnt = 3
    +-	test $cnt = 3
    ++	git format-patch -3 --stdout >patch &&
    ++	grep "^From " patch >from &&
    ++	test_line_count = 3 from
      '
      
    -@@ t/t4014-format-patch.sh: test_expect_success "format-patch result applies" '
    + test_expect_success "format-patch result applies" '
      
      	git checkout -b rebuild-0 master &&
      	git am -3 patch0 &&
    @@ t/t4014-format-patch.sh: test_expect_success 'reroll count (-v)' '
      	expect="$1" &&
      	shift &&
     -	(git format-patch --stdout "$@"; echo $? > status.out) |
    -+	(git format-patch --stdout "$@"; echo $? >status.out) |
    ++	git format-patch --stdout "$@" >patch &&
      	# Prints everything between the Message-ID and In-Reply-To,
      	# and replaces all Message-ID-lookalikes by a sequence number
      	perl -ne '
    @@ t/t4014-format-patch.sh: check_threading () {
      		}
      		print "---\n" if /^From /i;
     -	' > actual &&
    -+	' >actual &&
    - 	test 0 = "$(cat status.out)" &&
    +-	test 0 = "$(cat status.out)" &&
    ++	' <patch >actual &&
      	test_cmp "$expect" actual
      }
      
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch with multiple notes r
     +	test_must_fail git format-patch --name-status 2>output &&
      	test_i18ncmp expect.name-status output &&
     -	test_must_fail git format-patch --check 2> output &&
    +-	test_i18ncmp expect.check output'
     +	test_must_fail git format-patch --check 2>output &&
    - 	test_i18ncmp expect.check output'
    ++	test_i18ncmp expect.check output
    ++'
      
      test_expect_success 'format-patch --numstat should produce a patch' '
     -	git format-patch --numstat --stdout master..side > output &&
    +-	test 5 = $(grep "^diff --git a/" output | wc -l)'
     +	git format-patch --numstat --stdout master..side >output &&
    - 	test 5 = $(grep "^diff --git a/" output | wc -l)'
    ++	grep "^diff --git a/" output >diff &&
    ++	test_line_count = 5 diff
    ++'
      
      test_expect_success 'format-patch -- <path>' '
    + 	git format-patch master..side -- file 2>error &&
     @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
      	git format-patch --ignore-if-in-upstream HEAD
      '
      
     -git_version="$(git --version | sed "s/.* //")"
    -+git_version="$(git --version >version && sed "s/.* //" version)"
    - 
    +-
      signature() {
    ++	git_version="$(git --version >version && sed "s/.* //" version)" &&
      	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
      }
      
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch --ignore-if-in-upstre
      	signature "my sig" >expect &&
      	test_cmp expect output
      '
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch --signature --cover-letter' '
    + 	git config --unset-all format.signature &&
    + 	git format-patch --stdout --signature="my sig" --cover-letter \
    + 		-1 >output &&
    +-	grep "my sig" output &&
    +-	test 2 = $(grep "my sig" output | wc -l)
    ++	grep "my sig" output >sig &&
    ++	test_line_count = 2 sig
    + '
    + 
    + test_expect_success 'format.signature="" suppresses signatures' '
     @@ t/t4014-format-patch.sh: append_signoff()
      
      test_expect_success 'signoff: commit with no body' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -8:
     -9:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    -+	cat <<-\EOF | sed "s/EOL$//" >expected &&
    +-	test_cmp expected actual
    ++	cat <<-\EOF | sed "s/EOL$//" >expect &&
     +	4:Subject: [PATCH] EOL
     +	8:
     +	9:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: commit with only subject' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -8:
     -9:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    -+	cat >expected <<-\EOF &&
    +-	test_cmp expected actual
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	9:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: commit with only subject that does not end with NL' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -8:
     -9:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    -+	cat >expected <<-\EOF &&
    +-	test_cmp expected actual
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	9:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: no existing signoffs' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	body
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: no existing signoffs and no trailing NL' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    -+	cat >expected <<-\EOF &&
    +-	test_cmp expected actual
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: some random signoff' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -11:Signed-off-by: my@house
     -12:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	Signed-off-by: my@house
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	11:Signed-off-by: my@house
     +	12:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: misc conforming footer elements' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -11:Signed-off-by: my@house
     -15:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	Signed-off-by: my@house
     +	(cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
     +	Tested-by: Some One <someone@example.com>
     +	Bug: 1234
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	11:Signed-off-by: my@house
     +	15:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: some random signoff-alike' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -11:
     -12:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	body
     +	Fooled-by-me: my@house
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	11:
     +	12:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: not really a signoff' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	I want to mention about Signed-off-by: here.
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	9:I want to mention about Signed-off-by: here.
     +	10:
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: not really a signoff (2)' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:Signed-off-by: example happens to be wrapped here.
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	My unfortunate
     +	Signed-off-by: example happens to be wrapped here.
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:Signed-off-by: example happens to be wrapped here.
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: valid S-o-b paragraph in the middle' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -13:
     -14:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	A lot of houses.
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	9:Signed-off-by: my@house
    @@ t/t4014-format-patch.sh: append_signoff()
     +	13:
     +	14:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: the same signoff at the end' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: the same signoff at the end, no trailing NL' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -8:
     -9:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    -+	cat >expected <<-\EOF &&
    +-	test_cmp expected actual
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	9:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: the same signoff NOT at the end' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -12:Signed-off-by: my@house
     -EOF
    +-	test_cmp expected actual
     +	Signed-off-by: C O Mitter <committer@example.com>
     +	Signed-off-by: my@house
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	12:Signed-off-by: my@house
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: tolerate garbage in conforming footer' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:
     -13:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	Tested-by: my@house
     +	Some Trash
     +	Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	13:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: respect trailer config' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -11:
     -12:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual &&
     +	Myfooter: x
     +	Some Trash
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	11:
     +	12:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual &&
    ++	test_cmp expect actual &&
      
      	test_config trailer.Myfooter.ifexists add &&
     -	append_signoff <<\EOF >actual &&
    @@ t/t4014-format-patch.sh: append_signoff()
     -8:
     -11:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	Myfooter: x
     +	Some Trash
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	11:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
      test_expect_success 'signoff: footer begins with non-signoff without @ sign' '
    @@ t/t4014-format-patch.sh: append_signoff()
     -10:
     -14:Signed-off-by: C O Mitter <committer@example.com>
     -EOF
    +-	test_cmp expected actual
     +	Reviewed-id: Noone
     +	Tested-by: my@house
     +	Change-id: Ideadbeef
     +	Signed-off-by: C O Mitter <committer@example.com>
     +	Bug: 1234
     +	EOF
    -+	cat >expected <<-\EOF &&
    ++	cat >expect <<-\EOF &&
     +	4:Subject: [PATCH] subject
     +	8:
     +	10:
     +	14:Signed-off-by: C O Mitter <committer@example.com>
     +	EOF
    - 	test_cmp expected actual
    ++	test_cmp expect actual
      '
      
    + test_expect_success 'format patch ignores color.ui' '
     @@ t/t4014-format-patch.sh: test_expect_success 'cover letter using branch description (1)' '
      	git checkout rebuild-1 &&
      	test_config branch.rebuild-1.description hello &&
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch -o overrides format.o
      	git checkout patchid &&
     -	git format-patch --stdout --base=HEAD~3 -1 | tail -n 7 >actual1 &&
     -	git format-patch --stdout --base=HEAD~3 HEAD~.. | tail -n 7 >actual2 &&
    +-	echo >expected &&
    +-	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
    +-	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
    +-	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
    +-	signature >> expected &&
    +-	test_cmp expected actual1 &&
    +-	test_cmp expected actual2 &&
    ++
     +	git format-patch --stdout --base=HEAD~3 -1 >patch &&
     +	tail -n 7 patch >actual1 &&
    ++
     +	git format-patch --stdout --base=HEAD~3 HEAD~.. >patch &&
     +	tail -n 7 patch >actual2 &&
    - 	echo >expected &&
    - 	echo "base-commit: $(git rev-parse HEAD~3)" >>expected &&
    --	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --stable | awk "{print \$1}")" >>expected &&
    --	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --stable | awk "{print \$1}")" >>expected &&
    --	signature >> expected &&
    ++
    ++	echo >expect &&
    ++	git rev-parse HEAD~3 >commit-id-base &&
    ++	echo "base-commit: $(cat commit-id-base)" >>expect &&
    ++
     +	git show --patch HEAD~2 >patch &&
     +	git patch-id --stable <patch >patch.id.raw &&
    -+	awk "{print \$1}" <patch.id.raw >patch.id &&
    -+	echo "prerequisite-patch-id: $(cat patch.id)" >>expected &&
    ++	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>expect &&
    ++
     +	git show --patch HEAD~1 >patch &&
     +	git patch-id --stable <patch >patch.id.raw &&
    -+	awk "{print \$1}" <patch.id.raw >patch.id &&
    -+	echo "prerequisite-patch-id: $(cat patch.id)" >>expected &&
    -+	signature >>expected &&
    - 	test_cmp expected actual1 &&
    - 	test_cmp expected actual2 &&
    ++	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>expect &&
    ++
    ++	signature >>expect &&
    ++	test_cmp expect actual1 &&
    ++	test_cmp expect actual2 &&
    ++
      	echo >fail &&
    - 	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
    +-	echo "base-commit: $(git rev-parse HEAD~3)" >>fail &&
     -	echo "prerequisite-patch-id: $(git show --patch HEAD~2 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
     -	echo "prerequisite-patch-id: $(git show --patch HEAD~1 | git patch-id --unstable | awk "{print \$1}")" >>fail &&
    -+	echo "prerequisite-patch-id: $(
    -+		git show --patch HEAD~2 >patch &&
    -+		git patch-id --unstable <patch >patch.id.raw &&
    -+		awk "{print \$1}" <patch.id.raw)" >>fail &&
    -+	echo "prerequisite-patch-id: $(git show --patch HEAD~1 >patch &&
    -+		git patch-id --unstable <patch >patch.id.raw &&
    -+		awk "{print \$1}" <pattch.id.raw)" >>fail &&
    - 	signature >> fail &&
    +-	signature >> fail &&
    ++	echo "base-commit: $(cat commit-id-base)" >>fail &&
    ++
    ++	git show --patch HEAD~2 >patch &&
    ++	git patch-id --unstable <patch >patch.id.raw &&
    ++	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
    ++
    ++	git show --patch HEAD~1 >patch &&
    ++	git patch-id --unstable <patch >patch.id.raw &&
    ++	awk "{print \"prerequisite-patch-id:\", \$1}" <patch.id.raw >>fail &&
    ++
    ++	signature >>fail &&
      	! test_cmp fail actual1 &&
      	! test_cmp fail actual2
    + '
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch --base errors out when base commit is in revis
    + 	test_must_fail git format-patch --base=HEAD~1 -2 &&
    + 	git format-patch --stdout --base=HEAD~2 -2 >patch &&
    + 	grep "^base-commit:" patch >actual &&
    +-	echo "base-commit: $(git rev-parse HEAD~2)" >expected &&
    +-	test_cmp expected actual
    ++	git rev-parse HEAD~2 >commit-id-base &&
    ++	echo "base-commit: $(cat commit-id-base)" >expect &&
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 'format-patch --base errors out when base commit is not ancestor of revision list' '
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch --base errors out when base commit is not ance
    + 	test_must_fail git format-patch --base=$(cat commit-id-Z) -3 &&
    + 	git format-patch --stdout --base=$(cat commit-id-base) -3 >patch &&
    + 	grep "^base-commit:" patch >actual &&
    +-	echo "base-commit: $(cat commit-id-base)" >expected &&
    +-	test_cmp expected actual
    ++	echo "base-commit: $(cat commit-id-base)" >expect &&
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 'format-patch --base=auto' '
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch --base=auto' '
    + 	test_commit N2 &&
    + 	git format-patch --stdout --base=auto -2 >patch &&
    + 	grep "^base-commit:" patch >actual &&
    +-	echo "base-commit: $(git rev-parse upstream)" >expected &&
    +-	test_cmp expected actual
    ++	git rev-parse upstream >commit-id-base &&
    ++	echo "base-commit: $(cat commit-id-base)" >expect &&
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 'format-patch errors out when history involves criss-cross' '
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch format.useAutoBaseoption' '
    + 	git config format.useAutoBase true &&
    + 	git format-patch --stdout -1 >patch &&
    + 	grep "^base-commit:" patch >actual &&
    +-	echo "base-commit: $(git rev-parse upstream)" >expected &&
    +-	test_cmp expected actual
    ++	git rev-parse upstream >commit-id-base &&
    ++	echo "base-commit: $(cat commit-id-base)" >expect &&
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 'format-patch --base overrides format.useAutoBase' '
    +@@ t/t4014-format-patch.sh: test_expect_success 'format-patch --base overrides format.useAutoBase' '
    + 	git config format.useAutoBase true &&
    + 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
    + 	grep "^base-commit:" patch >actual &&
    +-	echo "base-commit: $(git rev-parse HEAD~1)" >expected &&
    +-	test_cmp expected actual
    ++	git rev-parse HEAD~1 >commit-id-base &&
    ++	echo "base-commit: $(cat commit-id-base)" >expect &&
    ++	test_cmp expect actual
    + '
    + 
    + test_expect_success 'format-patch --base with --attach' '
2:  7619da962d ! 2:  fd908bcc01 Doc: add more detail for git-format-patch
    @@ Commit message
         Next, while we're at it, surround option arguments with <>.
     
         Finally, document the `format.outputDirectory` config and change
    -    `format.coverletter` to use camelcase.
    +    `format.coverletter` to use camel case.
     
         Signed-off-by: Denton Liu <liu.denton@gmail.com>
     
    @@ Documentation/git-format-patch.txt: Beware that the default for 'git send-email'
      	Make the first mail (or all the mails with `--no-thread`) appear as a
      	reply to the given Message-Id, which avoids breaking threads to
      	provide a new patch series.
    -@@ Documentation/git-format-patch.txt: will want to ensure that threading is disabled for `git send-email`.
    - 
    - --to=<email>::
    - 	Add a `To:` header to the email headers. This is in addition
    --	to any configured headers, and may be used multiple times.
    -+	to any configured headers, and may be used multiple times. The
    -+	emails given will be used along with any emails given by
    -+	`format.to` configurations.
    - 	The negated form `--no-to` discards all `To:` headers added so
    - 	far (from config or command line).
    - 
    - --cc=<email>::
    - 	Add a `Cc:` header to the email headers. This is in addition
    --	to any configured headers, and may be used multiple times.
    -+	to any configured headers, and may be used multiple times. The
    -+	emails given will be used along with any emails given by
    -+	`format.cc` configurations.
    - 	The negated form `--no-cc` discards all `Cc:` headers added so
    - 	far (from config or command line).
    - 
     @@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
      --base=<commit>::
      	Record the base tree information to identify the state the
      	patch series applies to.  See the BASE TREE INFORMATION section
     -	below for details.
    -+	below for details. If <commit> is equal to "auto", a base commit
    -+	is automatically chosen.
    ++	below for details. If <commit> is "auto", a base commit is
    ++	automatically chosen.
      
      --root::
      	Treat the revision argument as a <revision range>, even if it
-:  ---------- > 3:  94a778c9aa config/format.txt: make clear the default value of format.coverLetter
3:  5cc5e354b6 ! 4:  e682bd347a format-patch: infer cover letter from branch description
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    format-patch: infer cover letter from branch description
    +    format-patch: learn --infer-cover-letter option
     
         We used to populate the subject of the cover letter generated by
         git-format-patch with "*** SUBJECT HERE ***". However, if a user submits
    @@ Documentation/config/format.txt: format.subjectPrefix::
      	subject prefix. Use this variable to change that prefix.
      
     +format.inferCoverSubject::
    -+	A boolean that controls whether or not to infer the subject for
    -+	the cover letter based on the branch's description. See the
    -+	--infer-cover-subject option in linkgit:git-format-patch[1].
    ++	A boolean value which lets you enable the
    ++	`--infer-cover-subject` option of format-patch by default.
     +
      format.signature::
      	The default for format-patch is to output a signature containing
-- 
2.23.0.248.g3a9dd8fb08

