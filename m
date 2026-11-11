Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410879;
	b=g863j62v+cXVSUHn0sXhHypK41v5YQj00MLwgSSiG0VCRHjtS8lx65uditoUr0ET5niJ
	 G22XPoWRgatPDVxLoWSy5jgSClUtsE4ZPpi/N953fX0zkt7nOQJeuafylaavc/TYEqIys
	 uctT0fD0mqonG2eBxgygEK2lDvJYRRmklf+teXQXFAvfwoqHC5tZ2gSdycwziYSbMk9NW
	 FmZq9vZ3yGFtPtOF/+wJzLWNZdUEs1/3Sq1wDtBMd1epDuNq1oeia4SYxPFnQDlTPrwQw
	 guBt5vh339u4NpO/BVm1dC4KYrqTTO/ks9J+Yj/8PYyV61MfNFqX+C6phl19ruhRxpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JLnk3MgvpLwOzIoexu2Do9CG835VWt1LPA/Bmj0kGZM=;
	b=hM9YIOYq+i9W0VCkIGQn53xQdZuvqsEMyFYUdqghKFfoleUMl0CE5AWm0Ui+gjexzZnv
	 dHLOTkyOpNk/bLKgkgc6DB7VCFQImuOt2K2NAUBxHcHHfO6v9RPWRG43ecVgAkTHykmGV
	 8BFsjMssqlApuHoRHzllLXWpKpSA7Q/5cAngZu8jcBzpXZf/XVBtBOUzobgKjTvYM4j0t
	 RI8qMOd0RA+bNkENzDmWZv8iTkk9bM4zx1atkOjtJH3BB1qW3VsF6Uk3eT7imMGAcEZys
	 MoLuQwHg9K39HuYzBoJeDN4DgEEiRPLCS5ib/hVhjFYsqFDz4LeTJP7IRqZLNlc/yaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=QuMgMVPk;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC74606A321
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 15:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BC74606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=QuMgMVPk
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f079a63b8so327011585a.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 07:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1794410878; x=1795015678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLnk3MgvpLwOzIoexu2Do9CG835VWt1LPA/Bmj0kGZM=;
        b=QuMgMVPk/lWMGuX5808OqUikRzah6mbLTfEjd7ByquDc3AAphhvWZXtYIj2oa8E4pe
         BgywXBkPm9O+spDnhSbF+zcyRvfhxTuKG1Lxp1FvPYrkYnJgnuDe8ZjKcEEdKrav6RFN
         wBZTVqi5MNNSW/vYN4swZsiOeVrwhL2whuCUd1Ue/f7+ENLVfDd+LcTn2R1hdlPYpewW
         +kfOKMCF+/B6edL7hnUBmpocCO4SyrB4C/D6Yl+D6VahyhKKIUP2mutRsQBIW326O8Wc
         J+6M86b3BExzwX1E1WVWo1Q0XpOfqvG87b7pRqTLZ0/Nz0mztzVTNpi+yfCMbMfUgilr
         9oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794410878; x=1795015678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLnk3MgvpLwOzIoexu2Do9CG835VWt1LPA/Bmj0kGZM=;
        b=M/Fkzpeg87WalzUiTIlw8y07SM44R5fn2KhvVBCXIIl/qpT8//2tuaEEQ+T5RdkXmK
         VouO/420KzGXHT7V+9T3NYp6L4vhv8LBG14i+F1dANETW9J6MWBCDL4odGx310JvV2yh
         93QZM9oufhUYUt8Mf50ez8Bw4OLf7k+2v4J9NaqmZt1nT6rquAu9it38cKiGCZgitFqh
         SOfVzZ2HnPoBIXJ756+PocRD9GVmDLE+BQVBYF5BbBACy8vqiOkYFNGgY1sDuSWqqs8c
         JKaqHxUvdbcSNLexV8AbvCu084De6Q5hLjlN4VLgHaLQn5bm4osyltUCR/0i4trStidj
         g2Yg==
X-Forwarded-Encrypted: i=1; AL+hErHM8rP5hEkYNN8An0YBE2HwAAItqOy3X7SOuEsL7WulTnbOs53S67Vjb4F6KAu5dLQqt18=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2sskGrVJtc1wSy3qvf3vSIYIPVZjdaQgX6JAgKKB+a2NYTOjk
	vRox04ESlNlNTzwnsLLDpMWcUwpwzPSGYVAmwJG7CdhaKHiC6HORfMad0BkuUG9NU5gDcHgY4Ex
	PaIY5LPH4I14qek0V536UvkJxT9DkHxn/Kl0ANRfW6DML0D4ue3aVNnXu6rPgpOlcyy80S0w+mH
	8H15ILfM1Aly6ln+GlLFHRuEn2mKzaclU=
