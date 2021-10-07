Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1508C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8588660E9B
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242466AbhJGUdD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:33:03 -0400
Received: from mout.web.de ([212.227.15.4]:41557 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242444AbhJGUdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633638662;
        bh=WtfnCv1KZIYdkaFlgL0daUuQ3VdoWyCJIttjCI3WNgY=;
        h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
        b=q5tuFAjhXYoPM/9s14tmIW5zH+PfZ3mCuy9b4rSrsSoLRD9zzSkP6MH4E5Q7IvaNX
         XmncRDZ6I6RHUEAYuGvmRqcJV7+TXi4hbOQVj32ZBaY03/0i3InosGS7uFDJAatMdO
         FmD7dE93drkeY5jxkV3CHkFxpjI2MdDkVPajejQE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MAdb9-1meNkE3oQl-00Bqiu; Thu, 07 Oct 2021 22:31:01 +0200
Subject: [PATCH 1/3] t3905: show failure to ignore sub-repo
To:     git@vger.kernel.org
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Robert Leftwich <robert@gitpod.io>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <079598e4-47fa-671e-0d1d-cf82039d861f@web.de>
Date:   Thu, 7 Oct 2021 22:31:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AoMAhMXYM4I176PFMkxyqof+zaTwGPHUu5RV2BldGEXPg7Sq6X7
 0rVs/UxFQ63lIw1V6pCgeDOOgFfjAT2T4Ze8I9LB8Oa+qfuscnk01zC3d04ViaWP6WOTAmx
 AfHA0roXT8Np6edmvpXOx4OQArvYrMTq5Ts/Jd8U/xA8C3DV5u3Oh2Ll4NQt6QS49jmYOYT
 cHZgLN+RMVTNuMVv6Vc9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5OrCNLV+K9Y=:rM09cCmjoy2o5VPxiQylKg
 ufgVwOps/rV9/EgDf1LPrq1rxCEDbiDSYQK8dyM1K8uCfMx0dbuewx8ybFFVrKcM4XxTY21xN
 kBRXGPWfFmv5xwETk5cUaaOzoCZ5yBeA40Usll1+VU5FoW7FdB8Aw2K9d924NP46Qnu+OQNf0
 dCOH9JGAbbon97UL8i3Gc5JOlkMfsWptit3IQWxDxG5LXas6rDBCwFzIHKt5fCoRASMybZWgn
 2VMnFJkpMelsgziOPaxMcxoTNz4uGjfe9r5VcRcUMv9GF39vbivjXa6Q6mKI4ziGEfR2c0YrV
 lJHkJ3pKFh+MkLIzProYTbovOgogkzPN5WeGQew/FsQH9XPrBBo0xeryhZP2KCLGjc+yhUWcT
 WnZ8haxIc6LBUaDx7KoSOD8S6wuZqQL6pHsOWGp1RUy6iKdZkRXNgaEfHs6QeSsp9pG6eZHq6
 ylFrSj8x4oke/WVeZmKUDs1qOk6DpVuaPxEg+iQSMx6nOf9lT9Ht3lg18WB9yt/plUCWRE4Tp
 cZ8R7YjYBDIrVNdON0aybkVLVU04g1/F6hWS1TDYY3g0hnThFOH1AE+eXjk8VLfIGa6lrIOuT
 ZKKZYep42FtZ1WGT1WAT6W3Rfixsu/HPOuYGNKO9cYr5QWZFZfwyVrJUHXjXsSRjGSJHoJkRD
 AeCgVq74Pq3kBCtjHH3tIIGbg4X8GKksk2hj6QuK4CEgqmNAr7zGDvF+cjAzUNhL0pgY8mMLJ
 c88f+e3OK9C6+zYmhwXZQ8wDRt5xRF2Mjiuxup5ewKzz2c2p61HIanE5nxy5SlO5HPu/D/pXK
 oPN1z+786LW24UtcJTXzKss4Q0+qYDH721m+WX0MqUEeMM7w2ZK+bSFAmXU6OyiFJRUcJk723
 Uww9/dTnzCcc+sU67Ph4QX1VhZI6togPDwUUyJsTF4nHMa6Dnl78BJtMVogqtqFurzByOVr7R
 fP5XEYK7i41jiGUKerxyajMHvqcwpnDv9tZfd/2zKe5EA85gYDeeahPex20brfGELqbgdgn1k
 dNB+mGMbGFe9KsAr8plZLAWdErONrM6pl71eE4wMHzcWQ8SYP0Vb7hdINDXGCxxNBg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git stash" used to ignore sub-repositories until 6e773527b6
(sparse-index: convert from full to sparse, 2021-03-30).  Add a test
that demonstrates this regression.

Reported-by: Robert Leftwich <robert@gitpod.io>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t3905-stash-include-untracked.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-un=
tracked.sh
index dd2cdcc114..19da46b7fb 100755
=2D-- a/t/t3905-stash-include-untracked.sh
+++ b/t/t3905-stash-include-untracked.sh
@@ -422,4 +422,10 @@ test_expect_success 'stash show --{include,only}-untr=
acked on stashes without un
 	test_must_be_empty actual
 '

+test_expect_failure 'stash -u ignores sub-repository' '
+	test_when_finished "rm -rf sub-repo" &&
+	git init sub-repo &&
+	git stash -u
+'
+
 test_done
=2D-
2.33.0
