Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515974;
	b=ugGuGO1pzS22vIxf6aeOQmoVr1eDpE+0z4AJ+yGUQi55l1NMB+IisGOfg7jcAR6uw4Fs
	 zY8xmCsEXsSfMonTxdvTZCz7mVTbrTlOfIr5L5qVAcCnKRmoo2Kp4ILXIyWLO+tyt67z7
	 tbUP9YH+xYUFG9k71BUXUyxEIoZOFy3j8OdyHyrOosn++WXWiRmlDnIDxsiWyLhWi9NRw
	 SdxBLiGCl8KSK19XNqrBe1JFK9PfbvbJa2Q9cl6szmnGH+9tuoIwcn+B6zBqFWC+jT7ga
	 YXlrZiUHRwBc7DyCcu3uift8fci0/hcSWV0c0qWNinR4xxtqh0FsUegxefwRFZDTcvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515974;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=jJSb/HL7fqiOQxH+m0Vp4q9jBMm7ww1QzVSGnv4Qvcg=;
	b=Oe3vlBkHZCfshnCfJmjM9/oosQXKeo3jLG+4GulGnAwQE02jPyHBr8gqrGnEZymJWEpk
	 Ee/mJDrL2+xNfYWLYd2dJB0DZHVi8ARDv1mJDWrIEOsEQbUaIm0UBmlfENmjCQ/xOg5AZ
	 nPi3Za23KeTQsWcW8/UBFL4hpxYEcM135aKJhfCU5a1NMqboVTB8qSlI56itahubAsMo3
	 p+co4jY4Snzcmgj3nfpujx+zXOHJ1/07ZMH8qDgv+1Tm2en94VfjvkyNklto6FpVIaHc2
	 ji7tyAn6Vr7i0BxFznwLVJWiQlG2RIpTwvqBdGS61ZFyofHbWu4gWhg8hSMr/r7FNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=YKN7SIKb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="vr4Q2MQ/";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD7606A322
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 10:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCCD7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm3 header.b=YKN7SIKb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vr4Q2MQ/
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C14731400242
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 05:26:12 -0500 (EST)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 24 Nov 2026 05:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1795515971;
	 x=1795602371; bh=jJSb/HL7fqiOQxH+m0Vp4q9jBMm7ww1QzVSGnv4Qvcg=; b=
	YKN7SIKbPOWxRNPVBqmP0XGvfLSiT4HQOu3U1NtxE4tf1QUPLa0j+W7VgBaA2JYE
	9YxLJR2xG3pS5qV9iKVjxG1rlSC8/9yW7CTyxBlqDilrj3LJiFPwgFbpD7KSnQlL
	zw8vKJ2WuY3VqT+pKFiK2GiqabxpwfXO3yGnTZguu67G/YlVzJkT13fmMRWZENgD
	z/UJ0c8APBCabvCvIsM08Eqe0fwggz65N+6gFL621BwH7g2Xcx5ret9HUxID1fm8
	skynrphF5Zb2Vfp2QfF8d91QopZcOkfRVa5EQYzln9dpdgUSkxpPVfnmyAcDcg0N
	VrFiOXG3+mOEvFKYsv91Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795515971; x=1795602371; bh=j
	JSb/HL7fqiOQxH+m0Vp4q9jBMm7ww1QzVSGnv4Qvcg=; b=vr4Q2MQ/epW2AydMe
	AFlhmvFBk+PPnVSp2+zTlVXnUniLB7/JeWsS1oCJrs4M/BuStqfh1GalHfzh+rpX
	0oa4Nb+DyBvx/Xlt9VTbKJ1pT8nb20RFOpH5zRdBBADc0FJIkPdejvJWp4fBXjso
	+pCfT4OunyFWnkHtNNVyb8YGoDhG38fXB66n7kFfYkvB0lLWYNcicfeM9UfS4w2Q
	KpJZ5Y/cW/as0Qq8k/ugvVd6KAnIk2VA0h3l5LWBmNl6NyvISQpV/5eM2PgalKSa
	tP+oGbJshOjDFAu68RiomMHhwlqvozuAgc/23V82DtqAJfJ5j6TJZa1Vp+Qa9qGa
	rIrmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795515971; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mCxGj+HJnhffAmfku49xmx/Ui2Nr+mWbCF13U4Vku3IvpNu
	2yUAVqDvWtu15ZLtJt31SVpJobLvduhPt1aMOMO2Nv+96VV7z/3/SAxoGkLMLelg
	qNfLoeWCSUdUWye7DJpMUV15TU9PRIwL8XfjcxcGs7pN8diwYQ5BcIofaOB5nh6T
	vQVAhgbCtbay5XjlunAeeNZFgcEcTa++cWnPG5XsjspYKx5H0kAZx3p+twzXQNgF
	I3osv8MjSR29UZ/B393/AZRMtRqo+Yy8cOPl4PRA8qN87jsiqSM82yAo8dHYxHl/
	pTvO6wvo6Em4pXbw7ZovzXD/LEOQ/iT8BtNcO4Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:343tYYelvTaISCUglAor/QloEIjizdUbMC52SwZS6wQ=:WWF61ftywivcaCdfGkJzlmTB8Yl6Cdwdlpv0DIgGu+o=;
