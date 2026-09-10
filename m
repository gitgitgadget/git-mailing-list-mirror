Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E425A514E
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069453; cv=none; b=CwewTHbb838YYdOZF8Pb73oRvuwnjSscJYbz8Nsufiitygj+ECNtP2nEHkixcpaDZleEBp+De46mA2tKmWg80RSmKmByOoJMA4ixl+MjjdDPg3MyQEMuyJfhRe4DEZI3IJOYmD4NnwJN/jObBVGoMYZY2aZmAuHK/poMmyiKnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069453; c=relaxed/simple;
	bh=BZX8Kpx21e52dh4dAIwt6P+wgW/HXabr2WYU32DCVv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CINvlqoDhaTSNAywijrH4MaDgCDGpy2b54BW38aDnYyteaAVLa+XaUZQwfslr7VYIv6zpDg08YtFjRNXh1z1+DQL8GnYoAm4YwoWkAho5EJk+ILvfbG7nmuvl7C0vORYjfgq90xMYnSDFsuYU9RCBBBVQ9QU+JN/ZAHDCo1rZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=A7ndTTC3; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="A7ndTTC3"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68AJi4jx016481-68AJi4k1016481
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 10 Sep 2026 22:44:04 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4kgm-001on1-P0;
	Thu, 10 Sep 2026 22:44:04 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 22:44:04 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 187354b7;
	Thu, 10 Sep 2026 19:44:03 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 1/2] command-list.txt: add gitformat-loose(5) and gitpacking(7)
Date: Thu, 10 Sep 2026 22:43:50 +0300
Message-ID: <20260910194351.20809-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260910194351.20809-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20260910194351.20809-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=bz2Jno+u/iilekVBRoEQwAWnwpcCOQP4ADRs5g11TN0=;
 b=A7ndTTC3DCcdxBRVBf4BV3iDe2KsnjyxLs6hsMjgWbVszOij2cL29DvulDJJb4mEgZx5bYKAEO0q
	G0GfMOEGBavSLGKcVfYPdPuZ4sqY016Cq0j3lkvvd7XSJ511tjW217QZDRApF1oauniQcQPMQWCa
	oKThNsD+UtsFNZx5Sks8Lmg9PfRj9riRd0+D/+izNgVXx3GfIh3eHkD54vW87o/H9aJYm7QV3GSP
	Nxj3OxXjp/o8NElD3UUK0RA7Rj+/Yq4VeOI6Zjob4LxSaDl6JfxBZqbBtMY/SOYz/CqsJW9M9Pn5
	Mx7U+f06D+ioJyoDIKlzw7LKahwZ5LK7R/+hHg==

Three manpages from sections 5 and 7 are not featured in
command-list.txt as concept guides or interface manuals.

As easy fixes, add gitformat-loose(5) to 'developerinterfaces'
and make gitpacking(7) a 'guide'.

That leaves only gitweb.conf(5) which could be added to
'userinterfaces'.  However, the manual would then appear
as "web.conf" in `git help -a` which is just confusing.
So, perhaps we are better off by leaving it out.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---
 command-list.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/command-list.txt b/command-list.txt
index 21b802c420..6667930e8f 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -224,6 +224,7 @@ gitformat-bundle                        developerinterfaces
 gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitformat-index                         developerinterfaces
+gitformat-loose                         developerinterfaces
 gitformat-pack                          developerinterfaces
 gitformat-signature                     developerinterfaces
 gitglossary                             guide
@@ -233,6 +234,7 @@ gitk                                    mainporcelain
 gitmailmap                              userinterfaces
 gitmodules                              userinterfaces
 gitnamespaces                           guide
+gitpacking                              guide
 gitprotocol-capabilities                developerinterfaces
 gitprotocol-common                      developerinterfaces
 gitprotocol-http                        developerinterfaces
-- 
ta/command-list-guides-sync-lint

