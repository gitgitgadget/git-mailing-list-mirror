Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723886;
	b=s9iYq74uTjozBy5uf3XnSTreg+H7Kb4AGJh2MgjUn3vfDE/Spcp8YVjGvfmji+6+vCVS
	 Vkc7UnP3JgLyelpanMbcZcLTqo1EVXp3Ut5vMhDk+Gr83rUxls6Z0w7TNwiGw9Vtjx8TP
	 Ydu7MxY640rsI9rEB2OkqlQgVGEOVnmajFwnsaFm0p2PFL5d0fn+SdkcaW7wvVB+Ooe2U
	 G3cDwuWilxDzEWdPRpgcoiPNQuvov3Q+1yVPM5/swnq0oG6bJQ5MtmU/roqgcaAi4oPBb
	 BArRGkypLDh6cxU2k16QeaPtF4/GKzVk28aVFyeRRfk4bj1q4+Y4sm/Q4gySEi1AezA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723886;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=1Mai1U2okvnGQHAIN3ZgjHcqajW4/v1Mo3f6ryx7k3Q=;
	b=SsJPFmeU9mOtKnfiVshFWTwAJaCJHr+5U9BEiJacJ4GvLFRZXRNSa0V+ath1Xk+VNe9L
	 aXrZWGgN+x16AoLePNYkDHIlARfiiUWUA3dGW3jvRKbfB8QB8/9aKBTPFnDxAdjNY3J3C
	 hnLQfFWDHiLyu/LI99k0Ebwryj76ozLln/r2PFyiTFqEnUAqBx38Lth1Ott4hyWdmZ80S
	 XXywb9ZVi39kPPG6s+Lee7eUGmo8xhw7/tmmsWMMdXL0Kfa1Kips3MiACA6ZwinVHzji1
	 etBpxkILK/uCdPdgjgqTQzNUHaJ03VenXNCcBjrUW2izzV70BkU5SwOjZmwGLGcg5YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=UcF8Wo+s;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26446606A336
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 20:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26446606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=UcF8Wo+s
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6AQKBBus024203-6AQKBBuu024203
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 26 Nov 2026 22:11:11 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xWfoF-00Co9q-5e;
	Thu, 26 Nov 2026 22:11:11 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 26 Nov
 2026 22:11:10 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 10cbc4b9;
	Thu, 26 Nov 2026 20:11:10 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>, Tuomas
 Ahola <taahol@utu.fi>
Subject: [PATCH v4 1/2] command-list.txt: add gitformat-loose(5) and gitpacking(7)
Date: Thu, 26 Nov 2026 22:11:09 +0200
Message-ID: <20261126201110.9046-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261126201110.9046-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261126201110.9046-1-taahol@utu.fi>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZW0gCHQQBCSgC
 HgYbRgsJSFg=
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=1Mai1U2okvnGQHAIN3ZgjHcqajW4/v1Mo3f6ryx7k3Q=;
 b=UcF8Wo+shGNPXdFa1cD7F5RbuABNSkY03rFZVfMOPZILvDNrRAohI7unL8bR355mQC0iaf5mU0TV
	NHshV8Cps5dJXcSLabls35EnIzwPIL2c3Y0kWsFYBwOhvAv9+kGtNhN0GfwfibMlYZUm8J2kGNmA
	gKQ6qStnzlLgsu2TTNz2Ozfsdrk/srREGi++OwQOkYvtXFvWXW99NkW+Ot0mYvtP9iMtBVjrHrs7
	bd8VjPQSOBiYMA2qjUUArQt8erpnPfnG/s2TaCgJw31z2TR3ZQDtS0QBp/MZNacj4mQ/18nRJTkg
	boC38tjzO2ELZPLGc0hJZlP3HUPNO+mpnlCmgQ==

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
index 56d0d7ed9b..6936ae8409 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -225,6 +225,7 @@ gitformat-bundle                        developerinterfaces
 gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitformat-index                         developerinterfaces
+gitformat-loose                         developerinterfaces
 gitformat-pack                          developerinterfaces
 gitformat-signature                     developerinterfaces
 gitglossary                             guide
@@ -235,6 +236,7 @@ gitmailmap                              userinterfaces
 gitmergeconflicts                       guide
 gitmodules                              userinterfaces
 gitnamespaces                           guide
+gitpacking                              guide
 gitprotocol-capabilities                developerinterfaces
 gitprotocol-common                      developerinterfaces
 gitprotocol-http                        developerinterfaces
-- 
ta/command-list-guides-sync-lint

