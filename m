Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B65620A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751945AbdASV1Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:27:16 -0500
Received: from mout.gmx.net ([212.227.17.21]:50458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbdASV1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:27:15 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjLwB-1bypGJ08Yp-00dWot; Thu, 19
 Jan 2017 22:20:00 +0100
Date:   Thu, 19 Jan 2017 22:19:58 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] remote rename: demonstrate a bogus "remote exists"
 bug
In-Reply-To: <cover.1484860744.git.johannes.schindelin@gmx.de>
Message-ID: <4e3c94cb58052af1c0021b7e4c96ab4029afb7bb.1484860744.git.johannes.schindelin@gmx.de>
References: <cover.1484687919.git.johannes.schindelin@gmx.de> <cover.1484860744.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6KRftw2Nf2MXuWkxJRPsNbavtyFJTWu5zk8bnybHQqE+C70JD4V
 LWg9iM15UDQN1i8AnTxBBMf9OGuC6KCn3w4DitDG3t3OMraCZCCTk6GDpKz4PTMTFUNDNcW
 V/fxw1FwTtsifqC8P15iIeX6nS3KLUlV7d8HGnISceDVpDpChUbZ+13gF6eGP6x4nQ7AUy5
 C1yZ6oipPB/zV0NqO8D+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xW0CAU4zARM=:FkjHdwfcwlmivcTNlVx6au
 InfQ309PKYCW3vkry/Z+wHPpz+PKxfoGItIhtrNaGU2pVgZQi7bYYnoTswkGFET/gAgkeJId6
 A9R0U3ThsVds69aaRjaoAL0psDwOHmhPlfFB/VIAYE3TzMT+15ydKnbTuvcAQZdLxDtCZrLWN
 SyA6aTaJHYSDTzMH8H9klO+vuLrM5lULios7sH9z1dz8g+lAJTNLeLOYj6kPrc/kEckEKEFBB
 CdIreRj4136SrL4bJBNWl0qf3ZyRm8TVmXB7UNjhOHLIRKRsxIdpfiVwFjwsgbc3soR0h9wh6
 6Kg71POXgTsG/1gthev3o2zNtdCTPibjJ8OMcdbmB+xZMOMwz6+LieBeKzalhxyB2avxAfe5f
 DLnb24hp/fbqKSTW+dOimx9k0PExr5dE08ygd8ulX6JLU/lCZ/ktZ0Q6qrQ/P8zrmYs8nS8np
 ggbNrgaM8mrp5GyDhA/pLpayedHYF91CuvV4n6C/5G8jSPPmcgc9NGnT6kCusAd/vdC+N4ph+
 6hdGE2pzF8zATVeDiY3O6hMAcZvPrtgKCDGgQNFnNbnAj/SnW3bgxPb0kMue1T83sEzF/fkDA
 lPzxmj76ZYJCBxxEQjY894bG6WwxxGcMKPyTRdxZxFwFgHzV+8uOLd3Y8L09VWqGZSuVceV/2
 QTg+O6bqKpItZnrjUUkPNu8nU6JY0Gsp1aMNetITFr0mvnXtWfVTKjAdPCvsIVFjlzgQ5FS0W
 x0tYGz3RPPncElJuePcpgAlyshsschtVSrPtBEJAnUVTN7vScvQ1Le+QjMa/MkdlT1OdLHr7h
 eOm7fCX0ZU1WmzBIqCoxOM/flOpxX1vQ3ucwUJxapqTENh1PkTiQ2rXc5dMTvs6QlGx8aVTew
 1dz7DhhqDe6fVQDh+QD8BL0ouhBcaOgf1q7Ijld7GCUXIHQQIfongutgQjsa8odkmCnWDkYBH
 I0qDJv9l36wigJ8ULRKlGqP8Ym5OuHgJYmX9FH4bsQsWT39qV1xKWtT27z17rx6MpibIKh3XP
 7SrIimbXiIUYt3O4hh4Dms2cStHi1G1Dypaqaf0sQ23fqoxkKGh9JlBoCd3G/SSSNA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users like to set `remote.origin.prune = true` in their ~/.gitconfig
so that all of their repositories use that default.

However, our code is ill-prepared for this, mistaking that single entry to
mean that there is already a remote of the name "origin", even if there is
not.

This patch adds a test case demonstrating this issue.

Reported by Andrew Arnott.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5505-remote.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8198d8eb05..2c03f44c85 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -764,6 +764,13 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 	)
 '
 
+test_expect_failure 'rename succeeds with existing remote.<target>.prune' '
+	git clone one four.four &&
+	test_when_finished git config --global --unset remote.upstream.prune &&
+	git config --global remote.upstream.prune true &&
+	git -C four.four remote rename origin upstream
+'
+
 cat >remotes_origin <<EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
-- 
2.11.0.windows.3


