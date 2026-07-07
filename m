Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CBB420887
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443765; cv=none; b=cbuAcBGSLPeTIhQmC937RnHadBn3pO6Ykiiy25XBVsw6nEK6J8Y74t1UXpLlnHiw7TFC4+ti2L1cBTUpQAwRnUtRNm6oXZK9Fqyr8irm1/lNRy4s/bORp3m9Sq23q6irVZtfmRfnfhh/fJT2vQRGa1uOWmaD8gJmbRl9OVVVfqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443765; c=relaxed/simple;
	bh=0iTpiH+GqxosFP1vcOYy9y02k15D3wpUNMZn4KpT9rk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ej5HFn3qosujpA8uQsL3lEEkDrd6D8RC346zvfZlUp5JB/wtdLxqt4HpMrGLYry24BF0vZlYAc2Pf/N2ib2o87JTiuXV2ZglgBEZTMzBFlEJItTNumKCtrdEBOc0kC84kDzEVAMQ7PSh5qU7/chAMG+3CnCM4TUqhz2io8iAKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/WyPrjr; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/WyPrjr"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e602d2c0fso56222585a.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 10:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443763; x=1784048563; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+djyqxJ6HrOAGz2szKTIFezncc7v+/4FZEIriMmSKA=;
        b=g/WyPrjr810hM2vR2xlhIv2g6xWwh0K/MHIm5rdvcpcx85uX11jq6gq7nsi+WjXb7Y
         3zm3GPNHCR4uSSwJvF+ZUrTuyvBGn9c1mWA1wPwdQ25kExle1o35tn0ZBPF5aLcciQBX
         rQqliytE7ANPI2vVFQW2wvWyiL2yStk1MfCJ0gPLkQca9JwQMc3YDqmh/68YHM4iMnDf
         PuPuvuN4gzOR0mpJS5lJIszfFH36vnpZOUOr48tJVbh8MJ6+n+WCRAwJDYVpupWkFXhx
         NRL5KuKq54S6S1JSSuQ2/Rfu2mC9D//ZhzGYiYJp51APAP4zIksJRW9FVGnXcqjafCoF
         HI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443763; x=1784048563;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+djyqxJ6HrOAGz2szKTIFezncc7v+/4FZEIriMmSKA=;
        b=XUloCLb+Ci8AR4vpAV5erI58BEJIlu47l7tnhG9mQfz+JP3/Jm48XBSz+QEPn755U9
         udEx5cJ4mm0RfP9tDMmbCMBwOH08AbNH5DhWemwQq5iRGm6hSiKED/2SgYTm3vP8voq8
         DWimDo0qsTzauexu1aVn5mNKM16lV3/sT/PQ2gaN6iv5Hx8aBKcO3Xvn3Tr0QVm2dAYq
         cAfqaGq+Zb/eiXRfkj+n96pWVInn2890OPAQ1QTtuarXKXehDm715DeSKrs/I/riqYct
         TULBqJOtWye5bhelW4gAIRvsOuJZZ5RUCw9HxfuEWoa8sK4379Fc9yRYClg9exUqUBCJ
         /5iQ==
X-Gm-Message-State: AOJu0Yw5ZzkWkhAobX/iX2MchhZhZbe+Y1Z37raj+KQHRx/t1oGcWMw0
	j60xOQPV7Vq7O0ol5B0zg2eXDjt8Dt8JjHyhtfQogI7dqhtzNOIRD57osEM/1A==
X-Gm-Gg: AfdE7cm0qjWxfoeAA7GcWk67+U821JkB3y3krdMUEbZIZd1SwFOW2KeSPLS5tWXSDmT
	1T5nHTqmP7oev0U0Kvld9MWWENEftGlYaVTw443wLKdi61gaPCkufJyQTLy4L9snDIYGafWnRrw
	jp8fqMzpQYfMm95c+2iUWnmQ/BxUoZKeTDdS0A2vGJRbRXac4v8bZeEL5WtZnPRkl3tY1p2hOyd
	videCleXGjsv9Etw+oGShfrrNpPbhmQDEs7sYIhphZ5kr6bJpqjNryxYOPr88ZfoFDhG+IrTbh8
	Xyl69xJHhwWkmA6NpATeMj1pbdQa12Op8yIUGNshtWoUc61WiqrbgOn6zesNiXhpd9XZwWuW7+L
	hBRhcGbKhG72s5MZGqVn85j9Y1HoP0zOEQOT2LGcYZ4m7wEK5eUaCIHolEKDzrLr8EqOhjkeXop
	mbcBHjdqziGdkz7pE=
