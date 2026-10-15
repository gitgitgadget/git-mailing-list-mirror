Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8B49EC68
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058075; cv=none; b=sA/xVfuMRSWq5t6bcXSR0ReeWPAj/ms/Nu+nwenugOzLnG0IoVLc79A9SXtxGwnfMrk9ZURG67KEb4ENAYzs6mZY9l9U6/joCq8J5gfaQWOggtmOkqjuFcWqHGQ2xnAr/U9fJwS6yBe2F3WMrn3JWCw0hcxQ6RymEk4yrunw4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058075; c=relaxed/simple;
	bh=Ep2aO0Yna8L3dbeVrUKoFMlKi260K2vH+WwvXLHhD9c=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EBdIBAvdQ7ai3FQ3kUemQGnyJoROlpL5t2WVhoNSjQ0CwTwZXV9IcljApiRKmpIi399vauWqnJkySeuFUz3yiPkKeG3VlWrlduyTeWuuR+96KOSv7FiOcjEXed0zToRujfH5em2T9vlw0yXZ30u8Bpsv7KTTaDTrHaGQfw8VCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzRJvArv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzRJvArv"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f432ac553fso5500471a34.3
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792058072; x=1792662872; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=22P6OSpLLyJRX2BmIZBZzoSzErdYI2SqdpcLGzJPIRs=;
        b=IzRJvArvi/DmdcKI1GNzOgfFRU+rowB3ozGmN+NmXEKppVkb5zF/nqi+n+dSERVZ9j
         isguG6Id/ChJb8yUWLK7jfSdjCfbaEjgeekCcX2aFpFUwUxOBhPAnotbnJWWoJg4WkJx
         3lrUuxLZS0yfIIE0YDAJoYXvJOueNZuvvZ4VqgHyB7xTU8PwzNNODg/n6XezEqZRVJn4
         /eXB1G2yKbwCO8+VvzojJYbA5eye9el+zy34r5oq3c0M4Z6gl+MPeBLBQi7IP21VyrXV
         vI2FePD7mg7tKeaJMYNPUnHUjB9DgK14wAcQifbHXZvAh52F0g7fgCA6Lah66HYXiZg3
         3AnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792058072; x=1792662872;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=22P6OSpLLyJRX2BmIZBZzoSzErdYI2SqdpcLGzJPIRs=;
        b=z6zoJ4LEtpWsvOM6XtdOV9ySQCXiME3uuoc8eZisds633ISN7oEyjM1LtgJB3l69zH
         aYlSQ6jSAXU7/6pHl57o02HUtg52SCbHEoPdoczih3ipsoD4cPYm+Z7Nbg6/YZ9TKUKV
         ru/IHE/5NB278ib/aruZ3rPY4PoV07hYRfvohG40O45WVNHR0YBLm9uMV1WpkZOc2vPG
         QZEW/FfQjtq53lzpzZOuVnjEi2H89z/8XMjOdi4G+oBGcASqhTdlykL2+GfHFNUVkdHT
         B8GaCBSXptMl49yip5m8MRWtX/qD9HKszoPJClhEVtd21CMkNYhTa+E78yoKl5yGQapM
         oNSg==
X-Gm-Message-State: AFq9FYIOUKEvDsYpaE+GNIsukPLrfpXHisgz/VOoPWaVFi8MPS6kt4Z0
	HCRAYf5sQ3kz7+jK/u6yhZm5UOyeJbF3O9+BCO/1o1dGdKaj4mlXN/g8APdA0SDPCEM=
X-Gm-Gg: AYBFou0tHLCSJz38DgewkNSEti4lCdOEaWpFLcOzKQZBGTKW7QcDDpdm9lvQN7qVdMv
	LMUL2lpdgo2a4+b2PTOHW3QBQbldahzXzYvBzyao7hXYSGKRgtCQxm/jT5Ch0bRIUb4XDSNJbaj
	xUebM93Il4qxPGNs8yG4f5mzyayH17Otj9CHD/d8qqwavfS9zV5VALOEJQAlYGTZKNWj7Ao5N4A
	SqNtMXoTal3nLSP6RT4W8S54C+oe9ZPwcCykMVQ9W8176m3InD9YTdfReBKrLAFisOQ0kWubacs
	yMMt31QEAYhWJY8lguKF8HOnVRK1/+7l8p9vBb+GhToYRuBjGJ2dRijERb2SfmUqufYstZYMFlu
	VQPrLg0bjzbABpropBUJrfSL+JmF05HQ8YC6YFQRWED2bMMnjBAPGev/oE7h61N5tNWCt/Nljyh
	+s/jP5yJ9mwYx0y4X3I4pX46mcMycOaeNQR4RnmoTlSBeqJy9zK7PcysAtOWPwtWNG+bi961AUF
	A==
X-Received: by 2002:a05:6830:378f:b0:80c:d30f:97d with SMTP id 46e09a7af769-8309815ea72mr18766106a34.30.1792058072012;
        Thu, 15 Oct 2026 02:54:32 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.23.97])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a46fc3sm18707881a34.20.2026.10.15.02.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:54:30 -0700 (PDT)
Message-Id: <pull.2257.git.1792058069306.gitgitgadget@gmail.com>
From: "Raj Ojha via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 09:54:29 +0000
Subject: [PATCH] describe: use Q_() for pluralization of commit and tag counts
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
Cc: Raj Ojha <rajojha047@gmail.com>,
    Raj Ojha <rajojha047@gmail.com>

From: Raj Ojha <rajojha047@gmail.com>

In `describe_commit()`, debug messages print the number of commits
traversed and the number of candidate tags found using basic `_()`
localization format strings:

    _("traversed %lu commits\n")
    _("found %i tags; gave up search at %s\n")

Because these messages display an integer count of items, using `_()`
fails to account for languages whose pluralization rules differ from
English (such as languages with multiple plural forms).

Replace these calls with `Q_()` to allow gettext (`ngettext()`) to choose
the grammatically appropriate singular or plural string depending on the
integer count.

Signed-off-by: Raj Ojha <rajojha047@gmail.com>
---
    describe: use Q_() for pluralization of commit and tag counts
    
    In describe_commit(), debug messages print the number of commits
    traversed and the number of candidate tags found using basic _()
    localization format strings:
    
    _("traversed %lu commits\n")
    _("found %i tags; gave up search at %s\n")
    
    
    Because these messages display an integer count of items, using _()
    fails to account for languages whose pluralization rules differ from
    English (such as languages with multiple plural forms).
    
    Replace these calls with Q_() to allow gettext (ngettext()) to choose
    the grammatically appropriate singular or plural string depending on the
    integer count.
    
    Signed-off-by: Raj Ojha rajojha047@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2257%2FRajojha-1%2Fdescribe-q-pluralize-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2257/Rajojha-1/describe-q-pluralize-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2257

 builtin/describe.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..1a7317c811 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -481,10 +481,16 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 				label_width, _(prio_names[t->name->prio]),
 				t->depth, t->name->path);
 		}
-		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
+		fprintf(stderr,
+			Q_("traversed %lu commit\n",
+			   "traversed %lu commits\n",
+			   seen_commits),
+			seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				_("found %i tags; gave up search at %s\n"),
+				Q_("found %i tag; gave up search at %s\n",
+				   "found %i tags; gave up search at %s\n",
+				   max_candidates),
 				max_candidates,
 				oid_to_hex(&gave_up_on->object.oid));
 		}

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
gitgitgadget
