Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72AD420282
	for <e@80x24.org>; Fri, 23 Jun 2017 17:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbdFWRDy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 13:03:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33754 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbdFWRDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 13:03:52 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so6847400pgb.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=USNB6try4/vGLEaoiZoV+oGXF6K6yAly0AFmnB22zjk=;
        b=dB7HO4mTXJxHCzYZHJj+lfnMZfHMVxkrCO3Vgb4xGuUSg3iZkGfT0r3oSEZLnYQoFS
         i6RLEjU1trhRW9UVaJ6c+88A1Rz+9P4NQMKo34YvdlGRN+h0OA+GW1/7G/9mL8jtupvq
         T1qBVbvN0YxtJzUwWYWy8qTcNHw4oC2f3PPpRwjc4MuRXPrsA5mGABbt9YI5xmjpqloG
         Saw9FOPtnpvwVabITGabscTfVtaPm6c/sQJhVm+iIBhJE1ZUGTMhJL6WdQLZdHTMc1aY
         Fkhcne0Jmzl4l5YbCOY7DUy3BmlGaHtOdDkZFgjK58UXBsPdvoW8u5+dOqpX8mkMhJnH
         p57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=USNB6try4/vGLEaoiZoV+oGXF6K6yAly0AFmnB22zjk=;
        b=CTM3IO/mW5ZKgo9XQ0gC5JfaNxnWBiFkRMiHwq+wQImeHvMtZjwsxS1O3cKUKlbxh+
         ivn+uyVGVea3zHJBeQ7zcWvrhlIcx3Lq+8UEUGB7ozxowZEqlrUPKrkTa5pzkSlLbiqz
         lb51LQLuxSY2ubfa6ngwQaiQ3MDEddSrCxT4YxAPnGzYuBLM4kRBqZnRSi9ZxJOQyqvo
         AqQknsHW96Mm4I1Y/F3s/GmaXudKdM9jlEsmiax3FPGNn2zHHXhHHdmfk/NNsxuTJcyZ
         uaM3guUO6tnSuF85KJ4nGbko0nf1c7/caz8lT6DKNZsjQGLqsZ4gq86O9JhyDhBAQBR4
         lj9Q==
X-Gm-Message-State: AKS2vOxT+nv2X5qYevlx1p0YFCO126IW2Rmf0B9RidcK1bjCz5lIdeNs
        eV830AKVG3AqPx0L+rartw==
X-Received: by 10.98.68.2 with SMTP id r2mr9293460pfa.190.1498237430906;
        Fri, 23 Jun 2017 10:03:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id 24sm11319250pfs.58.2017.06.23.10.03.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 10:03:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
        <20170619175605.27864-1-phillip.wood@talktalk.net>
        <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com>
        <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
        <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net>
