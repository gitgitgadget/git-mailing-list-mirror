Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FF1C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 12:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbiHOMZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbiHOMZt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 08:25:49 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2862E1903C
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 05:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660566345;
        bh=jXbELNQo50Zpzni+E8eGBkMBDg1xslNd8v09WMXrUFE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SQPDVTiXP9yUannczZxSspgQUrXYxmoiIHj+KOKpNFz5fSlHUJJ/oLMs816hxepOn
         iWEkQb1vYw0T+Mk4B5Mu6g9xBTfRpNy71GxxBx1C2kN9TSNM8PVM4VvbhdLsyi5k0X
         +KodC2fTTvOkBqme5P6N73uUY31wZSfZjMDg9DBc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KUd-1nHn6H3TEv-016iXv; Mon, 15
 Aug 2022 14:25:44 +0200
Date:   Mon, 15 Aug 2022 14:25:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     demerphq <demerphq@gmail.com>
cc:     Git <git@vger.kernel.org>
Subject: Re: "bubbling up" patches in a commit sequence.
In-Reply-To: <CANgJU+VYSuEkU+V0WRpsTPv9iPYeDo52MeMHuD7-Yp4JnA60NA@mail.gmail.com>
Message-ID: <7o9n6751-2083-155s-02op-o5635o4qr278@tzk.qr>
References: <CANgJU+VYSuEkU+V0WRpsTPv9iPYeDo52MeMHuD7-Yp4JnA60NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mCZcR5ceLu+sx7dMXtOA2Wh2hrZ2JYdTN6eZpQNjBj7FzPLYBFr
 gJBaVaqEmvif3ETOeCEgYF9rK301z/SWUjquk999upolNsY7i2eKMU/aEV4NgQrUK8S147f
 8XMCnxZL79qIsyc7m+eKwXE0YkuTGiv3WE6eK9YhG+8jG0KwRxVfIly+yhIix6i5ob8Gm5s
 EMculRq9Og6alC7mS7BGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zXLk0ru73oU=:eFkPPFsv/UBznzgEPw76WI
 LZ2S8wWYLox6qfDdWPA5KaMpVvA6eK4O3MwO5uyuKdYcFgXULuy6BWaNz7vrrFSWMKnpGhv0p
 bLo/ulti/eLqdEuqpeUVTd2Rz2jyQhOjvCzfsndC6Dy4mHE9MqhA4g99vXImb0XHHuD2XjZgy
 ZDToB+feUPaE/uBYzTv15vay4/5RjqHnCbf+GG8JJHmO2qHffKKnWXaM9tGYq60tKVEmYiIlv
 I7mdNSJpAVRiXMaPen9rSkt6pESZo54SJY5eV8qQZ/L7CatMFaf7RHTbEUOga4i194C7tPX6h
 d0rDoGVXvMK6ivIZ3r+2F1ihLFC6EqErfPPX/l3anhZj246BkDTGY03bShoSi2hkn7osE64AD
 uYKzNWrh3IoOZv0UHmHgN5uUvi6tLs9NDcBRb2EtbciYCFOBgS6w5j9uOkldGFaHSHKtPa98B
 0ZyoB5xRK/50La0iQ5yFxgNTf66E/BwZNHjAd2sOCgG35TRIi8w3h0iU3BDcIu6kdtyyGky19
 kkrleNlkwCa0uoRIMQRTUZ6pNV+PzzQbk6sm/MlF7jKqonijZUQAHskN9eBPC3YNFChdNnk0D
 93a76mfqjph3jdhaVr4vtZzyvU08HMYwLPZ0ApnS9WQGwLRmKIye+0p47jiz27REj0shfx6F/
 WInDBLAp2SWd+MZWvsq0LMaOSt/ZYPaaLA6jK0ccN+Q1JhAOTmov2HJjam5Ci82GbFIBK9eT5
 awEm+x9fLs2Jme3PZPLMrQh6kQ5pPmAEqFuKy55jH+OJikXbMhS8br4RO2xqmv7gGzuxOWjfm
 agodBWEic2qtQdT9ONVTgkPNxX9pCSAVXrlkKmF5MsdjM0IoRAe3k6ZD16/6riTBpwHdAfh0f
 L4y31VOlakW57YtIHiTm326jRVKzcU6OD8izSEeXUpGJ5EaeKyawGENA6oVW2prRerIi5r40O
 eNuetFqDFxrprVCS8+E5+7IZbNlFWMLC5M/2XkXx0H3ae7rL6DSJNG3Xz6sjl/XZwBS2c0t8L
 9jWQMOQK41htdPI87XL8Tiy4vCNcLp7w4+LpyRbD6Ue+hxXJ0c3N7BsZ3r2+vuvQ380/vdQE5
 fT3zk7EUcvPY3PHW0GgiLQ6o7kIU2dsuLZy11+nVOYDDmLQPaS3jirWLQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yves,

