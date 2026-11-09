Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255465;
	b=JYLrKRy83okKkfJiFvjEzcyvOqOR7Rsolo8L5ZJZDkWQej87FNAUinbg6SQ6c0btAE4+
	 cxmgN7YJJKhkWf8+b2AeHoVNKVkcLxgOMPCLyKmSi7aaxKURdno3BGonbzX6XN6eziiEE
	 BgJo+o4JQ3ddIrSWS0TP7SvRQnEdNhfn/dNv1+Ob3xT6roZkVt/rKDB5qGSVMo1jiHZVV
	 qR/OESFleCKQ9Hg86RCr6b8iu5bEjkSutrBvcW3pVeriaDkrFJ16GZ0x+u8yIznnLPN3r
	 qNqV2DLhXvzbgFp48/9zpq8EEIA4x/njFRuVQ0d/qvpFZPBFOi90hozX223aG4rFNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255465;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=WrY1wXw694MdVeSk9Vh+Xaq6swC4kIavKhtM0pmo9cA=;
	b=N+3lrV+EPRk802+TjuOqVVsaUrN59ajAj51P99pD6sG5b8KxlEqvKi7C/VfU8pNMLOft
	 rD+OLuld6AMR49aVR+Pm0Zfjtt9r3Kd2Kwl9fMBXDKey5v7cb2e5pMO0JkGrShVn90W7K
	 ZYPS79qWmycIPgt1Ule1kvb2BV0aQEyQAQCbSjJPiYcsqu1htBBxqB4ix/j+7+gxLUKl7
	 9kttuxAasOcJTnfA86x2zg+aN2p9tgVmAZDzs1XkoYg8InhPJbKSGDqxq2UWBCW1jDfzI
	 uK3DDj4AEC0EsqefzAyM8p++vuKxjU5KFJcup+VrBc9XMyoh42dKcHBruseOM/B98BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bdLx5Yzb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ixO71Unk;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6B0606A334
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F6B0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bdLx5Yzb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ixO71Unk
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9C5BB14001A8
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:17:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 15:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794255464; x=1794341864; bh=WrY1wXw694
	MdVeSk9Vh+Xaq6swC4kIavKhtM0pmo9cA=; b=bdLx5YzbDu+kGutq9+cmNGSoAT
	1/XB2iZDc41rjZ61wUlPQ1g5Yioi22qwSaM71Ab4Hh6ShaXY3yCufCTeRzD7u6IP
	dUf1SEIwehbkClnP+RfXCaydToy6LRf7Fw7Xc1rxhnl4TFSM0ZfsU5lffnijGgl/
	+rvAj2ATNjacBgoybGKURr+VIQELwafJ2UXhlIAegem87CIZmLlkUaRsicOx0rpc
	bsieWgPZcDn6mzY9tYxcdzkWvZl1ORmMAIDpqNvrljXYwYYD8twgUYAkOGHQHLr8
	9OAJdYt0IYPNOGUM9u8vNhZmJ2F16W813S0jW5hjPxCz2Uwna3hQr+/gHK/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794255464; x=1794341864; bh=WrY1wXw694MdVeSk9Vh+Xaq6swC4kIavKht
	M0pmo9cA=; b=ixO71Unk3gUukHuhOVtUKNmJOjEOTv9uUnDrhfKuu0gf8oVmEZB
	6WBNiQsGP4j/tbCzawKmnU7IZxU6CMLojWKcuve+SDMfFAJ2WrJmIa/LGtLgvT2P
	iIuIGA50r+SXVDHTo59D1aK/pphJVERPqET9qqIjgt9EpF9e/7xPYRog61kJVrW4
	TLKv/QaLbrbHGQE+vuApd/xt3tnV3hLXnkFqXQumD6L4pOMa1v75GJGufvjk88u7
	W29BGL3PiWYaYoF/Xp85+zlcTlNMuurmlSUO4c4SwFuhzvRulUUVPJEt2VqLqcOc
	dfXFsSssWNzZhKQHYfvlbYBvEJdSgaqjYkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794255464; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:D9l6dCjwCBeaV9UQA7eFB10kNxegR1mwc+m6EcQFgfB1NYm
	ZyU12xhV7+cSMaKM9BX/csyJr3kF3e23cDV/kfGSUePNN3jZLmMQeidebkJwfQeH
	s4Do7MFhsWp7971/ol3NEmaMhtae+TpDa6IG9jbVMKXuEfHOVCsrFBnbB110tDBE
	AQRKwZfsD90ZTmmzRQGag9L5Y5Ku8GOSwNRCVdVFKM7+srNig1URJKs8+sl4RvGC
	EzvPzCv45i8VdogJdjftYX3eq69EmNvHkk3VRD5PkKD3R+f+iYNEnc44sSpm6Ks0
	3pw+r/pSf1+wnnnAbZ7guzvQ/heIml7BKnnnHDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vDIsABzzMoCAzcLycQomL7dX4NnGJ8fXxHTtt57AbdE=:CuwnGsQWgsbEf2JltIiuoNYoSt9nDdYOj8QAKPkznRg=;
