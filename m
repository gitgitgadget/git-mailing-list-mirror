Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23068369233
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 18:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766168174; cv=none; b=c/ktRhYfwyC/chiMQ4m5cdDwbFRwiW4fRfh6ZmUn6xexUfXb4/pMzjaDXoiqMZhNuwBV9G64KXz6bnLZvLaSDMkPpyhCjX/lRUzX5990jtKkcv+AdGuH32PxppBXZ4oaGYFy6uNQy6LO/kFIacnfDt99dATZPobe5BeK5bU7WxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766168174; c=relaxed/simple;
	bh=teTTwKs2CvqoAmV1K04hK2D7cOWR2hjeMAniVAxgmKQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=caL2c4kmQtSTArOwg4VAJZHwRWSqDhMEBCsECN34j5eCIpgYSO5l6cGlfkA/dfpBpRcKSUFlWYfbHdAIUw7NqXBZeIZ6aJhY9LQq3hZBkPI1vJbYjkmfKmvS4IZEAC7GSOuBApK1z4tyx7mfG8DhWmURg36Mrggc77xfLa5jnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbxdwrN/; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbxdwrN/"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c363eb612so1985201a91.0
        for <git@vger.kernel.org>; Fri, 19 Dec 2025 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766168172; x=1766772972; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdOaoSl0vd67O4Ebe7PsCR+Zi5E4o1q8BPuhxXCgUi0=;
        b=HbxdwrN/OzRfFOjzpuooBv+sP45XyfjmVhhjkfa/BLxl+5KRCxHigO9Td1TjNzdSTM
         kToX7jFvVScqpB1DYVzpJWsOG7HQQW74UG4a7XmPdeNX8uFA1YoMp9i2kHT5IBQc/eN3
         tlcYEVcJZYA/1qphBTkFZqgz1P6A7/rOqogehsYbOuOGIbmepBH+BdzNYKWSEbPhfkgH
         NCGmlU6rt9/jlO60Z41rz5DBWhwcXyZhG9xIV0Iq7pKGLd6lhGKrxjFSZ/lJgBc54k2H
         3RyBjwukmCN4xiUKdW2NYcEn/mgIoUjxJ+8SX/QRnZErOqwOIokVmVPtaP4DpZrFJ28H
         BwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766168172; x=1766772972;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SdOaoSl0vd67O4Ebe7PsCR+Zi5E4o1q8BPuhxXCgUi0=;
        b=XnCaOkJfzcq74N6uBvPvtwlUK31YCcU8OviKO5YfaOKgr4d4C4tr/sLdPatxtYtchX
         DfYtMbrzp7hVNRTFeW1c8bqSKHJICBnaLd+dxZxFGUp52uQemidPRdis0tA54jeOC7rM
         HVEAXKW9V0PKk3QnziQSAgon4LCL6E90UWz4aHic/IQLHqMqA2ihBOLjXh8NKNV6UhQx
         d3MuKoL/GGrdMU0PcQFIu68xI4IvNwleBg3YeJxu+nmfQnPhzrd5CQbfeR+WI8BmSzpT
         FFkG/HBik/eLAPLIi7sqD5dlXEWrDaGbeCiCCIrQUTDDo0bdrcC2GzbPUS86+US3j0MD
         vQCg==
X-Gm-Message-State: AOJu0YwtZgLXG2/jPFzQ6lw4Kds632QVc/ZCsRXU5RJdc5wx8bJWSQvP
	uQkwTJB8I/rVWRzx7ah4fR+o62wRtmhtL+gRXcu/wWy8MvGOL641IU26ezA5rw==
