Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC089135A46
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 22:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454980; cv=none; b=Sv63jQ9gMgw/LMYwA6aze2KFTsj7e9zYZMO9ogRQNgTCYs1dQ6OqdCaTyFt4t1aRiELXJeewU/WdrrqkpXaSh+0tW41hls5ygxGaLpWIGLr35b2SLMxYZZz7YhMSNgC8wbh+pAbte81hedg4BiGexsrI+BhR9VRvPlpgmc0BC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454980; c=relaxed/simple;
	bh=aQ5DGE7lsmVTPujc0BLMwuvX4XMpGUvYNfkAUD7A+tw=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=MXtGGf6vmkUHMq++qEsW0IJ7v9EWRDtMk9H51sNtCiKpIUPMDC70OV3BfXbL0J6akBmufqau0n1ZBqEhfElWykh+VQ5Y9SXQ1jBYXldZD1zjFYnhFUQIT6807UuNdsG1nCGNxb28uWXHQb/dHiOfk+rssCFRSTpGoRdpVPyqq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G1mGtCmb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1mGtCmb"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4213870aafdso18358355e9.2
        for <git@vger.kernel.org>; Mon, 03 Jun 2024 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717454977; x=1718059777; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uSarN32CWfM9Yki28X95oNlpOQxk3ev8zw9srTM3a8=;
        b=G1mGtCmbmy05o23GCisxXOoqe3PJ5pVuyAsqW86xzz8gJr3RxqeGXZFURVH4vPmeT5
         69drC8lGXI4McYiJ1a2eoz/Q/NCylAz1G/qpXj3lWHxpTnjcgERTdGku1iLlshmVcPKW
         NoiYwdu1d27ymjMV/ybaLu4iGgCGvLwDJPlgWjBFEZH8DZGGmUyQhogtt0PuI8awTIer
         72jvRxuH66VFyxezPmpDEJPoYcwVaBC/TGddanS6z3FcAVn10TWWstEAGdyO4n2Pkfos
         ofo4RzqxZVv83elFezn6ZRC5QvDbem8LFrkbrX+gRYDrUGI+/SJ0fMuRdurpQcIlaWmU
         5VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454977; x=1718059777;
        h=content-transfer-encoding:subject:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2uSarN32CWfM9Yki28X95oNlpOQxk3ev8zw9srTM3a8=;
        b=bBTohWRMsmsI+uS808tT1J5jZKDfR9ZgLADlmjryEVv+jsrx4BgTtKiwVaf7ro5EzD
         KKtuPm+vbmlJYEnJXmSd5P5gV7sP3A19zWQhiMcuHes836p/bovP/BIWVTGNFm4p1e3R
         myqVV09ZMfFCZASdNlgGVgWP2i6lBg1yeQBFCuLdcaINOVrJjygAdw15cCoWNpcG0Zr1
         k3ddj+ny1ctiW999QDEy+NAYynu4V3BSXUmMA5mcqjEWxwI5xKTRKPq+KTVdA/6izoz3
         44xcDw+s2d4WEvPdliTtaDHnfX9SY5ZqVIct0ZgCe3gSXWLg2gi16T+wGJtKzhlPucsc
         ZI1g==
X-Gm-Message-State: AOJu0Yw9SO68FZzgKN/S3IZVPhnZbBXcvSyT7VEr4Dvuc/Ljw/3Rs10/
	s0JFPpzVMlr2gf7G21OABnlRZiT/6vbnUx99xpZmY+6KT1ZQH3ODzlvdBA==
X-Google-Smtp-Source: AGHT+IFEIO0uMk36jb8qBLcWkxW0c2vyqhOoQnN/knRHFkP4Z0jbSMW/ngiLg0vjWCwmU+W6STQJSQ==
X-Received: by 2002:a05:600c:1550:b0:420:fff:f4c9 with SMTP id 5b1f17b1804b1-4212e049964mr106424635e9.13.1717454976841;
        Mon, 03 Jun 2024 15:49:36 -0700 (PDT)
Received: from gmail.com (32.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133227f8asm117205045e9.19.2024.06.03.15.49.36
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:49:36 -0700 (PDT)
Message-ID: <6269eed5-f1ff-43f3-9249-d6a0f1852a6c@gmail.com>
Date: Tue, 4 Jun 2024 00:49:35 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
To: Git List <git@vger.kernel.org>
Subject: [PATCH] format-patch: assume --cover-letter for diff in multi-patch
 series
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If either `--interdiff` or `--range-diff` is specified without
`--cover-letter`, we'll abort if it would result in a multi-patch series
being generated.  Because the cover-letter is needed to give the diff
text in a multi-patch series.

Considering that `format-patch` generates a multi-patch as needed, let's
adopt a similar "cover as necessary" approach when using `--interdiff`
or `--range-diff`.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/log.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c8ce0c0d88..56101672f8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2286,8 +2286,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.total = total + start_number - 1;
 
 	if (idiff_prev.nr) {
-		if (!cover_letter && total != 1)
-			die(_("--interdiff requires --cover-letter or single patch"));
+		if (!cover_letter && total != 1) {
+			warning(_("--interdiff implies --cover-letter for multi-patch series"));
+			cover_letter = 1;
+		}
 		rev.idiff_oid1 = &idiff_prev.oid[idiff_prev.nr - 1];
 		rev.idiff_oid2 = get_commit_tree_oid(list[0]);
 		rev.idiff_title = diff_title(&idiff_title, reroll_count,
@@ -2301,8 +2303,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die(_("the option '%s' requires '%s'"), "--creation-factor", "--range-diff");
 
 	if (rdiff_prev) {
-		if (!cover_letter && total != 1)
-			die(_("--range-diff requires --cover-letter or single patch"));
+		if (!cover_letter && total != 1) {
+			warning(_("--range-diff implies --cover-letter for multi-patch series"));
+			cover_letter = 1;
+		}
 
 		infer_range_diff_ranges(&rdiff1, &rdiff2, rdiff_prev,
 					origin, list[0]);
-- 
2.45.2.405.gf8e6085128
