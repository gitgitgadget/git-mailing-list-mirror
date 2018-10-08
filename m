Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6871F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 14:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbeJHWEQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 18:04:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43136 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeJHWEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 18:04:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so7930515pgh.10
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 07:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2FZyh2aMiMxE0NtGtFoXlEwAYnelS5AsDXVMCALGzm0=;
        b=Cv0yTAuoxcuICKeCDyFsfdabuFyBn9iewcbGQQxUs6ppadn7A2QPrPwmNhnd5Oj/fe
         jPJEBqlPbN8gEVEDw7AVEaWNQYtdsjo6WhTbESfhuhdNTKKB8VmQQAm7EiHCqW+KZNa/
         Ofb/yD0nG5gjZ+lcDvIQiGHmbLQZqQIE4ihoxdRGjONT6EoX50tYg4XOTtMU3DXruSB2
         NFka1JtzUw0y+6+RPXv2GNb29OF8WcOfW+/6QjIjsEMwM2s3m+v3r3Pev0j2hJpnUKoX
         osvcUclWwgv4af1b0r5sItO4gAYRC0tm3+FwzYpQjkUWG0qeEaTCrgB7yQ2M0nbelKFL
         aAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2FZyh2aMiMxE0NtGtFoXlEwAYnelS5AsDXVMCALGzm0=;
        b=XSkYQYpzoJMTspM6SwhBgEMOgWGn0/jH+oNajyU+C2fKrkBGNHG6znMSGZRfqN/Zi6
         g8U6ThMgJblcacAfxR0QDQ99uRE0v8avBPnw3Zem+asNt2D8OmCXbDsYyASyd3t1juVJ
         yZT8KPrDQBmSayzSygzh5Zquz2QIVhLhscdNMAY544KE86i3f1mrizx+1kaP0CoOXwt7
         wpmYPZeGjRxq3aezu4/9ubOh7Fy/WBZKTpaECV5wnfWmfytPm8hEQH7hd4jZo/52tccJ
         AXQG89yPDgfbHoMWVh2wKvwKR7h1IusTy41EOr9JZxFWs/onJUB4J2yE1GP5dBy20L33
         6NSQ==
X-Gm-Message-State: ABuFfoiHbWM5oyur4CQbfTRS9pP8VNoZ3e+2DMv7FwVXhM1GYGKu2NM8
        vOqlua2z5HYLRmMycFaltilQy67b
X-Google-Smtp-Source: ACcGV610cjUCOit0AnY4+Fncc3p7S/5mLC3L4Fd+LbzQV23wuIujcWmCQWE3vSr9YiegLI8YgJjqtA==
X-Received: by 2002:a63:a441:: with SMTP id c1-v6mr2074391pgp.49.1539010328945;
        Mon, 08 Oct 2018 07:52:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id l26-v6sm26339384pfg.161.2018.10.08.07.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 07:52:08 -0700 (PDT)
Date:   Mon, 08 Oct 2018 07:52:08 -0700 (PDT)
X-Google-Original-Date: Mon, 08 Oct 2018 14:52:05 GMT
Message-Id: <pull.40.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.40.v3.git.gitgitgadget@gmail.com>
References: <pull.40.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/1] contrib: Add script to show uncovered "new" lines
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have coverage targets in our Makefile for using gcov to display line
coverage based on our test suite. The way I like to do it is to run:

make coverage-test
make coverage-report

This leaves the repo in a state where every X.c file that was covered has an
X.c.gcov file containing the coverage counts for every line, and "#####" at
every uncovered line.

There have been a few bugs in recent patches what would have been caught if
the test suite covered those blocks (including a few of mine). I want to
work towards a "sensible" amount of coverage on new topics. In my opinion,
this means that any logic should be covered, but the 'die()' blocks in error
cases do not need to be covered.

It is important to not measure the coverage of the codebase by what old code
is not covered. To help, I created the 'contrib/coverage-diff.sh' script.
After creating the coverage statistics at a version (say, 'topic') you can
then run

contrib/coverage-diff.sh base topic

to see the lines added between 'base' and 'topic' that are not covered by
the test suite. For example, I ran this against the 'next' branch (e82ca0)
versus 'master' (f84b9b) and got the following output:

builtin/commit.c
76f2f5c1e3 builtin/commit.c 1657) write_commit_graph_reachable(get_object_directory(), 0, 0);

builtin/fsck.c
66ec0390e7 builtin/fsck.c 862) midx_argv[2] = "--object-dir";
66ec0390e7 builtin/fsck.c 863) midx_argv[3] = alt->path;
66ec0390e7 builtin/fsck.c 864) if (run_command(&midx_verify))
66ec0390e7 builtin/fsck.c 865) errors_found |= ERROR_COMMIT_GRAPH;

fsck.c
fb8952077d  214) die_errno("Could not read '%s'", path);

midx.c
56ee7ff156  949) return 0;
cc6af73c02  990) midx_report(_("failed to load pack-index for packfile %s"),
cc6af73c02  991)     e.p->pack_name);
cc6af73c02  992) break;

