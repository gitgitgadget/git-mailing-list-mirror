Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C792E40E
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736316146; cv=none; b=H8+V1N527B1UYBSrd8kb1OwOeFUsGxe4NxE6Z/J8nPcKnPNG5jzYRsMHOl+2z6BLRFhZ3NTEAHIBElF+gz7N+57mZR0+HKQTHdP/h8JiOKUZi1M7SXSlRRd/JVQM4Nu7FgRZTwc4irK2OCFy0yN+V/BfORvX2XwL0p2Thf/VY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736316146; c=relaxed/simple;
	bh=P0XpJjg95ijTMnZdTq1P52zRRjaCf6jFLenBtf11HCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOgSCwT14WlMaWVoFNFrtHCrrLrTdRhwFW7cEvS3Edc8sODOrDKSLjEzuGHC/rFqG9KL9qzqjUCAfUx8NVF2N5awDJBpKxm0Z9lGfuYpN0OWwGobzk+8DC4MrXis+ESoh79dsZxozDZ7kw5kLUDPfz1js3urGEdT7SC8pr0j7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJR6Arx/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJR6Arx/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163b0c09afso240198245ad.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2025 22:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736316144; x=1736920944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yjS5a5ycLn/RVwYHEUbkfTdSkneS4D5XbzpECaasAc=;
        b=CJR6Arx/wO76Ewf9Dtpo2Z9ZGvK0owV0SpLyiWiAHIRgfdY9/O1yhcB6SpN1fIC2XL
         6/BsCbJrW/K5Yr99ZXuOPJTDqUW91qK3wKvXdsJ5Eb03wQgpE8ccS6aYJzNNt3Stp7ft
         HWBBj6GK03EjWh9nOxuNDjY94QfzadA9p2COrULMUmu/2NS+KL3WfWwgzL8jTtMhkTMR
         Xy3ximagnTeS02L8RnpwHqlXVqR9NiV1qwacR7uNbvZx61kvyACHmKmpA+4vyMIZ4qgJ
         GEWZwsm5plz4FahoJxYZ+KlIvMBiTldgADBjfKsGCh8g89xINOT2fzkq1J8zO7BVsY62
         O8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736316144; x=1736920944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yjS5a5ycLn/RVwYHEUbkfTdSkneS4D5XbzpECaasAc=;
        b=Asv3KZUQbXXmpx8071ylQmSbYZDPvEzYQmkWFImLOMsv+YWZvTKrhWJYMlXctHobLW
         qTFgIJ9INE1Bp3kFao9tkseCaS1s1EBiNRxuUZroEHH/MQyZNtBDN1j6aTYpYb7x66x/
         1Cx1TH08iU2HSV0T8tVL9zoPjI1sSM3S21+gXR209e1yseFTY6BcjWNyejwNSheYV84q
         25sNot8UMJBSOsU7lmQpd5YCpwlw2eKpzrGTpnT3PXKPCcA0o4c5a3R5hRnMNey3dxT4
         3so7jZV9+m6cPXSGC6bP0gSUu9nHXUTawduEQQi6wKOARa9JhW/N/4/5SZvH5N+KEKqU
         oX5A==
X-Gm-Message-State: AOJu0YxcqyTCxx2/OdWOS6op/cHb/LoXXf+4h5JT3EmrpkTxEkH0n7Xl
	laRaVhH9DBJPcUsIleHV1G1wHxrHgi67/Mg1wKAl5r6tOp8Nm76J
X-Gm-Gg: ASbGnctrBMX5qYDS0JtoCQk+vmq+ZAUjLAxLzr3OMPrYTNAtUIW3uebLqPKB20hB+mT
	XWJA1JRLuxTc60we/TM5y36oPeC9xRc5LTpdCDGfJnOYmcT6XcnOWU8U3b6/VKRQPThzf9uDIyn
	bbDCiLMdVfCVZPvPBTxWJ+Ip6T9X3WvLz73wgtUBDRuAkoQuAIEEvtGusdVzfQPKGV4RkhxpGOB
	r9SpRCb+G0HlF9uJxj8vEAx9bNfncFSY7+uh3ekJn96Ybju7U+oYvreCutRA9ZS2Pz18KvB3kmM
	/qPd1teIGDeN7hsmP62V+Os=
X-Google-Smtp-Source: AGHT+IH/TxMBS2yPfhxyNjUSPtWVmpeZMgcQiSBpqoz+lEfpQxYTt1FzTRW3hwGij09OFVoHxab9ZA==
X-Received: by 2002:a05:6a21:7885:b0:1d9:c615:d1e6 with SMTP id adf61e73a8af0-1e88cf0f669mr3216990637.0.1736316144266;
        Tue, 07 Jan 2025 22:02:24 -0800 (PST)
Received: from occam.ucdavis.edu (campus-069-172.ucdavis.edu. [168.150.69.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842de3a0c49sm31910704a12.62.2025.01.07.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:02:24 -0800 (PST)
From: Jake Roggenbuck <jakeroggenbuck2@gmail.com>
To: roggenbuckjake@gmail.com
Cc: git@vger.kernel.org,
	Jake Roggenbuck <jakeroggenbuck2@gmail.com>
Subject: [PATCH 0/1] Exit on invalid diff status of diff_filepair
Date: Tue,  7 Jan 2025 22:01:50 -0800
Message-ID: <20250108060151.7218-1-jakeroggenbuck2@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CAEUC8gmgq_yViedLGHOeSyvR9rQK+O-8Fh9wzds=2+326ngUjw@mail.gmail.com>
References: <CAEUC8gmgq_yViedLGHOeSyvR9rQK+O-8Fh9wzds=2+326ngUjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Git showed that object files were empty, so I manually removed them.
After removing a few object files, I ran `git diff` and I got a segfault.

I have since narrowed down the source of the error to a usage of
`diff_filepair`. I also noticed that the `status` field of `diff_filepair`
does not get set and stays a zero value. My fix is to check for that invalid
status character and exit gracefully with an error message.

I modeled the behavior of this patch after what `git log` does in the same
situation. `git log` will exit with a message that reads `bad object HEAD`.

I initially found this segfault when using git while working on a school
assignment. I am really interested in helping fix this segfault.
I'd be happy to hear any feedback.

Thank you!


Jake Roggenbuck (1):
  Exit on invalid diff status of diff_filepair

 diff.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.47.0

