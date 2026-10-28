Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204870;
	b=IZI6AeRWhVPJCVpzYBO95PlqjRjAKETCxks4tvlkF/UkM4c1qYTPydrmQLK6NgJGBTgh
	 zp3MeB0rZcSDGD6SdDjiebZ1wxtf0X3JojBdozZ0aep9Gu44Tc3iGoTgMskGfy8HeppRz
	 h/Hkve7TW6OmBZJlTWBqAsXtXlVbe8FVXYHLruIdlk/pw/RrAyiU7BUwzg48GWZm2jAR+
	 YiCnpdfp75hRz/d0alDP5/slAZhWMPv0U3GI4KXwKlN+WSmQUsH3uwRUZiQij/8L866yF
	 0+SXcl6sE6UNZSxoj/jBpb28pKOAQxPm2H+ttxNIwkVKgyONlUYyDU/RAiABHXN6C8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204870;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PwsTNlshgp2wzCwB2KAnb11sZr5uVJzgoKj7XR0VQAk=;
	b=vNQUNfgUDPvPGBRsXBvkfwzKjKCN36xxgfDY5l2XW90R2YxasMnutAX2VsEEw77W1SEs
	 9+xkOAf5NWf6umZMAfD4sfh4tbsYVUaYvZHzFhCs1vXHBk220g2HhQGhikSx55G7gX7Pd
	 hdOTUVm6TXgHVTOTu6kt4XJS4lS3vE5I+vvou2nFc78Al35dbxim0pZ+5KGE7hJnjoXOk
	 xRyc2lp47v71VCifYwGQakD7lFwzsMKRKHUUoZAw0+lamX78dXevG/6G4AMYVsM8Ipy9o
	 Ll3zMocRt9LHbUFVS0wdNXT2tFFOQTgwrcc2g8fCSgBG+x+387FKdxxpTtChkJ1pyJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZfaimXP7;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dq39pdVx;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC8606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFC8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZfaimXP7;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=dq39pdVx
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C9D81D001CA
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:27:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 12:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793204868;
	 x=1793291268; bh=PwsTNlshgp2wzCwB2KAnb11sZr5uVJzgoKj7XR0VQAk=; b=
	ZfaimXP7/h6dD8EEAQJfEmvRkLdHrWm94qgDgGtcOMxZAxB1zh2FtkdYoN1Amm4C
	mAvsinwLxal0b9UlkwGp6J5O/+Wd3KMI57NEgEWPOxN4lsgO2CPerKVKwVRfuf3+
	ms/pnd9OnO7GxI+UjC2bRIb56EuNtAmS8WHRF0Z6WjTjV+4l64yfLrJk5PbmEUT+
	zXHyjhGMX5qTHGRtyx4StaE/caAhXi5ELwr6/kaz4uI6JN4xAZRQDgG52KFiu96P
	0/p9JagM9cTccQb2rHOtveoU3aHG63O0dtjVmySuqErUMDDrPwSZikAfEDVH1i/Y
	fC8TREo8nzZ43K8J/SY0sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793204868; x=
	1793291268; bh=PwsTNlshgp2wzCwB2KAnb11sZr5uVJzgoKj7XR0VQAk=; b=d
	q39pdVxbGMa1eZiE+zJQH3KHAIaKitBITaMjL81u40bIzJq5wWGjXBSW6+Zd7WHv
	8b3hPiVnlkdY0Kw+6+CaimnkEEhhWyB7Nj6bq4wnznldW0V+HPrfz1xxesuvSmow
	D/nH9bhIlk3xfa+zkXhFZ8QDSszFr43gsgybjhDZMFKL7Ve3/P7XL2lcWo6FpZTU
	Q/HKClmuEPvPqJKTquwuDzJmwxohKJ2cYlsYTyq/GnbBl8wcdYbA+3j6u98MAAEA
	Muh2zE0jWf5D7+QvP6gmmQ8apTahu4he3gO5AnpHaigobsxIAy7qos16QWq13kTo
	eiJH+QgHCcO+vWW0BTA0w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793204868; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:L552adULH0w36o5HqgNDNhwzgUHj0jRsty/4L+LqKOw/Rwi
	ipgB2WL6f5TpOvpaXfx7dNU3bTwtlsQm+fnLvS+hyZ5AMz+k1eZzt5jWxKdqentD
	Sq+aiUPlda1752P/MPfnsDRfI0wcr5Paf3462Ze2ywib8f/CnrqdLfdSciHMgZf2
	EuJYCdbu3M9krJApIm7dz4eFSATJ4XrXYeWcPbJMWnCCtYC9JFx3CeHhsXANs+d+
	dYKtDeV/gBayCn5czQQNCXcaIbKZ/iR0NatTCP9xGk0K7tvjXPZVihkMP7GdxQZ2
	5/TqoxfTy20ezg4o+LkeJ7Pis6ia37Zru7BwV9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:tR7CftSGShph4OFygxtYm+/UZgOBwsHQCxn1KdmWvOE=:COFXLzE71iJHwvqvf+18TJqEQbGWD0K2vZeOLw5FDYU=;
