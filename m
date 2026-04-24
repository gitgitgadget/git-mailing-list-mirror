Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9784F281369
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042919; cv=none; b=byU6RVfvRKPEHPU5IkOE5xRtMCP9xCoVrLuzu7p+65oEVcoh1m1OYHEsb4Eya6qCNjIeR/Kz3Ln/qRsWcRtfauiw3fAmZF8cx4YoH12Mky1nqY4cKwljYhWFzgCNf6sB8CsBNxTJiFZYo6nkBuClOcinMNp/CdCWaijjb8POaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042919; c=relaxed/simple;
	bh=jnm/Z1If7bkvFQkcU7sqYak1vdbr0fMaw8wj4FMrIJk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KNGbcv3u7XvTu7q9ICjxpXaBNr/8trbIphYMsG0pPZ388xgxDihchIg1r7ysYDA4bmlhQZGzMM/GxDWo1mfg1LVwAodd9C1cgxmQ4FDGkPXI+We+XBPpzOmv7RtDOTNYgJ/FY0MbBlmLkuqgJAOA99E2NGV80GKyNS10fWsa0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBcl4vYL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBcl4vYL"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8ef5776530bso411750785a.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042917; x=1777647717; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCHz9aPq0NVGCNpLUqgbv5QeQXOox7FOOXUOGvMdvAw=;
        b=FBcl4vYLeQNx+p5trBfwGiEbIC3HRJVuws9lGLjUPtaTgY8XPJ8QLcOWhdRzPo5Tb9
         XspEJj4ita4ZmR1eLMwGcITRGcoEIlmy7HcrjPjqc662fI0mzPDv0l4IYNfWTrKbzkPE
         K92N+mANMH2BzSmirb508+Xi4k60j45k8BVSif7vf/Da9NZb51Pnvat82fIo+4/QxK77
         x/Nys1aUXwCy/h76bMJc2XMLaUpLpJhv19gJ3xR89YxZwOkQGrE0pHFx+j8npWvY5xue
         4YsL5rXEQsY8J2ViHF83y1q388ak7MIesQG0E350S2Kv3A/eEbnXUatWBu61I9c9DLdz
         cLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042917; x=1777647717;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCHz9aPq0NVGCNpLUqgbv5QeQXOox7FOOXUOGvMdvAw=;
        b=h7f1s9I/0Cp3r2tVexTG/C0B5W68AwVHArjFJLycOPSsQno9C9He5HFaYY0nH1sJdb
         lQTdUqFd2gW95oB9dBkhgN0sgl8H/Ys9wB6DMONIAvXLzhpjYZ5Mxdj40jJLEFNQVlvN
         9CLvfneVJ67crQfqk/+dhId4vZpfuCP32qNEmlgm4AePP+us1RVdYs2LGaZXbhwfqeKC
         kM6NC/g7JZf229hJW6WvqioW6TX0NNC3+IIF5cDXKbL9SfWdKG6byrvYjhFqmh3PR0cQ
         Xhm33OpXcEGsx4HLgUYjWVm2rNFnNla4NnjLrbV0wWTAQb9/gHPB1JXvMoHlagDaC1rM
         tXbQ==
X-Gm-Message-State: AOJu0YyORYT8kmfV3RQpwI2i02HHwbDQ/XcwxGuzb9MIeC601En3H6JD
	JYJXjX/9QFQ5aiCyM3JChSaygwbuQR4Iz5dQVYpH7v3KM62rRTkIMMdm+UREaw==
X-Gm-Gg: AeBDiev5ZSuU5v+B0K4JL/rlrX8d68zzJAAA8R146aCN1D5q647Nv6pFq6OPILRT1V3
	x7cT5omaijDgLhrExCyveo/MJOg6cyMa5Jbl/j19vrdjmMkFlgo92B92RgsvtsYshx5Xy7NXwrc
	6FWWc1yhcaJmeSEYSbzRVc5CgTNnxdccxO60EYh9VjGb9fRZ7qHd6r3+dYdQUwQ03ASwQqAMgRl
	tAd+Tt0ZSY1rLR27BnqawLUVvmA8NcPvrmfpvIPLX3+n+636whLsNK/djV/wiPICtIgsrR/DYLO
	hPBq5kIC0SoffbwNM5YRLq/z/YWatIg0wBfYb1U6jNONbvPfHOVKTHw//rnDIbePLWfupANoIID
	lpeORoGwYSSQEbZ4G+Z+cN8Xhd29oX/GLiUzqGCwaMLmGf1CSR02EMsRKK4NZga8icU8WwKJAgu
	t6lNA+vdhRr0H6dWG5HoxN45kYIqsgqWQkTem94Q==
X-Received: by 2002:a05:620a:470d:b0:8d0:3add:30d8 with SMTP id af79cd13be357-8e792566f53mr4535815385a.52.1777042885433;
        Fri, 24 Apr 2026 08:01:25 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cc559sm1923592385a.13.2026.04.24.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:24 -0700 (PDT)
Message-Id: <3aca302275225d374d33789f56efae47c025bb32.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:14 +0000
Subject: [PATCH 5/8] t5601: restore `.gitconfig` after includeIf test
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

One test in t5601 overwrites `$HOME/.gitconfig` with an `includeIf`
configuration snippet and removes the file in its cleanup. This
destroys the `safe.bareRepository=all` entry that test-lib.sh
writes when `WITH_BREAKING_CHANGES` is in effect, causing later
tests that use `git -C <bare-repo> config` to fail with "not in a
git directory".

Back up `.gitconfig` before overwriting and restore it in the
cleanup, so the global config survives into subsequent tests.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5601-clone.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d743d986c4..3dd229c186 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -813,7 +813,9 @@ test_expect_success 'clone with includeIf' '
 	test_when_finished "rm -rf repo \"$HTTPD_DOCUMENT_ROOT_PATH/repo.git\"" &&
 	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 
-	test_when_finished "rm \"$HOME\"/.gitconfig" &&
+	test_when_finished "cp \"$HOME\"/.gitconfig.bak \
+		\"$HOME\"/.gitconfig 2>/dev/null || rm -f \"$HOME\"/.gitconfig" &&
+	cp "$HOME"/.gitconfig "$HOME"/.gitconfig.bak 2>/dev/null &&
 	cat >"$HOME"/.gitconfig <<-EOF &&
 	[includeIf "onbranch:something"]
 		path = /does/not/exist.inc
-- 
gitgitgadget

