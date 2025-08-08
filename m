Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DE26FD88
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637890; cv=none; b=kZXPXxPum8Kj6AD06RxPIE1GEarSZP6WlQUvabrI9ZYIA9DbZmg1bkAKgPmxVTK4Sa7szxqh8i2ZBlKcYydK1MmvF9aqk25FRl2pzc/YCOtuHqaL4SyBlRf7wZvprWSGjpD69LfhbJU9WSFa2Sj0S9R3wYE//RRpJ7z6fDOlM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637890; c=relaxed/simple;
	bh=w6TJ/TqlSkKoNCL2mafCb5kDy8JdIT6FlkWHHaNW8l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ2Z1R3CgiHDeNE0Byb5ZLPtPhgwZ96LGz2tlMJpTPTykt8U222KdNgXH3a404cEgAMTFq21FprC7BI2r6aLtc+MRvLxmOFqtamWsfMzYc0AkNQujMPlFM3fWzvOX391cof47hzzcat+ENYfYoqteGA5kiaWzPsd4rpfp+HVxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5lKSp91; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5lKSp91"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2400145aa5aso2680665ad.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754637888; x=1755242688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ClnCcdnuYWu0GfTIneGJwzabLJobfATEmbO7LuiWA44=;
        b=d5lKSp910zjXM0ru6wliWewCedx3XGeEVB2k9IYE2DlWlYZub7eCLwPc5qilvAmRfk
         wL7cpgALxmWn+LPS2nxDmi//mgfBD6saB3cu527Gp8zojCeGVWc+Ugv6xpUjLG8dQo66
         8Y8G2qBGZkRqZTFm/AB+uecpdNUHJo24/bT6Qmptoy6jAQ8PZo4qe3KJaqxygco6B5QW
         M7PrMZ76Ie59a2xJkiZsEAxx46qLd+Sdcg9bHzOniYQKryDrCkX0nc3r+HecuN0yJI/j
         R1gkPtDhYrs9nrzGgLMVxDIA7t98CYQFo419FMQQCgRCnXHJHdxTtN2TFbHwcfAbaME9
         cvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754637888; x=1755242688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClnCcdnuYWu0GfTIneGJwzabLJobfATEmbO7LuiWA44=;
        b=E89X5XZ1dVXvSmevgrN47KGB/0Nz0QRPkiU2gCtg5KTt6w/Rm+T3bisOg0chBH1v7q
         rZPCjkfPJXYCuK6b/FcwFV/8BLQ+B5NhlfrgGnmwHIoLsvrY0tzvAhkYrkU2IHZzE30T
         l6m9Segg8hvu2s1jFv9iWV/3OwK6iNg0hkEl6/oW/iRVFG24RunbR/6FPDFjd3/5+Lzv
         ruph/urvY6qW+bm6VaMxwvWdG/i3o+xklNBj30+lW3BcVyTWCrgX6AQiyIZcRcsazyL+
         8hKXf8SoXFmJ3mpaFZfHxgreHluEeWwpMbV5WYhP6FWI4V7dZk3VKNmfVAmh8VVQ8YTD
         wFhw==
X-Gm-Message-State: AOJu0YxeaX2P9i/WavHDu45QLEH7Xqc24h79XhWZ6Rrhbmcoi4QLqJuy
	XNZbPdM2YjcPBkvwVzoDHV5FGhZKXlGDJnhCsUPbfJ6eg2Hz1X7xAYbFA6ivwQ==
X-Gm-Gg: ASbGnct6oHl10Mxvyu5sBdxwIR0WQAqy9z6WIhCbsHyHJYP7DQTV0QB38GGR8HhrCmn
	k6cSj27pZ26C0ZVOlly4H/NxLCQWZaWvKFYxNU37Ih2M9TVCODe9Rol7CLjE8PwF/XZEP6a+KIV
	zk8OudeESrChIsK/lWpdChUCM0vmtBPDDm/QOcLzMPPKwns9zozWEsLEMhViwr0uWVbbyil2XLN
	W4yHFFemsrVO8DH1fUy69/lq18tAERczmlKxOg2SKUnPc8sG6Hctj0rrl6PU4i7OW3ZxmVdrXZ9
	tqPSx49LhnqRX9Csc4oiaP0TCD/Cp6ZKr8u9B2mBfqGoDYKGbbaMCVE6tvxDWG0XyTkcCMrjV30
	h955oDqXjXxmORHrBK1Xwqap16ZSDdA==
X-Google-Smtp-Source: AGHT+IGRh8xj4x1FlsXx4RR7HGdLZr5wEIk7/aQNVDuXWqdLWxpIeumiA81HSW6FyBOtf073zJMk2A==
X-Received: by 2002:a17:902:fc48:b0:240:1879:c2fd with SMTP id d9443c01a7336-242c25a352dmr13804055ad.2.1754637887797;
        Fri, 08 Aug 2025 00:24:47 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b5e5sm200209545ad.124.2025.08.08.00.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 00:24:47 -0700 (PDT)
Date: Fri, 8 Aug 2025 00:24:45 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 2/3] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <d21612fca63794df8cb405280d795799b374e1cd.1754637850.git.liu.denton@gmail.com>
References: <cover.1754627874.git.liu.denton@gmail.com>
 <cover.1754637849.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754637849.git.liu.denton@gmail.com>

When "git push <remote> <src>:<dst>" does not spell out the
destination side of the ref fully, and when <src> is not given
as a reference but an object name, the code tries to give advice
messages based on the type of that object.

The type is determined by calling odb_read_object_info() and
signalled by its return value.  The code however reported a
programming error with BUG() when this function said that there
is no such object, which happens when the object name is given
as a full hexadecimal (if the object name is given as a partial
hexadecimal or an non-existing ref, the function would have died
without returning, so this BUG() wouldn't have triggered).  This
is wrong.  It is an ordinary end-user mistake to give an object
name that does not exist and treated as such.

An example of the error message produced is as follows:

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c              | 5 +++--
 t/t5516-fetch-push.sh | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 88f991795b..00761604a8 100644
--- a/remote.c
+++ b/remote.c
@@ -1218,8 +1218,9 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
 	} else {
-		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
-		    matched_src_name, type);
+		advise(_("The <src> part of the refspec ('%s') "
+			 "is an object ID that doesn't exist.\n"),
+		       matched_src_name);
 	}
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8eddf3e40d..46926e7bbd 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -471,6 +471,11 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 	test_must_fail git push testrepo main^:branch
 '
 
+test_expect_success 'push ref expression with non-existent oid src' '
+	mk_test testrepo &&
+	test_must_fail git push testrepo $(test_oid 001):branch
+'
+
 for head in HEAD @
 do
 
-- 
2.50.1

