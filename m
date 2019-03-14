Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EBC20248
	for <e@80x24.org>; Thu, 14 Mar 2019 21:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfCNVrx (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 17:47:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37342 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfCNVrw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 17:47:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15so7491811wro.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 14:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lNau3thIbWx2JIjUIapDDhw9YoMwgNem0onGANgWusg=;
        b=PewHLSIK+QJMpZ5w7YUOmD/OpEpVlBdzCpWOL6dLLEFRgKEKrLfM4UGlN7y8R+mBTB
         wAWattZS8syE9dzsMenxy42+UD/+8dEYEkrsr0uetjuUXBAYs0RuFMv6C0j04jF9BGpf
         7fyUhAHEWwIxtGbDxjS60nYmqo6s3pKyn6v2Suiv27vlGi0ftay2YrnOLAAzOUlMbCVK
         kqlWfgIOWhW3K1MG7o8qSd6OzPa9zSSfqbfml8HdC9GsWxiZYXA3QvYTk3tizzoPwFFu
         swVZzw+Xz0++4IYAaCZmvSIQKG4b/Z4QTu8SQdB5waH0CEkX1C0fy81ptkHjbwAVxNK7
         RWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNau3thIbWx2JIjUIapDDhw9YoMwgNem0onGANgWusg=;
        b=DjysDZdaconAAztTU7e8B2DD0HzbW/Oerrdw/96jnKL9vnuRQaGYd1YaBc+U27u552
         1/bvwuxfAjwlBEH0BH5QehSa/tU1l/lYJovL4ZfcmqghHAuQ7kz5XyOYLH3zGK8db5jM
         i8cB3161TAOONMAdMzg1lfkYD/2LLhJomgvHNdTIKetm1WZwbNPdqmD++2hWOqWpfrFi
         f7Q6/K8UdKfoH7UyJsUfpmHcvBsdS0hE44fwZpnOuEiVJewcVxPChtelpHMhMlJ2PoR1
         pALBZnNkSDIKUMtASqL3SQB0n7ZWw0Sm5emUqLgxCK2iT3/tQ+0De8Rn/MQ7c5fGnrA7
         i3hA==
X-Gm-Message-State: APjAAAUnlqkacs80WywRAqduQqd8whmVwtDGmxGJqjLQvbnDRbcuGsyY
        74shcSxRW+sy9eFgGuLHh36LnYRg6vw=
X-Google-Smtp-Source: APXvYqx8qdcx/3ZgHHlmNFI609QiJvocZ5V25DAvTlVXQSmFHEQQMjGA16E+qAci1TI1Fs/EVGEUZQ==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr79613wru.140.1552600069943;
        Thu, 14 Mar 2019 14:47:49 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h137sm194348wmg.41.2019.03.14.14.47.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Mar 2019 14:47:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/8] commit-graph: segfault & other fixes for broken graphs
Date:   Thu, 14 Mar 2019 22:47:32 +0100
Message-Id: <20190314214740.23360-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190221223753.20070-1-avarab@gmail.com>
References: <20190221223753.20070-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See the v1 cover letter for details:
https://public-inbox.org/git/20190221223753.20070-1-avarab@gmail.com/

I'd forgotten this after 2.21 was released.

This addresses all the comments on v1 and rebases it. A range-diff is
below. I also improved 7/8's commit message a bit.

I fixed a test to avoid the pattern a0a630192d
(t/check-non-portable-shell: detect "FOO=bar shell_func", 2018-07-13)
tests for. The new pattern is more obvious.

As an aside I don't get how that doesn't work as intended from the
commit message of that commit & its series.

    $ cat /tmp/x.sh 
    sayit() { echo "saying '$SAY'"; };
    SAY=hi sayit; sayit;
    $ sh /tmp/x.sh
    saying 'hi'
    saying ''

I get the same thing on bash, dash, NetBSD ksh, Solaris's shell &
AIX's. I.e. it's explicitly not assigning $SAY for the duration of the
shell as this would do:

    $ cat /tmp/y.sh 
    sayit() { echo "saying '$SAY'"; };
    SAY=hi; sayit; sayit;
    $ sh /tmp/y.sh
    saying 'hi'
    saying 'hi'

Which is the impression I get from the commit message.

Ævar Arnfjörð Bjarmason (8):
  commit-graph tests: split up corrupt_graph_and_verify()
  commit-graph tests: test a graph that's too small
  commit-graph: fix segfault on e.g. "git status"
  commit-graph: don't early exit(1) on e.g. "git status"
  commit-graph: don't pass filename to load_commit_graph_one_fd_st()
  commit-graph verify: detect inability to read the graph
  commit-graph write: don't die if the existing graph is corrupt
  commit-graph: improve & i18n error messages

 builtin/commit-graph.c  |  23 +++++--
 commit-graph.c          | 132 +++++++++++++++++++++++++++-------------
 commit-graph.h          |   4 ++
 commit.h                |   6 ++
 t/t5318-commit-graph.sh |  42 +++++++++++--
 5 files changed, 154 insertions(+), 53 deletions(-)

