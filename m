Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5A92773CC
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769937823; cv=none; b=kmYRoKYmG5y9vwSLMbn1swv+XuR7JW2RNkUX9OrFZPMv4FHqmtt5IkxJDCzXwSHu+D9a53zHqt7DXsRVn4e3RFj8SHMwvc9/xBkiiM5OkbY1NAv7LQlSBpwB3ReIi0cM09qHAzNHu88dFN7LTF94cAQb+12Ic1AECq625afMdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769937823; c=relaxed/simple;
	bh=dNT1GjdLEWxaFbtg44xbceJl8Mh+YPjVUVUOUo+qoMs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=lql5152OC1ptYOSWTQP5VpBE5Aqqqe+kT3NVRU8WZsXMt8xpTZ8iqSRBBE9bTP/bL5TdA/BW6TCM/IQ6MmYGqQrFcH7B2UPiMIU0l8IhLRCmm46EtKCSsTpVg3atJeB9c+hZtH8lL5A5Sv7yjxG+NbobWJ7J67YALM7u04yWFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D27OvmNz; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D27OvmNz"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-502acd495feso40961961cf.2
        for <git@vger.kernel.org>; Sun, 01 Feb 2026 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769937821; x=1770542621; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXY1xQSMzLHPbSWyCp19gHy+nlEIW+SHW98/zJXRYNI=;
        b=D27OvmNzDnQJrMeiDZdoGXZTjuQlJ9+qsSXOd8KoMjbctW3T02rRW4bqd5P59PJ61B
         w5zHQBmBLMWd1GLcNw8IRMtdDthvOQUtZDsb+1PUuK997u4rGjFdMkRJnWvIKS8dAclu
         SeqncoyJDpGUmcdbBdWcN67xMD2ixDOlPKrdwoEM1oz69YagN2pkJJpPVDbiJwFxar00
         VOe+CJywb0R2FAAJQzRAi91E6AbUVrGmxPT5Xsz7rUevhppqwc3GsXneGXFd2oIV52gY
         YKkeJB/zqmbea3hOzXxXuwv+eCI23YgJBMPxIJGmORY5p/ofXNCByXq16FYIRmpdLqHM
         wPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769937821; x=1770542621;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXY1xQSMzLHPbSWyCp19gHy+nlEIW+SHW98/zJXRYNI=;
        b=ZFWzEn5DPU10UEFcnF6hCC/XocRYfQ4eMbKpl0yBquFdVQvpzGjdCPMybe1DPCGuTH
         PobAc/6NSByn+8m0wMB9efyHXJec3Ij+VnauycWq18otUvwM3ykVn5TIhDl7euk0yz8F
         tr7jbeF5J2Z74iEG6IRJJMka0mAz6PTUSU6eKYEpvHNvEWwxBeSTLlTZvnY78NIZz/rx
         V9LmMLSYOpcBoDfotqa4Iq+24YLjHRREe4rGGLE8ozXa+z0OLGgugJlpI/5o74QSg2cc
         7QWcsQod11t94A9J9dQjFADKHTDSqjhxpSuIaL9oNk+og53T0rxUkPCCy+9YXhJnoQZD
         dchQ==
X-Gm-Message-State: AOJu0Yy5rJCLWHKJlTN4lkKZU0dd9KT0syMnuSYeVQ/QI2uTdDoHTPYh
	HbU7h5WtQ2c9BAfdyFP+vwTh69C7pLnWaXJ0iy4GqpEdWYxDSbhugxyweNs6NQ==
