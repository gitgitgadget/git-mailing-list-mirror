Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729661;
	b=18geQYvlegvud/XFxndYwi4miXAeHn6xp5so25JhKiI5k4Zp+FszM+yVYS7PzlAItSpt
	 A8cOUt90L1BpIGY43VML/HkaS/hHv8h++MRm+5ejpDEVKXGSFzZunWrTq55GL6CxOe6k0
	 fnpWrtkAPoS3C4B1HO+MxaK3TDeFXbk/EjmPKd9TW0zxKUMfblm4NfHY2ql9bQoLEdZEt
	 LsPyxKuYElG/E5B5o/51WPhdVJE7Rx3MBnn0g5pf8rIxHbcOUTT5iegQR6E1zKHxuVC1D
	 n+j6vCQqRSxjk1emX3V2EJm6ZVs6NHfWjTEO/kawgjLMNawoxQI7ohHjHaSZV0ID3Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729661;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2IMqvDSSzB0sp0Ufrl7GA9FJRdrXGpbFm9Bqvr074Nw=;
	b=ZQcfUkPuHZT/vVOrvme0sT1kCO94/3gYDopY3qDEVTIYTUuEqnmLLNml5lKli0vvS4Pp
	 XqM0CwqJ+hpnTKu3PleuEo8XoH093VkhREAhiRl1r80QfzwHbI6eA1rDy4heFkwJToH5Z
	 rAc+WtSgLdadhR8fTzB0ElCLi0JDu8Gtngnep3TlQ8iU+jq+h4G9diT4Af2WdE1GEJtcE
	 E0uV+WzBeBwpnQHjnFQwyRcKn76KZEPa24YKdUQQSAtr+PWBtJBNhm0g/KYZHWd+i1d/R
	 kSJN1LyoMR0YxrGeMb8rU+bGg9IIEgvV1DYqQv4hejoYEHvYl6bAstP2FCKw+QlxexA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fEFtshOR;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D+IRjKMF;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08252606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 21:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08252606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fEFtshOR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D+IRjKMF
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 30E3D1D003B7
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 16:47:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 26 Nov 2026 16:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795729659; x=1795816059; bh=2IMqvDSSzB
	0sp0Ufrl7GA9FJRdrXGpbFm9Bqvr074Nw=; b=fEFtshORINobvJ/T+SKZRuHYID
	WyjbSpZW377rC78/AbH3Vh9Qh0wDG0o1Dgo9VYiM6s44rJBY2gc/MvLa1Iaknkx8
	3s5SO+sZrfEgDiq0Dpenu8icsH04ORqt7gPbX9JiUL1MLfhuS8LtwLny68MxFW45
	j0KundlySwJxe2upz5cD1PyqwRK3wvEAxoyS+mtkExsScBc40i5OlJ3dwxJfPN5b
	TqFG0D96cVxdF28ccuNz8XmIanMGtSz975opYa+kqixGz50y8x63IdvVF4n+jOPn
	eawv2YfLXb67YsRartEeF5UVZhTlq7+ReYdAg2Q1q2H3rgb5QR7Zh/JJVPEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795729659; x=1795816059; bh=2IMqvDSSzB0sp0Ufrl7GA9FJRdrXGpbFm9B
	qvr074Nw=; b=D+IRjKMF3XsXT/YZ1mf1yv733o1+nDqnaHwTBChGTXP8uAZDJS7
	hGrERIQZ+mhFQTCzd2C+/vIO9mmSW614oobw25/kaQyBkYg6VNkf5MGckiv+0F+O
	CGsrQAiMZMPubEKdrtnJ7OO7fZYyWUbHvBYz2Ef3ZecbxpAU13A+7bNZbL6+Slfg
	V9+6V7Qqw9ZXEzf4aWlTPzn66SGxMyIqfnnmBmLmuPtc63vw9w4brMVGZ+mFz5K0
	Iv81/r8KgBPBwqv6v/UZaLe3NLX/z/QKtMidU4a/wYflEypVhcUpyX1G3XdN4jT8
	q+1SMHoGPWwCDC9AZjuteqhFE2LiU2l1zMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795729659; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QecE/QFtI0Gs+5HF3E7gq/ntmrbt++4AhwPIn+ODT3uIDpB
	tiRLkOpFJVd9DFnFJ5iLQv9QpiRoL2ZiHVy4un0iFSagueTA8t/Iuvsygkt0QY7x
	6gKHY8kYROH43Q3t3dye2kky05PwWO8pZIaLtcpyLD9FIyZi/GBb8iHDSnxhT7Td
	R02h5ocmNjbQOS3Uz+kZsOWfNKgdA46AvEORa+m/fuDExgKGjTwIv87/rvGHE+Vl
	QXc4L27CdRhkKwztLQaRGCtIt3Eo1MFTjJHBLyEMVXMN0tJN60i5rqYbRDB6Nwa4
	ydP/omCZ3ifvSalrbYQCY6K46V4BaQ0/ZLW/I9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:9qkjwndiZn74kTdPIjH46vfJoio0vkNZzo51pwfS6qQ=:x2WiEdU9XQO8DXRZ5eOrCcKCKubppTxqCt6tyHFP8xs=;
