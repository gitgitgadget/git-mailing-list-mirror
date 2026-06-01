Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66C344DBD
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355352; cv=none; b=eYUgc3rT3gaC6Y7s3CC43GGYBGTbb/0KTJ6VDWXoMbA0oXqBM1188OVUSqx9krreFhCdD+GPeR8CEiQxNLoYc6Df4UNxgGeK7bCfpbGeEM/2E8GD0cVW3qtoEYnt7aTrQxIcm5r2Jree4YEy/fa3savRzYMHRp4RpjzypgePISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355352; c=relaxed/simple;
	bh=TWLWqiFSkxns2NjpIYsnC2ZDJcXN5++VyAZRwIsGrKs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Du7TVGO84E2iKQxpUwAN79Qv+0MJm4M4e2FQr+AbKVOgO8Thoz/cDDwc3xjD9UXkTXP241x3+ovaCwoGkZ4jYnHnPLLi2GWwLgD+NmfpXRdM0RGqwoj/OU1Zp3pHb1ZX2ZT+174FM1VQth+xtTZ+16FTj8yGumXoMSV6IDF86HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mke4q9w8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBbQw8K9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mke4q9w8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBbQw8K9"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 627877A010E;
	Mon,  1 Jun 2026 19:09:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 19:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780355350; x=1780441750; bh=D1h/pxzmW8
	WLv19ixbmRZ/43CpPtRYyryhLxCPEFz/E=; b=Mke4q9w8iK8BgRK6DuL6knY7fp
	Xzmu7QPAQM3nxFt/mY0NYaSYsZEUGuaL4hhELu2R1V0ujcnXznN0vL/9YMJI2fyu
	epQ6BfMQzy89c63DF5Ic4C/z4TEpsBtFCegFgO3oAijEBgxRoSFyaHcuF4/zTfM3
	rX/JD2uKG+nT0cP2diEP2i9P20/jVClW8evWzBB0J2CM9rEIoGM2gYAWjQZzJUF1
	jPxfK4gO1xtIEyc2m9gvkuKLUAqmzdPQ+7zEnBAlhWQfPjqC5Kvm7lb3U17PD1wT
	u7kyPFCSW+OrCL/gTcEQrmYWmoLDHJ9kA/nb2honKpK0WZ+eH/DiOVDMfhJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780355350; x=1780441750; bh=D1h/pxzmW8WLv19ixbmRZ/43CpPtRYyryhL
	xCPEFz/E=; b=IBbQw8K97Oe28OtKAK/TbOtyPNe3YzrPZEdwxBtV+Ibm79C1bzJ
	GgciIt1WvHYwhGAK88FG5uhDJO9CxIFo6rdXRx5UASfAb82F41qZRjATB86lWyEi
	nGHvyW1caO2K+R+BTQYaTbuDeAOZKY4m9acPVdnJkhJvB3edYEv1EGkUoM5Q4JMu
	g9I8XcX72FLIE8P6+seQitc5eS9DgihYxc1HgIh0fHeoGlKOWaWhzHhu6Tv7HLct
	hPTlkgLTdkgIddJfcAUVzyAebmQVjc4r26d1jajlnIqs9I9biZVkqb8V4TZVoxj9
	hdOc/zisINNNDKaCv69qjIi58XT5r6gRAQg==
X-ME-Sender: <xms:FhEeaqy_SHcGOH39rUr5_IuOzvRI9ZmFzkPk-kR0VZe4AA-Y9htHDg>
    <xme:FhEearPZSg5g4LVp7tOFQEWDYRPGD1K_5Oi1RmqzfmRkXGq_1Xu7XducykvTY4nAY
    ExonJPL4UGwHIZnvnWEjTfx7bUyXdPjcewi0inhkwhJcL_b8Rc>
