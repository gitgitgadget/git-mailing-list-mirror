Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526401;
	b=cZgzq9purKHDa5Snm6VcRN1RkOsSS5HWui/4MfdoSSkaq69VhtOwY/KCekl0txvQSHRo
	 DupQhp+tsTagZEkRqi/PKp61M2XjJG8R4Ik3RyaDSr7a6m81R6VILKmgSc6z1okCQIFb0
	 ts/sMQA295ksvVN0Fkk7U1BhE1b4RG0/zeWY/1imy9O6lGQI8mUxQQehlt8IemmrWLr89
	 srRMqvNVwYJhl+4MEIKqyO5ibgVocBa6RFB9Clamp6xJn/1rK4eows7UA6VpEeC7DoVHW
	 PzRzdr6ti+q34s2aVps8omXvM3KsfWizi2l4xfJOPOpx/lgHupo146xr/UDPLlZCXkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526401;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=9ax6lCiUJMwB3WfDBQvVnMDpFaf7QMxKURnad5BaoUE=;
	b=UkRkVs7TCT0vP6yGlblj+s57tFuy2y+7p7Hs2BH5S3ctWhTj4vRqZs9kaQkizQ9T2i6C
	 r9txFdTdQM8myJozoG/QI3cV8dhh6R3Sjb6oR+Azq9aPfmVJZmjbkUUX/X89baj1sze7m
	 SfnJybvA1wq4EbJ+Rjv3DcPLT5dzMuSQhW7BCHfM5W/FhckuLXNnLCpRREybKbveKmndR
	 Jl+Zp7l5JOtNwOinEbyrye3TEbJjvumExEunD593ZClvxgFazS56DIdM0PTfklN+vj8hf
	 vxv0TyrC9cVwL+c3O/2QlFerPzuW31D0oV6Ij1Vyi1SQSw0Bp6J/GAbcB2ZV/jKvDxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aPkuo3OP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aehbu1S6;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFA606A31F
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAFA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=aPkuo3OP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=aehbu1S6
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 215D1EC01D3
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:00:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 20 Oct 2026 16:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792526400; x=1792612800; bh=9ax6lCiUJM
	wB3WfDBQvVnMDpFaf7QMxKURnad5BaoUE=; b=aPkuo3OPDUL+wkUZ4HOjjCTKEc
	v1YRyE1e/GR/u6eKZhIOm97tgkFyXEblnkyWCbj8nbzDDVPyykq+hxwNEW0/w8gj
	89szYBUJo02MLNGwLLwJdVFsY18WBCtThwNVyXp51pdDh6LXhwJBI30DVir23KEN
	iN14vbbPg/ZLYiTFTubLyQvW4+eQ71qLwUiPZyUe/0vT+/EPlOTa7aENjudDnG/1
	G6YrYjPDdbgIojbXmOr72/PRvn/YAqFdEQl5STptRrOkL+OkNNtWSpp9g9gRIEfv
	BKzKiqj1Bo76o0sm5z/qtHN3B3p2/foklBkBbp0pYMt8r7aRXpt7VxDNDd8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792526400; x=1792612800; bh=9ax6lCiUJMwB3WfDBQvVnMDpFaf7QMxKURn
	ad5BaoUE=; b=aehbu1S6Y0IaFMa6893NVDActFrmnmSk9qszcQGa8jnmoBdntTl
	YwytHEyp9yBQNwCFSbuujz63I7PdVWDCoCqjkJyfoFdU0//D/se++CIaYD6XyWE4
	3YII/zPPEFefeOyNiFQm7CH6ytb5rwkQT1xDg5jWv6mPqdkXWdVgNuNL5q+waYFa
	gKRNnc13lYtrKG0S6hi5Xb5YFMtM63rmBfGjDDu+fn1Lelqd9gfkaEYIWfLn6R5S
	b9OWH4XMVF2YGaT8cke1AQUGd3Fm7acTnzJv5jkOWmLrhNRVKlFcqzSEUbTVNcSJ
	A+3KEtblWgX0PFNb6d+jld11YknGU+gSGsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792526400; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:W5blMEMBeZyPeLppwk5teMydXVraUFkFJeuErnZN4CZf0bp
	Ow6f6RjclRCSLvR+qEI7VqvshJuWKNL329yot3QA8mS1Y2iIRzEb23f1V91b3nnA
	uR8uiVItWfq2oX1OoyoqTOPzPA1ymoHd6KS6IpIOl+ZSZBtlP98vrn5kNN4FwhDc
	j08lble1FV+mshMkg7JSvOJ/qSc6kZDwKhNxTH/c21vXbk8uW1ajXR1AlkeY6MGf
	mnxl9m+V9iKtiO6FIeTE9YmS5BNFXc+y9Jvj4eWAvUmvDihGV/aXdLh0ZexEcF6a
	kieJsCGLwnFSEyLIUoMfdc14sqQmuhC5Q6f4nHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:w1jL8w97vR1YCoEHspPbQP7djR+R4nYBPkB21KnqIsA=:gccD6WNgKenQ56fmA+oKO7/YbIKH7ovxIwXiEkH0IIw=;
