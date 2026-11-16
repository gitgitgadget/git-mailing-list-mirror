Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814630;
	b=PuVWzjtBWldDPP187+Qf91dAOUpVsZMdu0BO6C7mpERyaNY4NJxyqJnFnFKDe1+Qbrkm
	 Lhzd5JPsbE9+pdGKNnMP4RLpdjKZMJpo1UAlZTPYStofhsZ2dkFLSFf80Lpx/z3ZdIApR
	 6FEG5gJyewFi9vJq9UnK4Hg48OukN2c+0eCLYX0BRFZaI0kl5FpozNXdS2IVM+uXlbJ1R
	 VybarrgYHO7TG/bqe+AxpdLB5vA0N753FiLX6my4csRUfSKCzV8vjDqtmO4G51KkW0oKX
	 D7N+Qt4C7DmxSHRKE/HyqTJuAUMbY746PqRbFlFLQVbikcg6UVo1kYMFVt/NPuKTuIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814630;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MjRVth5Ywm8eTJaZrItYzwMWfBHuLv718YbMFHVFOWc=;
	b=zi4wZBPNLq6OOeJ9heAwDbVSY+oAsK3iVuBCsJ8MQRDs3uqnZ8jJTMuGwIao4vcz54nd
	 NZcQXB5GXGlVuBZaQtmUoSNWRm0+MRy5vLR+yFMFqizXPcxQzkk6P2+ne2gk1IRTDhe3g
	 uLqQQjwaV2EP/Qigkloz1GPEg/x13aiyPcO3VhEv9dK3D7PVwD0ukYoPgFotiFjo83zkg
	 D/RLMLtlZhW6jLySACqD4kWyBPyP7ffDVfxSY22vwt/OKV728+kwui9+SswY31k4Na0OZ
	 /5KG95EEKcT6azEbv5yxPUknyav2TE5IkPM8/ttw7F5Zbf7EzulTld/AnAXg5oqh03w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=b08aLHD+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d69dau6v;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2276606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 07:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2276606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=b08aLHD+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=d69dau6v
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 143A47A017E
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 02:37:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 16 Nov 2026 02:37:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794814628; x=1794901028; bh=MjRVth5Ywm
	8eTJaZrItYzwMWfBHuLv718YbMFHVFOWc=; b=b08aLHD+wjLMtMMGUedvvTnFob
	cD/oWk4wLz9WpBkz4kVKAj1fr1DJ+80CXMWIKDOMoOQXZ5rbaCVTt27jKiDzB++t
	A2zB42HNJQBvhnMUgUXpE4zTo/yKbDgfE+2F0Ru3cTwzD4XlA6mGAUFKKOSZTa8a
	fAEMP3Xv822/pSGQ+onmMxCHkPzWqEeNVbRDo6a34jHY96/5v1iuHUc1DBl0fzoE
	/Dwtd++YmDTHBPaVG4hM+TKJt5sJWV/MtJ58lS4mf2L1zkwavacnozh/fQbASIT2
	YjfAaXyaGzDtyOEFfjAZ4lfLyvOEI6SIBwcI2qYpEbHmL1Jsr4v4kYTVTamA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794814628; x=1794901028; bh=MjRVth5Ywm8eTJaZrItYzwMWfBHuLv718Yb
	MFHVFOWc=; b=d69dau6vghAuOvV3xTv1A9TzsF4n+jDKJYBH5WUgxaXJOjKRjwI
	r5nDABDarmWIafifNbYeJ1R8DH2iWSlw5Gh/du2aydbN7N5klpHzgCLH11HsXLO7
	kTB1yQC7GtqURvZ8Y/l2jSSzVuZ1R/df5Z7f2brfkRstqG6m0rPl3XZT8vqFBKxA
	awmoYBLZlyshrewCB1l6ei/XIuAuiGHA4qrwEy28+ep888omOO+CA5Sm1rtodO+u
	YyyLhIuSo5VFbcT1XwsF9LMLDdNibMsOaqjh2vArRFdaIp8hgLmEZT6eNLuzIM3n
	GEHIKnjL5A+IXuJLzkn71FsdDXonqfpAchQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794814628; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:HeKfmwRoJYTfyRADEfqtq6+vi65HNa2RG/ZeTRMBXNJ7X+K
	k3HwPKISfp9/zGe9v/EAIy3odb5LltU7IvCaje/B5tZxu79Ji8tR+1O4hx0L6xd5
	4u2U5Ua2TJ3ceiIdeVlUMvIjs17kVR9rGQooJayhvvmelX6XktauvJ104WB5DNqu
	M64bTB17EWYrea3kG/T2SbtCeG2rxBlQRTwqLkyrwV7zfwJcqB1AHOU4VX7/MQ97
	m//t0RIByC0UTXqqvZ0jd+P2hHV0zJHWar1fA4k6CgoriRFmZf+pmzxJBgDbRru+
	ejvXvwsDnOiGcoLfdjN6tU3mOZGZCyYctPboOBQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OddN5lfcVsptiMkTnQAOsc20gKyuHzUsB1PPGiTTVnw=:0ctx5/AnrOK8SGMlUgVHbQh2EJiSSzmyLqZFBXGG6uY=;
