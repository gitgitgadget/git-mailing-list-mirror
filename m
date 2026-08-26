Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B0388394
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787739598; cv=none; b=GAuNpjaIPQI1Ew5/qtQSwYOGS6fEpQeNHqMkbj2EwHcxM53QwrO2arkMGmvYjtYCwjsimAPI4HhVx45mh3v9ETJHxAy7j7m41a4OC0TiGRDq0BO8nh9uqKlj2gQDj+CCO53uOSXiTWU2DbLZxyqU7wUL3EhBOWNvkH2ZDH6URos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787739598; c=relaxed/simple;
	bh=N0WMD2NEoMqy5ejZuH1H/0bwDUTiN/IbGGRveTwUV/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIvuQRjb6YtW2w/GcY3szzw3OBTs9b2eMJ58CLCx9q2mPpqNZ/bzkm7/sznIX8b43cVxvkxT9dRVnzr7qhRjdnpRX9TU6FIBCH/cHzF53DwV1gl3wJM9DRykhvpyfg7a0fEGUrV/bY1emUX8mxO2VN1yJHMTFT/EfsBy0FbmAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQdldOYD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQdldOYD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c250a2bc3b3so94035366b.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787739595; x=1788344395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQXucLS9JhhSbzwEWCxCwUTJ+50Oo1InaUmt4jFaezk=;
        b=eQdldOYDs+N0Xxb7abYYLsQaMxDCikpK5UO0Pr3y62kWoY/h3qnmfrgsAThWFDuHKO
         2ip9qonOR3RJmQ1kRg8jSxG1AcrHzza2DDiHFsL1XoI0oWVL8Fxv9gX7eMQEv2xTS8oy
         g150LDFIPugFAjg7rQErtZXl7goYuOmO7c0V/NoUocOd+M1xDt+h0qMnVUjq0GlWPv4H
         zqM36TpinEvykb+X0Xdkwt+HwiGYSpVNpKTeXyuXtvDdvtd5O9PnjLRQ1VWznpDhk9lY
         EONHVadAA8/R1QK8ZuLKh7yGJMELJn2/9DR2sQD2r6vAcJw2TEGaUV0OfxDYS61UWP+p
         zfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787739595; x=1788344395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oQXucLS9JhhSbzwEWCxCwUTJ+50Oo1InaUmt4jFaezk=;
        b=bih6/dNEElUqXuSmLHyPFIkKPZHPJOoXHw/M+qQM9IrieduXyI2YNsQS0ADqQw8Fgc
         Z5cZZvYKLNyAaYXn5s7XtSi49Ad0vmeMrQQNCrUgP02nfBAoDG8TreUSLpdT4O66hIwB
         nUWotSo6xSJKOx/Sngn41EXfmg15cK6WJ6YFj63aspmAlVWFYywo6iw36K/nxCTEw+Va
         fnJlEyowVTgB3bVulEpksm4hof3/eRJZymLkKllsom4pT026gsl14L3rdnI9i2Fg+BrR
         y/L4irqjYrxAhMvY7lG9Sm3OIQ3pnkZNyNXBjs2RSNYFNPlaDYfZC5LXocxU/lqcPSZQ
         Yc+Q==
X-Gm-Message-State: AFuF++m8vYVYLWjcCV2TkySqceDpHGVrQ7fnI9kG2SCKNtazDK93Hxo5
	KdLmcAWVrQwiXLr06MJm0sRORFoPTxyzk/RztoiRuixnCoQZUs2Q72U/
