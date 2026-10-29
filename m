Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305212;
	b=pe7E7MsmYhtobXm69N3hLD3jj5+3yTudponETkv3TZyB2yoje/pwRF1iNBp13kzFID52
	 bEJPwpimLz9dB8EsH1hmzRZWEyF9TKDjQpwB9jg1DLvDk8NvLakCIqBWdhElud5utm3fX
	 ddyaxPoIMQF8PjwXaEiR4mMsomXtCvscRqW3wyuOAwSwDHGEmzAbk748bR6Yr5slcIXT1
	 ANPWltn1vk/mjEEPv0fLvViO0hx0GRdjqO7+acFjtb8O0Th6sjIkZGdVkE/6XWrJNW8Hu
	 HQzAsq0xUqQE7GSgZ9z6xxPlHYgSJMcmYlw/PvvlFGfFTc3uE6G5F7VYK3lthMo8thA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305212;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=7BQSRFHSBJqapdjgqYmN8XfyG0MP8BuvabQtNkdtbfI=;
	b=CWz4JXcdprNN2k1nBhBxm/9NvMU4F2b4iEB1XCszWoGsaXBWAeRPp6RtyR6wU3rScnH3
	 0FVf2iSLWzQ9MwBfGOjOCNYkK2cNFd8IXeh7buB6lZzMt39XlKjvxciaa1lS6OgWH0/bO
	 2mTSKjeXmLFwJa0awhzBLo7o8gDstE19QxiBCDq6F6HSST7jABlt9MMptLP+z2HHmX21h
	 U1qCjpHBcAkb004uHTN7JrsbtBlH2kdAB4++lOYYPARQegaF9rM07KeknCcWGQmCp87vw
	 brjBsSL+k2RiLhr2zNWDWONZw1iHvZe4O4kE8i/2A20kpm8KmuJhouJPOC6wdR4P8GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=j4anFfl5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gus2KIfb;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C5606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 20:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE4C5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=j4anFfl5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gus2KIfb
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 208877A013F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:20:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 29 Oct 2026 16:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793305210;
	 x=1793391610; bh=7BQSRFHSBJqapdjgqYmN8XfyG0MP8BuvabQtNkdtbfI=; b=
	j4anFfl5aKk/wnR+xcaI3sc3KuGQTKDFp9+Dcx+FJVJqyVdgue6S67xxahCZ0ei/
	BdJEhqdZwIxqp8/cuT4AsZ3rKTlbUvD6jdNc88m5ReriE1GOZ0eUL0orTPguyZJC
	NEGuWQyyX7oeddHeYN3cutcVQjMANG3YLUQXMvIUhdm+doaubxnOP5CcfWB84KUb
	K3h3ERJGkA7QWQMfnavHqtcBb077Dv8ehPPCwNRPx30ay+hzXnJFqNW40OOoZPpz
	8iR9o9nhftfNYKmukS2eNAT2YQrJBcMWbe6frYRQ3hCWR9NH4I9K4/mtdavhK/ql
	2E9VWBcJqDN29zqZNc8YnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793305210; x=
	1793391610; bh=7BQSRFHSBJqapdjgqYmN8XfyG0MP8BuvabQtNkdtbfI=; b=g
	us2KIfbxieRtJrRKBCxg37ZHNulRfdhtvyGqWLFjFcNdmiSa/du5M7VY7G5DTkhR
	qmliTgdx2MGOeBUP/MOLx4JgEaIDye+OYxIerZ1xCe+oKf0DCPPKZBvDUCrd2SEW
	XfEmbeolhCi7VLlwMt92/fmNbvGRnp5tyJvnvThQ/wRcCHeYKzvjOGdUMfSySSZa
	qcdH81SOwlMginmifcIwbAbQj81EHbpXvOxU5HID1/05cBmq0eepn+Y0lmkXaNMn
	7kERLVG3o39ynhOs6q4CXKdn1ftHGI6Ye1eFaz32x/eWcoaXRXd63p3KI/UdbvXp
	VisWt6U3SIo1Rb5IpUWrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793305210; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Anvt1ab6wmHOpHf1plvRu+i9NAJTzdbhb0RsuP5I+nIYFZ6
	68mkWRi1n+xmne0mV+ZAz9Kz8l+8UjZTZaluifvkxr5DifJr0FgMrDmiPCcHVz/7
	UyaZvQI7PgwDQ1UNzM3UUoAJByBkjHNeelhKLdu2DndcMwjPeAm6epkCfF7/OGQP
	OEUsBD4jTNO58jhsqe7hv8unehhwy0gafcUnnJYHer8E1ujczeM/37uo9COXdgOw
	NR0UTQMs0Wbygjj8gulovKqw76y08Rul5O/NRDalPOjuQNwd46Kb/kkVt5Qf1Cnf
	jU3EigtA6bf7Srv1DYCSNkxmJERTRUpYjNQkfvA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uFupvXZW9Z3wBpU3Bwb6Y3r2yS0QeRRzh712/1CiG3Q=:lW9nwkb05BoDmH+dCb11qeOfs2nj7BS6jQXXQQwPYu4=;
