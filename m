Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E518E25
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 19:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352891; cv=none; b=CDLzP8ebkPH7cz+1D8sWX4Zmqi1hhHFd2a9X+Sc/vi5+BiHsF2azt8oErUU+9r4SWLI8wIWGkIsTd5SfCGVIVjUV76ETvrIZm1J5c9mD2rB7WlnemYfqkiwUGzOLY6qCH3HEWhfs0Tx5qBREHCQzLtajAfPBJL8ij8bQ2HMknI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352891; c=relaxed/simple;
	bh=UfwJiU265/Ho0JoPwfh8zgZ162+VxBGunePRP427HkI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=hC+CWZ3muF+ZP7fs6ErTZ27QLw3iH8EknFQP3t2U6eA9b2QxdLcLyDx317tjmpJdkMIGWdSBJlt+kH84QmqU6IoPODRrMwKXupG4txS7hYfvwPtSqchfdLSgHLFlEMWKVxsK35HeF5U4857HD4IH1tbWAO5LWzxILtf7NqVz/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlZSp/Xc; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlZSp/Xc"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso493918566b.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2025 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738352887; x=1738957687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ooUA5V9wvx9XofjTjlNSGoviLfBXUTbTPpvb6FvPOAc=;
        b=ZlZSp/Xcdth60leHbHtNdb4MDUgpKKlzNsXe0nuDaxAjceB20ZC/sefibBL4N7fYRF
         aJh8IPEjXxdp72+tdTighHzIrjwht9I/nVoi+elUMVNI6nIDm5nZwPfIwmUs5lt90Yhb
         qlw5zXCO3FGWlhHeYAIib/ZPS+Z868QUS6xmiXGg8CXn5rZgLJc3fAFZaYqq0kMXnwx4
         qQM00p8l4FVPOwPkHJ3ygL91Yq6KWMCFVQWyyamsQYf8hkRwCD8H7BSjiMeVW+oJOuwh
         /rKSn1vcdnWAJorKMEm1sSV7irRwYhQ0dd/1kzNfmbM1hyEaaVYJQCNwOR40QqkOO5ge
         nAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352887; x=1738957687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooUA5V9wvx9XofjTjlNSGoviLfBXUTbTPpvb6FvPOAc=;
        b=EyUMWxtk3iGYBc5OhYPoz85dnfAWRKwmhRgWbhMyxBwrErxaEJPzzZRjcG9S1jyZ1B
         f85yk425XMXV59WcddCrV7E/tMFcK09hdZoUBowasawaw0lRLC6Rp9aaEU4sTl9TL5Q6
         yveblPB9xybVyC1xC/5nY4TIZd54ZSbe9yXV9/7LSSYHWHJLjfUg8YkgEvmjltk6hxtU
         c19ziqZzw5eqUUk/lZzQJ0anKZhEuuquX704/v4jse3f6WjlvxUPgkYrgICgRzPPpEGg
         I1nTe78jN5z5MN3m5lz9tD8DQAW8omeMRru1wMxeABHnKuevaHGskRFlkWViEAqll+9u
         iweA==
X-Gm-Message-State: AOJu0YwxO5RdPCyWcAJoXxvBNrsvpIRLINO4MYiclDXnoxXxKMTkStvU
	kyE6dadFuBVC9QQjruxnBa4qYGN3McMnFH98QooQ042TM0BQgkPjLwcA1Q==
X-Gm-Gg: ASbGncsmFGPoxZCmw5iFdKfANI9dio/4YC5xaGXbNJSYQKbFj5hzg8XMGibjEL7MecO
	JSgobwp0ouR0XN5JFv2sn20f5aD+TAlWTtbJd8Iw0d5R74W4sGLveFZe71c7tUScMwhw7sS3V/v
	ElqlS0lBjpWggO8McRyiaMjDJ1mTxbvBZhMqh65AaYscAjLPbnLpV9xNPQvKWdHCnx/2EmnvxF1
	ZODHlctGodviGS9gxl3Vl55YWq+gNqKx51Xv0YYNg0W5K3WStKvtpLNy+V+LkA+3C/HSRCXG/aT
	Dgcr7G34feKE+FYu