X-Gm-Gg: AZuq6aJibQY5A6uRBo5pVkHF0tN0QTWQknm2W/edgxDvjJZC+epSRknvJZe6A/0hsct
	Sbu8l7SU9jVxdI/GHp9psF6LZLrJlLhdHxTgdqsj3ySi3zJQG3cg76GTuLKp95dgnffsu/fJKuf
	h8ZtaAcfFjLwBbmhvi+mjEcKcwq75iaeRZSswRkvjNSasRF5Rmlj0QETFsCqxmYAQq2HBhnqGxf
	6NMn5n8Kt4DiGgGR0ufZP0TdF0+QFZwQvmonAoertMfys2VYCXKvNYRgmVsiA491E25Ck7iK/C5
	JMmz9jtrYeuJA2NLbAykz7nzTJcUgC9WPTBvSqUC4jNu/dazhw5GKWRPeSB0NKu6/PDkmBRcJGC
	TZUeInah5w5M0RKflZTax7T3fRYq+szEJMGe152GafRBEvj0aibK7YzW+Exw36cl7iEPznKI35t
	xVJ6+Umgis9mw7
X-Received: by 2002:ac8:4459:0:b0:505:d647:645b with SMTP id d75a77b69052e-505d6477abbmr60039061cf.42.1769937821090;
        Sun, 01 Feb 2026 01:23:41 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337ba4126sm89429301cf.21.2026.02.01.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:23:39 -0800 (PST)
Message-Id: <pull.2185.git.git.1769937818682.gitgitgadget@gmail.com>
From: "NitroCao via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Feb 2026 09:23:38 +0000
Subject: [PATCH] fix(clone): segment fault when using --revision and protocol
 v0/v1
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
Cc: NitroCao <jaycecao520@gmail.com>,
    Nitro Cao <jaycecao520@gmail.com>

From: Nitro Cao <jaycecao520@gmail.com>

git clone command would segment fault when satisfying the following
conditions at the same time:
  - Use HTTP protocol v0 or v1 to interact with remote servers.
  - The value of `--revision` doesn't specify the peer reference, like
    `--revision master` instead of `--revision refs/heads/master:master`

When using protocol v2, git client can use `ref-prefix` param of
`ls-refs` command to fetch wanted references based on `--revision`.
But for protocol v0/v1, git client just fetch all references and
doesn't filter them.
In this case, the value of `remote_head` variable is not NULL,
which leads to the value of `remote_head_points_at` not NULL too.
But we don't specify the peer reference in `--revsion`,
`remote_head_points_at->peer_ref` would be NULL. So git client would
boom when `update_remote_refs`.

Signed-off-by: Nitro Cao <jaycecao520@gmail.com>
---
    fix(clone): segment fault when using --revision and protocol v0/v1
    
    git clone command would segment fault when satisfying the following
    conditions at the same time:
    
     * Use HTTP protocol v0 or v1 to interact with remote servers.
     * The value of --revision doesn't specify the peer reference, like
       --revision master instead of --revision refs/heads/master:master
    
    When using protocol v2, git client can use ref-prefix param of ls-refs
    command to fetch wanted references based on --revision. But for protocol
    v0/v1, git client just fetch all references and doesn't filter them. In
    this case, the value of remote_head variable is not NULL, which leads to
    the value of remote_head_points_at not NULL too. But we don't specify
    the peer reference in --revsion, remote_head_points_at->peer_ref would
    be NULL. So git client would boom when update_remote_refs.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2185%2FNitroCao%2Ffix%2Fsegment-fault-with-revision-param-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2185/NitroCao/fix/segment-fault-with-revision-param-v1
Pull-Request: https://github.com/git/git/pull/2185

 builtin/clone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index b40cee5968..ba8de92563 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -558,7 +558,7 @@ static void update_remote_refs(const struct ref *refs,
 			write_followtags(refs, msg);
 	}
 
-	if (remote_head_points_at && !option_bare) {
+	if (remote_head_points_at && remote_head_points_at->peer_ref && !option_bare) {
 		struct strbuf head_ref = STRBUF_INIT;
 		strbuf_addstr(&head_ref, branch_top);
 		strbuf_addstr(&head_ref, "HEAD");

base-commit: 22584464849815268419fd9d2eba307362360db1
-- 
gitgitgadget
