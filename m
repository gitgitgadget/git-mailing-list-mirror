Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F63743F091
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277987; cv=none; b=QEEJd6vRnjpX1rElHviKFzX7Asx5QOh0s+GW3Okkyy3XyuEOVF9pQCuTiNdVBCJBmEgKWK0Y5SG6VqatFFlAFoecgOBZNf+2IsBR71FZeEex5JqnPY8No1wpbukZXu+hEB5fe7qJNbWrpq672QEX8GP08E41Pl8F7fMg/8W0Xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277987; c=relaxed/simple;
	bh=hAHdrjEg1clKea0N/leUzT3nk9GNqVy2JgcLWs7b0VQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TxB3KW40VRw3IkwZertvY9fFKJrHltXPKsHqLyOrNpB7amQHGqhAjTNgvp6w3V9Qctxbc7nrd4Yr8Sq9Zz2u2bzbnFUD9Ioll4NQkp7IoYqWJVvbslXseYnzoZLEV+zOrmFxPjBNhMUYvW3lvdb3kqR7UgBf3t99vkDE9oL8hiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5cLuUB4; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5cLuUB4"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso5370019a91.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277986; x=1788882786; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3W5cvt2JobgHGH51oboicjd9ixrG9DhrlblutC0XLEU=;
        b=G5cLuUB48e91ZlJjZWZlFmGonfJljyXRilBuOiWsh/vkiKoKy0lRt3CxKmdFQ2OjKY
         0PSyBsih4Qy4XzZGy6GY8SfW19CouSB2iukL978fevrnZD0bhb/u578SsrlrmDa9jrdV
         Wty2SMPZS1eRU5baLjrJc+ynJpHGY0Dnj175gLYeS2RueGLBvA11if3l2s0hL5H8UtD1
         8albXkALVFK9urKrw1tAAO3lGsGcAMjUlFVvZlfXgJ3smyv/AzNFC2EgIlG987TQMZKl
         bdGwomRdFVA+M9lADY2zb6VfkU0laHmZ92wGX5+zSCNVgMn9f5vIRsTei3W6+Q/lSWDl
         Z+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277986; x=1788882786;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3W5cvt2JobgHGH51oboicjd9ixrG9DhrlblutC0XLEU=;
        b=PaiaC1LUrJDeLfUxfiQ1ZXBpC0BUm3+bDRSmVG08SmwRnxH+cQqCTsGT/yncrCtTUz
         3gDsWPhjAIZg0UrmEQkiD32roTvNumS8g+RjyxiQXHCi24ibTwTQhP3Fdb88KXl31Une
         AcUvwqi8bd97v7IEjXVJI66eo3Yx49uANqseJ12VKPEGx2ko4EWTS64FUXGJkGkeyaLM
         3g7Dy+dHHfKVCI0D3DZPF8WtRfFHmEe9ZpR8REwiL8Kc5j2EfEgydUbvN5L/PbwdjCc7
         ombIjtgNt1YFiQihMIGBpPhwacbeCcG9I1dHMWy0E4WUBM90x6oHM6/qXQJ3oHvSMth5
         9bng==
X-Gm-Message-State: AFuF++nVbdrbp0L+uoCqgRt5vhUk4Q3ZMNPlQp78IZOoYPawweRa3Uu4
	uvSr/g4mnVpKp7MS4jSb08hKpxWoNjFupRQw8Ts0e6VmQBcSsMEpfQD4D73wxw==
X-Gm-Gg: AYBFou0wbVFjC+s9M4iEoy8SX+n6RiVfSKjkmdnCtacZYhkQzlnlA7QR+kD50D+E1n+
	n+ArerLfZOKK2Oyq0t1QkJ4IR+j7AwfNniB2BLV0CZk96cP9Yz12wYgTiCrfy9RdklUcb4iUA0H
	sbEsuKLLfk2SJgltF4IqycYe8pV3GonQoETUPowXx0mHMrgne9nJ30dZ4mVi477y6aMFtOvagmg
	VZVTNvAqo29dc1PhGvbq4bwJKT8rKlFvl8Y0oi9OIWVFiEDu1EnpJsFapHghhKn+oRmhgwB6Oru
	zBG8vUYTbyEaYipsED76rAPQLBXA1anFQF9wHDtVONRFRybDeipe5cRUtBn5HZsMzRhOpqobzT2
	CyNrBzKyFKg4dfd9rdgYZMOeQ5dY0J/PSHSpAo80tSyWRRTkrIuwCeDHUwPX5/HgQ/moz/XRFDL
	yY1drUuQxQNtqarRsTUiyEPQGXHVDLZ+Vq0q8rKcHeQ4rLhGHrwCubunZeWiWx