X-ME-Sender: <xms:ZyryaoYS2WDP-8EYTOTXO5gSG_qzqO_yuQd_UmRcl7-MA3_zyWk0Gg>
    <xme:ZyryatZkgv9BPg0IhZvhXd6pmNjQlo0gGrZHZtfHLlQIdoxc1la2JVAt9Wu5VmEq9
    66AZoC36d12JtZMvMQOVH-OVhD7US7HG-rTovKLUg9DZw_JbI91YKE>
X-ME-Received: <xmr:ZyryapnBo6LTeERkh8lRMKQKKUOzkI-qv3uGm-7c_WJN5eNNp7ZOx-AAEjlWqGtLFKae40Y3GoUtGhrIxfWZtPnXbW6PnfCdnqtJ>
X-ME-Proxy-Cause: dmFkZTE6K3ALbEJ4ABE5E0NXPSHYx4ye2C6LsQQD40iUnGvR4S3JYez9xQNmAF5cGFwpmJ
    qbO9IcDmrSezTDH56U+rBS9MH5Quld001Rdt5G3ubnMuq+klxnPczB9SXTcw5xdFzlMCPi
    f775fCT6eVAZaZKjpc30OBOnQNyYnm1sS8BkIDqLP43J2IHOLnDYmQ145qrPjd93ZQJR1p
    RsgVzGhFQzbocFaUB1FicB1lWt4WRla0kQnlrAzduZAcwsLNtfb6u8dx7g9YxGYOv+gEQt
    j66GOYttY8vehmbVRPhkBTOiAAZX93Jjd/KiIrYt/svFjiJXRvsd3ZUPvtdlkaggDjMUuG
    /Vv733zj8VjQtYc06rnu2OEwMVmJeKhuLKURD+LbxYm4oN8maWpYjeWlNoidPj5hykXubp
    cZevKB0JBUBX/qqqF/ETmWDhEOSVeajs8TxOQWq1MUSEOIvmFnL4uTzHy2yRnIFIp0LIVm
    6vqihni8IfeDxUJGdQN7bRW25+O59OPer4ZNZ/yvmkuYugO92ISQu8JcxAN7ik2KQsf/X7
    gkyKnR5kNNsTyJ6neD7GlZJTO3fHdLz37XzE09Zarqt6AyX5Bh2VrIfR3mB7cM1tsP3lXg
    2XQR+1q3fHCm/yucmnUAzS9Jc4b7WemDWxpelOGWkqTC8RjW7pa4bTM9Lrwg
X-ME-Proxy: <xmx:Zyryag3ibGc85prTCrVmGSaxtBesaWbZrZ_DrJH324W0-pPLiJbqGw>
    <xmx:Zyryah0-MwnXKEI3RrEBrQbzkA7E4cy_0M6AsNCQeiLNJb64LRlJFA>
    <xmx:ZyryaqpgD5BdpIkZzhPvlQYhO05rS4dhAW_6KvdGgtJWvGqJJyPVyA>
    <xmx:Zyryali5Ojf8nHvKR09lgmXpWHLjrCVXr0C4bjEf-fOp6FKEVbVq7g>
    <xmx:aCryaqA-S9gH_-0kM2-WXqGgaNR09ihKY6fsv9ItqxIm1P9c0Qk6KQvU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:17:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Jasper Mayone <me@jaspermayone.com>,
  git@vger.kernel.org,  sunshine@sunshineco.com,
  kristofferhaugsbakk@fastmail.com,  haraldnordgren@gmail.com
Subject: Re: [PATCH v4 2/4] doc: for-each-ref: say how to read
 %(worktreepath) safely
In-Reply-To: <4B1D5AB6-7E40-4633-B804-752257DD0B67@gmail.com> (Ben Knoble's
	message of "Mon, 9 Nov 2026 12:27:49 -0500")
References: <3b97401f-5579-456e-ba62-c7a0fdb88d23@gmail.com>
	<4B1D5AB6-7E40-4633-B804-752257DD0B67@gmail.com>
Date: Mon, 09 Nov 2026 12:17:42 -0800
Message-ID: <xmqqpkwdyd21.fsf@gitster.g>
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

Ben Knoble <ben.knoble@gmail.com> writes:

>>> I was under the impression a branch could not be checked out in
>>> multiple worktrees due to possible races from each worktree performing
>>> updates; or at least, that the porcelain would refuse to create such
>>> worktrees.

Phillip's answer covers everything, but I am not sure if "possible
races" is a good explanation to describe the reason this is
strongly discouraged.

You checkout 'main' in worktree A and worktree B, so their working
tree files and their index files all match what is recorded at the
commit pointed at by 'main'.

You then make changes and commit your changes in worktree A.  The
'main' branch now points at a newly created commit, and the working
tree files and the index in worktree A are in sync with the new
commit (note: unlike the initial state, I am not saying "all match"
in this case, as this commit may have been a partial one.  The
important thing is that from the end-user's perspective who has been
working in worktree A, things are consistent without any unexpected
change).

In the meantime, if worktree B weren't doing anything, its index and
the working tree files have not changed since the beginning.  Yet
because 'main' (hence HEAD) moved, "git status" in worktree B
reports as if it reverted the change made in the updated 'main'.

That would be a grave confusion, and that is what we want to avoid
by forbidding a single branch from being checked out in multiple
worktrees.  But given that worktree B was doing absolutely nothing
while worktree A was doing its own thing, I would not call this a
"race".  It is something else.

Thanks.
