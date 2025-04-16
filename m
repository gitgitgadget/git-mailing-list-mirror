Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E31A3144
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744778406; cv=none; b=GKMjFAgFj3g+nDlHV8rUtl9Rvhwa8I3VdU1NtCVnhHAayyxpXpXLvLdiUN6Fvd0uVH5/VhNsiX45cW2+qJUR1xUUHJmSSoTu6ZO8ZKkTVTyNs543p1cI8AyJSUhDiXec4nd3TjXkxQbbn4HL8zlyvspJ3Eeq7r5vY0fWl2IjgPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744778406; c=relaxed/simple;
	bh=+4hmOoTNbo/gSuwWwHCtgLT2LdZm/uWcuLaEAxPZjNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe7olTTf23tO7Uw7Jyn5PoL2MhI1Fu8CHCHSodSWU9NE12Ws7Z9LqustbSyMtZWN94Oz+SPWLp6VIbwanEPZvUWCbV1OLyc3/9ngRtH3JeMJ6gdsPSm4CL+AyOTQeBBz5dsaCrvqxeuFVcf6zG2REg74QAgTM1iq7ZdApwrK4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cz3M6X3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBq34QIM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cz3M6X3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBq34QIM"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 195DA254038F;
	Wed, 16 Apr 2025 00:40:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Apr 2025 00:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744778402; x=1744864802; bh=tDgXiZzFPd
	6oi32aT4TPRI3lVMpDhU/HLE0khLIky+w=; b=cz3M6X3jzKHgPkSbwFfIv3UoV8
	QoA4rfMs82D+5h/2Lx8fFpw4OEWCXPkIatMHLDRvoUIIi7idC+XxHwycdmjr+mj5
	ABDz5Hmzthu7FA8zpV0fKrN1lAr+RfUaWENfVBUm1pca/e9aFk1scx1G61z23ixg
	LhzAAkZ9Oq0Pt8n3F2qcdIoL8vfxK5nJF6n2QImG03JVlelG8niQeqOLxrtAyeiV
	pbyjg6N15M84WL+6dWV29Dy+DfkGrkflcLE8HIJqCOIsL4bVgWyAuzOmlORirEuX
	i7DHRz7EuEFQ4xsyFYJswP4FpmGXaMfrWzhqmh72f1PFZhv6KINk8wfMXBJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744778402; x=1744864802; bh=tDgXiZzFPd6oi32aT4TPRI3lVMpDhU/HLE0
	khLIky+w=; b=IBq34QIMsjiASwCkHAmmCa5nU2WC7PLS0uJeNB72SQU26kDdKpE
	a9lsKV+MiaofMD/vV01JENfVEydnWg4MceAtkDpao2NDaL80TgzaqKATu2GylpmE
	L00Xd9Vf/zK10fL8otHDXi15OfTOlT/7cEBcRdLpEpJxVtPqetyKFmOomd5PNy4J
	ojOYZI0ekWqJ2EASWF0Yp4lAAX15CvoWa5hwfnvKEsRPYSGZ+FH76arwukAeuwQv
	SUWRztFaDd7Wmpl0uGNOwJgNx7UMZ1TTrEdiJNlz+CCuInqgy3MD90OXYJTG9qSv
	To0q5rpG0RdDiCL7f4fbdADSugn8Ou24UCg==
X-ME-Sender: <xms:ojT_ZzEEcofSQGP9zpBWS4v-GL9Ice5enWxQy8nV3YbaLFFeMDq-Iw>
    <xme:ojT_ZwXrcb69wxhA3PTQT3TabRKYr9WNx2Pviprirm72RZXtGuQ5tPYfQnA_O5TyK
    I2xdB2lju-MMKyGrw>
