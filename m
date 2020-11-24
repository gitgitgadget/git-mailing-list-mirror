Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C54C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A821206D8
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 00:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ItUvOc8G";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kyleam.com header.i=@kyleam.com header.b="nxyRpijv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgKXAwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:52:45 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62099 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgKXAwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 19:52:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 23C3810AEBA;
        Mon, 23 Nov 2020 19:52:43 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=vAwfi4x4YnknJwoK8425th2MS50=; b=ItUvOc8GXwSLivcKHruX
        cNzPLYS0wLASqk27X4Ovgmu2ttAGVPMKLdE6rDavQnu+oDKw1kalGcW0ZNF6YMJs
        ets0uhvXNUym9tIcAJ2p47o5bXHMi8Vze9I5hspKP+z0Bb/Fw96OZEO1rTjnvPyq
        GqqhoIA9ghBNnDLR4uWNHsU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D19710AEB9;
        Mon, 23 Nov 2020 19:52:43 -0500 (EST)
        (envelope-from kyle@kyleam.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:subject:date:message-id:mime-version:content-transfer-encoding;
 s=mesmtp; bh=IHh0OtO35gS7uI1z6Xk60CWw3bnUCZF2JBZtiP67uvA=;
 b=nxyRpijvQ0ZbNqohTMUxp3cYrVLC4xrGTeR+nTV2GjPgjDCI2et4ALxjyweb9Thui5O1DaHhmx7UOzXc5y2wJS+WTppfFCLY8kWVD2lwZIo8d8LUW0O2KRSoVS17M8Lj8fdN5qL28wGsEWtR+0sYKB3m12rbau9ybTT8wzj7akg=
Received: from localhost (unknown [45.33.91.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D98110AEB8;
        Mon, 23 Nov 2020 19:52:40 -0500 (EST)
        (envelope-from kyle@kyleam.com)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Subject: [PATCH] stash: add missing space to an error message
Date:   Mon, 23 Nov 2020 19:52:12 -0500
Message-Id: <20201124005212.13780-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Pobox-Relay-ID: 5AA51A40-2DEF-11EB-9AFB-E43E2BB96649-24757444!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Restore a space that was lost in 8a0fc8d19d (stash: convert apply to
builtin, 2019-02-25).

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 24ddb1bffa..e1f8235fdd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -419,7 +419,7 @@ static int do_apply_stash(const char *prefix, struct =
stash_info *info,
 			ret =3D apply_cached(&out);
 			strbuf_release(&out);
 			if (ret)
-				return error(_("conflicts in index."
+				return error(_("conflicts in index. "
 					       "Try without --index."));
=20
 			discard_cache();

base-commit: b291b0a628020eedb10b6236d87fe25d295cea81
--=20
2.29.2

