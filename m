Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6E1DDC3F
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745959; cv=none; b=Rflzda/B34Zyv1n6eS4Gc3lK9rYgi1PLZ5CanCOQDjMALLDoYAd90N7EOQUAa7DbUKKbzhaZIFmboY4LgmA1lpG1JVqXrE4RqZ9tvz7oFQW6sQtJ0JokJkXOPR0R7QNMKtbg7EUgffEwvIlFzKsS2zOIZDoe9d+Koq124MwD+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745959; c=relaxed/simple;
	bh=2PLYgZDpMXntg5snzb5hVShVwvdTHzu5v+LwO7JRVd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bjUSXc5X+wHExLj0PYzwUzRtQpQ+lbzVzrn6gsW55wtMHcbynTPdpfJ8AYYEAilk3Fv3I3RtsIgQ/z8LuPVhl51jub02om0nSPPZP1b57Db5JDDM12QJL1hfpjZh8In3xk0JisZhYjBuy8Go8YqCewYlhTDnKJ0JZY7LzQ7rZxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=baWJX2ym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHuNSnqK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="baWJX2ym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHuNSnqK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C99F41D000E1;
	Tue,  6 Jan 2026 19:32:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 06 Jan 2026 19:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767745956; x=1767832356; bh=ko3d/9hu2z
	q9N+dRamCBkaMBiyByOsunIc6LCc8NZjY=; b=baWJX2ym4xZV3oQXckizCLNW26
	57N/kmhJ9mMOuHnimQKRJNuPqt08N8sFnAdC0/zl6peE7+B0iEo1iUhO0kNprusA
	T9zezofpPYkAdnsFZAKND+oioOxhfI9RN9Oovog76wTsv0TlCoa7kRNrY3mnVBMr
	8BZbt8QC3hW0JFR5JgOSGIaMoSFq0JZ2l89AFCqrBmkWWj3j0Fje4DxrOqh9tfBh
	rvjC5eRM/C5vaCw7TH4SRqxnOUPPPorVckjH8WXIgz5NFesfJ5eQ4fi9r1tnHh/M
	KGrxtaXFGrWjyMbTgY1boaT/IA+UibWYsiIc381ljE8DQWXws548fMArWiGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767745956; x=1767832356; bh=ko3d/9hu2zq9N+dRamCBkaMBiyByOsunIc6
	LCc8NZjY=; b=EHuNSnqKT+dVCou16d7UI3dVBgeNhe82aI5RjFobRJdGxT8xZ46
	JeaEusH118vaT4Q+MnmUrGfFgfw4I0GGkpM/bTYDDMRtFwSLnA3BgsEHq0O9Xd3F
	W3k6iUuoQMmv0y3jD/6HSwzTKDCbtk8lP67bveOQS8L690RRZjPVP8nl7z+Al6Fp
	B6LqHbzj/sHW7JthifvfzaGFxhjhPHPjgr6tvTw5u0E6jUxhM3OMsxYmKH1aIoDe
	q7eRsafQcf2hQ+nZKrd5KruOwAiIR483y8W1TAdvDc2nUTnIk1tm2fgNe49YNKqG
	hvCCmSuPXayk4h04QhEcn9yd02Du9V9ug7Q==
X-ME-Sender: <xms:pKldabCVScQoEePD7PvglRrgbVq6FBvlgCzClSxp-NimCIhfBqhrKQ>
    <xme:pKldaYicP7Gx6sMcQeiC-ztzPR3Giu0sqSngdkdKsgfJEkvs3wioMA4ToGngj49sG
    HKMAJX7shTWgzm1IIQfxhYLrrn7M_T-_2p3dpPnCKQr_7jqwLwc>
X-ME-Received: <xmr:pKldabnjAUrKuLBS9t9WMiHUyWRX_AUyZSGE3lNpZz-vYjNJylwyGpE3bUeY5fxx-UQZvQViqddAEUf870yZFP07n5Tg9hQuy1rzYCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetiefhudehffetffejveeffeeive
    fgleffudeukedvieetvdffkeejgefhudekkeenucffohhmrghinhephhhtthhpugdrshhh
    pdhhthhtphdqfhgvthgthhdqughumhgsrdhshhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtse
    grshhhlhgvshhhrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pKldaco5EmvlFPGLsR65BsuOPUeKqCvAKi1DEKVPLDg0JGMtihXJyw>
    <xmx:pKldacFMJxZPLCdGO7bQYIHXauowhMuj0EcS2zfsCVl2yBfqauGqnA>
    <xmx:pKldaQxiMywf6xPpaPk7zkd2FGHONRpYxDXQfx3AyqMD_C2sJedBvQ>
    <xmx:pKldaZqa8k6QAUboY8Uvxkg4_WP7J1AHklngbR6dIjeffXYOnKpSqg>
    <xmx:pKldaUXVONoYbAVlEDvLVa3RQWFMJ0XToE3Bs5DCR9GbxhFLVERB-g-P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 19:32:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Ashlesh Gawande <git@ashlesh.me>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] t5550: add netrc tests for http 401/403
In-Reply-To: <20260106114029.763351-1-git@ashlesh.me> (Ashlesh Gawande's
	message of "Tue, 6 Jan 2026 17:10:29 +0530")
References: <20260106093451.748761-1-git@ashlesh.me>
	<20260106114029.763351-1-git@ashlesh.me>
Date: Wed, 07 Jan 2026 09:32:34 +0900
Message-ID: <xmqqwm1ui7od.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ashlesh Gawande <git@ashlesh.me> writes:

