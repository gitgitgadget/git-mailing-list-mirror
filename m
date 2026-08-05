Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EAA37FF5A
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785939898; cv=none; b=Ihz2kmEoKi+JiprRxKEVm0KbOei9F4YsYXhq3QLPdrRqc9cBz0WiHmDp97PmO6ymmH/vPbsH7zX+pqFKIfB/u2rBQtD2qC02VEFM59vNEHngwY3QRHYYUbU8ritUlb8glbYrTaHD8LrsKYs9kEB2ESHgDOqbhhVLNkhwXDn6UrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785939898; c=relaxed/simple;
	bh=MpDB3cqFH+hwVAGsX+VKTrMzuXGx2I/ztAK6r3FvVQE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gXQFeDkK8k07UUit4xkgDSdcHDMldzl7a7xeyidkhDTQwE8UA3BlNzBr4Na7MmmdgjU2T/vHd7iOvOjPxAFwm7irurL8Tr2S+gXKsoHyPE+KTQRLA6ydcSCcbG+k2kCxlLZ0h4lo8UrpYI5YGLYo/LTpd6s9iMAf39cK/Z3xCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvk6WqIe; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvk6WqIe"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so1013567b3a.3
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785939885; x=1786544685; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mcF/+heMd1JhSstuSajEvhhfEk3Y70H/0lW5l+AemvQ=;
        b=kvk6WqIe54mg1Q4PmrFltjQfH11jSM2V7FfBjpSeXCgzV3o4g8EbIlZgubqs7NWQrL
         aD3oYwqDWKcUNlc73gVJu3sIu1fnX4PpwWjBNzF7/OK0SuONofzEsZIhNbVOby9ySCfG
         tkYhNEYUT5C3yBjuu0ro4MjWlpd1GcSTZOeOH+1vZQyfq2Ckrtt9dEG73g4HKhKulnI6
         EmyprusbnAFCQ/FPNNRVdSggYAoHhAJ7dAasvqlN3axllT6IG36xvzjeMfYeaTNYDlA0
         vbkd2uyte3dixo/tcAAVMJpQl3IM+4mdR7TMlWmjUDMBpDt2KRZ3soASQ3RUdl1C4X9U
         8bUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785939885; x=1786544685;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mcF/+heMd1JhSstuSajEvhhfEk3Y70H/0lW5l+AemvQ=;
        b=CFAt0669eQXzgxAA6NYfEjURy5ISZhww5kIq/rEzkFSXLu5xeYCCqaOk1zap2Dho6n
         EE3dmWFnbY5t3j9jNfgjOnadbqvouUNzSeblry3NORSy/85JNXV3EiD7qEwh1YMNC+ej
         7cUyY4/95P2B5+F8kisrU04PahMoGQZ7735OpaD8OAdMADSkGjHL+mw+kpvjY2Agm1cC
         XnTFiHmKK2a2u8Jx6KYNS9CTa1RCdonw8EmkkCdm6SvlFkd+M0Hik7/EDPGxyHsm4N+i
         vQMzi6NOHrcZemZf9xxv0JXLeKYGcAynB+2YW3sJWZbLt3IA25HawnPDD1HAT7SQ1jIk
         oJbw==
X-Gm-Message-State: AOJu0YxCa/gX4G2xff5HasljFf19fIr2WLz8wS/gMBJLKLyJ83izdaiP
	MzeNssztBF0yntrgjhn61+cI2yBEdDfitwFP92uRU/t7ifXkrYECycDNtIn+fg==
X-Gm-Gg: AR+sD13gOvn0329RItMS9G5R3VWNVxWlwwJSRel6LeXDh+7u7kaQmIoPW+2iarHxSVh
	1N0VxeWhwVTH9dUAATrB4I45Ayco3hHk/3I6lzb3NS/KbnmkHUH1UrIl7F81KUF/Inf5I0aChST
	b1cEO0QnpaGvnQLKLFvaue2gtO+edIcgW+jd9mjRFc548AojcelSI9ZgrKOMXcsGf0HxfrixnCv
	juLOeaiuH3mL4He+D48K44SDXrSfodVUxqtuLp9DEo9mLm88t0xmU48s3RWML5rLIQ3uRNzwz0g
	x2SmC8nYo+ZERlNyin7txXDLJwQaZI6SH49yNwVEXOE+UEyP6nFN0NHTf1HjMN+0k3HnuXE35zb
	wAsWKoxw16I9B47lN3NxejgjayONftLd4lsKeobFF9a/Dy86cjBNXAu7UtCFG0+fRew1VUNkVTz
	S1fhilZtNR9R5mzjA7/gXX9fSlVW1VxjiDqMua4surP9YGg+xhYhKj9yONN91/UFn7Q9C/9cawy
	ulQMQ==
X-Received: by 2002:a05:6a20:3946:b0:39f:a8fb:3354 with SMTP id adf61e73a8af0-3cb85e778b7mr7452096637.17.1785939885313;
        Wed, 05 Aug 2026 07:24:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca908068sm14304391c88.12.2026.08.05.07.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 07:24:44 -0700 (PDT)
Message-Id: <4ab81f0b0aad39d4e55fedba045d4182772624e2.1785939877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
	<pull.2285.v25.git.git.1785939877.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 14:24:33 +0000
Subject: [PATCH v25 3/7] branch: let delete_branches skip unmerged branches on
 bulk refusal
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
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Add a skip-unmerged mode to delete_branches() and check_branch_commit()
so a bulk caller can silently skip branches that are not fully merged
and carry on, rather than erroring with the "use 'git branch -D'"
advice that the plain "git branch -d" path emits. Existing callers are
unaffected.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/branch.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index db7cb01190..c44f710a48 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -192,6 +192,7 @@ static int branch_merged(int kind, const char *name,
 enum delete_branch_flags {
 	DELETE_BRANCH_FORCE = (1 << 0),
 	DELETE_BRANCH_QUIET = (1 << 1),
+	DELETE_BRANCH_SKIP_UNMERGED = (1 << 2),
 };
 
 static int check_branch_commit(const char *branchname, const char *refname,
@@ -205,10 +206,13 @@ static int check_branch_commit(const char *branchname, const char *refname,
 	}
 	if (!(flags & DELETE_BRANCH_FORCE) &&
 	    !branch_merged(kinds, branchname, rev, head_rev)) {
-		error(_("the branch '%s' is not fully merged"), branchname);
-		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
-				  _("If you are sure you want to delete it, "
-				  "run 'git branch -D %s'"), branchname);
+		if (!(flags & DELETE_BRANCH_SKIP_UNMERGED)) {
+			error(_("the branch '%s' is not fully merged"),
+			      branchname);
+			advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
+					  _("If you are sure you want to delete it, "
+					  "run 'git branch -D %s'"), branchname);
+		}
 		return -1;
 	}
 	return 0;
@@ -316,7 +320,8 @@ static int delete_branches(int argc, const char **argv, int kinds,
 		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
 					flags)) {
-			ret = 1;
+			if (!(flags & DELETE_BRANCH_SKIP_UNMERGED))
+				ret = 1;
 			goto next;
 		}
 
-- 
gitgitgadget

