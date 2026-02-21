Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9652C10785
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771703369; cv=none; b=P+x8m5FXy2fNsVSScqj7wL6sHOuHeX2u6cElZc+4Q9SeupMDoq+a0gduW6vxGjEMDoMUmQQxyCTwM3wX4Fqd8Nw+/LNS/iu3noEBaayKDVDPVjcqd/KDYo8llUsAMJZlSWYfQkXvNDOXFcHhCCumTfmELG8rGalYvLcCAux36/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771703369; c=relaxed/simple;
	bh=ZgnA0fcQQArY/YmpjAgWIDlOUOD5QpxD+CLBau+bBHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T3/P8MAuhIBZwRf5qf7kPI06JVl05BCoxnVQF2l92s0ueYUmdCuxqiGOeH3TMiF0iMR474E3iZe5Fdw+pXAom+/I+bZInbN2XEC7IyQ2y59lmI/Wz2d6fBCp7hLf1w3qylao0JhfU6le2OwsXWYioWfIjxk7ZqY80ekC6a+ze5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a963f49234so12200695ad.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 11:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771703368; x=1772308168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfNpOFLieMaFwE+H4hNSZ85pk8JOCC5kAYrRn1Lw8tQ=;
        b=OiAVTsBdHToYLELZAJ0w0/vfAhCgBkIVF+QKXSlDchUTJa+UmOfutEWpJdWBK97mU5
         zAMXxDAe+JyDrav3yNFqjk6mZw37TYIQsbT6JqJ6WMTFaqyj5mryZd9ruBpcKXOQ+imc
         w/2hQ4/X4llpnQHD4PsGFwGBdEJO8nns0+ib+dz+T45TKRTQmBZcaKZnMsR5Ydmdl0Q3
         URQaDx3yVynf/JxVDhHL6f9iCvr/2RXx97CPVE7l9b4sELQ0pousVK/tUmKmnOoObeim
         Mbn0AAMrjv4oODveNsHuBi2d5n2lXNnmVY7yehYjYeDvokkTA9H4RP4idEGxNNHMHyBz
         4NXw==
X-Gm-Message-State: AOJu0YzroguGkfApEbOtKGWzkK0SXxNDpU1fhSyqE+aiuGmeaFQ1mkRQ
	AS+OSkDx/n/vP//eJNMvVzzR7wZh4bzH7CA0kOGiEVKgIVQiBDEWZXhfxzE2tw==
X-Gm-Gg: AZuq6aI0vuMbRDJks+poVacdGdcipHl6bKZRi2uqGGR81HD+FvmZCmDCkWpjzaQ7HAu
	/YTVLlIHZaP2J2b6IN/T1iR7lnPCEu4ywjc00NFYAuJXp/CfrvHfDphV5t6k3afjUU84A+nQSkM
	Xko1P6L6BoulW+ah+Q2XCRKLFuKE7De8nAArFLAce/RNgHRKMfIYA5K670q3fNsn41ES971M4v+
	VjQoI/biG787DhP4CqZbysKAS3ILsFcMZSW4Bcz8IgVyErmhyHt05AJGJDRKN7jpCSclObTnIcZ
	/irE256CDsBmOqrTie0sA2wmheyvYkvlwJLL6JdABBE3XSvj4DllXm5QGVo+/2Pob0nJAQVdlv6
	eS+VTT3whJri9JxuquW3rPzfgADvHW++rJrR4MrNNyEsb/AsIpEejw4T3obQTB3VX5gaVfGtHfb
	/j3D855rFKXdP7IqP+cJWycnOufA==
X-Received: by 2002:a17:903:286:b0:2a7:5171:9221 with SMTP id d9443c01a7336-2ad74553a82mr34370555ad.42.1771703367643;
        Sat, 21 Feb 2026 11:49:27 -0800 (PST)
Received: from kb.localdomain ([1.38.141.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7500e318sm27014145ad.43.2026.02.21.11.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 11:49:27 -0800 (PST)
From: Karan GB bhatrekaran83@gmail.com
To: git@vger.kernel.org
Cc: KaranGB83 <bhatrekaran83@gmail.com>
Subject: [PATCH] added error lines for no 'want' line in git upload pack
Date: Sat, 21 Feb 2026 19:48:41 +0000
Message-ID: <20260221194851.84071-1-bhatrekaran83@gmail.com>
X-Mailer: git-send-email 2.53.0.154.g7c02d39fc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: KaranGB83 <bhatrekaran83@gmail.com>

Signed-off-by: KaranGB83 <bhatrekaran83@gmail.com>
---
 Documentation/gitprotocol-http.adoc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
index e2ef7f0459..0f735de216 100644
--- a/Documentation/gitprotocol-http.adoc
+++ b/Documentation/gitprotocol-http.adoc
@@ -440,7 +440,15 @@ The server MAY walk backwards through history or through
 the reflog to permit slightly stale requests.
 
 If no "want" objects are received, send an error:
-TODO: Define error if no "want" lines are requested.
+Then the server must treat the request as INVALID and the 
+terminate the negotiation.
+
+the server responds with:
+
+   S: ERR no wants received
+
+It indicates that client failed to specify any object to fetch.
+The server must not continue when no `want` lines are provided.
 
 If any "want" object is not reachable, send an error:
 When a Git server receives an invalid or malformed `want` line, it
-- 
2.53.0.154.g7c02d39fc2

