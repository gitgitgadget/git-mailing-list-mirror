Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656144;
	b=qYppmSstHpeT8i2vposp9VyZpC/Ym2sXIn1bQJZCKStBFcSF08hAN143H5wYYmmWHCCW
	 qeGPlUGE8tfbk4AlJvttoM9gq9ItPj9JhQ+xwvqQODB3nkVbmtU7OK+CX52gpw9VsGQbb
	 SG/oqEY2wC7UsNwIjP6qdTkDqmuQ8wAodskPO2FqcJTwKtIiWThUNzVVX2ehcXj9OJRkJ
	 2E7I1bLWNnIZqK8rStUD7Md+dC+3LbBOSw/7WYLn0USbbVH9nEqQNkseLx6XbAwfI0SYO
	 BSTdOMJzRYRGjZy7Ul2XDakuPCVgbZ+e/klwUuJ2YkCmkNfKLJ4Tpd+w9X2Avon15XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656144;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iNgKb7wItWrl/3Tf6hscxxHrOlU6ylPisUvXenvBF5k=;
	b=NGmVnhPzyBwLY7VNUhxwmU5w1aY2QLYmwLLY2Xz7Ml0bPlLVZEF/9YkxGbe2m08tXHs3
	 YluVo9PSThtbPhFh8sVFC1eQxZalxhwaa+JK8E5P1Qaaqw8Frfr/Sp4tuShEworZLWUcn
	 9q8oqxC5rId9TNAwX+z2FIQSrhepA4drG8i85ruWzUEVs8svjI+l3FtouhinXBvHe46nN
	 95vx7Zw4x8iMFEAZKhesSe+BTYiQ8C8Ayhn+vObINO88yedL6iC3jB+kLbTRo+45eJxtC
	 hcJbM9McWBHunu7wy9+9rsqhvLNcilJNuXEgRhyioZPgTTixErzBS8M1g5kMbgQnCKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FImYpeLJ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wsBP2tym;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56B0606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A56B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FImYpeLJ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wsBP2tym
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DE2671D0016A
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:49:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 16:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793656142; x=1793742542; bh=iNgKb7wItW
	rl/3Tf6hscxxHrOlU6ylPisUvXenvBF5k=; b=FImYpeLJOo9C05qk6ASAt9jF8Y
	+i0Gfsc/EFoBZQlxWh7jCKu+lDQHKI6eE5nWBqPeI5vWfssr6yoOKglH3Q1pnemr
	Qc5Iyjc79uyc29/xMkaLuDzyheMhBeesmbwh9JKfdAZY/VcY/BkTHlbpqrrWxRok
	Y35+zYr7TEcpa0IZoBZMcm/knbBwnGam/ICA4zzhaPTGaG9iYxOg9ANoKQPBWAKo
	iHDZ3Ljxv4npciK8O9Z07vvXv7FYgL4JYv9HX7nvyrDrWFum29WszNnNsQRNaUaf
	GsK6OfzbfYZuh2s0ScaWoS936E7PBWGEZHjrez01hsUBa70SFOqYvk4KZBIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793656142; x=1793742542; bh=iNgKb7wItWrl/3Tf6hscxxHrOlU6ylPisUv
	XenvBF5k=; b=wsBP2tymzm25Yr3UexC3cj6+u5EJkIaRaGvPCXk3CHwTd0JBWjF
	pGerRLCGskuIKRyt2ala7KMR9FAdpu4XoiBfWkzNnkVnsqOTM19dHKdD6qY9xSia
	OEVu/vQNViqM+vzJ1EmwBWBEJVBq9igWlfSNxGcZi40zjeslKfBUVGTp3kn+dM4/
	LdOJpd6LYoQ4dmEWEW6eX6uDWtpvLHm1MkH7UC3/KYQ2fkgi8H2K1miWwNAHNxly
	nhxAaGUzo7ULcn6QbcnqF8Cidrk3ud6D5FY4K7HXRE9ngAfkVtc+PLASM838YOSi
	hjbgQEQm5auvG9LtcQEHqxkIqPmsKcAiGVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793656142; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XRNj43OV/vnyhejM3tAlCLYqCTQ5JZ/gv4LosJ2K8GLIpqK
	xZWWNsOpX0AWZfSP1hoLxOIrsZJ/H6kTWAPsnNuMgT2WtDwBt/kwFqO+63gsRFj/
	n2HRR8O5HL6oJxmzG6fbIQxi21lQBnqc9tQqVQYuKgaJ462sNf0GQL+61bWG7kUl
	nihIuJhrCDbdC2v7TbJpV3NsvtttDCJAp8PLLWXxZt+pRoLEw5e6pQ+E2RObwLIS
	95aHwjlweV+lX9asrZ8sRQBHszOKLAVgVmkOCs1Ead5+sO7zhZEuoZ+QyREXkyXD
	G4K8KzXIq3lLysMpCat2dmQSTw847jMYQ0NvF9w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lkfZ+gcO5GdeOB3WmeY0OaahpEGDFAN+usyB4ZqNSh8=:8523Z0PKqjNU+QJEHFZeOdlWUaA0kvwCaeW+uS6zJq4=;
X-ME-Sender: <xms:TgXpat3UZ8AFbDob54vbrigJm6_2UCex-9GmPo9xS8-BljXwDJsh5Q>
    <xme:TgXpasiK819NBJDriUUBCAZV0wuXUCvqxnvE9aPNIwfs5axv5eaD5Ux9OqSr2NPXX
    HHwDGUyVl5CPzRuuRTQG3ZlpOmqgH0ZkuDbG3dpjtgH3DfFaplsHPA>
