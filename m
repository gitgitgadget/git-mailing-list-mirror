Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538F51B11F9
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111580; cv=none; b=kIjW6w/CiENjARGwHeDLln6FX8QzT5JYfi9/fk13bMo9LMOwzV5WPIKCcVoZYfDG0Tj3vZ5Z6OVkCqIokQEokpuqOP52WUnDC3RcZIQXsix6i6u7L9hyNXOqwV5qnbwdAK1i/Q84z6A2BdDjaRW+w4IoKGkwBHocRgb8Neljyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111580; c=relaxed/simple;
	bh=LRxwrWopuD2T6+NRa1Epruza1GXk/FM0ZRaIDG7OBBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0TZkd/EOUgJd9/yJF99zIgvhTsn04Ah6DxdsXC0kKjwd0Sh1yzm9UHDD5C3BH7xNQqqnhEMsbiM+hvMtJQCn09FCgIEr5cM2DgYbDvmhDhiq3a7shIF5Y7LETX+c1Ngem5Q/K8+w1VXTjpUMjhdgKLy88XLJj0XecpTdkYMN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIm/MZqd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIm/MZqd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42578fe58a6so5465805e9.3
        for <git@vger.kernel.org>; Thu, 04 Jul 2024 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720111578; x=1720716378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKbZb/cuDI5wILaOUD34JUoFJHsS+LJDRsDcbIh4lRs=;
        b=kIm/MZqd+Sv9XxoGaOLuT6YynaUcy+FbfyurRa7x+0jPxf3Q0adLtZZcxs/mSwPBTA
         J8G+Q+SWhhtnGCV3x6OzECeuwla7aeO5nIY0qqNfTdraGYNP3hpvO9AcyNtt/Vp2+2Sd
         eBAxVNYdwIy3e65mlCCIH8Ph56+xVqmO1ZlY/RDtS19QPBFwxl8knjQG2HFsZ7ruQ+t3
         koBDjfXL8lPx+gghbJmV6fqXpSyRtSBM6dTA9vJbfSk7ryPWx5h1VMB6Tuf5Gnk5SunS
         kCDuEZpi95Ouf8fji479eLt/PG+PiOL6GNGnkWWW9v3t9pzb5IUEzzbftgZzrloQ/g6h
         WcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720111578; x=1720716378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKbZb/cuDI5wILaOUD34JUoFJHsS+LJDRsDcbIh4lRs=;
        b=dP0iwG9hDPrU63TMAey6a45p1FC+HOc+NrsSWFsOjUrocioDCGcj3lT1jDxqLcACa6
         zsVkPgr4RIXKUos6aS1NyxECG9tywzrMmpjvH2E/BoTlqREd2u1Sw+WTQsauc9WhcNFe
         0kZ63b9sxbfeRfBeGB57vb+fYKowZBRQVFp0DItZblpCR89+JPHAs/fcYCA3hZgE0rG9
         UTtMYejlHuVojQGXEYhammYhHwpHtaevdHjj/PQFWd/rT+BMJ6MrEgvrJPRGuHzZhP8Q
         xUS+1XCd6j8vXcvI4FBwbiUurWW5kVCaLLIk1BwtMcmVwYjGOy55TVbi/2hUdvuX8280
         TEDw==
X-Gm-Message-State: AOJu0YwvDfx5TqSYg05ePumyYogvp96bphe6qQnriFSjcfQmULSUsSPi
	cAqvxro8oliiY0i0f82ioHCZqycPm8GMd1Z50mBXpsyY1N94U0bH7c4L0msE
X-Google-Smtp-Source: AGHT+IH6r7iAyKKqdNvSqJAwjBgEAOuA9jmNcZRr6x+zBkSPWkmLQeJtPy73hbjhvkN2DLP6YSZcoQ==
X-Received: by 2002:a05:6000:1a46:b0:367:9cef:f41e with SMTP id ffacd0b85a97d-3679dd73b3dmr1794982f8f.57.1720111577492;
        Thu, 04 Jul 2024 09:46:17 -0700 (PDT)
Received: from archlinux.. (255.red-79-146-1.dynamicip.rima-tde.net. [79.146.1.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367892a4817sm7280416f8f.10.2024.07.04.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 09:46:17 -0700 (PDT)
From: =?UTF-8?q?Jes=C3=BAs=20Ariel=20Cabello=20Mateos?= <080ariel@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Jes=C3=BAs=20Ariel=20Cabello=20Mateos?= <080ariel@gmail.com>
Subject: [PATCH] gitweb: rss/atom change published/updated date to committed date
Date: Thu,  4 Jul 2024 16:45:35 +0000
Message-ID: <20240704164547.94341-1-080ariel@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the published(in rss) and the updated(in atom) date
used is the authored date. Change it to the committed date 
that betters reflect the "published/updated" definition and 
makes rss/atom feeds more lineal. Gitlab/Github rss/atom feeds 
use the commited date.

The committed date is already used to determine if more items
should be fetched.

Signed-off-by: Jesús Ariel Cabello Mateos <080ariel@gmail.com>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ccd14e0e30..0ef5707557 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -8329,7 +8329,7 @@ sub git_feed {
 		if (($i >= 20) && ((time - $co{'author_epoch'}) > 48*60*60)) {
 			last;
 		}
-		my %cd = parse_date($co{'author_epoch'}, $co{'author_tz'});
+		my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
 		# get list of changed files
 		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-- 
2.45.2

