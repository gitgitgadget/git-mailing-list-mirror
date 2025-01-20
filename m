Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB310F9
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389071; cv=none; b=Dv0rKaCW8z91hBTQ4NhT0xzz7GulXgtiNt0vzhSM/mRqmucJDVLjODd7f+/K3FD67y2EB14OwyaV5SS/7OQ3+LrnXgdTrFFmj8URjyukLKSlgg5oHAn76bYYkxeAtmyleXuzDOuH4UxB7isN12LS/HQT4psCDNPYYv/WBkerFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389071; c=relaxed/simple;
	bh=cNdPbWwFbM8YbJ8y6pgvedBBTsavma14oYF+8P9gk94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IVb3StzIe8ucoagA533xTDpyjk9p5vMvv/7vfera8xTUI6a0L8hvcm0BCcih0r/JrOyPimCuPdERiQ4dvTOaPKJZZ7VwJhfX6AK25Z8E1+UVPC5ugINY/gDdl+y32h2rEtoRalLFv+9jNpeMlKG3jrduLYROqgl9Bdy8tlKTXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk; spf=pass smtp.mailfrom=mavit.org.uk; dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b=S7lgrMZb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mavit.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mavit.org.uk header.i=@mavit.org.uk header.b="S7lgrMZb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso32360755e9.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mavit.org.uk; s=google; t=1737389066; x=1737993866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=yFRjdaoII/QDPkVUa/UW2ij8oS63PCGE6uhur+vloA8=;
        b=S7lgrMZbqqE8y0fffl0mrWASBOwauWRDr3i/in+c5hfYMms5oAmWULfS2ojtf9vm/v
         zuzrBL9p2RKRU4qOwPke2M12sSyfdo5lEMZeQydwhyIpoTKbSQnhLuMafKU5QRApYKDJ
         yCmL4NoN4aD7WEDnJM4U5OeOKDIwDuTrX0yrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737389066; x=1737993866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFRjdaoII/QDPkVUa/UW2ij8oS63PCGE6uhur+vloA8=;
        b=n1/N4MOI/FnXqN4Ey8AMY/m9euWJ5TZ6OzueKH6RGg4GGeDfG1LFGrdF28ABd0a7zm
         +PCQa7pG+XMnhAWazwdBevPe/YFILuIzCTCXc1OAnbZBiJASm7mM7n3iFJuGyFzzLXTg
         Gn1+bXKLmGb2B/qMtzHTiwCeMfembjnsaWIZ7cbM3XpwPRovhqjhTFIxidWc9KKNHXC/
         b7eP/F83QIC48waVdBEjts/I8flDdi2AojZKDETODRSVm3udyUc8uBUhlcLXcM9k/As7
         4OQY5+vrUArOdLyGpM4GE9pSA7T0Qb3OcU9VjJA0svTPpJpGXjikICzIt/mL/94XhIuX
         O6PA==
X-Gm-Message-State: AOJu0YwC/OyBqRL/KZ9ajs9E+w3eTQVPohr8pVr3mg8dS0QUxkjDMkFm
	Pr2CISLJ1fVkMHbuL2cKoTBxL6bwGffdD0ALsMoLH7nCTUoBkicl8uRDDQcneMVJW+N6oyxfLy4
	=
X-Gm-Gg: ASbGncsQX0Zwv6QXPN8e9r+3H8ummCLsL92i2bG7oVTQwqQFbnLfChDmpEbSySuGef9
	SHky1GED3NBsfK/NLIAiKv+EdF0kcEFGKqhsTAVs9Y1xkKcvHkla/zVw6t9s4EhK3INyedLppSh
	2XdGnKbD4zJ8lBw3p5ozPLPGbZCAeTVA+cpZjTyBt5LYA/mqGHr4ymabz2NOHsCJPTRXDzludiA
	YNeoLh+Psy5ap7HQ25tmLnDKjF/uTYwlovgC6W3hE+KneSGEeUCkhaBgOAd+KfmNlSMhtYbXWgX
	Uqpxw0lSqa9GKtk+rlJog9pZmQQ+22egjB598dfpTJypyBvlzeLj4BXPlGwVFzHbN3gJTDK/Jw=
	=
X-Google-Smtp-Source: AGHT+IGfgj1VM3+/g709Zkl5V6erz7C24JosSS6hHZHGrmNp+VqZaw2SC3jiqioktoMKbtBPhoQPtw==
X-Received: by 2002:a05:600c:3d97:b0:436:f960:3427 with SMTP id 5b1f17b1804b1-4389142745amr116600685e9.22.1737389066189;
        Mon, 20 Jan 2025 08:04:26 -0800 (PST)
Received: from froglet.home.mavit.org.uk (dudl-14-b2-v4wan-165812-cust3365.vm31.cable.virginm.net. [82.34.125.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753c617sm206259155e9.37.2025.01.20.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 08:04:25 -0800 (PST)
Sender: Peter Oliver <mavit@mavit.org.uk>
From: Peter Oliver <p.d.oliver@mavit.org.uk>
X-Google-Original-From: Peter Oliver <git@mavit.org.uk>
Received: from froglet.home.mavit.org.uk (localhost [127.0.0.1])
	by froglet.home.mavit.org.uk (8.18.1/8.17.1) with ESMTPS id 50KG4OYC121495
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 16:04:24 GMT
Received: (from mavit@localhost)
	by froglet.home.mavit.org.uk (8.18.1/8.18.1/Submit) id 50KG4Nsm121494;
	Mon, 20 Jan 2025 16:04:23 GMT
To: git@vger.kernel.org
Cc: ps@pks.im, Peter Oliver <git@mavit.org.uk>
Subject: [PATCH 1/2] Check for Perl 5.26.0 from Meson build
Date: Mon, 20 Jan 2025 16:03:00 +0000
Message-ID: <20250120160301.121245-1-git@mavit.org.uk>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 702d8c1 (which landed not long before Meson was added) dropped
support for Perl versions back to 5.8.1.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 0064eb64f5..f01d81b39f 100644
--- a/meson.build
+++ b/meson.build
@@ -755,7 +755,7 @@ endif
 
 # Note that we only set NO_PERL if the Perl features were disabled by the user.
 # It may not be set when we have found Perl, but only use it to run tests.
-perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
+perl = find_program('perl', version: '>=5.26.0', dirs: program_path, required: perl_required)
 perl_features_enabled = perl.found() and get_option('perl').allowed()
 if perl_features_enabled
   build_options_config.set('NO_PERL', '')
-- 
2.48.1

