Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5D2FC893
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001600; cv=none; b=GBpw9ClPj8+HpGF8jqZjoI1k+BTi4q9OPLIrkFCp2fDNswV/1IODqvR34kzT6GJvUo6JyFlGz0LNWG+xGU3CEqtgl80IU5bcyjh5mphxMqqOF8hrtiL/rBpR5e3dHKHP4dglwl9Y2ihsbrcfyAVMsKD8jcqtaCjjGKfV54xoTfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001600; c=relaxed/simple;
	bh=z8ecjKdyOBxqoNqi8e+XdpkHuJ1F5un+T079iRgQu30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfNitvBuKIirtQaZ+WsZAUlxBTHwDO8G1EXkXa7+mdsNlmoreEPxEt7DXLWuNJx1mINU0gy6WlKnWgnDn5sr5/D2tCgWJSOfvaSo3PxER4zfuNhSTwi4tzJkCyVyd9giKPzIBSrOwe6Qh/dL3uqVUgwqFCvj/CinhZgtAmpIRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQxtKZQl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQxtKZQl"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b801ff00294so3759266b.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 11:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766001597; x=1766606397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XI5Cgxgd4VLg/8vmjx1BUChB7e40pdbPSsTV/Ts85co=;
        b=cQxtKZQl93O8IYhOdxU5o+Taj6WCea+7AbqdO6ic7Azua4v/w6VANq7IyLuxMHT/2F
         vpBjgXKNx1KrpyEV0NN7nEiesjDoSKCsLuH7u8LEq9MyVQk5WzCUnA92oFV73dUC4Vhz
         mPHobl4ObmzM+2cFR6KPyhPCZpVo2t6hdbSRAhX9/mrooJpD12zJxtrXS63nSzm9JSKj
         ZPF0BOULhxscO/wAGxlQlu6BkliP9xZhbKhNoC9SpjxIUo+hk2JbN7M3qsd/iN9zJz9O
         dHp9kx7Gb14yCJu9Mv2BkDC57CbOhtadeFQuiRbHEpu228/U/4rGNgRO6Tqv/HGhq8bK
         Wq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766001597; x=1766606397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI5Cgxgd4VLg/8vmjx1BUChB7e40pdbPSsTV/Ts85co=;
        b=mZpkZsaE7jET0iMIeqsmged0qUVcVJ0ItdYm4ZNkliPkFZFDnZBB1/YX0AyL6/Vj7X
         9GN2ohquFH27TLzis7drSzRBktlIPY4YkkIYVEW8kTyDXLGObSnrXHqo1sD2Xw5aFye4
         324hHI6sJTckdahQ4IWiNwfZXdkLKCQ28sf0Cn5jj4ZxyExZreUKc/ZIS9tQkCM1CaPL
         zcN/80ILnEhlVuCbwr1MiikdiigLDPWUqUxnN9TnQmUIO9/eZrLyIUqUkTN3k4pVsTKT
         cKbxDUoHusopogSDbZaxBtZNlWkNnElpsB0cJauGuQkx0d++CVbsqbM8UfeObEYQQsqO
         21yw==
X-Gm-Message-State: AOJu0YyvI+1FMr6zLZGU9N4ndqNsE8ib1ZxUgWdRWUiJbG9Bvrl+KjZi
	3wqvikt9ILtiISrpkuUYi/6/0Wvt/lhY4A9J7IBSkAEJrLHy3PMToU0kPdhStnR0
X-Gm-Gg: AY/fxX7FufjxJqy9I2IsGJb6ogqEBVWrhyw/tPhsAIpLo4vUpzgH0cWejwtwcIbwfxI
	E55OqCseHpt5kY6wPfKdo28FfQDoxobTn+XDnObXsvzhjRbffKEI8ejN5BizetayFWyYA6Coyif
	kvvDCqgDn3LaylsAVZzOVTYVGQqKpFDhRM2Yuq2Cn9m9gpDBzzqXsCtHQ/UuBXohyjwAKAiFaXi
	mMFtygyVIdD6djYPD6RsRjvZupA4LDEUX+sA4WYEj0IaNARatnn6Il865hU4KCEVVupsNLDSM/O
	lbQT08taPCIC1LfXxPeFsTv1HHEZBmLVLZP/Jfk+rzIkjYvzchope5nZxLpIWblvfWd4CTMQykw
	VO2Hlps/zKtWEwcVl8oDKAbWDlAP2kL7/3gCYVgAuimXCsxtbCYecbRbzl5OhZLsDqfIvQfmIOJ
	2DfArpfbRe8SL6WQ==
X-Google-Smtp-Source: AGHT+IECoedZ3LCRgrisNWfBuVo8Wy+Cic3mlu5Ebbo8x9PUGgmDVLdgBDVeMBzzrb41kL64D4f5kA==
X-Received: by 2002:a17:907:9496:b0:b7a:2ba7:18bf with SMTP id a640c23a62f3a-b7d23a102bamr1165950266b.5.1766001596996;
        Wed, 17 Dec 2025 11:59:56 -0800 (PST)
Received: from desktop ([194.127.199.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80230dc084sm12359466b.28.2025.12.17.11.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:59:56 -0800 (PST)
Date: Wed, 17 Dec 2025 19:59:55 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH v2] docs: note the type of core.attributesfile
Message-ID: <20251217195917.25710-1-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
References: <20251217195050.24837-1-matthewhughes934@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217195050.24837-1-matthewhughes934@gmail.com>

The previous wording:

> Path expansions are made the same way as for `core.excludesFile`.

required one to check the docs for 'core.excludesFile' and from there
the definition of the pathname variable type to understand the path
expansion behaviour of this variable. Instead, just link directly to the
pathname type.

This change is basically the same rewording as was done to
'core.excludesFile' in dca83abde2 (config: describe 'pathname' value
type).

Signed-off-by: Matthew Hughes <matthewhughes934@gmail.com>
---
 Documentation/config/core.adoc | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 01202da7cd..9bc9de29d9 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -492,10 +492,9 @@ core.askPass::
 	command-line argument and write the password on its STDOUT.
 
 core.attributesFile::
-	In addition to `.gitattributes` (per-directory) and
-	`.git/info/attributes`, Git looks into this file for attributes
-	(see linkgit:gitattributes[5]). Path expansions are made the same
-	way as for `core.excludesFile`. Its default value is
+	Specifies the pathname to the file that contains attributes (see
+	linkgit:gitattributes[5]), in addition to `.gitattributes` (per-directory)
+	and `.git/info/attributes`. Its default value is
 	`$XDG_CONFIG_HOME/git/attributes`. If `$XDG_CONFIG_HOME` is either not
 	set or empty, `$HOME/.config/git/attributes` is used instead.
 
-- 
2.52.0

