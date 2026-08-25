Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2A719E97B
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787618454; cv=none; b=D4X8/LZxUwCHxxmLnOAy1m2F+197wv+vsqL2niYU8nmVpTyX4/UODdGV5iIKC6mYExdmou31rmkWGGbB2NgH55rllcgn0wxZWX9bBXxalBh+1mxicdN1wuGqMjegBXEjRZuPM1Y/Lr3Ayd52Ppl/zC/79CLYCJwBVVLjFnjL5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787618454; c=relaxed/simple;
	bh=6Mfxer6eZIZEhB5WXWYVmAIugj0Qg6DNYzwuezHdovU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F9kUDPfsiBX5vm/A9/7mk2ZuuJd4NtItDrk++AnF5cbC2fB7NstgGOo2J92pjhhoQICHtqpUS0QHbwVYQoasYJgSU7HLY2dqrHi+gQW/EqVnGrrQFADbdY6CvhQKdrDgiRlH1tbRNEsieDzQgVN2mgfQyUIVNLwggbgRt0JS068=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0XX3aLxM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RKm18u+8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0XX3aLxM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RKm18u+8"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 40F24EC0501;
	Mon, 24 Aug 2026 20:40:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 24 Aug 2026 20:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787618451; x=1787704851; bh=PuB6tMB4Yz
	BjUWKgWf9VhUTkpcIbkKO60ZgkHBvLyFo=; b=0XX3aLxMUhdxZ13f5kcL+cEirV
	4WRAtE8Pq6TZtkqOqPFAMpfxZSlV7v4WA3nCBeHMFFI1J+d+oZmZ46/2p3+9GYxx
	kL2ML+gSeYQ+Lkbkni6BtIqBylY/WSpu5NRbmqNISUM5l/u09NnZqOPIs6T/huK0
	DIJEXTYd9bU7qz/Ps47EbvWmhFGAmkZLC5qehQ/Y9fMB51giflb3qpPs4207HbLU
	fxDX8TFutN75sKw4b9mUHUjP9Tf0XRRsm68T4Pqa6zCNnyVNrQCJtgAfSIGIthvO
	BOD4EeOf+2RRkJ9ODEo7GkUvMrBG3rBffTkYtdiyy+TyctEmSANC+0e0oWDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787618451; x=1787704851; bh=PuB6tMB4YzBjUWKgWf9VhUTkpcIbkKO60Zg
	kHBvLyFo=; b=RKm18u+85ci7rS3z+3RLVWjkxuksX8pxRhrULb+Yfcrhs15smKi
	7JjRURG8uS19LJj3OGJZWK4VsoCNtIhDa/bwQwtfVypGGtQsEqHezpGoMw1lFqiI
	3pSc+pRnDkD8/BLAMyTGAGN5iaRRLR4iVubqmhTpblhXcpD/KfZZqdfG+DlebyBn
	GNY3uxufex9S6W/slbHKzXXVYNnrlYokm/qxACRC7wMXDRGib4YyuInANyK8VPq2
	SbeOXsYa/3vidR6g1jvG3cWAtY37S9hUNRgBkBng+LfYT3IHz++Q6QI0GFQUQLwj
	u1HI7+GqaQybb/f5fDy7sDnPIjSviZ6WqAg==
X-ME-Sender: <xms:k-SMajqmcME5erK3mVnQ3cz4ku8svnG6rdIm38mwhS99aXYXp2dkCw>
    <xme:k-SMakqj9X5litaxDjstUVW1-cc_HXmBpG59IVRDuT_knlDRW8pLUiRc7rNTJvxVd
    YmToeR2cH1RBMaNDsK5PWRBnXCKd3e0jjKhrwirU7lnEMaeJ1X216Q>
