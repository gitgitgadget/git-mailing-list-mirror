Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214563;
	b=ouhDp1QTMw9ttLTsCIVr9ytUNVW2w+ilnFc8o7jN0hgl6YYoHpIFRoFGFAFt6gU0yrwe
	 Q1/FjrLrflNtzsbrErEvV2r1sujzQhWqaUfG6eV7XWfeaKscOtzAGyNfVepAak1sYa/oz
	 9Xorn/Aq/i9ZpOYYt33ZDJ4tMYFtgVPVvKzW4rESGFXguhMtwJMoE7YbL25bCA/OqVPY4
	 aQP4a65Gjnv/q2CBQtPqsk9yPPnTAXo1tt1u7t6SgqX3OtFt6MP//YmCPV9WG1v4MYmxj
	 9VNtvTvzJmtKzDF6nBd7hAFPf/zCB6wAYf2lhP/Y0rJWBqVc06DmhQq8iUakGQsv+0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+TAoYlJz6mszii6hY2siS7SA01OJK2e2PhZ9j73zw2A=;
	b=le3To7M6/qtj3QcOa9D/LEi5ldWxSHD4VS1tWfpKg5/zBzSFda/fennU+EkQL4RXVW+V
	 VSyrIYW+qSbCn+0gR700AiPFKfKEq15kDWHI7Aj1AMDewSnfGIs+JUkr7kqHiXFv4n4tB
	 62hnuDiyVRKUr2m2/AOgzyqeAFa03jqwHaqYUWI0exHz62VHCXgFRw2dqtYwDhO9SCzgq
	 MKcwLwq8mBcfVLidHy0Ni0bSlSPaxqj+178dhnLOfq6CHx2ca/r35ypb4gFZVSCnO6A/f
	 XQRde/Rc69AVqfKYFBNkYI/Cz1BC7L31jfJGr5wDNN43BcPFaC2Cf8a/1QAznqW2s2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RXsOOaYw;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7D606A6A1
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 22:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9C7D606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RXsOOaYw
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c506a231b88so215746566b.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 14:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795214558; x=1795819358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+TAoYlJz6mszii6hY2siS7SA01OJK2e2PhZ9j73zw2A=;
        b=RXsOOaYwOxWoQSpELMad4/1wNfZjkrCVRM+BAcMAO2WOyh78iTQB/bOySRlnYQnNOU
         nnM+nqsi0UaNEd82DxRYHzOWjEYAVjShvDwqFFAg2C5uqLJ/C7ERctwWtZDzpowRDjF4
         lBZdQ5C/ziU2pTIe8GOmQjVA2EfZofZPP0CkmfvRzy9JWYYJdVHa3KX0k+900oIGPQ7E
         +blrnKZK6yE1/civFNdYNyi6v3e6vncFQruZXfR+nM/ZPC62HDYHollP2ITBlXrbIGVP
         rmX0YVyoqw3TCdbwIflk9sByA2CdZ+DZqwHkpRZRfSqSG4Qc+NhoES7Qg7ysdYnREq8e
         ULEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214558; x=1795819358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+TAoYlJz6mszii6hY2siS7SA01OJK2e2PhZ9j73zw2A=;
        b=BU6E6S5SOWZSduIXT3msK7eotO0fIgPV4Ob2/9guYSQ78/eqm0ULXzUaCR/8OWhO9E
         WDjABOvXdqfCWRlKcLC1rPG0hZHlAn8akqFpOVBoGIyla4pHCMDuBeSYSacz2ra3fZr1
         zT9lB//iWHO0xYg2b31BzrjTswZnpGfWLwekNY2KHqGsyWw5DHvfGhTcr3HVFLB1zxsd
         sV1l8ThkNnanRchSQrDt0LETFrWZjUtrMJebeIAx7/Ss69Tmb2iAMcb/K6BuKSrfli+Y
         njlKqpsNUSGpIK+bZwwBvzLjh2mN2fTWEa+JzF7xSXWYei+oauUa422a039G9qGK4AvR
         ZZDA==
X-Gm-Message-State: APuU4Z9l2MnwRktFDUTgpppiDM6vtqvzFku+t9P8MtY+pKYGYp2j9pvB
	jgP6EHP1ktPA8L0Ff3nOzKXJMk/OU5pZLKlVncH5no+Yoa0Sw5HNx6u74LOwz5lI
