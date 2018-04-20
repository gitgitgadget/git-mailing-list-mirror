Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72DAE1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 21:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbeDTVHC (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 17:07:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:35665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeDTVHB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 17:07:01 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LorB9-1eTgiZ3E67-00gnli; Fri, 20
 Apr 2018 23:06:56 +0200
Date:   Fri, 20 Apr 2018 23:06:41 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/4] rebase -i: avoid stale "# This is a combination of"
 in commit messages
In-Reply-To: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
Message-ID: <cover.1524258351.git.johannes.schindelin@gmx.de>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3bYiE8vC/aEu5fHFWohVReTCdkv4mttAOGSRRKzGQRp2JKHNfyh
 dh19agZrdjZt+MRjagPCdpmz8G5QPa2v45JkN9JxnBgM3vPc6XvQH42BAHh+vK+b47q4C7l
 nHYYkGZ2XJfxy5GJeaPwxIYrZyz0g5fEBhuytITA8eO3gelRAf7Ik8WjbQTHUApRo4FLFLF
 TKflmBEi+jVy5UUE4Z43g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:unKVRUHNGe4=:ZZvdvPdBi+ukj78UZFwxpx
 Xrrbvd0k0njWh9cYjCbZrXElOuWsYbzY2j+0JRWGKIV8Vqr7R8iY9HSY1lFtHFvRUJUoApDat
 PPugOXU+dDsNvy1fu6pRpgUaE2FoboMklUskrVpdwVO1mlhGBAo+055DF32tQeg4Y9bKj3IAN
 oLY8JzpTLF1BcRg5+C1tK9mZue6m1L1DEWYN6dAr1zVatqtgoctvfU1huixA4RV94KEyrKDWg
 JnuMd32K2W91bribSQW8IdeqQ/6Z+7ZvmriYnx+TjkpHnINSD413YD+7OVwFV5VdyGKTFTmkY
 I20NMOur3ssabXuYDkf1YKQ2Rbf388ye30UO0JWBgzEPJTBpROOSujHIz2hXuKQlBop85tFib
 +lhSNomirEtyER1OGbspe1qL5o5Ss5QViGirsxRzX9bKG4d/FZFTQairBBfyfCvH2wy53NnXP
 eb9ozsTHMqDlk91SJY8FAYlpWgtQknRCvOspayTDTNqWGqImPfrOsB44QOo7vsDWqj13mAV7n
 W6lwVC1Yf+alMJQSxjYH7Dsia//t2yaS8xJXurS2rS0i2cIHx1HkLGjMZxki/SmQ8ahle96v4
 un/RtzaKAf/HOxmuEzUwxO6jyrUO8TR6mZM1+b8v4hsMI5u/bg6WKwUYdiVkO3rQ+qAWwlIyN
 7RvxagODnO8WLohXsoSOfP3jX5xSRcJuCldCm7vd+G/xuxcf/ePji9zZlb71+ec9nZZckSNRq
 8nvEKAysoX0Os05L5Pd+41+r7fOjnr/CthzeZBu7DomZh9EM2zMVspbzjRg53kHp7ddj9BAxU
 JihbOp2rYiTcVWsezBoBtKCKRhCaFI8Qac83NHsWsdo/KPkQzE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine pointed out that I had such a commit message in
https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
and I went on a hunt to figure out how the heck this happened.

Turns out that if there is a fixup/squash chain where the *last* command
fails with merge conflicts, and we either --skip ahead or resolve the
conflict to a clean tree and then --continue, our code does not do a
final cleanup.

Contrary to my initial gut feeling, this bug was not introduced by my
rewrite in C of the core parts of rebase -i, but it looks to me as if
that bug was with us for a very long time (at least the --skip part).

The developer (read: user of rebase -i) in me says that we would want to
fast-track this, but the author of rebase -i in me says that we should
be cautious and cook this in `next` for a while.

Fixes since v1:

- Using test_i18ngrep instead of grep, because "This is a combination of
  <N> commits" is marked for translation.

- Added a patch to actually fix `rebase -i` when building with
  GETTEXT_POISON, because we used to assume that numbers are encoded as
  ASCII so that we can increment it when writing the next commit message
  in the fixup/squash chain. This also seems to be a long-standing bug
  that has been with us since the the beginning of the localization of
  rebase -i's commit messages.

- The test case now starts with test_when_finished "test_might_fail git rebase
  --abort" to be allow for failing more gently.

- Fixed grammar of 2/3 (now 3/4): thanks, Eric!

- Fixed the description of the new test case (it purported to test --continue,
  but it really tests --skip).