Range-diff:
1:  9d318d5106 ! 1:  2f8ba0adf8 commit-graph tests: split up corrupt_graph_and_verify()
    @@ -49,7 +49,7 @@
     -	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
     -	cp $objdir/info/commit-graph commit-graph-backup &&
      	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
    - 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
    + 	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" if=/dev/null &&
      	generate_zero_bytes $(($orig_size - $zero_pos)) >>"$objdir/info/commit-graph" &&
     -	test_must_fail git commit-graph verify 2>test_err &&
     -	grep -v "^+" test_err >err &&
2:  73849add5e = 2:  800b17edde commit-graph tests: test a graph that's too small
3:  6bfce758e1 = 3:  7083ab81c7 commit-graph: fix segfault on e.g. "git status"
4:  ac07ff415e = 4:  d00564ae89 commit-graph: don't early exit(1) on e.g. "git status"
5:  b2dd394cc7 = 5:  25ee185bf7 commit-graph: don't pass filename to load_commit_graph_one_fd_st()
6:  9987149e5c ! 6:  7619b46987 commit-graph verify: detect inability to read the graph
    @@ -37,16 +37,10 @@
      
      }
      
    -+test_expect_success 'detect permission problem' '
    ++test_expect_success POSIXPERM,SANITY 'detect permission problem' '
     +	corrupt_graph_setup &&
     +	chmod 000 $objdir/info/commit-graph &&
    -+
    -+	# Skip as root, or in other cases (odd fs or OS) where a
    -+	# "chmod 000 file" does not yield EACCES on e.g. "cat file"
    -+	if ! test -r $objdir/info/commit-graph
    -+	then
    -+		corrupt_graph_verify "Could not open"
    -+	fi
    ++	corrupt_graph_verify "Could not open"
     +'
     +
      test_expect_success 'detect too small' '
7:  0e35b12a1a ! 7:  17ee4fc050 commit-graph write: don't die if the existing graph is corrupt
    @@ -18,6 +18,10 @@
         use_commit_graph=1 as seen in 177722b344 ("commit: integrate commit
         graph with commit parsing", 2018-04-10).
     
    +    Not using the old graph at all slows down the writing of the new graph
    +    by some small amount, but is a sensible way to prevent an error in the
    +    existing commit-graph from spreading.
    +
         Just fixing the current issue would be likely to result in code that's
         inadvertently broken in the future. New code might use the
         commit-graph at a distance. To detect such cases introduce a
    @@ -36,7 +40,12 @@
         corruption.
     
         This might need to be re-visited if we learn to write the commit-graph
    -    incrementally.
    +    incrementally, but probably not. Hopefully we'll just start by finding
    +    out what commits we have in total, then read the old graph(s) to see
    +    what they cover, and finally write a new graph file with everything
    +    that's missing. In that case the new graph writing code just needs to
    +    continue to use e.g. a parse_commit() that doesn't consult the
    +    existing commit-graphs.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ -119,7 +128,7 @@
      	grep -v "^+" test_err >err &&
      	test_i18ngrep "$grepstr" err &&
     -	git status --short
    -+	if test -z "$NO_WRITE_TEST_BACKUP"
    ++	if test "$2" != "no-copy"
     +	then
     +		cp $objdir/info/commit-graph commit-graph-pre-write-test
     +	fi &&
    @@ -130,14 +139,14 @@
      
      # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
     @@
    - 	# "chmod 000 file" does not yield EACCES on e.g. "cat file"
    - 	if ! test -r $objdir/info/commit-graph
    - 	then
    --		corrupt_graph_verify "Could not open"
    -+		NO_WRITE_TEST_BACKUP=1 corrupt_graph_verify "Could not open"
    - 	fi
    + test_expect_success POSIXPERM,SANITY 'detect permission problem' '
    + 	corrupt_graph_setup &&
    + 	chmod 000 $objdir/info/commit-graph &&
    +-	corrupt_graph_verify "Could not open"
    ++	corrupt_graph_verify "Could not open" "no-copy"
      '
      
    + test_expect_success 'detect too small' '
     @@
      	git fsck &&
      	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
8:  a74d0f0f6f = 8:  29ab2895b7 commit-graph: improve & i18n error messages
-- 
2.21.0.360.g471c308f928

