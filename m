Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628547;
	b=elvGQNRHsmg765VXTknZvT6ltyPtKiEUNNgnpVmGWpD3X5l7Dw059wBAw7f6/D7yYUyo
	 t0yv9xOyioiwKbSiT0Fw+IEVyr8hwRdyIIjWcftlp3Z92sri9v0iZNINCYBiu1wmS1Piu
	 ot4QTmLvDNhrPF1ZeEF9PlXHOf6+FdRejlp3OZcki+8QC/HhQyy+nu7GtbbcSMMgJe2Kz
	 Q1dyfy6yPvyQf5w7D/ARiAzeNkPAJ+Bmd+G5WAc3zXlA756UHMwgJ/j7xqfbo2i/h7sWw
	 B4s3byTrY47G8K9L6J0o6lHnjTKLOTMf+dCp8pMDuPt3FLfLS/PuKVbSWPLfke8XXcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628547;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=szG35YM75gGGwXDhBsNJNkwqkDyffp+hoqHFihqpVP8=;
	b=VzL9w4fsaVv6p9iMsJkmjJ8HarDVDAAIhnWwpVfH5ZexJnqnkTwSyhPwf+P6CAZuGtEM
	 CkeTQD06/mRKwI3ms/X2KnZJQdNviDUbqTsHZiiG/8slZR/jnqAAANdRQygxaRDCBZ18u
	 S1XprFadB94L5cQu4ZyGK6GgfGxUNFg9B34HodI4OXuIamSqLwo2+WzftKLS0GxjBJXmm
	 uz8blJQWHJEyd+H0iO/ck9ShOO8xzwYlwKZI9ByD0kMZUO8d9NFMTb0mvJyYPyMwRafO5
	 7lPr84cYOMvJk97Q7BjJLNqclZABlZJSIJPqbR4r5Yd8b0s625DvikBwtihiypNV7SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IesYRgER;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cujCu0kr;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D01606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 17:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34D01606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=IesYRgER;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=cujCu0kr
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 67DC4EC0BBD
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 12:42:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 25 Nov 2026 12:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795628546;
	 x=1795714946; bh=szG35YM75gGGwXDhBsNJNkwqkDyffp+hoqHFihqpVP8=; b=
	IesYRgERiO7bIbxPGzQqqXt92mKlDoG859k3P1ah+sblhtbBHfLUBo5rDeii9lxw
	pi1mWKKXSYcsfIOIaCw/gXt2sHjDXFVhTdcoHKp6Ggd+YbbJRR4oO4rismL1JvDk
	gBdsMH8bVUK6xUVnOUUnLRxUoe1n4HbgxONTL6KaygKBeLvt2a3hx6h/0kOKK8Pk
	Q4wP5NFL23gwtaqgt7I68aLyH+AIQkpvQZ6Po1R2Uzi/DHulQzOAF0O3xv/o3uRj
	0mCgA1EX14ywyOTKVumYRzf9bxmSIl7XSTlaGH7Jx4kagZY+fdESuYOwWiBcRt+7
	bbqD/F1hnX+Qy6bmzwpGaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795628546; x=
	1795714946; bh=szG35YM75gGGwXDhBsNJNkwqkDyffp+hoqHFihqpVP8=; b=c
	ujCu0krr5Fhk4bEbPuKETIBts1fTmNe5cyoTdSL021ZnHdT1oV+my+KWJE1zMhna
	PDIDUab1IMH76M0uuEkSXljHyVfw9tfb3BzzDGfejcL5mWOcb1YZcNkrq01OWD6C
	cNpDvbRvEdOTmo0eBjb0WWGgCrTaIM0rDFWGZAJ65ktBaGb/iohqBrnos/AG+JGW
	C+bVtKgki6aPmLii/q+loK3iMnTmplxP7rPC2m2cEn3wWZxJ5xUHWoZB3vfsJzIZ
	EoB6lhXJyuk8Ie6x5a5OmmzYXImV7L7Lbdn6kvLwjaJThK07DkqRVPAs6WcxylYA
	gej0n/N3L6BcEmSgBZD6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795628546; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bMEB2h7QlyFwNldMQYpZnBqOROCqIBR8ARKlMFkufoZjkai
	X0EwrkpnFMTNiuXNTBdGcXtU9wxOD/Wf44ScuCGTciR005WI7pVyQi7xOyOfO/bI
	hC5NF9pPm7+uhZnvrgt5EUIKoH0VkWDAigNHR48U3MaApqnc+cdZd6/aYnJGQiWm
	Gt+xLBJLXaXhQE5T6BPr9eY8h6OF94E8CtDhB4llyKSsxZUkbBZ/t+89oqTae0Xo
	OE8KLo7ilSNUYlMXZ/IKX9ofH/sUujzDfu3tN1kqet/EQyxDUTraoMGDqR2b1ghj
	q37dCvEolDkKF47oNmB98p8q+pv2We6hd30msQA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:zVQMaHsGZe008dTVtlz5qV/35iLrT4MV/14dzKEM51k=:dn76l6PCzI0CiplxqT/AUkNmwib71qhQkKnnt+k2fUQ=;
X-ME-Sender: <xms:Ah4Hay_B81WeNac8-PfVHizoRQStSw9UMsul5qXE52qvPgu8wZwIDA>
    <xme:Ah4Ha5lh2owQFPxKG2muF9056E2vJpzQNTgFfbYa0b2NGH-w3z5JBad_ZKCII_k7R
    E0gEZ2TR2nv7DilhV89Vnyw5AZ_phKTJHdZdGKpTOzqW74iy4zy_3k>
