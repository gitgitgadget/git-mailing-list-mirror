Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09279C0015E
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 04:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGUElX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 00:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGUElA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 00:41:00 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEE2D4A
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 21:40:50 -0700 (PDT)
Date:   Fri, 21 Jul 2023 04:40:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail; t=1689914449; x=1690173649;
        bh=tM2SNQN8JZhUDcv0+GoFwFVNcOGaxbOAUC7R7aCOYgE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EUjGFdesoNxHHDpww8GdS3lKG93AhanRjlBFK6jHU52z9mKXWsOsPvlOAnUOM4QGj
         qbkIFchX/NnsPqIDccCfzMQNhzzoMiciDBkxB1eyaK44kbQdwrWg33hCXO1kQWrycL
         Dc/obOL9sTIsz7et5rBoxzAcrRUPC27O12RqULPTfYdoshTO9wxWMV6q2YNg5DyWD2
         PaRBjIzqJsa9mwYBcKjkV32EHd3Bj0RxVf0PJHqWIPRpIjWNAMzUcovjJODYh3XlGh
         /rKkxDkHdoWB1jzb5NK+xwF+Itw5KpTVrPR2R6+6VIX2Wnvfz6NGzAXJVMr9HIenSR
         7j8Evt/kx1M2w==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/3] t2400: drop no-op `--sq` from rev-parse call
Message-ID: <20230721044012.24360-2-jacobabel@nullpo.dev>
In-Reply-To: <20230721044012.24360-1-jacobabel@nullpo.dev>
References: <20230715025512.7574-1-jacobabel@nullpo.dev> <20230716033743.18200-1-jacobabel@nullpo.dev> <20230721044012.24360-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 t/t2400-worktree-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 0ac468e69e..e106540c6d 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -995,7 +995,7 @@ test_dwim_orphan () {
 =09=09=09=09=09grep "$invalid_ref_regex" actual &&
 =09=09=09=09=09! grep "$orphan_hint" actual
 =09=09=09=09else
-=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --sq --path-format=
=3Dabsolute --git-path HEAD) &&
+=09=09=09=09=09headpath=3D$(git $dashc_args rev-parse --path-format=3Dabso=
lute --git-path HEAD) &&
 =09=09=09=09=09headcontents=3D$(cat "$headpath") &&
 =09=09=09=09=09grep "HEAD points to an invalid (or orphaned) reference" ac=
tual &&
 =09=09=09=09=09grep "HEAD path:\s*.$headpath." actual &&
--=20
2.39.3


