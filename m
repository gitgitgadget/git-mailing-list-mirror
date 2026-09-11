Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB4582BBA
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 19:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156405; cv=none; b=QRRBv2wY/fAxcozIUGDytLyQ4eyONbyTS21WT237nmoIoWWOt8lWR0OQUQW+qFYsX+fK/69s+DSkplXlXIbOheOX+RC26/lRRxzOFovMR1l0UUdznbVjWo63RTwJCKwyLF9JgtMMEbIxGWi0GfTLYy62bP1YD9itcA6dtwGwUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156405; c=relaxed/simple;
	bh=heFpzXhdEq83rbkeixA+4H9I6PN9hfXJyfj7BXBeHhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4VHuAhJ9P9AgGlLQMEw2pz2o0z9LPve3e9sY2jFWSrIjQfdNkwDL1MZKl3SGMQNb/F6LDeOjXYbZydNChfuS0IoQSsBlvz8DFsUNWhY++PKrFduNQX5k6xznp0cOfmQhBgF128c869BcHky85yG2gUQKCv39vEcgt+xsYGqsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=U48/gJhQ; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="U48/gJhQ"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68BJqsYk022910-68BJqsYm022910
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 11 Sep 2026 22:52:55 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x57Is-006Oi0-SH;
	Fri, 11 Sep 2026 22:52:54 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 22:52:54 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id cd339218;
	Fri, 11 Sep 2026 19:52:54 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, =?UTF-8?q?Jean-No=C3=ABl=20Avila?=
	<jn.avila@free.fr>, Jeff King <peff@peff.net>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH (RESEND)] ci: use system asciidoctor
Date: Fri, 11 Sep 2026 22:52:50 +0300
Message-ID: <20260911195250.31201-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260902071113.GA70165@coredump.intra.peff.net>
References: <20260902071113.GA70165@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZXkgCBkYJHgEE
 CSgOGg0NRg4aSFhIWVtIGA0ODigYDQ4ORgYNHEhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=Hr7UgP7i07f2YrMG59nabgYZuEMC4hc3NSWrYkGx2a8=;
 b=U48/gJhQDAUwgYTaDIfZaQwcXLLpEHFEAghPeNosplfbZnFAsffDAY8rrEfXI95PJomAzNwN46Vf
	tFeERam0xkEuJME+lb+iRvg/ysG0E0PMSFl9CzMWnNZqT6knS3YnbPxAli7iuDQsRlN5yE5laTt6
	q4ydqiQVWGQh07oYnMesKaYHA+xKydmJ6PSZupvuzUKdBTtUC8Osxuk8h6HUUeKCO0hqK1IRRDub
	oFDEabWihHvrvJwfDwmT3ZFbRqUyrmLoEJ+lPofKggjUVAiQY4q0vcF1sFw0QAgT8AR/NKkkzYMd
	gQp2ASqJk66XyyVoOnGQOOlhuJ5VV4sf3WTwLg==

From: Jeff King <peff@peff.net>

Our CI Documentation builds have pinned asciidoctor since 615a6c37e1
(ci: stick with Asciidoctor v1.5.8 for now, 2019-03-29). Back then a few
changes were needed to build with the then-new v2.0.0.

We've since made those changes, in f6461b82b9 (Documentation: fix build
with Asciidoctor 2, 2019-09-15) and other commits. So it is not only
safe to use newer versions of asciidoctor, but preferable: it's what
people are likely to use for actually building the documentation in
practice!

I don't think there's any need to pin to a specific version. We can just
use what ships in our Ubuntu image, which should give us an arbitrary
representative version (and if it changes and something breaks, we'd
want to know).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes:
    The release notes draft for v2.56.0 already claims that asciidoctor
    has been updated to be installed via the system package manager.
    Clearly it refers to this patch which isn't, however, anywhere near
    the master branch.

 ci/install-dependencies.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 2f61fbb07c..d57dce5663 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -164,9 +164,9 @@ sparse)
 		libexpat-dev gettext zlib1g-dev sparse
 	;;
 Documentation)
-	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby
+	sudo apt-get -q -y install asciidoc xmlto docbook-xsl-ns make ruby \
+		asciidoctor
 
-	sudo gem install --version 1.5.8 asciidoctor
 	sudo gem install concurrent-ruby
 	;;
 esac
-- 
jk/ci-use-system-asciidoctor-for-real

