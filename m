Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209744;
	b=nDFg7C6Zhn6W2xyxbdS5UMu6Bwo6jXxi9KnEm5bChuQ2PHL6KYfqmTQIn0/q4u/1xonR
	 bmvTJZpLdRNTbVUNjW8/gbYQY6iBiC8nVi+iY2CqFV4/yPojSdzqTFEZBbcc78baIzUvo
	 dXrIsuQYufn3z4+2i6zwRNdJnvAqwCPlqNAHnnZhbJrnTKelMkfiNo2RjsSC8CYkaW67f
	 H7v+0oF9VwCo02TvIuQDGOyowtillrDafYeHLsQaFWlV3yyMeE+pPfM/+JkLGaoino/Hz
	 ryH24AWVE+xOfdfT+UoDWcwI7yh8JSHRZZSOIAhyau7odBQMDrA4u6vU37439F4lTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209744;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kgAtb3fbUW6ctXIsCpzwVv7cjOLa+aE9tBwpohhVOqc=;
	b=P5W7e5Ks/1yZWHcoDMEcKIWyL3f+GYyBrOCdIeIXFjUMNrQ0SRbKPzjD8JTTCKkuAEkA
	 xVpsIKlLYWMSfCJoXNw1iJC0KECrqdgzbtGFI6el7z8qLf7i/Uda/kgHfvtfMJZhZ/KtN
	 AXGyIo8owBGkUt90EJBC8/kSzTMIN3a3CLcpXNAEaD+Ct8Mc2jP6F0NGs7lUSUTFTShf1
	 LyaGw1cajTIYJdJ/NuL5mZoYC3Q5YF2mSOl5h3vUceFIdegfbCZK3ooXokaV5oyofM3gJ
	 8bdU+eSobj0XMZlON7szkuzOIG01XW2XwdVdutDUAcRFYCjiWvypFyeyY9W6EoY6OIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=cRa6kVNb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g23PhYwN;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA6606A32A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 07:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3BA6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=cRa6kVNb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g23PhYwN
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34AB97A0155
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 02:35:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 09 Nov 2026 02:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794209742; x=1794296142; bh=kgAtb3fbUW
	6ctXIsCpzwVv7cjOLa+aE9tBwpohhVOqc=; b=cRa6kVNbvz+UXY0bFB7CePa2Oo
	CiefJdAGuBfZ+SZVvF8V72hX7M8jrLTkekaJVtvOX46zjaYDoGqvwbf1UyQQJT1/
	ftYfOxzwyN8JO0/WqBDrfWm8LMoQSFekNdy2V21so2I7I6mYGENYBZTVynVX6UG4
	16M9lDcLYTPKTGjsjMfkX/B1MWi2rVWddASOAKEQFtmU/j3ICzUdJzG0BmHg//+v
	5SHqEim0Syo7qLc/KjVdxxzVHXJH+sT9VitLFdNkX2kZMX2KcLVYAt4i1EX5OX+9
	F+ojIxqa4ylj4UHXlnMAW01DFUFXSVlWcyPMUO5tLHi+U8x8K3PaB8A3PB9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794209742; x=1794296142; bh=kgAtb3fbUW6ctXIsCpzwVv7cjOLa+aE9tBw
	pohhVOqc=; b=g23PhYwNXIAXg+HMgPtT8/QhAB9BY5bt+1LI5HzZNkcFUeCE9On
	Vj52qoyZfcEjr76XOGnMqO7Zs/RIj0z27mJcNs+oPlILLLj/Hac+vX67DyIFsRGr
	1xE33C4t10xbzNfkm0X4CExaYQilfU5t8PVH0LwCCkokPRayRe2BbI1PQO6KM/Ka
	OwhdetdEPKJRxHkfHO3Lo70XuhGZZMwJH7mUnnSQCoJrIp5esbeOitN4MQQbu2RU
	EtBDNvJjoO1qKOv/5ze8Bu/+BxPd09qUt2du9p5POXfStiLy/Al9lTfb2bg3EU6E
	Aj4Q9d4DrGVuA1EaqZ8JH3rfgCQqC1wlW5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794209742; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mdd4PX89qbbI2F6UjwWtK2h251YW2k6DS9KKarCXVHiUsbu
	nGHzaO2BsihKNrzcMnh3T17xsPwPQoR0tuDOuzCq/dbh7HkEQeCJpFSKdo0SID+2
	ss+Vij3tPNZAMP0I1k50ZX7HF4JjZzmthEDtmd0Ej5/xTKxXxkK/z+sYiTvohfZe
	q3FieBqMbVE0dkpcTESK8XTrbdkIFOfxxXITczSzVgV+fUzWNq/WolJyN+JbA6yG
	A0ow74KN/+hq3/ZkAjdTsIBssyZy32ArM6wx6zfNfhVQE95TBAc/RGYWUkKf/a+c
	7YbxUSK9tnp46ON0LeRDYUsexDZlF0Hj3NbvECg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iIBkDdc88GBZb29CTCTO58x/Zax/7jwijYBSClr7cyU=:vgaqMWMz91Hz0+OE6Ma7WHreOLo+IkkIoBHiKaX6pxU=;
