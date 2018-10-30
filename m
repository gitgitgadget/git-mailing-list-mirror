Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6B31F453
	for <e@80x24.org>; Tue, 30 Oct 2018 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeJaHDs (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 03:03:48 -0400
Received: from mail-it1-f201.google.com ([209.85.166.201]:59041 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeJaHDs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 03:03:48 -0400
Received: by mail-it1-f201.google.com with SMTP id j7so12258045itd.8
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=MNojA5uCyoBReYWk+/uamYgjAi7b0DBMdws//zOTtX4=;
        b=TyCMEOmB0d7rqQyIcuoRtZ+VhaUujZFRVNl6054qQXytyGM6NH7girbxlFKp9bexhZ
         4B3EF9QFsg6lnN3nqHL0hyKBtkQMu/+ZokC8Fu0BjjxtVzvaPykW5e1sfDDME7P6h1fi
         /NIv8T/YJ5DRyi4YVi7BoEI8U8UeWocjgj1ztA8KG4RjZB6sf8ul5B0tG/71mox/AVBz
         lmOwW5dqaDKfX32EtjJNz/OzoQVzewd2BQpSJOq9KIap6PTBKSYFPo8+1jSlvvvxmTWh
         UjD8l6EwgiffGx4TjOJul4pcCdenl65QLXQDXVjiGg1Dvrv3Ug5Ew0s824zP/s5jxhUx
         7iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=MNojA5uCyoBReYWk+/uamYgjAi7b0DBMdws//zOTtX4=;
        b=rIVvzdOJBLsfEskPTdcpYrK+0JF017M5JR9pjOoKdQxn15oCU2prt+c9cASAENz6s+
         lvPmNq24fJZTodPhtEkFLj5NYH3kKUyuLKZrSBCDtQDD9QMK3OuOyXbZ4kaGOxcnJ1xT
         NpXXh1tnpDz2gxUBW1ZI5grUCFFroXCnFRAKH8NGi63TVwo9Wjy37B1b5v+ouZRy50Qa
         S6SVDJm6CJqq3dOhYAoombiNeY6nhOgbrR90K+Cp0ySHwZJA3EL1hpou67Fbkpm8T6y2
         JYZJeL7ADOf6bdHqSCZGo7emJol+pfeTZIaMGYXljDxBCxlcZovGZ3jbSnGedTDHIWnl
         VXYA==
X-Gm-Message-State: AGRZ1gJ+hkOB00sPi6Tm5iqjbBDuRGFYDzMshw94aek8O2EzWuy5nwN2
        HWxriBcQcaub0dPIK46+HTz5neqEF+LYPkLzJnYYw803rkEwjXvRCyBVpzBlAzYUScKjpBi+nH8
        vYjbOE/zBW756LPVrrhn+SwYlOOvJ2oSbP8s+L335586sJUN6BIMrSdEZSKIR
X-Google-Smtp-Source: AJdET5ddiiPIq6xjbPr3jIJ1W4IMc2ZhB7m6jur5hMibyEQX4T3NFCIWQK3JnXRBOGFj19cjVHlXFSIfEwL9
X-Received: by 2002:a24:8903:: with SMTP id s3-v6mr333793itd.26.1540937312932;
 Tue, 30 Oct 2018 15:08:32 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:07:54 -0700
In-Reply-To: <20181030220817.61691-1-sbeller@google.com>
Message-Id: <20181030220817.61691-2-sbeller@google.com>
Mime-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
Subject: [PATCH 01/24] Makefile: add pending semantic patches
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>

There are basically two main use cases for semantic patches:

      - To avoid undesirable code patterns, e.g. we should not use
        sha1_to_hex(oid.hash) or strbuf_addf(&sb, "fixed string"), but
        use oid_to_hex(&oid) or strbuf_addstr(&sb, "fixed string")
        instead.  Note that in these cases we don't remove the
        functions sha1_to_hex() or strbuf_addf(), because there are
        good reasons to use them in other scenarios.

        Our semantic patches under 'contrib/coccinelle/' fall into
        this category, and we have 'make coccicheck' and the static
        analysis build job on Travis CI to catch these undesirable
        code patterns preferably early, and to prevent them from
        entering our codebase.

      - To perform one-off code transformations, e.g. to modify a
        function's name and/or signature and convert all its
        callsites; see e.g. commits abef9020e3 (sha1_file: convert
        sha1_object_info* to object_id, 2018-03-12) and b4f5aca40e
        (sha1_file: convert read_sha1_file to struct object_id,
        2018-03-12).

To allows semantic patches of the second category, we'll introduce
the concept of "pending" semantic patches, stored in
'contrib/coccinelle/<name>.pending.cocci' files, modifying
'make coccicheck' to skip them, and adding the new 'make
coccicheck-pending' target to make it convenient to apply them.

[Missing: SZEDERs sign off, so I also do not sign off]
---
 Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b08d5ea258..6ea2bbd7f5 100644
--- a/Makefile
+++ b/Makefile
@@ -2739,9 +2739,11 @@ endif
 	then \
 		echo '    ' SPATCH result: $@; \
 	fi
-coccicheck: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.cocci))
+coccicheck: $(addsuffix .patch,$(filter-out %.pending.cocci,$(wildcard con=
trib/coccinelle/*.cocci)))
=20
-.PHONY: coccicheck
+coccicheck-pending: $(addsuffix .patch,$(wildcard contrib/coccinelle/*.pen=
ding.cocci))
+
+.PHONY: coccicheck coccicheck-pending
=20
 ### Installation rules
=20
--=20
2.19.1.930.g4563a0d9d0-goog

