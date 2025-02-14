Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85494267AE8
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554586; cv=none; b=ONEyvcQ4fOmHP3qpxrOqqBV368D6M8/Wa55/dbntoJu0MnisjxBxRbdLbm8MCP064VIQEPWThoXXKJaPN4m24TGsc9783taxvDVdqKBckTQ/BzwL1HyfXFQ1zaK2cMoQ2mhHeHIcD/sAM49q7eYY6gCesEAbHnAmRH/kCrmcwro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554586; c=relaxed/simple;
	bh=IHFrwBzeBTcGGN5JMIDVuT7Fc8mL+T1RVWXz+6nnVaQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gDeF3g0i8gRZae/dpGg4VFG/EKNBBxsQDK5kR39QsFOQf+evKJGvt5ILh3HPHSkxn4lP21WoYUSFCVC7z9F9RX5+L5HFo31XSDtRh1Dr0Z6WbRoRvq1jGf0Op/8pqZlnO83V57+5xnLp+S+yV3nOTYckAVCO0+ux1WiQMrjvkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqZTAbxU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqZTAbxU"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2c4382d1so629467f8f.0
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 09:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739554583; x=1740159383; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF6/cRJzFT1NjWYwXM/o78DL4GaKOTSa+Xx+lHPFqMU=;
        b=dqZTAbxUg/y/ArtcTewkT3l9n+cVnh0HnRtuhjWRPwoN2FM6ABqtQdDWBaGp7FNmIP
         YOX7K5jrNkUySISkfx51Ht6Z/Ssus6f/YjBEhKJtGTyDmJKQlk5ylpNvW36FxCOvZgDv
         0ZaEXztvL6E9ny0SRXs0aSYmWR8hdNzA1E/ERELUd9ciNQCS4jm8TmvViCZGCIhGvkTZ
         FB1kJX58pVefgK+0Nhv7pc6nT6CrwRWEDzBDUuFgN+4KwwTpqRL5MzPK/8kTJC260lto
         fhWGVApbq6mhRLBmuWwuppWoFAMuSK3QZ89lfUKRo+txX2aoxOIEgWQvi6CgY1ZwmTuS
         yb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554583; x=1740159383;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DF6/cRJzFT1NjWYwXM/o78DL4GaKOTSa+Xx+lHPFqMU=;
        b=eZG6BQPUPY4FgMLPDL0LYLzzMuCJADJCSb+SvdmJ5GtK1zo2HoozGLDiClOMxYyOkI
         fdi96u7c7hnR2D7pDkjGZSgXYPgp3bmRX9TiIRPe68h1o1lIHctt8M2ZL3NcDz5kOx9g
         E1WmoSFfCwjwdniz2diUZqsd8o+16eg0+zmFuJoSoe/kMRg1IDQK4NUyBxAgOoZKS/8f
         f04c0Wb09wrvFAm29UFvZnH6fg78bvhPoMUzjCMYMQT94Xxoki6R1tCDbqKtgsu+zATW
         pPqxojkCRYsCaS1HFdz9oCJm34jNELbKCdmboj+hVFUu7JCI1pm7L+rPFi/t6Xj2mrs6
         SJTQ==
X-Gm-Message-State: AOJu0Yw39ujIvT3ZdFJmfJFk1Fzkf4XwrL5yO5MBgZzLr65xNNZDKEZO
	kcJMHPDKX80XCXAS/csVUN6/SPWohZvVDJZjQOgYaakpMarWB7K4KNBLSA==
X-Gm-Gg: ASbGnct+q3fVLXdhlpnRPHNgbpMEPVHvct+jzrRKfrp9GhBA5T7PKi/EZ9xgXq6Qxyc
	jENXXTL+9WQVly9czP3IkLWIN/mcKHeewSfKZrBdZPUSuuepUc5wI/AuFrcb1MwHygqS9KKdqVl
	7TCoZzvx/M6xYqkGmV0UegugGqRRjSGXLie0nlpMEFlxtKiFK6eqJwV1yoK7ABE3cTTtuRfk2Pq
	wHa26h1+c31+fIO3DhXDlTLf73cciMyiEjsrKIWzCbHBk9jqFwJtjepmD2tuKCjmS029hRWu0tk
	WeiMBGQdxyUXg/tj
X-Google-Smtp-Source: AGHT+IEcD3P/yJqsO93jiPsb1rK/18uvToi1xH2Zoy/b6Pv3TmzLqSa8Ukz1Yt1i8/XKPdxsM010QQ==
X-Received: by 2002:a5d:6d09:0:b0:38d:d414:124d with SMTP id ffacd0b85a97d-38f24d74196mr10466751f8f.19.1739554582577;
        Fri, 14 Feb 2025 09:36:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1aa779sm80329525e9.30.2025.02.14.09.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:36:21 -0800 (PST)
Message-Id: <140794b8846e94ec3ff77920f0153f65d434f07e.1739554578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
References: <pull.1894.git.git.1739554578.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Feb 2025 17:36:18 +0000
Subject: [PATCH 2/2] config/remote.txt: improve wording for
 'remote.<name>.followRemoteHEAD'
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
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/config/remote.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 1b9814e8aa4..25fe219d103 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -110,12 +110,12 @@ the values inherited from a lower priority configuration files (e.g.
 remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
 	The default value is "create", which will create `remotes/<name>/HEAD`
-	if it exists on the remote, but not locally, but will not touch an
-	already existing local reference. Setting to "warn" will print
-	a message if the remote has a different value, than the local one and
+	if it exists on the remote, but not locally; this will not touch an
+	already existing local reference. Setting it to "warn" will print
+	a message if the remote has a different value than the local one;
 	in case there is no local reference, it behaves like "create".
 	A variant on "warn" is "warn-if-not-$branch", which behaves like
 	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
-	Setting to "always" will silently update it to the value on the remote.
-	Finally, setting it to "never" will never change or create the local
-	reference.
+	Setting it to "always" will silently update `remotes/<name>/HEAD` to
+	the value on the remote.  Finally, setting it to "never" will never
+	change or create the local reference.
-- 
gitgitgadget
