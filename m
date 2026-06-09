Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9023BCF7
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972604; cv=none; b=sGr3RILWUzjonZRw2fZ1KhLriAMpIXYkS3xC4fO2/El7AIqi0iTtRQeUXTKoRHTm6hJmDeExpurUeyB+UytMwaEf8JDsQJU7MRY+/Z86dG0dfGPt2mOaJlP7Ybm81QJXJDsHc92oqkRypJZYQtYp+78I/dIrVqbjsLfHtCSpNxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972604; c=relaxed/simple;
	bh=SbEin9i0inynY9Q6o0flbbEub9MQlgvAQcEzuyrd9cQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iqdD+M6qXDGLgeY1IITh9GAL0ussqIxM8jZDjU0W1IKP8ZEBxp4MFL9Ys49IE8//8OvAh68hZTyderqT/zxr0RwX0w3s2+l3b0fKd/DKwofG7T4aeARcSdn5Jfd4+xb1Bns+9HDZfE563zzLfgPCY5cDkdaPXsEqRyvbOpgLWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvV7x5IP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvV7x5IP"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51778069c31so40548231cf.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 19:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780972602; x=1781577402; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GxVJ5Zz9SG46ciYRj7ychLShFLYYkXaOlsItKpiims=;
        b=XvV7x5IPYwMm614uQGoVcoJk39bPyHLDRhMUoIszRE9UX1PFTE0T/TfjbUX4ryZ9HU
         87F3wN1s+PBenOOgK1f8v+xfaL7J1rzHN/9Nh3vl4eeCd0WBpHsmEZYUCQdDMTEiuPjq
         D8ebndLFPRaCoHJMLyK+GYe9frg+XAu4NVQRyHV+qbx1Cnl0OZmckJmtyobB2GHzNGUb
         YfneaiwkWcxRUU99rzV5nYd5i0bgffYPvUH/wGJKWwr09zTn3O9Kc/S9JeCpo/sylHTo
         Ccxz5OX4kQXD2r3JmskVKDDs0+sAMn+dpw0MjXPpuZdL1ifleQQJqxopt3w9sZMPQlhU
         cD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780972602; x=1781577402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GxVJ5Zz9SG46ciYRj7ychLShFLYYkXaOlsItKpiims=;
        b=r3ipGsLvodx0m1TjRlRNNIy9eiVn6jpAOa8pswKyMlhIqwj3NHLzNKhm8js3YGRGej
         tOJ7BU91mjmWrEEj5cRI9Zr1owWoov745a45KFLEVJL66G6F8fWRN6oLCOlFTQWbTjlY
         WxzOe62S19zrqZhOCVc65StD4YQ2A1hzJeh7VYZqVcNi5MDEhksXrCcWr9gx4CJpH6Wf
         CAILB5alcv0/6+ptYNZn+lVJoocbM7l6cocb+GNKv8QraxNM22d9SsMMpc1xs8+C3Fwd
         s4YJhVjhJd6CT6T9EidGj6QpfwQ13HLHuxAmEU8IWq0ptvwZqL0GjSa+C19/s/juTCeb
         CtVg==
X-Gm-Message-State: AOJu0YzpcGqktob+VXniQek1kcNZCJJXq5CfVn35Amf0/1AdUYVzhKUT
	/9xL3Iyfr143gIWJLvKtEyUosES01OrngMIcD13eiT6VTpIjO8Q9Sg8r
X-Gm-Gg: Acq92OF/x5rCWr+NQeHXidM4YALlox9L7RVbLADxZQCXjTBrmoNvbDZahaELAmbIe34
	cC2SvWIrADXY/V3OWbd51j9t+c03nXoV1V+BeymiHSIYxDUi1Tamdk363WJytXb6ago6rJnE8uj
	9yRjwRygwB+10nDK/B2AoX9b3plZeZRH4pXFIx+7CyBq2yRVne8uFJFwfpc+grNr3fc0kBvkY66
	CesOttY/vwgkriKwiwSks+4fn19iEHYyKsY37TeAoDVoS4oZEaNIRP6RExoTsEjODbSJxEG74Gl
	rCsgZX+touEjSPZZntaEZy3Bfepd0u/9SQVPPts9XfGj6zROuedCxCM7JQR6DFIFwMfpFASV25N
	pbboOTeIHRvI3CI7m3zvPCyB1XKYfK9+GMKTX1DsNrDCHHuURDAc2QegQnyby1cX9UjmqT96m3M
	MuNrpnppcYK5hEkyS+5kUSpa33908fP7RVETzKMPgisWsKmy3i2odgymiROjtDAUH/A46r5xzeK
	Zc/wVp4Ohcr+rfGg9DRqEvrpkBSOfV3udKm3LBK5NpkPEYpLN7P9H7By9yUsNl6AFmAh5BkCvs7
	cqvkl1r7WH7PHP2M6pTYEgYN5BeEGT6JKI+S6nC5lPPH9ptq4p1Mdzrm5A/LxuyZuG/I06k6pp7
	S
X-Received: by 2002:a05:622a:14b:b0:517:21ad:faa8 with SMTP id d75a77b69052e-51795ba1ed1mr259585291cf.41.1780972601720;
        Mon, 08 Jun 2026 19:36:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c08234sm172718611cf.6.2026.06.08.19.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:36:41 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/2] Reuse --contains traversal results
Date: Mon, 08 Jun 2026 19:36:33 -0700
Message-Id: <20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ7CIBAAv9JwFlMwgdST/zA9wLJt1xQwgI3a9
 O9S/YDHSSYzK8uYCDM7NytLuFCmGCrIQ8NgMmFETq4yk61UrWo1TzjwgeaCiXv0kd7oOMRQDIX
 MNVhlTxbAOMFq4l5ten7z1/7H+WFvCGVv7sZEucT0+v4XsXt/rhbBBTei09I57ECry+gNzUeIn
 vXbtn0Aqw9sJtoAAAA=
X-Change-ID: 20260607-ref-filter-memoized-contains-7cb6b3bccad1
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1780972599; l=1262;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=SbEin9i0inynY9Q6o0flbbEub9MQlgvAQcEzuyrd9cQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNvUKHRVGOilkhNyyotYvffrD4DaZ8tbIsqqGIiNnfaWwkL5q81V7rDiY+2XD8xHkLjcV29mcyv
 cnO1ddHng9Ao=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

The memoized traversal used by git tag avoids repeating graph walks for
refs with shared history. Extend it to the other ref-filter users after
making the existing traversal safe for cycles introduced by replacement
refs.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>

---
Changes in v2:
- Split cycle handling into a preparatory patch.
- Exercise cycle handling through the existing git tag path.
- Move perf result verification out of setup.
- Link to v1: https://patch.msgid.link/20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com

---
Tamir Duberstein (2):
      commit-reach: handle cycles in contains walk
      ref-filter: memoize --contains with generations

 commit-reach.c                 | 43 ++++++++++++++++++++++++++++++------
 commit-reach.h                 | 10 ++++++++-
 t/perf/p1500-graph-walks.sh    | 49 +++++++++++++++++++++++++++++++++++++++++-
 t/t6301-for-each-ref-errors.sh | 22 +++++++++++++++++++
 t/t7004-tag.sh                 | 21 ++++++++++++++++++
 5 files changed, 137 insertions(+), 8 deletions(-)
---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ref-filter-memoized-contains-7cb6b3bccad1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

