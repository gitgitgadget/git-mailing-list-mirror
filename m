Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E618018DB1E
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275033; cv=none; b=iYI8mY/iCNiLK0UyQB2Hre+0y5RgBTl7lb3tVuXPyTLXtCrUhzRS3Vl2bODXO9DxbuVWzW+TXVADQbsg8ndOh/An40tyuB+uTpJolgqIE2QzcM32pq+xezWUR76rWX0uQ5LpEzuIlY93ZNyEZbbJibQmC35M7HLKs9kc83PaOV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275033; c=relaxed/simple;
	bh=7dTn310qKzY3WLw9wbBldeL9I4gLjyluFYKpKPMP9oY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RtBlKjRgeo4ZwHAfW8W0dwldf2CxUVYumyWVzKvFrL4ar1jPSOdnGbr+eUFYsm7xvFJJ6337e1SweNehPlfbNBMfHv+I9t6dxud0aCrNx+uYr6y2pZEUSZM2YVSeq36H+KjX31tQYrD8rg2kP59mLaP6QowyM66+YLFL9pfVtrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WINlwpkj; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WINlwpkj"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e4ce6e3b8cso1386704a12.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 07:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741275030; x=1741879830; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHnJ2mD8p6o7MwWGVMsZCHYJQs1xWAxX/Qg2N4kftKE=;
        b=WINlwpkj81P/usJj3dV/RLErvnFgGu9el/NhWzVxhPLMc6oz2HJ5oe0b9AlGBKd4/S
         xfdrfjzsxheLOXqr+j5MLS4swlSGCh/j9Zhmyd2H5Vxbb1J5iymRdGK2rCWYi+OKRjHv
         6iMztae8J0RptdH4sOeYBi+8wC6JBNgqbarctxqS9nM1uXk1JdDNxYPoTYPCewwyeVD5
         bmwVKRvPgRBN6LONuqvyJU7Cz5PIX3nIx35ZFvRPFuuZ00jVWqk5k1X2yp5ZFA45quvk
         /L1/M1ZbLUY5H3zgpqsLYuRbNRb5siHrrYmkBFmzhv/mg2FtjKdpmjp69CEr2euTX4Ou
         G4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741275030; x=1741879830;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BHnJ2mD8p6o7MwWGVMsZCHYJQs1xWAxX/Qg2N4kftKE=;
        b=DIBZGTGr61tSxwF/vlZCJnS6JDePK/x7PpXYPRML9wWhw8FxJUOJ5DSkwDU4K8d2X7
         ra8GG4l16L6V/FuRMrVnVS1tR9A07Jroq2bqj0ynuF4Na7eDfVePCxNdG7wnKftzPmma
         fPCboWyTPsFn+HFLsMN7Uj9ZuolHuAv4SbE59RoRdkDZrdcpXivHfXNdrkXQm4vxrAYh
         btVbo5SBrHwhpGQiOpVqWP6bnzpXLd3FZ5XBPdGRt1xXx+5v64hdkw/Go/MgyHFJak8w
         Yx2p0FzT9rOP9jNOyUq/ymzVXBPWwhyjRnfk56kB6b19nYKy694He3JJFmFnEIOFJJjp
         UMDg==
X-Gm-Message-State: AOJu0Yxvse/bG0jxU06gAFgeUvxjoWwCz7RXDybieN/RuTTGqHGfGpxt
	MiAtEPOq9CPwTFU2Du9liqmwweedbae7beRQKEmbboS0zXDiENg7dT3cXA==
X-Gm-Gg: ASbGncuI7eY00RpB3x7tuv60uhNaLJ6VQsM+F3k3vD/bGOvLEvF4/m2krQGXxltswBQ
	Y1hEEDY20poe2ZphPmCedxWaZ34X7HQFqKEKBurfO7bvRiWEcdZJPxyE7gOXB5fJJv/OxdoRUa/
	28wVbfyt4AemQT53x5q66tWiymJGOho4xrg9y/lYfZURUksXO3RhTORCmGJ6oaN7zOXfiBXFFYA
	iwbk8skbrphperphksoxwImFeiyyjHkBysQ6Tsm72e/EQee8PvpmxxD7ru7GFR9mlN24w6E37Vy
	BZIFI+fm4PV590j/Oqxhwm70dEVeaRuWjuyH5jMS7UYc2A==
X-Google-Smtp-Source: AGHT+IGd5iVwJQHlhcn3SSufX0c6M0rGb9iYxViWsly57PadIT73nxo1atHEjHpORkp95VP+a6xWTw==
X-Received: by 2002:a05:6402:40c9:b0:5e4:d52b:78a2 with SMTP id 4fb4d7f45d1cf-5e5c1b973f3mr3416167a12.15.1741275029517;
        Thu, 06 Mar 2025 07:30:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a960esm1112300a12.45.2025.03.06.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:30:29 -0800 (PST)
Message-Id: <69da363cab9127cbe4fe6843c49c1a41ba9d4521.1741275027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
References: <pull.1873.git.1741275027.gitgitgadget@gmail.com>
From: "Dmitry Goncharov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 15:30:26 +0000
Subject: [PATCH 1/2] t6423: add a testcase causing a failed assertion in
 process_renames
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
Cc: Dmitry Goncharov <dgoncharov@users.sf.net>,
    Elijah Newren <newren@gmail.com>,
    Dmitry Goncharov <dgoncharov@users.sf.net>

From: Dmitry Goncharov <dgoncharov@users.sf.net>

If one side of history renames a directory A/ -> B/, and the other side
of history adds new files to A/, then directory rename detection notices
and moves or suggests moving those new files to B/.  A similar thing is
done for paths renamed into A/, causing them to be transitively renamed
into B/.  But, if the file originally came from B/, then this can end up
causing a file to be renamed back to itself.  merge-ort crashes under
this special case, due to a slightly overzealous assertion:

    git: merge-ort.c:3051: process_renames: Assertion `source_deleted || oldinfo->filemask & old_sidemask' failed.
    Aborted (core dumped)

Add a testcase demonstrating this.

Signed-off-by: Dmitry Goncharov <dgoncharov@users.sf.net>
[en: Instead of adding a new testsuite, place it near similar tests in
 t6423, adjusting to match the style of those tests.  Tweak the commit
 message to not repeat the entire testcase, but just describe the bug.
 Also update the line number in the error message.]
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 41 +++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 88d1cf2cde9..259ee9628e4 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5360,6 +5360,47 @@ test_expect_merge_algorithm failure success '12m: Change parent of renamed-dir t
 	)
 '
 
+test_setup_12n () {
+	git init 12n &&
+	(
+		cd 12n &&
+
+		mkdir tools &&
+		echo hello >tools/hello &&
+		git add tools/hello &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		echo world >world &&
+		git add world &&
+		git commit -q world -m 'Add world' &&
+
+		git mv world tools/world &&
+		git commit -m "Move world into tools/" &&
+
+		git switch B &&
+		git mv tools/hello hello &&
+		git commit -m "Move hello from tools/ to toplevel"
+	)
+}
+
+test_expect_failure '12n: Directory rename transitively makes rename back to self' '
+	test_setup_12n &&
+	(
+		cd 12n &&
+
+		git checkout -q B^0 &&
+
+		test_must_fail git cherry-pick A^0 >out &&
+		grep "CONFLICT (file location).*should perhaps be moved" out
+	)
+'
+
+
 ###########################################################################
 # SECTION 13: Checking informational and conflict messages
 #
-- 
gitgitgadget

