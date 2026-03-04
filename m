Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E8358371
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610203; cv=none; b=QCAINlw5rtxP/BxiEPijosXqavskd9+11Kc0aIIUHiAm4DBYRMWgIgUTuZdR+KKO77dAjy3x9rOKDJ5Oh34iLWVAC8FmQclRDtvOyrBU/T7taDvVlKAwCwf/UnLrV5Wi5xuIOc4twu45O6djAoHQ/uDdOFa8WWUGTV/Eb10hKw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610203; c=relaxed/simple;
	bh=ZYYJ+PbnI5ibJLf/rRkfuHfAjuxEsa8GIKCBAaQBdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INtS+SEH3F0NrR+QqlTfbB2a6dqOXnI+5E2O72gNYIM3UcI7sWskb8bOu99b82Ue+pSQ/oDNjvJ6TUTLe7cpol48fmdesGmFzkV3+SgKKIHBDen9of2AHQqhifI3VY+C1W8PuH0h4vtJNvG451T2y6x3CsSzwjEd/A9seZ7ifnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E2RpHWk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n32zYjZr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E2RpHWk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n32zYjZr"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B759EEC04DC;
	Wed,  4 Mar 2026 02:43:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 04 Mar 2026 02:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772610201; x=1772696601; bh=fUE6S4oGv+
	YTA5kibQ0MLkniMvPpEQ3SrpcBaBMjHX8=; b=E2RpHWk7+Hs+iiCP380yk6g1N8
	ynccc3LIjtR02I0CF3svzRWpEHdQHNnkD8ldR0AITSOqhwNILXGQnlECQPs0hkPs
	K+PzH5wtW/ORpi6Ej0NdlayFcFEtx0YBFsFuEeGHe2gt6DpZZN0yH/5XMvEEhmqX
	xZoLlIS4NHKPXv4kvTfsZn9RA17rPLKpkZYdacP46V6OJuc5/LP8bEwTGzWy3G0g
	CIvdpHQtBzDfdP+LlnRMbkosUNH3vPdQNFTIeIq03MekZ+a28YUfx7EmLn8ODt+C
	3ak8y3iQfEPvk0ari+k1wttb3NF/OFiAbOD2ty9sriPWn32Eucw1bXcSY2qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772610201; x=1772696601; bh=fUE6S4oGv+YTA5kibQ0MLkniMvPpEQ3Srpc
	BaBMjHX8=; b=n32zYjZrNqmcnj+6/gctmiNpskrCGsYCVgeOyIpLNkYJDMg+tiR
	/atBYv2t+coas9OIJuR2N/zKQfOSBOghxeoqSyxjPYUKJoPiGnqctVVhba8QIzOI
	H5BZ8Z0OLLzBmYgxnJSoGgXz+3q+0pQrkjZKvp9+LGpI3lNqjddgdMXMBe2GDF+i
	zMdtYp70S1tuRURfO6+NreZkqeqpxnQMs3YRYp1v4kFwd9jBKpbJ1Dxk3vDFAe4H
	gmQWNGVLcScGwh4ZMU5yg9qg58bcaX/QZDn7lISdlRn5hcyJNB81dtMPoA9693KX
	+NCQOQRwP1KOqm5EUe0jAiolYQkkrommFug==
X-ME-Sender: <xms:meKnaVBWRixysqWNAjeMsoXykMjXsi1SyD2Dpm_8FVjNLe8wYcg1hA>
    <xme:meKnaa-XEK9fz4jQJD38TL7tBxOPzEU3NIhdGQJWGaefxSBMssnDoQwm8O3BWAHc9
    S_-b2liczR0aDsj68-iKf_H2foIak2r7bdZJ5mIjD0BSQKnpi0h>
X-ME-Received: <xmr:meKnad_XKT4v7Zlssy84BzQjQ3KV0ZTPYPetMHgz2qU7zujN8ffP6KLDGCpUk9ZVCzHuCiIPf4ItKWf-8zLuez3VK46E1buxv894cnGtQIFRqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhthhhusg
    esphgruhhlihhsrghgvggvkhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgv
    thesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:meKnaZfHIVzth6bFLnK8gW460kDdtNOQw2tdqJuMwNmZnezCQgBFbQ>
    <xmx:meKnaeEgSe-12Om1Zhl7jaoYCmOY5pifFn2s5cwRdmfWJoPlnZIsQg>
    <xmx:meKnafemqg0_8f53xJx0fziL37OMnFQnNdpRCon_ayn3NliMErov4g>
    <xmx:meKnaQELMq-0rrhCQHBfjYaTFEhiY3LZhTrDhQkDS0DZ0ut7MrykVQ>
    <xmx:meKnaZZ3i7YHWsXIhbO-ya9UNpAq8W3d3BTGj6t5UyHwZS8may2l6oNP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 02:43:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c748f26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 07:43:20 +0000 (UTC)
