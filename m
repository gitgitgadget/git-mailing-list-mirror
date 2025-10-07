Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA56266B64
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873185; cv=none; b=T4OcWKEwcMPXwowW6zBMzb9Fhvu0Rb76ztKMjp6A5KtqY4lx/EuRBLVVmxXnOZTIPGWA0A89SqjVePf4JfFf5dVXoLyXqeXU3/LB+S3a8JYZBfCRTk2edjHY5KQsLrG/x7leo9E3ZfEhFV/aLxtpq9Tsq8LDtzTEwFRt3EMR2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873185; c=relaxed/simple;
	bh=0MxuAFCIOCOsi0ktvkxmQqfZRgHK+O4zGo9N1n1tHTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMLWGZSrVSMLkDlOvhsdjYQ0bA4rIdY1+VsME1t0c8AaL5Hr/AzRMPqS7LldRJ1DsDGMPt/ooXAJjtiS///Bsar8tvil/NVK3l9mY8paQ6krN72XE4ThwhqUxSbx1Kaem2psoAbrnhgOjI11qS7tlv9dhnoB2h3KIM2UDd2Lmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=SfEWKwXZ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="SfEWKwXZ"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93bccd4901aso74828439f.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759873183; x=1760477983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0CsP40XuAvRTiv9w9zzlvsazPzYra1iHe9OTCA2lK8U=;
        b=SfEWKwXZG6v+iLaTihLn1VAb9xmFh3z2t5AAuGG0SpdTusnqAY4l2Fl5PJpT8uyjt0
         QvIErdQnhPhGuOOJds1eFPWNsPsZRaTcZee2NENquOW9sonaVUrf3THQkI+kaS2extcr
         kvkxasxKj+IbbG71gNGPQ6vrbmzGa7JGNg9iRb6KSbRg94sIiJdr232c+TAIZszylbMU
         UBh7TfP99awAFvga4sYpUrhU1R7StFrhGrIGXMt51iYqBI/pLjJeGCkbHWae/6cGwaLz
         xLVNo2REI0oR+7ZELnV9iL1pNi7B8ti2lu+bsCz2p+9CMcuvxBblG4tBH0GdRhh++Hl7
         XXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873183; x=1760477983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CsP40XuAvRTiv9w9zzlvsazPzYra1iHe9OTCA2lK8U=;
        b=Rqd8nHVPdnNCX70dq3DwtKyRgNVGze46dQtN7h4RcvPKZ3xxchWwDeu54KyLoRM+z3
         QuTdNWdsSXN3DxXki0M6mNCptk4uPpQH+b4mAIxVxOiVpk1rsmuPioM1zeE+LQmwuCF7
         DJx07UZ34zLWo+jSpgMqZwOGRe5O1mBPyGsfz69OBz9OJPw0vg9Q2yYU9tJcq1Eb8+a9
         ffw7e0QO9QcU1AWwBtqnCrBqKHwA5RJzYoVYaalLuE789H6JVE25gBEe2M8/u7RslSIv
         6AnFDILcL9A81mtUVMX3Oe7jpL0ebdduyFnqsE6LEQHvi5PJO7oe+pGvAYa0pMM3Cs32
         WsPQ==
X-Gm-Message-State: AOJu0YyUmgN7gQegOZzlg4+bLOr2JwSOUG6QKPzoROksotjO1/oQ6y0f
	iuL3fpodvrHVillV0DEdCrDw3DUOVwSB55SxNvAsnpIQStf//C0JuhxCQwGAN382zBrtcfQV0UN
	TMn4b+Kujtg==
X-Gm-Gg: ASbGncthodVsfgsgnf9aGKx8m9rGEqAG63ejXKbokpzGGxIMXSOJEC2CJL+4oPoRZee
	G6rEbGwLdJlXKrea02dDIOvvDPXUkzhrdpRhqmHwZvgWAMpTfkWpUPNm4+N2fcnahplFAeED6RO
	nWqX5CO/GYdccXemHFu7ZTxHGJA918RAiBRaAC7wEItt+Yy/lfdes82n9u4gGdicvtSklFUYimp
	RoenpXRDlkdcTz9juEsTkaxdH6EUc8JCtryG871kGh2ShwpI9/NnbhhjNnByVk+kyUxnBWcOeDv
	omzVIIp5DxLpVtgVHeIqB4AqIVOvNtPWrgz/nnY1SZUoBK80r7GpPdmRvvdfcfII27Ha6frKkpn
	1Y2pSIhOMRJqDSeMp3wMzlWBvdbbbybB6DeM7Qa81lK6Szi/P9jCEmyFrFt1e56Hnl1Gme5FulZ
	oxfKIVKEc2Q8YfZVJQgRL+mri76UqM0ypXIb/Evx4Gzk4yk5er8Qlx3JL5tcjQ
X-Google-Smtp-Source: AGHT+IG3J9ZXIpT7YINQQ5MBYhOnBRp41wBdPOrmEds6VAJTH/rHcD6DXumTkDhiLNzucPAeSqBuNQ==
X-Received: by 2002:a05:6e02:19c8:b0:424:8b1a:9326 with SMTP id e9e14a558f8ab-42f873e10demr8910915ab.21.1759873182748;
        Tue, 07 Oct 2025 14:39:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42d8b20ab2fsm68941135ab.13.2025.10.07.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:39:42 -0700 (PDT)
Date: Tue, 7 Oct 2025 17:39:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] SubmittingPatches: guidance for multi-series efforts
Message-ID: <f7a65e208c72e12fd71d5f788e372184250dcf3f.1759873165.git.me@ttaylorr.com>
References: <cover.1759873165.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759873165.git.me@ttaylorr.com>

Occasionally there are efforts to contribute to the Git project that
span more than one patch series in order to achieve a broader goal. By
convention, the maintainer has typically suffixed the topic names with
"-part-one", or "-part-1" and so on.

Document that convention and suggest some guidance on how to structure
proposed topic names for multi-series efforts.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/SubmittingPatches | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f48688e3700..d620bd93bd9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -593,6 +593,14 @@ description of what your topic does.  For a single-patch series, use
 the space between the three-dash line and the diffstat, as described
 earlier.
 
+[[multi-series-efforts]]
+If your patch series is part of a larger effort spanning multiple
+patch series, briefly describe the broader goal, and state where the
+current series fits into that goal.  If you are suggesting a topic
+name as in <<the-topic-summary, section above>>, consider
+"XX/the-broader-goal-part-one", "XX/the-broader-goal-part-two", and so
+on.
+
 [[attachment]]
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
-- 
2.51.0.435.gf7a65e208c7