X-ME-Sender: <xms:znfxauZN1se7HcH1Z_x3CkuzDba-E61Dp1mngZkmOIdyHt3GZblw5Q>
    <xme:znfxaoS1cP-h4Cdyt8CS42PZwlUl0XMgRWJuUG_Cua3sBDulSzm7xtcCgtRT85oEB
    cXBHgeV-q3gKFpGdx5_7jo7coETnArL0LJBdyon1xfwnItRvYw8NTg>
X-ME-Received: <xmr:znfxahR01HZcMwhvDUAWuWakoR9BYfqOC3AtxmkgzOTj5I2A4ShTlbviOXJMNatyeBcV9c4>
X-ME-Proxy-Cause: dmFkZTEDVLfwF5QkIsaREYLTlnc0Vfac9fEFHaCK5vYB6GNlx67skqGuYp2RpIAgFxxqJD
    chz1z1D4M/Mek6l+mRTGPz0plSRbVw4f4ndwvlJRYFW4x6bAKakmTRZesyj9Qn96AwYZS1
    Yp4HoKoAwxPqMK4vOYmlfyT+z3YJU+9PiNbVNAjh7yrJMlvlIeF3wD1crJ1T38mBnyvQqf
    Py3586ZlNvso2qnuIWmI54c9XWN6+d3PLAr7S/PqArBUgBYOtG+0PInpmyOMXDl80FtBgI
    qGX6nWxVGwshZserOqX4Xe8jE/o0/zfTFQTwAbHKGDykefudvnGcTSlkTK3lOmw659G+Np
    anD6y0xSlcV+w0Lms88142ZWqRPSRHtVkFu8iHjSSZU/+oXrT3RAh4oStvsAllnIJoAtBi
    z2ti1pc9HGmsP2sskcGffRjkeE2A071SkQKQ7jmTu9+DAb5aJ6vfV/eFIGhVrGX8ThNf/i
    to0bGkJyeX3vjMnZxpze8w3pjw8DmNlo6loC1g75Svj6ETDyYvIUfDcbdhMmqIW108OK1Z
    AXGSQF4o0UUAPjtLYLCglTf/vgGDvnfS8U1+CbfNebDRGHjRpLkq5aEs0g2lRB0oQsDycV
    a+5jeLqboA5XfIx0LHUd10axcFHm+pwS1nLdt5tzm1qtdKcFzT+X3K0ac31Q
X-ME-Proxy: <xmx:znfxasSO0FgGAxkl8W7Rvd_5cGdOK1mzm0clf6ATH0UJ9sVJA7-OKw>
    <xmx:znfxam6e1vp-pAtJ7dhVDHVRTHCIfEMWDwXeqAGADyeHxo4r4uWbRw>
    <xmx:znfxao2iHBUZLd-wjYrqqCPobjqnFjJQ3mlxltah_lVvLbGz8cJlVQ>
    <xmx:znfxahAscS3iL_0SiSOs22aN-kyNJ4WD85iRHqJKMdW1mdtoyO_IUw>
    <xmx:znfxaoUmIoW-IHKFYmLFGWp5kjMXXZjcfUbnSVf7LNRZdgprYiGp1ENZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 02:35:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 608f13cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 07:35:40 +0000 (UTC)
Date: Mon, 9 Nov 2026 08:35:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Joie Joie <soniqjjj@gmail.com>
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [Outreachy] fast-import: Use repo_for_each_pack() for duplicate
 checks
Message-ID: <avF3yR-PYA3_Ih3v@pks.im>
References: <CAH=d44co_ZFA8EJwAoFL4=88ZqWzO65_+GbHDZfjG8amR4cHBw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=d44co_ZFA8EJwAoFL4=88ZqWzO65_+GbHDZfjG8amR4cHBw@mail.gmail.com>

Hi Joie,

On Fri, Nov 06, 2026 at 06:44:49PM +0100, Joie Joie wrote:
> Hi Patrick,
> 
> I was looking through `fast-import.c` and noticed that both
> `store_object()` and `stream_blob()` still loop through `files->dirs`
> to check whether an object is already in a pack.
> 
> I saw that Git already has `repo_for_each_pack()`, which is used in
> places like `count-objects.c` and `pack-objects.c`.
> 
> Would it be worth using that iterator in these two places instead? The
> idea would be to avoid accessing the files backend directly while
> keeping the current packed-object lookup and duplicate-handling
> behavior unchanged.

No. `repo_for_each_pack()` was introduced as a helper function to make
the migration towards pluggable object databases a bit easier. But it is
ultimately still flawed, as it assumes that the backend uses packfiles
in the first place. So the goal is rather to eventually get rid of this
macro altogether in favor of higher-level interfaces that can be
implemented by arbitrary backends.

For git-fast-import(1) this will be done by making use of transactions,
and Karthik has already started taking a look at it, so I've Cc'd him.
For other subsystems we'll need to investigate how to do it properly.

Thanks!

Patrick