X-ME-Received: <xmr:Ah4HawWXyXaWBk-v06vK6Jz0knTWKiNby_nkRILaijl8kgyvQtB42-1iclXM3MTIOQd0mpKn4K9N52Q76p1v6u1qPMBP8ziyYVf4JPE>
X-ME-Proxy-Cause: dmFkZTEiCffW+73lisVRmRFFdQUdTVwIPls8ssJO0U/u9o4lUZHOAyInPAzhyNCLOs70lr
    bMmsunp6L7DNyU49E7KTXmvyLxG67vL5mt3bwF/6Yg8E24qjg1zwzlGLZ46HPkQO+r64/O
    HJMf6qr0YH7yVhgyNraRWAQvVd+U7oC2TfIxCUG9ce14AABNgfj48kypkIvpkU63bFT5/f
    knMEPaSbRzqW89+n42hNIQDF3CqWQS5Q2rQkEpjwbJyaJkQe9Uz8qd900HKHxUtECv7f+l
    nQDCW7vzsKWmPPqjg6U4Ax7e5nbkcyvWW8qJ1F79jMHUGn47uymL9ltk7S97yq1L/urtbj
    LrA8fdhstCgiJyAR0P2bK7QU2kWV3K9s+yvTlZZrtUHIMon57O1SWItYvuT1doR8YB2sl4
    1LgdLwMYatuYdf426bFm1bUy86iE5Rg0Mtm7pFWEfPsN6+4VIENtKMVuy76KQYsrI0wk5c
    PdbR6tM+xQt6UyjaP48Nui0cZUWKjNp5yGuvs+CnQakDwdRR2bcM+CgxcfzbKePQRAjd2D
    itDM+1pcB4poBQyfZGHHqIxZI4QGqHryC994vryqIE+XR058mj6t0bvQoU7NfJy2zAMmqX
    8KTbKSPQF4evsKIIjTHl3MRizx7z9WozRQU+A0ZXE+tZAu/8oItzTs3VNh5w
X-ME-Proxy: <xmx:Ah4Ha2H1wMVulerh4MpMd2dIAGfD9OomNRzmlvkZIgi1OnFMoHtz1g>
    <xmx:Ah4Ha0ddHxi_Pb1-WNl29jCRDalpqGRuGuNZkjmsXPhcBr_gExLYOg>
    <xmx:Ah4Ha_LamAak6xYjNUIQhoeX34RhcZFCAwuTyWM9mXeJDmT_Tmcmbg>
    <xmx:Ah4HaxHtGy3XAnB5BPEYm35QhwZxYjb1IGsO1NaAwH1VK3BXCnmVkg>
    <xmx:Ah4Ha8BtY_3FlNE1xcByABpU5trilJaA3f0WjwVO_B-zBvw8ECZIQsuw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 12:42:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Dominik Maier <dmnk@google.com>,  git@vger.kernel.org,
  dmnk+artist@google.com
Subject: Re: [PATCH v2 1/2] archive-zip: fix prefix stripping for extra and
 virtual files
In-Reply-To: <16fa9275-b2d6-457a-ab30-932c98a52c1a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Wed, 25 Nov 2026 12:39:59 +0100")
References: <20261119192311.2685319-1-dmnk@google.com>
	<cover.1795543448.git.dmnk@google.com>
	<72c0d0c0a43cadcc61f0187c86b9bd9361079a42.1795543448.git.dmnk@google.com>
	<xmqqbj7dhiv8.fsf@gitster.g>
	<16fa9275-b2d6-457a-ab30-932c98a52c1a@web.de>
Date: Wed, 25 Nov 2026 09:42:24 -0800
Message-ID: <xmqqy0ag6c5b.fsf@gitster.g>
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

René Scharfe <l.s.r@web.de> writes:

> On 11/25/26 1:09 AM, Junio C Hamano wrote:
>> Dominik Maier <dmnk@google.com> writes:
>> 
>>> write_zip_entry() unconditionally computes path + args->baselen before
>>> passing path_without_prefix to entry_is_binary(). That matches tracked
>>> tree entries, which always begin with the final --prefix stored in
>>> args->base.
>>>
>>> Extra files added via --add-file use the per-entry prefix recorded when
>>> the option was parsed (info->base), and entries from --add-virtual-file
>>> do not carry --prefix at all. When a later --prefix is longer than the
>>> extra or virtual file's archive path, path + args->baselen steps past
>>> the end of path (and for --add-virtual-file, looks up worktree
>>> gitattributes along an arbitrary virtual path).
>
> Oh, good find and straightforward fix.

Indeed.

> That would help workloads that only ever call userdiff_find_by_path()
> without a path.  "git archive --add-virtual-file=foo:bar $EMPTY_TREE"
> is the only example I can come up with on the spot.  It would also skip
> the sanity checks in attr_check_initl() for those workloads.  Not sure
> if that's a good deal.

I am not sure either.  My point was that the above rewrite to avoid
calling userdiff_find_by_path with path==NULL does not work as a great
optimization (and if the author wanted an optimization, it should not be
done here but in userdiff_find_by_path()).

>> Mutating args->base and args->baselen inside this loop leaves them
>> pointing at the last extra file's prefix (or NULL) when
>> write_archive_entries() returns.  None of the current callers in
>> archive-zip.c, archive-tar.c, or write_archive() inspect them afterward,
>> and extra_file_info_clear() runs only after write_archive() finishes, so
>> this is safe as-is, though saving and restoring them around the loop may
>> avoid surprising any future caller.
> ...
> I wonder if it's time for a struct archive_entry prepared by
> write_archive_entry() to avoid per-entry changes to struct archiver_args
> and pointer arithmetic in the tar and zip handlers.  Out of scope for
> this series, of course.

Yes, but I suspect that it would be a good longer-term direction.

Thanks.