X-ME-Received: <xmr:TgXpauU2r-0Oj9M1647h53-S4MmwgEVCjJaHrEMObjDLZnWijrs5bQZ5YH1GNTIhXio0tK7LbKnLo3W06QttoLbaqQF2W768EyF0>
X-ME-Proxy-Cause: dmFkZTGuFjsgL6LKIEvlZBfOjndWXRpH9Xvg/lCFsroY2RoCoGF4bgG7KzzfS9ONw40OpS
    EyYVVl8tui5SSyXmN7VTe05KvydmFiB4At52AOH/nKcOQsHsSd2F0tM2ll/wxygZUojj7D
    zGc4MX0+LoXWd9u8+VpRI3rw/MZS5M2ZACItq6v26J1rXN539l+wgeXecbqpgnZ9mM0V0F
    ItpWrSfReRxIlVeMfeicip0Nmc6kJAFlFzzDaGcPt2TnntqpF7GfpYmKcOCtRI/3eiSgcD
    CZsdOeYtW8qBTt4tUVTkrIo4TtJ+Ukt134g4Xs4JMM8ddKENvCnPdGqSddilgOV/k4aSQ6
    ZnX0vbxbLAHx1LdX7QuJ1r/TH89NuPWlh/kp3Zzk1QXzAJF6I85p4gOus3O9EdcQ287Fjf
    2t1jdLd9rXqkFuIDCHzXbxs296Nu0EqoaGbthD1OhYF4w1osGEAh9yW03xxGp+P62+6v5p
    ygBqg6ugUTQHuxwfr4wxERHaj57pyZOxUsFfcPO5v6YpXZyavse/Nyn/6vPo1+p6N+l9QW
    3WRxK0MDSDhmUBky2Uych0thtU1U/jCHhQjNEnrnVIrfHEpXRsvqsh6nNlyP02D2pltATt
    K0xXna3u0I0Mj+vLHCXdF1/6Viyx2MtoZaR1TU8+usuKg2sbjn1C+wpDNf+Q
X-ME-Proxy: <xmx:TgXparXsfTZQDe8UbMxb_UmB5eyHFiIRLjxYuGMo4ggzhPxhNG0HJg>
    <xmx:TgXpauiFVBLI1-vQp4nlYIOnGwoU9jEJbS7CkgfIVZYy0zGm3B6lAw>
    <xmx:TgXpambqM24F8MoqOInfDfhR-dlN9XI1K5rxl5V4nTZtwc84_7Nijg>
    <xmx:TgXparp1iBnB5O8HTotF-59OP9Xo38h9NXBfXm4ofTDuggGCse10XA>
    <xmx:TgXpahbslGFgcpw6yHkjG8k62pLIrWEcQBoxedtGXmpbYLWJI393LvVu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 16:49:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Andy Koppe" <andy.koppe@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Karthik Nayak" <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/5] root refs vs pseudorefs
In-Reply-To: <840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com> (Julia
	Evans's message of "Mon, 02 Nov 2026 13:19:57 -0500")
References: <20261022212903.177261-1-andy.koppe@gmail.com>
	<20261101230326.3675597-1-andy.koppe@gmail.com>
	<840bc117-75e9-4d63-882e-3831156871a3@app.fastmail.com>
Date: Mon, 02 Nov 2026 13:49:00 -0800
Message-ID: <xmqqcxsmhpkj.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

... 200 lines of quoted material omitted ...

>>     ++[[pseudorefs]]
>>     ++pseudorefs::
>>     ++    linkgit:git-fetch[1] and linkgit:git-merge[1] create the 
>> so-called
>>     ++    pseudorefs `FETCH_HEAD` and `MERGE_HEAD`. They are not 
>> references as
>>     ++    such, as they are not stored in the same way, but they can 
>> nevertheless
>
> When I look at my .git directory during a merge conflict, I see these
> files:
>
> $ ls .git | grep HEAD
> FETCH_HEAD
> HEAD
> MERGE_HEAD
> ORIG_HEAD
>
> From the above, it sounds like ORIG_HEAD is a "root ref" and
> MERGE_HEAD is a "pseudoref", but naively it does look like
> they're stored in the same way. What's the difference?

A pseudoref cannot be treated as a true ref because it can describe
multiple objects.  If you force it to be interpreted as an object,
you will still get one of the objects, but that is not the primary
way it is designed to be used.  FETCH_HEAD even describes the nature
of each object, e.g.,

a018953...4		branch 'maint' of gitolite.kernel.org:/pub/scm/git/git
8d1b215...8	not-for-merge	branch 'master' of gitolite.kernel.org:/pub/scm/git/git
882cbad...5	not-for-merge	branch 'next' of gitolite.kernel.org:/pub/scm/git/git
4231a2f...4	not-for-merge	branch 'jch' of gitolite.kernel.org:/pub/scm/git/git
2fa90fe...8	not-for-merge	branch 'seen' of gitolite.kernel.org:/pub/scm/git/git

The other kind, just like a normal ref, describes one and only one
object.  The only special trait it has is that it is outside the
refs/ hierarchy, so it may be a slight misnomer to call them "root"
refs.  We do accept $GIT_DIR/ORIG_HEAD as if it were a real ref, but
if we did:

        $ mkdir -p .git/foo/bar
        $ git rev-parse HEAD~24 >.git/foo/bar/baz
        $ git show -s foo/bar/baz

we would end up treating "foo/bar/baz" as if it were a real ref,
too, with exactly the same mechanism used to treat ORIG_HEAD.

The only difference between .git/ORIG_HEAD and .git/foo/bar/baz in
the above example is that we _do_ create "root" refs ourselves,
while we do not create such funky things like foo/bar/baz (hence
they do not deserve a name, and such "use" may suddenly break
without notice).

By the way, *please* trim your quote.  Having to scroll past 200
lines of material that are totally irrelevant to understanding your
comment is a real pain.

Thanks.
