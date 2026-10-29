Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299772;
	b=AqgEF2EsMq7jxdwxMqsFX79Ur3dreSZbasRru/v3TaF4RttV/XdpUG+ybBhhxfyyTJI7
	 PYNlhkk6VPbSVF3lkxLPNuLmpWheGg0RYbzWjQkbUtzoJsjxcIsd4edzKS7Gn/QDTkper
	 j4je4oTBL5umwOnyO7EiE4OR7VhOvBVYe9UF4isT80Fz5YoEzZFpPWiTr8hAX4Xft/qyP
	 avOBzEoka5mCpoGhCaOAbQ1s/44KtkgOGyxk+r3O73SasWqiiw+y36BfHvkbyD7Qywi1T
	 DiJe1Qzv2Qm7EcxESNXB2/OWnzkbcK0p7WpSNLStstzvfRY0sa/51Exg0zh2zan+peA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299772;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-FEAS-BEC-Info:X-FEAS-Client-IP:
	 X-FE-Last-Public-Client-IP:X-FE-Policy-ID:X-FE-Hostname:
	 DKIM-Signature;
	bh=qOCbk0KJGTtFWEJTzgbxZnJdtPHsyz8PW3mZq2rqyZs=;
	b=3plkjmDrKOwT3DlGkZrR/B7O3gpNKPCk47LZ6ouzb6KHQkpiK9uIwWqcZci1vn/w/yNy
	 KOdnMsA54Fm+h2RMr50gMts2+Ipb90+GmEvM+afNl4xWRKUaDIoKex4VfSQqIWtOYnvIL
	 V1iAAnm9n3m8A8h+dO8QdU2dsWo8ODLDfxUdDjUFUqkh36Xk9SgVfQtMCfX60VeHhsXvb
	 uLCTu17516oc2Ezn4Crq2SA9mm/8juiqcRtp67aEb8uD19CJPPPcZ1dYh1TCguEypQKgT
	 R4TPQ5OKoPfMOamSglG9rCoc2j0yfISN2hB9LQl2ektvxjXcVdYyXx3DmGQUbaUIHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=lBfHVTw5;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F173606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F173606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=lBfHVTw5
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69TImo7L018596-69TImo7N018596
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 29 Oct 2026 20:48:51 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xMVBC-00Cjtn-Rb;
	Thu, 29 Oct 2026 20:48:50 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 29 Oct
 2026 20:48:50 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 9211003e;
	Thu, 29 Oct 2026 18:48:50 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>, Patrick
 Steinhardt <ps@pks.im>, Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff
 King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v3 0/2] guides: keep Documentation/Makefile and command-list.txt in sync
Date: Thu, 29 Oct 2026 20:48:32 +0200
Message-ID: <20261029184834.2273-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260909052501.8448-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
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
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWEgLBwwNKAMACR0PGwoJAwNG
 BgkFDUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXkhYSFhIWEhaWEgLBwwNKAMACR0PGwoJAwNGBgkFDUhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gP
 ARwbHA0aKBgHCgcQRgsHBUhYSFlbSAIdBAEJKAIeBhtGCwlIWEhZW0gYDQ4OKBgNDg5GBg0cSFhIUUgYGygYAxtGAQVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=qOCbk0KJGTtFWEJTzgbxZnJdtPHsyz8PW3mZq2rqyZs=;
 b=lBfHVTw5ltu1t4x0uV6hQUstrkc/RLla6bDUv3qtx4og08xcb+a+BYCKQNTbYZy7w6Rc+PUDBKW8
	Pr9W90kaDq67izRcesDDmy3xKkFFu2zZMEQt7lj5WINlmTiT/jfRM8vNbwMYVSTyIceYTbXHYlJP
	V2Y1Qu3hPT637Vq9tljeVy9PCUH8opIMu1EU4yvekSp5cYbRbzgYYkWg5ir11m0OyYcfDOVT0Y8K
	r1DGhe3l0aPtgnlnQL+Ej+VfPmBWOK+x+/MDt7LGYndKzaIKwBp3Bi3p0wXyh8czFlIeLXiSZ4eP
	lsWPDoNIHc+GpnejJBpTU9aVNFtSCLefuHERYQ==

A new linter test has been added to Documentation/lint-manpages.sh
to ensure that all non-command manual pages (concept guides and
interface manuals) listed in Documentation/Makefile are present in
command-list.txt.

Changes in v3:

* [2/2]:
   - Exempt obsoleted gittutorial-2(7).
   - Even more defensive quotation.

Changes in v2:

* [1/2]: Use command-list.txt as the area identifier.
* [2/2]: Protect variables againtst whitespace breakage per review comment.

synthetic-base: master + je/doc-remove-gittutorial-2

Tuomas Ahola (2):
  command-list.txt: add gitformat-loose(5) and gitpacking(7)
  lint-docs: check the guide list in command-list.txt

 Documentation/Makefile         |  2 ++
 Documentation/lint-manpages.sh | 11 ++++++++---
 command-list.txt               |  2 ++
 3 files changed, 12 insertions(+), 3 deletions(-)

Intervall-diff mot v2:
1:  cb6ce6cad1 = 1:  9a1ba61ac0 command-list.txt: add gitformat-loose(5) and gitpacking(7)
2:  2dc1ee4514 ! 2:  5d36d75859 lint-docs: check the guide list in command-list.txt
    @@ Commit message
     
         Adapt Documentation/lint-manpages.sh to fill that role.  Extract
         MAN5_TXT and MAN7_TXT from the Makefile and check command-list.txt
    -    against them.  Exempt gitweb.conf(5) from the new linter routine.
    +    against them.  Exempt gitweb.conf(5) and gittutorial-2(7) from the
    +    new linter routine.
     
         Signed-off-by: Tuomas Ahola <taahol@utu.fi>
     
    @@ Documentation/lint-manpages.sh
      #!/bin/sh
      
      extract_variable () {
    -+	file=${2:-../Makefile}
    -+	directory=$(dirname "$file")
    ++	file="${2:-../Makefile}"
    ++	directory="$(dirname "$file")"
      	(
     -		cat ../Makefile
     +		cat "$file"
    @@ Documentation/lint-manpages.sh: check_missing_docs () (
      		git-stage) continue;;
      		git-legacy-*) continue;;
      		git-?*--?* ) continue ;;
    ++		gittutorial-2) continue ;;
     +		gitweb.conf) continue ;;
      		esac
      

base-commit: b9e5cff1803ab24582201ef059516eb16014b9d9
prerequisite-patch-id: 7f3cc00ab656bf1192d93c2e6a434c0d0fda2b6b
prerequisite-patch-id: eb8fbd9fc3f96e3cbffddbeaf47b99f397e5330b
-- 
ta/command-list-guides-sync-lint

