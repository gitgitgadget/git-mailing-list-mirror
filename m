Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609478;
	b=dVQ4qN9wpBdvhpUehKcHqFredoQuDvvVMjmU9zn9eisqGcWUSmPI9ly8TDpT1d+GqdwN
	 BX4otQjL9fL5Y0h57H6YW8O6FCdou7Bc71qgu/b8+PbZQrWR09v24pKsDk1ZTpyALpxgK
	 ZXP9Vu1thR9K4Y/eJn9MT1P3xLuYu3Sd3Ltx+gyMUEaWgEnczqsJWltSILgsuasi57ch5
	 pj4kzVPBzuTij1UxstKDgVT38d6WykyskuZce3wHawpWrr5Eb55IBdLj/eCRaCS5/rJ+P
	 DsO95883kWePKpLqH996AQw+fTBY/BDHpKKlRrG3cvxs/vwB60mOb4wKc5ubDBgSbcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609478;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=nOU5VYG32Dyu5NPCWaF75SIy3RPLe+odG+o7G0bX3HI=;
	b=WPX5aGYBZWIqyYsMGoUREjSniLba4wIhsXthVV50OXmdULTRj+AB0dEySmAI64zhtH62
	 /C47V17Y0SUxbY81fKsStnjJG8tfmrFTu7VZfXu4JHe8qYlLsnlbcPfa0zNMji75+EGJ1
	 HNxtVfeY/j3aYN++XMJqvP/PwhLbjkaUKiQkBLtZ2NjeJVLGcoxVrh6r7Gmt8U1Vvuspr
	 9BFY1w1R05ceMDTpN3WqxEudC95WAU/rJOOdhlvGiej0zGxemeeo86jBPeANMsneX45Lt
	 cYiUqIs4JQmXT1rMLGbFvPnMt6QO1rYEyufK6jJPx1JGvEcI+4Trf93sL6hZlH2d+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=RZvISj8g;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QNIUbImt;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9860A2605
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 08:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD9860A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=RZvISj8g;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QNIUbImt
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C07081D00064
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 03:51:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 03:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793609476; x=1793695876; bh=nOU5VYG32D
	yu5NPCWaF75SIy3RPLe+odG+o7G0bX3HI=; b=RZvISj8gbC6g84fAvjyNmdfYBr
	7Gh9RX6ECakTYrooMfGgkutyLI/fc2e8aoqjp/xgRDr+lVs9Wxm7K0p9MOAfo/FF
	2+kNK/FCvytzM/ez5DtyYraQYck4CuV48BQXFHp+P9yyxrX0td/HbW9WJWMmg1FD
	vPPsUmrDEyj+6vx0qGo6hZLwBtF7azEqbvC+yWiTpaH8+ivQksEFRN0ItpOsfNWO
	T1mxfnzv2SrfAcAfJWuIeI52YKgT+zfEh9DWYxDJWGwNJ332Mv0v2ffXxfNGCQE/
	qyf+jGcqytYpVDqSgfrHG556JmaTQEJ8H0YI8aPdltIWbZ1bQY2sBW+vRYCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793609476; x=1793695876; bh=nOU5VYG32Dyu5NPCWaF75SIy3RPLe+odG+o
	7G0bX3HI=; b=QNIUbImtnD6S1scTEhMAZSRcTsMiDNNFXcaXxXOVwWvhQ897+M/
	akcm9jzkani6SYTmDIpPZ1fgo1SsRJinMQAvMptjXfxN2x1nmx9T8idxwMS5zhSD
	WEK1CoSVBqcIPzsLA0dYVcGOxvR2a4I2nCVqK626AemQJX0YrFkNJ5gLzwRrPdsk
	3uODAbAEcli4loovwS62w+LcXGCSKCxLKG8QlTcThNP7pB0eu+sL7XYJcW1rPDUN
	EZ53ynEfy6URHj+R6Mm90mvcxOsSN+LYA29UYBj8o4ReDt8Zm1DnCwV9sTtZ1W+M
	ZHaUFFqxyvFP9mjEF5794kI1idcNUU+BvUQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793609476; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Y55w3VbJjH+S6+zQUC0eIVORV8ExKazH9DRbKi+kHnAhGTr
	8/wUGa/PyhdVY+rs3LCjNK0OchgHYr8bmsFd/BBmoUvgsJwps9pe1VN5KicPtN9K
	W3e82XYsIwNdIL8Bv6hQLpUDeWJW1yINo00eYg82LrMqEPGeUkjncVoQGsCFbBps
	FCMtCuWboV7uBozA2X1sUQnqkYBy1yO2ugjduiBAwfNKbCugUBe/te2a+9dzCcnh
	I3qTzvnhM7Lm/R3yKjd1sIphUz5UjZLT33hbsZBYaOlqpjoyIbT2jIRL8aJjQIkg
	kLQXhUZsA5yRU2LJVB2ME2oTnRYQXs8f4WRXxMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:F2U2fQ9JDqIpZosZ4q14ld/UMEbCwWOAUfXpocyTzqk=:59iYpINEKgHp9skAzAWSY02jYDZcHIdCM0q3tphbLQk=;