Johannes Schindelin (4):
  rebase -i: demonstrate bugs with fixup!/squash! commit messages
  rebase -i: Handle "combination of <n> commits" with GETTEXT_POISON
  sequencer: leave a tell-tale when a fixup/squash failed
  rebase --skip: clean up commit message after a failed fixup/squash

 sequencer.c                | 93 ++++++++++++++++++++++++++++----------
 t/t3418-rebase-continue.sh | 22 +++++++++
 2 files changed, 92 insertions(+), 23 deletions(-)


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/clean-msg-after-fixup-continue-v2
Fetch-It-Via: git fetch https://github.com/dscho/git clean-msg-after-fixup-continue-v2

Interdiff vs v1:
 diff --git a/sequencer.c b/sequencer.c
 index f067b7b24c5..881503a6463 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -1350,19 +1350,18 @@ static int update_squash_messages(enum todo_command command,
  		eol = strchrnul(buf.buf, '\n');
  		if (buf.buf[0] != comment_line_char ||
  		    (p += strcspn(p, "0123456789\n")) == eol)
 -			return error(_("unexpected 1st line of squash message:"
 -				       "\n\n\t%.*s"),
 -				     (int)(eol - buf.buf), buf.buf);
 -		count = strtol(p, NULL, 10);
 -
 -		if (count < 1)
 -			return error(_("invalid 1st line of squash message:\n"
 -				       "\n\t%.*s"),
 -				     (int)(eol - buf.buf), buf.buf);
 +			count = -1;
 +		else
 +			count = strtol(p, NULL, 10);
  
  		strbuf_addf(&header, "%c ", comment_line_char);
 -		strbuf_addf(&header,
 -			    _("This is a combination of %d commits."), ++count);
 +		if (count < 1)
 +			strbuf_addf(&header, _("This is a combination of "
 +					       "several commits."));
 +		else
 +			strbuf_addf(&header,
 +				    _("This is a combination of %d commits."),
 +				    ++count);
  		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
  		strbuf_release(&header);
  	} else {
 @@ -1405,13 +1404,22 @@ static int update_squash_messages(enum todo_command command,
  	if (command == TODO_SQUASH) {
  		unlink(rebase_path_fixup_msg());
  		strbuf_addf(&buf, "\n%c ", comment_line_char);
 -		strbuf_addf(&buf, _("This is the commit message #%d:"), count);
 +		if (count < 2)
 +			strbuf_addf(&buf, _("This is the next commit "
 +					    "message:"));
 +		else
 +			strbuf_addf(&buf, _("This is the commit message #%d:"),
 +				    count);
  		strbuf_addstr(&buf, "\n\n");
  		strbuf_addstr(&buf, body);
  	} else if (command == TODO_FIXUP) {
  		strbuf_addf(&buf, "\n%c ", comment_line_char);
 -		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
 -			    count);
 +		if (count < 2)
 +			strbuf_addf(&buf, _("The next commit message will be "
 +					    "skipped:"));
 +		else
 +			strbuf_addf(&buf, _("The commit message #%d will be "
 +					    "skipped:"), count);
  		strbuf_addstr(&buf, "\n\n");
  		strbuf_add_commented_lines(&buf, body, strlen(body));
  	} else
 diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
 index 4880bff82ff..693f92409ec 100755
 --- a/t/t3418-rebase-continue.sh
 +++ b/t/t3418-rebase-continue.sh
 @@ -88,7 +88,8 @@ test_expect_success 'rebase passes merge strategy options correctly' '
  	git rebase --continue
  '
  
 -test_expect_success '--continue after failed fixup cleans commit message' '
 +test_expect_success '--skip after failed fixup cleans commit message' '
 +	test_when_finished "test_might_fail git rebase --abort" &&
  	git checkout -b with-conflicting-fixup &&
  	test_commit wants-fixup &&
  	test_commit "fixup! wants-fixup" wants-fixup.t 1 wants-fixup-1 &&
 @@ -99,14 +100,14 @@ test_expect_success '--continue after failed fixup cleans commit message' '
  
  	: now there is a conflict, and comments in the commit message &&
  	git show HEAD >out &&
 -	grep "This is a combination of" out &&
 +	test_i18ngrep "This is a combination of" out &&
  
  	: skip and continue &&
  	git rebase --skip &&
  
  	: now the comments in the commit message should have been cleaned up &&
  	git show HEAD >out &&
 -	! grep "This is a combination of" out
 +	test_i18ngrep ! "This is a combination of" out
  '
  
  test_expect_success 'setup rerere database' '
-- 
2.17.0.windows.1.15.gaa56ade3205

