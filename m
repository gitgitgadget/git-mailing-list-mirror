Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039873;
	b=uH5KA0I29PhgVYVwzZ5sK2jNC5nxOC+MhTJejgsb0T+BsOzttOjFSJNVTGZ92cBFgfjT
	 lkfZOetjB/nLtbKoEhmAXeJ2ijaRAulVHpZVN6g541UrnbqCyUUjUIqeq1ms6HlqO3DyO
	 ZQp5uJYQ/nPcYRTwzaEJnBdM7GdajUrqVrqlRW/HlPWnKVt+XabbLUHhLr7W7YewYqskQ
	 dgA16kN8Ri4xjHo7oct8sBkMilZRkEa6jvTOMj913ssVWUjzl5+wKxk3EWGO9JOEaq/UB
	 C9boCpTukSGPdkYidXKnEnJ5ed9WEEqeQ6BUGc8PazrAEmUxnkBrgyaTKHpZ6KjTnrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039873;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=Hf6K0YhbVyQLsDewcAoh7hRcUxEzl0/zzPOewxxk/SA=;
	b=tGZWSblrsH0vAsIv6aSd5zSYdUnmU5kJzefTGYVCBy+iGH27OYNEEuDVoTt8DoIly+jj
	 14RZg9emPc8dqFpDVaiPnw7JunquMsK4sRzpjXmzQMe9xC+9TeLgy8ratyo20d3iZcjCY
	 MznYqwh9jVayAOcTgzmeBcnMSgJYhJm9JT6hF7gv+dmCkgaUVAREEgB0XrfIVAvdlQs0Y
	 sf7hpwj1nyZrnQ9X4TINNy7mCzvPytXOK8tW2hjilLW2mWL7vGNK6ZQ3lVKatThrlsMXB
	 xoyiyW83Vt5J7WNSEcN4ZNjLMEZTCpO4ttbAfILmL9parXYEMtc6KlxQw8XjAEZ8k8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WcZtjxir;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kdedVKiu;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8FC606A32F
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 22:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF8FC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WcZtjxir;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kdedVKiu
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9CE81400174
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 17:11:11 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 17:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795039871; x=1795126271; bh=Hf6K0YhbVy
	QLsDewcAoh7hRcUxEzl0/zzPOewxxk/SA=; b=WcZtjxirakLIwva1Sh9NInf9N6
	p9DqB8gjaOkb/FnfZ6xgAl67GEH35hlsL2tOfZcQDNapSz3aNRmXup+SoaBEZFul
	KC4sLgOZSPZouiAvPRFgHxARiDb8NQtA06Py3TNhNnRh9+FMbWt7WMtqhaSzGCJM
	54dVtCtrGH1hXLm9vgSML/IA88ae4rwDJ5NYFyjAjsaUkch0IFwRR7dB4W9yz4bt
	cFyCaNdJYoDn6+BVLHLwzm/LEvdlAhNj1G6KfEIC5biuKqawFIIMlbHrlFQCxlbI
	UKr0VcwR3mD7r6RRQt/4F0XnlmRivXWt2lSZahvcp9urinSQSn7qlQ2V90kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795039871; x=1795126271; bh=Hf6K0YhbVyQLsDewcAoh7hRcUxEzl0/zzPO
	ewxxk/SA=; b=kdedVKiubuhe33f4uEOLMkKApyInK0ZEb2yb+FcxTwMVNF9bVSN
	qMC85PtfSSNbDA6wGdOI8nH0kK/Z3dD6sjja30stqIC0Vsd+/2Lbm2FMs34eBzW2
	xKB6CUeeMLtzoL6IeW959gHUUGWu2IKyBfzz/qhbuFqj+iOqHvVGe3gpp+JIFaol
	Wh6xphHuqnLiNF4gC91DCt0NjJ1rahAmSzHigOtZ6tDRBlM3QTVSwYKFheF9oi0O
	uof3zaoVTzNxfI5ZcpwB6JYqzPvNnL9RphI8NjGTbXjosxpF0IyaLpSrPp3Dp7KG
	Pn2+Fdf9FeukkQ26BXLLdZJt3bdlTIkhKTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795039871; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Nrt8aPTju4m0mlf309qDg37muGQsikuVa0CPPNA9K95dsDV
	X0jxA+QvhxfKBwqX/oxKn5zABMwRflv2RVlKqIUXWaj7wQ3hb/XkzQMRffDP0Xli
	ML4MNd8GaQoLkoFRJBESRl7RGnZM7m+0rXdVhakjVMJJtkWf7qcQov8rWuJYsdRr
	ceq1rWhgoydAPhFZGyuoHUZENih49EddHh9brPe130HOdlzjb9PFbIXUHuz+nCEQ
	X1ckTEJzAFA4nSobyztGaNQeAI++hTSEY3TfbflqMwseSxBYT24OJhdsz4yNXdxN
	RR1qtjeHm/Pw7DhguVbk/MTpiy28Tr02JgrCVCA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5tDQjwY8HQWZby5GiYFioWudH6LrqOAAwdI2M4N/ifA=:RpqRtu5kjKbTnKbGio4FG2XOhYo6XfHTDmVy9hj15z0=;
