Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD403368BF
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132638; cv=none; b=HbS1+kqPMZ9NdGCDNV5YuTPzSzFSxJgOJnixwmLUH891zRywlLGV5feJPgAyhs2dSxGcCqsQ5eImPDXZK5Grjm0FmLdML6lH6vnfZA9mSwmBm9bmh2gMb67H9TdCaN++7AYgkiywzK5YafMhTGm9VUKVvmeB2ljjIFsb/ruKQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132638; c=relaxed/simple;
	bh=ny42TmsS1oMRfHrj+DTvgp4wwzBDQ0qVBqvXH7eKo3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NbYWj+bLOfpNqmpmcqd1rQcosedXVriODml3x+9cEnmAwCO6cp1rhrYURjaToDZy39cqc/HqJlHGCgkijbT3AJpOGcxeL79mqdellSD0cpRnJpccA16x8XqOLKgiGdCYg/SPe1TBCJssc7dy5nz3dTa/goia6dJYm2Qw6emp8aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kU8AQPhH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MF4hOf/C; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kU8AQPhH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MF4hOf/C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B69681400220;
	Mon, 22 Jun 2026 08:50:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 22 Jun 2026 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782132636; x=1782219036; bh=87ADCyHcA1
	+9CQU5Sg6XOgWn2Jxpa6BsTdsyM3e3F7E=; b=kU8AQPhHHbq+Xlg/zXuRkXW/uG
	0Q2geCwlO/D+mwVoK70o3xPm1C9rQKyQAa6FIPojfQA+fJaccES5mTd50+fcsme/
	sUx1wbg5SItM7m91G+7J0RNIi2VpUu4EGF71rqX/QZIFd2Qv3/bx0LYucHzVc3UF
	qDp4UnoG4Ozh14uTFnx1RjUD7ZTsGY3ClySEW8jilHcw8EavkWoTjwkbmbwDqwhf
	pI4l0CKEf6l/Z4P8hgx06nL2pEXbsLqJdloU2mz0b5X1dW9Mtbpv93mGZMiPUsbx
	qh5YlCs2zyW0jECfSxl5ewPmEqYezUhDA00J2yBkkLfjE1Xv6BbiTJLm13fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782132636; x=1782219036; bh=87ADCyHcA1+9CQU5Sg6XOgWn2Jxpa6BsTds
	yM3e3F7E=; b=MF4hOf/CQkdaqIzb9kzzIyDH8ynvHs1+RQlmvsDpm6u4aIgOko4
	D2MogFTG30N78a1IJfxbZomb618x8FaWeBRYmhC939C9d3Pz3JKjCzVg2T+Qd3Gc
	CZd0KX+/K2jln3ZCLxOKfnHyisOpOOYlk4wxQI0CV6yWTB/O3m3FUAcuFxQSEER5
	JdCe7i0XB3DtYXDoMOeHUMhlOVN3gWKUTmm+melXXjNnHaLydGlr/rJyn3o/aSGk
	7z560xPxXsVGjRU91YBG3dVO1sO5eP7dX2xO8iZENJfbbOQu9deo3H38ZN3DJ4BX
	LXk94+q3ONwE3CTsbDZPGCkYERFE09VMnmw==
X-ME-Sender: <xms:nC85amlQnse4EywbHjN12WZWF-bm3FCuy1wib13-isYU7oJMos1z6A>
    <xme:nC85alSKRBv00uj1TKlIWMMyZRxtsN81aFP7apLcjdUE6Wyfq7D-194F7HmHpRJat
    jlKWlmMdWVYdWubT6nb1Eqzw6JqtniE5lJEe0YBfWADaQGveTh4VQ>
X-ME-Received: <xmr:nC85aiBmZMKxSo97czN1o_0zOOWNRooYi7Mb7FPWf6pVpqnFKxDJBQeU8UrTQEYom0wsVt4mbK2psPqDLzDXpHPrIqklnSJcdVIc26w>
X-ME-Proxy-Cause: dmFkZTFSb4BgP/0S89ynfqSBcH9fUvBMLsZbJ/iYm9C3qS4v6eW+u8DUDH4XKXOKPkD/Uf
    C4j5GuRcx0XB5IYiPwuW8t2nnOMs0XrycgIa+ykVJJtIT0tiuzMhXl82y/t8BzZvxUe+Qc
    51xH9HN4AY4h46L2kYDpEEoMAdF6SrLJNrneVvZjx9N0tay7+ssXQVYS4Rk3kWEFha/cdI
    NfqppEy6ZCH6Tydf0ebsypUp2Rem/DtS0Rm+9pl1EJ3dH0Pjs8Htkioj69UFLIQjbtLptd
    yBWvjj5uHhBrfCmT/6lUOgPTmAaaSaFx2M92lZWN7eR//lK4DfJWigHKm1Vl91lC4tTxCM
    subw+WN+fofv1etlg1eaEbxki17TGmkSOUn1Qrwcd5E6G1TADolCeUl4ye8rGARUmOTs/d
    4xyiEoquzjVtaJEAuXPl9t4SyGNIUDZjgMOUwvKwWLep7uQ2/feeboUW6y/MDXNqESKqZM
    DgtwLHZ/mr9ELs0Ji9KGJnv4tAeh9B/FEAyf4pYbzzotOq5ItLCRHjT+dAJOVljLv/qNU+
    8k3KQ0BejCgkb8BC6vMYnvKnGnwrjY31vpAgv55HB+aFWuUH+X0uu1vACuGagKxqUQCRrV
    Oa+KmNeAtvYwdx13B44j7jf0HVMqm7rDBpu7aLwqXvlwfA4LxgIDjQFk7RwA
X-ME-Proxy: <xmx:nC85akS_ysaNCZLRKdDuhtB3i6l4pWCzxOJPj5ZuZW4Q3fHb1ycAaQ>
    <xmx:nC85aooDPIFlIsTiw-c86UcoACepZFUhGLDe_OAqmZbEZ1ySRR_EKQ>
    <xmx:nC85auz-hOuEBFVtcB9XhJB8mu_M24Q_LXQqIgD-8MMbFo-ecmILXw>
    <xmx:nC85alKcC9zsi8pQW3KHmygPf60mLidVvBTYVJq-84fPmOydd2Mg_g>
    <xmx:nC85alayVxR-siSOYG8NkBvQuIa_zRfDN4XfeQaZ72KB_BPv_ZFOkiFz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 08:50:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2026, #07)
In-Reply-To: <ajjpoEDt9Q_uv-LY@pks.im> (Patrick Steinhardt's message of "Mon,
	22 Jun 2026 09:52:00 +0200")
References: <xmqqldcahu6q.fsf@gitster.g> <ajjpoEDt9Q_uv-LY@pks.im>
Date: Mon, 22 Jun 2026 05:50:35 -0700
Message-ID: <xmqqwlvq3fj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jun 19, 2026 at 06:33:33PM -0700, Junio C Hamano wrote:
>> * ps/gitlab-ci-windows (2026-06-15) 1 commit
>>  - gitlab-ci: migrate Windows builds away from Chocolatey
>> ... 
> Might even be a candidate to also merge to `master` before the release,
> if you feel comfortable with that.

Yeah, exactly my thought.  I've carelessly merged some stuff that
had wider implications (I do not think they are buggy after reading
the patches, though) than the topic name suggested near the tip of
'master' recently, but compared to them the potential blast radius
of this topic is certainly much smaller ;-)
