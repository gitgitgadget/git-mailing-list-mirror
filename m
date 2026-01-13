Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA029B78D
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286953; cv=none; b=VKDwfoR6RQtrXw5mH8W3oVtK/w7WeWnEqUq3ZpRZANZsrz1GEAkK11RMTvmOlTAx5QLz3AnsuzthNEOs8qjuS19lgIKif/GW+0UW+YUL5NN9gzpGOCJmnLPyhE8DzQeEK64ovLS8cPp/025gn6FReRJg5Sgsfuy1+Os+rHuxICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286953; c=relaxed/simple;
	bh=ajsQT38B8xi1rJwbc+CozWia3zPiqqNQ7kbzpEj3+cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOkaywO7/VIVxM8KtXVmqkNfWghEL3QfOGgqjlM7qRfxJVP50nUMMuZ+/zUhQn5CcCSUjbFVoc7YrqR9QSzVo/M9w7a8ZYknExU3WZfN4Z4yuKILgAAgMfoH+tZNsMzrylplKjTwYWm08C8sIfNkUtwbpu7eBDxaO5SyNWaHty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPb6gpL/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pWiBYRIm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPb6gpL/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pWiBYRIm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD1FA1400192;
	Tue, 13 Jan 2026 01:49:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 01:49:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768286950; x=1768373350; bh=x+o1wjVhdb
	s0u0kSpU6HfshlUHbFDkZa/QIcYWWw9As=; b=WPb6gpL/BL0lOy+L9m34mhTP9i
	NQCZ9lIm16NI38w2ibXXdGm/Fpk9If/0dN+Mqe4qgHjJzYEVaFFPWpfMyxjzQKOG
	yIQ6oSzr2s2uQD7hDA+NBBvJg6UJQzakZgfxnhDfdZPWb/XhWLwFA6lcClLpAd9F
	GzUX6KRjXUitXRUUQwUp27nDVLDZ/KlIsAbicY4C9A5W+2TxToVtPcL8cRx1k6QQ
	lSHci1jld/Mghlqc9ZlhioLcyouYtNINL6xqGHTZUjBRCnQlZCZPCugZKFaeheud
	K4QQK7+tsNrG7NiQ69vEBZ2cC6tl7RB08W/JXu25hOv/ixXn53EeZmEo3FKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768286950; x=1768373350; bh=x+o1wjVhdbs0u0kSpU6HfshlUHbFDkZa/QI
	cYWWw9As=; b=pWiBYRImDmItuge9H54zm0Qe+Y5vbHKXo79aSN/9wDc3ysWf4eK
	z3WFb0g3I6J17TDoPjVanJvICBNUfOCarp3AMuOo8jhhfU2AMiSMxzrTZXj8T+Hr
	7hPi8yS1YwNUYOrkyXAVDFlwgaK+wuo9nYlc/8uqcPcXGxNsatYC9gBsIeoqlG4p
	j9YCS8o7JGWI6aXJugOVvJGAYAmMNp3gq3+L42CyLzbGj7PPe7oAAfHFme4mx9Dl
	15bLGzF3t7LM6KNb+PjGH5hvncOsf3xFHEQ0r8ORnrqdpVK/e8qwVMypwykCGy5e
	bp4DjhEpe5JCeguBOQT8sNbNfpcFocEqZ0A==
X-ME-Sender: <xms:5uplaWLr17DEigd1lziKTOpB3wwRhzhKVqrleVHkoTh6lfpzpxiUTg>
    <xme:5uplaVIF8KbBMxAbdxHQp1oYnaNjOzuYvibgjycxeTa8_UbT9SAK6v-KNYy9ioUxO
    Tlm8gnHg8kE2AhYSv9xgYM11bPwu7lZEdVmgpglbe-F9XYLLq1XX-Q>
X-ME-Received: <xmr:5uplabv9eyqgdMzfgz99zip_2r5T-f-KlEv4TZeS5UPFlJPPfW8us1Wl4l1u7e5yOR9-8s50wJTj9O2uKB1mC5oPDZDvPNueCdL2ZmnsbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudelieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    eptddthffhtedvteduteehjedvtdfggfegtdfftdefjeeguddtuedtueeigfehvddtnecu
    ffhomhgrihhnpehhthhtphdqrghuthhhrdhshhdpphhoshhtsghufhhfvghrrdhinhdpvg
    igrghmphhlvgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopeguvghmrghrtghhiheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprh
    hrrghmvghshhgsrggsuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5uplaaQYRWgf6pLzS0o7FE1x97Ekugx7688hSzHToStLRX5AcGMUcQ>
    <xmx:5uplaZMLABbdQpeSt7eOVSzGRAgk4N_N6SaLBujL_Jn-w6Go7HDreQ>
    <xmx:5uplaXZNhdygRYezQYcKVCG_JPuF20WGAApJC_lbA8ma7_ZKP5wFAw>
    <xmx:5uplabwSDe2XFB-eG_d24ytyG-A9Ei_NYHh7zLUts_n10lD5KH7FzQ>
    <xmx:5upladq31iSwtYwsY4DqQswMxpxLF4p6WIjvhckCa67MohKe4x9Hro2t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 01:49:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1322d683 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 06:49:08 +0000 (UTC)