X-ME-Sender: <xms:BE_oahjNtwoLiRKjy2VrQ21dzerNtKHlA3YoNCDpdJ-JFaHQiqxB4Q>
    <xme:BE_oatCj1PdbvmXkR0GhS9LFMceHDqsX3RliC_KFF7vltBdMpq8dkGtDUOHsRxCO6
    -x7kuaXNkrOirVuuv_0TUaK7599563n8TcWx0n8PF752kJARqcf>
X-ME-Received: <xmr:BE_oamGtYGLz7fhir17fJVyXY-fIR1aD7ClVjQHRlsiijba0ZcBgFRjME7t02KaavdPqmcjnMy-VhawvMNvJuMAstBxoPqAYIjEq>
X-ME-Proxy-Cause: dmFkZTFJrIA8GL/vw+yls64GvFNbIPEmQp5bA8VTdVotbwxztiOFfrtXAzPwh21ZiknATM
    9LGjgrOAgtdIokDljmaBbvSCmjFsyQt++cht7mEkBUmgUuTwf9D1Y+e3XQ8vGIAmFZ86AT
    z/U0bsG3cbPgR8F2ULKvhvtg1F3okQueFPxpih3MG5WFQPNXqzNnbuqxafCMc2mxC1/fu9
    N+e8WJX0pNVeU0zJ9odpHbVhsvzhiqLN+nrrsvxuwIRp7aG0BPHJJ/eNbsTEVcDusbOcm0
    LQoJkuEHj2etd1nciWkjNj9xa7FqK60I5BvxZc2IsvVlqcxO8IOkPPmoFZsSVd1a25BKmM
    FGuLbd01R9mAak6V2Q7H8mwZF1v9y7vDWHxvEYrtVb/fe1GNT8iw9ydnWOeIp1Al9DEzew
    DDCSvw4FJDB7ZuoNDXspbEBV18RkZ2rx8TO64qDlqFRuV45Jkhg77mdQHFQCCcODukHXTz
    dWmjtKCFlcUgPhLTqWPqap/rk95qqWVQMHevLg43RI1hKT/XMxQo559K4AD0sJQCWvcjWM
    x4eNOFkusskRMANLvMF1JpK6m4iO45+uxr+m8u3KALeMnqTU0WnoGBvo1BtqHDDRifAczw
    VOTJudblbuOQLWDc1v46B0i53e8e3Bj8/PZa+wAao0U5ZkM7IuRnTTxX8g4w
X-ME-Proxy: <xmx:BE_oalIGe4se9t8s4GgJtLB_h_XRejUTnXsDkdcF0NTgY66x16X5NA>
    <xmx:BE_oaqmS6IcqwOp2r8rjX_BylQy-Og-QK8wcWgJd7oMB5KV0A-eE-w>
    <xmx:BE_oatSVLOJM4BtA7E7fNv12HHEs6YkJetYOkIbNpeNiw17sFnoMyg>
    <xmx:BE_oasJW89oFyWz9P7rHQRSFDFi0f1nG1qHWftrMPCq5qqgsD9BnSA>
    <xmx:BE_oasKk_-SaPF866LDZvhmdRRbO33qs3PPNxmFHTHLAlcmKDtPGiiw_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 03:51:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: Aaron Plattner <aplattner@nvidia.com>,  Rahul Rameshbabu
 <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
In-Reply-To: <xmqqbjarowvi.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	24 Aug 2026 17:40:49 -0700")
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
	<xmqq8q60u82x.fsf@gitster.g> <xmqqbjarowvi.fsf@gitster.g>
Date: Mon, 02 Nov 2026 00:51:14 -0800
Message-ID: <xmqqwlqvmxa5.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> For those of you who are watching from the sidelines, this v2 lacks
>> the threading history.
>>
>> The v1 is at https://lore.kernel.org/git/20260602161150.1527493-1-aplattner@nvidia.com/
>
> Any takers?  It should be quite easy to be more interested and be a
> better reviewer in the http transfer codepaths than I am.

Second call.  Anybody?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

Thanks.
