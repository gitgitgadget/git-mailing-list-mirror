Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5433597A
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 06:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744784098; cv=none; b=CUocKBR4Tu5ZxRHmJq9Pr0lsd6CBfMhnhuIp+99znHfAXAA/2b+uKdk5HENN17SCZecIYX+WVeVWwz74vleZXTSlILSAYI+nEVyLQRU8ugRaxEOzg6ihItynHVjZOdRjPysHsjvQgImQDmhKgjubOQLSFuAliiC/QTf1w9CVkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744784098; c=relaxed/simple;
	bh=L3DNf/aCGpMmBahQ99C6ynAyL9kWd09cZf9JvAISJcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWWCkeYzo4wXAFXrTVB/2hvvJ4pdETbCIviS5GtR14ybPjic/5TCKBhzyEX24hgxv5375WDEfHdwSwyMJX/bcK0OrnIlv7KrlGnFE4mQh+uGvLdcxtqfxsvN5GvejTaw8ljDsFiEcH0Kzrtq2V61a44InGBa8dC7dygi0GXMldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7/94kOB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7/94kOB"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff85fec403so350716a91.1
        for <git@vger.kernel.org>; Tue, 15 Apr 2025 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744784096; x=1745388896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+p3d+6hSKHmlJMu+tJJE80IhOvH/9q6GjOOfUFSdU6Y=;
        b=i7/94kOBFHZ6XA3rnc3x6ATKRfNTZc2oXqQT2zyr86XNiAIEUNyDeiEn9PSapInIz3
         SOND3YxC2wxslJT2MRAjQvatjpR/u6fDQsFLSS7UdJyQDaRvXJBYnyNLyKUfDRAhn7Ev
         UhdscSVzjKO+zDhhy6UKnBb3KA/qcAzexW2/HPNFwr/HnHPtbPdMo+1bQ2Kcmemnws2b
         h4xfHBUNiTCEuZrF6Z151L6Hqct0fmA5UKbOUnYYkwYjDpCq8zsRNX1KIRzz0J1yz782
         OYZpOeXkEEnNaqute2PNagxI72j40xgTPoA7Ma7M6UjSjqe2WSEf9FUbMCJduSCU3Ex+
         Di/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744784096; x=1745388896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+p3d+6hSKHmlJMu+tJJE80IhOvH/9q6GjOOfUFSdU6Y=;
        b=bWsAgdiaub2OxQqoD/xAXrwdQUUFXy5LO5nRIIQmMV6fytl8CbRjxeXfgXWrt6I4Wg
         LWzKatnvHyc4e232q0LjAbH/69MHTgaf28AvZKkaEZy5hg+/Z1RUBpgv8JGfMaX77RWu
         sqyyYUF6PSZjInE5QiR8zFZoXIH2JekpUaYPH6/150dLtJ+WUz4ABcQmQKtBNKArtkNr
         NAYVkOMc0tR6i5cDTGqP0mRCz47ImJkXLjLtYtqYZvPUAS+cpAlRHI8d0bLZBuAQkhHA
         T7Qm2/XORZTpvffljgvHZA/WCxvS9H2tVfn181myIAhmCvkK0YpcnKYSDTyS5OfGsxik
         hKhQ==
X-Gm-Message-State: AOJu0YwnSn1A0QgTHtOVij7sBJsf0o3KvqGsR4L9EH9hCG4Gs97ZBnT+
	m7XtsNB564M0BTDFAVmCF8/adVpiQDoiJndkNboWb+ib6FQ0bcs8dPrwPg==
X-Gm-Gg: ASbGncstS46WkN6RMSG0OBUjCJxrjNnYQLEvIpeliEK76dZzp8t6UkoF0DVoW+q9esv
	375suoRel1wR0/QARzzimo726gHxDCe+eg80cJUXYQBvwvXJ5dvGSKsAiWa4cbgJCqZ+m/cioSO
	6Ta8j5sqX+NxzdfNFSNkJZG8y2P3p9/vdx/39eFo16KaEG/KSFF1nbe4JxjNzLRwbczBzWrQzts
	mObz7V/iu2XGDmtV3cYeJzci5+N1rGc8CusVMHfqnsNVFTZ7/bZYOw/jqyBRlNoDMsO3FNQb7H4
	7V+L7fdfGHm1nL4jPk6eb17VZKsRwbaXAKnaJpugexh9s6Omzyohb86H7A==
X-Google-Smtp-Source: AGHT+IH+mQwSfiXPlHtnuWwKrdGGyPi9Me9xlmgUvtW4JBl6B5ao/ppafNbHbBddP9lNEbL45I/sJA==
X-Received: by 2002:a17:90b:6cf:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-308647291e9mr741792a91.17.1744784095996;
        Tue, 15 Apr 2025 23:14:55 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:5522:eab2:4cba:30d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308537cdb13sm1688603a91.0.2025.04.15.23.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:14:55 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH 0/4] update MyFirstContribution with current code base
Date: Wed, 16 Apr 2025 11:44:46 +0530
Message-ID: <20250416061450.25695-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A series of patches extending my GSOC microproject
Fixing the documentation MyFirstContribution.adoc

Updated various commits since the last patches sent.

Feedbacks taken to write detailed commit messages

K Jayatheerth (4):
  Remove unused git-mentoring mailing list
  Docs: Correct cmd_psuh and Explain UNUSED macro
  Docs: Add cmd_psuh with repo and UNUSED removal
  cmd_psuh: Prefer repo_config for config lookup

 Documentation/MyFirstContribution.adoc | 89 ++++++++++++++++++--------
 1 file changed, 62 insertions(+), 27 deletions(-)

-- 
2.49.GIT

