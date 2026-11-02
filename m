Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610680;
	b=mOzojoim3OADQWRUntHcJ7gYaXpGXMFFS/lIN75+GAxElPAsY6cJ+FqIM/IhAw9pHbfi
	 H7JfbPebtS86Lg7UeA1g1kl9IvnGkz9u3e0KyJGlFQkif23HMYMIQ2QK5XvBX0+WVshSE
	 cQA9VIbATnYG4TCEpU+KENQMwWW+cQ2+MOQcWN48NPlDDNj8OaSwG1PpzCVPQcmSQt+bp
	 ABNOQemnEfY4WEU5cR9ZIVFWJZZzWNrci+1YnVZsbNXF+48fhd+hoJCZY2pUd27UnGxsU
	 cnORRiuTLD8GYY5hQAlw2myd3pu2Nb5nz1LfUeDp/Y2rsiIAmT9Mq1yltVnVXHnWCIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610680;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Mj1jnjcc1L45lvRjMcIvn3NDhR5ER9sZCImVK3Tlk98=;
	b=xZ/eSW+0yTu2ZoZYL5kmU/al2/v7Yux71LQGIGbg4qXmxzCFaCJ9REDIBd10zY/IFEfz
	 e3SZ5MC7+57NM0Mr2FO3xwN6HbYRe1zPUMUlr0W/mEBR63ytSsS/XG80WUj1gj4npK5El
	 Z6gyym0zZvCrpBw6YkDNAyI5lxbiIqrTSvvIikBIAAOwlhsXpvE+2nBvGE/z35AEJg1cn
	 /eGbolLs+138lC1tW1hoF+i1/uoyI0a0wWjjUrhrWBE29jASvQw4t3GmeSgB6xQeAJzhu
	 9kdipUFLSGB7AD6sk2Fdl8DWH66vB8JaLw7P+R+NGpAf/gq9qU1YCL3O1JaDGQgdGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lRAaoaPY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Di2O38j1;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248F606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A248F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=lRAaoaPY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Di2O38j1
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 0ED541D000AE
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:11:19 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 02 Nov 2026 04:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793610678; x=1793697078; bh=Mj1jnjcc1L
	45lvRjMcIvn3NDhR5ER9sZCImVK3Tlk98=; b=lRAaoaPYfAQj77rArV2VZeQU35
	3eOpDA+rbwJ9PewcK1/9QVe6SaAMX10FNEFDh9ygcJkXk6atfgTwSS8OeMEDCVh8
	bElm2Et4iZB2TRyYRh8Nc+KGqcXc8uT1+AF/6a9nM4lL43WoX38v16YcyGUAwgDp
	v+3Ptzj+jQ/3xKY7Xy8Y7ucwZLu9tYPXBB0BdPdZFduWKRUm4mPOyX0zdeV3mSBv
	ubuXVeYSynrOkM2RiJvAVR7+uuzS5xHoIg4xZmsSdHsH7MD+xW9d4O7Ai0OCZ6Rf
	j5T3YmgUgpcM9ks6rIPsHBu/3MVKxELi1kPEgZjhO1TS5HKA6+BrlshedJlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793610678; x=1793697078; bh=Mj1jnjcc1L45lvRjMcIvn3NDhR5ER9sZCIm
	VK3Tlk98=; b=Di2O38j1Y/YW4p5pCTl/PKLYlQhuUf6fDbmX4VTCqRfjRjnnjhw
	S4Q1jRyyfHvPQshxMTX9yWfeOIEPULVVPQt0v3Wvi36WzEZyXsl4vDuLQzEHaMKY
	rB8dAUHhqIlCXE/OZsGFZkvHsM/LkmERiWOt+cjWzU+Ey+lK7PQXlS6DiJBZJA6Z
	KMtKsgk8yCKaaEpGS2ygG0Q6xaR/FPbF5tQRQ0uugW20ZIsoNza+5qDSD+iQKQte
	5DdbBNm46gkIYGXd9k7GBoR0W+J7o/sR21UtNFmp+C4aJTAPscFYb0zRh/JvuN9F
	EnYJCA4/F7xgZmCpob0kayI5pHnN0rlBXZg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793610678; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WKV+ZOrwMJs3W5DNLIK3TsyZoyWXe9Iqb1Q192ReIxqtBHE
	etcT87ah4kt2xU1UZ7Bcl0ZG4vqfPrzceNxV8dgZWq/lforHlhqEoG9HXfIHZ2ML
	kk/nUtaCeyUJUjE3ln62U5kWoehFYNUPv3NDVpLU385n5sGB83kRip7KkpyNcBwB
	z2xi5UzRjSU2DVx9C8/Olm2EikIjgc5d5IWt+fk/OaYBiJzLmMXbYPcBzHvRsSt4
	BC/md/jy0Pc2epXpMGHBnKqNwd90WERh3A7BJkS2QFq9RSYNwGwiTgnHKTfflDBs
	c72uMStcAqfYlJAPaxeba7FhlasRDK8qXbwanmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dFBOwkzRDdsTrIST9iwjt6F0udHS2KZ1ofqrkrlrA0w=:dMwBXAZQK4C5lmdB4q/95AG1hxm0UY/B0NNCihaNmY0=;