X-Received: by 2002:a17:90b:1a90:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-396d0f8e80cmr48715354a91.10.1788277985529;
        Tue, 01 Sep 2026 08:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.146])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e41837c6sm34349587c88.11.2026.09.01.08.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:53:04 -0700 (PDT)
Message-Id: <pull.2171.v5.git.1788277983.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 15:53:00 +0000
Subject: [PATCH v5 0/3] t/lib-httpd: make CGI test helpers concurrency-safe
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Michael Montalbo <mmontalbo@gmail.com>

t/lib-httpd.sh provides several helpers that can be invoked concurrently by
Apache while exercising tests. Currently, two of these helpers use state
management logic that fails under certain race conditions.

apply-one-time-script.sh is one of those test helpers. It executes a
"one-time-script" responsible for modifying the response normally returned
by git-http-backend. Sometimes a race between multiple concurrent requests
causes apply-one-time-script.sh to misbehave and return multiple modified
responses or an empty response that results in:

fatal: ... The requested URL returned error: 500 fatal: could not fetch from
promisor remote

This can be seen in the flaky failure of t5616.47 on the macOS CI
runners[1].

Fix this by chaining (&&) the logic for executing "one-time-script" with its
removal, rather than running them as separate actions. Add
t/t5567-one-time-script.sh to verify this fix is effective.

http-429.sh is the other helper whose state management logic can fail under
certain race conditions. However, these failures do not manifest themselves
currently since http-429.sh is invoked sequentially.

As a preventive measure, fix http-429.sh's state management logic so it
relies on an atomic mkdir operation to mark that a 429 was returned rather
than separate "test -f marker", "touch marker", and "rm -f marker" actions
to manage state. http-429.sh is not as straightforward to test as
apply-one-time-script.sh, which is why no regression test was added for the
change.

Finally, document these patterns and anti-patterns in t/lib-httpd.sh for
future developers.

Changes since v4:

 * Reword advice about chaining (&&) atomic operations like rm so it refers
   to chaining with "the logic guarded by the marker" instead of "the logic
   that claims the marker" since the latter is circular and inaccurate
   (atomic operations like rm are the logic that claims markers).

[1]
https://github.com/gitgitgadget/git/actions/runs/28756172690/job/85263916762?pr=2169

Michael Montalbo (3):
  t/lib-httpd: fix apply-one-time-script race under concurrent requests
  t/lib-httpd: make http-429 first-request check atomic
  t/lib-httpd: document writing concurrency-safe CGI helpers

 t/lib-httpd.sh                       | 12 ++++
 t/lib-httpd/apply-one-time-script.sh | 38 +++++++----
 t/lib-httpd/http-429.sh              | 22 +++----
 t/meson.build                        |  1 +
 t/t5567-one-time-script.sh           | 96 ++++++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 26 deletions(-)
 create mode 100755 t/t5567-one-time-script.sh


base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2171%2Fmmontalbo%2Fmm%2Flib-httpd-cgi-safe-proto-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2171/mmontalbo/mm/lib-httpd-cgi-safe-proto-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2171

Range-diff vs v4:

 1:  e202142f19 = 1:  e202142f19 t/lib-httpd: fix apply-one-time-script race under concurrent requests
 2:  79396d491f = 2:  79396d491f t/lib-httpd: make http-429 first-request check atomic
 3:  d8d11ad246 ! 3:  75a184ca09 t/lib-httpd: document writing concurrency-safe CGI helpers
     @@ t/lib-httpd.sh: prepare_httpd() {
      +	#   - use "mkdir dir" to ensure only one request "succeeds" under some
      +	#     condition (see http-429.sh).
      +	#   - chain (&&) atomic operations like "rm marker" (no -f) with the
     -+	#     logic that "claims" the marker instead of relying on a separate
     -+	#     "test -f" and "rm marker" check (see apply-one-time-script.sh).
     ++	#     logic that is guarded by the marker instead of relying on a
     ++	#     separate "test -f" and "rm marker" check
     ++	#     (see apply-one-time-script.sh).
      +	#   - use scratch file names that include the process ID ($$), so
      +	#     concurrent requests do not overwrite each other's state.
       	install_script incomplete-length-upload-pack-v2-http.sh

-- 
gitgitgadget
