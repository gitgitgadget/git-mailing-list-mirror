Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6232459F1
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300590; cv=none; b=kSqrc1Mc82OQLOBlhs1PhnFtXlBFaTjJvNWftp0kWijJTgkBz/6fsltZOkNwXAsorWULC+/aA/VlgaBYg7m91R+ugeJpNuIwapbQClDDNfTpF6mIw/zeqVPlbx2g6y7y/rtd+dYlCw+17mCYY+ncR/MpnFmdEa9HuESdk9o98Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300590; c=relaxed/simple;
	bh=eCp6o52Vudc2JTabQYaAXHW2O3anwUQ4pK+LFp8YlS8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reSot6jC/WX96L0mEe+U/4rPC09tE0pnfSBKGsPZxCDj7ZviM5zLfaahCEC44YmeOss+mTPpe2LU7owCEppNMfuEFGhS3Zobz6TqCnNbMNK+U8m9XJbTrZMSaFqYQaxaSNWXdlXaa+pn/F+QKrrAIo5S4JgjP0Vr5A+oHQz72iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOkM6Wb8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOkM6Wb8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2400b3008e8so6379415ad.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754300588; x=1754905388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1i/CO5OEDHxZCOdRwD870QmGPiSb33QJRu+/6YAHC2w=;
        b=gOkM6Wb8oKNO7QAzlZkIB8+G2H0/3EXKjMsCjHms9A7LjcQiEipPZzNxIsP58qc9Zx
         c34n/O8ZC4+8nietOI6t18NHTBuHPPHWlOmo8RKAC9/3QFJdFnYnMt3If4ekZavGZ7if
         e+RhhTRGTwI7RXfxn8Qrz7oFR6h/emhJ4bpzLtj0mgp8JmxRJLXrosmbnChHEo0T900t
         ZsK8DPp3H+oi7irqGdrKTP5Z32ThuQ0leHLFBtpWWVo7fPfQDXz03/jJ9c5YCD6m45nu
         PNlhs56mSzR4Gr+RHO+RHXLArxXk6rK9qFNnngDbFEsPnmhadoLFGalBaDQDc00wfDev
         B1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754300588; x=1754905388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i/CO5OEDHxZCOdRwD870QmGPiSb33QJRu+/6YAHC2w=;
        b=giWsvT5zPMoPcGJDnzoVhqEwhYatGJFXjulO9dALl3XUEWpoi3Gda7b4O31oSBl9x2
         4PLRX8y4q2bn8u6PmggjDQLEB0aoOnMJxAi8a0G2gBiM2obG8uF9iygtywpWXpPHWZaC
         2TgznIjVp0UlL59AsKQcPfYak+E4nSVHLM+7hVgfdgdhVw1apCu4BNDA9GxanK1a51Lr
         3HZNrO1M5qN4iSIb9HmZCcfrZob/D6IErl2tPg8dYKJ7bKeQDxsWZPavBV4JXF+7Urie
         KCiWV0JHMd/jlu8lsqUcIQhsHGH85OtAcXPeURBr7uIHH0KxTu2yt4tO3X5Nhpzju+lG
         bmRw==
X-Gm-Message-State: AOJu0YxSFu+1yPA5IbyX2DEjGJCJ9uofvjrTqvan1Zlco55lCVZtbRDS
	uLyHgfZnImm5dPb/DgpAlSo6KPtXpM7sgIjI9IwBqC7sqhDH+RCFWCE3NFcvVg==
X-Gm-Gg: ASbGnct3l83QdPW2N+as5vW8teQCkRdLnIphVIyCOZFHmLfhaKtUALtHx28B00z9YT4
	VJ6ouRGEF4Z4HfN15f705HChEfry0G3HXnpquuK5RFhCYspap70GHHDfSpdgI2Ay+6NKvk4f4+D
	Ec9dH12Onlitj0Ikl9EWuFNCVvUxB6lwVlD3NJCE1sAQMP1O1xYDoy6d78hueNc2K/BTGYTKXmr
	tDtF4nIGGsCDMtgcsuhlQFI7U5EECajWCyvQKZeq+7Gq41EdwHFpGV1bnZzVz+CUF4bgMEybLfA
	Ra3w9HGmtUQkx5q3aw22CZIvKzLrjcB3iw/O5RWi9SYPgla7mCZtzvfJUwiX8R4q0iehvIDC7wv
	gCFXksfUiTLF6dfu+LaymOeZnjjNvpg==
X-Google-Smtp-Source: AGHT+IGV7mHRQId9IgEIUmHbkPWL8RclP4vuv6cCdKjTGhlpwoBvSwrYbf8k2/2Tkd2Vd6veLQGeMw==
X-Received: by 2002:a17:902:f550:b0:22e:62c3:8c5d with SMTP id d9443c01a7336-24246fdc91bmr52499485ad.8.1754300588270;
        Mon, 04 Aug 2025 02:43:08 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6d3asm11194247a91.23.2025.08.04.02.43.07
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:43:07 -0700 (PDT)
Date: Mon, 4 Aug 2025 02:43:05 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <3eb95731ea07c5f25ed7a47cc639f53b4b18e113.1754300389.git.liu.denton@gmail.com>
References: <cover.1754300389.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754300389.git.liu.denton@gmail.com>

In the case where a non-existent oid is given as the <src> for a
refspec and the destination is unqualified, we end up hitting the BUG in
show_push_unqualified_ref_name_error().

This is because before hitting this advise message, the <src> is passed
through repo_get_oid() which, upon receiving a fully qualified oid,
doesn't actually check the existence of the object and just returns
found. This means that it's actually possible for the
odb_read_object_info() call to return not found under normal usage and
thus, it's not actually a bug.

Replace the BUG() with an advise() displaying a helpful message about
the oid possibly not existing.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote.c              | 5 +++--
 t/t5516-fetch-push.sh | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e965f022f1..9fb76049d2 100644
--- a/remote.c
+++ b/remote.c
@@ -1218,8 +1218,9 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
 	} else {
-		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
-		    matched_src_name, type);
+		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"
+			 "Please ensure that the oid '%s' is correct."),
+		       matched_src_name);
 	}
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c2fcfeca92..e064ea7433 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -509,7 +509,7 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-test_expect_failure 'push ref expression with non-existent oid src' '
+test_expect_success 'push ref expression with non-existent oid src' '
 
 	mk_test testrepo &&
 	test_must_fail git push testrepo $(test_oid 001):branch
-- 
2.50.1