X-ME-Received: <xmr:k-SMalMQbeHtieAsAHdCbsZyJ9RvBGNkHvdjDcuLK509W1jfLSo8f19aoLG3n5MCMmtH-eYuiW4giM_JcUX1r0x-Fj0siklspQ>
X-ME-Proxy-Cause: dmFkZTGDKccVYSg80PAlNU77roQZH2sz+4lFp1DurjbmhpRUiCiTmVARlxWjPgAhX1vi5Y
    l5irMkyST3SuuA1Uw7XZ7I/dv28Kuvzb4JSs27oJxZVKraVN/NpnsnBMrfnqzOqPfKTQZm
    aj9Pd7i4U24OIRc6Ec9W1MEOLp6bocylvuDPsDnr4sJMWcnNUg/nvsoW+5SexdhQ/cZZYY
    IGdCWWi3NAscElvfQJsJgt/HPxb3sWDfZQxN2+WrYhSCV/P0dVqNwBEjMn3A27pl7U0Isp
    Ywlbj38A0t5JIuFF/9OXbAHg1A4OSf/K2ZLhMmN29VIVPGZbpzHxhhrxvr/SMZHSod1OPo
    ZsUUCeokPrX5slKdt5Re5RNsCHmaPy8kIAR5/+kSM7/XJ0/NyHLXQEor3oFGRWsoPezhOv
    /atvynEKt+vb3MELLkwAWkkSbZ3/Dqg/F9RWghVnUGNkz1BjKWpmjT6N1o5RXGYSwO3MXA
    jpzJ+TQ1+tM7I50bBh2uBozU0GHw1sHS1P0yWO/pRxzi5O5QTNhDmtNvDpaXfdcLkyjQ4J
    ex5kSE9D0/aZDq4WgVwpjQdKVhXdg/nks9AwpqKChyJ8DQfwdKDiSUs/Kv2RsrycF4+zAI
    uqgWnYR8ag3duHqVO/wYdifW5Pjh1T2Cx5w8Frt78ypmUtK9g3/IF8PKlHag
X-ME-Proxy: <xmx:k-SMalyTvtemHsnUQzqMLJo2shYA-pxA7-St_mOVTH3VKweSEWSnDA>
    <xmx:k-SMauubmmJLo5S1UVqQEJtobsMXoI4RWJQYzXBqIKlIiV-hdWLw8Q>
    <xmx:k-SMau7SI7k2Xg4AeT23uVHbWzCuBG4-LPKql3uHiJgApI-tfBYjHA>
    <xmx:k-SMatS2FWN44HDpuyoImVcfq0kJMD0zyRkge-9Iqeqo7zndFElMWw>
    <xmx:k-SMakS95PP-MedAednaqKnIfE4NcYxCyUai87ziJ_Jmcs50_kvjRs2O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 20:40:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
Cc: Aaron Plattner <aplattner@nvidia.com>,  Rahul Rameshbabu
 <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] http: preserve wwwauth_headers across redirects
In-Reply-To: <xmqq8q60u82x.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	20 Aug 2026 08:26:14 -0700")
References: <20260819-http-preserve-wwwauth-redirect-v2-1-4c61039432b0@nvidia.com>
	<xmqq8q60u82x.fsf@gitster.g>
Date: Mon, 24 Aug 2026 17:40:49 -0700
Message-ID: <xmqqbjarowvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> For those of you who are watching from the sidelines, this v2 lacks
> the threading history.
>
> The v1 is at https://lore.kernel.org/git/20260602161150.1527493-1-aplattner@nvidia.com/

Any takers?  It should be quite easy to be more interested and be a
better reviewer in the http transfer codepaths than I am.

Thanks.

