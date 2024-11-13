Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97025680
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459134; cv=none; b=j9bayHfwMLydnFJRClh73t9DXVkMIqgTK7yu5AnkaC4B95CNwfLD0mKtALN1PtG+BTBG8SYY6RfS4/JE+OjxTPtFw4NsFLwGVTiEgOlgat4LBOWfOfNK6Qk5pw9epltsGs4TQAqahD8gm3F1M+UvUqtT9wFkSy0Zmn+p5kSeLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459134; c=relaxed/simple;
	bh=ZxB0Pds/72H1qGrM0vIfgtVzxwiCkOcCHGBxt0XTWHs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=blY+waPQtSswUVbzPB80vJevWuihx0cftWcMVsCgJoVLCl7Ktm90o0elwcU/ia2971IxxrbQfqqZBu93dytlhejLGC8jj1i5JVcdu1b2omqsYpSbcfwheA6hu2fnLzGKkMaDGFbiQXyrS7KvjasIauX9BNV9GJrroHGMjrfPEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGkOyflk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGkOyflk"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315baec69eso56156425e9.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 16:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731459130; x=1732063930; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMZd6pL9I6cFzWwxp9cEAWDcZJiylGuDq1ibIm0UmaU=;
        b=GGkOyflkuRC5MD0nC+NGv9F7vcBOL6KnYpsLRc4USozHQ202KFWZZ+QRMkB2S3KPBe
         7O2sK0y/0YbPKv4GmI3GRTzqvqJpYXnwAC8z3pi5+YoH8CKluCgdDN5rPl639Q63R2HS
         MNrZMaTfCc7TOXtkRYyEN+du3C6w6VNPZZXfKRdKDxMD8BO1MaWxug2nUkX6724UxFiu
         BToy8P1U4oBxbbfVRdf1VLZB0tX9dWptPxBQRUM2iBTcjuijy8dbp2o5JP4sA+DBbqA+
         H47myXIlwCKSOQU1BxqKOMNeppGPg2F2JS45Wj4mLORQKYLv8WOfeNgv7ne4esJyumxr
         ETYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731459130; x=1732063930;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMZd6pL9I6cFzWwxp9cEAWDcZJiylGuDq1ibIm0UmaU=;
        b=HpOrl0XbDKSLqYUKxivlaupt8XSdbXWNOsbokiSNBiIglqHeZVd5IZkWH0wFgaueRe
         WZfGZAWFaeWVryUtFFw6DGlgQf2MvhZntyIrXIcQUjz1fFMyD1bYUw62RDyKVVJK5YAj
         XJK//i4Tl4P/8ytDZ9hM655/6SkRAMPsVpgzCeCoxYLa7ZOYuj5dbpozqxW4k4fVGvK4
         BX92LPamY7fiGf6P667hTFt9RxTnTWvYxA+g3fSHs4oob+TNlEwZWjrJvDr0shWL5Fki
         uDWIkfAbf94wkiblsOCetF+R2Xte/O+hRSXovvgV6Auj4TUjDc3dH5Pg1Ze/y3qBrmnD
         0IZQ==
X-Gm-Message-State: AOJu0Ywsza6b5gJuLxhBlt2wSa7BZ14hOur4JAqisZZoCnI5gPktTNEh
	QPF9RG4MLIMfo84cWd6bBVAbu6NhTY58rK1vjoPYdEILcqynZQSO+01nQw==
X-Google-Smtp-Source: AGHT+IGahUgzqajstpvTM/lriCKnE6LPPSAT5Ax9tQAZPAm6i8xtU+uPBVGlFqa3zjEIrG74s5KLiA==
X-Received: by 2002:a05:600c:3ca0:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-432b74fd8f0mr155367135e9.1.1731459130507;
        Tue, 12 Nov 2024 16:52:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d555908bsm4584095e9.44.2024.11.12.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 16:52:10 -0800 (PST)
Message-Id: <24933ba71305caa97fe1f756aef770d40f39fbda.1731459128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
References: <pull.1827.git.1731459128.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 00:52:04 +0000
Subject: [PATCH 1/5] completion: complete '--tool-help' in 'git mergetool'
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Seth House <seth@eseth.com>,
    David Aguilar <davvid@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 3d4dff3185c..b3b6aa3bae2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2331,7 +2331,7 @@ _git_mergetool ()
 		return
 		;;
 	--*)
-		__gitcomp "--tool= --prompt --no-prompt --gui --no-gui"
+		__gitcomp "--tool= --tool-help --prompt --no-prompt --gui --no-gui"
 		return
 		;;
 	esac
-- 
gitgitgadget

