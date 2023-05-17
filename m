Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26331C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEQVsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEQVst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:48:49 -0400
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530CC59EE
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:48:39 -0700 (PDT)
Date:   Wed, 17 May 2023 21:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1684360117; x=1684619317;
        bh=Y1a7rQSncLhtu88Qm/Nvvm58PD7UhbgEwbiKOjAlt60=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jdshn0+xud6AJ9Rne7QH+6v/B2/cGzmoXJNPUNK5KaprElQB6mbmvr5gmH4gAEm/3
         dLkYBWYE2R96chFTD5g51vhXI59m9K5YwnACt7/TEDpuMoI+ogC+Nr/ktlZe25EtL0
         p4Q+SwGWP4rCPse0Qqi5N4TAsmHRcPEs4s2bgiixuzggpnnsBYLUBzKunMbfHeFF9w
         Hh3YGT1EGC9uBBiWHgElEq05+wkg79KFAlK7f6C9goGTDtNvBp6I6sclZ1EehM9PQk
         6rcw1y5hm2Tj0LBA4822sgcOcb7PNmtM+/IbL/BWVcmeTk0LjDtwQnzre+2+bN5DaU
         qKYnzZ1MUaKhw==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [RESEND PATCH v10 2/8] t2400: cleanup created worktree in test
Message-ID: <20230517214711.12467-3-jacobabel@nullpo.dev>
In-Reply-To: <20230517214711.12467-1-jacobabel@nullpo.dev>
References: <20230417093255.31079-1-jacobabel@nullpo.dev> <20230517214711.12467-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..a3f108347a 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -326,6 +326,7 @@ test_expect_success 'add -B' '
 '
=20
 test_expect_success 'add --quiet' '
+=09test_when_finished "git worktree remove -f -f another-worktree" &&
 =09git worktree add --quiet another-worktree main 2>actual &&
 =09test_must_be_empty actual
 '
--=20
2.39.3