X-ME-Received: <xmr:ojT_Z1Lno2VbknPg5j2Jyuinpd5T1ldS7HtLVcz78dwEBf8dTpl07RV85j6cG5fMzSP7mK9-m64EiC38wT3BqvY_UWDG3IPQMTfigG0qNp7oeiLPVTQG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdehgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvohguugcukghulhhlihhn
    ghgvrhcuoehtmhiisehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpefhvedvje
    ekvefguefgueehudejhfelueejgefgudfhgfdtgfehudffveehgfelgeenucffohhmrghi
    nhepshhusghjvggtthhivhgvrdgtihdpihhnshhtrghllhdquggvphgvnhguvghntghivg
    hsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ojT_ZxGWGCnMH-czW0vwY_FXH-ylBVAJ5Hjxur9JHe1oS6Qv76YLyQ>
    <xmx:ojT_Z5XvOuhSdtAAeHyNnEqXxM3G-Cq3SGBDwc7-6mmUSfrBNH_qMg>
    <xmx:ojT_Z8N8mmiSwLsoYbrHaMvNbRN8rF7VWtJUviCiJNlTqohUOmwLfw>
    <xmx:ojT_Z43iP-aJKjMieW2sqH21Gcx0fqSQaigcK1_pNYzM1m8Qu5lRnw>
    <xmx:ojT_Z_EKGkDsVP5BUDCTPdozKwzO7xQHgyDuITUR6teXW8nynqqhI6Gu>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 00:40:02 -0400 (EDT)
Date: Wed, 16 Apr 2025 00:40:00 -0400
From: Todd Zullinger <tmz@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFH] fedora: pedantic fails complaining that awk is missing
Message-ID: <Z_80oMscHcR4pyvf@teonanacatl.net>
References: <xmqq34e9kmef.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34e9kmef.fsf@gitster.g>

Hi,

Junio C Hamano wrote:
> GitHub Actions CI started failing the pedantic (fedora) job at the
> tip of 'master' few days ago, and the log claims the failure is due
> to missing "awk".  Even though we have seen a few topics to rewrite
> Perl scriptlet, and I think at least one of them uses awk, but they
> haven't hit 'master' yet, so it is puzzling why this started failing
> all of a sudden.
> 
> So here is a band-aid.  I wouldn't be surprised if the base image
> was updated without telling us.  We have seen Ubuntu 20.04 base
> image retired to cause CI failures as well.
> 
> Almalinux does not even seem to have awk available as a package
> (or it may be called differently, but we are not suffering from
> the lack of awk on that platform anyway), so make sure we ask for
> awk only on fedora.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * As the scheduled retirement of U20.04 image broke CI jobs running
>    for 'master', I started looking at making it pass again with the
>    minimum change, i.e. by merging dd/sparse-glibc-workaround and
>    js/ci-github-update-ubuntu topics.
> 
>    Then I somehow found that another job is broken.  And this patch
>    seems to make it work.  Not knowing how it got broken is
>    unsatisfactory, though.

I can hazard a guess (or several)...

It is likely that the image pointed to by the fedora:latest
tag has moved from fedora 41 to 42, which was released
today.  The fedora 41 container images have awk installed
while the fedora 42 images do not.  That change is, I
suspect, just part of reducing the size of the base
container images.

In both AlmaLinux and Fedora (as well as other RHEL
derivatives/relatives), awk is provided by the gawk package.

On Fedora, `dnf install awk` uses the package filelist data
to determine that /usr/bin/awk is provided by gawk and
installs gawk as a result.

On AlmaLinux (8 & 9, by my quick testing), that is not the
case and you'd need to use `dnf install gawk` or `dnf
install '*bin/awk'` to get it installed.  Though awk is
included in the current AlmaLinux 8 and 9 images, so it
isn't strictly needed.  But it's probably better to be
explicit that we need it installed, as a defense against
some future change to the AlmaLinux container removing awk.

Using gawk (or even '*bin/awk') would likely be clearer.
That avoids relying on 1) a case statement to set an awk
variable; and 2) the different behavior of older and newer
releases of dnf with respect to the install argument
matching on the names of binaries provided by the package.

But that's certainly subjective. ;)

>  ci/install-dependencies.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 8700c0f292..a7c613ce4c 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -30,8 +30,10 @@ alpine-*)
>  		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
>  	;;
>  fedora-*|almalinux-*)
> +	awk=
> +	case "$distro" in fedora-*) awk=awk ;; esac
>  	dnf -yq update >/dev/null &&
> -	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
> +	dnf -yq install shadow-utils sudo make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $awk >/dev/null
>  	;;
>  ubuntu-*|i386/ubuntu-*|debian-*)
>  	# Required so that apt doesn't wait for user input on certain packages.

-- 
Todd
