Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD7E280035
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042884; cv=none; b=rdroFYpstVlBt28j52CJLyN65B0nr7T4zNj+W78vnrUanhEFUlYZwlRl+iZA3qIawQxV4y9hpUP+WQ0PHurdj4SCqdz6pMAEc+7cvBM8FGKIBijaMdlb5NzGzEaT0wpc8oQfUCEQaqC2ZwJdu7yquIlJJbDkc3Hxhv+fAriFj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042884; c=relaxed/simple;
	bh=rmu5z5V2euAn5gbTTKB8XTD3b9nAO5wjFHJmTRkR1rg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pMkDv9swhsz/QW6f9liHnURSFlkbvlDW+s1l/UKFh1AxXeLy0d5+0rcDiA9qN/G7aUt8knSc33jBQGcrQHLFXj5s1CE7izGpcuOBcxBQAvukwL2aeDtxfiv+sLVPnCIZBXv8+O6IAlWP3CnoPBkucH2zsgZrtVfL08dK+Hng/vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQOptvkB; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQOptvkB"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94e578a0fa5so3664624241.0
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042882; x=1777647682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRAPcRPjEztK44f727GGVSrCN3tTUQZWyM8FSGsNS6I=;
        b=dQOptvkB1mTVfzwbC7GesPDv8MPf4cIUa24J0mN00JLCFhq8FCSFHkTufUORoFAfqy
         ciS3i32rgZrgntguqD+VjZsFUW4CKX+XxPLPzfvPhGGK5jJqBcMZooLuLgqHzrZJFH8G
         4SroxWzs8s3KsIz+eJ2/N4Xgg672F4gACOwXHX86Zsd6r1NXqru7IvDVUdYisssxaPDB
         IVv5VOO+50KHoUJHp9XTH0Uu1OqpnJL5uP3ccFYNqrctRB81Hv9Hq0UUbV10RJDPv84R
         VrFUGymnsZ3CObvRswodymxgUCwiTzJG4kZ42wzIMHJAr1pvAFUAf68fB3s2/xxFeD6z
         ehtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042882; x=1777647682;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRAPcRPjEztK44f727GGVSrCN3tTUQZWyM8FSGsNS6I=;
        b=icRiTXsW4mBHx1JQkqsP3xyrVWo4E9Z2AqidpXmyuAPX6qF2VUTF4b655GgG1kqqor
         h/pptQ1wnWB/3Fczac9FdXRGbNsBzZ3D2l7bzcphyUkqVxDy4eEpI7HZKmqTTtqD0ZHd
         Ehlm1a3yzDkceyl2Ip+l6UTkoUQvPDXPJbIb0DRwXMvz3xvgSicMwlEOI3Wh5WwI6xFx
         jYgoqTBpQqi0i0x1sFexP7ESZapuU8pDxgTGqz4TYSGXtNFk4u7KmKVP7wa6iLGsh4+e
         NfiLxVtDRxuMIPAQcMrg4QwX6gU4ioVcxgSHMfKWls7TgBIZ/tIo4vml2HDVaHefVjR/
         w9xg==
X-Gm-Message-State: AOJu0YzOZH9ICBxdiJsmTvblI6BZbyHfaJjDPt5u9rB4P5IOMnAaKCE1
	DNgMSrUZdI8kCq7jFtuq0dzdJmo0Rj4tcUBTGkTgdl9xe9/wKySkVsPQobgC/g==
X-Gm-Gg: AeBDievNIe+hlOvKI8AuL1eYktb9yrDUKkUTaj0JKUof32TGqO4hTgKfGdIFntPba9H
	qUmy2p8iA8FQvn6Om4e4ZAI2kCBywnvGnN5ncwN/IKAmg18Tm9wgXECAJxARSuuOWdpQQcCC9bH
	gSMpC6mqeLfLERS6dduBWVqA5uFNPsgNlEocO4wz+VQ8bN6iHY1aGqXy8RxOLZq4yyjVumwl0Kz
	u59+4qjsumQrFQ3/09dPqiYlYF7AKz0TIq5pwB1Wy62Zl2tsBeuKjKIG5STvBq/cqiCBYgPdu0Y
	5QOyPTs+jbCD+LvbVdOhopm5fkMdTBKs3YoymNSuYILJCjK1sHKrSS8NXQJf7yLvwJ2M5kfSPHp
	O1Cn8FvZEjTuJPaVgpSyfq7v5+nS6C7QwLZ5ENNkRTHfkWwdXUOcFc/NRgG6iWmn4+bJ0AbDA/P
	NdsvxJ/M3yD4CwCtHIYtTDBRCn/ZZwUfzDzv/rLQ==
X-Received: by 2002:a05:6102:5123:b0:607:a151:d5a with SMTP id ada2fe7eead31-616f45351ddmr17961100137.6.1777042880289;
        Fri, 24 Apr 2026 08:01:20 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.133])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb9becc72dsm1485581885a.34.2026.04.24.08.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:01:19 -0700 (PDT)
Message-Id: <62707b410977af2c80d98306455aaec55499f606.1777042877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 15:01:10 +0000
Subject: [PATCH 1/8] test-lib: allow bare repository access when breaking
 changes are enabled
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

A future patch will change the `safe.bareRepository` default from
`all` to `explicit` under `WITH_BREAKING_CHANGES`. At that point,
every test that operates on a bare repository through implicit
discovery would fail, regardless of whether the test is actually
about discovery or about how a specific command behaves once inside
a bare repository.

The maintainer suggested [1] setting `safe.bareRepository=all` in
the test environment's global config whenever `WITH_BREAKING_CHANGES`
is in effect, rather than adjusting each affected test to access
bare repositories explicitly (via `--git-dir`, `GIT_DIR`, or
similar). This means the test suite continues to exercise only the
historical default behavior even after the user-facing default
changes, relying on a small number of dedicated tests in t0035 to
validate the new, stricter default.

Since `$HOME` points at the trash directory (which doubles as the
test repository's working tree), writing to `$HOME/.gitconfig` also
creates a file inside the working tree. Exclude it via
`.git/info/exclude` to limit the fallout, though this does not
help tests that use `git ls-files --others` without
`--exclude-standard` or `git status --ignored`; those are addressed
by subsequent commits.

[1] https://lore.kernel.org/git/xmqqse98cc51.fsf@gitster.g/

Original-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 70fd3e9baf..b8726f4647 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1597,6 +1597,12 @@ cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
 TRASH_DIRECTORY=$(pwd)
 HOME="$TRASH_DIRECTORY"
 
+if test -n "$WITH_BREAKING_CHANGES"
+then
+	git config --global safe.bareRepository all &&
+	echo "/.gitconfig" >>.git/info/exclude
+fi
+
 start_test_output "$0"
 
 # Convenience
-- 
gitgitgadget