X-ME-Sender: <xms:pLL6agnaNNdZ8CM2iUWlzDg0gM2-Ly388hoDMu55Vtg5Lji1K_7OkQ>
    <xme:pLL6au7mGXoShp41gq08SF8K8-GGdM5Mq_vlhIdq6BXGbuG147i8e1PlAs-bvxBAi
    T-eK-V_uwzaRG1yYYAHx1nOEuY85R5jkzblK9POhk8cCaA5HZ1DR9Y>
X-ME-Received: <xmr:pLL6ak3ldR0QIItfvhnDjo4cBhfuZ_6JqqiWq2OCQRKSaZ8vClBWYHdeQaJQtSQoYKQD4T0>
X-ME-Proxy-Cause: dmFkZTE51ZiAmoZcYrKfNP72wiyodKbQixST937ZEUHt1P8zOhZSMRbN694DlGKjiBXpry
    Ghc5JnZiHCh8uEbnDIYROmabaSkdd4VGDU15ZPiy/k4gXy6lxJvJK34tlUky7E5FZlE4Cy
    BjmKCDsYxLShvgXKoDMOcfv7junXHuBB8zYQMC0fpeQk3AazS7kwKbBNFd/0ZL4NXuapD6
    5mVNbuvYpeCsM/MRCM3uyjy9ThxTDVz2apYQ5AFhYLLNdi7i/dlmvdsLcj86dGVTcQFpwN
    tEPyIgoehkIuVC89fRMHGOiXcRGSzzg3eQhcuvl66wfLdnJSlZ+mCwyr3mBW3RTQ4gPMA/
    uiss8MI//dVAFmfY8ZN0sNIaXc7/D6tkZXAE9kmaIbWarDyEDZSUDOzi6mZEhe/0WVx3pQ
    GdTuWs6fELAlRj1161/4DnArZnTJtN8uW2kByEMMowz1cUnuhNojtiWM7vkwotK7AtXuUj
    DWM5HsRzNGy1QoN4tLjt7/qCHrN82gdX2tjOr9o7aPosNxEkKCqSPhfKDIct7dKdf+iRxb
    wv7QanczVwWUvYF5esPEbsQAJdSp/mX/9VZd4r7PLIlGvM8tBVMfrBimfNct+HuyafqzxD
    ZfywgRhH5xjqV7Y0RK+5R7nOzaZcixO7n67bH+AsnDjtwL2MFi6K1mEF17fA
X-ME-Proxy: <xmx:pLL6apHtGhXj-8uz1ejtXivORzClD_OWiOkjbympHgACkuhCvsDU4g>
    <xmx:pLL6ajj70RUsvsFtdwcJtTGeSU1tfutZz3uJaPYe2SemL31cgG6wVg>
    <xmx:pLL6asBEdPrwjAGaWn1lr65nG5JeCAe-RhQ8rdDLWiF79xg39IQkJQ>
    <xmx:pLL6alQWCX3HFT6k9JrggcWZBa4ISspYpyGZ4hneC9Bo4cmaKxO99A>
    <xmx:pLL6aqgDBtrUiRBWlCnDd1loQn55-DbrW85sZuqUYUv11H6zVb3lT3_j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 02:37:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a2e953d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 07:37:06 +0000 (UTC)