X-Gm-Gg: AYBFou3PuMz9yQAQLqzCm5M44te7+Doiqo9ZdklwaBErhdWNV0uZPp19jLVSvuZIbTW
	zgGEYNv2yZ7KqhXRqOx72lyJXj4nXTGmP5UB73RBEXzizkf3mgIPKc4D/GAmkMjsH0+K+EqV9kM
	QiDuZTBkujmMYf9F/5mNGGWGPnKQJ7Raohr2OQILezEzBZRaQoG23jxCBoQd592n286lsoYvUIH
	HUFKc+9SYisjc4j0K2T9L3W8Bpi+v3i3r7rm6p/qly4q+J77NtipFOQCydk6c6t9rR8EpWm6DJf
	nZaa2xSPxocGshNnysCgCpbhSAV4Mwsz02PdpFYdgG8TcQvuy7nzuA24LQeABxk894kmlo9sjGf
	SDlIGWZbf/oOBzA+k9jjU7Ab/3Pf/UZIhnvzFCSoi4nZwUF5o+kBlwJSL6SSBn5M75D9nykreS9
	Xq1EZSwb4egWrVTuLtwDZGW+qz5yJHucm6jw3n6vZ4r6pInycE3gJQQ84yK2cl4Hv6g96bZsD7H
	aXOxtCuhwShHAUn4iBjPCs/15VOVmd+wKRKzOA6pye0WM/up8Gzx20U2Ns6izv3AHSoicS//bpz
	Douvs4Vi8W9SpgslEjQKw+K5fU5MTgueZRTPIRrK6PsN6xD5xwELFNJrDZR38fcCXMqDiGSwVWE
	P3qWU+gBAqCjpmjNbuii1JMSOpBzxjWalx97YPlIefLKLgE7932bIapVCwBlr0Ys1Qtx7wdfcHu
	aCZaEpe090rFgUWhHmdWD725HoJm69F78QbgLv7ldOYEgmRmsz7DlFOFFyhnH6XmADj5ty7ggPP
	w9fBfPu4tQUOXJ0fF+bIXq6VecJqp3ZRj/Uy/y4G7QHqGIYp0eHkQ==
X-Received: by 2002:a05:620a:390a:b0:912:1206:ddd1 with SMTP id af79cd13be357-947afb909f4mr462296685a.1.1794410878032;
        Wed, 11 Nov 2026 07:27:58 -0800 (PST)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.88.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e7a8348sm504781885a.26.2026.11.11.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 07:27:57 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: haraldnordgren@gmail.com,
	git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood123@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v6 4/4] branch: let --delete-integrated find branches merged onto changed files
Date: Wed, 11 Nov 2026 10:27:53 -0500
Message-ID: <20261111152753.99845-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAHwyqnXuN6vjBD4_A7FsSHTvra_k7XCpZPdm=DSdH+r+mNgekA@mail.gmail.com>
References: <CAHwyqnXuN6vjBD4_A7FsSHTvra_k7XCpZPdm=DSdH+r+mNgekA@mail.gmail.com>
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

Hi Harald

On Sat, Nov 1, 2026 Harald Nordgren via GitGitGadget wrote:
> +static int merge_keeps_upstream(const struct branch_change *change)
> +{
> +	mmfile_t base, upstream, branch;
> +	mmfile_t result = { 0 };
> +	int ret;
> +
> +	repo_read_index(the_repository);

This runs once for each changed file at each candidate commit. After
the first call, read_index_from() returns early, but repo_read_index()
still calls clear_skip_worktree_from_present_files() every time. In a
sparse checkout, that walks the index and can lstat() the
skip-worktree paths again for each merge. Could the index be read once,
before the walk in find_landed_commits()?

This also answers only half of Junio's question on v5. The attributes
now come from the index of the current worktree, not from the upstream
commit. A merge driver that is set only upstream is ignored, and in a
bare repository the index is empty, so no attributes apply. That can
be the right choice, but I think the commit message should say so.

> +test_expect_success '--delete-integrated deletes a squash merged branch after upstream changed the same file' '

All the tests for the new code path expect a deletion. I added these
cases locally on top of v6, and all of them keep the branch, as
expected:

 - upstream changed other lines of the file, but the branch was never
   merged
 - upstream has only one of the two hunks of the branch
 - upstream changed the same line in a different way, so the merge
   conflicts

A test where the merge does not leave upstream unchanged would protect
the behaviour that matters most here, which is to keep work that did
not land. I am happy to send the tests if they help.

With those points, the patch looks good to me.

Thanks
Jasper