X-ME-Sender: <xms:eqrjaq6hiFRcexbm4Ohdwt8UVcXZ_hT6E9IRu93UTur4X_emZ794Dw>
    <xme:eqrjarUiqWHqm2AinekUmCYG95yye5eDbzI2uRREBV79V6lEkK6GSN1sfgpnzNHyG
    vHUF8ziWyveo301qPxxV0JCL0dEY3nDX2cnSxNykzsVErdcW2D0tAiX>
X-ME-Received: <xmr:eqrjam1tjLMigVdt6vSeHqJMmgbxEMODouALXVI3T0Q_11DKKX1ZvTpoZIyd5L2AH3j36ZGcK4YqJkbTmwtJtwVskOYn1DFNFOpNBB9XMtSrcZ7iarvt2iQ1ZQ>
X-ME-Proxy-Cause: dmFkZTEBROWezfNIXqHdn9xoqIQUFsioIaBYYGFQWamOGWQRr3/11M+4WXLJvGSlX81+kr
    XWil3afXVfy4yPD/PceVLTdtUW6PdN0wVZWr9GvFk2PLo5NTlS+HyeKuEKONPICN5upjjY
    L5M4EtekUCbpQGziY7bBKEC2FPo+Ra/UVaM2yA5AHRbhNtUx+uypd64q+DA8LWvhl91JNO
    lbGNsotz2jSi5Vd+P4VjMXcVJCgCTMidYSee9jkQ+mBsnSIg3dtQLw2C14SspU4P+OpvIj
    pZOMmEBNMf5FtbRCj/P4zaw+nqDntK4V58tr+6clNQQTOvj9KC/QntMCh2CthrMVKc0ZjM
    v/QUOSgfMoysRgpJyTw0ya//0pVRnTMDlSP37XMPRWx02mf3fcAZRkOuITEf4S1IrkcYbG
    xdLQt+kjruj0u8mqtzxpH0vexN2NlFyZODcDBOw2qnK6BupMNelPHzpkBN7YwRRkgCFyx5
    K522V+/kUfzqlX74r5o8ianpH5aMaYlcmYryy973MZQVAFoCr26Hs37PI0YqM+7IsWuyfy
    XDRDddafguai7WrjN58Us1AH8LR+eX+KrWnXng4yEyFXs3wEPWLkq5qVKc/LnzGbAFbvRq
    XVq4xoBy0NKb9hoFp0YBxlttR/l9/Kc/w26nQYrXzYRbjJDzMiHGWfYqR4XQ
X-ME-Proxy: <xmx:eqrjag0JYewmH-IZ6pH1LFelaVOH50ZOhvw8fQisvXiUeqrFROEqQg>
    <xmx:eqrjah8E0NvPqIznKPLLmi4hDXHXyhyqf_tpKh0YFBICXTSvo50LBA>
    <xmx:eqrjal0cazTr_HNm5aFXAvUYKK8hlVbeH1NWVt9hq84T8ip96sNDLQ>
    <xmx:eqrjam-rpcYQh8uqEIWSBzb3yERiNxZHPb9L2NamlZ1MXY1ffGvVkg>
    <xmx:eqrjajcPvQSfANeaXBH7PchASkWPYZ9bmrOPOCA9qCgf0wIpyGUy3WjL>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 16:20:10 -0400 (EDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 16:20:10 -0400
Message-Id: <DMHLN4FBDV5C.8O60G05LVV3@fastmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] repo: add level of concern reporting
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>
X-Mailer: aerc 0.21.0
References: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com> <20261029-b4-repo-structure-concern-v4-1-d813537ec617@fastmail.com> <xmqqld7g1dy4.fsf@gitster.g>
In-Reply-To: <xmqqld7g1dy4.fsf@gitster.g>

On Thu Oct 29, 2026 at 3:53 PM EDT, Junio C Hamano wrote:
> "Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:
>
>> @@ -550,51 +700,76 @@ static void stats_table_setup_structure(struct sta=
ts_table *table,
>>  	stats_table_object_size_addf(table,
>>  				     &objects->largest.commit_size.oid,
>>  				     objects->largest.commit_size.value,
>> +				     repo_structure_concern_level(
>> +					     CONCERN_STAT_COMMIT_LARGEST,
>> +					     objects->largest.commit_size.value,
>> +					     repo_structure_concern_thresholds),
>>  				     "    * %s", _("Maximum size"));
>
> So, objects->largest.commit_size is computed using the value in
> objects->largest.commit_size.value field.
>
>>  	stats_table_object_size_addf(table,
>>  				     &objects->largest.tree_size.oid,
>>  				     objects->largest.tree_size.value,
>> +				     repo_structure_concern_level(
>> +					     CONCERN_STAT_TREE_LARGEST,
>> +					     objects->largest.commit_size.value,
>> +					     repo_structure_concern_thresholds),
>>  				     "    * %s", _("Maximum size"));
>
> And the same objects->largest.commit_size.value is also used to
> compute objects->largest.tree_size here.
>
> Copy and paste mistake, perhaps?

Argh, yeah. I road through this commit _so_ many times, and still=20
managed to miss that. Grumble. Will, of course, fix.

    -Mark



--=20
Mark Craig Chu-Carroll (@MarkChuCarroll at gitlab)
*** Software Tools/Math Geek - Software Engineer at Gitlab
*** Work Email: mcarroll@gitlab.com / markchucarroll@fastmail.com
*** Personal Blog: http://goodmath.org/blog / Personal email: markcc@gmail.=
com