X-ME-Sender: <xms:QWYFa55QLF8SuxtQFnak6nqr0PN3hjdy7EF-kp5SWNquaOwCqz_2y94>
    <xme:QWYFaxsbg4e6L_wZjuNUbnimBgN8ccDLqNHmYa6PDn6EAgf5eRMr0ErAp0OCcVDZi
    VEomUxd39LHqtnS6SmwgfKVebISbbLVzVggSAo0QVUBJStfj8_jmto>
X-ME-Proxy-Cause: dmFkZTE5IhNT+q8be5MtzaXfWRHmcyLNKl1/5t3Hoj4IzDL9EVvidw+RAcqRdHvCx9QAMd
    dyAoXgNAY017SSqQ/iDhkGsOUWU+tjbQFjYSR3e8V2NvSyvY3PcwDjReXohv/wk3JhVjX+
    pJ5VJhLy5siDa22ggxQotm4cwh3fHjcw22OU6EVZxZqlOuaiPErqoC1g8o8+2CXh9YghxY
    1hHS1LlKtjQDaNOLGo3sBfIEMc43cy8ZExBoh0oB1qXgj0B7k6haryBkfDOp1TkVSykFRN
    /016IQuFO1+Jd3qDvm53wgGKMJQJrw1hBX6EyBFiKtUpyDVRUMi7mtTDUiloC4GlSewbjc
    iekDh2T1ajQyN536WKL8v7ozc32Dl4T+5xLleIsFeWXbFcKxc77869Qn8npracAyBFGDsb
    IbdkxKp3vVs3ScEZqyvPz97VTjoFZD+0S/UW/TKgKpihxSUHF73fSeO6m/KLE+RtoOOh4b
    PZtMvSZwzdFVdmtiG+I2Dx16pCCaGU8AfpKLo3T29qn6tpgUHqwFZForArDxlOS0iwTDNm
    0ZcJdYOdpe6yZ2CNILlDhI5/LO3XQy4ar4oxnb2h3EMU+b6Vx+4JZYWujDZvTzpeeIsI7r
    LOFpUvaGlAM6Nrai1aatwJEe3GSJLgrAvaibi0k7iHGOq2OKeevoT49sPkbw
X-ME-Proxy: <xmx:QWYFa0kbxEWXLEYBcOyiZHzEuO1PYPsX2h85CMoVjsOMIQGDV2U6UA>
    <xmx:QmYFaxx9KYJe3I7AtPAIbYTTSKx0hPTxW2ZvbZsYhtCifnfxU0ETDw>
    <xmx:QmYFa6Pqpzn2G6ap2hEVkfK3QKNM2vTcX5dmZfYxVN51ph1glCVBZw>
    <xmx:QmYFa9REKa84aTQA3vxYv4B40MYwRR_RxpXVl-TJ0C6hHCMzvkMDYg>
    <xmx:Q2YFay1Wz0UiaK3PtYd3nX1c8WxdB-fniQcGmtVmm6Wjh760J97irA5P>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id ED32822C009C; Tue, 24 Nov 2026 05:26:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AGI3diiWwXGo
Date: Tue, 24 Nov 2026 11:25:48 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Richard Kerry" <richard.kerry@atos.ai>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Message-Id: <c11e143c-91ea-417f-8f20-cc178e280a6c@app.fastmail.com>
In-Reply-To: 
 <AS4PR02MB8336DCFEB4C0076DCE45F950EB452@AS4PR02MB8336.eurprd02.prod.outlook.com>
References: <20261122152538.107580-1-omri.sarig13@gmail.com>
 <xmqqfqwsk4a6.fsf@gitster.g> <6954cd53-43c8-48ca-82da-35c673dee260@gmail.com>
 <AS4PR02MB8336DCFEB4C0076DCE45F950EB452@AS4PR02MB8336.eurprd02.prod.outlook.com>
Subject: Re: [PATCH] doc: update-index: Format options correctly
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026, at 16:56, Richard Kerry wrote:
> Hmmmm....
>
> We've just had some discussion on this.
> Spot the line that isn't part of the reply?
> And that is not surrounded by blanks.
> So is not visible.

This is referring to a change to MyFirstContribution which is
in `seen` now:[1][2]

    Leave a blank line between paragraphs. A block of quoted text counts
    as a paragraph, so leave a blank line before and after it.

[1]: https://lore.kernel.org/git/20261118105227.50447-1-okhuomonajayi54@=
gmail.com/
[2]: Which was motivated by https://lore.kernel.org/git/AS4PR02MB8336399=
9DA64DD82F6E25FB0EB7B2@AS4PR02MB8336.eurprd02.prod.outlook.com/

>[snip]
>> -----Original Message-----
>> From: Omri Sarig <omri.sarig13@gmail.com>
>> Sent: 23 November 2026 15:32
>> To: Junio C Hamano <gitster@pobox.com>
>> Cc: git@vger.kernel.org
>> Subject: Re: [PATCH] doc: update-index: Format options correctly
>>
>> Caution: External email. Do not open attachments or click links, unle=
ss this email
>> comes from a known sender and you know the content is safe.

Why does Outlook leave this in the email itself? My Gmail restricts
itself to =E2=80=9Ccautioning=E2=80=9D about it in the interface.

>[snip]
> content. Although Atos endeavours to maintain a virus-free network, we
> do not warrant that this transmission is virus-free and can accept no
> liability for any damages resulting from any virus transmitted. The
> risks are deemed to be accepted by everyone who communicates with Atos
> by email.

This sounds dangerous. I certainly have not accepted communicating with
Atos. Maybe I should have a rule to delete these emails just in case. I
don=E2=80=99t want any computer viruses.
