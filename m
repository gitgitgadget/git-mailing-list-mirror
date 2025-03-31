Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426508472
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433191; cv=none; b=qJYsm1/5u1J2bs+As1UckKtGfJ7CeFABDhP8wdQH6o54Q4RkvN+TauY//r3Eocs5WsLjcmftnFpalU3MHj05EHuGHCUurKqyrRamrBT/DyO5U09YuszKFyq8YKIm7bdQ9AoMllZ62pqDLBv+qi9o0V7/KG4SLTkHV893MF23eA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433191; c=relaxed/simple;
	bh=cRcB5spoHRookA4PA6SGdM9qAJjkq4dKeg0BJ+ImUDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GV5ZsSI4MtDjn3ycjep1ghi9tg/eP18Efr/86IZrs6c63v2teJjIqEzarlvq3oA5qgyZ+rmcIqU+bZBBQmFpByzM7RKQYg/AOlpalM5svzMQHVJovCy5l5ALY/+A3qJ+P2lL8XXjd/4cralqzI4Vxf5gFDYh303Rex/sXp7ar24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL4mJpkp; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL4mJpkp"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-477282401b3so46721381cf.1
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743433189; x=1744037989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cRcB5spoHRookA4PA6SGdM9qAJjkq4dKeg0BJ+ImUDE=;
        b=AL4mJpkp0pzLSrXzomyZgB7t4sDBKFvwhAE5b3fag/t0sSkPn6m3IcgDiU2yRGdYmV
         IZV9tgONwAKuz0CERoS8RQ3Cg2wdiHdI9kGCnkLTCc1lhDABHm0EeKjySE45PmP0LhLL
         rAdePV/0TGkZTtMmcO3iVCDr0x3PDSii1MW8YWdsP2oZyBUI5m6ZMDX6/ojUU+CFaXPm
         JxJdOnTXVcRwvzXTYx7/So8WbDt7Wpq8fvU6xbSUvcUYKlKURl0IjUy5BK/qbcGciDZS
         3gJArFFok6bHShpZSoURes1/i/xmqm23vltYj+kqo+8vG6qRtgfjFNo7DIK2Fe+PYfpi
         /m+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433189; x=1744037989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRcB5spoHRookA4PA6SGdM9qAJjkq4dKeg0BJ+ImUDE=;
        b=SmSSd9Ojy17OcLaa8wsC7Disl4QAhicog/gki2DoW1GY8I5uMYJWC8/VFlr+1FW55u
         v2KaNuYM3vBr/aHZii9xQC6HRfUw//H18gSCqt25+P6zAbKJl5fz94AcX7ItESrmmD1K
         GwqqumYG9FrrjI2TLz59Wl6pp4vj6x56OUqkL8bkGPJTGqajrKnRXHsBWLEepUwvfuqB
         RJMhQmgnunuRuVfTRfyg8o+2u5B6b8R1VCBlnIRvRGxyRSz/oDhskQktHUYqBUSD+Hkl
         dG+j/LiucXdRaiuBoo3scSNISJThrRx5Tx5W5LjNFllTnD2/cZOEplIBo4o9aWq2KSin
         I4rQ==
X-Gm-Message-State: AOJu0Yxs8TxBGD1HUbMzIuQkeD6I/XsBsTYeacNbBgaan2VXd0CWZkSP
	r4jBxXsydGYABizfroTvE2/0MTXsYl7rh81u6YZDmY0n5owELzaoaLB5KMIq26uBat3z94Qm18Z
	zKAFcubU0T7Zy6TpyXDy0NB6Q6GqHF3YZ
X-Gm-Gg: ASbGncuEj4hH7G06E15CwCTdKu6VPl8d9K+96OrUEqtp/y4rrKC6KfNhOlv+c+GRrIe
	AjZCY7hm6YhPHmXF6jSVIncNmqI+FlvI723wHreSCnd9kmbiOxa8DZ3KPILQvzBLKaOmbkjYCLM
	UPU3wvRUENnoj2eVXjZfcocwqBEgNCCMZtBj0a7UAsHoajROI+AIBkc+vE7XA=
X-Google-Smtp-Source: AGHT+IEtETtiNEfpFuus0HZQu1Y//DxJni6q/2o0et5T2aYsHH+IJKSpp0uEoHiCRNkvefsNLDV/BlnLozIWEZfnh9o=
X-Received: by 2002:ac8:59d6:0:b0:476:8612:f01d with SMTP id
 d75a77b69052e-477f7b31d3dmr112437471cf.48.1743433189026; Mon, 31 Mar 2025
 07:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
In-Reply-To: <CA+rGoLfxZHdns=7FwQuYS=JANrR9zDP-dOpV2AxM1hC1Lc9wiw@mail.gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Mon, 31 Mar 2025 20:29:37 +0530
X-Gm-Features: AQ5f1JqR9CWx035NpgPAdC67rARUgyXQDjPM6n56_d0nZvnbeyjoH41W79nS1tQ
Message-ID: <CA+rGoLff+i8oxm5yfzxWbRe99M3CvBOw7BgaxWEZrib0rnL-AQ@mail.gmail.com>
Subject: Re: [GSOC] [Proposal v1] Machine-Readable Repository Information
 Query Tool
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, karthik nayak <karthik.188@gmail.com>, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Here is a doc version of the above proposal [1]
Looking forward to any feedback!!

1- https://docs.google.com/document/d/1q06OHRo0fQluoZuSN5j_wgezT74JgMWYOk8O21ixyUY/edit?usp=sharing

Thank you,
Jay
