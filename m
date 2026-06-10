Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3950F356773
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132129; cv=none; b=An9TalTMjDX2LRgSw34APWgCKFOJ87kaEYFF8zq0t4gbKH0MOZ7auSi7JFlopkK6EcBN25Wq95ZeWlEf9A/0LjkM5e3IyRfkh/yVsDOzTpyVf7xfmntlrHQq2w2A4HvfBKRt/xwR5Z2Cqq4wnV6OnNApOSTzVD/n5f7BYMJedzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132129; c=relaxed/simple;
	bh=5CDmZbG2aBAL1VyrKGMa6vYWtwQC/fNlDXEeIS+DF4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2h+FU1muhAebFy87vKB3ritXE3pG13OmeV9+GjRAW/YRhJl6gVsUCYIXFgin87mpZjIOqoCEpG/z+GIFWAtggS3gY/hrr9t1xQiv+q0fMe5nn+HQINcqNnNhu1nsTDEizea4JSBIK4gSQ2LkOrLXr3HBdd3YqUb+RrqjT5R5KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=dPlBzCWi; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="dPlBzCWi"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 65AMtH6I032421-65AMtH6K032421
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 01:55:17 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXRpN-00Euul-D3;
	Thu, 11 Jun 2026 01:55:17 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 01:55:17 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 0b614def;
	Wed, 10 Jun 2026 22:55:17 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 0/3] doc: config: fix AsciiDoc glitches
Date: Thu, 11 Jun 2026 01:55:10 +0300
Message-ID: <20260610225513.6269-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260610185148.23920-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIW0hYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhbWkgDGgEbHAcO
 Dg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=hfkcC366tS0r/W/P/nLZm1/v+6c7P2ozEth3KXFOm00=;
 b=dPlBzCWiUJbNj3NCKsuuuRFUWoZaun4wJPM3HVkmeFvVGN9NxU/WjvBkek5ruXSJHWiK8S5iiwDK
	AjrggZFmMxzAofv8QLLlDH29MowvWIfREtIXX+DcRc+YaUXOM6VHUk3Gpl1kmxZJpbR6SiB5vN3x
	qpcTeMpddRj8gqSDoN4mIy6K5zbqitwIh+LyUTQ6OtxAQY4Lhb2AmchomvqhtHwkfRbjzTwDYn+V
	BEkAQVt6UyGjIAqDnbCEm1IMYHfZ1F1U/xkGn3ZzpNHBpDBxw6HWwaaopQB8JfASdHOBVHs2XSDu
	x59VeS4HBXunsxHF8JdJv1ThAtVX2UKeBDDFUQ==

Fix various markup shortcomings in git-config(1).

Based on 29bd7ed512 (The second batch, 2026-05-12).

Tuomas Ahola (3):
  doc: config: terminate runaway lists
  doc: config/sideband: fix description list delimiter
  doc: git-config: escape erroneous highlight markup

 Documentation/config.adoc          | 4 +++-
 Documentation/config/promisor.adoc | 2 ++
 Documentation/config/safe.adoc     | 2 ++
 Documentation/config/sideband.adoc | 2 +-
 Documentation/git-config.adoc      | 6 ++++--
 5 files changed, 12 insertions(+), 4 deletions(-)

Intervall-diff mot v1:
1:  224303c555 = 1:  c9131b23fd doc: config: terminate runaway lists
2:  a7e6b82c97 ! 2:  ca65211ea4 doc: config/sideband: fix typo in adoc markup
    @@ Metadata
     Author: Tuomas Ahola <taahol@utu.fi>
     
      ## Commit message ##
    -    doc: config/sideband: fix typo in adoc markup
    -
    -    Fix a simple typo in AsciiDoc markup.
    +    doc: config/sideband: fix description list delimiter
     
         Signed-off-by: Tuomas Ahola <taahol@utu.fi>
     
3:  7d0916a874 ! 3:  0341a4bde9 doc: git-config: escape erroneous adoc markup
    @@ Metadata
     Author: Tuomas Ahola <taahol@utu.fi>
     
      ## Commit message ##
    -    doc: git-config: escape erroneous adoc markup
    +    doc: git-config: escape erroneous highlight markup
     
         Paired octothorpes are used in AsciiDoc to mark highlighted text,
         <mark> being the equivalent HTML tag.  To use the symbol as a literal
    @@ Documentation/git-config.adoc: OPTIONS
      +
      If _<message>_ begins with one or more whitespaces followed
     -by "#", it is used as-is.  If it begins with "#", a space is
    -+by "\#", it is used as-is.  If it begins with "#", a space is
    ++by "\#", it is used as-is.  If it begins with "\#", a space is
      prepended before it is used.  Otherwise, a string " # " (a
      space followed by a hash followed by a space) is prepended
     -to it.  And the resulting string is placed immediately after

base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
-- 
2.30.2