X-Received: by 2002:a05:620a:4503:b0:92b:856f:3c14 with SMTP id af79cd13be357-92ec0c7670amr363072185a.11.1783443762606;
        Tue, 07 Jul 2026 10:02:42 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.38])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b800e3sm1177571185a.2.2026.07.07.10.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:02:41 -0700 (PDT)
Message-Id: <8f2bd4b14a3ed796fc58184d305e4b64ca52c9a9.1783443745.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
References: <pull.2288.v6.git.git.1783378333.gitgitgadget@gmail.com>
	<pull.2288.v7.git.git.1783443745.gitgitgadget@gmail.com>
From: "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 07 Jul 2026 17:02:23 +0000
Subject: [PATCH v7 1/3] Makefile: add $(RUST_LIB) prerequisite to osxkeychain
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Shardul Natu <snatu@google.com>,
    Koji Nakamaru <koji.nakamaru@gree.net>,
    Patrick Steinhardt <ps@pks.im>,
    Shardul Natu <shardul.27591@gmail.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Shardul Natu <snatu@google.com>

From: Shardul Natu <snatu@google.com>

When Rust is enabled, the git-credential-osxkeychain helper depends on
Rust symbols compiled into $(RUST_LIB). While commit 522ea8ef7d
("osxkeychain: fix build with Rust") updated the linker command line to
use $(LIBS), it omitted $(RUST_LIB) from the target prerequisite list.
Without this prerequisite, running a parallel build ("make -j") from a
clean working tree can fail because Make does not know to invoke Cargo
to build libgitcore.a before linking git-credential-osxkeychain.

Note that we depend explicitly on $(LIB_FILE) and $(RUST_LIB) rather
than $(GITLIBS). Unlike standard Git builtins and programs like scalar
(which define cmd_main() and rely on common-main.o to supply main()),
git-credential-osxkeychain.c defines its own standalone int main().
If $(GITLIBS) were used, $(filter %.o,$^) in the link recipe would
match both git-credential-osxkeychain.o and common-main.o, causing a
duplicate symbol linking error for _main on macOS.

Additionally, wrap the definitions of $(RUST_LIB) and the "rust" build
target in "ifndef NO_RUST". This ensures that when NO_RUST=1 is
specified, $(RUST_LIB) evaluates to empty, making the Rust dependency a
clean no-op without needing intermediate variables.

Signed-off-by: Shardul Natu <snatu@google.com>
---
 Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..7db38ecce9 100644
--- a/Makefile
+++ b/Makefile
@@ -939,6 +939,7 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 
 LIB_FILE = libgit.a
 
+ifndef NO_RUST
 ifdef DEBUG
 RUST_TARGET_DIR = target/debug
 else
@@ -950,6 +951,7 @@ RUST_LIB = $(RUST_TARGET_DIR)/gitcore.lib
 else
 RUST_LIB = $(RUST_TARGET_DIR)/libgitcore.a
 endif
+endif
 
 GITLIBS = common-main.o $(LIB_FILE)
 EXTLIBS =
@@ -3019,11 +3021,13 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
+ifndef NO_RUST
 $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
 	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
 
 .PHONY: rust
 rust: $(RUST_LIB)
+endif
 
 export DEFAULT_EDITOR DEFAULT_PAGER
 
@@ -4074,7 +4078,8 @@ $(LIBGIT_HIDDEN_EXPORT): $(LIBGIT_PARTIAL_EXPORT)
 contrib/libgit-sys/libgitpub.a: $(LIBGIT_HIDDEN_EXPORT)
 	$(AR) $(ARFLAGS) $@ $^
 
-contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) GIT-LDFLAGS
+# When Rust is enabled, git-credential-osxkeychain depends on Rust symbols in $(RUST_LIB)
+contrib/credential/osxkeychain/git-credential-osxkeychain: contrib/credential/osxkeychain/git-credential-osxkeychain.o $(LIB_FILE) $(RUST_LIB) GIT-LDFLAGS
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS) -framework Security -framework CoreFoundation
 
-- 
gitgitgadget

