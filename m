Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D31591F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 22:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbfAPWmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 17:42:25 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:47732 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732830AbfAPWmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 17:42:25 -0500
Received: by mail-qt1-f201.google.com with SMTP id f2so7236139qtg.14
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 14:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=ouit/+S6TOXxvnTb6MOzXk3zHaz8h/7euMXbFNM5Vdw=;
        b=J/7DR5cBZYWphbCshYRjZ5evO8+xPRgliP9/cKFIRGZmzFr9el3q387Quh/fJvEf4j
         fATLOMcMk4+rUX1QiB+EvoaLCRyRhOHPK/88p3kQtrF3A8McG62WFURVhMYm7AqsE/VH
         fH++qM1wlZBm/U5Xuf6LaBB9ecpRQTrI8OQ9Pcd2E24+/jzKBijy47icjDDV7YvT93Vl
         p6TO5DkL60scKdd7yuEhQHh8SHFwKgdWoJ9tLYXzRhTD9nCv/ewKB2+/PAs2ewQ4UAIS
         mS4kiNi9IZl0z/XqK881Ni+1jf6RbtOKZ+M04IbusR15yCEWPknkTBfwmj18kt7sgAwe
         ZJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=ouit/+S6TOXxvnTb6MOzXk3zHaz8h/7euMXbFNM5Vdw=;
        b=pWCaGkM/8n37DbmxPcDYct25+VP3X604SlFMSsaOVazWPkjVClJAHrLeGdPL8WDjWN
         QDLkjGnUoWDKrKMBxyQ9ej1jI57uybmtGUVus4QP/tSKbCJbw6EGA+f14xZk83h8ToG/
         rKkflh3y8tp0UkxgpoEHL0NFOu324sOQE6UuwKOxJYttVryHDIEIw8QfQwDdLx/Wbg5c
         wXvP6jgD00b8I1zgP9dmCNoyE5fPyEP0aLVwPDLH2MAragaTNxikYI4w3axCxLLZB/3C
         ZdbWECCdPzi34J1qM6V1KoEU3MqKxT1bpGohRKX5sbHn41qtesHmrkrWVRap3J+dM16L
         iLpA==
X-Gm-Message-State: AJcUukeJM6vm7G6j+p1cyRxT4XGnfLrPlEO1KRLHy9FHZveiN3vpu8La
        GPv1GF2vrQFHrvZF70h53CbRwKrEnewdrNGa/b9bHc/M3IzKf9ZG3cpdg7bqN9sUl2muG1n0tC7
        0QO/bKPowF6htMNstu3VV+b9WobNPUPzajV3ITbdQK1yy+/1X1Ilccj3z17/rq8fqD1JLfLYDza
        EQ
X-Google-Smtp-Source: ALg8bN5if0dh3QtNBxFAiMEwwoWhetqTR/EcvbXVxQjHSFd7EpbimJ+vs/4G4/DogkqyGYV+JLmIED8BPAG7Anga5wWn
X-Received: by 2002:ae9:e90b:: with SMTP id x11mr6236980qkf.56.1547678544232;
 Wed, 16 Jan 2019 14:42:24 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:42:09 -0800
In-Reply-To: <cover.1547677183.git.jonathantanmy@google.com>
Message-Id: <241afc6b556334fe212147e94167e3f23d4e21f5.1547677183.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1547677183.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [WIP 1/8] tests: define GIT_TEST_PROTOCOL_VERSION
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com
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
index 28711cc508..fd7f29cbe1 100644
--- a/t/README
+++ b/t/README
@@ -311,6 +311,9 @@ marked strings" in po/README for details.
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