Here between the title and your sign-off is a space to explain why
it makes sense to add these new tests.  One way to do so may be to
explain that some cases were missing in the existing tests, and the
new ones are added to cover those cases, i.e., what the new tests
try to see under what situation, what behaviour do we expect out of
the system, and why do we expect that behaviour?

Thanks.

> Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
> ---
> Range-diff against v1:
> 1:  27e112ea42 ! 1:  0b68f1d1af t5550: add netrc tests for http 401/403
>     @@ Commit message
>          Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
>      
>       ## t/lib-httpd.sh ##
>     -@@ t/lib-httpd.sh: set_askpass() {
>     +@@ t/lib-httpd.sh: setup_askpass_helper() {
>     + 	'
>     + }
>     + 
>     +-set_askpass() {
>     ++set_askpass () {
>     + 	>"$TRASH_DIRECTORY/askpass-query" &&
>     + 	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
>       	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
>       }
>       
>     -+set_netrc() {
>     +-expect_askpass() {
>     ++set_netrc () {
>      +	# $HOME=$TRASH_DIRECTORY
>     -+	echo "machine $1 login $2 password $3" > $TRASH_DIRECTORY/.netrc
>     ++	echo "machine $1 login $2 password $3" >"$TRASH_DIRECTORY/.netrc"
>      +}
>      +
>     -+clear_netrc() {
>     -+	rm "$TRASH_DIRECTORY/.netrc"
>     ++clear_netrc () {
>     ++	rm -f "$TRASH_DIRECTORY/.netrc"
>      +}
>      +
>     - expect_askpass() {
>     ++expect_askpass () {
>       	dest=$HTTPD_DEST${3+/$3}
>       
>     + 	{
>      
>       ## t/lib-httpd/apache.conf ##
>      @@ t/lib-httpd/apache.conf: SSLEngine On
>     @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'cloning password-protected repo
>       '
>       
>      +test_expect_success 'using credentials from netrc to clone successfully' '
>     ++	test_when_finished clear_netrc &&
>      +	set_askpass wrong &&
>      +	set_netrc 127.0.0.1 user@host pass@host &&
>      +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
>      +	expect_askpass none
>      +'
>     -+clear_netrc
>      +
>      +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
>     ++	test_when_finished clear_netrc &&
>      +	set_askpass wrong &&
>      +	set_netrc 127.0.0.1 user@host pass@wrong &&
>      +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
>      +	expect_askpass both wrong
>      +'
>     -+clear_netrc
>      +
>      +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
>     ++	test_when_finished clear_netrc &&
>      +	set_askpass wrong &&
>      +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
>      +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
>      +	expect_askpass none &&
>      +	grep "The requested URL returned error: 403" err
>      +'
>     -+clear_netrc
>      +
>       test_expect_success 'http auth can use user/pass in URL' '
>       	set_askpass wrong &&
>
>  t/lib-httpd.sh             | 13 +++++++++++--
>  t/lib-httpd/apache.conf    |  4 ++++
>  t/lib-httpd/passwd         |  1 +
>  t/t5550-http-fetch-dumb.sh | 25 +++++++++++++++++++++++++
>  4 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 5091db949b..5f42c311c2 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -319,13 +319,22 @@ setup_askpass_helper() {
>  	'
>  }
>  
> -set_askpass() {
> +set_askpass () {
>  	>"$TRASH_DIRECTORY/askpass-query" &&
>  	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
>  	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
>  }
>  
> -expect_askpass() {
> +set_netrc () {
> +	# $HOME=$TRASH_DIRECTORY
> +	echo "machine $1 login $2 password $3" >"$TRASH_DIRECTORY/.netrc"
> +}
> +
> +clear_netrc () {
> +	rm -f "$TRASH_DIRECTORY/.netrc"
> +}
> +
> +expect_askpass () {
>  	dest=$HTTPD_DEST${3+/$3}
>  
>  	{
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index e631ab0eb5..6b8c50a51a 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -238,6 +238,10 @@ SSLEngine On
>  	AuthName "git-auth"
>  	AuthUserFile passwd
>  	Require valid-user
> +
> +	# return 403 for authenticated user: forbidden-user@host
> +	RewriteCond "%{REMOTE_USER}" "^forbidden-user@host"
> +	RewriteRule ^ - [F]
>  </Location>
>  
>  <LocationMatch "^/auth-push/.*/git-receive-pack$">
> diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
> index d9c122f348..3bab7b6423 100644
> --- a/t/lib-httpd/passwd
> +++ b/t/lib-httpd/passwd
> @@ -1 +1,2 @@
>  user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
> +forbidden-user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
> diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
> index ed0ad66fad..9530f01b9e 100755
> --- a/t/t5550-http-fetch-dumb.sh
> +++ b/t/t5550-http-fetch-dumb.sh
> @@ -102,6 +102,31 @@ test_expect_success 'cloning password-protected repository can fail' '
>  	expect_askpass both wrong
>  '
>  
> +test_expect_success 'using credentials from netrc to clone successfully' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@host &&
> +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
> +	expect_askpass none
> +'
> +
> +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 user@host pass@wrong &&
> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
> +	expect_askpass both wrong
> +'
> +
> +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
> +	test_when_finished clear_netrc &&
> +	set_askpass wrong &&
> +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
> +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
> +	expect_askpass none &&
> +	grep "The requested URL returned error: 403" err
> +'
> +
>  test_expect_success 'http auth can use user/pass in URL' '
>  	set_askpass wrong &&
>  	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