X-ME-Sender: <xms:P8jXaj--8FKZegowGA-b6kM9-apUxg3Ly767apBYBjNq-SMwqMsv-Q>
    <xme:P8jXanKSU1HpuZyYfR7vrqnDOXeKd2lI-feI-ThoJ8TJ91oMluQrncZXr2lWXHTHE
    V6GuM-zlNrfMauOJll4F1ZYDVWqSeBaBq-q2iVaNhSng8JDjemqWbw>
X-ME-Received: <xmr:P8jXaubOvcdq9wrKfyT6JTTywSa_EynT-VqyngM1Cdwc58a5nPqGQvD3hpAFqvdGFg2Gi8OW65uV3Ea0Vy_mILquVtZqMAbDQQTb>
X-ME-Proxy-Cause: dmFkZTFthKzzuKqB8ktRcIFxuGmGXK2VF0Udv2V+uRyKtj1DML8Pt9rpS+xjNNivXqr6j5
    UneIKT9p6Vu8xOOlJZB917hazIGK0DWKrztzZcOjTcOqBBqouHjH0zr4uVmcc8xaEFcUCf
    gYHvjvuRcTSfcD4J+QoR4YRFNLWPdjJ/31fXBXC6NiL6BRkXe8LK4+vBloLzh1GSgx32Gl
    pUzGUut0n33LFAQEzgHfo5y2s9PG1eMC/q1smU5N8QPsoQsUGJDnH5gTsoFaPTR/dcdTON
    lduvceHXkRxb1v33si1MVAL8bEUx8GMwheNTpDsGCribQqUTsUzNm1TQTZi9C1EScQ3wUF
    gZgqRUIPY0RcL5GAtSVf9wYsnTSJ5Qiw6H3namIsI8ePYzRV8Y0azff/iYOTrp2wieG57O
    xXJnFT9tz4lroi11KWSrG8pahSK0nedVLe/U0y+ehfdSuOI2iKDQgh+rt96OykYAvTvYph
    pfeKpQX3junX5+wj0i2WQr+919bZNNjheqa8UPEpVFxkzsdMgZodQRnCfAGh+hnIG5kNxz
    5FDYC/pKHafGJhmWxF93cjPAWDj8Ueh7R6Mna+cNd5GYmecsq5zdqn0BDay+Ck1e043yMY
    J+Uv7PgweGo2hpf+syebIc9KmO2UVoT3z2BkmPpMrOpK5IXaCaCHsjkZkkVg
X-ME-Proxy: <xmx:P8jXapI_hqwRZdiJ0AxYdvwmri5avMeZJhH5kKzbp39Taguklcuufw>
    <xmx:P8jXasC4P7MK740DTGM1Qs0SA3HA4A6yelhGUw7SlVaZozP4BcWepw>
    <xmx:P8jXauqqr23lC1cXbS3iWJB9DGBdWJKwYhEXtFE5etHoCoM2WQ0xUA>
    <xmx:P8jXangL5XBUYM3744IHQcvUjVPjNz2KIfoPwjBxM0su7ru3H1Vojw>
    <xmx:QMjXanQhU65UeAc6SXVUuL1-rTQi0JM90ey1zft4XmM9_ndZh4DQ5ZIV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 15:59:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] odb/source-files: only reload alternates when the
 file has changed
In-Reply-To: <20261020-pks-odb-files-reload-alternates-v1-4-d9e156323836@pks.im>
	(Patrick Steinhardt's message of "Tue, 20 Oct 2026 10:54:55 +0200")
References: <20261020-pks-odb-files-reload-alternates-v1-0-d9e156323836@pks.im>
	<20261020-pks-odb-files-reload-alternates-v1-4-d9e156323836@pks.im>
Date: Tue, 20 Oct 2026 12:59:58 -0700
Message-ID: <xmqq33u0uoqp.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> +	if (!validity || !stat_validity_check(validity, path)) {
> +		int fd = open(path, O_RDONLY);
> +		if (fd < 0) {
> +			warn_on_fopen_errors(path);
> +			if (validity)
> +				stat_validity_clear(validity);
> +		} else {
> +			if (validity)
> +				stat_validity_update(validity, fd);
> +			if (strbuf_read(&buf, fd, 1024) < 0)
> +				warning_errno(_("unable to read alternates file '%s'"),
> +					      path);
> +			else
> +				parse_alternates(buf.buf, '\n', object_dir, out);
> +			close(fd);

When we update validity and then fail to strbuf_read(), say due to a
transient I/O error or something that was caused by somebody else
mucking with our alternates list at the same time, we warn, but do
not roll back the validity update even though we failed to parse.  I
wonder if it is safer to run the validity update only after
successfully read the alternates file, and if the extra safety is
worth it?

