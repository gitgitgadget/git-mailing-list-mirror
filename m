Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E22D1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 20:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeIGBL6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:11:58 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:36604 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIGBL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:11:58 -0400
Received: by mail-ua1-f74.google.com with SMTP id m19-v6so5282670uap.3
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 13:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ZD/R4eo1sB1agSEfqQZB0tXIgr56eU+4kUpHvU9GGH4=;
        b=N2uaDE/xjJxZH97WWGMCUbSt5TXHsYvBId8ZSsKoXN+xWvppd06Uc309xB1/FXiBpH
         pmWwrEkC/PDWyIn7ulYFYll7+abYg6V9kJt7b2mijQ1jy17nS7sZTBnpNFSghKjZPc8G
         911w9XbOi/QFqiM6wWDYcD93221tSrxRmAddpIArcurvdhe/YULk0sorwYgEgyklnz4c
         B2ckJ0fzj/aP4JNKea0VN9+XvbRS2CKEfh34tBLcg0C073S4ZXeqKNoIBCRdWMH4hv3b
         g+wAXRl8qDnrA6gGloFM1ZYZhAG2togI/8MSGtG8SwfctgkD+tFZDhAlZQTOgk6XzGNn
         38Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ZD/R4eo1sB1agSEfqQZB0tXIgr56eU+4kUpHvU9GGH4=;
        b=INtGFcWznbB7oioRy5yjAD9JC34leJ8H6dXZKm2dm0UbhcUTjBDLgAiwEPTyox6bG4
         km7EGTD/4vCC8jNw3Mk0CnCZpOKoEH8bhn3xNBE+A0Tu4Ew5VD3KHgvByie9NcYXbXA5
         H7mwDSsb9AXkwsyV1lLhgkaEFFjjueKEO1ukqsK4sn8lfba4et/Yu+XlRBFh8g/Y8XyA
         pubaoNMHV75HSHBJTFo3/0TUH4cIer5zI/Glaaa52KoTo6qtG19YT0od6NvXs4Ti8pB1
         sy+uFaRO+Bns1BTlnwDe1xw0v9xvYi5f94G+uT9n5jNZiVyW2nPtLUnfwaQoTOm15hQq
         8rjg==
X-Gm-Message-State: APzg51DSugafrG5nHmHtMstDQMX11BsF4akGmeRBG5+P1YOf/uz8W0zj
        /E4SK6rD0uAPf35dRu8ZxWC3GrJ04pN/bhtMzN1BQj6N15WfvemSuWP6TJ47/poB0yycjZ4XMZt
        RXAT1lA9qrnNiZ2B8cSYTSc+IWO2+vc8mTEqzGBB+h4xg2NWeNNj2PcWc2kVQ
X-Google-Smtp-Source: ANB0VdYhidx74IxfczpoYjG7QcUejAsKcc27GaiUuutrgaCKvka5n6A5unX3ixUe73lsbwvaXeZ2OUXiAV97
X-Received: by 2002:a1f:2903:: with SMTP id p3-v6mr826340vkp.88.1536266088564;
 Thu, 06 Sep 2018 13:34:48 -0700 (PDT)
Date:   Thu,  6 Sep 2018 13:34:44 -0700
In-Reply-To: <CAGZ79kY_+jNAu4jwVOhd+gVMELDSjk_MACKBRf51tksrzZMx-A@mail.gmail.com>
Message-Id: <20180906203444.162213-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAGZ79kY_+jNAu4jwVOhd+gVMELDSjk_MACKBRf51tksrzZMx-A@mail.gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a-goog
Subject: [PATCH] git-mv: allow submodules and fsmonitor to work together
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Ben.Peart@microsoft.com, avarab@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was reported that

  GIT_FSMONITOR_TEST=3D$PWD/t7519/fsmonitor-all ./t7411-submodule-config.sh

breaks as the .gitmodules file is modified and staged after the fsmonitor
considers it clean. Mark the .gitmodules file to be not clean before
staging.

Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Inspired-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

I am not quite sure if this is the correct approach and handling of the
fsmonitor API, but it unbreaks the test.

> Just naively adding mark_fsmonitor_invalid doesn't work, as then ...

Adding it before the staging, works.

Please double check!

Thanks,
Stefan

 submodule.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/submodule.c b/submodule.c
index 50cbf5f13ed..56b0d5fe24e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -22,6 +22,7 @@
 #include "worktree.h"
 #include "parse-options.h"
 #include "object-store.h"
+#include "fsmonitor.h"
=20
 static int config_update_recurse_submodules =3D RECURSE_SUBMODULES_OFF;
 static struct string_list changed_submodule_names =3D STRING_LIST_INIT_DUP=
;
@@ -149,6 +150,15 @@ int remove_path_from_gitmodules(const char *path)
=20
 void stage_updated_gitmodules(struct index_state *istate)
 {
+	struct cache_entry *ce;
+	int pos;
+
+	pos =3D index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
+	ce =3D (0 <=3D pos) ? istate->cache[pos] : NULL;
+
+	if (ce)
+		mark_fsmonitor_invalid(istate, ce);
+
 	if (add_file_to_index(istate, GITMODULES_FILE, 0))
 		die(_("staging updated .gitmodules failed"));
 }
--=20
2.19.0.rc2.392.g5ba43deb5a-goog

