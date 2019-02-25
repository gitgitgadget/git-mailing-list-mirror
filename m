Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D0920248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfBYVyW (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:54:22 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:46619 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbfBYVyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:54:21 -0500
Received: by mail-qt1-f201.google.com with SMTP id r24so10566839qtj.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=B/NA90jRu3+C+k1VoKgh5ggzgW2QMKfjvPMG/YAB52o=;
        b=ceTMh0Ya80xZLR8BX7Xy40eT4MvpDsJ56J34e9t6T436p4ftKSId2z4k+BrsTa2ETy
         QW/QIu+IOPR1Eya7+ASYGDOGFVJpD+uEDWnAFv2Gbdp2EhPczejFyQVkWyDALK62Fecf
         kyaeyNE1p1OtJVGCqgcjgEWLn5vDUgJphGz8eBT26iUcryRe1bC8OUQlzyOBfx5gscA5
         Jd8R9Ps7iXXCe4tS69wu9UpVOtXeErUwI/rHEdIpCup+MEO7Td8p4J/SixEkewW2vJXB
         1aUhb9mXZ48QO0ZcJlpscsuwi9wxz/bH+Gx/mlsXq4ylUC1qniT5KLeuz9z5JlAO5St/
         Igzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=B/NA90jRu3+C+k1VoKgh5ggzgW2QMKfjvPMG/YAB52o=;
        b=ev30CCi71TGpVsFBn3iUuuh6wSsJZL2gYoOAvLlyeN4xPMUaTXrzpzuV9esr12kk7j
         R0xD3V+X6r8Xr17tmeRLmYfSQyefLTo7L4DSWIRFrFhmXBryo2K7tuR1alfr3CNPi7N6
         LuQoxPnQTLTUTiYuZMJpGH9tdRD4Xus4Hv2es0AH4N80RjLK7SJnkFxUu8qeJftvfl3p
         AL2x6alXI94ADu+28zAYG5Bz2Bf6WvkksLbfxoEjkf+jyW7uOLqVSIFn7SOzSisOJ2pM
         L+d1iGNo0b0Nq3MFGFLo+k/0VOkMuaI8218LjSXuEBV5zey0HGrjNzZBs31FWy62x9wV
         3pnw==
X-Gm-Message-State: AHQUAuY1yp8u/lKh0fck73YzIibrW3HI6tR8Pu3MNS7FYShO0Jw56bJE
        6LtmUq+NrP8y5qT8IKO5UFzYKFsz3dSQQsN9o4QVZARLn+yYTIB9pWW/cOT+2YU6iqDNboNLK4J
        5ioUYFOzd7MYgxV6eEguYAgDz0yD5eDHiajVFS8Rp2lCv0law9Q2FGDrBbZBK8ry7yUJQ1XwXyL
        E3
X-Google-Smtp-Source: AHgI3Ib+7nXfhFJEMfXNNTLGSIvMn/ZE3tit1Vfbe8gC/dnXT49UfkNvLsfaRouTom/3c+U3v1RPs9WcvkgiNgDLYCAj
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr12149836qke.50.1551131660306;
 Mon, 25 Feb 2019 13:54:20 -0800 (PST)
Date:   Mon, 25 Feb 2019 13:54:06 -0800
In-Reply-To: <cover.1551131153.git.jonathantanmy@google.com>
Message-Id: <4dcd89881317eb97886e1ba0377ae6fff4edc1da.1551131153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1551131153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 1/8] tests: define GIT_TEST_PROTOCOL_VERSION
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>
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
unset or set to 0. Some tests fail when GIT_TEST_PROTOCOL_VERSION is set
to 1 or 2, but this will be dealt with in subsequent patches.

This is based on work by =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 protocol.c                  | 17 +++++++++++++++--
 t/README                    |  3 +++
 t/t5400-send-pack.sh        |  2 +-
 t/t5551-http-fetch-smart.sh |  3 ++-
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/protocol.c b/protocol.c
index 5e636785d1..9741f05750 100644
--- a/protocol.c
+++ b/protocol.c
@@ -17,6 +17,10 @@ static enum protocol_version parse_protocol_version(cons=
t char *value)
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
@@ -24,10 +28,19 @@ enum protocol_version get_protocol_version_config(void)
 			die("unknown value for config 'protocol.version': %s",
 			    value);
=20
-		return version;
+		retval =3D version;
+	}
+
+	if (git_test_v && *git_test_v) {
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
 enum protocol_version determine_protocol_version_server(void)
diff --git a/t/README b/t/README
index 886bbec5bc..3125bfa6b6 100644
--- a/t/README
+++ b/t/README
@@ -341,6 +341,9 @@ marked strings" in po/README for details.
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
index ba83e567e5..a852684e16 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -43,7 +43,8 @@ test_expect_success 'clone http repository' '
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

