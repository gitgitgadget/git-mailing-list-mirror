Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 826011F790
	for <e@80x24.org>; Tue,  2 May 2017 12:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbdEBMam (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:30:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:65047 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdEBMak (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:30:40 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lh7PL-1dtwFx2fH5-00oSfD; Tue, 02
 May 2017 14:30:34 +0200
Date:   Tue, 2 May 2017 14:30:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] completion: mark bash script as LF-only
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
Message-ID: <56201ef047812b6ff1746e54a643f65710d49bf0.1493728172.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QgtVWIsNe8bYUqq0UlPJ1hQrebs9+plEakUVkTRnxONH3TF5yUT
 F6Me6RNbmVt8LduOtPQOg1VJSX3+iMCwuPHTBOMOjUkF8M4KCc4VQqgdUZ0jJGjxgOM264i
 GBZ+8ruQ63olv+pxAi1Pmtn2bPUOI3Yv79wkslWmt0apJ5khwqW4PnW8utjMKmYGp0pT/9S
 He+ITUXxBaJNfDy+cO3LA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iuxZY34iA/E=:rhiXEMkOpAcnrS6R3o4he3
 cGz6RFwOjGhl1xVkkOj7bT0ugiS8hmFqd5T/mdmjuFirdVkH46WMC8Qfk9d6UWKSjM7ndTYH3
 /Ez1X+s7TRz2g50CsUnSyv9KV4LGfRlEfBJtuUzJ5wuHbudeyx+sItxJRaMX5+0p1i6XxUKsk
 RTJ4rPu+KK14Ccn2V6pyxyPoNi0aSzFat5F0P0/atzOmBiIOr+0n7W3pZJ72Gy6EvjRQSF7K3
 suDm78IH56koSFK9t0UbNeAh24RpAfUYuIs5iJTbEZu33GE1hh8SvBz1JbgYaXgfdrQWFH3FK
 d53xoRQnnuig1u2Di4pXeE/1ZfniGdJPDcdzAGxA7sLI15034PFEuVOll+sVDAMbG20JpcQHU
 jNMHaKeiYapHpsRN4nVvHngtSl9l0x7Fm7/aGIA56tLM8KHwqZgcncia5hfURuM8W0Tg0TYUf
 n5swqZR1wcOYt/uFBiQ+dTGDS9I33xR3oKtVY/bFaKpWJuF5mudW8MV7rmq9mAwLpVpccQC30
 fpS8E0GgMNEe5SEPbL1JmXRgNfhhNeX1UBx4uXr+FBOP8du6FfXlN7ofqoT/sEe7Lx+JuzSUd
 ktfdEKuxh7JXnxQ7sjmA+9rkRqdyaYBN16VNqL8IfZHptNHshwa3TUHzXF8XT/LXJpQivlnfH
 I94+J6i7/8slqAoQMGnIb2fdWqA0Efaf+NtAgUiY02wUj2K3CAlf9xr2HLhlC7VL8NpRcnGbr
 m6Wo2n4YyghY85lWQTILEpfQd1A4qOz4EoR5cHqTHNzdU+a2nGFoM+O4qXkEHo6QTYR597xLe
 +SEMfL9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Without this change, the completion script does not work, as Bash expects
its scripts to have line feeds as end-of-line markers (this is
particularly prominent in quoted multi-line strings, where carriage
returns would slip into the strings as verbatim characters otherwise).

This change is required to let t9902-completion pass when Git's source
code is checked out with `core.autocrlf = true`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/completion/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 contrib/completion/.gitattributes

diff --git a/contrib/completion/.gitattributes b/contrib/completion/.gitattributes
new file mode 100644
index 00000000000..19116944c15
--- /dev/null
+++ b/contrib/completion/.gitattributes
@@ -0,0 +1 @@
+*.bash eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


