Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003548;
	b=T8lg7iCnmw5YiZ0N/MUuTfvUhM6mXP0gweqjTaq1p93CFatYe2Nyb/nodmFBhJ8v5AP+
	 51oANImOqv/0mrv11/tvyvBNXJne6zvUUGOOBgeqHaFpBZf0Inf61riAmM4r5xbqyd1Ck
	 eHpFPfyv1OpnR5YDZfdDk4K5gzKvhO5srOd8HozEKJi42RfAToOKGJicqA5fLJIQxnFfl
	 IW69ETUVv2GaQAJXuLuCboydn6xcP0BE7iZKzexbnCcuSqynK+K7Yq9vOb5c60IMqQkpq
	 qCM6VmGEk9n3pA+q2cVNm+R/X7SdafSQwv8yxSyl4GJJu9tb3HPaqpiEY12epzVkNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003548;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cBa56LNYbUw98JPULEOHf2ZpEVRzMk+1Z6z9WYTSAFk=;
	b=bk1Lv6TLb4BU4NhIYTZ1HTsWhkdn4eUExNlTdXMcKZZi5EDkRx1Ykpk1MrBRW6T3Gjdc
	 DjcBocxsXinAgaIWSqvm7Ea3cB/jqudij/PEzvOmEaS1aXV70drRVRgh68whM4EAhIQlh
	 YytWGrbHnyJh/SFmdzz5llWx+YaJDJv9w6ljMEr6iXjNnJJVgyLxlCaRNMwiWqinzOxd+
	 BHjuNj+9c8aI7pM4wRxyIW8k55XcHUHteWjqslpUYQGPss1ZjW3FxPxsYiBlma6lkRRIk
	 qI1Cyedw4Fp7v5ayp30pOzZSm72jtbSITo5W3ckh0u31EvEVcxoj4r/VH6wg9NBocaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=u5gtf+ja;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DUwtJQNa;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A088606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 12:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A088606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=u5gtf+ja;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DUwtJQNa
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CEB41400026
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 07:05:47 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 18 Nov 2026 07:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795003547; x=1795089947; bh=cBa56LNYbU
	w98JPULEOHf2ZpEVRzMk+1Z6z9WYTSAFk=; b=u5gtf+ja9JOv1v9TpX4FeelV+T
	bqWJ06jgy2+/BLkTKZvW7o+0yKD5KsBijdbWisa5CRhJZODlqeZmCIGE9xDMVeHM
	tw92X7bsgJ/MuwhN/m12FDocVFQgNo+LR2cTTq2vs39U7JjdPCfVO3d16q31tX6L
	A3aitwzfrx/29ocstmhCG/N1tVoAXui6GoQAxclwGRcYnbhfwU6KKaE7zSYgjot9
	wnDcBOgrqgKwGzV8Zivkr/ZSqPRubN6M0BDq7a7SvfLnMG53pXuJ8r5umnwq7agU
	e2vjY7BSmHtBy5nEqUFksvagCKC0oCUZHhVVbvdssy8LDKGKLsEvz9Ow8SsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795003547; x=1795089947; bh=cBa56LNYbUw98JPULEOHf2ZpEVRzMk+1Z6z
	9WYTSAFk=; b=DUwtJQNaIVLtSttCp7neoj3Z8MyAFUdOggXw8cnV5DdbNAFx+cA
	HP3a1DQ2D3N1cqgFDMRTvP9c5tsNI4Wko4PsuzuYJJo/FGqZCoFc27TelfwZDi7J
	mu9GVbt989kdjqZ1fwSH7r5VCsnILKnHk/Qsn1agkuE6itnKht61ooR0jZy0sG8j
	WfZMdM7KUPfz71dQDoPOaZK7xIZtp6WVxDtgX4thkCrAShjMMh3Sy/0iAYIe+lOg
	ff3wqbf769/sXnFCfphUMeZE77CwWd54etpxg3+RR2AKgcjoHNzuS43HdPMDg2A3
	QlRnaNXJFIJrXFg/U62Sd02gtMnan9yh3eA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795003547; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:ukYuYEoG96AOfge5qJg6cnZ5WHNADOcVhRHuZOX+k66Kfjx
	P8MdGzItBk2TQ6nhagawf0zf46VkMDAKNvnSp2Gsvn3D5NGpFV7q91z8hIihrRkG
	r6CU1j8BcTT8RnjBatxPzicP8s5W8W0z7IDc4d0xQdn+KjWDxzpfOlEJNOjLLo15
	V9TvSRi4QmGbCG96BRpc6oxn4kTDJdttP4WfmgSB3TbJPmx6XZN0HGUm7F4V4qh6
	AOeitoELEXvUecVjoBFarH4khrbXSnBt56J8cnkU7DpVhy8azl3g3XYmXjflkNwl
	Hwi3c6DJImTfMH4/ieH+SoZ3ZNlAI+09ADABYnw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:JOZzX3wG9yWa+Y1yIcIuKPn1QuQmoDCK2dCmrjcjvnQ=:qUUDoSf/LRh8u9e3myMq9PbmClp5ZQH3t8GkX+IKOBQ=;