Date: Tue, 13 Jan 2026 07:49:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Lucas De Marchi <demarchi@kernel.org>
Subject: Re: [PATCH v2] remote-curl: Use auth for probe_rpc() requests too
Message-ID: <aWXq3Lrzx9NGnwGb@pks.im>
References: <20260113031929.3746753-1-aplattner@nvidia.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113031929.3746753-1-aplattner@nvidia.com>

On Mon, Jan 12, 2026 at 07:19:28PM -0800, Aaron Plattner wrote:
> If a large request requires post_rpc() to call probe_rpc(), the latter
> does not use the authorization credentials used for other requests. If
> this fails with an HTTP 401 error and http_auth.multistage isn't set,
> then the whole request just fails.
> 
> For example, using git-credential-msal [1], the following attempt to clone a
> large repository fails partway through because the initial request to download
> the commit history and promisor packs succeeds, but the
> subsequent request to download the blobs needed to construct the working
> tree fails with a 401 error and the checkout fails.
> 
> (lines removed for brevity)
> 
>   git clone --filter=blob:none https://secure-server.example/repo
>   11:03:26.855369 git.c:502               trace: built-in: git clone --filter=blob:none https://secure-server.example/repo
>   Cloning into 'sw'...
>   warning: templates not found in /home/aaron/share/git-core/templates
>   11:03:26.857169 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>   11:03:27.012104 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:03:27.049243 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>   11:03:27.049270 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:03:27.053786 run-command.c:673       trace: run_command: 'git credential-msal get'
>   11:03:27.952830 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:03:27.952849 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:03:27.995419 http.c:849              <= Recv header: HTTP/1.1 200 OK
>   11:03:28.230039 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>   11:03:28.230208 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:03:28.230216 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>   11:03:28.230221 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:03:28.269085 http.c:849              <= Recv header: HTTP/1.1 200 OK
>   11:03:28.684163 http.c:890              == Info: Reusing existing https: connection with host secure-server.example
>   11:03:28.684379 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:03:28.684391 http.c:849              => Send header: Accept: application/x-git-upload-pack-result
>   11:03:28.684393 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:03:28.869546 run-command.c:673       trace: run_command: git index-pack --stdin --fix-thin '--keep=fetch-pack 43856 on dgx-spark' --promisor
>   11:06:39.861237 run-command.c:673       trace: run_command: git -c fetch.negotiationAlgorithm=noop fetch origin --no-tags --no-write-fetch-head --recurse-submodules=no --filter=blob:none --stdin
>   11:06:39.865981 run-command.c:673       trace: run_command: git remote-https origin https://secure-server.example/repo
>   11:06:39.868039 run-command.c:673       trace: run_command: git-remote-https origin https://secure-server.example/repo
>   11:07:30.412575 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:07:30.456285 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>   11:07:30.456318 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:07:30.456439 run-command.c:673       trace: run_command: 'git credential-cache get'
>   11:07:30.461266 http.c:849              => Send header: GET repo/info/refs?service=git-upload-pack HTTP/1.1
>   11:07:30.461282 http.c:849              => Send header: Authorization: Bearer <redacted>
>   11:07:30.501628 http.c:849              <= Recv header: HTTP/1.1 200 OK
>   11:07:34.725262 http.c:849              => Send header: POST repo/git-upload-pack HTTP/1.1
>   11:07:34.725279 http.c:849              => Send header: Content-Type: application/x-git-upload-pack-request
>   11:07:34.761407 http.c:849              <= Recv header: HTTP/1.1 401 Unauthorized
>   11:07:34.761443 http.c:890              == Info: Bearer authentication problem, ignoring.
>   11:07:34.761453 http.c:849              <= Recv header: WWW-Authenticate: Bearer error="invalid_request", error_description="No bearer token found in the request", msal-tenant-id="<tenant>", msal-client-id="<client>"
>   11:07:34.761509 http.c:890              == Info: The requested URL returned error: 401
>   11:07:34.761530 http.c:890              == Info: closing connection #0
>   11:07:34.761913 run-command.c:673       trace: run_command: 'git credential-cache erase'
>   11:07:34.761927 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-cache erase' 'git credential-cache erase'
>   11:07:34.768069 git.c:502               trace: built-in: git credential-cache erase
>   11:07:34.768690 run-command.c:673       trace: run_command: 'git credential-msal erase'
>   11:07:34.768713 run-command.c:765       trace: start_command: /bin/sh -c 'git credential-msal erase' 'git credential-msal erase'
>   11:07:34.772742 git.c:808               trace: exec: git-credential-msal erase
>   11:07:34.772783 run-command.c:673       trace: run_command: git-credential-msal erase
>   11:07:34.772819 run-command.c:765       trace: start_command: /usr/bin/git-credential-msal erase
>   error: RPC failed; HTTP 401 curl 22 The requested URL returned error: 401
>   fatal: unable to write request to remote: Broken pipe
>   fatal: could not fetch c4fff0229c9be06ecf576356a4d39a8a755b8d81 from promisor remote
>   warning: Clone succeeded, but checkout failed.
>   You can inspect what was checked out with 'git status'
>   and retry with 'git restore --source=HEAD :/'
> 
> In this case, the HTTP_REAUTH retry logic is not used because the
> credential helper didn't set the 'continue' flag, so
> http_auth.multistage is false and handle_curl_result() fails with
> HTTP_NOAUTH instead.

