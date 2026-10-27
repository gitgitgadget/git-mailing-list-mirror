Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116934;
	b=qieDTABjZBDOEbFwIJnEuNFM0w/1h5PTrejIfJ/6j0w/EQLi4hgNBkT9WoVKGqxcSfZb
	 AaOV24WDBtfMwiuJaYej6vWgYoLrZ0sqe8eiTbd95ryHxxLm3pSAeHr6Zwp8Gt6jwCA5S
	 YeatqQo1xHWC+c+d6osy9j00qT1afQo8LeH9GZzQXoSSt1fF6+M/xF9fUp8tJlN9yvI6j
	 M0LdliTebRC2BvT0S1HzVaNa4AVS0tEYy7mKqjBqTn3gogr0VvVNkMMluxZsFcBI5vILh
	 C6tST8H/ppEyJZ81ucxSXz9tIq5nLb7pCHDpnPCWBI6c0mdcQDvcHXMK8VsG5r5AMcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116934;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-ID:In-Reply-To:Subject:Cc:From:References:To:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SHF0OUIBnmclkHpAFOrmGSXXh/3raUtF240iTPWximM=;
	b=hYQXVjLkBULkzuaGdoJbScTgt5ATQW1AIW4yeX0Jsaoab5EwpDwaTIVGqxvZE1xicAbG
	 UXDFBpap+oyZwCV6ekRydhfzBZJnRW7mQ/rEvrUbceMOk2AfwZazZ+pjnpjBSANC+JsjB
	 RquHwbHNLBgXmG2t8ybhR5zVb7az530ABTXL93fgzG4n9EV/R752Rw2dp5keCIiikSlxE
	 Lakh/VptnCmUSneFg59l6sjbED6b+Jr49ml0q90tmaKfkUEK+FykKvWdB5Wz7GLeMHQwn
	 wb9tl4eum+ob/tn8dtJv/Wsa3UzjGXMnzAed3OllVCiDZr+HjXhh6VtLkvPiB79VyRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=FdctLD7c;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y3pfdNMa;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DE606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B83DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=FdctLD7c;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y3pfdNMa
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5CD614000F0
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:02:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 12:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793116932;
	 x=1793203332; bh=SHF0OUIBnmclkHpAFOrmGSXXh/3raUtF240iTPWximM=; b=
	FdctLD7cVfqpEQNv6hGzJWaeM2ia5Z8ja7AEC7pERxock5exknWnOXtRjaqmj4kS
	zMooHv/tj3hnIDf3S/5taV+LQ7YTw4zeHSvwBZiZw5ohvidT8E6yTUKp8oA6U3+I
	I2VorNo2RJrb19geVam2VzPm5gulyAQJSs/Nc9SKjj5pP3iTbkv1XoiArXfF85b6
	MkPYcuhzvYm4dVlw73qcXhkyhG/89KH82p54ekI0GUtCng+j43EJXdjcwMffcSF8
	N2PDjcXa5r4TcAUhJZvfNlBp3FXw8KgvqPLmYZ01cGoVjXV85QJxg6iXtMa5YnDL
	XHmpcHw3+hyzsZ2UihafOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793116932; x=
	1793203332; bh=SHF0OUIBnmclkHpAFOrmGSXXh/3raUtF240iTPWximM=; b=Y
	3pfdNMaYfMI1RboEJpMVEijiaiD6RodagETrYPgqaoQxGPYE7oJ95j++EV/wgUJo
	6DzcId84dyE1wVrLg5wBKMi44lfIq4Hh1bmJlATLusHFcX3AsPuIE0+CmFZq9VRB
	2VKdCRtcvlfxxu3JfHeBypOVt39sIcMC8SMD32ZTMgPPTZS9SW7qt3bL8HjxcKrt
	diJR01pU1uaWM4LafBfrpa44uV5aguDF1a6+dKoTufz8Nkw06qzyKgpoYn8GHUbj
	pWv/JdqZDXjRZkg2ykP7e+N90TMlTN8DlG+pIBuu4q97EuZ5woLpqfq29+O6oOgh
	rgm/CylFnh3JjtPFG8DEA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793116932; d=fastmail.com;
	mf=PG1hcmtjaHVjYXJyb2xsQGZhc3RtYWlsLmNvbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:aTz4uTyh0pHKn0jsMvxQ88AOKPYVVIqcPOJMMmmDZbBJpkz
	EL2Wu77fArtJeTeCOC3F7Qmiib6JizwWKa0wAg2JBQQkTJAoqQwtF6zlPEjanajm
	qw2RBOUuHjQggozT1+1p8A4Uh9GIQzaAi5QO+FmuBfpRXAhom1NABw4K5jWM5ziP
	ON6wkDgPgQphDKHK4OMuxB/XrCbDjVrwITPBNsa7HD/75JsrrEYOnQZkf5C1VaX3
	1KfEb2w0fj+FL8R6sV7JMztlbXvEtjlTf3NUbKmf/DeYd1yZ1EWC5hCIbqbIdKA8
	l+HH2onRXZg0j+pFanuVYf7/k5QwjtHGCmZnzyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:iB0YdRac2JafMnnTW/x+bRm/z4ydXMd63DCVTvu5ZYo=:G+6teiGTmX+ZX3HdmTLXyfu91nAW1rVrb94Sg+gpWk4=;
