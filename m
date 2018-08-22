Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D1F1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 21:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeHWAl1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 20:41:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:57995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbeHWAl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 20:41:27 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mg3Vt-1fV8IS0wMP-00NRMz; Wed, 22
 Aug 2018 23:14:45 +0200
Date:   Wed, 22 Aug 2018 23:14:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [GSoC][PATCH v6 18/20] rebase--interactive2: rewrite the submodes
 of interactive rebase in C
In-Reply-To: <20180810165147.4779-19-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808222310220.73@tvgsbejvaqbjf.bet>
References: <20180731180003.5421-1-alban.gruin@gmail.com> <20180810165147.4779-1-alban.gruin@gmail.com> <20180810165147.4779-19-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PwajD9AoDgEHLtLV96CHTkRwtMAU12+mFt7zQz7ccC2JTaXbWZb
 AYJHeCFX+8/hNoxI9hGoczadwKfeps9SBRDgdGZGeD5G3Fu76qAgcp2EzNmwRplwAZLiZj5
 n4zSd2PIMT7Kto9I/jRsIcA0sATjl9AHZgIF8hdWVg0/aS2XoTtOuA85OwBmcktqHvzybqw
 28s6BSgvHZ0d9SVVloLXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EQKYiVp+C+k=:gxZfs4N62AXiXvIcgiuiMx
 Ud4ZxDg0LvixaHGtgW56rG4lEdZHfCa9pxjkOKbOi/BHG8l+36EK/HQNnjIrnQvakQ3xEi2qZ
 b/jrVjSyGS0vNGsIFkRFAzXqxGBOxG98lh0iqgJJe+jdeiI6MzDJutSQG6B51hzMBlWBdVeMY
 Gq3mDnkp3RZiTAnNFqkQIwQxmy+5n/jcdTKYfXojqvbS/xcKg/NkBrSTUE4G2zrv/GNX1PI1B
 t4CptqyHgD1fUkC45AyA+apIYVy44waPD7an+TYCGiK5x0/m8mDskOQrmD3MGfj8N+dfGEURp
 DTxnXiMRB9sLZxEuAdWJDPbZ7I/jlnSj6S/T8ZFMBvE9tlTvuqFNvlkop1hGM8ONrbr/bdbZa
 5emSrYUq2Aj1PeIi9FIMF31aVFBIlnLFSH6HszV6gBacyS1MxwAfJriyPSC3VhyjxGWZQ53x9
 f8rkT3fg8X3GCRkLSti09avMh4yrHvc+R4ZTU/F/rDkxo4ZKsQwoo1oSGeWNECwTgAxaojtAF
 Xu4+T5Ez4c3jkXgeNfEWXyfr/0as8nr0+MMP2sw9pqBEwH1Mm5Al6JcN+KAvA/ny7F1+bbYbt
 VA2wlgScX2/XXr+ioIW++kIWvUQBvOSDgCZ6o2YQ6ff28lV2cdue/5K0aqj5wMuXI3wSDETBe
 zSvRx+9v7fvpk2OQqyTKQW51fjPiTYQgIf1BQWuS2w1WP62RkMTs1yWc1FPvZAXj9NGlYD81J
 4o+8vwKjqMCg00dKQWX8V5S6mhCl5F6uPh5cCNSNHWteUyu0dc7BWZwjQa7vVrHI5O1PyaxDE
 neqApG3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

thank you for your tireless work on this!

One thing that needs to be fixed, though:

On Fri, 10 Aug 2018, Alban Gruin wrote:

> +run_interactive () {
> +	GIT_CHERRY_PICK_HELP="$resolvemsg"
> +	export GIT_CHERRY_PICK_HELP
> +
> +	test -n "$keep_empty" && keep_empty="--keep-empty"
> +	test -n "$rebase_merges" && rebase_merges="--rebase-merges"
> +	test -n "$rebase_cousins" && rebase_cousins="--rebase-cousins"
> +	test -n "$autosquash" && autosquash="--autosquash"
> +	test -n "$verbose" && verbose="--verbose"
> +	test -n "$force_rebase" && force_rebase="--no-ff"
> +	test -n "$restrict_revisions" && \
> +		restrict_revisions="--restrict-revisions=^$restrict_revisions"

I made this same mistake over and over again, myself. For some reason,
John Keeping decided to use the singular form "revision" in 1e0dacdbdb75
(rebase: omit patch-identical commits with --fork-point, 2014-07-16), not
the plural.

So you will need to squash this in:

-- snipsnap --
diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index fb0395af5b1..7600765f541 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -145,8 +145,8 @@ run_interactive () {
 	test -n "$autosquash" && autosquash="--autosquash"
 	test -n "$verbose" && verbose="--verbose"
 	test -n "$force_rebase" && force_rebase="--no-ff"
-	test -n "$restrict_revisions" && \
-		restrict_revisions="--restrict-revisions=^$restrict_revisions"
+	test -n "$restrict_revision" && \
+		restrict_revision="--restrict-revision=^$restrict_revision"
 	test -n "$upstream" && upstream="--upstream=$upstream"
 	test -n "$onto" && onto="--onto=$onto"
 	test -n "$squash_onto" && squash_onto="--squash-onto=$squash_onto"