Date: Mon, 16 Nov 2026 08:37:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Emily Shaffer <emilyshaffer@google.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH 2/3] rev-parse: die when --output-object-format cannot
 map an object
Message-ID: <avqynlDKnJpJn6RZ@pks.im>
References: <20261112195740.2834341-1-adrian.ratiu@collabora.com>
 <20261112195740.2834341-3-adrian.ratiu@collabora.com>
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
In-Reply-To: <20261112195740.2834341-3-adrian.ratiu@collabora.com>

On Thu, Nov 12, 2026 at 09:57:39PM +0200, Adrian Ratiu wrote:
> "git rev-parse --output-object-format=<compat-format>" should print
> an object compat id when extensions.compatObjectFormat is enabled.
> 
> Git however doesn't record a compat id for every object, e.g. for
> objects received by a fetch that goes through index-pack.
> For such objects, rev-parse silently prints the wrong id: it prints
> the storage id where the compat id is expected and exits with 0.

Yeah, that's just plain wrong and extremely confusing.

> This happens because rev-parse ignores the repo_oid_to_algop() return
> value. When no mapping is found, that function fails and leaves the
> id unchanged, so the storage id is what gets printed.
> 
> Fix it to die with the same message as pack-objects. The other callers
> of repo_oid_to_algop() already check its result.
> 
> This only covers a single revision argument, the one case where
> rev-parse converts its output. Other forms, such as "A..B" or "A^@",
> print storage ids whatever --output-object-format says. That is left
> for a separate change.

This paragraph is a bit hard to parse.

  Note that this only covers the case where the user asks for a single
  revision, as it is the only case where we pass the desired output hash
  explicitly. All the other cases, like for example when the user passes
  a range, do not use the desired output hash at all. Fixing that would
  be a bigger change though, so this is left for a future patch series.

> The test copies a loose object into the repository by hand, so it
> doesn't depend on whether fetch writes compat mappings.

Do we have to do that? I'm mostly asking in the context of the new
object storage format extension, which may change where and how exactly
objects are stored. So all tests that manually modify the object
database will break, and we'll want and need to fix those.

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index d2154eac8d..ab2898ba52 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -1171,9 +1171,11 @@ int cmd_rev_parse(int argc,
>  		}
>  		if (!repo_get_oid_with_flags(the_repository, name, &oid,
>  					     flags)) {
> -			if (output_algo)
> -				repo_oid_to_algop(the_repository, &oid,
> -						  output_algo, &oid);
> +			if (output_algo &&
> +			    repo_oid_to_algop(the_repository, &oid,
> +					      output_algo, &oid))
> +				die(_("cannot map object %s to %s"),
> +				    oid_to_hex(&oid), output_algo->name);

Makes sense. I would have checked for `< 0`, but that ultimately doesn't
matter much.

> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
> index 30bf8a4d0a..c15d9953a8 100755
> --- a/t/t1500-rev-parse.sh
> +++ b/t/t1500-rev-parse.sh
> @@ -241,6 +241,24 @@ test_expect_success RUST 'rev-parse --show-object-format in repo with compat mod
>  	)
>  '
>  
> +test_expect_success RUST 'rev-parse --output-object-format with unmapped object' '
> +	test_when_finished "rm -rf plain compat" &&
> +	git init --object-format=sha256 plain &&
> +	git init --object-format=sha256 compat &&
> +	git -C compat config extensions.compatobjectformat sha1 &&
> +	oid=$(echo unmapped | git -C plain hash-object -w --stdin) &&
> +	# copy the object by hand, so that no compat mapping is written for it

Instead of copying by hand, wouldn't it be possible to write the object
with the compat object format unset and then set it afterwards? That
should also ensure that we don't have the compat hash.

Patrick
