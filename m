Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635627;
	b=u5J1ABnyqHRdRwFbjngqScScZVM5KkdmHH6KFtuxafTQDXG8pnM4dGw6ZC2G9YGZVLbY
	 fnRxvfHsliZEFfYrXFiBCyrD/rCvyVRVUWhM6gKqngOBb38gAFZLcDaO0WXt8uRcvCgvU
	 Et4pIgc4/DR12hzf5sZWD9/1MTKDEWy1DLzxgGcB644FzB5fU8oWF+e8Y7jcTajf1m0cz
	 tQqIxgaCk1o/q0S/gIysQ7hN4ZJ+ERE1dJUBsc0QyC8GT+LII5wTnzTXkeNQllEr4zq+a
	 zr1e1+Vp1pkHf5hH/1CrwhVLLgfIIHxGQ1cJdFc5g7G/oOY4lIjozicSMMDNImVkwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=kKUmX785yPmOX40N56hKJd4KhTUEjEHzqBNyU82YAY0=;
	b=cwxxUbZDs7PhWeTsTskEtiiLcv05wBs6XDeLapgZXMq1B9GOjkLs8TxGPEnQ3rCPUF9S
	 2cmyO4p+yTvIrnau/YZGrfm83t335UIJ6EP41R/cE2rBc742MrTW7JtOgBryIXAOVmWtC
	 BCQLs4dchceLkZ4/l+lNZRGx7R5c1/oHAQc22+yv1LDqk0SKJbNU1qw0ry7Y1XXDblRi5
	 dMV7Et+naSDhJ4WR4d+BgxY/KZpSmSUlhADCpo4JgnErqQfnnqBEjSvfQSYs7b3Ika6wk
	 Txbn2n78+d3PdDugdEPrqXqdaNXCRw/+tes5rfzSFzslRHi+LaWCWMT9tCS2llWBdTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iB6TmiHi;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91A6606A333
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 19:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D91A6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iB6TmiHi
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ada81853so7216637c88.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 11:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795635626; x=1796240426; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kKUmX785yPmOX40N56hKJd4KhTUEjEHzqBNyU82YAY0=;
        b=iB6TmiHijPnwbrWJPM228zz5qRoz/bhht6BYeFpXRxblA3DqC2sUsNPWFvMBw7wDdy
         kdaF1fYW/qmBKP2AS5BOEOb+CHR0tzMnb0N08f3oN+STxu0WZlvC5py3HNyO/tXTjFjK
         gX4OCOY9ZpeqUNDEzdG9E8bJn4ow08rhU7VuGHevJ1bh3HvsGFx/x6KStBFGwiZq1Mwp
         lMuB2fi66A/iLr8ZrybBgU+RpRdxr9vTRVy8WdoB7iCim8Bv8fcDcPSCQUsCYNmlc3KS
         OCUQioOFec7hX3UwDvgS8E3gCnLGg1oxh+QvxU16yGCok36ReLncYlHccyrlQjughg21
         tQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795635626; x=1796240426;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kKUmX785yPmOX40N56hKJd4KhTUEjEHzqBNyU82YAY0=;
        b=h+cKNUldgDxe3T+bkKkwtsrHLNzAMnwmPXl+yCcWDT2eG+brFJ0KDQkqONwDrqVtMK
         dvZGLv8L9X3XGogCzy6fGDKoX53IbGm7ByYnSRzcWnfXduv1E1PptNIRWfphwABbf1rR
         fzM/Wt8eCf+6zGk0vI8zEogbnybEE13q+LMVYvJ57xTXNTT1NronSAfBbQQ96dbYSGA0
         NALBd2xHjXitzfKDmHfFCzm1xPA6DX6y8QHtNctyidpr7HighW2j1Hglo7XBDDrjTCW3
         0i4NmCo2QDwbW5dzlaxS5bxW6EhgA9x+BqYlm4nwLJQQ04M6ERb+tYlz2Tk7QYITcFDT
         L2BA==
X-Gm-Message-State: APuU4Z/SJFlbyPKSJ6Tagk+TXL+HQf9/X40Srdw4jZAQhm3oWZ/gPKYt
	EUs+B85qJsmuMxQHVsl8AnPtVvwc0f0YpbYRWZdxTLWn2BIqMa8C85smdDpoyA==
