Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104850;
	b=XdF4wCqYwuzOMuY8105q4vxnhni8EofuT4DzvkGe9yaCjqnZGQkPhrm6CGqfmEGRIMGR
	 lN95PpWnx+ulm0fRq9eGoufLjj3VQX6ii9q+3ZGIcGAKVjijfISbVwQ+Wknd733twkc5O
	 aeiCCjsDMkQyMaR+IngQfKOHYk4cuvv/roAyNq1i5164JiRR6QwQ1LXd+VryMqvQSCY60
	 AvDNSqxqqcrk+S32tjRvSJDdK2K+k3EvmQE85fZekDqlb8UZMBfMJRwpSLG5lDQV4LpXD
	 3mJx9fqcBO4FTUHO+Tuyk6SmQ0cHi/sZjwGOrCIe+T/rtjcJbsPGCM1ghMzm/PAWa6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=sDPzLeZgImJa3JWZiQBkrznUV0tsj3p3vrB9W3TZgAY=;
	b=HHmKKmbwhOS4HgGMC3gZQ3WinIBNTQTseKWv6pt3eczQv+tFBw3OWZjP7gTzt8I/w9Mp
	 MW1D/xIeSu2ssNOCflPeLt0ctWvvRqCx+9hOKf1jAMIE1ei4TZtZBe7ZClD57nOiisXM9
	 L7vMnfmwa2YiCdoy0sg9AQD44H5TkXRhYbAsILln2J1/dizwIHr6f/WS2T4i/I42RfXo0
	 pWVm2GJIPamHOFg4zIGOXjQhwkfWuUmIwe9MSEOhhfQta1xf21kVMBtxfGr2nBIUrm1Fy
	 mw5sOibQszvtYh1wzI9J6yFhKqHRV/exJhqNwt4HbbnVsMhDDqukw3ZKNnrTw8P+iIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZizTJcJM;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DCC606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DCC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZizTJcJM
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c75be77c4so4113886d6.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793104848; x=1793709648; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sDPzLeZgImJa3JWZiQBkrznUV0tsj3p3vrB9W3TZgAY=;
        b=ZizTJcJMR53WX96brthJ/0fvKiyobmB5qVfVN6gZFGIu8nDfH8W3B8jRly2FH/tmTD
         0Q/T3c84iRS2YaJG3IxCZlXVNLKPmr1f0xEyDiJ9m8VYYFkS9X2g51HhZN3ka7NiFCXB
         zc18YrPrsitPw0yg6j1xn9lTWk8LWgJdDHNkNnGKpP/zp2QSl+Qqbax2vur3tOq9rRvU
         2f+uAJYcA9XUtczs45Q12j7YMOnK0DNoPLKbrhYLQnGAlf0uOriFII5mxPIStm3VVxbb
         51ZD3/4r7t7eXoOJ291lcQSK8p6ICC8RiZcewoqXdV7CvUgpTY1f+SMRr9uE2KRxSJba
         7dLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793104848; x=1793709648;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sDPzLeZgImJa3JWZiQBkrznUV0tsj3p3vrB9W3TZgAY=;
        b=KLdt77rBy9YVl7tgLgPmwZp7M7j1Tec/8DZqKw4NyWMIoZfZVT/tmIOOCZ+lwYLNL/
         qQHvwRYOKK+a3gAfWejbM2ppAAkxT4WssSYjfmnm22nA48ncVbJeg++2aSKK0pXlJ4fO
         Kbf4cR0AP8zkoLkBfbAr3ZXeYHyRkrwNQHyM5nTLf+F4UUT6IBd9yDj13PFhTcgoXYrw
         9HrMAdsrh44VE1R9ufmMKacZq7GgOMgfEO6B5+5Phrjuemre+oUaejkMZ4tG19ZpyE8J
         uVQ94/glEqgKp11jXErPAtUlZEJbpKB/RjKZCNyGY6YzZV2Ob3NXM/cW39lgP1tDBVC5
         HVgw==
X-Gm-Message-State: AFq9FYJDKIbaOzdu6ZpMyOsAY2xBggVXdmqIc+RX3J8+v1FiKaOqiDi3
	+id37XQOxHUFfEMSZdQVAb82MfYgHaWnWsEn8y+lB2lKHeTlyw4mIDgNg1BML53mBz8=