X-ME-Received: <xmr:FhEeagmz-cEoDsEvaHBg9vswuuRpd-pm1JwGCyXanJWCbOVt_ELhhD75YLprrbkI_nwCKABeLIEsxplQqRdjjy-O5ik2nY4eIwm3>
X-ME-Proxy-Cause: dmFkZTFb4udCn6Di/TSJpx/oXGQlkRglXk6JblGeNhwVLa3a1CPL+VCdVDMSIRWfjRgKu8
    r0s7xY7pU7/qdwVxAcRc/ZstLgP59fMgTT/ypfygp1Abm49V9HZ+rj7P9gt04B4RbAq//a
    WeJxjS87eCP+Bq4lsN/yhVSjr5/njiBejHs5lhk+/ajujYPS7ZAn7ooUUAaSaO5QXrl/+8
    HCPDi2b0Pe+a75pV7d6vWJfBo8LNEmXtpERbT/cjqnIVD7JtA9QWP/WlL6N6hG+uW7HzC+
    JCR1iWzGnvV1RNiZl+uHuLtIhll0PoJjg5XSSHiG6RoDNhrp/gW3QQa8BbNnz6n4rnmMEP
    BMJJ2TaIiUGavn+eT0SRgzaWQTru8D+NeBcry8Ok1Zyn3Fsg4BStHIyg9fc+nUfuquTBCn
    O0R1Q9ow4M7rP54v8f1J/68mZ+08cu9OuPRmdJ6JjPOzyE+fT06tfIthpuzBb3/71uSzU7
    cvNX9Csr69cU55hIoR+RkzWosNswUKsh3xcgdEUggwzzG9Hsj7IeiOM1E6Bv1ZYkrxZ+iP
    BsOgGQ/afSEfBeOfkhDrTidyo4/NghBzhNjAEhMjCT8c82DfpDQFfALSH7oxS/X9rJPsC4
    NwEG3D9dzQC48D2cCJ6CrzeQt9USJUBX6aSJi25l9Kr6FHOIRU0YEYM8GNkg
X-ME-Proxy: <xmx:FhEeagQHGdrEoQTTcecW0ArCyIfeVCm-kdx4WocUM6gJo35aGNrDqA>
    <xmx:FhEeavWQrBH4jWF3Jn4i4SJyMzAGIQnSAqIijjJw3ol90i_G0Gkz_w>
    <xmx:FhEeakK9XSCQZZs_fH-ihKU7lRYG8Lyu5g0a7ChZash4c4e0cdmlhw>
    <xmx:FhEeav0ZcSikiTcodTp4ef6cUwQ6sEbTv4NIui6mHQU4v-dIEWxpSA>
    <xmx:FhEeagvPV7-H-VOTPWl4LQdXCaZa6IxpwCeAo2z8rh82AwkxTdy7rNxL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:09:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>,  git@vger.kernel.org,
  jltobler@gmail.com,  phillip.wood@dunelm.org.uk,
  sandals@crustytoothpaste.net,  kumarayushjha123@gmail.com,
  a3205153416@gmail.com
Subject: Re: [GSoC][PATCH 3/4] repo: add path.gitdir with absolute and
 relative suffix formatting
In-Reply-To: <FE164E62-C086-4902-B21F-157CD2C4ED0E@gmail.com> (Lucas Seiki
	Oshiro's message of "Mon, 1 Jun 2026 13:28:57 -0300")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	<20260601151950.30686-4-jayatheerthkulkarni2005@gmail.com>
	<FE164E62-C086-4902-B21F-157CD2C4ED0E@gmail.com>
Date: Tue, 02 Jun 2026 08:09:08 +0900
Message-ID: <xmqqo6ht26zv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> +test_repo_info_path () {
>> + field_name=$1
>> + expect_relative=$2
>> +
>> + test_expect_success "query individual key: path.$field_name.absolute" '
>> + (
>> + cd test-repo/sub &&
>> + expect_absolute=$(cd .. && pwd)/.git &&
>
> Note that this semi-hardcoded path won't work for other values (e.g.
> top level dir, superproject working tree). This needs to be a parameter
> just like `expect_relative`

Good thinking.  Thanks for carefully reading.