Commits introducing uncovered code:
Derrick Stolee      56ee7ff15: multi-pack-index: add 'verify' verb
Derrick Stolee      66ec0390e: fsck: verify multi-pack-index
Derrick Stolee      cc6af73c0: multi-pack-index: verify object offsets
Junio C Hamano      76f2f5c1e: Merge branch 'ab/commit-graph-progress' into next
René Scharfe      fb8952077: fsck: use strbuf_getline() to read skiplist file

Thanks, -Stolee

CHANGES IN V3: I took Junio's perl script verbatim, which speeds up the
performance greatly. Some of the other sed commands needed some massaging,
but also added extra cleanup. Thanks for the help!

CHANGES IN V4: I reduced the blame output using -s which decreases the
width. I include a summary of the commit authors at the end to help people
see the lines they wrote. This version is also copied into a build
definition in the public Git project on Azure Pipelines [1]. I'll use this
build definition to generate the coverage report after each "What's Cooking"
email.

[1] https://git.visualstudio.com/git/_build?definitionId=5

Derrick Stolee (1):
  contrib: add coverage-diff script

 contrib/coverage-diff.sh | 108 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100755 contrib/coverage-diff.sh


base-commit: 1d4361b0f344188ab5eec6dcea01f61a3a3a1670
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-40%2Fderrickstolee%2Fcoverage-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-40/derrickstolee/coverage-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/40

Range-diff vs v3:

 1:  21214cc321 ! 1:  6daf310a43 contrib: add coverage-diff script
     @@ -26,10 +26,10 @@
              contrib/coverage-diff.sh base topic
      
          to see the lines added between 'base' and 'topic' that are not covered by the
     -    test suite. The output uses 'git blame -c' format so you can find the commits
     -    responsible and view the line numbers for quick access to the context.
     +    test suite. The output uses 'git blame -s' format so you can find the commits
     +    responsible and view the line numbers for quick access to the context, but
     +    trims leading tabs in the file contents to reduce output width.
      
     -    Helped-by: Junio C Hamano <gister@pobox.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
      diff --git a/contrib/coverage-diff.sh b/contrib/coverage-diff.sh
     @@ -81,13 +81,16 @@
      +	'
      +}
      +
     -+files=$(git diff --name-only $V1 $V2 -- *.c)
     ++files=$(git diff --name-only "$V1" "$V2" -- \*.c)
     ++
     ++# create empty file
     ++>coverage-data.txt
      +
      +for file in $files
      +do
     -+	git diff $V1 $V2 -- $file \
     -+		| diff_lines \
     -+		| sort >new_lines.txt
     ++	git diff "$V1" "$V2" -- "$file" |
     ++	diff_lines |
     ++	sort >new_lines.txt
      +
      +	if ! test -s new_lines.txt
      +	then
     @@ -95,24 +98,50 @@
      +	fi
      +
      +	hash_file=$(echo $file | sed "s/\//\#/")
     ++
     ++	if ! test -s "$hash_file.gcov"
     ++	then
     ++		continue
     ++	fi
     ++
      +	sed -ne '/#####:/{
      +			s/    #####://
      +			s/:.*//
      +			s/ //g
      +			p
     -+		}' "$hash_file.gcov" \
     -+		| sort >uncovered_lines.txt
     ++		}' "$hash_file.gcov" |
     ++	sort >uncovered_lines.txt
      +
     -+	comm -12 uncovered_lines.txt new_lines.txt \
     -+		| sed -e 's/$/\)/' \
     -+		| sed -e 's/^/\t/' \
     -+		>uncovered_new_lines.txt
     ++	comm -12 uncovered_lines.txt new_lines.txt |
     ++	sed -e 's/$/\)/' |
     ++	sed -e 's/^/ /' >uncovered_new_lines.txt
      +
     -+	grep -q '[^[:space:]]' < uncovered_new_lines.txt && \
     -+		echo $file && \
     -+		git blame -c $file \
     -+			| grep -f uncovered_new_lines.txt
     ++	grep -q '[^[:space:]]' <uncovered_new_lines.txt &&
     ++	echo $file >>coverage-data.txt &&
     ++	git blame -s "$V2" -- "$file" |
     ++	sed 's/\t//g' |
     ++	grep -f uncovered_new_lines.txt >>coverage-data.txt &&
     ++	echo >>coverage-data.txt
      +
      +	rm -f new_lines.txt uncovered_lines.txt uncovered_new_lines.txt
      +done
      +
     ++cat coverage-data.txt
     ++
     ++echo "Commits introducing uncovered code:"
     ++
     ++commit_list=$(cat coverage-data.txt |
     ++	grep -E '^[0-9a-f]{7,} ' |
     ++	awk '{print $1;}' |
     ++	sort |
     ++	uniq)
     ++
     ++(
     ++	for commit in $commit_list
     ++	do
     ++		git log --no-decorate --pretty=format:'%an      %h: %s' -1 $commit
     ++		echo
     ++	done
     ++) | sort
     ++
     ++rm coverage-data.txt

-- 
gitgitgadget
