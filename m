Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2AB1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 00:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfBFAVa (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 19:21:30 -0500
Received: from mail-it1-f201.google.com ([209.85.166.201]:52503 "EHLO
        mail-it1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbfBFAVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 19:21:30 -0500
Received: by mail-it1-f201.google.com with SMTP id o205so1526243itc.2
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 16:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bzMSmmNf61aws+11xjYEzZh+7adoDsl8yuJy02exA1U=;
        b=GuPsFkmlCcoXdHtVyvhQwjCDPeYVsuSwbnBs0jymO856BXWCNtYCXoyda1q0hH4fgH
         ke4z5dYbG5RQrFJOESGkG/2j/CeUPk0CFTHmsbQ9au+VWVDjOTlIT415PFw9tMP2Qrpd
         H6p3fZEljRzlS3JaUrV9TCIy5IpP5H6CjlETQeh3v1f13oPGBYOE+xV+3md4pXFJ+Uzy
         lziIvrNWVPx0NOjcDalLaezCpxLPM7eqyIuB5POth77jY8mf3YIQlLs+mpJBmY9HsCJ3
         T74XNoTTTSgGaFCOcKvVMx5RZU3AfXG8HE1LLKVyMK4WDZVPQg6Z+a73Uq+RGn/Ia6J1
         Yecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bzMSmmNf61aws+11xjYEzZh+7adoDsl8yuJy02exA1U=;
        b=OJU12QMzWj3TA9wJGllPvc1JCPM05rkD0LYVJbLKJtpiJLXStcjmYboZktAT67hgmd
         SQrpt8YUe68Sp6OZ+ur/m9dNwuwIgnukKj0we5jUYlUco2BQG0sBUOCaeOcnqqJoofbJ
         a0fLPjRhi7t6Agrs0+a/BVCnDHW0Wf7eEWaWCLSks7VajZSsPzelBvERQpSyIJGpYlgO
         Vjf34jYeGVZZTsEH0yiZ5mfv4Fkt2pmIx39qNm5C3dHiGL97UuSbggRaBwg6MOe7RTac
         7N/zSU0OtW43ulXTbrJTVwkjRrkSLhVRXM/iQPXdHQytU7pHVkSeKiuWvP0Qa0Qm/j+g
         3o/w==
X-Gm-Message-State: AHQUAuYw4gt53AAibzAPh606A2YCopF2NWbaiAv06fx5Y+TdF3ihnHXq
        tDIhT3k8iZKZPMk09t/7qnDjb2a38GPpDu1GVS6iFKe1kjdt12psl5zLyttUwxT52dlpjY4LaQI
        FjaiB2OnfO4wQMJWjlQenX/YrOxa6Ry5H3SGI0UMsaj+xQszx0ll7sw5si6zeY77CUrYf2qk8fw
        4T
X-Google-Smtp-Source: AHgI3IYU2dPMVRBtY7vin45JxU/UD50IMNEfAM4Sxnz7ZGNC4ATbBMAxvjYzg3iUvrwPBa7A3UmgKiNMtrA5JmhhOeMe
X-Received: by 2002:a24:1c5:: with SMTP id 188mr935202itk.12.1549412489061;
 Tue, 05 Feb 2019 16:21:29 -0800 (PST)
Date:   Tue,  5 Feb 2019 16:21:15 -0800
In-Reply-To: <cover.1549411880.git.jonathantanmy@google.com>
Message-Id: <6e0c6aa9a71d4192591ed406735684cd15a0e3b9.1549411880.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1549411880.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 1/8] tests: define GIT_TEST_PROTOCOL_VERSION
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Define a GIT_TEST_PROTOCOL_VERSION environment variable meant to be used
from tests. When set, this ensures protocol.version is at least the
given value, allowing the entire test suite to be run as if this
configuration is in place for all repositories.

As of this patch, all tests pass whether GIT_TEST_PROTOCOL_VERSION is
unset, set to 0, or set to 1. Some tests fail when
GIT_TEST_PROTOCOL_VERSION is set to 2, but this will be dealt with in
subsequent patches.

This is based on work by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 protocol.c                  | 17 +++++++++++++++--
 t/README                    |  3 +++
 t/t5400-send-pack.sh        |  2 +-
 t/t5551-http-fetch-smart.sh |  3 ++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/protocol.c b/protocol.c
index 5664bd7a05..c7a735bfa2 100644
--- a/protocol.c
+++ b/protocol.c
@@ -42,6 +42,10 @@ static const char *format_protocol_version(enum protocol=
_version version)
 enum protocol_version get_protocol_version_config(void)
 {
 	const char *value;
+	enum protocol_version retval =3D protocol_v0;
+	const char *git_test_k =3D "GIT_TEST_PROTOCOL_VERSION";
+	const char *git_test_v =3D getenv(git_test_k);
+
 	if (!git_config_get_string_const("protocol.version", &value)) {
 		enum protocol_version version =3D parse_protocol_version(value);
=20
@@ -49,10 +53,19 @@ enum protocol_version get_protocol_version_config(void)
 			die("unknown value for config 'protocol.version': %s",
 			    value);
=20
-		return version;
+		retval =3D version;
+	}
+
+	if (git_test_v && strlen(git_test_v)) {
+		enum protocol_version env =3D parse_protocol_version(git_test_v);
+
+		if (env =3D=3D protocol_unknown_version)
+			die("unknown value for %s: %s", git_test_k, git_test_v);
+		if (retval < env)
+			retval =3D env;
 	}
=20
-	return protocol_v0;
+	return retval;
 }
=20
 void register_allowed_protocol_version(enum protocol_version version)
diff --git a/t/README b/t/README
index 25864ec883..21e941eb94 100644
--- a/t/README
+++ b/t/README
@@ -327,6 +327,9 @@ marked strings" in po/README for details.
 GIT_TEST_SPLIT_INDEX=3D<boolean> forces split-index mode on the whole
 test suite. Accept any boolean values that are accepted by git-config.
=20
+GIT_TEST_PROTOCOL_VERSION=3D<n>, when set, overrides the
+'protocol.version' setting to n if it is less than n.
+
 GIT_TEST_FULL_IN_PACK_ARRAY=3D<boolean> exercises the uncommon
 pack-objects code path where there are more than 1024 packs even if
 the actual number of packs in repository is below this limit. Accept
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index f1932ea431..571d620aed 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,7 @@ test_expect_success 'receive-pack de-dupes .have lines'=
 '
 	$shared .have
 	EOF
=20
-	GIT_TRACE_PACKET=3D$(pwd)/trace \
+	GIT_TRACE_PACKET=3D$(pwd)/trace GIT_TEST_PROTOCOL_VERSION=3D \
 	    git push \
 		--receive-pack=3D"unset GIT_TRACE_PACKET; git-receive-pack" \
 		fork HEAD:foo &&
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a60dd907bd..8f620e0a35 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -44,7 +44,8 @@ test_expect_success 'clone http repository' '
 	< Cache-Control: no-cache, max-age=3D0, must-revalidate
 	< Content-Type: application/x-git-upload-pack-result
 	EOF
-	GIT_TRACE_CURL=3Dtrue git clone --quiet $HTTPD_URL/smart/repo.git clone 2=
>err &&
+	GIT_TRACE_CURL=3Dtrue GIT_TEST_PROTOCOL_VERSION=3D \
+		git clone --quiet $HTTPD_URL/smart/repo.git clone 2>err &&
 	test_cmp file clone/file &&
 	tr '\''\015'\'' Q <err |
 	sed -e "
--=20
2.19.0.271.gfe8321ec05.dirty