> Aaron Plattner <aplattner@nvidia.com> writes:
>
>> When cURL follows a redirect, it calls the CURLOPT_HEADERFUNCTION for
>> each header received including ones from a redirect. http_request() sets
>> fwrite_wwwauth() as the header function, which will record the wwwauth[]
>> entries for the last step in the redirection chain.
>>
>> However, when http_request_recoverable() sees that cURL followed a
>> redirect, it attempts to update the credentials for the request from the
>> new URL using credential_from_url(). The first thing that does is call
>> credential_clear(), which clears everything including wwwauth_headers.
>>
>> If the new URL should use a credential helper rather than credentials
>> embedded in the URL, this loses the list of authentication methods that
>> the server provided in the redirect.
>>
>> The WWW-Authenticate challenge is not derived from the URL; it is
>> populated from the server's response, and after a redirect it describes
>> how to authenticate to the redirect target and it needs to survive the
>> URL update so that credential helpers can know which authentication
>> methods are allowed.
>>
>> Add a new credential_update_url() that wraps credential_from_url() and
>> preserves wwwauth_headers specifically. Use SWAP() to avoid having to
>> copy the whole strbuf.
>>
>> Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
>> ---
>> I decided to come back to this after I noticed that at least one other
>> person had run into the same bug:
>>
>> https://lore.kernel.org/all/CADoNwcscDrx+YcfbcW4YKONDZZQgnPiwEOxL4QYV_C7_=FOFcg@mail.gmail.com/
>>
>> Rather than reworking everything about how credentials are stored, I
>> took your advice in [1] and just moved the code to preserve the wwwauth_headers
>> into credential.c. That way any future credential fields that need to be
>> preserved can be added there without having to hunt down other places
>> like http.c that are reaching into it.
>>
>> [1] https://lore.kernel.org/all/xmqqpl28scll.fsf@gitster.g/
>> ---
>> Changes in v2:
>> - Move strvec preservation into a helper function in credential.c
>> - Use SWAP instead of strvec_pushv() to avoid having to copy the
>>   contents of the strvec.
>> - Link to v1: https://patch.msgid.link/20260602161150.1527493-1-aplattner@nvidia.com
>> ---
>>  credential.c                | 16 ++++++++++++++++
>>  credential.h                |  8 ++++++++
>>  http.c                      |  9 ++++++++-
>>  t/lib-httpd/apache.conf     |  1 +
>>  t/t5563-simple-http-auth.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 78 insertions(+), 1 deletion(-)
>>
>> diff --git a/credential.c b/credential.c
>> index 2594c0c422..035399d7ee 100644
>> --- a/credential.c
>> +++ b/credential.c
>> @@ -708,3 +708,19 @@ void credential_from_url(struct credential *c, const char *url)
>>  	if (credential_from_url_gently(c, url, 0) < 0)
>>  		die(_("credential url cannot be parsed: %s"), url);
>>  }
>> +
>> +void credential_update_url(struct credential *c, const char *url)
>> +{
>> +	struct strvec wwwauth_headers = STRVEC_INIT;
>> +
>> +	/*
>> +	 * credential_from_url() clears the whole credential. Preserve the
>> +	 * WWW-Authenticate list, which is derived from the server's original
>> +	 * response rather than from the URL and is required to authenticate to
>> +	 * the new URL.
>> +	 */
>> +	SWAP(wwwauth_headers, c->wwwauth_headers);
>> +	credential_from_url(c, url);
>> +	SWAP(c->wwwauth_headers, wwwauth_headers);
>> +	strvec_clear(&wwwauth_headers);
>> +}
>> diff --git a/credential.h b/credential.h
>> index c78b72d110..b90f666e33 100644
>> --- a/credential.h
>> +++ b/credential.h
>> @@ -305,6 +305,14 @@ void credential_write(const struct credential *, FILE *,
>>  void credential_from_url(struct credential *, const char *url);
>>  int credential_from_url_gently(struct credential *, const char *url, int quiet);
>>  
>> +/*
>> + * Update the URL-derived fields (protocol, host, path) of an existing
>> + * credential to match a new URL. Unlike credential_from_url(), this function
>> + * preserves state that was derived from a server's HTTP redirect response,
>> + * such as the WWW-Authenticate headers.
>> + */
>> +void credential_update_url(struct credential *c, const char *url);
>> +
>>  int credential_match(const struct credential *want,
>>  		     const struct credential *have, int match_password);
>>  
>> diff --git a/http.c b/http.c
>> index a0d399b274..e8abb9f95a 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -2427,7 +2427,14 @@ static int http_request_recoverable(const char *url,
>>  	if (options->effective_url && options->base_url) {
>>  		if (update_url_from_redirect(options->base_url,
>>  					     url, options->effective_url)) {
>> -			credential_from_url(&http_auth, options->base_url->buf);
>> +			/*
>> +			 * Use credential_update_url() rather than
>> +			 * credential_from_url() so that the WWW-Authenticate
>> +			 * challenge the server sent with the redirect target's
>> +			 * response is preserved and handed to the credential
>> +			 * helper.
>> +			 */
>> +			credential_update_url(&http_auth, options->base_url->buf);
>>  			url = options->effective_url->buf;
>>  		}
>>  	}
>> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
>> index 4149fc1078..0627ef1433 100644
>> --- a/t/lib-httpd/apache.conf
>> +++ b/t/lib-httpd/apache.conf
>> @@ -203,6 +203,7 @@ RewriteRule ^/dumb-redir/(.*)$ /dumb/$1 [R=301]
>>  RewriteRule ^/smart-redir-perm/(.*)$ /smart/$1 [R=301]
>>  RewriteRule ^/smart-redir-temp/(.*)$ /smart/$1 [R=302]
>>  RewriteRule ^/smart-redir-auth/(.*)$ /auth/smart/$1 [R=301]
>> +RewriteRule ^/custom_auth_redir/(.*)$ /custom_auth/$1 [R=302]
>>  RewriteRule ^/smart-redir-limited/(.*)/info/refs$ /smart/$1/info/refs [R=301]
>>  RewriteRule ^/ftp-redir/(.*)$ ftp://localhost:1000/$1 [R=302]
>>  
>> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
>> index a7d475dd68..349ae4ab39 100755
>> --- a/t/t5563-simple-http-auth.sh
>> +++ b/t/t5563-simple-http-auth.sh
>> @@ -557,6 +557,51 @@ test_expect_success 'access using bearer auth' '
>>  	EOF
>>  '
>>  
>> +test_expect_success 'bearer auth after redirect preserves wwwauth headers' '
>> +	test_when_finished "per_test_cleanup" &&
>> +
>> +	set_credential_reply get <<-EOF &&
>> +	capability[]=authtype
>> +	authtype=Bearer
>> +	credential=YS1naXQtdG9rZW4=
>> +	EOF
>> +
>> +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
>> +	id=1 creds=Bearer YS1naXQtdG9rZW4=
>> +	EOF
>> +
>> +	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
>> +	id=1 status=200
>> +	id=default response=WWW-Authenticate: FooBar param1="value1" param2="value2"
>> +	id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
>> +	id=default response=WWW-Authenticate: Basic realm="example.com"
>> +	EOF
>> +
>> +	test_config_global credential.helper test-helper &&
>> +	test_config_global credential.useHttpPath true &&
>> +	git ls-remote "$HTTPD_URL/custom_auth_redir/repo.git" &&
>> +
>> +	expect_credential_query get <<-EOF &&
>> +	capability[]=authtype
>> +	capability[]=state
>> +	protocol=http
>> +	host=$HTTPD_DEST
>> +	path=custom_auth/repo.git
>> +	wwwauth[]=FooBar param1="value1" param2="value2"
>> +	wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
>> +	wwwauth[]=Basic realm="example.com"
>> +	EOF
>> +
>> +	expect_credential_query store <<-EOF
>> +	capability[]=authtype
>> +	authtype=Bearer
>> +	credential=YS1naXQtdG9rZW4=
>> +	protocol=http
>> +	host=$HTTPD_DEST
>> +	path=custom_auth/repo.git
>> +	EOF
>> +'
>> +
>>  test_expect_success 'access using bearer auth with invalid credentials' '
>>  	test_when_finished "per_test_cleanup" &&
>>  
>>
>> ---
>> base-commit: dea0ea3582e6980ddbc1173cc8e3e9f9db91cde0
>> change-id: 20260819-http-preserve-wwwauth-redirect-a3fe4dab6b35