X-ME-Sender: <xms:-6gIayHW1Wrtoj0fjQkspMTefCXlXkE2yLvbJuZfbLl5xvdcrzxh1g>
    <xme:-6gIaybNQi7BpUUOn-FCuXKcIDXOYsQO1K1ZaaDp_VMoGT2tQ3EjWTJO8Fj83-igW
    M1QJajqPS5HPah_FHF766E94N4yeQI0xTQ5b8AA1V0ZeodrPGIj0ck>
X-ME-Received: <xmr:-6gIayU7Vl2XqTjkbGEkWDRSJ77VkO9AzhsqUtUF4qknRKX1Qm3btLmFsMGBe_RoZGMVZORIVLzuVaSYRvnE023D2wciNFxNxJ9qGWc>
X-ME-Proxy-Cause: dmFkZTFz/3/Vrso4ZvZ1RihPw8H8WX1+961K6oep+5hmEFGnta8MorJZ7taj62SgnyuYfB
    AnJdVwevM/an+OgKd1+K2XXYy2VRacxc+ok6ZjUl9ofUOJEt3nul5e2FrxDvfZM8jqIs7S
    4OLls22Ao2qVsn8tm0FA4wQukTK8PmRWlRixjFG4J3R+9s2jzB4XmnhiV6aLcCY9NlKBm1
    I4GtsF2IJDwO8/aXTvsvLptudkN7XmVNI77Tn5J3uV+8cVcvNydqix7Ug2N+X2+ABA+QBc
    6M8Np2lA9Cfy3EZ2wM3PvIyP9+2WPkC3mJuYdRsYiooMYuIn4hWoCPsge0TKC8EPS1x0Hq
    czcIwLTA+Fl/sHeS79yond5x/3iZ44CkPis75f3lScepNxZgMZ8yQVGuFUuUNtuPI8i/C7
    iJG6/U7mhu3bDWf8n/y2NYjOT/+5PzR7RXIF4XV5ghqO+qessZ9ytYMeNMTXBTn/KUaeTh
    HbY788F/liEk6iDgeXm42Q9RCp0diefjsKujvAa9cuvFvjOX5H4r8yYQVe1iz6bm822yjj
    gzjrUG/VIYqDlgwnPyJ9QfPB/wqKifXYVd78A1M16Dq30TJE56EW8dIvu1sj5iy0LEaHtW
    3ZttiR1PNhKa9mMg0+FCdXaKo0i8E8F+2LRvu05TyvNxQSS2YkoIk7Hm+eSA
X-ME-Proxy: <xmx:-6gIa4mK30cPV_SB28ylOIIvWmbKgqlLKBouWieYh6ahV5K-YwT0zw>
    <xmx:-6gIa9CgLx2VSSG7IfByz9_QduQuLIZSdSYtUL4dnW83TpwepbKAaQ>
    <xmx:-6gIa3hWOrhT--d9nlBZcPSbVarP4fQ8qfHRWkRVQVzit_2817N22w>
    <xmx:-6gIa6zx6SNPt4n0h7eda_SoLA19N8cmtIqwKXkpkyzRiYhZ7iawzQ>
    <xmx:-6gIa43-RtdOcCP6afiTK53G7KcbCOwWAURxqvipi7mY6QS0ud4vdX1E>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 16:47:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/13] builtin: populate pack index v3 fields when
 indexing