X-ME-Sender: <xms:m5T9amY_8oDzSCTZpnidjB8WBHl8vqG-AT3ooLdPRRF2ZDEJRJSEPw>
    <xme:m5T9avZBtkr-KXX1c9xeTX45oieGZA07ICcwd3rKn9v7vRH15NZf8AVY7gjZCsFmi
    dG5areKeLrlsN--UNtED2Zog1rJ2QVximdUdFFIzkBbeD4IEpRdbrQ>
X-ME-Received: <xmr:m5T9aukP7uXJNnLySpNOpkE9OQfwM3jfPulIMA53sq9moGlFkjJMbw>
X-ME-Proxy-Cause: dmFkZTESaFtEoNN9lDVu88KLGAOaFWiMbmGYvyiljUXwPdaIVX4/yG5X5KfU8Xrc9H1esF
    GrN90G2o2N92ztKOPZyEIFgdJv036nzU+55nUqNMEqFqP7t4EZC7D1DUgXR4Hg9uwobQSF
    aQJJ7gnySpur9nJH/zPhlgVUWz37NHKUAn6oSernVRhnC2xsh17m7yaJL0EU4sLuO3RomU
    5clP3QpJl0D2dwEqgq0iDKxH127G8ajDggn2hATYuG7PlqpAGbJx9//pHp5fkSGOvbzs3m
    UOta067rLyGRrekNFQSpf20FmZdueqWp9h9AieKDYvWZgCX3EzsqrcmDHpRd+K2hXayLEY
    diUG5XRw8eHKOTJA8rd/DFa1siiMGsWEpYY7V9GOB9Oi3oiVmkGMocoNaXvzgf1EqkPNdQ
    2DyeweCBoB3sl/Myyx06l8d4KStLVdd6D7hU6HjvM2qNmZz1cWRRFi43gC2ocvpv7ZLrlt
    CtpEZwTHLocHl1ur72oSRhrf2GmfsWd7lCNvQK9g4U+G4rM0eCCJtX5ERonHrRD2Xo+SDX
    2zw8fCdaZv90YPxNx8RRKrwuUPPuXrv4qcFgdE5HUxzJdtOL4VJH4UW32TrT4jILPKYwgo
    CEnRKWUufbA/oK5hakbSdE//4Aljj2CHb6eulznv06Ys1An7mvWszOBJoW3A
X-ME-Proxy: <xmx:m5T9ajxlTqm43a9FCKNt2tbBRPTSEQJX6tiAXOkd8jjE1q-zMTMtzg>
    <xmx:m5T9akOAa8r12qErSUGnSI26Uun2fofygwr-UWoPHLSTObOgZp7G5g>
    <xmx:m5T9avS5Xbpy07k5SrSyrES7v9RDVU8o7SIQvH7yBnOvwOWsVUhFvQ>
    <xmx:m5T9aqYXfm9LzIY50X_hJVnJbIDRYMzvtKHvE98UEGyIYJx4hSi0DA>
    <xmx:m5T9asJAKA_kK2N_iBMogkHKppAEyuq3JyBF5a2X0CR5vEKjkAF9ghQ8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:05:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 36614e59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 12:05:45 +0000 (UTC)