X-Gm-Gg: AZFdTZdPtwBwEeSkFyio8oAqMzEnZt9LUBR/rTOZja8V6Xw7jt24YvXCOxNMcp+Rbbn
	dJL5obPhGC+n5mvVv52/Jqt+yR9BamE1PLDGgkvZoeyuJS0g2YqcWzMWLdQDALqTZObe5c0IX5K
	mW7y+1NIazxAwkFbu3fsCtDY6/qB8cP8YAbRv+AyzJzaltOJZP0JlSgYsel3aYqxybuRVoHICQZ
	0uCHikMnI7Gcs4LWE29ob+uuDexI7Bvf9iPdlfndgPmikE5g/4yy3yWNaBJBTB1rrBKuUJRmDmX
	cQ7Cz7lMEeORuhnV886koqZkc7yVBDiA7BOTjhmK9NAsmnSgrwl4uGqcud3TJOmUezRKoBrVlRQ
	dKryjWQtoibvUc10xsF3wYOEHAWoDlLlWetDOkl3TqSqQ5LXDnHuONIoW+cISdA2rPR/Ovwges8
	qZbuxOhfvRYmwm1jrsRdbIIAx7llv6smYJYMxhrDje4DzHPwsg0I6AviighNZ9rk2+sWyQgEuDg
	Fxm7Yi1TUoEbFG+qh45NiYN5vPbzEfI8cd6kjGD5uV+Vm6TeTXA9ocWpjwe4K6OU0Jw+K9jQbxt
	Sx94ltt0FDmc4pJglG0HkKSo4RLh4ZdMXOPGvvuhWMJiWn5B+8J+g3Jplv6wrFLgW2DDOeGSMTe
	1XcGx9EAspUNwvth5ZxD7tR7sw31nBSpZG/aYgcff2tczftGW4laRES5qxtJtpBNCM2kODcVIet
	+ReqP1pzAyOT19T1c7ZH/qI3ll2R9V
X-Received: by 2002:a17:907:3c8d:b0:c4d:8e7:29b9 with SMTP id a640c23a62f3a-c513a43532cmr434053966b.5.1795214557918;
        Fri, 20 Nov 2026 14:42:37 -0800 (PST)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513b030ed9sm142226666b.86.2026.11.20.14.42.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 14:42:36 -0800 (PST)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH v4] doc: wrap emailed text to a maximum of 72 columns
Date: Fri, 20 Nov 2026 23:42:27 +0100
Message-ID: <20261120224227.932-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120110215.42209-1-okhuomonajayi54@gmail.com>
References: <20261120110215.42209-1-okhuomonajayi54@gmail.com>
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

CodingGuidelines, SubmittingPatches, and ReviewingGuidelines do
not say how long an emailed line should be, or that there should
be paragraph breaks for readability.

State the limit in each: wrap the text to a maximum of 72
columns, matching the commit message convention, so it still fits
on an 80-column terminal after a few levels of quoting. Lines in
a paragraph stay within that length, and a blank line signals a
new paragraph. Tell readers to leave a blank line between
paragraphs. A block of quoted text counts as a paragraph, so
tell them to leave a blank line before and after it, too.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
Changes since v3:
- Say why a blank line marks a new paragraph, and tell readers
  to leave one.
- Say "human-to-human" text instead of "patch message", so this
  is not read as wrapping diff lines.
- Say "before and after it, too" for a block of quoted text.

 Documentation/CodingGuidelines         | 8 ++++++++
 Documentation/ReviewingGuidelines.adoc | 6 ++++++
 Documentation/SubmittingPatches        | 6 ++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 23a4d2186a..ff4829e8da 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -33,6 +33,14 @@ Git in general, a few rough rules are:
    achieve and why the changes were necessary (more on this in the
    accompanying SubmittingPatches document).
 
+ - E-mailed text intended for human-to-human communication, like
+   log messages, explanations in cover letters, review comments
+   and their responses, is wrapped to a maximum of 72 columns,
+   matching the commit message convention, so it still fits on an
+   80-column terminal after being quoted a few times.  Leave a
+   blank line between paragraphs.  A block of quoted text counts
+   as a paragraph, so leave a blank line before and after it, too.
+
  - A label "NEEDSWORK:" followed by a description of the things to
    be done is a way to leave in-code comments to document design
    decisions yet to be made. 80% of the work to resolve a NEEDSWORK
diff --git a/Documentation/ReviewingGuidelines.adoc b/Documentation/ReviewingGuidelines.adoc
index 6534643cff..dd164e0010 100644
--- a/Documentation/ReviewingGuidelines.adoc
+++ b/Documentation/ReviewingGuidelines.adoc
@@ -116,6 +116,12 @@ guidance, and concrete tips for interacting with patches on the mailing list.
   unrelated to your review from the email reply. Make sure to leave enough
   context for readers to understand your comments!
 
+- Wrap a review reply to a maximum of 72 columns, matching the commit
+  message convention, so it still fits on an 80-column terminal after
+  being quoted a few times. Leave a blank line between paragraphs. A
+  block of quoted text counts as a paragraph, so leave a blank line
+  before and after it, too.
+
 - If you cannot complete a full review of a series all at once, consider letting
   the author know (on- or off-list) if/when you plan to review the rest of the
   series.
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index c60855f706..747e6adc79 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -700,6 +700,12 @@ WARNING: Be wary of your MUAs word-wrap
 corrupting your patch.  Do not cut-n-paste your patch; you can
 lose tabs that way if you are not careful.
 
+Wrap the prose you send to a maximum of 72 columns, matching the
+commit message convention, so it still fits on an 80-column terminal
+after being quoted a few times.  Leave a blank line between
+paragraphs.  A block of quoted text counts as a paragraph, so leave
+a blank line before and after it, too.
+
 It is a common convention to prefix your subject line with
 [PATCH].  This lets people easily distinguish patches from other
 e-mail discussions.  Use of markers in addition to PATCH within

base-commit: 7fb6055e678f800320d8ab8cd8f201d9493d1ba0
-- 
2.56.0

