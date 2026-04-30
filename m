Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BC3DB627
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534526; cv=none; b=pXmauGBgMLnzYHn+ew9OnEFFliusPMJp5IhwAwTY7NpYZcTw+ZxnYUX4RbLKIMJTZln46hMIWYKoKy3q2WvLpSxNAKBoSpGR6R8lMn6EV5BzkGVD9w4jA7r6m+yxlI55mb0nDmvNdeLaw5+6UCodPywW+SGxMjTCfW9ZrzP1fEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534526; c=relaxed/simple;
	bh=Um8dOrD+8n7ZrMuNeTQQ0c1fT14axWDGTKlXtmstISk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=qD+JNhZ2JZJ5tf+S1VzroI2sVyDQ1Z2bD//b8d+bCOhe6qKWVOfHlvp8ILYt1wnA9qEZ7y5r4h7FyFAKxKzr/SH7c50sOyrlXx9Iv6snzqNJa/ARNMkSSPibvBWl8X4/WgrsRWoX0DO7HFps9DUHQXXOpaYzNmIv1CnLI75xrHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+Fe0LiL; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+Fe0LiL"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8ef2118b478so60864285a.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534511; x=1778139311; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7/Z7XbxFNeQcezkDTaSLriPc4aaAKyWW1amkiukUes=;
        b=B+Fe0LiLjNRgYuEfUV+G6qebWeynwQqjmFQm+rnaoGF6Zrw2SCa/suu6FnU/URByOZ
         QnK4+KgisNOX0A+yMxupZ6i9b7Di3WvOiNyX/GkbLxoOn5Ulh0CYjTsu4whDy5yfAQ7L
         fshVhm2swvSvsuF/ecoTSSshv6HXc2wa/YdqUyZV/g2S5MKsxN/5ftY1f0jKrqt2pDnK
         cLVztOLfJ8wI9AwV1sWBH8Kr6MoRF0fEQ90f4YnvRvHnCfAYnym8JRYrEnrbDd7SN5pg
         B98yaNYhhywjf2v3X+0TFxxUS3jhAK8fwZOpG0swPj81UPIYObWwKN+Mks7dBzk3DT87
         6GJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534511; x=1778139311;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7/Z7XbxFNeQcezkDTaSLriPc4aaAKyWW1amkiukUes=;
        b=R6OZXePlHHB1aogwgNEp668olXcwgYz6ATqubOQqnEPUTb+MbnxFGZX+pu5Q7cn0FX
         HaqipttcvKU3obNEdVuKqRoxugs1fAv+JYX/t0wKUSg9BnRo0eQ4v5rXY3RuHumjtPLo
         uwkPTAFWAsvMIyA+ctlQrgNSpqna9gvgVKnpWPpaEkE+IOp2j3CgfA6YzdDqm+b8H6oQ
         /E3MgIPSTUUfaEUNmy0Sh9/9oY7S+I30UXLnXzSbUpMLbAehBrzzoEiWgy/0Nthz9fgz
         fSmkfu6XiZavs9Fg+kU4l+fZI3OtaNB7PD9PIAadgx/mhly3JccClOH7rPr0gv/8MgvH
         HyAw==
X-Gm-Message-State: AOJu0YxUz+S+hBy3BK0UiwdK1psXw65LSzf6H7Fe96DrEuDWFWjnSCrT
	w6q3CtpodRV0pljbg7hfbxvghHtJy4X7AaFv55cbZgz5EJ/w3xV1Dhh04BR2Ow==
X-Gm-Gg: AeBDievP6ejVTyCyCdnxm3OvLz/npQ6+stXTlyt/5c6Uq9lx6M9TmkdbcISioBJPA9A
	RMqU4oiKzUK6ujRa/lPd2zWxnVBk0+D7gb7my4wyWqJ9zHAWXdQevtJZqYgbEbsHiwzrJ2R2/F2
	I+ncQm634LMgNcZcB3GEPGUf6wRreFHKrgy2+RD1OU6QJ4gseubN4BsCBrBTWf1sd3qjva78C2k
	fEJ4UPZr53Tnq+Bluj8e2QS1abOHKhF3z5HhMzSttVNOSDY4o591c8mxqwnzGSTd/jxEWPEeWJa
	6uNxMJqFtp8v7hNdnV2na9RS9Pk+2/R7IgF2oGUPBBjqUM5l/taRhmu1cAr4PJMXgYrFboyYgBu
	qwneOM7LcTKzpwWhy7IXe9/sl+xhhTGwvX2OitxR5aT9I6hiUbB6wfp71Tm/U7XtqKeRKfhjYBj
	HUPdsQ5CoCjMWZzVcHDe5A5NAXldOrZLJVEmMj
X-Received: by 2002:a05:620a:29d2:b0:8ee:630e:350a with SMTP id af79cd13be357-8fa89a04b99mr286052385a.58.1777534510796;
        Thu, 30 Apr 2026 00:35:10 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93c808639sm435521385a.7.2026.04.30.00.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:09 -0700 (PDT)
Message-Id: <b9ccb66405c887812a3dd5791b343aed6c15a15f.1777534500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
	<pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:35:00 +0000
Subject: [PATCH v3 6/6] l10n: bump mshick/add-pr-comment from v2 to v3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The l10n workflow uses `mshick/add-pr-comment` to post git-po-helper
reports as comments on translation pull requests. It was still pinned
to v2, which runs on Node.js 20. GitHub is phasing out the Node.js 20
runtime on Actions runners, so staying on v2 will eventually cause the
"Create comment in pull request for report" step to fail.

The sole breaking change in v3 is the switch from Node.js 20 to
Node.js 24 (https://github.com/mshick/add-pr-comment/releases/tag/v3.0.0).
The action's inputs and outputs are unchanged, so the upgrade is a
drop-in replacement. Subsequent v3.x releases added new opt-in
features (message truncation, retry with exponential backoff, file
attachments, commit comment support, "delete on status") but none of
them affect existing callers that do not opt in.

See also:

- Changelog: https://github.com/mshick/add-pr-comment/blob/main/CHANGELOG.md
- Compare: https://github.com/mshick/add-pr-comment/compare/v2...v3

Pointed-out-by: Christoph Grüninger <foss@grueninger.de>
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/l10n.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/l10n.yml b/.github/workflows/l10n.yml
index 95e55134bd..114a12a9e5 100644
--- a/.github/workflows/l10n.yml
+++ b/.github/workflows/l10n.yml
@@ -92,7 +92,7 @@ jobs:
           cat git-po-helper.out
           exit $exit_code
       - name: Create comment in pull request for report
-        uses: mshick/add-pr-comment@v2
+        uses: mshick/add-pr-comment@v3
         if: >-
           always() &&
           github.event_name == 'pull_request_target' &&
-- 
gitgitgadget
