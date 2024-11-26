Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C94BE46
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632044; cv=none; b=kyCEyj7lWhzfLbUSJVHRprzdPyTcbOPw3pNrgvgOm/OFrMWApHnDSdQcQHJD+P4PP7/CB/IRQEWErMb2hun0Q6a/uO8y7Y/KUnVQj8Y17KesWcGTsqkGoYFnDAmmFn0h15A4zbvUtX5Kuif0XeI7oLTyw4V1v9C0IuPEpIR9oCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632044; c=relaxed/simple;
	bh=needdXTXd2sR6e1LEuZF0dpMUmpAH5uJoUyt6+XcMw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JL6qqzEsLhbsFEZG63bd2H2SoCXgttq2hT9E+QQlW8f+bO43BG3YvaziYiHkeGc355YEV33+RZq2agfJugqqy+AczBARZJzCYbteIwcvk10RJ4k9AAAaxiuxdwxGhOF5BFjQHIPGTkcdragO9Y6y5DTO78M8R/XejtpYV+fm7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUKfLKFY; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUKfLKFY"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2142214abd2so31805215ad.0
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732632042; x=1733236842; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HUhvCOzc2bVNLxp4bJf/b5kK6xEbliudFFi7KVRt6o=;
        b=HUKfLKFYNP97rZbzdHc2Dc5uPI5fhQGV+qnekNiSobQ8/P5LorqxbMNjr+9tGvP/Ka
         0itWxSrIevYi6L2UmJqA2JDdsEYXoU+iwhzbPzDtOPz+Mou6hcgSwnl+a8Cq3Cl9hbHj
         9g+nh5aC2GSP1yFv7/rkallwUGFkVL/1UAmh4BDKTHdGudxnWkzz0VVe7izZmmjZPTHq
         b66ThBTUINwWgvHw6sBYSjtD9CPWAaZ31Jcdmtkh9Z+dS1CJz67jTxscnTn/dRsRc6w6
         Fx9y9a3kGzEq0PUpfmo0Njp3iB+8NECxbjHP/UnTBYj39/h3/CTz4v8oY7iKVlFIkURg
         yCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732632042; x=1733236842;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HUhvCOzc2bVNLxp4bJf/b5kK6xEbliudFFi7KVRt6o=;
        b=FlcYdcZCvZsB8oX5nkVDCNpqZgS6zl2SzlAhQdx2QyXsoUXBcjcJVv322YNJjXLHy7
         GFIYeaedblYMqoDx/drwah86yEl4h4n7LKXigLB30kDjaaEYsuBRdi5arsE5StsMbtO9
         sdou9+ZZqag71WoSkah6qH+Gg4t48THedwo3X6rh0PZS/64eDQ8t+GQFQTzCCBt0HGyE
         1pXK3M/UX1aT0+6iDARzciszh287m1pHNLu1BGi7cYdrx6DP2PqNR+LVmCc5wg7lGhhr
         ngJhA8TP4xbb6jo1Vd0sJUWrHs0NHb4TJFlZ20dVC7iEgLlqnpqMZmnUsfia1k+V6FHX
         lyxg==
X-Gm-Message-State: AOJu0YxDNXtIQl7065NqUFa3NfJ0dga4kFS+LXCN6EnxRqieYtOegPPV
	InBClRXEWgYwjsmUE0ceeSpjPHZMGBK3DQTo/KJ7qUyVWTVl8Hg+YhKoNtAB
X-Gm-Gg: ASbGncvqScLprUMqtGoBqPMmUktQMXPu5LBo74E3+iOfZzkOtKwVpukNgIOkOU0ys9u
	0PUSki+N8WsXcg5FoxdKlhFeJ6BzAqwN6Uxg0Ma6wx9C1Eexu62aPWctODC368CWjLLgBXaHq+B
	k6CkSXcoa/Ttu9P5AX/P1twOOg6cv23NBLyBDP8gt7/jRu+6kkEWNRcTHYJsHZLPUKLahYDGowE
	4iMFfnDRhOkv1o2eHbqPFmYC2zWOOKpmgvnXISs7SB40A==
X-Google-Smtp-Source: AGHT+IHKNiUc0TnR3TLouOu2Sh/cHyM3m3gnzjQK6jDUyXr5tUCF/EzgjULatU2NSQXVJBLGeSACFQ==
X-Received: by 2002:a17:902:ec88:b0:212:8ab0:4f55 with SMTP id d9443c01a7336-2129f780debmr230249955ad.56.1732632041575;
        Tue, 26 Nov 2024 06:40:41 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c864sm85552175ad.37.2024.11.26.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 06:40:41 -0800 (PST)
Date: Tue, 26 Nov 2024 22:40:57 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	John Cai <johncai86@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] ref-cache: fix invalid free operation in `free_ref_entry`
Message-ID: <Z0Xd-cYPNNrxwuAB@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In cfd971520e (refs: keep track of unresolved reference value in
iterators, 2024-08-09), we added a new field "referent" into the "struct
ref" structure. In order to free the "referent", we unconditionally
freed the "referent" by simply adding a "free" statement.

However, this is a bad usage. Because when ref entry is either directory
or loose ref, we will always execute the following statement:

  free(entry->u.value.referent);

This does not make sense. We should never access the "entry->u.value"
field when "entry" is a directory. However, the change obviously doesn't
break the tests. Let's analysis why.

The anonymous union in the "ref_entry" has two members: one is "struct
ref_value", another is "struct ref_dir". On a 64-bit machine, the size
of "struct ref_dir" is 32 bytes, which is smaller than the 48-byte size
of "struct ref_value". And the offset of "referent" field in "struct
ref_value" is 40 bytes. So, whenever we create a new "ref_entry" for a
directory, we will leave the offset from 40 bytes to 48 bytes untouched,
which means the value for this memory is zero (NULL). It's OK to free a
NULL pointer, but this is merely a coincidence of memory layout.

To fix this issue, we now ensure that "free(entry->u.value.referent)" is
only called when "entry->flag" indicates that it represents a loose
reference and not a directory to avoid the invalid memory operation.

Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/ref-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 35bae7e05d..02f09e4df8 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -68,8 +68,9 @@ static void free_ref_entry(struct ref_entry *entry)
 		 * trigger the reading of loose refs.
 		 */
 		clear_ref_dir(&entry->u.subdir);
+	} else {
+		free(entry->u.value.referent);
 	}
-	free(entry->u.value.referent);
 	free(entry);
 }
 
-- 
2.47.0

