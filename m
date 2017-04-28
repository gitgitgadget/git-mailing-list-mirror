Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF56D207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 21:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166128AbdD1Vbr (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 17:31:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:64726 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165216AbdD1Vbq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 17:31:46 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LsUDg-1e5uwv2sLA-0121bu; Fri, 28
 Apr 2017 23:31:33 +0200
Date:   Fri, 28 Apr 2017 23:31:30 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 01/10] t3415: verify that an empty instructionFormat is
 handled as before
In-Reply-To: <cover.1493414945.git.johannes.schindelin@gmx.de>
Message-ID: <210c26f91c8dc8a4bd05fda2c46eb0c28bfb2da6.1493414945.git.johannes.schindelin@gmx.de>
References: <cover.1493207864.git.johannes.schindelin@gmx.de> <cover.1493414945.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Xs+w2Bc+LHcLdtCPWhKbVLGhb9pDMPW709yb50iIWTrxCE1uCt8
 Y1u3Bj6nwtRHWdRRb4jChx/014SdsfA5oHl0QiRSxvjiEBAAAKCvDZ1Cum2IOXM4t5g5gYG
 y2daoRg4lYKzJidz0oxGzl1+w9Hnevti0774lPQKpBeQtksbZ1OuvwNqwibWOYZbvphMhV5
 FJIStNsrSKz5+dgZH7SWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0JnDwei8yZ0=:Dmx+b4c/HSL/0rGJ3DASyS
 2e6N6NCS4JwMKS1yHB/jcWbwm30UY6btauFtEttsk+gQdJDaoXf5GwdXp0jkurY/cW8lFJ6v/
 WO1z9EL3jXhRG777l+0sQO08wJZdBLPqAzswtSQc/BACgaetv1awsaHer05G4EWbejk04ioAG
 BmnAGzGSSCOAxVpvx0BL8B6J8iVTRw5RjCRjr8ZDbz4+o6+0jOJzkKxtWqxXI1gjxvgdDnhgY
 i9UtuOcVl4KVrEcFoHiU1pIl+/qQfq44WiRzHlH0XVagLsNNa4Nbi8h16dBSAOET0ijIBFHRT
 1rNFhYXp4yr127TAPmsCftaEsYciGaimWYRgQImgqPZ0YeoPSV/n8RDHIWd4FgAuHC34HWMfd
 CmoZX5zLDhkeYOb+XJbmqO0UPuHKyIlNEKxp+GMTPzWKvqGcKybZzCZ9PGCjxbsnhbHmGoG7B
 PEpshS4KMrjtdtfGxzRmMmmCCsCjdwTHV3tGhukJjZGm4Z7/ECKHq4dRSIlt0wyGVeOTSFWDB
 w3YB1JLf/aJtW03OZ1X41gEI2+6rQqeEK7RAsXxeQUDAP8bgb0Qw8jC50KWf8QcMWVPJO2Rao
 oA0w9jSS5bbcplAEya9fVZNngPqJR5qwG/vAz5oLMxdEqyCBGzfYuyq5L0yPiD2p7mDPPgGOc
 YaklUQgPrILeW56kPW3KZi6Rvrwuclmn1/EscWaqNGpCbf/CZ26JVX2fJm3ZpsurrPHiroBq1
 On3QnhxPmyCHOEXZIiQEy7eUMSli4BempHZ3b+x0z3SwxRFwiMs6/63L0g5K6rquwg7HmM6dh
 dPISj4z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

An upcoming patch will move the todo list generation into the
rebase--helper. An early version of that patch regressed on an empty
rebase.instructionFormat value (the shell version could not discern
between an empty one and a non-existing one, but the C version used the
empty one as if that was intended to skip the oneline from the `pick
<hash>` lines).

Let's verify that this still works as before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index 48346f1cc0c..6c37ebdff87 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -271,6 +271,18 @@ test_expect_success 'autosquash with custom inst format' '
 	test 2 = $(git cat-file commit HEAD^ | grep squash | wc -l)
 '
 
+test_expect_success 'autosquash with empty custom instructionFormat' '
+	git reset --hard base &&
+	test_commit empty-instructionFormat-test &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git -c rebase.instructionFormat= \
+			rebase --autosquash  --force -i HEAD^ >actual &&
+		git log -1 --format="pick %h %s" >expect &&
+		test_cmp expect actual
+	)
+'
+
 set_backup_editor () {
 	write_script backup-editor.sh <<-\EOF
 	cp "$1" .git/backup-"$(basename "$1")"
-- 
2.12.2.windows.2.800.gede8f145e06