X-ME-Sender: <xms:BMvgas1_JuctDv595D9_9IBKryjGrdQy5q7ljAvcVcQN6N4vn2fWHw>
    <xme:BMvgauiPBEtPjHwKb6SZjgGO_3nd9AJqYgTyv0wPiE7iGbfSD3wPiNwaJR549xzex
    AAgqippuKSeqtWjixDeiRBW2A_51XKynLckdYRGmv-dTmAqEfPSl5M>
X-ME-Received: <xmr:BMvgaiS-mRhfjX1UoKx36t77KK8l5U7_MUrGQHfaNUDp4JUF11sFLX-ADEwrj_OH1WbxD6QAszRbJcjgEs21-g>
X-ME-Proxy-Cause: dmFkZTE8yc0l18LqkraF+uve4cHTnMnssiTdugUuDBbuizwBSRPwQgFieVBlO35aN+lsm1
    guuJyR6H0ioPqGnjACGuDdlPCqSglgVtTUDN5RpCOmUZITxFV6k1aP9YPeufZf7sPShCvl
    3G4BLGD0GiGgw75iilMYA38adRu+omyRS8nBgeRHhhXgBGHNQ2LuoY3Q/ykPeXZNZiV7m7
    ZB0hcKxGNPbgN/HIsiCW9ZRTXFNY1FnvVG1e5KPSNXI0YZKTfWTv7gD4zMPeaULiJmfT+J
    42ZYPJachBymi3qtlnXF5XcQr2cHDkohcXwdPwSFjv9cgFyRaGzSmVQtuv1b+blTFixnf8
    qWxb0ZmKc0UCNXIS5nshU8gsPSHF1pQFSlaH+6ZgZ+oQ+KVxzfFzhrccdJbgAhSvglRgjv
    wflTLKUIAxpREMl7ZeEfnnZnqhBuLLFYQAmTAB5bZRixKS7yfe+Djcc/HOY+PSC0ABuWxa
    2WE8hxkVtYT3u8m9NjY+9QXKukbnuAVsz5Fa1ftFCenDqMg/LPeV7mlHIMnpQk2eKGbJqd
    vz3sO7aC5y0UURwXbKHDiG3U6AiBd8fu36s4z/aAPNjxXBSOYKIG3mm60R6+t7frGFKQUv
    sc1/DrOJDJgSmyKnmRV0Cpt67bb+zyLyYi2MrKFfRm9MDWM9+cwIK0f8B/+w
X-ME-Proxy: <xmx:BMvgavjQRASt6L-EmNs6oAR7bx-3eB5JMoI8MttQsqGLP8FXaFhdJw>
    <xmx:BMvgai5FDcRAS4m_labQK_JYEUT1ipQ4fSIDJ3wG_PJWC-bTkIUbCA>
    <xmx:BMvgasBJxxo0unsnZPFpMBZuh9Wnefc1bD2lZm-Ny7G7JOgto6S_YA>
    <xmx:BMvgapbw711wNqrT_fgVOWBGai_5wBucuytc-DpflslizgMvSnWRsg>
    <xmx:BMvgaigspgkbmsS6b8QhSm-3LVgmz9oZ7skkW0_HRKDijyOw2D-dFwsB>
Feedback-ID: id2564aa6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 12:02:11 -0400 (EDT)
Date: Tue, 27 Oct 2026 12:02:11 -0400
Message-ID: <03704f3590183aadc16d5d81bdc64e9a@fastmail.com>
In-Reply-To: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
Subject: Re: [PATCH] pack-objects: handle missing objects kkkjwhen excluding promisor objects
Cc: Daniel Zoghalchali <daniel@latchkey.dev>
From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
References: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
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


On Tue, 27 Oct 2026 08:00:28 +0100, Patrick Steinhardt <ps@pks.im> wrote:
> In a partial clone Git tries to maintain two different sets of objects:
> promisor objects should be those that we have received from the remote,
> and any such object may not be fully connected. Locally created objects
> on the other hand should be stored as non-promisor objects. The goal is
> that promisor objects should never reference non-promisor objects as the
> "promisor" property is contagious, where a promisor implicitly means
> that any of its referenced objects are promisor objects, too.

Wordsmithing nitpick: this reads awkwardly. You start by saying there 
are two different kinds of things, and then introduce one of them,
followed by a comma, followed by something which _isn't_ the second 
type of thing.

Maybe:
In a partial clone, Git tries to maintain two different sets of objects:
promisor objects (which are those we have recieved from a remote, and may 
not be fully connected), and non-promisor objects (including any locally
created objects). The goal is that .... 




