Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58E22690EC
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771257217; cv=none; b=P3qrg63egl9w0CljMQ7VtuwUf8Nv0bBkgef2WkPuVDfooPHjK+yGaOnPXVRZCTge2NnZVgwQujUOlPfkjXzILVJW0vedfxLv0FfM5rbRZt+g+JPiUz+O2VS3qNqUFS/sy2GJAyS+OsRlOVEftqU46cc2lA4IRVj0KIB64TfPjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771257217; c=relaxed/simple;
	bh=BM9uEcdC+hudU2S5Cte37dGjT5eObDiHy0m51k5unuE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mMYl6zSK6Jbl4Az65lIeYsBpPqgFKmj1uHSMbDHn4EslSodYPa696CCs/0ZmLEt6OzkpLSnBlca7zbDnMldSGXO7oSADZaUglXAaz0wZZy1LZJKUh8hlJE9WeLqU0OlhhQPOgGp7Jy7QHpgjS+rwUPVUqoZpCPDjXgXZ1f8vUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRduJbWK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRduJbWK"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5069df1dea8so25888491cf.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771257214; x=1771862014; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSq0PNQVrqZsL2QTVF7Vs8KWfL+gIllTtZacy+7yqvM=;
        b=WRduJbWK1HMzJuJNr53io5ThrRDsQ2EV2PqJ74ubbdkjvxCy400MVOSz+8i/QMR/6b
         DHOFOqzcthC0mQv2u9TA1TmRq07fVVSeFd4HViBQG+GvuB2UwntIjmx5drxDa4smvDz0
         6Ii981XrnpNfmCmumZgYwIyPYYdCpmW23zeqg7mg+H61iyQdujWpnIoGEqtzf0R3efeA
         q/rZ7SuQBZcPzeXZcZa9hk3zQCq7QB/MfzHH+m25HQlQ5TByUdxwQMaPe/j+fg4Lf0A/
         wvPeS0QMF43JJ2t4pwYpJFvpk/IH0i5DRrTMYTzQ7SaAk5cr6fla0E6yAbGGyKJscBx1
         r6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771257214; x=1771862014;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tSq0PNQVrqZsL2QTVF7Vs8KWfL+gIllTtZacy+7yqvM=;
        b=pAJ4zk8J/CsA0evLRjIQEk6ZTf7az0b707nRpy80s8ApdjgAcF50SHX1//HO6n0YPz
         lI7GIxGNJ037E57ThiSj7KEj0aUeS5/Dd5CKjaJkfJPRYWf8dAYh5EVu+pVtrbLKsu8F
         NflHL1Zm19CqJ5AUYPz7+rgREJ6i7OrV4KbggEwvkGkgqpV0a7pYESlc0m5A85zs0ptu
         +aKp2gvxKG3R6t6jR0+CU7JLnzCIqI7t70+6uXrh9mhou422xc+TDj3NATSW5Oht8qGR
         4lIrWRt348kaKxJp+P3jFBNwcULWzNsEZKFhZcldKM0UVUBmYS7CHn1eJtLU1K14quq6
         36tw==
X-Gm-Message-State: AOJu0YzSZH57D/T6sQUx7loEDEtLu76HnEzUZ6bbZH0F2zonI8h0n+PH
	hJNVERVvzj6vvZcuI5eFV1IWEovQCBXwsIgPTp5TbY4jz8J+INtfvbWpCq1uDFLq
X-Gm-Gg: AZuq6aJfIEJOKHBnGnjxT0OSE5MqY9HDizIh9VdTYL4ZBAJrMKSyE1ChWaNWiRODwly
	BFsLPD/YDO9h9kaqD8a3HdBojvC7vICXBUsz66dCx7IZGgXexlnDewcMYzQBOLVNOCTRlbjcNlS
	+z3wuDLCRbRCs0yqjH1S5vjhE5Z4sT+JrmM31NeD6vcXa6suF3yHr0j9weU/J+Vbkllo2oNbxVQ
	lc95SFZui4L5EVtSMcMWO28aiP7j5AVjtXhUsxSoFIGXxLc8CV8blMV/tn2GJW2B2vqHwSbzPon
	qwylOENVDOv9F8ovVEZ1cLhqnVpNdVwJsfHyHrhGz6WhyaUbn3SLj3qj2MTsKf4y9zCFCsOvRpv
	1H7cjv5nncxo339XXQd8k2s4Mv781TxXq/3RHZ4yLpmAabcq+voqVm59vkm7i7mg/Cj7TzmYvqg
	P6bDAN9BGt4oylG4DgzZRxuvWB2sU=
X-Received: by 2002:ac8:5f50:0:b0:4f1:ca82:f1e8 with SMTP id d75a77b69052e-506a8271aaamr123617661cf.7.1771257214362;
        Mon, 16 Feb 2026 07:53:34 -0800 (PST)
Received: from [127.0.0.1] ([135.119.238.192])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506a1a50276sm95322391cf.22.2026.02.16.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:53:33 -0800 (PST)
Message-Id: <ff85e97ceedd206f723061ced972b7b7ba431b56.1771257211.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
References: <pull.2043.git.1770679038.gitgitgadget@gmail.com>
	<pull.2043.v2.git.1771257211.gitgitgadget@gmail.com>
From: "Rito Rhymes via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 16 Feb 2026 15:53:27 +0000
Subject: [PATCH v2 1/5] gitweb: add viewport meta tag for mobile devices
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Rito <rito@ritovision.com>,
    Rito Rhymes <rito@ritovision.com>

From: Rito Rhymes <rito@ritovision.com>

Without a viewport meta tag, phone browsers render gitweb at desktop
width and scale the whole page down to fit the screen.

Add a viewport meta tag so the layout viewport tracks device width.
This is the baseline needed for mobile CSS fixes in follow-up commits.

Signed-off-by: Rito Rhymes <rito@ritovision.com>
---
 gitweb/gitweb.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b5490dfecf..fde804593b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4214,6 +4214,7 @@ sub git_header_html {
 <head>
 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
 <meta name="robots" content="index, nofollow"/>
+<meta name="viewport" content="width=device-width, initial-scale=1"/>
 <title>$title</title>
 EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
-- 
gitgitgadget

