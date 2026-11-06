Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976880;
	b=xVWw+LOP6htGKcwYp2k0F4W+1gEzHApElhKiOr/MhXgSDwl6IJQ0QxrOpQB/7plChAxw
	 Lj4giQb7o5IKkB3LMb4Z5zayD5OGQhAe+BuU41ewaL0nOVuDfGMDjFtxzzkhHsel1ZBZ1
	 yx1884pNCsjHMMeoD07t03/r53C0SiCg4QVdaGb5hwlRQdF3YjBCHTYJ1KdHzt57qZ7mG
	 H6JKBCaJr8nVlWQrg+GGQHDEvm0o9lxSkj6lk7HPY8L1emfMgZ1goOELpW0ZCcVOlIxJX
	 Bf8iCrSprW2daFByg1H5ODKyDcXxMy9VZb39hCsfIWgFm+rr22a8OaDGoCOgfT7KSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976880;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tUvYeubA/b7NuEOtx6EGoHJyZkjfsQ2OUry3KDLtUNg=;
	b=34LDLBFVN39REM+5GBJv7O4ThLvvVjne7xk6TvnGVyln+gzApgfRK52I/BwdmOx8xMaq
	 HFCpu9Zfx9Zu1A6eFxYBMDiAFIAJmt9ChePfnp3WeuPokCCeAe5nWFROSF9sSR4Q0mWZI
	 5fom1g6k6AUssN2GxK+MtBHkY/aV6pDfcMN2lXYi/1u62xkVqlKXWkll62CZ1rnEfMRBb
	 O5iRNG7yRM/ewhS0lRJeLI++sr22+sboxPkwhQ6o8Mk2KmFT6MfNU1mcwYFdUyxoHdKXl
	 /eufQJCn2Fz/Z26ROrmzXE8f7CjcfRqd2iihK6jm1K9sZ+EhkOWQLAsPFEkoxguy5Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=mLI4tXau;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xNei0nFB;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD481606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD481606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=mLI4tXau;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xNei0nFB
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 97B721D00082
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:54:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 06 Nov 2026 09:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793976878; x=1794063278; bh=tUvYeubA/b
	7NuEOtx6EGoHJyZkjfsQ2OUry3KDLtUNg=; b=mLI4tXaur+4xa/X4gyHTdQkF6M
	3OKOoYE9RqCG7gIgSw/SCCg6Y3k45BXY3kJvOHefyv+fQ+7NZdxoqpO284y2CpgD
	gPy/v3D5L/DqxVj42nbnF8va9naSuw38SP/PA1M/qS8h3nEc8fyXs+RocmmZ094j
	t/FYzfimj0kdBUPAcKLvAGwsSPPcCVnbSSFAfn0Qgeo7bQYL4VN44CUn7fMvn3E9
	D4zgYK4r6JzZGwiWYgCUJ4a1se+nGv3D4vbDXMEXR0Vp/dn22400IrTF1RWaRk/b
	BHq6CfEtDhU4ri2gGjmTK/4xxw+yReADksXYP5fyZdSRgSRMFsBz9XvbFfnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793976878; x=1794063278; bh=tUvYeubA/b7NuEOtx6EGoHJyZkjfsQ2OUry
	3KDLtUNg=; b=xNei0nFBEAzBjldBZg0df5VqTxuNncqb7J5uiPdKmDHDj7T5sWi
	tj6k6SZXU6WFKQe7A8TaZ/zxL11z7ywEbU1OykfIc+4QVSoSM3qWa+SZNUMnHYnM
	rxvsbPVDwniLDs4yd0C+PRvYIKsulkiEV6jfdeSH9b8+B7vnMh7A46TZOYRL1Wdz
	uxahIselolNSCXjzEpd8scaJj9MpnJwbm4VhgzfKbQQg0GDpQlUJAAHcFVbQD8vY
	gALprQSve2+g1Gn7helXWE0OtEp/nxly5ceUyrHbdbtZjx7srf7dMdfBRdL+lhYg
	RDwxd//EDyIG5+xivoM5D4Ur0ksqT5i9KtA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793976878; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:dpDR68kLIsiUUfZnpSn04ypA+RCHxVV4eRPRpg5HnJeZCFK
	UMZn6Sfr+ProMHs8wLqdTxNRw+JBhrQCOt1YiSFawnZMpuxmPr2HPt7nLlDGmv/k
	GFWPYnVNcDinbTM5Iv3baU0zSS3WkRimBq+EteCQK6Z3mOv3YLw35otPDiEbmv+Y
	yquZfzDv8lWb+u9XhDpmtjURvqnVgfS1P6/KfcmwIRfjk3j2nyYrkZ2uP/w5g0Ly
	tkUFSQQypS0EvfLLZr7nNgoeq/vfmdBDSIEa9IRw70afvQeRV7y6hBVLnHPtTtgV
	iNE1vkRNgS6f9miPtD5tdBYRXOd02brifOHVcbg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nweIErZhriRGkr/g8vC4k3Z1crXXf5XGElFhet9akKw=:yx7NSHgOxMjaYHXXyUENi2g9yLch4a2a2qjoB6glBPs=;
