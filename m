Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BC93955E1
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662986; cv=none; b=awdXyAQD1qud/EsMDEnfUK6H7nEO2tMk5DO1W66eCv8nnXuOJ2jFBbfQHH/KppAxjPmqxou5K4bxY1pyvRUTlcEoq8P6Qy7cCAo7Gk/ZY+NvS+PzBTsiHeiMbcfuKx+6edMRb1kycN9kUHrSIHRR+/MqluFhhwWAMIdOentO8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662986; c=relaxed/simple;
	bh=NJdDN2Oi6mRe16dCNas9EbxZKi7WYzDWUWZyGA+LigM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhyP5tqAtgZvLMf2QnUSdtWOsxLeEOoG9P+wYJ2zkXtds7p9gGYmOsRRHi1yP6e0njfvy2Sp8r/3eUk8jqoGYMs8Qr6GPOuJu97AmbbpjiJO2+SCka5HpSEzWFi9Kl+T6efIpyPKoxJO5QLE5w3J3ANqhYvDJhLUp+36D/hJwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fAY44wue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZkMWRLvC; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fAY44wue";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZkMWRLvC"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 30E401D00061;
	Fri, 10 Jul 2026 01:56:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 01:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783662983; x=1783749383; bh=VUSBQ1iltz
	rOyfnwI9oBp/0YovYhSSmWiVsYak/0ai8=; b=fAY44wuew09Z/6jwdu86OT+j+u
	gjOfXbIiMn5kuhV8YEuei+iW1/qZodwr781gFK345I85o7tHGntZ4PFiNJ1091F9
	j4NaXWurX4ph2WE8WeImq5W+f7T/c0tNE18RptjD17BR1b6oAz33ECMJ+IHG+Df8
	PaS6IuYxH3Sy8kLq07g6sq7CGwl0cQ19TcP1gYTk1MBLQrunU8K5MWtxM+hGvPyp
	m+dAy1Yil9bDjeopRfnsOi2uUEW/2rY8DOC7TWlH4q1OgsoLEvpTX6BXmRqpuIWH
	GDZVnADJJ/itCCAUPQEWHkQ3ksnGr0TOiYPaLmQ2hzxNTsVAJH7a1Z8/LmQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783662983; x=1783749383; bh=VUSBQ1iltzrOyfnwI9oBp/0YovYhSSmWiVs
	Yak/0ai8=; b=ZkMWRLvCNbecvWoMJwsZWIaGANBCwuCL60ROa24YZn1rWxyen5a
	vHfiF+gUfTODJGo8D94/Meyw25ePHBY56sR4qpSA4SFcViZTAvmQybRFQTmqyEbt
	4Ty/3Q/K9riqPN1hMujqM0gXas9+xhr0iJweMFFRPV6lgO6EFtuazxfQsoV/bRCn
	qPvja8GSOertN1b6frplVfVVzQAVUNV+ektKVTq5A2muGK34XTUU2ioIn2y/q+Cu
	dOObNbc8nv9OL3GU/ZUjAPqgk7W0dbYmfihBpA8Zhmfa/Ts471bm1RwOhRVnbAFy
	LXVVnMZYIRrump4D6XW9ACv7IGqUS46ge6A==
X-ME-Sender: <xms:holQapYSKuj3i4c9ydh-cK8Wii7epX13Xa19T7U17m75ACLKuMGZ0Q>
    <xme:holQamZNeLVMYMI0wsd-CXuuwJy3u5Tpi25wvchKiY3BE1ZidXLx3dqiVhrPj0N8r
    7hZ_z2VG-Qs-SdhYodXDzvfd8t0fhps-k3LfGsZmktC0UD5wCbkl1Y>
X-ME-Received: <xmr:holQapmOE1zKdpIBAdzXasQzuepsspbbm29lm6zKqfHniNAnVWVGTkeblGU-1NS5WN1KGcFWzqQFD5jLZwaeUN1x5KAOUdjIOTAggkXzI8JHBw>
X-ME-Proxy-Cause: dmFkZTGsuSumlaRbLt1NKZEncBVHK6OvNOzss8yQC5eQUOT12fkpiW7RChU1FBNujW0zTj
    VCOGBPsKb2AkNxvbua4ZJfqEdn1Bpchh73ufdGrX3gTdhKJIXqvUYQDKJn9iiwj/CR8WMs
    uriU4wxLuuAcrO0r8K8/Dy+fF8a4wy1ZOfB8/hsNJm+HgmNAR6bJSxmjAabPbkdAV99PhF
    XurOFlJrAQLqizYseYyh7cHiUbIrD5DnczNOW8SkEAPqdHj3LfnGi6JLCzfeP/BA2DnNjR
    QJmIR4nMiwSku8tpi3xW3HzN0glU18+a5S3MeyAdDOD3kc5V1g7ukptrnPemkB9F/toEpA
    JCVSBvWIlYqzHJRAphpJ4YKzsPfw7+DSod1fE6/kjagCv/KyREJvOjrD85EczxyIcDRaB/
    +JjCnC4ttujW/f2vf1F1tT5ZQ0RM/UZl1R0hQuzSEFXbhWJtlcFVdffvkPS7t0XjsDHfud
    LV7mMpyagrRonFa7MSxk9VeO5BHel9wPtC2Y82dllNrstao1PvGgptk2ThTI3twrHM6460
    VKBHnW8Q/D1yMLywLiFX2FZqMEkfegeN4LS+hqN1xNQDNANGdEJiUDo91+A2O/ObUFRVMb
    Jj3wKfoz14pZf72tBiqqVDhuQgB45APynS5vO/BQtMi01dMcSbYsdyrkb+gw
X-ME-Proxy: <xmx:holQaix2VxGqMel6JrI5TzjXsRFg2O-yN8Y6MDvEb_vlChLymIqSRw>
    <xmx:h4lQanNWv_gtmGgg5uGOQdhdadUf6nZjf5LRUkYSrjNcIxTW88Td9Q>
    <xmx:h4lQamQMv9p1HSQBIioScwA1aBBpQAxnRJ9Vm8SsMFeNneCafcmLNw>
    <xmx:h4lQalbRPsg_jwjKTtdPWEcboX8QhxJ1EpE_-JLZInRsBUqBnPUp-g>
    <xmx:h4lQaswj2n0Zlm8HltxliOEEB3XebRirhKgrOFrV7nCDjPXkS95sYNgb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 01:56:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33b557fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 05:56:19 +0000 (UTC)
Date: Fri, 10 Jul 2026 07:56:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/7] refs: remove use of `the_repository`
Message-ID: <alCJgLcjXKEgNwFF@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
 <xmqq5x2nlwyg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x2nlwyg.fsf@gitster.g>

On Thu, Jul 09, 2026 at 01:39:03PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
> > 2026-07-06) with ps/refs-writing-subcommands at 002fe677ca
> > (builtin/refs: add "rename" subcommand, 2026-07-06) merged into it.
> > Despite that, there's a small set of conflicts with "seen" that can be
> > merged like this:
> 
> Thanks for a heads-up.
> 
> This seems to break so many tests when merged to either 'jch' or
> 'seen', even though all of them pass standalone.  I did not have
> time to figure out what interactions with which other topic are
> causing the breakages.

Oh, interesting. I'll investigate what other topic this has interactions
with. Thanks!

Patrick