Date: Wed, 18 Nov 2026 13:05:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] refs/reftable: don't write new table when expire is
 a no-op
Message-ID: <av2UlJLpSDOPKbua@pks.im>
References: <20261118-pks-reflog-expire-performance-v1-0-10b9263566a8@pks.im>
 <20261118-pks-reflog-expire-performance-v1-2-10b9263566a8@pks.im>
 <CAOLa=ZQGJkyVY=e94hJVmLa2fuPVUfC3uFRsQTeoa95sUe3UcA@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZQGJkyVY=e94hJVmLa2fuPVUfC3uFRsQTeoa95sUe3UcA@mail.gmail.com>

On Wed, Nov 18, 2026 at 03:33:04AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 4216a18684d..e2027bb9c02 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -2696,17 +2697,25 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
> >  				    logs[i].value.update.message,
> >  				    policy_cb_data)) {
> >  			dest->value_type = REFTABLE_LOG_DELETION;
> > +			has_changes = true;
> >  		} else {
> > -			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash)
> > +			if ((flags & EXPIRE_REFLOGS_REWRITE) && last_hash &&
> > +			    memcmp(dest->value.update.old_hash, last_hash,
> > +				   ref_store->repo->hash_algo->rawsz)) {
> >  				memcpy(dest->value.update.old_hash, last_hash, GIT_MAX_RAWSZ);
> 
> We can skip this second copy.
> 
> > +				has_changes = true;
> > +			}
> >  			last_hash = logs[i].value.update.new_hash;
> >  		}
> >  	}
> >
> > -	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid))
> > +	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash && !is_null_oid(&oid)) {
> >  		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
> > +		if (!oideq(&arg.update_oid, &oid))
> 
> We now check if its changed, makes sense.
> 
> > +			has_changes = true;
> > +	}
> >
> > -	if ((flags & EXPIRE_REFLOGS_DRY_RUN)) {
> > +	if (!has_changes || (flags & EXPIRE_REFLOGS_DRY_RUN)) {
> >  		ret = 0;
> >  		goto done;
> >  	}
> 
> Nit: it would be nice to mention that we exit early to skip writing any
> new tables.

Hm. I thought that this was obvious from the code itself, so I didn't
think there was much value in adding a comment. I wouldn't really know
what information to put here that doesn't just repeat the code exactly.

> > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > index a7027458395..d808f1887f6 100755
> > --- a/t/t0610-reftable-basics.sh
> > +++ b/t/t0610-reftable-basics.sh
> > @@ -912,6 +912,36 @@ test_expect_success 'reflog: expiry empties reflog' '
> >  	)
> >  '
> >
> > +test_expect_success 'reflog: expiry without changes does not write tables' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +	(
> > +		cd repo &&
> > +
> > +		test_commit A &&
> > +		test_commit B &&
> > +		test_commit C &&
> > +		cp .git/reftable/tables.list expect &&
> > +
> > +		git reflog expire --all --expire=never --expire-unreachable=never &&
> > +		test_cmp expect .git/reftable/tables.list &&
> > +
> > +		git reflog expire --all --rewrite \
> > +			--expire=never --expire-unreachable=never &&
> > +		test_cmp expect .git/reftable/tables.list &&
> > +
> > +		git reflog expire --all --updateref \
> > +			--expire=never --expire-unreachable=never &&
> > +		test_cmp expect .git/reftable/tables.list &&
> > +
> > +		git reflog expire --all --dry-run --expire=all &&
> > +		test_cmp expect .git/reftable/tables.list &&
> > +
> > +		git reflog expire --all --expire=all &&
> > +		! test_cmp expect .git/reftable/tables.list
> > +	)
> > +'
> 
> Nice. Could we add a similar test for the previous patch too?

This test also exercises the preceding patch as we use "--dry-run" here.
I could've split this up across the two commits, but I was lazy and just
added it here.

Patrick
