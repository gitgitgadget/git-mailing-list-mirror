Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B753DD528
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534516; cv=none; b=LaRbFSVmVA+eXhuq0eZwVKjuOONFdX+7oQdnRStXKR+MyQI5s0lOlwbutnUUI6BjEf9yszY35sk4vyjxnHlEy7o3p0qYWPQyRDGTfyhm62pwd6nnsBxovE6h6wGr/u6I3/8N6/8GeddeBoskiG5Ic/56TXKjpXefBwn6k4cl/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534516; c=relaxed/simple;
	bh=3Hlgd8uMV0Agal/5OW0q2ue7DwCCXv2/KHZe35CJSx8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PpkjQC3NLtTrGoEJjIwCmlAXOIHqtJTyzuhmI1Fc8qcDcR3UWgFk4iqKUdi5tK69bHCZS7YG3iaftQ6/QKif9nypc1evSBVr9HQH8aYdu21ZVuSIbVoMMkf+r1XXfV03pr/Aiopx9P4EaZZ/jdLNwKFvFUPW60OVuQURNxfnoHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbdZq8sz; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbdZq8sz"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d68f702851so68436685a.0
        for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534507; x=1778139307; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMj1f9ZBkdD0HhZnJAtNiJv3zCRtKvFbvyHj8mGG2S0=;
        b=FbdZq8szT76Vjm0EcrMcxPxjP1n+I1j9c7OV6iyf4Gtg2VArBTXN1KUi22hpWWJqfm
         xxTLji5IcnVhHY0M4TZkSL7NudJkkLoQAVG87qMyhffSRO+WlcKYbVkhhHltIWqWHNvH
         I2U28RAgdPQ3iDJzkF298UnfEXS442RXFKdnaoJsK45fjGmcySx3n1QfwpZn++T0t21G
         HNFV2tUGsIEIxKnJxnH1/z+jQIeevkMKP8piXqf9qzGEeZtCOz/JF5v5WBOiVYWlR8Yx
         iKqtUYjATp92NVbA3Jvvu/GsNamWSGTp3s6TqBkzhBuLCVEWR7yjjyLSk176zkLMdNfn
         aD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534507; x=1778139307;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMj1f9ZBkdD0HhZnJAtNiJv3zCRtKvFbvyHj8mGG2S0=;
        b=OF0pHl0S5vc3TlVdHz+DZ/QGyxhwyu/TQcNg1xGVSLdWrvJxm/dNtjoILTpmyPZlyh
         IfaLnh2oEqNEx6L34VKJTyp9qrlSrq3eXg+r3DErNMEsTsV77NUNu3BaQAuERH11mY6A
         GoLqdXes2XQMg+QKyFG3lEO6b7GGd+LamfDm9wqljN63kdZEBO9k89W8pHKf6vpAFmpC
         XTNXHnpQoE4a7sQ6xqJ8ry+wwUhfg42bt6rHCkjOm8dszZMuALNPD4bYT9fhguIYqAj9
         jRzg0XKka3wOsbyHb6lx20bI94QyjRsWfK1SfboFKVAT/T639F1RCvHGgUeDYHn8HXSJ
         FfvQ==
X-Gm-Message-State: AOJu0YypD5W/Cm+2yfJ0jdQmd9EU5kaoGg0dC+eoKcvN5khN6WIc8Bvu
	eevOS1kviHZGRqXlPe3a+soOlcc7o4y6ljhfjzEGxD25HpeYbVm7CxZf6mw4zw==
X-Gm-Gg: AeBDieulepFKgr7Rh9rJAL5IILzCXhQCwB3MtdH6/EHVO9i2EoYiJe0zhFsiygC1Rfj
	RHxYOqHc0b2E/3esrSGPagCRsojke3aRq7/+jMdXpRmQfo8WacZnwNSbLkKD2Ws8QlMwWcXSBAw
	efZRYgQaYUinHs2PUSuvsqlowxnNJ5gHA/G51IM2KOqfNpIfsKdgK29wdBqWyDx6DWQx+ZRu+gi
	XxEGECZLGEx8rVGQ7YiAq8/YqXopEiFVV6mL6FidHAAAoNaCrVJkC4E6+tFUV6kJPVJ0naTrMOD
	4/9oc1rb7vHYYU2uYhMUKg1SZi+rrUZBJrFggSoB47Ik5T5Uc7xsZr6e2zyxMN22GsSzwoMR71+
	I6qjgW/hG1uzPI3B6w9ARBPgBzaqP1s63TmNYBbOIa2yqDJsVUJEFaQFBCqqK8aFrwN2p6HxATP
	1PVF/BcYLHdSzFTv+hTBW3aBUHjy9GwjUT3RbK
X-Received: by 2002:a05:620a:3942:b0:8ef:12de:1334 with SMTP id af79cd13be357-8fa87594f6fmr277958485a.1.1777534506932;
        Thu, 30 Apr 2026 00:35:06 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93ccff7e3sm390534585a.12.2026.04.30.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:35:06 -0700 (PDT)
Message-Id: <bfbe0db67f5a0454378bd5fd71e2cbc1493bcb59.1777534500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
References: <pull.2097.v2.git.1777114720.gitgitgadget@gmail.com>
	<pull.2097.v3.git.1777534500.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Apr 2026 07:34:57 +0000
Subject: [PATCH v3 3/6] ci: bump actions/github-script from v8 to v9
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
Cc: Christoph =?UTF-8?Q?Gr=C3=BCninger?= <foss@grueninger.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The only use we have of `actions/github-script` is the "skip if the
commit or tree was already tested" step in `main.yml`, which checks
whether an identical tree-SHA was already built successfully. It
currently pins v8; v9 is the latest release.

What v9 changes:

- The `ACTIONS_ORCHESTRATION_ID` environment variable is now
  appended to the HTTP user-agent string. This is transparent to
  our script.
- A new injected `getOctokit` factory lets scripts create
  additional authenticated clients in the same step without
  importing `@actions/github`. We do not use it.
- Two breaking changes affect scripts that either call
  `require('@actions/github')` (fails at runtime, because
  `@actions/github` v9 is now ESM-only) or that shadow the
  implicit `getOctokit` parameter via `const`/`let` (syntax
  error). Our script does neither -- it only uses the pre-supplied
  `github` REST client and `core` helpers -- so the upgrade is
  safe.

Risk analysis: the step is advisory. It sets `enabled=' but skip'`
as an optimization to avoid re-running CI on a tree that was already
tested successfully. Even if the v9 upgrade broke the script, the
surrounding `try { ... } catch (e) { core.warning(e); }` block would
degrade it to a warning and CI would still run normally. In practice
the script continues to work identically on v9.

See also:

- Release notes: https://github.com/actions/github-script/releases
- Compare: https://github.com/actions/github-script/compare/v8...v9

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index da31b10c79..6d7f26e71e 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -63,7 +63,7 @@ jobs:
           echo "skip_concurrent=$skip_concurrent" >>$GITHUB_OUTPUT
       - name: skip if the commit or tree was already tested
         id: skip-if-redundant
-        uses: actions/github-script@v8
+        uses: actions/github-script@v9
         if: steps.check-ref.outputs.enabled == 'yes'
         with:
           github-token: ${{secrets.GITHUB_TOKEN}}
-- 
gitgitgadget

