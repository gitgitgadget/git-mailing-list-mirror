Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294291;
	b=mvw3SipwFoGkOZpAS2ZPB5ttRRPp+3oqYp+14GHhsCxl9YLDismdSXyIN9aCoIThPpkn
	 Hjj8tjn4jdiKllZMyxuiCMLsi30VbhTwjt0PcXX75Zgee/yFdlBviAIhw7ShMdQtI2XYR
	 fcUOmp/66W0LfOa/Rr/RTdGlJXr9tKoMvSlBtppsbFxblu54bdXg8B/yGyxoak6pxRUSE
	 K7ooq0j5AAnVwOsB/OnmD2h7UyF+qMen8gnSamEsQJxAi1gTW0GhCROx1U2zXFk5Ht+jw
	 jf6aBHgkH8Wh2kZutO3ZoE+4QkrkVdsAGtuhIlPchlYV9hfjwibiwokNuXvDiJpRQsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294291;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SbTwCXI6xuesmgVjjVEP3OqKtW0/ezwFcLn09WOAZQI=;
	b=ZkTMX8TE51GSHvA9nT3/weSe3xEssXp47o5KRTgvZl3IswS5f5IgTLiedcd7twhXqL/5
	 mNi8Oh194MZVXf/F9YqHrh91rrdH/NufeSkua3/qXUNYxXI+t63bTm+e9j14Sm5C1ygMG
	 5Ld0Yj3sl0QuzxmsO3fWTGolef1jPQIWEx8a6ZrxwZ1PhIWe7WLsHylzygstrw9YqOcMj
	 9XtUJZR41PBccUdS+RCrFEp/8fSH49g0OCsLyzJa9ulTtDf/nuhBinCnWQA0kDaPYhgqZ
	 znhbA8RUAKpM6xN3Xwv71Cwi3g0DZYp1e482vNZQ40u/l+sq5Yn1eHPcbBcoOM+gZcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=DyxmYBkE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NDr1Sh6r;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C264606A326
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C264606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=DyxmYBkE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NDr1Sh6r
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E0267EC0584
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 02:04:49 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Nov 2026 02:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794294289; x=1794380689; bh=SbTwCXI6xu
	esmgVjjVEP3OqKtW0/ezwFcLn09WOAZQI=; b=DyxmYBkEsgAJVoDLRHZmaakYVo
	b+lmolYeAC1ZPx04xl7sh69ANcEXyVaY0XSCiKlGvZD3qaQrCv3ByoWTMh6MNRgj
	7QpUayHiIYoL6Xen6JTJ9UdCNSUfPI64gEPZgHkB7/L/0ilxNBkEygvQAdHeXQ74
	ohl4YlLGzU1J1sSE157+JX/t6xwrw1TE9QdpHfoMqzEEpeq3c31m4vUUrEvCXoxz
	JvsMCqaThEoAw1EgfATTMGsfY7iQv7vZDwzOQ8vrtKpCCvC8H+agmg4FwCJs/HEj
	uo1/MNFc5PuUJG0JuehOC2TDnoYlmuDhdPjPnpEjLLJ3cIlFqp+5AUYpTfkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794294289; x=1794380689; bh=SbTwCXI6xuesmgVjjVEP3OqKtW0/ezwFcLn
	09WOAZQI=; b=NDr1Sh6r2OL7jUadhSA37buri3E1GoAgVncx0nZsa6WyOyQvFVg
	bVbZbVCvvrYyhB9g7oRQ80zh/2IIfUHTuUhYUnCFFRa2BZA8+m4wMLWKai2oI7Uz
	fyNdnxUHd3LMPvIc8syvcqTHaUFtl42pS0ip6dUOWhgj0bjSBZ1euUDANFk6v61p
	XUfgNwYeY3KoPmfAc8/pGTXAsvtkIHO897qzG9YPg8tSxFvI7frId8dBKm9eaj2h
	rri9Mmoes9hFJYGS77+VOsp0vckai46gHlMe6RfU4NDxv/O7dUpuhyI/mhQ2U0M2
	dbx5Y9fV7BvP2EzSFsGtfV3KbzFYelbaVIg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794294289; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:LkfcccUiuhfdew4x3GGFj3m/S1vl4vY/6Pb0SF2FHrtrBPN
	t9hSJubad0Uhjh/gEn56G8o3483k+KRRMT4fdRQe3lxDQdUf9C03aeq6tz9DciBz
	rfGFi+hkDlhSgvVSwHs/71ctulidNvnLjTZP1pVnXv2YJCTbxjC5u6v8zK3bqtKj
	YzolBA3KhlDHldflO7fBjtBRKJs784V66fK4dd8IIFyqZXy9gjuBQoMQr93Ng55y
	+gqDoWEnw35E+VBmrxLp20bqb3twy5/OUwcnTtAwT8HC93m6JGFxgPGZHgby3IQ9
	S7lZuE8dxdj4cmlAlbvOJqoc1bVfsUyuhg7gZrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9VFH9t6RTvFTE9rvUeBtmXjSS5Dk2DDNQrykncbZ6PY=:6RmKeWeuojp4hP0H86VV79LFyjJDa6cCfYRo838zzq0=;
