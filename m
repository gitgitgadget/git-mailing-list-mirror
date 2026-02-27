Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A946AF0A
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772228551; cv=none; b=Z0Gt3ujUnnkqikwNNK1qAIfPIaPMNeORGb0hl9B//SIP+PfDsO58zRLOJEyMqwRqPxcF3VqfEZ57jKbg0T+rAqbBuqCiPucUAgEFsoQe99tYFKUG0f9/NfvLsVYQTCXKq7M33ofA7vFXToYLT2xOdSuqZFCHWnVZPepUiKrZvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772228551; c=relaxed/simple;
	bh=KNSyu3Kx4FtO0rdBT6rR4Rpj3vgh46ZM6t10065L8K8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BfLVDbUEZY16iqvY7NX/unmVx55ggUpRyaO9YjvV2LczQuJ7ByUfyRxmQUN6kNtrYGCSj1IynXuw9qiPWOWORlWE/QEsmIEFdIzHPDnV7+VrP6E+94NbvaKyA76uIQS4ctRoc/0aQOYF0QATADEVfOTa9iHcH2p/madDel4FuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyI7oUDb; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyI7oUDb"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso1862940e0c.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772228549; x=1772833349; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNSyu3Kx4FtO0rdBT6rR4Rpj3vgh46ZM6t10065L8K8=;
        b=KyI7oUDbitkbAM7EWUCkIEMMiLYrai6DeoJuVHnRpZMjivK9DHOWfeGQcGvTt57k71
         cNpuTfr2jpjY3RLbPXYvQYzMPNtWVbcmWqEO5w73Fxs/g+9G3mQi+RcPwOHce6ijAZYE
         7+sL9NyRw+pwypBHke7g3lcqPhLSR++NGqiwcks903DzSGgoq/U7pWnfWSn4GjLs4uxe
         wAarCyeXTaaT8b3A67CFzbRA77PoWp6BSK4jmIarJvQA3gEH9i+7ynuMtvEoW/EHpReE
         bkfdIcA4QEVSTsZ0eqdAglkbM/tPt1mhdc/UgaxzMyEu0U+EOfIi+o/q9bDWJ9qdOqp3
         fiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772228549; x=1772833349;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNSyu3Kx4FtO0rdBT6rR4Rpj3vgh46ZM6t10065L8K8=;
        b=tsuAr3PLzCPpxRTV/RforzW/jRNOinQh1Zbyiv9LaYL9kdJePbPCZCu00fhN4+axoD
         GEXXzEZ7OQAuBKTZuWbt1JrCfKmozGo0R9YXZXkTR78o4jiyCbNEsTvRHkzIPzezV6eG
         yh73Dm96k3va7ryNbFbgCm8ZBKmO67BHQhkhuA45nLWP9+qbdyTTQcp3QyLujoxOpp06
         JoJGso8dorQZh2GjYNhq1vRbil78UBp+JJTYIFP9rBoB1a50d1ObDS7sC/W5+Pw/p/Ib
         Rf/fos/C0njU/poIk1BLqr1GhqOByn3jv0A2XoUNodkMO78CPUIFYS6Q8WKsuh38B7g5
         RGHg==
X-Gm-Message-State: AOJu0YxiTubOFiHlBiHPj9N3R/xzjKJ/Cu5NSFXasqvkXKln4vWA/39X
	SvdzEs7y2lez6h2lNZY5PtUqY3UBhwyTsFukkXUnIpF2TEAYW+ywcj+m
X-Gm-Gg: ATEYQzwcSuO5pSTEb9eibTV3npBkErXE6Qe+4uZPm2yOsGOycuLA3T6VZmsxZVifHft
	r+OPLWoaTRXYwwpS0tKw4rtIxXEhnwbO1swmpcSdUPjCK1RT0tK65Jj7uNugm4OelGAHeDShCPt
	LXVP38wxviGe5h/fAy8b6vuaSQv8MV8WY+1rV+m+uPxNuI7umy0smuC5jGXlc17wcE68U4QIGGv
	MpZaJvpN/7PuXV2RzNQWv0jA1JLP6InTPM7hjWdDuHgJKiCOslK8+Vj+haH9mwEFgD7ji52DoL6
	C/ARmvkQvXtjFP9k9gzycleWVZmBIFAQtGtDpZesBP6ve8InkVhwXHqgj8V44j7kReSdm289JLF
	E4Mb0Krp6hFNjc7z8t5m25Lytc87aQ3bFdwGS4JutUftcfIAc7wGOuEbmsPUsuY4JRKMoBJTEes
	W3wKz60nSPLV//98CmxLFzggT3xZRmpr4MlgXwCTFJ6xPVyfLi1IvXrg==
X-Received: by 2002:a05:6122:4592:b0:566:3c22:c13c with SMTP id 71dfb90a1353d-56aa09e05aamr2617230e0c.3.1772228549446;
        Fri, 27 Feb 2026 13:42:29 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91b8c7ddsm7894360e0c.3.2026.02.27.13.42.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2026 13:42:28 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v5 01/11] repo: teach info context and category keys
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <99c8058298d403508ab2a23ed06c36b8707989d0.1772220640.git.gitgitgadget@gmail.com>
Date: Fri, 27 Feb 2026 18:42:15 -0300
Cc: git@vger.kernel.org,
 Phillip Wood <phillip.wood123@gmail.com>,
 eslam reda <eslam.reda.div@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <FAD4CF2F-2BA4-4DA7-8E54-086FB2F9F674@gmail.com>
References: <pull.2208.v4.git.git.1772140487.gitgitgadget@gmail.com>
 <pull.2208.v5.git.git.1772220640.gitgitgadget@gmail.com>
 <99c8058298d403508ab2a23ed06c36b8707989d0.1772220640.git.gitgitgadget@gmail.com>
To: Eslam reda ragheb via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Also teach git repo info to accept category names (for example,
> layout) and expand them to matching key.* entries in request
> order.

If you have a patch where its description says "Do A. Also do B"
when A and B are unrelated, there are good chances that it should
be splitted into two commits. This patch is an example of that.