X-Gm-Gg: AZFdTZdc/iDoNGQ9oYfw7n8uV96iDJhKnV77TSorXRfdIvFOXegS2K6AihWPhLUcQHg
	hP5gIbV+xO3tJvpaNvVoLZzqcex8RSVr2OXFXRd1wPtBoba8ZyDUJtcJ6W67Mz67Ip6zlFT8n/a
	vgait3XaFojkKCmthfI/z6ShaQqXOlaZVUaiToUysFbhB0oowpG34abMCAlHdARREXoloHf2A5L
	8dptA9X5GehRmTv+WgvbclUsX25EM5PPXluYfTMXCjS3tWW4d5LLLdI0Pp7G0lvidc3xbP9XNzj
	K/RnBRv2Tnnw3skjhJhvWqV8dYhn22yTfbB8xii58S62eeOIlnTAdukfxUNkPljc06fnEQtFkJz
	VQLsEIggXRgA636TIytw3doJZ7ZXgxg2cKc2j/9Bni7fCRhxfx5K9h8gUZU6kdCv4q31n9Ff9gF
	GLI6ehnumXQWb87aOdcxOORAelcDnJCp8ANb+W9wYck4H+Wcli8ijfE2BEaLFSzPrUPAWIEZEhc
	FAQLdL2RHSD6I3xVE1kYQLlvIOsDgQITfGsfoFt/1nH8ndRWIH7Emscojbesk1kqw9msLp9v3Ht
	i+fA4rRAUrOgODqjw1TsEXQPr8zoTg1CStADqRwNxPIVAck8qRUo9Kw=
X-Received: by 2002:a05:701b:4586:10b0:1a3:9936:d11e with SMTP id a92af1059eb24-1b558384bf2mr17606576c88.41.1795635626005;
        Wed, 25 Nov 2026 11:40:26 -0800 (PST)
Received: from [127.0.0.1] ([57.154.167.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm33572907c88.4.2026.11.25.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:40:25 -0800 (PST)
Message-Id: <pull.2333.git.1795635624820.gitgitgadget@gmail.com>
From: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 19:40:24 +0000
Subject: [PATCH] pack-objects: handle missing promisor objects
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alessio Attilio <attilio.alessio@protonmail.com>,
    Alessio Attilio <attilio.alessio@protonmail.com>

From: Alessio Attilio <attilio.alessio@protonmail.com>

Objects missing from a partial clone are expected to be absent.
When checking whether an object is in a promisor pack, do not BUG()
if its object info cannot be read. Such an object cannot be included
in the pack, so skip it.

Signed-off-by: Alessio Attilio <attilio.alessio@protonmail.com>
---
    pack-objects: handle missing promisor objects

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2333%2Fkairosci%2Fattilio%2Fpack-objects-missing-promisor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2333/kairosci/attilio/pack-objects-missing-promisor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2333

 builtin/pack-objects.c   |  2 +-
 t/t0410-partial-clone.sh | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 65c2ad9a86..5228d7f90d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5092,7 +5092,7 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 	};
 
 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
-		BUG("should_include_obj should only be called on existing objects");
+		return 0;
 	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
 }
 
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 788e9a1631..a858aa0a85 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -32,6 +32,26 @@ promise_and_delete () {
 	delete_object repo "$HASH"
 }
 
+test_expect_success 'fetch --unshallow with tree filter when remote has advanced' '
+	rm -rf server server.bare client &&
+	test_create_repo server &&
+	test_commit -C server c1 &&
+	test_commit -C server c2 &&
+	test_commit -C server c3 &&
+	test_commit -C server c4 &&
+	git clone --bare server server.bare &&
+	git -C server.bare config uploadpack.allowfilter true &&
+	git -C server.bare config uploadpack.allowanysha1inwant true &&
+	git init client &&
+	git -C client remote add origin "file://$(pwd)/server.bare" &&
+	tip=$(git -C server rev-parse HEAD~1) &&
+	git -C client fetch --no-tags --depth=1 origin "+$tip:refs/remotes/origin/master" &&
+	git -C client checkout -b master refs/remotes/origin/master &&
+	git -C client fetch --no-tags --filter=tree:0 --unshallow origin \
+		+refs/heads/master:refs/remotes/origin/master &&
+	rm -rf server server.bare client
+'
+
 test_expect_success 'extensions.partialclone without filter' '
 	test_create_repo server &&
 	git clone --filter="blob:none" "file://$(pwd)/server" client &&

base-commit: 1630431f326e15fcde608827b5ff38422528eb59
-- 
gitgitgadget