X-ME-Sender: <xms:hCLiahJTSwUaN-2NXibvhH3thrqAOd97NOGeUKqDYFU_j3QZ2t52kw>
    <xme:hCLiakJLe4HPIS1D8M1vAvoiY8OueQzNpbg1caa-767_K_qlBfpAVtqDbu4ObyoF1
    uF_KfH1rkea5kPuS8wSQYxoqLueb_O_0EH82Td_VNuEGlVNzbHIrQQ>
X-ME-Received: <xmr:hCLiautk3vHxOOu0YAGX3p26C0GqBzNuAE3vqRhBTtoTNKSikVQ1e0n8TLG_KLAj3QJtY_yi9-cKDUFzwu3eowOrGEqFQpqVjMlk>
X-ME-Proxy-Cause: dmFkZTEENYS2lMqgZ+6bP0Sk1CN+6faCbKcD7FBOF1h01BtqCdzDFaoC10aXw1fly0PNKv
    kmSzyeSTq1gjKGIluKhgPyNem0Iq9zd914/BshA/qU1fYQcTeb9/l6jkdhobodCtNsgvNl
    pcKrRYHKM8Kx/4ORFARWJfZSu+vXs9+D4fRrwuJg5CaMyFb1Z1aaxCRVWFIFUg91j8XBJS
    itG0MLoa7X+l1ZwfWCe5JaXaayVyoEJcwd2vKmHR9d6o/t7J4oGtjxvdLXc5vo4hPT/fYh
    1xUaJmSRlkEN2iTHi1nZ2WZXeYr/Ef0mJlr0/c4xVzYfThXnQGpD4WDkVygaQlDH8owSdP
    SLN3oHm4ohtEnhE4atspEV2DSS5OjGJ6bBtc0yr9mFHeQL60M8bmnWWW8+In2cWNEWKGZE
    TUKg6d+289ejmFPPcsTPmNXLNa1j1KAn7kmFqndZqoLX15sS6icY0sAP1P+4b0eu7PxmEu
    Lb4ZpIPIBb0QK5XeVBHF4cBkPreIbtmn7/Uv8mZptURFdXzp5xT2AnBHANZfFr8gExhhha
    gA4lh6ydKdlwvP4ngkf1zKm5Geo3C6J0KwgLJTXj4dFKEYvarqozeo9ZZV38GDTWmjYFLE
    hGT98neNF37Vfz4/Hd6K9J9hi1kX3Fk6ykbNtHShmszQ3GB02q0XHCb+td1Q
X-ME-Proxy: <xmx:hCLiahQoIHaA7zrh0vJ6BBfe2KyeA6ntLrSWDl4NgeKWLhwUMzhDpA>
    <xmx:hCLiakM-ZCf7DYJBizwi-c1dve9kLeTQ_UKdt1iEuuIqWJ1HKsZLmQ>
    <xmx:hCLiamYC-aPgXtxllZF__o_14TlZ5_MjryMI9nzTaWpub4iz2w-Stw>
    <xmx:hCLiauy8ILsmHzRYZyOS_YTUSc3kKxzp6ve5p8lgc6FtPEP0AH_6GA>
    <xmx:hCLiauO-zX4jJRizaYWZRa3i2R1qMXxcW3uJIf-1xBWJWe9rg-MpBh7C>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:27:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] odb/source-files: simplify directory duplication
 detection
In-Reply-To: <auG7Ru6MhhXzrVd-@pks.im> (Patrick Steinhardt's message of "Wed,
	28 Oct 2026 10:07:18 +0100")
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
	<20261028-pks-odb-files-reload-alternates-v3-4-011ddb64b626@pks.im>
	<CAP8UFD2Os79AwJrFvoPti-AD=v6wDf7BVWy4o9dQxQriFD3FzQ@mail.gmail.com>
	<auG7Ru6MhhXzrVd-@pks.im>
Date: Wed, 28 Oct 2026 09:27:47 -0700
Message-ID: <xmqqjyn1bxj0.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 28, 2026 at 09:59:57AM +0100, Christian Couder wrote:
>> On Wed, Oct 28, 2026 at 8:11 AM Patrick Steinhardt <ps@pks.im> wrote:
>> 
>> > Rename `dirs_paths_icase` to `dir_paths_iscase` to match the naming of
>> 
>> Nit: s/dir_paths_iscase/dir_paths_icase/
>> 
>> Otherwise the whole v3 looks good to me. Thanks.
>
> D'oh. To many s's that tripped me here. I've queued this locally, but
> will refrain from sending a new version just to fix this one commit
> message typo.
>
> Thanks for your review!
>
> Patrick

If you have a single list of less than 7 lines to fix up, I can do so
locally before applying.

Thanks, all.