X-Gm-Gg: AYBFou1tyJQY2jRyO9a5XiaKw+TOjw/s9RdeNNI2rQw8hSr5W1lPrPI1Edkbpwup7Oe
	bbBUCECujpcnnV7TAFgB9hvWc2KCyAZkmBk1f8HO2T4SM16TPrDxDB0/nSsF1SRpU9718d5d100
	am7Hju1Lohm6AzA9T8mHCi2xgRxyR4n4HyHGYUm76JSfCCsA8e9xbznBnC9HNC0sBmsa60E44fq
	bmA239BvvcoivcPN5bTSH3pk/a25BI5g3LVckL8QYJLmgJkBi5urxi+gTDb8MM43zI6fZ0ZIY8z
	iVDoVrzC60qMcSTb+82wLaaM5ETLenOjlbnoPPBzcx7kmC0NAGw+h1iuR3ygb7OIRRuIvF1GFaO
	G+O6oxQpnDqoW6PbSVGe52414O73Xb20zHc5+pfV1e0yKqVp17vQl0xG8zbIjR19wdPZaAaYFBX
	x/P7aOB9ySy7wBg1NVwAbqkNq/Y7p8woGHrVfO09jnm++aCJhDi/iQLshmgD3DZW13EpG1C77cx
	BIGkikhtHT6HFi7haaLWS5mFvOJbt2T6J8dmvpYKRMydi22/uOV9k6Vor3OOHhAbZqIQBK8YzQj
	Rl8VS8Z7F1ccuWwQFBVDhdFiXezAnkk1Fg==
X-Received: by 2002:a05:6214:27e5:b0:917:a041:2dd3 with SMTP id 6a1803df08f44-91c48e85ec2mr168906036d6.43.1793104848227;
        Tue, 27 Oct 2026 05:40:48 -0700 (PDT)
Received: from [127.0.0.1] ([52.151.198.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c6f3bcsm104252536d6.29.2026.10.27.05.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 05:40:47 -0700 (PDT)
Message-Id: <pull.2464.git.git.1793104847288.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 12:40:47 +0000
Subject: [PATCH] Makefile: let ccache cache objects built with the precompiled
 header
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Since 8d3a673147 (Makefile: precompile "git-compat-util.h",
2026-09-15), rebuilding Git with ccache is almost as slow as building
it without. ccache refuses to cache a compilation that uses a
precompiled header unless its "pch_defines" and "time_macros"
sloppiness is enabled, so it runs the compiler for nearly every object
file, even after a "make clean" in a tree it has already built.

Both settings are safe for our build. The precompiled header is only
pulled in with "-include" ahead of the source file, so no "#define" in
a source file can come before it, and none of our sources use
__DATE__, __TIME__ or __TIMESTAMP__.

Enable them for the precompiled header and the objects built with it.
On my machine, "make clean && make -j8" with a warm cache goes from
about 100 seconds to under 30.

With Clang, switching to a branch that changes one of the headers the
precompiled header includes and back again still misses the cache,
because Clang records the modification times of those headers in the
precompiled header.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    Makefile: let ccache cache objects built with the precompiled header
    
    With ccache, building after switching between two feature branches gets
    about 6 times faster. The first build of each branch gets about 25%
    slower while ccache fills its cache.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2464%2FHaraldNordgren%2Fmakefile-ccache-pch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2464/HaraldNordgren/makefile-ccache-pch-v1
Pull-Request: https://github.com/git/git/pull/2464

 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index a96be506b5..43ea5e0c40 100644
--- a/Makefile
+++ b/Makefile
@@ -2946,6 +2946,8 @@ $(PRECOMPILED_HEADER_GCH): %.gch: % GIT-CFLAGS $(missing_dep_dirs) $(missing_com
 $(PRECOMPILED_HEADER_USERS): %.o: %.c $(PRECOMPILED_HEADER_GCH) GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c -include $(PRECOMPILED_HEADER) -Winvalid-pch $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 
+$(PRECOMPILED_HEADER_GCH) $(PRECOMPILED_HEADER_USERS): export CCACHE_SLOPPINESS += pch_defines,time_macros
+
 $(filter-out $(PRECOMPILED_HEADER_USERS),$(OBJECTS)): %.o: %.c GIT-CFLAGS $(missing_dep_dirs) $(missing_compdb_dir)
 	$(QUIET_CC)$(CC) -o $*.o -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<
 

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
