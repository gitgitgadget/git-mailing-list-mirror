Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985941;
	b=Ed8vJH5Im6fRagT0voU38TIU5+nVF1NEqVBeWnvh5mcpycT0TZZ1PVz0vYTwehSERX3L
	 vZUJYogwA04PkayAwm0KfBQPT5x6jRqKsh+atVASlRw3woMGVSYMu33J6pLzUuCvubw/n
	 TvmXnuClGvmWsfUIOJHQCLcN9x6YjXSwPWmSwxdGZ3qdh+tx8i5VXsdrlfQT7wVErL7tR
	 lVVc+M/A/TPJp892CTKj1M7tATpQxvBL6IWOIbHUT8B07rFb2NOInNxKR6oOciNhpVY1q
	 QYQ7rpank5MmpPuxprYoIVkT99y1noBU05hnxBtdyRqXozniNsuqqsDuSExdrGJrjSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZDdLrZt977+zcStHE0qLlhD+yFm9Dn+6dZXPflHoSWw=;
	b=eeqaL9tyO81IIHmjKeT8hK2AsMCG8SDdLbvvsUBApOw+tXETTLTYDmb6H8QTxsc5MIi+
	 rByOVx1eYjMQEY31vPR2BahxaUFf19Sl2KO+05YIkDO7mB5w+ZQweRqZEzLmt8Ron5FQW
	 XdmUjiwFRMWEsNzL7hojxHsXrwoxfADLVZ/HoXytZfTppe6Vb/LFVLl4DkOTpbtcv2PB/
	 yq6HRNE4/RFihC/41xFlkMBVxJz6ya7B8fM14k4d3EJ4pUs+G0ucaXWVnyFR2mdTtCv/9
	 90mzKeNXEsNoXYrupBu5rtqm6xNubzvjGusrMueVofsuqRZgD8162vRBrJbNE46T4xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqUzONoQ;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32692606A33B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32692606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CqUzONoQ
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso596095a91.2
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 09:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793985940; x=1794590740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDdLrZt977+zcStHE0qLlhD+yFm9Dn+6dZXPflHoSWw=;
        b=CqUzONoQrW9ZFmcFFJ7GDDwaFh0+vRcgqt9E9P6Us27XEE0CF42ThsojJJfjP08Lxu
         +zhE2OndFmoSCzl9h3n7YWc3AUZPI1WDXpEPJKG1jyR/2b9H2whlV5R9lxUzjNx403b8
         cmfCRAS4jVONualMQz4TY/YEQGxtEJENyl5zi9XVkrwfd8cMdMkXhPFfSvMgfmAG8UL9
         xEi0bPP9ai1rp5bx58RWLUr81S3Vmq9XpQLlimllDlsOVKgZGlPPnVTuly9mlkRUUPiE
         O6UKI6tNB5Sw3CccPGXsSpYV7ERsS9s+oKpe1atHLi3jipZO96G+wI0Y6/sNlj79H+3q
         BPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985940; x=1794590740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZDdLrZt977+zcStHE0qLlhD+yFm9Dn+6dZXPflHoSWw=;
        b=lHVDK1t8WbWD/DkWDcQgKjgdxVEPHP18i2GBuib806xomkMpAPJIGSU8m95p64lxwK
         zg5iKKe4QXoo6zMC4N0qZV6r8P86MrAW3Id3AUYOmRQHkNivdtAZTOCIIWlHaVoDqSI1
         wq+OaAuPGBRPpvU7FUa5/lkTEPmAkZzkAX98blB5PP/AoSrwXQiZgLLK2Fd6W/f36q/Z
         foGcUC+cBDcgR+JRxd5xbleWQDoh6V4n8kd0uZTdg6K903jFDQEcGo0gqYw8I1uqwRqQ
         htSQiRkZt/EoRVTjkXJelkVS1/FgFAHgZFaGkPaKKcN809smI69LU3zt9e0HxtCbzDfH
         XBpA==
X-Gm-Message-State: APuU4Z+SEmWX6A/87a56nl9ZV75zdZwcdRULPPRBUHkJwotyxu8fyM1U
	oyiHXhex5nHfU9xUseL5pH6BkQDMSi87UWGTn1WRV809gIYsSWIB3+RU
X-Gm-Gg: AYBFou2pQfSzyU0Q+PhFUId8DUdejyJroLSO/HIBa3x+/SGWaxweWGeQB/mJMT1+gQk
	PpXfzuRDAJuE6giD/Cxsz5H7u0xngCeI6+MN4els+oHUsJxW19H9rfG+mmHW5cX6B3trc9SA36z
	d61KuRNaxcZdaEglD0VHknr7mU0ncBRxBXiHlnuPzbljYkXe44HjOoU98+OwLzImtdvULGdDR3O
	//3igCJFa7GxXv+iUk3qxkabqJsxKPchbShUi5o4TVnRX/Sez8JsvOYgqBAb+uEcvYSGwOqOUoR
	rdld+bWecj5jSnSI6+GP18kWSr6rVdrtVjRRx6RB2AdZmYidzKW6910ekUsR1grxS07vB7TIKBj
	dlKyt487fEPMu41D3NOLrFIOxdfHQJX9OVBbqrNjwK1DFaHvuh41UugpKwQSXRORzi7qbJQ3pHc
	rW1wLDyvP10Og2jeNAfQ7QW33HmRRg3PsRdZxrzQTp1DgT6odfnhV7p/FXpKFqByFOIAkRG4q+Y
	+fy89Lly+ohDf7V6xgdgmdjPN1JLJYGPRFBB+DoFMEQUdLshPgcugCgzZNt76afuFd5r9S09V/m
	3LiHIQkENKG4q047hKPagqKFZrqG7s1Iq1aDfZP+vK3Z+C9huMm+wJ5TTksW/+DVmWUtaST1FQ=
	=
X-Received: by 2002:a17:90b:4a48:b0:3ab:4f1:4f7e with SMTP id 98e67ed59e1d1-3b0db6c9e8dmr3428078a91.28.1793985940387;
        Fri, 06 Nov 2026 09:25:40 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0f3cc9144sm1591204a91.12.2026.11.06.09.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:25:39 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/3] bundle-uri: do not die on unresolvable relative URIs
Date: Fri,  6 Nov 2026 17:25:33 +0000
Message-ID: <20261106172533.612673-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <25a32212-4906-467b-9b1b-301b38ca0e2d@gmail.com>
References: <25a32212-4906-467b-9b1b-301b38ca0e2d@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stolee,

Thanks for the review.

> I'm less convinced on this factor.

Fair point. I tried it with a password in the remote URL but the "failed
to download bundle from URI" warning prints it as is. I think this patch
will only cover this one message. The reason I did it is that git
already hides the password when it shows a remote URL. For eg. in the
"From" line of fetch. It is a separate patch so it is easy to drop if
you and Patrick think it is not worth it.

While checking this I noticed that my commit message for patch 3 is not
accurate. It says that the clone carries on with the other bundles, but
the list is only used up to the bad entry (not at all for a list given
to --bundle-uri) and then the clone fetches from the remote. I can send
a v4 with that fixed if its fine

Aniket