Date: Wed, 4 Mar 2026 08:43:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v7 10/10] fsmonitor: close inherited file descriptors and
 detach in daemon
Message-ID: <aafilb7FnvWBTQ0J@pks.im>
References: <pull.2147.v6.git.git.1772050636.gitgitgadget@gmail.com>
 <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
 <4987a009a2e74a04aa1a8deb0508c971a3df0549.1772065643.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4987a009a2e74a04aa1a8deb0508c971a3df0549.1772065643.git.gitgitgadget@gmail.com>

On Thu, Feb 26, 2026 at 12:27:23AM +0000, Paul Tarjan via GitGitGadget wrote:
> From: Paul Tarjan <github@paulisageek.com>
> 
> When the fsmonitor daemon is spawned as a background process, it may
> inherit file descriptors from its parent that it does not need.  In
> particular, when the test harness or a CI system captures output through
> pipes, the daemon can inherit duplicated pipe endpoints.  If the daemon
> holds these open, the parent process never sees EOF and may appear to
> hang.

Oh, interesting.

> Set close_fd_above_stderr on the child process at daemon startup so
> that file descriptors 3 and above are closed before any daemon work
> begins.  This ensures the daemon does not inadvertently hold open
> descriptors from its launching environment.
> 
> Additionally, call setsid() when the daemon starts with --detach to
> create a new session and process group.  Without this, shells that
> enable job control (e.g. bash with "set -m") treat the daemon as part
> of the spawning command's job.  Their "wait" builtin then blocks until
> the daemon exits, which it never does.  This specifically affects
> systems where /bin/sh is bash (e.g. Fedora), since dash only waits for
> the specific PID rather than the full process group.

Hm. We already have related logic in `daemonize()`. Should we maybe
reuse that function, and potentially expand it to handle closing all FDs
up to the maximum file descriptor?

> Add a 30-second timeout to "fsmonitor--daemon stop" so it does
> not block indefinitely if the daemon fails to shut down.

This feels like a "while-at-it" change to me. Should it maybe be moved
into a separate commit?

> diff --git a/t/meson.build b/t/meson.build
> index 85ef2ae2fa..19e8306298 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1210,18 +1210,12 @@ test_environment = script_environment
>  test_environment.set('GIT_BUILD_DIR', git_build_dir)
>  
>  foreach integration_test : integration_tests
> -  per_test_kwargs = test_kwargs
> -  # The fsmonitor tests start daemon processes that in some environments
> -  # can hang.  Set a generous timeout to prevent CI from blocking.
> -  if fs.stem(integration_test) == 't7527-builtin-fsmonitor'
> -    per_test_kwargs += {'timeout': 1800}
> -  endif
>    test(fs.stem(integration_test), shell,
>      args: [ integration_test ],
>      workdir: meson.current_source_dir(),
>      env: test_environment,
>      depends: test_dependencies + bin_wrappers,
> -    kwargs: per_test_kwargs,
> +    kwargs: test_kwargs,
>    )
>  endforeach
>  

Might make sense to reorder commits a bit so that the fix comes first.
In that case we wouldn't ever have to introduce the timeouts in the
first place.

> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 774da5ac60..d7e64bcb7a 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -766,7 +766,7 @@ do
>  		else
>  			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
>  				git config core.fsmonitor true &&
> -				git fsmonitor--daemon start &&
> +				git fsmonitor--daemon start --start-timeout=10 &&
>  				git update-index --fsmonitor
>  			'
>  		fi

This change feels unrelated and is not mentioned in the commit message.

> @@ -997,7 +997,17 @@ start_git_in_background () {
>  		nr_tries_left=$(($nr_tries_left - 1))
>  	done >/dev/null 2>&1 3>&- 4>&- 5>&- 6>&- 7>&- &
>  	watchdog_pid=$!
> +
> +	# Disable job control before wait.  With "set -m", bash treats
> +	# "wait $pid" as waiting for the entire job (process group),
> +	# which blocks indefinitely if the fsmonitor daemon was spawned
> +	# into the same process group and is still running.  Turning off
> +	# job control makes "wait" only wait for the specific PID.
> +	set +m &&
>  	wait $git_pid
> +	wait_status=$?
> +	set -m
> +	return $wait_status
>  }

I thought with our call to setsid() we're not part of the same process
group anymore. So why is this change here still needed?

Patrick