X-ME-Sender: <xms:tlPoas3aWfLonXo-i-jxMgQCfoN87PeDtpc7crIeJgnBI00EhQgeMw>
    <xme:tlPoauEXAcmhKsEuPVTS9YvTb4tzQNZ3EATO9N3vH6486cYVByTFyGIXv63cqESoh
    NrYxBwGNJvgHvHRUSle6217Ed4yWWDmzHRUPo1OEY_m21gaxWRnYg>
X-ME-Received: <xmr:tlPoap5eQSCHFseHeMe9Okv_CfqCa861DBewRlD2aejIiGPUs8DjmgHeXfm3COQXunTJSE0jzRHvDQKJTxJDgOPi8GEZN4Bch16c>
X-ME-Proxy-Cause: dmFkZTEvkJ9eZGikSj20msE3hpZqc3bideBu1CefqaP+Mu9lpkRafdHnGLfGSRtABDxY7d
    DgtxAbHK1NHuy+6HXqxx9XMVUBWUly2OPf93RI5LzCkidVbStKgGmVOdpe6hIBdf3uGo9i
    GxvXjR17gERWQYSjsQsXk8ol3syffAHlxRQHdM5wZtxrgc1UPIbHq8fT5jk9S9rSw4qrXD
    +PjAbRVQni31IBq/8nePDl6oPLeqlEUW3Dd00Eeiize7TbdJPkleM3YSM9KvFSJHp3Z9WW
    uBiux8zFtBV3sg1N5wKegddGVIynEuy+NUS6F9qS20nYcUrWCM5wuiinltFbz6CP8JJ9Ko
    ftJwNRx6G8dIQ5YyC9HhE/vpUL2a/uq/MWB3GBaQbDPOkpkFlRZVwD5OyyetECaY+C9MyK
    n/kbxlYgskTaGA/wdokESNx1IOPftqV6lhEwuzLro5X+EsnSrgHwmB1xN4lnuC9Gvuxh8H
    07IBn9gWxaIgWOLy5v9JRa2zhtET1FeTdmH3nuyFLpUjFvx5EiHExIlTj6kbSBcp/WKEPi
    QVYsD2GgI6IMc4dIRq8NRPCWgo3JmRdCvi3vE3Vih+k+IlmXP8OAQ6WYnKMWgsOj3DEG4g
    lnAr+qSyyW0j88SUTUzO0MNUNULJ2S8xkFFJkWKp3V4yF+OBJjZFb9/yvCUA
X-ME-Proxy: <xmx:tlPoaktLn41QY4nBoSAVrqdpur-xY7bNPlpW0kSz5BDFvcESl6OoYw>
    <xmx:tlPoaq6m3YpOEIi4Tf6TjwaOKcBzg_YiGUaYKzvn9EFK-gwt5LIBbw>
    <xmx:tlPoavWZHh8Ib5q94jDoOIi234iT1yJXrIgSArcMy-WQ0erW2N_sGg>
    <xmx:tlPoas--IKpUtNSYwYvldEruoiNAXu6ZBUweb1UpBiuhrbh3HaLFAg>
    <xmx:tlPoala2c9lZtdGNUup3kl7xExcg9JC6pXuxFg9nK5upelq1barRdx0D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:11:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>,  Michael
 Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v3 0/7] line-log: scope stat, check, and -G to -L line
 ranges
In-Reply-To: <pull.2152.v3.git.1788411919.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Thu, 03 Sep 2026 05:05:12
	+0000")
References: <pull.2152.git.1781806593.gitgitgadget@gmail.com>
	<pull.2152.v3.git.1788411919.gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 01:11:17 -0800
Message-ID: <xmqq33tjmwcq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Teach -L to work with the --stat family of options and --check. Also, teach
> -G to search within the line ranges specified by -L. This series continues
> the previous work[1][2] extending -L to work with more diff options, and,
> for example, enables:

This unfortunately has seen almost no interest or reviews since its
first iteration.  Any volunteers?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

Thanks.
