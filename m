Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313567;
	b=VFZzzbIl2M0RQy4kfvRkn21lgNs11iLwS16hqvcjY7xTi8ZeYfQa4tlcgFNwEJfLfqZy
	 WWwoCAyt9JGeyKR2qHesFd2ZptMZXS2QGcxzX6aN/1ZdG15o7coHr4al1FEOWy8xXohsW
	 ATEUwti2zryUK2Ws/iVeT+L7fqUMcrfR5IezAazt2VY5r1M0mtNYWXa+9dvKuQ1Afpu+z
	 0yhlsFtnae1vAXAfXnesq/D4De2jR1VhXS0xN5Nz3JLoAqiQDgAg7rpCH8sex9RblTuHE
	 J/LDQbHo1QUygjujZbC2xhvXe+SeUA3GPUw1C5YdvKUkJvCSzoH97CAMT7oJKjYXJkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313567;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=1PG8L9lsz99gTRM1iwsMSMFRrgH0QabUCyGwAoJphz0=;
	b=vdPkwU0lRlZ+ijy/t9q96nIw3vX2SfLfGffnK+4Fxb8JLRbEN63w5BOdxzuQ+uE/SoAf
	 gEt7Dn7QYI/ZwIno23VmR7Z1a+t+hWpGDg2KBvsVDfdSyQ5GZY0vZlKisRPSNrKnl26pc
	 S2kwaWoUfVI0vJ6WN2q9IiTBsECEyQpjrFN8AHBukAugm28ENH2e4ZpKrHWBzf8bsjiYD
	 KvnQZ3jtkgBzadjo/2RLktZoesDrESIjftBUfLUwsTcF5+8780VqNYkG75TTTpIAzaoEe
	 cMZF0FIug8VMSA2xAM+UY8vF7jKZ+NpAQjOhK++Dhk2qftj4tca3gOixie+1NyvCKbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fYcdwi36;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C9606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 22:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9C9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=fYcdwi36
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69TMd4kW024892-69TMd4kY024892
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 30 Oct 2026 00:39:05 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xMVBY-00DBJe-ET;
	Thu, 29 Oct 2026 20:49:12 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 20:49:12 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 7300a0a5;
	Thu, 29 Oct 2026 18:49:11 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>, Patrick
 Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff
 King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v3 1/2] command-list.txt: add gitformat-loose(5) and gitpacking(7)
Date: Thu, 29 Oct 2026 20:48:33 +0200
Message-ID: <20261029184834.2273-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20261029184834.2273-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
 <20261029184834.2273-1-taahol@utu.fi>
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
X-ClientProxiedBy: ex19-15.utu.fi (130.232.247.55) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEheSFhIWEhYSFpYSAsHDA0oAwAJHQ8bCgkDA0YGCQUNSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlfSA8B
 HBscDRooGAcKBxBGCwcFSFhIWVtIAh0EAQkoAh4GG0YLCUhYSFlbSBgNDg4oGA0ODkYGDRxIWEhRSBgbKBgDG0YBBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=1PG8L9lsz99gTRM1iwsMSMFRrgH0QabUCyGwAoJphz0=;
 b=fYcdwi36OeVvQoRYpkONHLgJuFe5g+UiiWAxBovBBugCs+wCKiHOrzqVLCi4ql8KWxfTVQZKCeTj
	lbBIuRGhabWVxFY16GeRye62dH2Uli3Xnx2DWDwqzB4oyqQcBqJH5GqmtnsAhQniBeu42KqouwFG
	9ulpmXRCRUSKjEtJ/0JtVxUaawW4HHYeZrvC6lzSiYMiiX/kp0vp+Tjs3iQFfqbrAmCZqspC6MPq
	K/wrszv8035viqHCOCchrNMZrEm7+tVtEEWTJMhO6EnQz2BsLsWMC/IJ3O+N+Bg7Io7lkjS/0VS5
	iuy0LLrJ/DBAuwWO7/8ORGatbrWhfQZx67ojhA==

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
index 5c649c882e..d96f56a379 100644
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
@@ -234,6 +235,7 @@ gitk                                    mainporcelain
 gitmailmap                              userinterfaces
 gitmodules                              userinterfaces
 gitnamespaces                           guide
+gitpacking                              guide
 gitprotocol-capabilities                developerinterfaces
 gitprotocol-common                      developerinterfaces
 gitprotocol-http                        developerinterfaces
-- 
ta/command-list-guides-sync-lint