X-Gm-Gg: AY/fxX4fanUzhwneI19Vg0z3oB1mgcXaPvCq6nzDdDAo1g2saaQVoFq6RVkrG33u6z3
	yEHKkzkLqvAR+dAdmAHXvRbbizAxwo/8GtYiXuwuEr8YTkj/M4hpqKdvTc8mY6vZeNW7VfOVaLa
	qR/4M54DBwcSDL7Zdz9AFcnuEaoFduEDPj3mIP16vGPVqSTL2PeXK0tHb2aOHLnf85OkDjKM4Hd
	fT5dUgZcAJ+qfpJ10SdLX3j1unobnIxNcTP7/OJuyUcHpnNwoMe4L/cOHFfNVG7NPFrD2mwKIyn
	Cjh0RymfkkzGbfYTrcPNYpdnKvli4OYxF9CUYERHpOqEUkV89aHOuU8Qw2uuN0SwtzWHXSizzn3
	ovIyxycAUO2kZlpvI1zIxZ6De4mGoyI+hnkG0ZcDw91IYsS9bd7Vr/w4LtAXxi4ktECj0bt5/aj
	aG1tf00Sixw0UJUj99V5gv5VEJcA==
X-Google-Smtp-Source: AGHT+IFOqeWq2JamXxKeiFGX43rjfGBfLJXy3Oa1DhajXjSZyHI3kz2KmM+KGkgidEPe0MtiVjWwMQ==
X-Received: by 2002:a17:90b:288d:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-34e921c2e3cmr2976369a91.23.1766168171686;
        Fri, 19 Dec 2025 10:16:11 -0800 (PST)
Received: from [127.0.0.1] ([172.184.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223ae29sm2906336a91.16.2025.12.19.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 10:16:11 -0800 (PST)
Message-Id: <ddd4191ecb391e10bf4b123f699384a3d609b4a8.1766168169.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
References: <pull.2135.git.git.1766156407442.gitgitgadget@gmail.com>
	<pull.2135.v2.git.git.1766168169.gitgitgadget@gmail.com>
From: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Dec 2025 18:16:08 +0000
Subject: [PATCH v2 1/2] worktree: clarify --expire applies to missing
 worktrees
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Sam Bostock <sam.bostock@shopify.com>,
    Sam Bostock <sam.bostock@shopify.com>

From: Sam Bostock <sam.bostock@shopify.com>

The `--expire` option for `git worktree list` and `git worktree prune`
only affects worktrees whose working directory path no longer exists.
The help text did not make this clear, and the documentation
inconsistently used "unused" for prune but "missing" for list.

This updates the help text and documentation to consistently describe
these as "missing worktrees".

Signed-off-by: Sam Bostock <sam@sambostock.ca>
---
 Documentation/git-worktree.adoc | 2 +-
 builtin/worktree.c              | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index f272f79783..402d363064 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -271,7 +271,7 @@ mismatch, even if the links are correct.
 With `list`, output additional information about worktrees (see below).
 
 `--expire <time>`::
-	With `prune`, only expire unused worktrees older than _<time>_.
+	With `prune`, only expire missing worktrees older than _<time>_.
 +
 With `list`, annotate missing worktrees as prunable if they are older than
 _<time>_.
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..82fcbfeccf 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -252,7 +252,7 @@ static int prune(int ac, const char **av, const char *prefix,
 		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
 		OPT__VERBOSE(&verbose, N_("report pruned working trees")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("expire working trees older than <time>")),
+				N_("expire missing working trees older than <time>")),
 		OPT_END()
 	};
 
@@ -1070,7 +1070,7 @@ static int list(int ac, const char **av, const char *prefix,
 		OPT_BOOL(0, "porcelain", &porcelain, N_("machine-readable output")),
 		OPT__VERBOSE(&verbose, N_("show extended annotations and reasons, if available")),
 		OPT_EXPIRY_DATE(0, "expire", &expire,
-				N_("add 'prunable' annotation to worktrees older than <time>")),
+				N_("add 'prunable' annotation to missing worktrees older than <time>")),
 		OPT_SET_INT('z', NULL, &line_terminator,
 			    N_("terminate records with a NUL character"), '\0'),
 		OPT_END()
-- 
gitgitgadget