X-ME-Sender: <xms:LurtatB7EK9o1BilSZbfS4LrkTjFK7Lw_yH7fvL3BjvAPhZ0DFSz7Q>
    <xme:LurtaihYMECEOKSofFmTiiOCcxQK5Q990moE0lHm2TXartLYvNOtJhYw1AP0yv9zc
    ITAuIQbCkieLYetVAYf-JSNPeUJxKPuWFTe9sT0FEpRlfkCy4x9-RU>
X-ME-Received: <xmr:LurtatmGkybJM1gjv1DqL0i91hcAYyvMBNt7wcBPNBvKVxCjvrb5sFpIX7AHX4oFqeJuaQ>
X-ME-Proxy-Cause: dmFkZTE7tXr5TMZ+TFwLGaUzkCdfmYBSFaSArvfivZHZhluCRVOJ2WpuxkdSx/AKJEZG96
    J6KaLroNbwvnXWZ4Q7icMVkYFo54EJMW9QMXzDO//+HOdzUml4z8+yESxdUCy+TqqPyN7Q
    MjubYPyelFTeuWlqY6+oeMfmo1OI0cKO/HY2m0SDQPEFcOkqqfNzlbAs2csl/PHbGX/kzD
    gibR7RS5/fw3S/RFjr3mdtSdEM8H2eHxAvR/9X8WBrYvHHVPui3gRZPUVNGxVMxDBg8I+S
    xLg+/heTFel03Js2wqPV76ktbhY5lv9cey7+Yxcax33P1TS0UoMR1suzCEJikNGVfLdLPI
    fJ2ewO8dy7uA9nw5nAIiyg94riansnxh7A9eiPpOqTS2PnWrJGNAzDI19QMTS9CGO4xRdK
    Z8PA8ANo5u/Y+cdRMgQts0m4efs54G9/Rbdd6QOdvM3yHf3lN6SSKeKaCzufawrVNC4aFs
    V5HjeB0bYq/vHIR50PZp5qwuPJSNkP9wDYw/05EZCv74gIIKdZR1DyoniR3jkpZhY+2i3P
    xV+dMLw9y9A7FB08Qf9xByST9xGogFnBtf1Z7MezF8PG3L/6x8uSyaGbokWtnKSTD9FsF3
    rw3keVRCLsA8/q+QNWYQdJjfIC8x91R+QQWVD/XRs4qmnIiHJsvSLEHNkalw
X-ME-Proxy: <xmx:LurtampuI09N5QsMm7wumrssFNY5KTbHm9achN84cDdE9pNZS8C39Q>
    <xmx:LurtauF0QuovmB5HBKSYLXjKNHIGGRF8Y4vA4XHkS1AWo7FhgAz0Lw>
    <xmx:Lurtaqw3UJ_wGv0_xwvcC0ds8iEJ_r9ytDacH1fzVK7TK3ECm-pJmg>
    <xmx:LurtarpPp-lH1KFfwKVU5d2k_yoeVxkC3J-TEKmMVjaMO0w5DJtv4w>
    <xmx:LurtarXPaT3bkTsdHT5R8yqJH2-YRouUWx_Ij8LtI0gmvkjXhwgg-ShO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:54:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 84c10f2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 14:54:35 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:54:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH 2/2] t5608: assert that the packs involved really are
 that large