X-Gm-Gg: AR+sD117FFdlUYJByvHjG/IZqXy1Nd8+X58CfyfUXcxpY1JOhAQEziRHmb2y2xV0cXf
	e0QNXp8U0o4lw4Hh+wX8YT4o/xCPSiRCRSXGRLS5fqb4Ep5frxfGncIyli3S+PMp8U5dor3i4Vk
	kxIgUrm62HovdklMWAJ9PpoANbz2dDaehhSbOHxA5vvgDo5cJTfmTiPzLbL2WO/zGL5Z2zzw3ZH
	Y7JxFMBcp54l1BZEKconvGgmZECOzIKAy/gezPzdUInF4zNaBO6UQaLQOpMY0BkrJ9TkuS+ocN+
	vB5Lon0hCfhLmBohz4y4uLQtUrsHYpNcx6sqj9w35pp0QeCP0Uf1yMhtHDGpp2pvOp3N0fV2vqT
	SMpXDA8EsXqe1Np5KXJ+qJdmOd1LZ0BaFLuHEhzb1KysN/GiraoLwi9iA9sJQJt30YHIFCTgqBF
	H68SCHbwTWyto3WOWvunZEoRPLByOEaSd48OZa/mPETvUGu3RCUekfwuVcFylWgGFWbQB2dRUo9
	zIdC+f4WKEtWhGs+Ou9hqGYtl8=
X-Received: by 2002:a05:6938:a089:20b0:c24:c250:a6b5 with SMTP id a640c23a62f3a-c250bc2db03mr538917066b.12.1787739594859;
        Wed, 26 Aug 2026 03:19:54 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:d310:93d0:2327:2f19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d6acasm477971566b.9.2026.08.26.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:19:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Wed, 26 Aug 2026 12:19:37 +0200
Subject: [PATCH v4 1/3] doc: add proc-receive hook info in
 'git-receive-pack.adoc'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-758-introduce-hook-v4-1-6b14975ad957@gmail.com>
References: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
In-Reply-To: <20260826-758-introduce-hook-v4-0-6b14975ad957@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, jltobler@gmail.com, 
 kristofferhaugsbakk@fastmail.com, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=N0WMD2NEoMqy5ejZuH1H/0bwDUTiN/IbGGRveTwUV/k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGqOvcfEiURdzK/SvINKB57KFa4vDfCOoGjwK
 6RtMUvbjJimKYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJqjr3HAAoJED7VnySO
 Rox/RbwMAIKiypRGZViQ4KbUNUM8TcXLB1vcvnRy6XxzjSu3OTXvGgOki6/WsDLxi83kwYhfkq1
 I3YD9DPpoU0gQwH2lrfUUseEAmQ4/JsUErvvkVM0WZHBuwfcA3rTctfpumCVbj4YawN2VHSL7cI
 Zn+lQ3F0pIps7DmdJ897zldaSFRg+yOwtK1UQCGIlDDvISyR8U0R7gL1nmKPyNUEolHCNBjYhT6
 CpvNBaBYp5Y/1/IvA5aJlXh8H8n21tzGqO+DAYtl1enY7cdmg+IgjhPW+5FzyIEZOfgdScQji25
 /P5380x9E6AFowzs3uFPb8oNOEX22NeOy74dw8oR6Ft3Reg1OyGk+vHe5vCGQstXcqck+Pc4hut
 ztgDT0QAQEj52LP1OCweEkqVOWmfcDs7KtgoDqKLUHfKSqS6kV7UtQeJ+9dRWbBz5xwWBJtP3Tx
 e+m2yhVMUUyPMH55pfjOhxU2rKza1h9rR5IaLmhI7+8Lgv7M0XXqG5ncdU8+DUbR/y4JadUn937
 mM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The 'Documentation/git-receive-pack.adoc' contains documentation about
hooks which lie in the lifecycle of 'git-receive-pack(1)'. Unfortunately
it is missing information about the 'proc-receive' hook. Add it.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-receive-pack.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 0956086d61..4349487e6a 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -236,6 +236,12 @@ if the repository is packed and is served via a dumb transport.
 exec git update-server-info
 ----
 
+PROC-RECEIVE HOOK
+-----------------
+This hook is invoked by 'git-receive-pack' when it processes push
+requests. It handles refs whose names match the patterns defined by
+`receive.procReceiveRefs` and executes the actual ref updates. See
+linkgit:githooks[5] for the full protocol description.
 
 QUARANTINE ENVIRONMENT
 ----------------------

-- 
2.55.GIT