Nice, this is a helpful little detail.

> diff --git a/remote-curl.c b/remote-curl.c
> index 69f919454a..1d0ae72521 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -877,6 +877,8 @@ static int probe_rpc(struct rpc_state *rpc, struct slot_results *results)
>  	headers = curl_slist_append(headers, rpc->hdr_content_type);
>  	headers = curl_slist_append(headers, rpc->hdr_accept);
>  
> +	headers = http_append_auth_header(&http_auth, headers);
> +
>  	curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0L);
>  	curl_easy_setopt(slot->curl, CURLOPT_POST, 1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, rpc->service_url);
> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> index c1febbae9d..adc210cdd3 100755
> --- a/t/t5563-simple-http-auth.sh
> +++ b/t/t5563-simple-http-auth.sh
> @@ -63,6 +63,26 @@ test_expect_success 'setup repository' '
>  	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
>  '
>  
> +test_expect_success 'setup large repository for probe_rpc testing' '
> +	rm -rf large.git &&

No previous test creates this directory, so it shouldn't ever exist.

> +	git init large.git &&
> +	(
> +		cd large.git &&
> +		git config set maintenance.auto false &&
> +		git commit --allow-empty --message "initial" &&
> +		# Create many refs to trigger probe_rpc, which is called when
> +		# the request body is larger than http.postBuffer.
> +		#
> +		# In the test later, http.postBuffer is set to 70000. Each
> +		# "want" line is ~45 bytes, so we need at least 70000/45 = ~1600
> +		# refs
> +		printf "create refs/heads/branch-%d @\n" $(test_seq 2000) |
> +		    git update-ref --stdin
> +	) &&
> +	git clone --bare large.git "$HTTPD_DOCUMENT_ROOT_PATH/large.git" &&
> +	rm -rf large.git

You can use "test_when_finished rm -rf large.git" before creating the
repo to ensure it's always getting pruned at the end of the test.

> +'
> +
>  test_expect_success 'access using basic auth' '
>  	test_when_finished "per_test_cleanup" &&
>  

I think we can simply inline this setup into the below test. We only use
it in that specific test anyway.

> @@ -605,6 +625,32 @@ test_expect_success 'access using bearer auth with invalid credentials' '
>  	EOF
>  '
>  
> +test_expect_success 'clone with bearer auth and probe_rpc' '
> +	test_when_finished "per_test_cleanup" &&
> +
> +	set_credential_reply get <<-EOF &&
> +	capability[]=authtype
> +	authtype=Bearer
> +	credential=YS1naXQtdG9rZW4=
> +	EOF
> +
> +	# Bearer token
> +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
> +	id=1 creds=Bearer YS1naXQtdG9rZW4=
> +	EOF
> +
> +	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
> +	id=1 status=200
> +	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com"
> +	EOF
> +
> +	# Set a small buffer to force probe_rpc to be called
> +	# Must be > LARGE_PACKET_MAX (65520)
> +	test_config_global http.postBuffer 70000 &&
> +	test_config_global credential.helper test-helper &&
> +	git clone "$HTTPD_URL/custom_auth/large.git" partial-auth-clone 2>clone-error
> +'
> +

Yup, I've verified that this test fails when the bug fix is reverted.
Good.

You might want to reroll to address my two nits around the test, but
even without that reroll I'm already happy with this v2. Thanks!

Patrick
