Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8F3176EE
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505568; cv=none; b=h4D36KRvbVLqrdSErBqaqHzyBImyTrbnIZnQg5QBPaT/Q1Lgva2d5qLsO+24ndOj3b4s4PrHmXxfA0ZRAyH/Cqa26xXeAjVF2BlsNMNQjTgG1LYKO3dA3jJ7CwxUOeUPN6uNvP9vkc9lL8pRr9qjWrtZ/tm2tcQ9HTD66i1KIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505568; c=relaxed/simple;
	bh=BO+R8u/1+PFCARa7Pm6gG7PImn+eAc8Qb/ZZJa2jvYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdi1WVYtsxgCeHDVw3epKPneTE7J5ujZKNG+5NiEbQJBA4w/sbdQ973R241gGr1IJsTWyMFFDpsl9apW10FohxkAWMt3s7C+j++NY7MOTNthhcmgjjvHZ/6nlgRDy0VsLzGIkMZK8kPQ6vLMsihWbMVhF8L4zsPrBPveryPlw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNg4JSSB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNg4JSSB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6b5aa7535so552935ad.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505564; x=1788110364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/hXTOmKjuycFhX6IewStIOLN0cEQNOc6iOXF33Wccrc=;
        b=CNg4JSSBv6+01IApDqo8y3eCw2O9CF9LFiz2lhZt7NfKtT/rayMgt9B8R2Lk8hNehb
         /Hm+M6oQo4j1lrzu+WQTp8HAxxKDpDlhAGKjdFrVEAko6H0UU5yhf5RB12lXzSFqJxZ6
         bHopJtLRX7x3/9AHlHbj8GSA6CiLmVF9jHnS5XScUMkIA/hgyRxJYrCrpCGModupa86Q
         YfpvrWkzzfJrWXbkvbAKzoBd7Zo2iMlp7OU7EC3wk5t2brAersUlQ7/tZ0/2OJZUB+uw
         YOFrXLh1zdebRNIgvKVC5GCRSOLSpg+WRJO//RQYRF8Lm1Uk1FgAVQdp6YggAextyQWO
         CUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505564; x=1788110364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hXTOmKjuycFhX6IewStIOLN0cEQNOc6iOXF33Wccrc=;
        b=BE1W87oMck+a4um2N39pQujK0QHOkz8rG9ChlEf9zIceotD4Sw53L3X/BASKZKWZ/D
         kpIl8QYUumaTtCITnqdY58v9Nlv6tzkhfnf/TuApC4PpkODZXHAlPJRMYTQmmfV/TpcU
         /7QMZBrW+k30zle9+Yqmi8/MpH8eH6rZdeJWeitC7aY//7UDpL1Ic5Gg4MfdzGMEWXMc
         8MRMTia51pbAq7GwmdMVLQAO84cTi8WxDP7R/zCqrYSmAnz3vZKKwWWQ35FhGOYp4hiR
         kgkg2WHLMuC7vUPquBvAI5UbIUn4dEhxIr3KwRPqsZ3jzsgXjhA5b5/LXuALaol95z6D
         f0IQ==
X-Gm-Message-State: AFuF++ntMSrmbrKTe9jlH0zZFySFI8LsgMUE9jXD4JS/BEsscCHWIC2N
	DWO/UU1zGHe4vgZT0Kar5ID91opMMtY0/jmILXipoGZ2Rhf9BNEe1Imqkdj5Zw==
X-Gm-Gg: AR+sD11K32ULyK7+tX5FUjrU70JL++kFYBKCwZWTMYPLsMlq9/+KFjX5vf8vjjWIbLU
	R2buDOha2CSB6z/VyE5+hi5uxFGHujS7K1tI8MAnEcBNbtRH0tUuZn7gcybQU2GkZ3Od6DoCu9j
	YrRIspmZ1Q4oXk+XLX9CAskGi+wZTwqp4TfNlFOSpxK5XFrDqp+2A8kq+8qr5GrHELOL4v4hpdt
	YVlin36j7IiPfsNJfR/rOnZRSJY1SHJHEc9u/CJRiCJWn2vtS+xUa6oZSUqV3lfndvr1d2H9BSp
	rq2kRiydv26I5v4C4pyaerMm6IZzO+NNthyJPqZsheF8wZetkotb4jJmiC9k3vZ2zcl2myRRPhU
	cYgNGl7710WKWoN1AjPm3bHpNjSBj8qenwPPJ44ggGXHGMg4KXoz02TbCjnq+YCov1Q0Zs33CsW
	8fd5mfm+iU2BdzuKT6R43R3SRTd7EiY88bJGh8tB7qXW+MRQffbqKruGhThyOZpMdHSXFocpa9t
	W9Bt0nuNrhnSnRj62LxY/JYX8oKWd2mOxgmiq7JBdhxhpRq4SltycpEEsyZxKMP5AniG7HOsjTK
	a4Lq2M9/E/oxCh9TDQKrdwNvIuCaQvV1E5Kl6u0zi4Yi4w==
X-Received: by 2002:a17:902:f78f:b0:2c9:9a2e:dab0 with SMTP id d9443c01a7336-2d64ad92e17mr377540785ad.3.1787505564330;
        Sun, 23 Aug 2026 10:19:24 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327ff728ca7sm15538506eec.3.2026.08.23.10.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:23 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 05/14] organize: declare Git's scope and layout
Date: Sun, 23 Aug 2026 10:18:49 -0700
Message-ID: <20260823171915.2662373-6-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Author .gitorganize for Git's own tree. [scope] puts the root *.c and *.h
sources in scope. [layout] keeps a public interface (role:public) and a
standalone program (role:program) at the root, and routes each component's
sources to a directory of the same name: transport sources to transport/,
diff sources to diff/, and so on for the thirteen components.

This is the map alone. The next step records a label per source; the carves
that follow move each component into place.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 .gitorganize

diff --git a/.gitorganize b/.gitorganize
new file mode 100644
index 0000000000..18cf3228a8
--- /dev/null
+++ b/.gitorganize
@@ -0,0 +1,19 @@
+[scope]
+:(glob)*.c
+:(glob)*.h
+[layout]
+role:public = .
+role:program = .
+component:odb = odb
+component:refs = refs
+component:pack = pack
+component:diff = diff
+component:merge = merge
+component:revision = revision
+component:index = index
+component:setup = setup
+component:convert = convert
+component:transport = transport
+component:notes = notes
+component:submodule = submodule
+component:archive = archive
-- 
2.54.0

