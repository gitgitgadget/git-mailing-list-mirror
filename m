Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E861F463
	for <e@80x24.org>; Mon, 16 Sep 2019 23:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfIPXvz (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 19:51:55 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:34843 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfIPXvy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 19:51:54 -0400
Received: by mail-pl1-f173.google.com with SMTP id s17so640470plp.2
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QMCRTwNUYjdzJSJtizb3P7Snj2PDdPcsBRmxk+Zzw4A=;
        b=MLgpLuxTUgjvxWMxi+UmTJBDEmHsklsB3LAbVuUmQmCxRJOOsa94ZrX/aG0FIuCxsd
         byQCTtftGePiCn75IFdHScd73LQucpElnpl6MzL3TG9njMH+krOAfjt866XRggBJf3Ua
         PM3QbfuluhXS4uGM6dKyoiFQUYxxMPPnBvOzNXok8cRzgrVYczIgVB+ql7iXQ4JfmClJ
         xQP4ajr6ddu8Llzk98orT8ofgc0dqMAIPrFa94zXcl9426UBgghJe70Bc60ksyUF4usK
         RgF5WwWkFfuyuhWw0Bx4ek5Wo1gU4lZ4VOWctlRUr8VPqgAvxiXncHF1W3/hHoOFscO0
         mH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QMCRTwNUYjdzJSJtizb3P7Snj2PDdPcsBRmxk+Zzw4A=;
        b=t6Q+MMRy7W2nKiLRZjfWCq+CTxiSnHjxWFQoP35dD1gYAmTIekY7np64tCbcBm3VC8
         KZcU/ECZ6W//Uwf9ZOIV7qfsa5M43WJOk/lLH7D4Jq5/5ppqas+KDUc+5uofXpttnFUj
         XyQAzNjywhA0khlD901OE3ka2Y2A2dY5mkVxXwg+5XjRPv/7+cmfROAAGrNH55xKDNvx
         13mRWK34snOvtDDbItBsmaSLld8dnhpuocUEjaDgJVZV8xY+TLCXQz0S8UbgFPm4zfc/
         STHwb/NszsD5xxo87WJ/XfVKExtILnI9etCz5jTexoZs9jhHfH/9kD6PddhUTStgPIYK
         FvlQ==
X-Gm-Message-State: APjAAAVed7Tx+EjMLUa2CP4RlC6Ql+3P3kI5csiibG5RLUIQPzg1XITa
        Kh/X3qlXRwUHV37feP98WHqpeoaDlvc=
X-Google-Smtp-Source: APXvYqysqDxFmJJtVUtAkuPeohOp2aThFaX3W9ump1bqPZqBPhiSQSkjHIGPyFNR6e60RH8S1+/7ng==
X-Received: by 2002:a17:902:690a:: with SMTP id j10mr732897plk.125.1568677912832;
        Mon, 16 Sep 2019 16:51:52 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id f20sm191225pgg.56.2019.09.16.16.51.50
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 16:51:51 -0700 (PDT)
Date:   Mon, 16 Sep 2019 16:51:49 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [BUG] t7030 is flaky
Message-ID: <20190916235149.GA96478@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

I just wanted to report that t7030 is flaky. I first noticed this on
Szeder's Travis job[1]. I was also able to reproduce this on my Macbook
with gpg (GnuPG) 2.2.17 and git version 2.23.0.248.g3a9dd8fb08 (latest
master) by running `./t7030-verify-tag.sh --stress`.

I'll try to investigate later but for now but at the bottom of this
email is the trace I obtained.

[1]: https://travis-ci.org/szeder/git-cooking-topics-for-travis-ci/jobs/518540359


Initialized empty Git repository in /Users/denton.liu/projects/git/t/trash directory.t7030-verify-tag.stress-1/.git/
expecting success of 7030.1 'create signed tags': 
	echo 1 >file && git add file &&
	test_tick && git commit -m initial &&
	git tag -s -m initial initial &&
	git branch side &&

	echo 2 >file && test_tick && git commit -a -m second &&
	git tag -s -m second second &&

	git checkout side &&
	echo 3 >elif && git add elif &&
	test_tick && git commit -m "third on side" &&

	git checkout master &&
	test_tick && git merge -S side &&
	git tag -s -m merge merge &&

	echo 4 >file && test_tick && git commit -a -S -m "fourth unsigned" &&
	git tag -a -m fourth-unsigned fourth-unsigned &&

	test_tick && git commit --amend -S -m "fourth signed" &&
	git tag -s -m fourth fourth-signed &&

	echo 5 >file && test_tick && git commit -a -m "fifth" &&
	git tag fifth-unsigned &&

	git config commit.gpgsign true &&
	echo 6 >file && test_tick && git commit -a -m "sixth" &&
	git tag -a -m sixth sixth-unsigned &&

	test_tick && git rebase -f HEAD^^ && git tag -s -m 6th sixth-signed HEAD^ &&
	git tag -m seventh -s seventh-signed &&

	echo 8 >file && test_tick && git commit -a -m eighth &&
	git tag -uB7227189 -m eighth eighth-signed-alt

++ echo 1
++ git add file
++ test_tick
++ test -z ''
++ test_tick=1112911993
++ GIT_COMMITTER_DATE='1112911993 -0700'
++ GIT_AUTHOR_DATE='1112911993 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m initial
[master (root-commit) 777c62c] initial
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file
++ git tag -s -m initial initial
++ git branch side
++ echo 2
++ test_tick
++ test -z set
++ test_tick=1112912053
++ GIT_COMMITTER_DATE='1112912053 -0700'
++ GIT_AUTHOR_DATE='1112912053 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -a -m second
[master 38545ae] second
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag -s -m second second
++ git checkout side
Switched to branch 'side'
++ echo 3
++ git add elif
++ test_tick
++ test -z set
++ test_tick=1112912113
++ GIT_COMMITTER_DATE='1112912113 -0700'
++ GIT_AUTHOR_DATE='1112912113 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -m 'third on side'
[side 684a8f8] third on side
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 elif
++ git checkout master
Switched to branch 'master'
++ test_tick
++ test -z set
++ test_tick=1112912173
++ GIT_COMMITTER_DATE='1112912173 -0700'
++ GIT_AUTHOR_DATE='1112912173 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git merge -S side
Merging:
38545ae second
virtual side
found 1 common ancestor:
777c62c initial
Merge made by the 'recursive' strategy.
 elif | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 elif
++ git tag -s -m merge merge
++ echo 4
++ test_tick
++ test -z set
++ test_tick=1112912233
++ GIT_COMMITTER_DATE='1112912233 -0700'
++ GIT_AUTHOR_DATE='1112912233 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -a -S -m 'fourth unsigned'
[master 6167475] fourth unsigned
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag -a -m fourth-unsigned fourth-unsigned
++ test_tick
++ test -z set
++ test_tick=1112912293
++ GIT_COMMITTER_DATE='1112912293 -0700'
++ GIT_AUTHOR_DATE='1112912293 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit --amend -S -m 'fourth signed'
[master d9607ab] fourth signed
 Author: A U Thor <author@example.com>
 Date: Thu Apr 7 15:17:13 2005 -0700
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag -s -m fourth fourth-signed
++ echo 5
++ test_tick
++ test -z set
++ test_tick=1112912353
++ GIT_COMMITTER_DATE='1112912353 -0700'
++ GIT_AUTHOR_DATE='1112912353 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -a -m fifth
[master 42b0e02] fifth
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag fifth-unsigned
++ git config commit.gpgsign true
++ echo 6
++ test_tick
++ test -z set
++ test_tick=1112912413
++ GIT_COMMITTER_DATE='1112912413 -0700'
++ GIT_AUTHOR_DATE='1112912413 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -a -m sixth
[master d964495] sixth
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag -a -m sixth sixth-unsigned
++ test_tick
++ test -z set
++ test_tick=1112912473
++ GIT_COMMITTER_DATE='1112912473 -0700'
++ GIT_AUTHOR_DATE='1112912473 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git rebase -f 'HEAD^^'
Current branch master is up to date, rebase forced.
First, rewinding head to replay your work on top of it...
Applying: fifth
Applying: sixth
++ git tag -s -m 6th sixth-signed 'HEAD^'
++ git tag -m seventh -s seventh-signed
++ echo 8
++ test_tick
++ test -z set
++ test_tick=1112912533
++ GIT_COMMITTER_DATE='1112912533 -0700'
++ GIT_AUTHOR_DATE='1112912533 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -a -m eighth
[master 55ae986] eighth
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag -uB7227189 -m eighth eighth-signed-alt
ok 1 - create signed tags

expecting success of 7030.2 'create signed tags x509 ': 
	test_config gpg.format x509 &&
	test_config user.signingkey $GIT_COMMITTER_EMAIL &&
	echo 9 >file && test_tick && git commit -a -m "nineth gpgsm-signed" &&
	git tag -s -m nineth nineth-signed-x509

++ test_config gpg.format x509
++ config_dir=
++ test gpg.format = -C
++ test_when_finished 'test_unconfig  '\''gpg.format'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig  '\''gpg.format'\''
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ git config gpg.format x509
++ test_config user.signingkey committer@example.com
++ config_dir=
++ test user.signingkey = -C
++ test_when_finished 'test_unconfig  '\''user.signingkey'\'''
++ test 0 = 0
++ test_cleanup='{ test_unconfig  '\''user.signingkey'\''
		} && (exit "$eval_ret"); eval_ret=$?; { test_unconfig  '\''gpg.format'\''
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ git config user.signingkey committer@example.com
++ echo 9
++ test_tick
++ test -z set
++ test_tick=1112912593
++ GIT_COMMITTER_DATE='1112912593 -0700'
++ GIT_AUTHOR_DATE='1112912593 -0700'
++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
++ git commit -a -m 'nineth gpgsm-signed'
[master 85ca5b8] nineth gpgsm-signed
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
++ git tag -s -m nineth nineth-signed-x509
++ test_unconfig user.signingkey
++ config_dir=
++ test user.signingkey = -C
++ git config --unset-all user.signingkey
++ config_status=0
++ case "$config_status" in
++ return 0
++ exit 0
++ eval_ret=0
++ test_unconfig gpg.format
++ config_dir=
++ test gpg.format = -C
++ git config --unset-all gpg.format
++ config_status=0
++ case "$config_status" in
++ return 0
++ exit 0
++ eval_ret=0
++ :
ok 2 - create signed tags x509 

expecting success of 7030.3 'verify and show signatures': 
	(
		for tag in initial second merge fourth-signed sixth-signed seventh-signed
		do
			git verify-tag $tag 2>actual &&
			grep "Good signature from" actual &&
			! grep "BAD signature from" actual &&
			echo $tag OK || exit 1
		done
	) &&
	(
		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
		do
			test_must_fail git verify-tag $tag 2>actual &&
			! grep "Good signature from" actual &&
			! grep "BAD signature from" actual &&
			echo $tag OK || exit 1
		done
	) &&
	(
		for tag in eighth-signed-alt
		do
			git verify-tag $tag 2>actual &&
			grep "Good signature from" actual &&
			! grep "BAD signature from" actual &&
			grep "not certified" actual &&
			echo $tag OK || exit 1
		done
	)

++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag initial
++ grep 'Good signature from' actual
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'BAD signature from' actual
++ echo initial OK
initial OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag second
++ grep 'Good signature from' actual
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'BAD signature from' actual
++ echo second OK
second OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag merge
++ grep 'Good signature from' actual
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'BAD signature from' actual
++ echo merge OK
merge OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag fourth-signed
++ grep 'Good signature from' actual
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'BAD signature from' actual
++ echo fourth-signed OK
fourth-signed OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag sixth-signed
++ grep 'Good signature from' actual
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'BAD signature from' actual
++ echo sixth-signed OK
sixth-signed OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag seventh-signed
++ grep 'Good signature from' actual
gpg: Good signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'BAD signature from' actual
++ echo seventh-signed OK
seventh-signed OK
++ for tag in fourth-unsigned fifth-unsigned sixth-unsigned
++ test_must_fail git verify-tag fourth-unsigned
++ case "$1" in
++ _test_ok=
++ git verify-tag fourth-unsigned
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep 'Good signature from' actual
++ grep 'BAD signature from' actual
++ echo fourth-unsigned OK
fourth-unsigned OK
++ for tag in fourth-unsigned fifth-unsigned sixth-unsigned
++ test_must_fail git verify-tag fifth-unsigned
++ case "$1" in
++ _test_ok=
++ git verify-tag fifth-unsigned
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep 'Good signature from' actual
++ grep 'BAD signature from' actual
++ echo fifth-unsigned OK
fifth-unsigned OK
++ for tag in fourth-unsigned fifth-unsigned sixth-unsigned
++ test_must_fail git verify-tag sixth-unsigned
++ case "$1" in
++ _test_ok=
++ git verify-tag sixth-unsigned
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep 'Good signature from' actual
++ grep 'BAD signature from' actual
++ echo sixth-unsigned OK
sixth-unsigned OK
++ for tag in eighth-signed-alt
++ git verify-tag eighth-signed-alt
++ grep 'Good signature from' actual
gpg: Good signature from "Eris Discordia <discord@example.net>" [unknown]
++ grep 'BAD signature from' actual
++ grep 'not certified' actual
gpg: WARNING: This key is not certified with a trusted signature!
++ echo eighth-signed-alt OK
eighth-signed-alt OK
ok 3 - verify and show signatures

expecting success of 7030.4 'verify and show signatures x509': 
	git verify-tag nineth-signed-x509 2>actual &&
	grep "Good signature from" actual &&
	! grep "BAD signature from" actual &&
	echo nineth-signed-x509 OK

++ git verify-tag nineth-signed-x509
++ grep 'Good signature from' actual
gpgsm: Good signature from "/CN=C O Mitter/O=Example/SN=C O/GN=Mitter"
++ grep 'BAD signature from' actual
++ echo nineth-signed-x509 OK
nineth-signed-x509 OK
ok 4 - verify and show signatures x509

expecting success of 7030.5 'detect fudged signature': 
	git cat-file tag seventh-signed >raw &&
	sed -e "/^tag / s/seventh/7th forged/" raw >forged1 &&
	git hash-object -w -t tag forged1 >forged1.tag &&
	test_must_fail git verify-tag $(cat forged1.tag) 2>actual1 &&
	grep "BAD signature from" actual1 &&
	! grep "Good signature from" actual1

++ git cat-file tag seventh-signed
++ sed -e '/^tag / s/seventh/7th forged/' raw
++ git hash-object -w -t tag forged1
+++ cat forged1.tag
++ test_must_fail git verify-tag 87979e7f1f67a2f370d47dff955a7b7a2fe8db28
++ case "$1" in
++ _test_ok=
++ git verify-tag 87979e7f1f67a2f370d47dff955a7b7a2fe8db28
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep 'BAD signature from' actual1
gpg: BAD signature from "C O Mitter <committer@example.com>" [ultimate]
++ grep 'Good signature from' actual1
ok 5 - detect fudged signature

expecting success of 7030.6 'verify signatures with --raw': 
	(
		for tag in initial second merge fourth-signed sixth-signed seventh-signed
		do
			git verify-tag --raw $tag 2>actual &&
			grep "GOODSIG" actual &&
			! grep "BADSIG" actual &&
			echo $tag OK || exit 1
		done
	) &&
	(
		for tag in fourth-unsigned fifth-unsigned sixth-unsigned
		do
			test_must_fail git verify-tag --raw $tag 2>actual &&
			! grep "GOODSIG" actual &&
			! grep "BADSIG" actual &&
			echo $tag OK || exit 1
		done
	) &&
	(
		for tag in eighth-signed-alt
		do
			git verify-tag --raw $tag 2>actual &&
			grep "GOODSIG" actual &&
			! grep "BADSIG" actual &&
			grep "TRUST_UNDEFINED" actual &&
			echo $tag OK || exit 1
		done
	)

++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag --raw initial
++ grep GOODSIG actual
[GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
++ grep BADSIG actual
++ echo initial OK
initial OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag --raw second
++ grep GOODSIG actual
[GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
++ grep BADSIG actual
++ echo second OK
second OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag --raw merge
++ grep GOODSIG actual
[GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
++ grep BADSIG actual
++ echo merge OK
merge OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag --raw fourth-signed
++ grep GOODSIG actual
[GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
++ grep BADSIG actual
++ echo fourth-signed OK
fourth-signed OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag --raw sixth-signed
++ grep GOODSIG actual
[GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
++ grep BADSIG actual
++ echo sixth-signed OK
sixth-signed OK
++ for tag in initial second merge fourth-signed sixth-signed seventh-signed
++ git verify-tag --raw seventh-signed
++ grep GOODSIG actual
[GNUPG:] GOODSIG 13B6F51ECDDE430D C O Mitter <committer@example.com>
++ grep BADSIG actual
++ echo seventh-signed OK
seventh-signed OK
++ for tag in fourth-unsigned fifth-unsigned sixth-unsigned
++ test_must_fail git verify-tag --raw fourth-unsigned
++ case "$1" in
++ _test_ok=
++ git verify-tag --raw fourth-unsigned
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep GOODSIG actual
++ grep BADSIG actual
++ echo fourth-unsigned OK
fourth-unsigned OK
++ for tag in fourth-unsigned fifth-unsigned sixth-unsigned
++ test_must_fail git verify-tag --raw fifth-unsigned
++ case "$1" in
++ _test_ok=
++ git verify-tag --raw fifth-unsigned
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep GOODSIG actual
++ grep BADSIG actual
++ echo fifth-unsigned OK
fifth-unsigned OK
++ for tag in fourth-unsigned fifth-unsigned sixth-unsigned
++ test_must_fail git verify-tag --raw sixth-unsigned
++ case "$1" in
++ _test_ok=
++ git verify-tag --raw sixth-unsigned
++ exit_code=1
++ test 1 -eq 0
++ test_match_signal 13 1
++ test 1 = 141
++ test 1 = 269
++ return 1
++ test 1 -gt 129
++ test 1 -eq 127
++ test 1 -eq 126
++ return 0
++ grep GOODSIG actual
++ grep BADSIG actual
++ echo sixth-unsigned OK
sixth-unsigned OK
++ for tag in eighth-signed-alt
++ git verify-tag --raw eighth-signed-alt
++ grep GOODSIG actual
[GNUPG:] GOODSIG 65A0EEA02E30CAD7 Eris Discordia <discord@example.net>
++ grep BADSIG actual
++ grep TRUST_UNDEFINED actual
[GNUPG:] TRUST_UNDEFINED 0 pgp
++ echo eighth-signed-alt OK
eighth-signed-alt OK
ok 6 - verify signatures with --raw

expecting success of 7030.7 'verify signatures with --raw x509': 
	git verify-tag --raw nineth-signed-x509 2>actual &&
	grep "GOODSIG" actual &&
	! grep "BADSIG" actual &&
	echo nineth-signed-x509 OK

++ git verify-tag --raw nineth-signed-x509
++ grep GOODSIG actual
[GNUPG:] GOODSIG F8BF62E0693D0694816377099909C779FA23FD65 /CN=C O Mitter/O=Example/SN=C O/GN=Mitter
++ grep BADSIG actual
++ echo nineth-signed-x509 OK
nineth-signed-x509 OK
ok 7 - verify signatures with --raw x509

expecting success of 7030.8 'verify multiple tags': 
	tags="fourth-signed sixth-signed seventh-signed" &&
	for i in $tags
	do
		git verify-tag -v --raw $i || return 1
	done >expect.stdout 2>expect.stderr.1 &&
	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
	test_cmp expect.stdout actual.stdout &&
	test_cmp expect.stderr actual.stderr

++ tags='fourth-signed sixth-signed seventh-signed'
++ grep '^.GNUPG:.'
++ git verify-tag -v --raw fourth-signed sixth-signed seventh-signed
++ grep '^.GNUPG:.'
++ test_cmp expect.stdout actual.stdout
++ diff -u expect.stdout actual.stdout
++ test_cmp expect.stderr actual.stderr
++ diff -u expect.stderr actual.stderr
ok 8 - verify multiple tags

expecting success of 7030.9 'verify multiple tags x509': 
	tags="seventh-signed nineth-signed-x509" &&
	for i in $tags
	do
		git verify-tag -v --raw $i || return 1
	done >expect.stdout 2>expect.stderr.1 &&
	grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
	git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
	grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
	test_cmp expect.stdout actual.stdout &&
	test_cmp expect.stderr actual.stderr

++ tags='seventh-signed nineth-signed-x509'
++ grep '^.GNUPG:.'
++ git verify-tag -v --raw seventh-signed nineth-signed-x509
++ grep '^.GNUPG:.'
++ test_cmp expect.stdout actual.stdout
++ diff -u expect.stdout actual.stdout
++ test_cmp expect.stderr actual.stderr
++ diff -u expect.stderr actual.stderr
--- expect.stderr	2019-09-16 23:48:06.000000000 +0000
+++ actual.stderr	2019-09-16 23:48:06.000000000 +0000
@@ -8,7 +8,6 @@
 [GNUPG:] TRUST_ULTIMATE 0 pgp
 [GNUPG:] NEWSIG
 [GNUPG:] VERIFICATION_COMPLIANCE_MODE 23
-[GNUPG:] PROGRESS starting_agent ? 0 0
 [GNUPG:] GOODSIG F8BF62E0693D0694816377099909C779FA23FD65 /CN=C O Mitter/O=Example/SN=C O/GN=Mitter
 [GNUPG:] VALIDSIG F8BF62E0693D0694816377099909C779FA23FD65 2019-09-16 20190916T234804 30000101T000000 0 0 1 8 00
 [GNUPG:] TRUST_FULLY 0 shell
error: last command exited with $?=1
not ok 9 - verify multiple tags x509
#	
#		tags="seventh-signed nineth-signed-x509" &&
#		for i in $tags
#		do
#			git verify-tag -v --raw $i || return 1
#		done >expect.stdout 2>expect.stderr.1 &&
#		grep "^.GNUPG:." <expect.stderr.1 >expect.stderr &&
#		git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
#		grep "^.GNUPG:." <actual.stderr.1 >actual.stderr &&
#		test_cmp expect.stdout actual.stdout &&
#		test_cmp expect.stderr actual.stderr
#	