X-ME-Sender: <xms:EcLyalU3AqSjrV0nIzhxDOaJ_ct0IqGngK9hFSUTSILgSIxf8LZ8Zg>
    <xme:EcLyarmMl2OgU6baRE_Szi02L8WUoyCZzk0ZLoWyE6CNep2PZ8AziPpAGUV1O7f2N
    McTqTPfzI0M2lNK36P5jaVDbI_F-EZ9gYsme2QG4rC8zYJY-8JkgcM>
X-ME-Received: <xmr:EcLyavAWyuwfMvsJUOF4vM8ZC99pf_UQAMuD9KfNp4h1D5xV3oPzmumn46nl4nSg6qWuwA>
X-ME-Proxy-Cause: dmFkZTFzHRnl0Orj5/G0XtjfmvXK4mOqyyVUfEMgijuzHdpu3VYcE+/f+sem8kmKPUpvt/
    gP/frcL0D1LJy+McNXja6YW5TnR+qQsBnOdPToE+8ltvTIQp6FL0/3M/8rI9UgF9/eYBbS
    EhkJPfuDT0U47t2fIxq08ifcsNIjQdU/cteBhMROwbJ9M6/9khyfNOxoy7qbSBTDc3N76J
    2EcUF+L0GtQXrCqkAqEzAHoAtQXUe/yip3QyDrErgPRMo8TIUzFpE0gGN2aNVl4wSE9oBV
    I7atjIsD781DN77L+C7InGGUQ32nS3jlby/aFhcdvDS62hKhFXHa55xB56cUbtN/TIW3bW
    ldJh3jzBPI8KioGom5P+VLJJhcCu+lc2HaHHeOXMtNxFXa5RSO94m6QKJdnksIixnhMIvS
    rzFHZQkOdWl4NhkMjzqm11Jng1lXph/SXbUSCTyJndtJm9K4gG8nkzWcv/FRXKLkSJvfPR
    FxjY8J2cxxNXLpphzvClf0IVFlDGCQ9fEiGfrIylbfHMUD01WWdNl+sILwG5GmMe5ws7PJ
    1WKR+8jLUb9IFLP3Nj50IiS0Pn8VmFcsRa8lDvPjtlxADnOFMSI6pNqP9CF4EM1zNU2n7D
    GSWOwaTKw16qiMjLNl3bR49m9JpC6tx3YdRKzGMSIP56EybIb6kHrWQtwaMg
X-ME-Proxy: <xmx:EcLyajetwc9ICG7tup678jAoJA6FrhhOEOhwGhfBz3QlbCgquywcrw>
    <xmx:EcLyaiKokMHJp8DKbYyYi3wie-m90K04yA0s___UwrzN9xbFMuOnSQ>
    <xmx:EcLyaucNlnoKAAvSbOQwitAaCqhRt1yrjjJGVVVvSAiX0Gu2H1FQ8g>
    <xmx:EcLyah0o6gCnfWMS7BGxK8dGivWdiL0FVWRqAW5N02soyMFjuKZHoA>
    <xmx:EcLyaguUdsN5sH6IdSfn105Tz-_kOWNqS-Bk5gXFMTZBksdmVKOBNUDk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 02:04:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id af797cf9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Nov 2026 07:04:48 +0000 (UTC)
Date: Tue, 10 Nov 2026 08:04:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] unpack-trees: lose USE_THE_REPOSITORY
Message-ID: <avLCDTHuScp4iLyj@pks.im>
References: <xmqqtsltbfdv.fsf@gitster.g>
 <avHNf-aaxdsyim7g@pks.im>
 <xmqqecctzttt.fsf@gitster.g>
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
In-Reply-To: <xmqqecctzttt.fsf@gitster.g>

On Mon, Nov 09, 2026 at 11:30:06AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> @@ -345,15 +394,16 @@ static void load_gitmodules_file(struct index_state *index,
> >>  				 struct checkout *state)
> >>  {
> >>  	int pos = index_name_pos(index, GITMODULES_FILE, strlen(GITMODULES_FILE));
> >> +	struct repository *repo = unpack_repo(index, NULL);
> >
> > This conversion here raises the question what we want to do in the case
> > where the caller has both structures available, but we don't end up
> > passing them to the pointer. This could in theory hide a bug where we
> > have mismatching repositories when the entry points don't verify that
> > property.
> 
> Puzzled.  Here we do have an istate but have no unpack_trees_options
> available, so it is natural to pass NULL for the latter to tell the
> validator "we do not have unpack_trees_options".

It is natural, but the calling context _does_ have options available.
It's just that the caller of this function here decided to not pass it
down because we previously didn't need it. In fact, every new callsite
of `unpack_repo()` does have options available in their call stack.

> Are you worried about a case where a programmer who writes an
> unpack_repo() call passes NULL by mistake efven when istate or
> unpack_trees_options are available?

All I'm pointing out is that there are cases where we could be as
defensive as everywhere else if we started passing down the options to
calling contexts that don't have it yet. I wouldn't say I'm "worried"
though. The proposed patch is very defensive overall, and I'm not overly
concerned about us missing that defense in some cases.

Patrick