X-ME-Sender: <xms:fyL-akjp-S4tk-NzHmHhBYWqufC7eq-TmCvKj5p8EDw_eQIURe0Wmg>
    <xme:fyL-aj7qiyFXdqx9X_ksCCLNMVZWI3eJr1y3n9QP0FiJTlgqORpmStokOtW02Kd3r
    x8j0hMaSyEtejtgYEMKulOW6_vHyCCoPIDiHds6r-4P-au0ergV8w>
X-ME-Received: <xmr:fyL-akYDQVXSx4-NtLL8mG8fzD9YfKDJZk5J_NNlRJ6HwCZemIfHKID-qiJeNDlzIKzAnZ_aWBiHO5k3jG2WLMdpEvH9FCDJNdKA>
X-ME-Proxy-Cause: dmFkZTEEgFg8EZ0w8IkoA3hPw/HvsJjN1j7NMQ1ZRYFSmWwIHH8WpdribnTp9xvWMOON9n
    nswwgitPU2gQsOdCKQO+stZbeF2U7uX8OGD6Jdsnti/vMJJ+7Od5SER/CKk7LWzgVzofB7
    erIb2ARLSuvmVk2hJJwOK6LpmEu1oj8wqE4myFzPqjpgCO+O1VbOhhT9mt4nGp2S9cJgKG
    HpdeenN359yP1cXsyn4zoUrLapTeJORtCT5z1ZXifTils9SL5v+aO1HlISM5rMAQe+u46B
    D/33dkRikAqHu0WJ+Wqmua8cXLJJpk/9wvDISHC3BOaZpJsHwzi12DBwF6b49wf7pLCtT6
    YWw5yg2Gk9cRQu62TA83hpj2BJHZ2xCrxHKiio+CGEFnryfHcwj03ywgyn9VeKwZ9fduv0
    X4xuggXJOv9oJ1z0YX1y3A+r2uN/Mc4WdhoXT8reM+NM9Vpmy645xAJus71lidaTPyxF39
    Co4JtEwJ+uJYg+gIzVE/gOQJ5SwnncRLiIYdIq9g7F4jC3rDjskbvvcd2m2edL8//j6cQk
    8lB9kVzJLiWht9Yfctkeu/UdXBoDu0q2azxBtDgzoL5Z8c4I4UXpeJyKBQqTluPFLMHDii
    5iXRAKrCftpFk2KhB0ZK71/RYUv0oSkfQgzjpXD4kWZhpogBYUbgy1RsQ4Rw
X-ME-Proxy: <xmx:fyL-ag5zyPMJsDiLiXifynJTLXKfYISZBaQHnVUbhzxqFN325-T93g>
    <xmx:fyL-avBNtU1HstMSpoQPLj7P4IKGLyHS3by8wCNXneGKcw6xMIi7lA>
    <xmx:fyL-aucodPcsVcRfwD3E-A04xkqxDvmlYyc5E10I7OCRAmrhqiabUA>
    <xmx:fyL-amI8YhZqqu4ehhOAsUZJ4qt79xYe8oP3CZ39aXeMFV0KypYFag>
    <xmx:fyL-asLyAVutg2kYgOfAufmv1WFctpkHQhZ2qY5q0TEAlhmoMlFnC6Uo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 17:11:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  ps@pks.im
Subject: Re: [PATCH v8 1/1] repo: add filtering options to "repo structure"
In-Reply-To: <20261118203519.2379494-2-markchucarroll@fastmail.com> (Mark
	C. Chu-Carroll's message of "Wed, 18 Nov 2026 15:35:19 -0500")
References: <20261015144559.3652143-3-markchucarroll@fastmail.com>
	<20261118203519.2379494-1-markchucarroll@fastmail.com>
	<20261118203519.2379494-2-markchucarroll@fastmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 18 Nov 2026 14:11:10 -0800
Message-ID: <xmqq7bi93i4h.fsf@gitster.g>
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

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> +		objects.commits.disk_size=163722
> +		objects.trees.disk_size=284547
> +		objects.blobs.disk_size=21022
> +		objects.tags.disk_size=126

This may not be a new problem, but hardcoding .disk_size would make
these tests unnecessarily brittle when you consider there are
different zlib implementations.
