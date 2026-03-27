Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD737C115
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639443; cv=none; b=u9Rx9kcx46Iy/jlTbVPmWIGGBLIGFI6NrqR3hOPaI/iCflwgc4HF1GpN4v02J8HyNI6dC5nqxd6Fwi4RsDbB1BJvT/Nentkv9+hHYpp8fyqYNs8IjgxiGZp2CR8IZBo6SNgDOugzB9cwFV+0gHja4B9lIMGyjsKyfqm7D5zBo90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639443; c=relaxed/simple;
	bh=Ao/aEfOMWdkk7cG6BaxAqunla7Vo6n4VL55nZxp0zQk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cT9e2ZCGfa16kSVs9cJMsfckkfi6jFVC8pw/qao12Rd6rbTfeLFj7RegV579W4vZsaJ4y7SvrY1pS0xb/Obbq7MrMwPRMvbGMtoQWVin+keIGk4Ntn+tBE8ubLbhQZWQBgeUuaT+7XptwF3FWMDPRjLFt6u0b0zJKLoKjh8D4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeov0sqU; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeov0sqU"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c15849aa2cso2827668eec.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639441; x=1775244241; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=jeov0sqUZSJEZMzrm3ynv0iUcn6/wT8DH8ozzrGFZ9Db7n9jRT86K/snYF4xLOsjNL
         zPH9jJOljuGCEgVPI2doMPzOdLcpSsV4eKcfvjLRRlhHxX04BFEcyHFC7pocFlohvYKD
         zXAB87uuT4lo8jPNj4nd4oJlilyfPuYJsuJ3m7sE3cEaxIcbSluP32A6iALZKDZMdyNr
         fwYra69VQGaw7J/IyUbmyNZ1MddU7Hi+wIrJ1vQ9RgECzWMHNlKvDOGML/LnnYCqZ5B9
         yRSvcv7sByQ1P6l6DdVmfkVK0yTaHssjWIrV6/hDB+buEGQsLIFq059ej2JPr5HCoVRa
         VbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639441; x=1775244241;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WVs9DBKONIEvkews5LxRJcvg9oerl9LS6fLqw81YFpM=;
        b=qRVjC5k6wcwN04jH6xFLoSf8/cPJQgsG6vBphptbr+q/TNdbYpBKd5sY+FjTF+Lw1w
         FjuY0KsQLzfCmhsI+2GOD09pT2+CJiRh7NIhb+qaYDGnUdWy88APLGpJiywxLycC2F4M
         /3Qwh6gT4i9mSVj4E7Zc4AyBvgZFkcgDCbXwRoH8NVQDHqGsFd2tsyEEizz4zFfjsi1m
         gHOr3RjICLOzorbPjtarQVkDW4uVMHwX6WSn+fHeEWNTFdBQUhllX0tZs8VGVy1LoZdg
         Eon9aYQvSu7EqnCM5WfG56jfyu9XwAAmHGVJLK3tAtDdw0pV51hOisBOlqXn9uDLghlN
         I3Uw==
X-Gm-Message-State: AOJu0YwACDpZIv8Bd213Unj4R1EqtZPiRov2tYN5UaSGnrjALgeXY1aL
	6BMBFTZvXUeH74urxn8dXj9eGl9+wZge+OpAGMnkoC3BH8MBltw1ZJMl80GQBA==
X-Gm-Gg: ATEYQzySjKF5mRiEMyGLziWtjOGyfWIjnHTmW4xnWp5HL+cWlYa7u18dCUpRjgOpgfH
	bxUKypnwtNXzArhHFMHQby6s+mNYrnCc67ykIS5v+1c0kWP1ABNdz5hHxwPMuOEBQr3wFj0n/iK
	d/sE/X1SnmHP7C5Hyty0dzfISNU9JuWh7/xKkn241u24Tkf0y955SxxFhaJdVQDiZ82YmCp8S71
	UbfL5IGoYH1C66tZLDUDL82xE14LkzkljfSZ1wRgjxDJIF+fGswRzWkcAlZiZvzFeubq1Ab4NMH
	ijH0umRz+xxKV+qf8A3awcBzr/plTLTkgEY795vA3DvxkKHWGjyd/SoIZ/daRaFuk8KUwdXcApK
	zfS4nTWUqdNqub2mKHit4sB5+jKwdnXFE8/70jO5DI292ICeDuVlv+y0VKPyAtzwCQGFsQjyIJy
	4aXQ+zEuJ0Pn0GCmnqg8rHxUdYLScb3ZVN/WQSbQ==
X-Received: by 2002:a05:7301:290b:b0:2ba:6b3a:7696 with SMTP id 5a478bee46e88-2c185cb6ec1mr2213360eec.8.1774639440770;
        Fri, 27 Mar 2026 12:24:00 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c796d895sm181801eec.28.2026.03.27.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:00 -0700 (PDT)
Message-Id: <39a35365ae85f630f6c69c2ab0393ef087becdbd.1774639433.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
References: <pull.2156.v2.git.git.1774473065.gitgitgadget@gmail.com>
	<pull.2156.v3.git.git.1774639433.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 27 Mar 2026 19:23:50 +0000
Subject: [PATCH v3 3/6] xdiff/xdl_cleanup_records: use unambiguous types
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Change the parameters of xdl_clean_mmatch() and the local variables
i, nm, mlim in xdl_cleanup_records() to use unambiguous types. Best
viewed with --color-words.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 48fb5ce6fe..386668a92d 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -197,8 +197,8 @@ void xdl_free_env(xdfenv_t *xe) {
 }
 
 
-static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
-	long r, rdis0, rpdis0, rdis1, rpdis1;
+static bool xdl_clean_mmatch(uint8_t const *action, ptrdiff_t i, ptrdiff_t s, ptrdiff_t e) {
+	ptrdiff_t r, rdis0, rpdis0, rdis1, rpdis1;
 
 	/*
 	 * Limits the window that is examined during the similar-lines
@@ -268,7 +268,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, mlim;
+	ptrdiff_t i, nm, mlim;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
 	bool need_min = !!(cf->flags & XDF_NEED_MINIMAL);
-- 
gitgitgadget

