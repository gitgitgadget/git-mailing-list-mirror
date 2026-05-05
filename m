Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F823BD06
	for <git@vger.kernel.org>; Tue,  5 May 2026 17:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001981; cv=none; b=iDZE7JSb4t8ox/QRXsJMd1hRNUe6xBpbeNEZdKN84hKqtuQd0wCBhaYRxE2mGR+A/rXLzH+z3YKdXsJj/xoDJ3viMrUxp5UklFnuXUac6IN0eAsYQFbmgueuwQXiwhAul5ipzc8rhf84a6HC6KK5XFFDgSaultpK3A9jfMvxykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001981; c=relaxed/simple;
	bh=SUIrsFO/KcITP/hqG4OAVtX/dXGQGo3kYFYuKAGrHWE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GANhWkeUMzxaUMi6KCJ08NWTrj8mtn+4a24gEvtOwSZj25Ulj8PfM6iq+4WTVud4dHa4P70/PGMHLaClQmQr6oToA2OH1ctViCK1YW3ETRVISVmPZIDFkoMWfT9cWQt1VXwIXSO9UbedyVBZt5DK8yGiSS1DUjablN2VqueWGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rT14P3NY; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rT14P3NY"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c24be9e4bso4794506d50.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 10:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778001978; x=1778606778; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mhYQ3bKe4YAsZHDvj8msTQfUBYH817Z0+3zX9nH3HGE=;
        b=rT14P3NYSvjCOLm64iM/b0FCGUu1/T6gzzgnnXmakOjtRMj4J+QVn7HgScmet6L8GB
         +wprkF84ASjd4fpYU6yYPu4NwrfTSHGEWfcOLbZ9vZapCrAk/Q2As78laqJjOOUJgOq8
         c8dTADr1O2toT6xdRcQvINTaxvpHqIYsLG0fWlPXCNwk1jzgF8Rih1KQopcE1U9Ab4VZ
         PVhsr8LHmQBHyHaOqWgUdnh2JtZzELS1b+lPcdPTXwCyh8icTFkoPoT0Q5kav4GBoSSz
         hG7cUNq5eIWzNeIkECRh70kR3vFIPolg/0qg8XGDLQShXbhq+0UpFmovSiJHzXRuKExC
         l9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001978; x=1778606778;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhYQ3bKe4YAsZHDvj8msTQfUBYH817Z0+3zX9nH3HGE=;
        b=feilmrl621VsubtSEbNtvw9cvLOC2rhVEgzaoxnRXRBEdm1lWzUR9cQCaARrLRNev7
         ICN+7NFh8yTk+Mp52nY+UEzfD685ifd3m4ODss57rCLK5QPJPb7bh1S3i4aBpvRVk4y7
         ZozZuJx9HW9UUb01282b4O2DYSw1Rq8bkgECzY5t1wvd5vNgHF9HVk6IR/8tfoKqfpZy
         amatvLutT44witdb/QmcdiePSan8PzPCfNSl5krEhk0EKXKoJa1lYnccqmie1Ji/hYxw
         ooMWQTRKeKVcWa+21jlyhUvP7I6TvQQ/dfPLjDWadbiB9Ltgxtq4B42SjyZY5XwrZzB5
         vr6w==
X-Gm-Message-State: AOJu0YzSyS2QZOLsv++myAZdmIT5qbe0Uuhwc+fwM3COdpIeMcgDHNIJ
	3vIkx+GAzW6ERqK/gSmSxmSKZUcnTSeUtHEi2ppXkhfzy/UXG9THvW2eEwT3gw==
X-Gm-Gg: AeBDieutPvi+aGSe1UWKJHuZ/gb3PMts0hkovf4VpXxj8xqPdPFeOq41C9BsFIoe9Jt
	BW3Jd77XSZs43i+N6pZv0DQ86fI9h9g3rYv9BO2L6ONy9Me6f5kNXlf4cA0/Z3IvLqg39IG+eMu
	k3QfUQH26uGauFDh8/shBbv/lnudP78+y8xI0H8zBCG6yXjNmNgk+skHIASrzlnaCkoRD+FjmO6
	+0jAFdihOyyFTJvYkUWjxF45zYrVwtC/L0ME60nGQ74EQiUp3vMM6TE1Pa2fWid1ua1SwK53ULh
	4A5WQaiEim/u7YnFEAAkLV26q4UmlbnpGuNYtm0vabKNNHeEWWCXO7K5aV0MQcSwsOyEkB9rWWF
	eJqRgnqjmbDl0/08W8+AhKibWIQV0UHEPMsDKyg6DYYxDMcArSS+OM6Z6XFm929CSdk65kKn3HV
	LuoSFwS0Yp9fbbogQOu0T0CQ/matw3iYs1Y78Kjg==
X-Received: by 2002:a05:690e:210e:b0:64f:fc0d:624b with SMTP id 956f58d0204a3-65c799da7admr159289d50.56.1778001978263;
        Tue, 05 May 2026 10:26:18 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.195])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2dc81614sm7425318d50.0.2026.05.05.10.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:26:17 -0700 (PDT)
Message-Id: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 May 2026 17:26:16 +0000
Subject: [PATCH] Makefile: link osxkeychain helper against Rust
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
Cc: Shnatu <snatu@google.com>

From: Shnatu <snatu@google.com>

When Rust is enabled, ensure that the git-credential-osxkeychain
helper is linked with the necessary Rust libraries.

Introduce the RUST_LIBS variable inside ifndef NO_RUST block
to hold the Rust library dependency, and use it in the helper's
build target. This cleanly handles cases where Rust is disabled,
making it a no-op and avoiding any build failures on systems
without Cargo.

This addresses reviewer feedback from internal CL 910223487
by simplifying the variables and avoiding confusing "LINK"
terminology.

Signed-off-by: Shnatu <snatu@google.com>
---
    Makefile: link osxkeychain helper against Rust

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2288%2Fkiranani%2Fnext-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2288/kiranani/next-v1
Pull-Request: https://github.com/git/git/pull/2288

 Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f86173f93a..a17dca22b1 100644
--- a/Makefile
+++ b/Makefile
@@ -1593,6 +1593,7 @@ ALL_LDFLAGS = $(LDFLAGS) $(LDFLAGS_APPEND)
 ifndef NO_RUST
 BASIC_CFLAGS += -DWITH_RUST
 GITLIBS += $(RUST_LIB)
+RUST_LIBS = $(RUST_LIB)
 ifeq ($(uname_S),Windows)
 EXTLIBS += -luserenv
 endif
@@ -4082,9 +4083,9 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
 
-contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIBS) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
-		$(filter %.o,$^) $(LIB_FILE) $(EXTLIBS) -framework Security -framework CoreFoundation
+		$(filter %.o,$^) $(LIB_FILE) $(RUST_LIBS) $(EXTLIBS) -framework Security -framework CoreFoundation
 
 contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
 	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

base-commit: 4f69b47b940100b02630f745a52f9d9850f122b2
-- 
gitgitgadget
