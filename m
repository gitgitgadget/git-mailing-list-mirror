Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897752070D
	for <e@80x24.org>; Thu,  7 Jul 2016 15:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911AbcGGPxA (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 11:53:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:52443 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbcGGPw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 11:52:58 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M2ckv-1bc28I24qj-00sJHV; Thu, 07 Jul 2016 17:52:47
 +0200
Date:	Thu, 7 Jul 2016 17:52:46 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] Additional rebase -i tests
In-Reply-To: <cover.1467210629.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1467906747.git.johannes.schindelin@gmx.de>
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1FQ0gGRDIx1uidGI/5g9vurDt5cTJUg+NFrCetOAoBhrOocuPHf
 y3Pb4BfSWAXplSkwPdW7KBqjglDqAV5M1DOWZOCVWawjKqEEYKrbDc2lCeHm14qQiii/jzA
 KrgcTx2ZtvYG+/sEdgRqRzW2NSe/1CztMF6YRQK/GfM2/pSnUHtIN6O3hpZ83jcxpmYLxAg
 4bKsjOtudJH2I2to7Nnaw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:qJbtUwLiZSI=:kAnoaEeMzxIol218frY1Cd
 SkMvkGzegT/7md2gxI8BCsWtJvoiZg44/a3M1JRPitWVqqOoieml5QimCvvI/+8h1viyHzBJU
 ItKgDGq1gta3Bop84gbQoWnX7E5UqFCVfxqkZQZAtEzTe3VobOHeN8dC+TR03H2P9SsSDyGyb
 0DwJmOlsr2E5pA+rJEH4ugtYkkuoepWetuv+LMZ/hAxN/P7TNBbuiq8AQgBAeDjRWNO0dwqA5
 OlhL+EIMzRWz+GmeA9ToSIkc9fy0cDGjXui9IgGVrsC7dv5P9nAvSoIYZ875UgGiLQoXviRpc
 f/GT3XnVb+xO+FLaiknGq5rshX9YM4VT4uUDrcXL6i8zqzZjXMRG+PU3PIVSBmGGbQKee2IoU
 9+8TKLP8Q0tSCeEhlEgeD+xoJaW4IyAzL/uZOXv+QJXaCnGZkGbmSjJYOXnV9G1qeYSArCXeQ
 8ZkkKAjzAVmNe7j0dfV4xjpp8fdMEYR3dXFD/7hwtHUjI3M1HFKcQk9j7kTX0rdHE8fF//kgp
 LSgQnA9IxBkmhm38emlVfXzgvRUKV56dD1dva4AOjXucXC4tVv9iy69/a1DlVYOsnnHKdEJzV
 oR5nmkoCoUPyVBMZAiXoqEaVWTuJyoMVLBP48al1Tg+q33+Vy4EdipWGKNy6Eb/tkEclAGB8z
 EKE1GkqmpLaniKrefN0mlnMe0Eb7qRhzbnAJ4zMqMepu2krGSpZ00AA8NYl4s4BgkNBYryB0u
 xCYUOAg4bDS+SfeQ/BY5+CZrZmAkhSrBivetp9TJUfFvu0DKT7ppL9JYHmnMvX5yCkfPohn6Z
 wLq6Ce8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is just another patch series in preparation for the rebase--helper.

Relative to v1 of this patch series,

- the grammo fix was backed out because it was picked up separately,

- two new tests were introduced, one demonstrating a bug, the other one
  ensuring that the rebase--helper does not introduce a regression (this
  test actually helped me debug and fix a regression in some previous
  revision of the rebase--helper)


Johannes Schindelin (3):
  t3404: add a test for the --gpg-sign option
  rebase -i: demonstrate a bug with --autosquash
  rebase -i: we allow extra spaces after fixup!/squash!

 t/t3404-rebase-interactive.sh |  8 ++++++++
 t/t3415-rebase-autosquash.sh  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

Published-As: https://github.com/dscho/git/releases/tag/rebase-i-tests-v2
Interdiff vs v1:

 diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
 index 4c96075..aa393d2 100755
 --- a/t/t3404-rebase-interactive.sh
 +++ b/t/t3404-rebase-interactive.sh
 @@ -60,7 +60,7 @@ test_expect_success 'setup' '
  	test_commit P fileP
  '
  
 -# "exec" commands are run with the user shell by default, but this may
 +# "exec" commands are ran with the user shell by default, but this may
  # be non-POSIX. For example, if SHELL=zsh then ">file" doesn't work
  # to create a file. Unsetting SHELL avoids such non-portable behavior
  # in tests. It must be exported for it to take effect where needed.
 @@ -1281,11 +1281,12 @@ test_expect_success 'editor saves as CR/LF' '
  	)
  '
  
 -EPIPHANY="'"
 +SQ="'"
  test_expect_success 'rebase -i --gpg-sign=<key-id>' '
  	set_fake_editor &&
 -	FAKE_LINES="edit 1" git rebase -i --gpg-sign=\" HEAD^ >out 2>err &&
 -	grep "$EPIPHANY-S\"$EPIPHANY" err
 +	FAKE_LINES="edit 1" git rebase -i --gpg-sign="\"S I Gner\"" HEAD^ \
 +		>out 2>err &&
 +	grep "$SQ-S\"S I Gner\"$SQ" err
  '
  
  test_done
 diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
 index 8f53e54..48346f1 100755
 --- a/t/t3415-rebase-autosquash.sh
 +++ b/t/t3415-rebase-autosquash.sh
 @@ -271,4 +271,37 @@ test_expect_success 'autosquash with custom inst format' '
  	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
  '
  
 +set_backup_editor () {
 +	write_script backup-editor.sh <<-\EOF
 +	cp "$1" .git/backup-"$(basename "$1")"
 +	EOF
 +	test_set_editor "$PWD/backup-editor.sh"
 +}
 +
 +test_expect_failure 'autosquash with multiple empty patches' '
 +	test_tick &&
 +	git commit --allow-empty -m "empty" &&
 +	test_tick &&
 +	git commit --allow-empty -m "empty2" &&
 +	test_tick &&
 +	>fixup &&
 +	git add fixup &&
 +	git commit --fixup HEAD^^ &&
 +	(
 +		set_backup_editor &&
 +		GIT_USE_REBASE_HELPER=false \
 +		git rebase -i --force-rebase --autosquash HEAD~4 &&
 +		grep empty2 .git/backup-git-rebase-todo
 +	)
 +'
 +
 +test_expect_success 'extra spaces after fixup!' '
 +	base=$(git rev-parse HEAD) &&
 +	test_commit to-fixup &&
 +	git commit --allow-empty -m "fixup!  to-fixup" &&
 +	git rebase -i --autosquash --keep-empty HEAD~2 &&
 +	parent=$(git rev-parse HEAD^) &&
 +	test $base = $parent
 +'
 +
  test_done

-- 
2.9.0.278.g1caae67

base-commit: 5c589a73de4394ad125a4effac227b3aec856fa1