Message-ID: <au3qKLWlM45rByWg@pks.im>
References: <pull.2299.git.1793969476.gitgitgadget@gmail.com>
 <6c6abee65cb3987978b982e69f227e408c0bf408.1793969476.git.gitgitgadget@gmail.com>
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
In-Reply-To: <6c6abee65cb3987978b982e69f227e408c0bf408.1793969476.git.gitgitgadget@gmail.com>

On Fri, Nov 06, 2026 at 12:51:16PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> From: Kristofer Karlsson <krka@spotify.com>
> 
> t5608 was added in ca31f0b5c2 (Add an (optional, since expensive) test
> for >2gb clones, 2009-03-06) to construct a repository larger than 2GB
> and clone it.  It already anticipated that the setup might stop doing
> what it is meant to do: "Should that break in the future, e.g. when
> pack v4 becomes default, there is a commented-out call to
> test-genrandom which can be substituted".
> 
> It did break, silently, with d9545c7f46 (fast-import: implement unpack
> limit, 2016-04-25).  The setup writes only 24 objects, which is below
> the default fastimport.unpackLimit of 100, so fast-import does not
> keep its pack but turns it into loose objects.  Since the blobs
> compress very well, the repository has less than 10MB of loose
> objects, and the bare clone merely copies those.  Only the file://
> clone still deals with a pack larger than 2GB, because the sending
> side generates a new pack from the loose objects.
> 
> The ">4GB object" tests added in 4b220cafbe (t5608: add regression
> test for >4GB object clone, 2026-05-08) have a similar problem.  They
> are meant to cover a fix in both index-pack and unpack-objects, but
> "git clone" always keeps the received pack, so setting
> fetch.unpackLimit in the unpack-objects variant has no effect, and
> both tests use index-pack.

So this test in particular never exercised what it was designed to?

> Nothing noticed any of this, because the tests only check that the
> commands succeed.  Add assertions on what each test relies on, so
> that it fails when its setup no longer does what it is meant to:
> 
>  - the pack created by the setup, and the packs of both clones, are
>    larger than 2GB;
> 
>  - the synthesized pack with the >4GB object, and the pack written by
>    the index-pack clone, are larger than 4GB;
> 
>  - the unpack-objects variant really runs unpack-objects, as seen in
>    its trace2 output.

Makes sense.

> Some of these assertions fail with the tests as they are, so fix them:
> 
>  - Set fastimport.unpackLimit=0 in the setup.  fast-import then
>    keeps its pack regardless of how few objects it contains, so the
>    repository, and the bare clone that copies it, have a pack larger
>    than 2GB again.
> 
>  - In the unpack-objects variant, use "git fetch" into an empty
>    repository instead of "git clone".  Unlike clone, fetch honors
>    fetch.unpackLimit, so with five objects and a limit of 100 the
>    received pack really is passed to unpack-objects.

And the preceding patch fixes a third assertion that we'd otherwise have
seen fail here, I assume?

> As a bonus, keeping the fast-import pack also makes the test cheaper,
> because unpack-objects no longer hashes and compresses all of the 2GB
> of data a second time.  Locally, the time spent in the setup is
> roughly reduced from 80 to 40 seconds.  The test runs in all CI jobs
> via GIT_TEST_CLONE_2GB, and is among the slowest tests there.

Nice.

> diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
> index 5d56debf1c..9d7152486e 100755
> --- a/t/t5608-clone-2gb.sh
> +++ b/t/t5608-clone-2gb.sh
> @@ -9,12 +9,28 @@ then
>  	test_done
>  fi
>  
> +size_2gb=2147483648
> +size_4gb=4294967296
> +
> +# The tests below are only meaningful if the packs involved really are
> +# that large, so check it explicitly instead of trusting the setup.
> +test_has_pack_larger_than () {
> +	max=$(test-tool path-utils file-size "$1"/*.pack | sort -n | tail -n 1) &&
> +	max=${max:-0} &&
> +	if test "$max" -le "$2"
> +	then
> +		echo >&2 "largest pack in '$1' is $max bytes, expected more than $2" &&
> +		return 1
> +	fi
> +}
> +
>  test_expect_success 'setup' '
>  	git init 2gb-repo &&
>  	(
>  		cd 2gb-repo &&
>  		git config pack.compression 0 &&
>  		git config pack.depth 0 &&
> +		git config fastimport.unpackLimit 0 &&
>  		blobsize=$((100*1024*1024)) &&
>  		blobcount=$((2*1024*1024*1024/$blobsize+1)) &&
>  		i=1 &&
> @@ -39,14 +55,20 @@ test_expect_success 'setup' '
>  	)
>  '
>  
> +test_expect_success 'setup produces a pack larger than 2GB' '
> +	test_has_pack_larger_than 2gb-repo/.git/objects/pack $size_2gb
> +'

Nit, not worth a reroll: I would have folded this into the test itself.

> @@ -59,24 +81,29 @@ test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'set up repo with >4GB object' '
>  		4gb-repo/objects/pack/test.pack) &&
>  	git -C 4gb-repo index-pack objects/pack/test.pack &&
>  	git -C 4gb-repo update-ref refs/heads/main $head_oid &&
> -	git -C 4gb-repo symbolic-ref HEAD refs/heads/main
> +	git -C 4gb-repo symbolic-ref HEAD refs/heads/main &&
> +	test_has_pack_larger_than 4gb-repo/objects/pack $size_4gb
>  '
>  
> -test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'clone >4GB object via unpack-objects' '
> -	test_when_finished rm -rf 4gb-clone-unpack &&
> +test_expect_success SIZE_T_IS_64BIT,EXPENSIVE 'fetch >4GB object via unpack-objects' '
> +	test_when_finished rm -rf 4gb-fetch-unpack &&
>  	# The synthesized pack has five objects, so a large unpack limit keeps
> -	# fetch-pack on the unpack-objects path.
> -	git -c fetch.unpackLimit=100 clone --bare \
> -		"file://$(pwd)/4gb-repo" 4gb-clone-unpack &&
> +	# fetch-pack on the unpack-objects path.  This needs "fetch", as
> +	# "clone" always keeps the received pack.

This is a bit of a surprise to me, I thought that it would apply to both
git-clone(1) and git-fetch(1). Did you by any chance check whether this
is intentional or whteher it's another bug?

> +	git init --bare 4gb-fetch-unpack &&
> +	GIT_TRACE2_EVENT="$(pwd)/trace-unpack" \
> +		git -C 4gb-fetch-unpack -c fetch.unpackLimit=100 fetch \
> +		"file://$(pwd)/4gb-repo" main:refs/heads/main &&
> +	test_subcommand_flex git unpack-objects <trace-unpack &&
>  
> -	# Verify the large blob survived the clone by comparing its OID
> -	# between source and clone.  We cannot use "cat-file -s" because
> +	# Verify the large blob survived the fetch by comparing its OID
> +	# between source and destination.  We cannot use "cat-file -s" because
>  	# object_info.sizep is still unsigned long, which truncates >4GB
>  	# sizes on Windows.  OID equality proves content integrity since
> -	# the clone already verified checksums via index-pack/unpack-objects.
> +	# the fetch already verified checksums via unpack-objects.
>  	source_blob=$(git -C 4gb-repo rev-parse main^:file) &&
> -	clone_blob=$(git -C 4gb-clone-unpack rev-parse main^:file) &&
> -	test "$source_blob" = "$clone_blob"
> +	fetched_blob=$(git -C 4gb-fetch-unpack rev-parse main^:file) &&
> +	test "$source_blob" = "$fetched_blob"
>  '

Other than that this looks good to me, thanks.

Patrick
