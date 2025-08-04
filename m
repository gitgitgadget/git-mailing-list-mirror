Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0952459F1
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300587; cv=none; b=hqrTNO9eZNq6DvS3zpUcB0fJjWij2WCbdgCk9Nuj7doLwdSSW9pNbo7CSFZclGSmuhB7vlS6HCxOZvlO+U3iWMe+XoVuQXyvkZUc0nWqU4BBd5ZRv0vpnkT3s/EZ6LEAZPF66AKq28s4b5o1fefgOgk6ZQiaCGte13eq+6atmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300587; c=relaxed/simple;
	bh=bfQBjJDUmoXrOT84OunZOT0f7iMCPpEpF9nQJ8bn+yc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuHsTu7Zo6jqa35Fs0hADfYiKa9SeEUNkroo3/rnZfCU5kFzOYm32MX0KcOz4pP0h9k9nhVpO10mRHQqPTxyccTuk117dXrnhEGU69xnHVQ0yqz42DhGIzeSACroKnvbsrcAziNI/BpOnXajfajrp3UM6g0qBFADZwYtJZl+YAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPgiLOEd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPgiLOEd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31ebeb3882cso546011a91.2
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754300585; x=1754905385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ls5u45XUNiqzDGKug0BjktY4HYGL4SOJEc5jSayrZU=;
        b=RPgiLOEd4r0x4QYYX/cpz0+75fxb3tbHNDpBEmpSedcHM637JTLgt9JoijGKEcZaCw
         qB5TH8WpDsIjam3kyKjXGRD11DR2i5dEESK0X36zhF2FjRJXbQpf0yEA5M+ty8ZeaqCS
         BKuzJz1RuYfptR68AZACpJhrUzkNbDz5KomEjxqZ+ReeC41xHglpF8GCiz/iT6CRWyBu
         zbxYmVDesTxNvSCyfqmZk9aQ2y2EQE71aM47Hb6O7kyg1dcW/J7eQRoO9WFI2S+OS0mw
         +7LV3/W++3O+ts0aEU7vT4VvP7gsDCkEIOdoHPx77GP5YibIgsrkXYhTimIh8VSn8x94
         HoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754300585; x=1754905385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Ls5u45XUNiqzDGKug0BjktY4HYGL4SOJEc5jSayrZU=;
        b=gUDHtQ8gsNaa5/42g8i0qAc5rj8m63jVDojxepjuBqgMaaQGUsxzz+B2ABPZnikldg
         RpYMyWdOh6CCRuFeKEtxjoyNEXXq64V+GPW95CWyUnCSvwgKOF1K9HDzEKuT4P3IDn9t
         SbLy3B2Yn8L6Q0L6zLgYsc0rniESKXX+iDe/voNYbc3D3K89mCDa/o4gX9ohaYtveugt
         XKyMIE0J9IceH0IJNAOLBGw4H6zzM9ZrUfya3eAyCE+imvJzt9kFqa1Ochlm1eFkKG3R
         jYdP95vlvyXUXDoyL5ASgMBvd8pEX59xWnZveLAgd4pF+adXER9Ecp5hwLdSVoqSil0R
         2vPA==
X-Gm-Message-State: AOJu0Yz/VglXw0yIVyNXo+tNUUDNPOzVuIwYaDPEJUiQHXzKU/hmJwbs
	QIgPIoW5EkwYALTLt421/91fg/4ArajF6keCOZMpFVY1csHLlDaD6JWm4ZyjEQ==
X-Gm-Gg: ASbGnctV+DISB2mcqbD9ST3UbtfrJBExJ0G/LcTL2GjpW+Hfi6mcHyrBzQIvT95yBcq
	S6j8k6vGTbQO/4LXaK16iGIw77HJrYZsqLUiNPkic9PbDOsdnX41U+FhzapsGdQ9h40bM4lu7F4
	ykkrGpyqaYPlj5NiMmhwy5FBI5CFKbeHr7n+/IlYme/MEc7gsGb72O1lfaYCG9GgnuB+sKmh0mk
	AwWXG9VxEHATtUlvAbQGpVShGXJOxl7lqeivkS4cmehrpXlHURWyBljaSYR6ECXLbLrqn8xkluJ
	0f61Hickk2gH590m5UM35334cJNlZkwaGbuoNlc1WBeSbqHcsaYNvVPKV65PqbCpXEE5N6X/DDA
	95sUdByY1U1snSlmj0+C3zxTBSBBnLg==
X-Google-Smtp-Source: AGHT+IFlwd1v0ZjZL4k8M58XvRA44HUdBavgFb+2+vQ9vZ9BDGmQUPggI20dbMzbWE+kfKU1YxKOig==
X-Received: by 2002:a17:90b:33c5:b0:31e:a421:4dda with SMTP id 98e67ed59e1d1-321162ce3d6mr5241706a91.6.1754300585114;
        Mon, 04 Aug 2025 02:43:05 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4230ecf8b7sm8357817a12.11.2025.08.04.02.43.04
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:43:04 -0700 (PDT)
Date: Mon, 4 Aug 2025 02:43:02 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] t5516: introduce 'push ref expression with non-existent
 oid src'
Message-ID: <d26f355c19c59eae30143900e218533bfeabec2a.1754300389.git.liu.denton@gmail.com>
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

It is possible to trigger a Git bug by pushing a refspec where the
source is an oid that's non-existent. An example of the error message
produced is as follows:

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

Document this failure in a test case so that it can be confirmed fixed
later.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5516-fetch-push.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 4e9c27b0f2..c2fcfeca92 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -509,6 +509,13 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
+test_expect_failure 'push ref expression with non-existent oid src' '
+
+	mk_test testrepo &&
+	test_must_fail git push testrepo $(test_oid 001):branch
+
+'
+
 for head in HEAD @
 do
 
-- 
2.50.1