On Sat, 13 Aug 2022, demerphq wrote:

> I keep finding myself using interactive rebase to try to find the
> earliest place in a change sequence that a given commit can be placed
> without conflicting with any other patch.

I find myself doing that a lot, too. So much so that I wrote shell code to
do that for me. The essential idea is to use the diff hunk header of the
hunk that I want to stage and transmogrify it into the `-L
<start>,<end>:<path>` parameter of `git log` (and yes, the `sed` call to
transmogrify that is a bit hard to read).

The relevant part of the code looks like this:

-- snip --
sh_quote () {
	for arg
	do
		echo "'$(echo "$arg" | sed "s/'/'\\''/g")'"
	done
}

staged_log () { # [--upstream=<ref> | -u <ref>]
	upstream=not\ set
	while case "$1" in
	--upstream) shift; upstream="$1";;
	--upstream=*) upstream="${1#*=}";;
	-u) shift; upstream="$1";;
	-*) die "Unknown option: $1";;
	*) break;;
	esac; do shift; done

	test not\ set != "$upstream" ||
	upstream="$(git rev-parse @{upstream} 2>/dev/null)"

	# look beyond upstream if identical to HEAD
	test -z "$upstream" || test 0 != $(git rev-list --count $upstream..) || upstream=
	diff="$(git diff --cached -U1)"
	cached_diff="$diff"
	test -n "$diff" ||
	diff="$(git diff -U1)"
	test -n "$diff" ||
	die "No changes"

	args="$(echo "$diff" |
		sed -ne '/^--- a\//{s/^-* a\/\(.*\)/'\''\1'\''/;x}' -e \
			'/^@@ -/{s/^@@ -\([^, ]*\),\([^ ]*\).*/-L \1,+\2/;s/^@@ -\([^,]*\) .*/-L \1,+1/;G;s/\n/:/g;p}' |
			tr '\n' ' ') ${upstream:+$upstream..} $(sh_quote "$@")"

	eval "git log $args"

	revs="$(eval "git log --pretty=%H --no-patch $args")"
	case "$revs" in
	*[!0-9a-z]*) ;; # multiple revs
	'')
		# not a single rev
		test -z "$upstream" ||
		staged_log -u ''
		;;
	?*)
		printf "Commit (yes/no/edit)? "
		read line
		case "$line" in
		[Yy]*) git commit --fixup "$revs" $(test -n "$cached_diff" || echo "-a");;
		[Ee]*) git commit --fixup "$revs" $(test -n "$cached_diff" || echo "-a") -se;;
		esac
		;;
	esac
}
-- snap --

Unfortunately, the `-L <...>` code currently works reliably only for a
single hunk, if I use multiple hunks, I sometimes run into assertions.

To help with that, the shell code looks at the staged hunk(s), if any.
Only if no changes are staged, it falls back to the unstaged diff.

Ciao,
Dscho