In-Reply-To: <20261023072559.3204273-8-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 23 Oct 2026 09:25:52 +0200")
References: <20261023072559.3204273-1-christian.couder@gmail.com>
	<20261023072559.3204273-8-christian.couder@gmail.com>
Date: Thu, 26 Nov 2026 13:47:38 -0800
Message-ID: <xmqq1p87i7t1.fsf@gitster.g>
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

Christian Couder <christian.couder@gmail.com> writes:

> Right now, we have support for writing pack index v3.  However, we need
> to populate the compatibility object ID in order to write it into the
> repository.  Let's do so by converting the objects from SHA-256 to SHA-1
> as part of our indexing process.

Small wording note.  The code handles both hash_algo-to-compat_hash_algo
directions symmetrically, not only SHA-256 to SHA-1.

> @@ -483,8 +493,15 @@ static void *unpack_entry_data(off_t offset, size_t size,
>  		hdrlen = format_object_header(hdr, sizeof(hdr), type, size);
>  		git_hash_init(&c, the_hash_algo);
>  		git_hash_update(&c, hdr, hdrlen);
> -	} else
> +		if (compat && compat_oid) {
> +			git_hash_init(&c_compat, compat);

Doesn't this regress indexing using v2, though?

Here in unpack_entry_data() (called with &obj->idx.compat_oid from
parse_pack_objects()), and similarly in resolve_delta() when checking
'if (the_repository->compat_hash_algo)', the conversion runs even when
opts.version < 3.  Because index-pack cannot yet convert commits or
trees whose referenced objects appear later in the pack, running an
ordinary 'git index-pack' writing a v2 index in a compat repository will
now fail on packs that previously succeeded, even though '.compat_oid'
is discarded for v2.  Gating compat calculation on 'opts.version >= 3'
(for example, passing NULL for compat_oid from parse_pack_objects() when
opts.version < 3, and checking opts.version >= 3 in resolve_delta())
would avoid regressing v2 indexing.

> @@ -514,13 +533,43 @@ static void *unpack_entry_data(off_t offset, size_t size,
> ...
> +			repo_unlock();
> +			if (ret < 0)
> +				bad_object(offset, _("could not convert object"));
> +			hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
> +					   type_name(type),(uintmax_t)outbuf.len) + 1;

A space is missing after a comma, but earlier in unpack_entry_data() we
already use format_object_header(), which avoids spelling out the
xsnprintf() format string.  Should this code do the same?

When running 'git index-pack --stdin --fix-thin --index-version=3',
fix_unresolved_deltas() would append local base objects via
append_obj_to_pack(), and that helper only populates obj->idx.oid:

    obj = &objects[nr_objects++];
    ...
    oidcpy(&obj->idx.oid, oid);

but not the .compat_oid member.

Leaving obj->idx.compat_oid zero-initialized writes null OIDs into the
v3 index for every appended local base, and with '--strict' two or more
appended bases collide as duplicate zero OIDs in write_idx_file(), no?

Looking up the local base's compat OID with repo_oid_to_algop() (and
recording it in the in-memory OID map so subsequent deltas against that
base can convert) may close this gap, but I am not sure.

> @@ -1847,6 +1850,9 @@ static struct object_entry *create_object_entry(const struct object_id *oid,
>  
>  	entry = packlist_alloc(&to_pack, oid);
>  	entry->hash = hash;
> +	if (repo_oid_to_algop(the_repository, &entry->idx.oid,
> +			      the_repository->compat_hash_algo, &entry->idx.compat_oid) < 0)
> +		die(_("can't map object %s while writing pack"), oid_to_hex(oid));

In builtin/pack-objects.c:create_object_entry(), this unconditionally
looks up compat OIDs and dies on failure even when pack_to_stdout is set
(in other words, no '.idx' file is written), pack_idx_opts.version < 3,
or 'exclude' is non-zero (for preferred_base objects that are never
written to the pack or index).

In a compat repository where an object still lacks a mapping (such as a
v2 pack without loose-object-idx, or a thin pack sent over stdout), 'git
pack-objects --stdout' or v2 repacks will die unnecessarily.  Limiting
this lookup to 'the_repository->compat_hash_algo && !pack_to_stdout &&
pack_idx_opts.version >= 3 && !exclude' may avoid that failure, but I am
not sure if that is sufficient.

Thanks.