X-Google-Smtp-Source: AGHT+IGHopVqRS1pej5xAkTxj6LTOUxsXkZx+4suDDr6CdtMSKMT5MMVg8BKg9LVTudjOurD1i968Q==
X-Received: by 2002:a17:907:c31c:b0:ab6:e10e:6e8a with SMTP id a640c23a62f3a-ab6e10e72cfmr1003418266b.27.1738352887052;
        Fri, 31 Jan 2025 11:48:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47ceadfsm344454766b.51.2025.01.31.11.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:48:06 -0800 (PST)
Message-Id: <pull.1856.git.1738352886190.gitgitgadget@gmail.com>
From: "M Hickford via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 31 Jan 2025 19:48:06 +0000
Subject: [PATCH] credential: warn about git-credential-store [RFC]
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
    stolee@gmail.com,
    Johannes.Schindelin@gmx.de,
    peff@peff.net,
    rsbecker@nexbridge.com,
    Johannes.Schindelin@gmx.de,
    M Hickford <mirth.hickford@gmail.com>,
    M Hickford <mirth.hickford@gmail.com>

From: M Hickford <mirth.hickford@gmail.com>

git-credential-store saves secrets unencrypted on disk.

Warn the user before they type their password, suggesting alternative
credential helpers.

An alternative could be to warn in "credential-store store". A
disadvantage is that the user wouldn't see the warning until after they
typed their password, which is less helpful. The warning would appear
again every time the user authenticated, which feels too frequently.

Signed-off-by: M Hickford <mirth.hickford@gmail.com>
---
    credential: warn about git-credential-store [RFC]
    
    RFC for discussion. Some tests fail

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1856%2Fhickford%2Fstore-warn-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1856/hickford/store-warn-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1856

 credential.c                | 6 +++++-
 t/lib-credential.sh         | 2 ++
 t/t0302-credential-store.sh | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/credential.c b/credential.c
index 2594c0c4229..6e05bba7e2f 100644
--- a/credential.c
+++ b/credential.c
@@ -285,9 +285,13 @@ static int credential_getpass(struct repository *r, struct credential *c)
 	if (!c->username)
 		c->username = credential_ask_one("Username", c,
 						 PROMPT_ASKPASS|PROMPT_ECHO);
-	if (!c->password)
+	if (!c->password) {
+		if (c->helpers.nr >= 1 && starts_with(c->helpers.items[0].string, "store"))
+			warning("git-credential-store saves passwords unencrypted on disk. For alternatives, see gitcredentials(7).");
+
 		c->password = credential_ask_one("Password", c,
 						 PROMPT_ASKPASS);
+	}
 	trace2_region_leave("credential", "interactive", r);
 
 	return 0;
diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 58b9c740605..47483f09006 100644
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -67,6 +67,8 @@ reject() {
 helper_test() {
 	HELPER=$1
 
+	# help wanted: expect warning "git-credential-store saves passwords
+	# unencrypted" when helper equals "store"
 	test_expect_success "helper ($HELPER) has no existing data" '
 		check fill $HELPER <<-\EOF
 		protocol=https
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index c1cd60edd01..349b5f0b084 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -133,6 +133,7 @@ invalid_credential_test() {
 		password=askpass-password
 		--
 		askpass: Username for '\''https://example.com'\'':
+		warning: git-credential-store saves passwords unencrypted on disk. For alternatives, see gitcredentials(7) or https://git-scm.com/doc/credential-helpers.
 		askpass: Password for '\''https://askpass-username@example.com'\'':
 		--
 		EOF
@@ -155,6 +156,7 @@ test_expect_success 'get: credentials with DOS line endings are invalid' '
 	password=askpass-password
 	--
 	askpass: Username for '\''https://example.com'\'':
+	warning: git-credential-store saves passwords unencrypted on disk. For alternatives, see gitcredentials(7) or https://git-scm.com/doc/credential-helpers.
 	askpass: Password for '\''https://askpass-username@example.com'\'':
 	--
 	EOF
@@ -186,6 +188,7 @@ test_expect_success 'get: credentials with DOS line endings are invalid if path
 	password=askpass-password
 	--
 	askpass: Username for '\''https://example.com/repo.git'\'':
+	warning: git-credential-store saves passwords unencrypted on disk. For alternatives, see gitcredentials(7) or https://git-scm.com/doc/credential-helpers.
 	askpass: Password for '\''https://askpass-username@example.com/repo.git'\'':
 	--
 	EOF

base-commit: 4e746b1a31f9f0036032b6f94279cf16fb363203
-- 
gitgitgadget