Date:   Fri, 23 Jun 2017 10:03:48 -0700
In-Reply-To: <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net> (Phillip
        Wood's message of "Fri, 23 Jun 2017 10:53:37 +0100")
Message-ID: <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> t3404 passes for me,
> $ make GETTEXT_POISON=YesPlease
> $ cd t &&sh t3404-rebase-interactive.sh -i -v
> ...
> # still have 1 known breakage(s)
> # passed all remaining 95 test(s)
> 1..96

Interesting.  The tip of 'pu', which includes this series, does pass
for me, too, but the tip of this topic 7d70e6b9 ("rebase: add more
regression tests for console output", 2017-06-19) tested in
isolation fails, and gives the output at the end of this message.

> Do you want me to submit a fixup patch for t3420 or have you
> got one already?

For 3420, I can wrap the two-liner patch I showed here earlier into
a commit on top of the series.  

3404 needs a similar fix-up for the series to be able to stand on
its own.  Alternatively, at least we need to understand what in 'pu'
makes the result of the merge pass---the symptom indicates that this
topic cannot be merged to a released version without that unknown
other topic in 'pu' merged if we want to keep POISON build passing
the tests.

Thanks.

-- output from 3404 follows --

Initialized empty Git repository in /home/gitster/git/t/trash directory.t3404-rebase-interactive/.git/
expecting success: 
	test_commit A file1 &&
	test_commit B file1 &&
	test_commit C file2 &&
	test_commit D file1 &&
	test_commit E file3 &&
	git checkout -b branch1 A &&
	test_commit F file4 &&
	test_commit G file1 &&
	test_commit H file5 &&
	git checkout -b branch2 F &&
	test_commit I file6 &&
	git checkout -b conflict-branch A &&
	test_commit one conflict &&
	test_commit two conflict &&
	test_commit three conflict &&
	test_commit four conflict &&
	git checkout -b no-conflict-branch A &&
	test_commit J fileJ &&
	test_commit K fileK &&
	test_commit L fileL &&
	test_commit M fileM &&
	git checkout -b no-ff-branch A &&
	test_commit N fileN &&
	test_commit O fileO &&
	test_commit P fileP

[master# GETTEXT POISON # 6e62bf8] A
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file1
[master 313fe96] B
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[master d0f65f2] C
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file2
[master 0547e3f] D
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[master 8f99a4f] E
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file3
# GETTEXT POISON #[branch1 cfefd94] F
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file4
[branch1 83751a6] G
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[branch1 4373208] H
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file5
# GETTEXT POISON #[branch2 615be62] I
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file6
# GETTEXT POISON #[conflict-branch b895952] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 conflict
[conflict-branch 766a798] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[conflict-branch 1eadf03] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[conflict-branch f91a2b3] four
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
# GETTEXT POISON #[no-conflict-branch 808874f] J
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileJ
[no-conflict-branch 265b89e] K
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileK
[no-conflict-branch 6b0f5e6] L
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileL
[no-conflict-branch 3389558] M
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileM
# GETTEXT POISON #[no-ff-branch 53b4423] N
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileN
[no-ff-branch cc47714] O
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileO
[no-ff-branch faef1a5] P
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 fileP
ok 1 - setup

expecting success: 
	git checkout -b emptybranch master &&
	git commit --allow-empty -m "empty" &&
	git rebase --keep-empty -i HEAD~2 &&
	git log --oneline >actual &&
	test_line_count = 6 actual

# GETTEXT POISON #[emptybranch da33401] empty
 Author: A U Thor <author@example.com>
Successfully rebased and updated refs/heads/emptybranch.
ok 2 - rebase --keep-empty

expecting success: 
	git checkout master &&
	(
	set_fake_editor &&
	FAKE_LINES="1 exec_>touch-one
		2 exec_>touch-two exec_false exec_>touch-three
		3 4 exec_>\"touch-file__name_with_spaces\";_>touch-after-semicolon 5" &&
	export FAKE_LINES &&
	test_must_fail git rebase -i A
	) &&
	test_path_is_file touch-one &&
	test_path_is_file touch-two &&
	test_path_is_missing touch-three " (should have stopped before)" &&
	test_cmp_rev C HEAD &&
	git rebase --continue &&
	test_path_is_file touch-three &&
	test_path_is_file "touch-file  name with spaces" &&
	test_path_is_file touch-after-semicolon &&
	test_cmp_rev master HEAD &&
	rm -f touch-*

# GETTEXT POISON #rebase -i script before editing:
pick 313fe96 B
pick d0f65f2 C
pick 0547e3f D
pick 8f99a4f E

rebase -i script after editing:
pick 313fe96 B
exec >touch-one
pick d0f65f2 C
exec >touch-two
exec false
exec >touch-three
pick 0547e3f D
pick 8f99a4f E
exec >"touch-file  name with spaces"; >touch-after-semicolon
Rebasing (2/9)Executing: >touch-one
Rebasing (3/9)Rebasing (4/9)Executing: >touch-two
Rebasing (5/9)Executing: false
warning: # GETTEXT POISON #
Rebasing (6/9)Executing: >touch-three
Rebasing (7/9)Rebasing (8/9)Rebasing (9/9)Executing: >"touch-file  name with spaces"; >touch-after-semicolon
Successfully rebased and updated refs/heads/master.
ok 3 - rebase -i with the exec command

expecting success: 
	git checkout master &&
	mkdir subdir && (cd subdir &&
	set_fake_editor &&
	FAKE_LINES="1 exec_>touch-subdir" \
		git rebase -i HEAD^
	) &&
	test_path_is_file touch-subdir &&
	rm -fr subdir

# GETTEXT POISON #rebase -i script before editing:
pick 8f99a4f E

rebase -i script after editing:
pick 8f99a4f E
exec >touch-subdir
Rebasing (2/2)Executing: >touch-subdir
Successfully rebased and updated refs/heads/master.
ok 4 - rebase -i with the exec command runs from tree root

expecting success: 
	git checkout master &&
	set_fake_editor &&
	test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^ &&
	test_cmp_rev master^ HEAD &&
	git reset --hard &&
	git rebase --continue

# GETTEXT POISON #rebase -i script before editing:
pick 8f99a4f E

rebase -i script after editing:
exec echo foo >file1
pick 8f99a4f E
Rebasing (1/2)Executing: echo foo >file1
error: # GETTEXT POISON #
warning: # GETTEXT POISON #
# GETTEXT POISON # D
Rebasing (2/2)Successfully rebased and updated refs/heads/master.
ok 5 - rebase -i with the exec command checks tree cleanness

expecting success: 
	git checkout master &&
	test_when_finished "git rebase --abort" &&
	set_fake_editor &&
	test_must_fail env FAKE_LINES="exec_this-command-does-not-exist 1" \
	git rebase -i HEAD^ >actual 2>&1 &&
	! grep "Maybe git-rebase is broken" actual

# GETTEXT POISON #ok 6 - rebase -i with exec of inexistent command

expecting success: 
	git checkout branch2 &&
	set_fake_editor &&
	git rebase -i F &&
	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
	test $(git rev-parse I) = $(git rev-parse HEAD)

# GETTEXT POISON #Successfully rebased and updated refs/heads/branch2.
ok 7 - no changes are a nop

expecting success: 
	git checkout -b dead-end &&
	git rm file6 &&
	git commit -m "stop here" &&
	set_fake_editor &&
	git rebase -i F branch2 &&
	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch2" &&
	test $(git rev-parse I) = $(git rev-parse branch2) &&
	test $(git rev-parse I) = $(git rev-parse HEAD)

# GETTEXT POISON #rm 'file6'
[dead-end f814f58] stop here
 Author: A U Thor <author@example.com>
 1 file changed, 1 deletion(-)
 delete mode 100644 file6
Successfully rebased and updated refs/heads/branch2.
ok 8 - test the [branch] option

expecting success: 
	git checkout -b test-onto branch2 &&
	set_fake_editor &&
	git rebase -i --onto branch1 F &&
	test "$(git symbolic-ref -q HEAD)" = "refs/heads/test-onto" &&
	test $(git rev-parse HEAD^) = $(git rev-parse branch1) &&
	test $(git rev-parse I) = $(git rev-parse branch2)

# GETTEXT POISON #Rebasing (1/1)Successfully rebased and updated refs/heads/test-onto.
ok 9 - test --onto <branch>

expecting success: 
	git checkout branch1 &&
	git tag original-branch1 &&
	set_fake_editor &&
	git rebase -i branch2 &&
	test file6 = $(git diff --name-only original-branch1) &&
	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
	test $(git rev-parse I) = $(git rev-parse branch2) &&
	test $(git rev-parse I) = $(git rev-parse HEAD~2)

# GETTEXT POISON #Rebasing (1/2)Rebasing (2/2)Successfully rebased and updated refs/heads/branch1.
ok 10 - rebase on top of a non-conflicting commit

expecting success: 
	test $(git rev-parse branch1@{1}) = $(git rev-parse original-branch1)

ok 11 - reflog for the branch shows state before rebase

expecting success: 
	printf "rebase -i (finish): refs/heads/branch1 onto %s\n" \
		"$(git rev-parse branch2)" >expected &&
	git log -g --pretty=%gs -1 refs/heads/branch1 >actual &&
	test_cmp expected actual

ok 12 - reflog for the branch shows correct finish message

expecting success: 
	set_fake_editor &&
	FAKE_LINES="2 1" git rebase -i HEAD~2 &&
	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
	test G = $(git cat-file commit HEAD | sed -ne \$p)

rebase -i script before editing:
pick ae8f65e G
pick f5f5249 H

rebase -i script after editing:
pick f5f5249 H
pick ae8f65e G
Rebasing (1/2)Rebasing (2/2)Successfully rebased and updated refs/heads/branch1.
ok 13 - exchange two commits

expecting success: 
	git tag new-branch1 &&
	set_fake_editor &&
	test_must_fail git rebase -i master &&
	test "$(git rev-parse HEAD~3)" = "$(git rev-parse master)" &&
	test_cmp expect .git/rebase-merge/patch &&
	test_cmp expect2 file1 &&
	test "$(git diff --name-status |
		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)

Rebasing (1/4)Rebasing (2/4)Rebasing (3/4)Rebasing (4/4)error: # GETTEXT POISON #

# GETTEXT POISON #

Could not apply 5d18e54... G
# GETTEXT POISON #
# GETTEXT POISON #
ok 14 - stop on conflicting pick

expecting success: 
	git rebase --abort &&
	test $(git rev-parse new-branch1) = $(git rev-parse HEAD) &&
	test "$(git symbolic-ref -q HEAD)" = "refs/heads/branch1" &&
	test_path_is_missing .git/rebase-merge

ok 15 - abort

expecting success: 
	git rm --cached file1 &&
	git commit -m "remove file in base" &&
	set_fake_editor &&
	test_must_fail git rebase -i master > output 2>&1 &&
	test_i18ngrep "The following untracked working tree files would be overwritten by checkout:" \
		output &&
	test_i18ngrep "file1" output &&
	test_path_is_missing .git/rebase-merge &&
	git reset --hard HEAD^

rm 'file1'
[branch1 2dd5570] remove file in base
 Author: A U Thor <author@example.com>
 1 file changed, 1 deletion(-)
 delete mode 100644 file1
# GETTEXT POISON # G
ok 16 - abort with error when new base cannot be checked out

expecting success: 
	echo A > file7 &&
	git add file7 &&
	test_tick &&
	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
	git tag twerp &&
	set_fake_editor &&
	git rebase -i --onto master HEAD^ &&
	git show HEAD | grep "^Author: Twerp Snog"

[branch1 2596307] different author
 Author: Twerp Snog <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file7
Rebasing (1/1)Successfully rebased and updated refs/heads/branch1.
Author: Twerp Snog <author@example.com>
ok 17 - retain authorship

expecting success: 
	git reset --hard twerp &&
	test_commit a conflict a conflict-a &&
	git reset --hard twerp &&
	GIT_AUTHOR_NAME=AttributeMe \
	test_commit b conflict b conflict-b &&
	set_fake_editor &&
	test_must_fail git rebase -i conflict-a &&
	echo resolved >conflict &&
	git add conflict &&
	git rebase --continue &&
	test $(git rev-parse conflict-a^0) = $(git rev-parse HEAD^) &&
	git show >out &&
	grep AttributeMe out

# GETTEXT POISON # different author
[branch1 748a43d] a
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 conflict
# GETTEXT POISON # different author
[branch1 34d1a6c] b
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 conflict
Rebasing (1/1)error: # GETTEXT POISON #

# GETTEXT POISON #

Could not apply 34d1a6c... b
# GETTEXT POISON #
# GETTEXT POISON #
[# GETTEXT POISON # 7866b12] b
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
Successfully rebased and updated refs/heads/branch1.
Author: AttributeMe <author@example.com>
ok 18 - retain authorship w/ conflicts

expecting success: 
	git reset --hard twerp &&
	echo B > file7 &&
	test_tick &&
	GIT_AUTHOR_NAME="Nitfol" git commit -m "nitfol" file7 &&
	echo "******************************" &&
	set_fake_editor &&
	FAKE_LINES="1 squash 2" EXPECT_HEADER_COUNT=2 \
		git rebase -i --onto master HEAD~2 &&
	test B = $(cat file7) &&
	test $(git rev-parse HEAD^) = $(git rev-parse master)

# GETTEXT POISON # different author
[branch1 cdf577a] nitfol
 Author: Nitfol <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
******************************
rebase -i script before editing:
pick 2596307 different author
pick cdf577a nitfol

rebase -i script after editing:
pick 2596307 different author
squash cdf577a nitfol
Rebasing (1/2)Rebasing (2/2)[# GETTEXT POISON # d2d5ba7] different author
 Author: Twerp Snog <author@example.com>
 Date: Thu Apr 7 15:33:13 2005 -0700
 1 file changed, 1 insertion(+)
 create mode 100644 file7
Successfully rebased and updated refs/heads/branch1.
ok 19 - squash

expecting success: 
	git show HEAD | grep "^Author: Twerp Snog"

Author: Twerp Snog <author@example.com>
ok 20 - retain authorship when squashing

expecting success: 
	HEAD=$(git rev-parse HEAD) &&
	set_fake_editor &&
	git rebase -i -p HEAD^ &&
	git update-index --refresh &&
	git diff-files --quiet &&
	git diff-index --quiet --cached HEAD -- &&
	test $HEAD = $(git rev-parse HEAD)

# GETTEXT POISON ## GETTEXT POISON #
ok 21 - -p handles "no changes" gracefully

checking known breakage: 
	git checkout H &&
	set_fake_editor &&
	FAKE_LINES="2 1" git rebase -i -p HEAD~2 &&
	test H = $(git cat-file commit HEAD^ | sed -ne \$p) &&
	test G = $(git cat-file commit HEAD | sed -ne \$p)

# GETTEXT POISON ## GETTEXT POISON # 4373208... H
rebase -i script before editing:
pick 83751a6 G
pick 4373208 H

rebase -i script after editing:
pick 4373208 H
pick 83751a6 G
# GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON #
not ok 22 - exchange two commits with -p # TODO known breakage

expecting success: 
	git checkout -b to-be-preserved master^ &&
	: > unrelated-file &&
	git add unrelated-file &&
	test_tick &&
	git commit -m "unrelated" &&
	git checkout -b another-branch master &&
	echo B > file1 &&
	test_tick &&
	git commit -m J file1 &&
	test_tick &&
	git merge to-be-preserved &&
	echo C > file1 &&
	test_tick &&
	git commit -m K file1 &&
	echo D > file1 &&
	test_tick &&
	git commit -m L1 file1 &&
	git checkout HEAD^ &&
	echo 1 > unrelated-file &&
	test_tick &&
	git commit -m L2 unrelated-file &&
	test_tick &&
	git merge another-branch &&
	echo E > file1 &&
	test_tick &&
	git commit -m M file1 &&
	git checkout -b to-be-rebased &&
	test_tick &&
	set_fake_editor &&
	git rebase -i -p --onto branch1 master &&
	git update-index --refresh &&
	git diff-files --quiet &&
	git diff-index --quiet --cached HEAD -- &&
	test $(git rev-parse HEAD~6) = $(git rev-parse branch1) &&
	test $(git rev-parse HEAD~4^2) = $(git rev-parse to-be-preserved) &&
	test $(git rev-parse HEAD^^2^) = $(git rev-parse HEAD^^^) &&
	test $(git show HEAD~5:file1) = B &&
	test $(git show HEAD~3:file1) = C &&
	test $(git show HEAD:file1) = E &&
	test $(git show HEAD:unrelated-file) = 1

# GETTEXT POISON # 83751a6... G
# GETTEXT POISON #[to-be-preserved 4b3f608] unrelated
 Author: AttributeMe <author@example.com>
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 unrelated-file
# GETTEXT POISON #[another-branch 8e3f1bd] J
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
# GETTEXT POISON #
8e3f1bd J
virtual to-be-preserved
# GETTEXT POISON #
0547e3f D
Merge made by the 'recursive' strategy.
 unrelated-file | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 unrelated-file
[another-branch 0f839ac] K
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
[another-branch 916bd1f] L1
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
# GETTEXT POISON ## GETTEXT POISON # 0f839ac... K
[# GETTEXT POISON # 8fa3ce5] L2
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+)
# GETTEXT POISON #
8fa3ce5 L2
virtual another-branch
# GETTEXT POISON #
0f839ac K
Merge made by the 'recursive' strategy.
 file1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
[# GETTEXT POISON # e12d8fb] M
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
# GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON #
ok 23 - preserve merges with -p

expecting success: 
	set_fake_editor &&
	FAKE_LINES="1 2 edit 3 4" git rebase -i -p HEAD~3 &&
	echo 2 > unrelated-file &&
	test_tick &&
	git commit -m L2-modified --amend unrelated-file &&
	git rebase --continue &&
	git update-index --refresh &&
	git diff-files --quiet &&
	git diff-index --quiet --cached HEAD -- &&
	test $(git show HEAD:unrelated-file) = 2

rebase -i script before editing:
pick 60cb1bd L2
pick f2d0f15 L1
pick 8b9d7f7 Merge branch 'another-branch' into HEAD
pick ecf20bb M

rebase -i script after editing:
pick 60cb1bd L2
pick f2d0f15 L1
edit 8b9d7f7 Merge branch 'another-branch' into HEAD
pick ecf20bb M
# GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON ## GETTEXT POISON #
# GETTEXT POISON #

[# GETTEXT POISON # 82f9bab] L2-modified
 Author: AttributeMe <author@example.com>
 Date: Thu Apr 7 15:43:13 2005 -0700
# GETTEXT POISON ## GETTEXT POISON #
ok 24 - edit ancestor with -p

expecting success: 
	test_tick &&
	set_fake_editor &&
	test_must_fail git rebase -i --onto new-branch1 HEAD^ &&
	echo resolved > file1 &&
	git add file1 &&
	FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue &&
	test $(git rev-parse HEAD^) = $(git rev-parse new-branch1) &&
	git show HEAD | grep chouette

Rebasing (1/1)error: # GETTEXT POISON #

# GETTEXT POISON #

Could not apply 23e2f4c... M
# GETTEXT POISON #
# GETTEXT POISON #
[# GETTEXT POISON # be87a39] chouette!
 Author: AttributeMe <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
Successfully rebased and updated refs/heads/to-be-rebased.
    chouette!
ok 25 - --continue tries to commit

expecting success: 
	git reset --hard master@{1} &&
	test_tick &&
	set_fake_editor &&
	test_must_fail git rebase -v -i --onto new-branch1 HEAD^ &&
	echo resolved > file1 &&
	git add file1 &&
	git rebase --continue > output &&
	grep "^ file1 | 2 +-$" output

# GETTEXT POISON # D
# GETTEXT POISON #
 file1 | 2 +-
 file4 | 1 +
 file5 | 1 +
 file6 | 1 +
 4 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 file4
 create mode 100644 file5
 create mode 100644 file6
# GETTEXT POISON ## GETTEXT POISON # 5d18e54... G
Rebasing (1/1)
error: # GETTEXT POISON #

# GETTEXT POISON #

Could not apply 0547e3f... D
# GETTEXT POISON #
# GETTEXT POISON #
Successfully rebased and updated refs/heads/to-be-rebased.
 file1 | 2 +-
ok 26 - verbose flag is heeded, even after --continue

expecting success: 
	base=$(git rev-parse HEAD~4) &&
	set_fake_editor &&
	FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 squash 2 squash 3 squash 4" \
		EXPECT_HEADER_COUNT=4 \
		git rebase -i $base &&
	test $base = $(git rev-parse HEAD^) &&
	test 1 = $(git show | grep ONCE | wc -l)

rebase -i script before editing:
pick 615be62 I
pick 0626e8d H
pick 5d18e54 G
pick 2e6badc D

rebase -i script after editing:
pick 615be62 I
squash 0626e8d H
squash 5d18e54 G
squash 2e6badc D
Rebasing (2/4)Rebasing (3/4)error: # GETTEXT POISON #
Could not apply 5d18e54... G
not ok 27 - multi-squash only fires up editor once
#	
#		base=$(git rev-parse HEAD~4) &&
#		set_fake_editor &&
#		FAKE_COMMIT_AMEND="ONCE" FAKE_LINES="1 squash 2 squash 3 squash 4" \
#			EXPECT_HEADER_COUNT=4 \
#			git rebase -i $base &&
#		test $base = $(git rev-parse HEAD^) &&
#		test 1 = $(git show | grep ONCE | wc -l)
#	
