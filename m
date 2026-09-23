Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356163BB687
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197672; cv=none; b=oNVtcJcEXv7y76vtYAgbLfQeEBwh7vxNYc+KFs+2wrqmxYASqdOscfw7uMoH1ZXOpJSh1TPDrqsJgHsIE68HAGECGElJynOFbfHaG6AN+G7FaUttV9eulVYQYum8rAELbEPLQCKH8xDNNLvGOfqncx6miLOQmdIc4TkkzA1yJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197672; c=relaxed/simple;
	bh=OfbCR+4lHXlW9o0q2lKlBiCICsqV7XPwYe7g1APAfuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWRwfjfg1c7NiMB291yfJXuKzEk2SLu6+0Zc+4s7Pw0F7HHyeL1JYVULInjQxepXU7sNBm8qf8DqVfEHl5R9AcXV7YW1dKIsy/ytBLkPOM9n6IyYmHYYgxwQN7Na2jYAmwyuj3mtVZhGEDbPDeVAWxZ55v0FhHKFfHn5MydwReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vq/uoxT8; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vq/uoxT8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so8211975e9.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 14:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790197662; x=1790802462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fJEbyeWysczahkWiNHAuOmdsQEM0YgTB+07yH8H0TyQ=;
        b=Vq/uoxT8EFbdFkj8Ld9MQUKe0m3vNEwZI07EdRfp3vXsMda/e73jRNPFpMnxfPAS5L
         TdmNU2Tz1z+PI/hrwB8YbB0jenBnxqbv8OcAzdQ8PAcwHj3KTv+s6jPmRA/lHlBzjNDx
         6ZgZe4gcmd7+gveCGMcT9Kd1ULbLG/GHIr5qeXeVbi6dXzKUsQddFivUJYXYtW8A0G3F
         +dNCfD/ktwiV0H+bWqwGKX5L/bjJ6YKeErFGDPXx2nTxryLBAQ22xlITMu0WGSKg9L/a
         eemNsg0ew9qF+//NaUa85ENd4ZsbMRSA97Wy+nK0ryXVX5R1ANdQkqHK9NG6rRRZFLRm
         AY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790197662; x=1790802462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJEbyeWysczahkWiNHAuOmdsQEM0YgTB+07yH8H0TyQ=;
        b=O35KmwVrF5SjE3uVtyJ8jW93b1/kwqH1+3bvNulssTBdC2Mqq01IB6fmCFikUv2I8g
         o9IApUTj6qgMneBJpaO++06mJBglT0Qa0geD8eiJ88ZsAbphE53ZS9Ept+8u/AHCjO4g
         Mf3LAEVfKztzdPvTuAhicv/f9C8lt/YD2jIChRh3nFDId9YVnLAbJtgqvuCWyhwdvhdn
         wZrO/ISac7lG2RXp9Hu9LlJLyex5Ok3jpiCukhP7+aBbyM5zMBHb8Hc2AKiOoHd1nCQY
         OvQTDKchHlSc0LVtnYC9zrqcoBak6X+kqAN+ic0CDlTyh58grdtqm7vyqzSbj3afDBQ3
         zGBw==
X-Gm-Message-State: AFuF++n+/q7ZaH3JCLrqBqKUvF3Sa2969D+P8SRpxUAuPxpp1KDUuAOD
	2CtOefHcCBI7ARE1pyz2Q6gwTt29a+M9Y9wSdaidcnPdcKDP/yIPMZHX
X-Gm-Gg: AYBFou0JLNyH6kgi6FkVhebcAVjVOdF//tB+q8QoEFo6GVE9tD57+DXGdo+YqAn0Plo
	AW3b7wh9TT6JlTAlGrrqLPzOFvWeVhypL2EYwEGFKgQZX0QnwqJaqpQT4YgWy+h2iyHnt80jwKV
	atLwsQeaE1TpZSh7csQSFCEg51eBH1Oi+EiMbiyoxAk3i3FU98QFChi4rdra8SCtWyiCwdUut1s
	4e8AEFMekYN7XdNoQrhJCLlr+YJ0p1MvLsy3shxhH/oMH34oagm0SNsxVEqd+1OliFxTff55ep+
	OC+w6KzxUpEvT2WenJFsZSf1iyEyxCsSf/xf50GTJ3ZO4aW34rzCEDq1GI8EtTYon/RYtzrs4VW
	t+F0qfuj/VmiXfkF5c5O8F1M6zda0QpsuHUQtqJwpLvIW9CaQuKimeVgXGcu60QUQiYvyneAKWW
	HwaT1Os5UqgzZ8l5BhgAMiTJTWpjJfkHLuAwYzjIJEjQiwUhy2kkOTcKEuLAfgIH31uQuPdNpr1
	ZaT4FClbjlfvI0VEvoXyqgQMOtC4gKCa/3SyVxB/my+J+TdJi2IbZN9A4VP
X-Received: by 2002:a05:600c:4f0e:b0:49f:d325:9912 with SMTP id 5b1f17b1804b1-49fe66d10femr7503075e9.10.1790197662117;
        Wed, 23 Sep 2026 14:07:42 -0700 (PDT)
Received: from localhost (20014C4D24E725002D05233788E8C45F.dsl.pool.telekom.hu. [2001:4c4d:24e7:2500:2d05:2337:88e8:c45f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cbd134sm14545755e9.9.2026.09.23.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:07:41 -0700 (PDT)
Date: Wed, 23 Sep 2026 23:07:40 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: graysongordon-gl <graysongordon1@gmail.com>, ps@pks.im
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v7] http: add http.sslVerifyStatus to check stapled OCSP
 responses
Message-ID: <arQ/nOH+o3XwQFD/@szeder.dev>
References: <xmqqecfez7ie.fsf@gitster.g>
 <20260915162348.97792-1-ggordon@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915162348.97792-1-ggordon@gitlab.com>

On Tue, Sep 15, 2026 at 12:23:48PM -0400, graysongordon-gl wrote:
> From: Grayson Gordon <graysongordon1@gmail.com>
> 
> git never sets CURLOPT_SSL_VERIFYSTATUS, so libcurl never requests the
> OCSP "Certificate Status Request" extension and any stapled response a
> server sends is ignored, including responses that explicitly state the
> certificate has been revoked.
> 
> Add an http.sslVerifyStatus boolean that maps to
> CURLOPT_SSL_VERIFYSTATUS. http_options() is already the collect_fn for a
> urlmatch config, so the per-URL form works with no changes:
> 
>     git config http.https://example.com/.sslVerifyStatus true
> 
> Defaults to false/"off". This is due to the nature of the OCSP protocol.
> If enabled, git would expect to receive OCSP stapled responses. If the
> stapled responses were not present, the connection would be blocked as
> the status of the server's certificate could not be verified. This would
> break connections to legitimate services that don't use OCSP as their
> certificate revocation mechanism.
> 
> If the backend can't check the staple, curl_easy_setopt() returns
> CURLE_NOT_BUILT_IN. The error message includes curl_easy_strerror()
> along with the option name, so a libcurl built without status
> verification is easy to identify.
> 
> CURLOPT_SSL_VERIFYSTATUS has existed since libcurl 7.41.0, below our
> 7.61.0 floor, so no version guard is needed.
> 
> The tests that need no OCSP infrastructure stay in t5551, which t5559
> runs over https. The rest need a certificate authority, a responder to
> answer for it and a server configured to staple, so lib-httpd gains an
> opt-in LIB_HTTPD_OCSP mode and t5585 uses it to check that a "good"
> staple is accepted, a "revoked" one is refused, and that the revoked one
> is ignored when the option is off.
> 
> Signed-off-by: Grayson Gordon <graysongordon1@gmail.com>
> ---

This patch was merged to 'next' the other day, and the last test in
the new t5585 fails on my system.

> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 115455784c..554b0e44fa 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -25,6 +25,7 @@
>  #    LIB_HTTPD_DAV               enable DAV
>  #    LIB_HTTPD_SVN               enable SVN at given location (e.g. "svn")
>  #    LIB_HTTPD_SSL               enable SSL
> +#    LIB_HTTPD_OCSP              enable OCSP stapling
>  #    LIB_HTTPD_PROXY             enable proxy
>  #
>  # Copyright (c) 2008 Clemens Buchacher <drizzd@aon.at>
> @@ -183,15 +184,26 @@ prepare_httpd() {
>  
>  	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
>  
> +	if test -n "$LIB_HTTPD_OCSP"
> +	then
> +		LIB_HTTPD_SSL=t
> +	fi
> +
>  	if test -n "$LIB_HTTPD_SSL"
>  	then
>  		HTTPD_PROTO=https
>  
> -		RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
> -			-config "$TEST_PATH/ssl.cnf" \
> -			-new -x509 -nodes \
> -			-out "$HTTPD_ROOT_PATH/httpd.pem" \
> -			-keyout "$HTTPD_ROOT_PATH/httpd.pem"
> +		if test -n "$LIB_HTTPD_OCSP"
> +		then
> +			prepare_ocsp_stapling
> +			HTTPD_PARA="$HTTPD_PARA -DOCSP"
> +		else
> +			RANDFILE_PATH="$HTTPD_ROOT_PATH"/.rnd openssl req \
> +				-config "$TEST_PATH/ssl.cnf" \
> +				-new -x509 -nodes \
> +				-out "$HTTPD_ROOT_PATH/httpd.pem" \
> +				-keyout "$HTTPD_ROOT_PATH/httpd.pem"
> +		fi
>  		GIT_SSL_NO_VERIFY=t
>  		export GIT_SSL_NO_VERIFY
>  		HTTPD_PARA="$HTTPD_PARA -DSSL"
> @@ -262,6 +274,114 @@ stop_httpd() {
>  		-f "$TEST_PATH/apache.conf" $HTTPD_PARA -k stop
>  }
>  
> +restart_httpd () {
> +	httpd_pid=$(cat "$HTTPD_ROOT_PATH/httpd.pid") &&
> +	stop_httpd &&
> +	while kill -0 "$httpd_pid" 2>/dev/null
> +	do
> +		sleep 1
> +	done &&
> +	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
> +		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
> +		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start
> +}
> +
> +# Check if the linked libcurl can verify stapled OCSP responses.
> +test_lazy_prereq SSL_VERIFYSTATUS '
> +	test "$HTTPD_PROTO" = "https" &&
> +	test_might_fail git -c http.sslVerifyStatus=true \
> +		ls-remote "$HTTPD_URL" 2>err &&
> +	! grep "http.sslVerifyStatus is set" err
> +'

When checking this prereq in t5585, I get the following trace:

  mkdir -p "$TRASH_DIRECTORY/prereq-test-dir-SSL_VERIFYSTATUS" &&
  (
  	cd "$TRASH_DIRECTORY/prereq-test-dir-SSL_VERIFYSTATUS" &&
  	test "$HTTPD_PROTO" = "https" &&
  	test_might_fail git -c http.sslVerifyStatus=true \
  		ls-remote "$HTTPD_URL" 2>err &&
  	cat err && # debug
  	! grep "http.sslVerifyStatus is set" err
  
  )
  + mkdir -p /home/szeder/src/git/t/trash directory.t5585-http-ssl-ocsp/prereq-test-dir-SSL_VERIFYSTATUS
  + cd /home/szeder/src/git/t/trash directory.t5585-http-ssl-ocsp/prereq-test-dir-SSL_VERIFYSTATUS
  + test https = https
  + test_might_fail git -c http.sslVerifyStatus=true ls-remote https://127.0.0.1:5585
  + cat err
  fatal: repository 'https://127.0.0.1:5585/' not found
  + grep http.sslVerifyStatus is set err
  prerequisite SSL_VERIFYSTATUS ok

I added that 'cat err' to see the error message.  Turns out that 'git
ls-remote' can't even find the repository on the remote, but the
prereq is still considered fulfilled.  Is that right?


In t5559 I get the following trace:

  + mkdir -p /home/szeder/src/git/t/trash directory.t5559-http-fetch-smart-http2/prereq-test-dir-SSL_VERIFYSTATUS
  + cd /home/szeder/src/git/t/trash directory.t5559-http-fetch-smart-http2/prereq-test-dir-SSL_VERIFYSTATUS
  + test https = https
  + test_might_fail git -c http.sslVerifyStatus=true ls-remote https://127.0.0.1:5559
  + cat err
  fatal: unable to access 'https://127.0.0.1:5559/': No OCSP response received
  + grep http.sslVerifyStatus is set err
  prerequisite SSL_VERIFYSTATUS ok

This time the error message talks about missing OCSP response, but the
prereq is still considered fulfilled.  Again: is that right?!

Instead of the lack of a certain string in the error message, is
there something positive that we can test instead?

> +# Set up a certificate authority. It issues certificate "httpd.pem"
> +# and is able to revoke it. Used instead of the self-signed
> +# certificate when LIB_HTTPD_OCSP is set.
> +prepare_ocsp_stapling () {
> +	LIB_HTTPD_OCSP_PORT=$((LIB_HTTPD_PORT + 10000))
> +
> +	# Referenced by ocsp-ca.cnf.
> +	OCSP_CA_DIR="$HTTPD_ROOT_PATH/ocsp-ca"
> +	OCSP_URI="http://127.0.0.1:$LIB_HTTPD_OCSP_PORT"
> +	export OCSP_CA_DIR OCSP_URI
> +
> +	mkdir -p "$OCSP_CA_DIR/newcerts" &&
> +	>"$OCSP_CA_DIR/index.txt" &&
> +	echo 1000 >"$OCSP_CA_DIR/serial" &&
> +
> +	openssl req -config "$TEST_PATH/ocsp-ca.cnf" \
> +		-new -x509 -nodes -days 2 \
> +		-subj "/CN=git-test-ca" -extensions v3_ca \
> +		-keyout "$HTTPD_ROOT_PATH/ca.key" \
> +		-out "$HTTPD_ROOT_PATH/ca.pem" &&
> +	openssl req -config "$TEST_PATH/ocsp-ca.cnf" \
> +		-new -nodes \
> +		-subj "/CN=127.0.0.1" \
> +		-keyout "$HTTPD_ROOT_PATH/httpd.key" \
> +		-out "$HTTPD_ROOT_PATH/httpd.csr" &&
> +	openssl ca -config "$TEST_PATH/ocsp-ca.cnf" -batch \
> +		-cert "$HTTPD_ROOT_PATH/ca.pem" \
> +		-keyfile "$HTTPD_ROOT_PATH/ca.key" \
> +		-in "$HTTPD_ROOT_PATH/httpd.csr" \
> +		-out "$HTTPD_ROOT_PATH/httpd.crt" &&
> +	cat "$HTTPD_ROOT_PATH/httpd.key" "$HTTPD_ROOT_PATH/httpd.crt" \
> +		>"$HTTPD_ROOT_PATH/httpd.pem"
> +}
> +
> +run_ocsp_responder () {
> +	openssl ocsp -port "$LIB_HTTPD_OCSP_PORT" \
> +		-index "$OCSP_CA_DIR/index.txt" \
> +		-CA "$HTTPD_ROOT_PATH/ca.pem" \
> +		-rsigner "$HTTPD_ROOT_PATH/ca.pem" \
> +		-rkey "$HTTPD_ROOT_PATH/ca.key" \
> +		-nmin 60 >>"$HTTPD_ROOT_PATH/ocsp.log" 2>&1 &
> +	echo $! >"$HTTPD_ROOT_PATH/ocsp.pid"
> +
> +	for i in $(test_seq 1 10)
> +	do
> +		if openssl ocsp -no_nonce \
> +			-CAfile "$HTTPD_ROOT_PATH/ca.pem" \
> +			-issuer "$HTTPD_ROOT_PATH/ca.pem" \
> +			-cert "$HTTPD_ROOT_PATH/httpd.crt" \
> +			-url "$OCSP_URI" >/dev/null 2>&1
> +		then
> +			return 0
> +		fi
> +		sleep 1
> +	done
> +	return 1
> +}
> +
> +start_ocsp_responder () {
> +	test_atexit stop_ocsp_responder
> +
> +	if ! run_ocsp_responder
> +	then
> +		cat "$HTTPD_ROOT_PATH"/ocsp.log >&4 2>/dev/null
> +		test_skip_or_die GIT_TEST_HTTPD "OCSP responder setup failed"
> +	fi
> +}
> +
> +stop_ocsp_responder () {
> +	if test -f "$HTTPD_ROOT_PATH/ocsp.pid"
> +	then
> +		kill "$(cat "$HTTPD_ROOT_PATH/ocsp.pid")" 2>/dev/null
> +		rm -f "$HTTPD_ROOT_PATH/ocsp.pid"
> +	fi
> +}
> +
> +# Revoke the certificate used by httpd and make both the OCSP responder
> +# and httpd aware of it.
> +revoke_httpd_cert () {
> +	openssl ca -config "$TEST_PATH/ocsp-ca.cnf" \
> +		-cert "$HTTPD_ROOT_PATH/ca.pem" \
> +		-keyfile "$HTTPD_ROOT_PATH/ca.key" \
> +		-revoke "$HTTPD_ROOT_PATH/httpd.crt" &&
> +	stop_ocsp_responder &&
> +	run_ocsp_responder &&
> +	restart_httpd
> +}
> +
>  test_http_push_nonff () {
>  	REMOTE_REPO=$1
>  	LOCAL_REPO=$2
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 4149fc1078..de5ca45bb8 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -242,6 +242,22 @@ SSLSessionCache none
>  SSLEngine On
>  </IfDefine>
>  
> +<IfDefine OCSP>
> +<IfModule !mod_socache_shmcb.c>
> +	LoadModule socache_shmcb_module modules/mod_socache_shmcb.so
> +</IfModule>
> +
> +SSLCertificateChainFile ca.pem
> +SSLUseStapling On
> +# Stapling needs a mutex, which apache would put in a system-wide
> +# runtime directory that need not be writable. Keep it in the server
> +# root, or httpd refuses to start instead of skipping the tests.
> +DefaultRuntimeDir .
> +SSLStaplingCache shmcb:ssl_stapling(65536)
> +# Staple non-"good" responses too, so clients get to see "revoked".
> +SSLStaplingReturnResponderErrors On
> +</IfDefine>
> +
>  <Location /auth/>
>  	AuthType Basic
>  	AuthName "git-auth"
> diff --git a/t/lib-httpd/ocsp-ca.cnf b/t/lib-httpd/ocsp-ca.cnf
> new file mode 100644
> index 0000000000..47a58139b5
> --- /dev/null
> +++ b/t/lib-httpd/ocsp-ca.cnf
> @@ -0,0 +1,35 @@
> +[ ca ]
> +default_ca		= CA_default
> +
> +[ CA_default ]
> +dir			= $ENV::OCSP_CA_DIR
> +database		= $dir/index.txt
> +new_certs_dir		= $dir/newcerts
> +serial			= $dir/serial
> +default_md		= sha256
> +default_days		= 2
> +policy			= policy_anything
> +email_in_dn		= no
> +unique_subject		= no
> +x509_extensions		= server_cert
> +
> +[ policy_anything ]
> +commonName		= supplied
> +
> +[ req ]
> +default_bits		= 2048
> +distinguished_name	= req_distinguished_name
> +prompt			= no
> +
> +[ req_distinguished_name ]
> +# The subject is always given on the command line via -subj.
> +
> +[ v3_ca ]
> +basicConstraints	= critical, CA:TRUE
> +keyUsage		= critical, digitalSignature, keyCertSign, cRLSign
> +subjectKeyIdentifier	= hash
> +
> +[ server_cert ]
> +basicConstraints	= CA:FALSE
> +subjectAltName		= IP:127.0.0.1
> +authorityInfoAccess	= OCSP;URI:$ENV::OCSP_URI
> diff --git a/t/meson.build b/t/meson.build
> index 3ca7b27104..72cbd12d8f 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -728,6 +728,7 @@ integration_tests = [
>    't5582-fetch-negative-refspec.sh',
>    't5583-push-branches.sh',
>    't5584-http-429-retry.sh',
> +  't5585-http-ssl-ocsp.sh',
>    't5600-clone-fail-cleanup.sh',
>    't5601-clone.sh',
>    't5602-clone-remote-exec.sh',
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 805bec025c..c51b14291d 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -680,6 +680,28 @@ test_expect_success 'passing hostname resolution information works' '
>  	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
>  '
>  
> +test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=true fails without a staple' '
> +	test_must_fail git -c http.sslVerifyStatus=true \
> +		ls-remote "$HTTPD_URL/smart/repo.git"

Shouldn't we check the error message, to make sure that the command
failed for the expected reason (here and in t5585 as well)?

> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=false is a no-op' '
> +	git -c http.sslVerifyStatus=false \
> +		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus applies to a matching URL' '
> +	test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=true" \
> +		ls-remote "$HTTPD_URL/smart/repo.git"
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus is not applied to other URLs' '
> +	git -c "http.https://example.com/.sslVerifyStatus=true" \
> +		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'
> +
>  # here user%40host is the URL-encoded version of user@host,
>  # which is our intentionally-odd username to catch parsing errors
>  url_user=$HTTPD_URL_USER/auth/smart/repo.git
> diff --git a/t/t5585-http-ssl-ocsp.sh b/t/t5585-http-ssl-ocsp.sh
> new file mode 100755
> index 0000000000..0d1310215f
> --- /dev/null
> +++ b/t/t5585-http-ssl-ocsp.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> +
> +test_description='verification of stapled OCSP responses via http.sslVerifyStatus'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +LIB_HTTPD_OCSP=1
> +. "$TEST_DIRECTORY"/lib-httpd.sh
> +
> +start_httpd
> +start_ocsp_responder
> +
> +test_expect_success 'setup repository' '
> +	test_commit one &&
> +	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
> +	git push "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" HEAD:refs/heads/main
> +'
> +
> +# lib-httpd.sh exports GIT_SSL_NO_VERIFY, which would keep us from ever
> +# looking at the certificate. Trust our own CA instead.
> +with_ssl_verification () {
> +	(
> +		sane_unset GIT_SSL_NO_VERIFY &&
> +		GIT_SSL_CAINFO="$HTTPD_ROOT_PATH/ca.pem" "$@"

According to our CodingGuidelines, a temporary variable assignment
like this should not be used for shell functions for portability
reasons.  In most test cases this is fine, becase "$@" is a git
command, but ...

> +	)
> +}
> +
> +test_expect_success SSL_VERIFYSTATUS 'certificate verification works against test CA' '
> +	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'fetch succeeds with stapled "good" OCSP response' '
> +	with_ssl_verification git -c http.sslVerifyStatus=true \
> +		ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'
> +
> +test_expect_success SSL_VERIFYSTATUS 'revoked certificate is rejected' '
> +	revoke_httpd_cert &&
> +	with_ssl_verification test_must_fail git -c http.sslVerifyStatus=true \
> +		ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
> +	test_grep -i -e "ocsp" -e "revocation" -e "revoked" -e "certificate status" err
> +'

... in this case "$@" is the test_must_fail shell function.

Please set and then export that variable instead; it's already in a
subshell because of the sane_unset anyway.

> +# Depends on the certificate revoked by the preceding test.
> +test_expect_success SSL_VERIFYSTATUS 'revoked certificate is accepted without http.sslVerifyStatus' '
> +	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> +	test_line_count -gt 0 actual
> +'

So this test case fails for me with the following trace output:

  expecting success of 5585.5 'revoked certificate is accepted without http.sslVerifyStatus': 
  	with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
  	test_line_count -gt 0 actual
  
  + with_ssl_verification git ls-remote https://127.0.0.1:5585/smart/repo.git
  + sane_unset GIT_SSL_NO_VERIFY
  + unset GIT_SSL_NO_VERIFY
  + return 0
  + GIT_SSL_CAINFO=/home/szeder/src/git/t/trash directory.t5585-http-ssl-ocsp/httpd/ca.pem git ls-remote https://127.0.0.1:5585/smart/repo.git
  fatal: unable to access 'https://127.0.0.1:5585/smart/repo.git/': server certificate verification failed. CAfile: /home/szeder/src/git/t/trash directory.t5585-http-ssl-ocsp/httpd/ca.pem CRLfile: none
  error: last command exited with $?=128
  not ok 5 - revoked certificate is accepted without http.sslVerifyStatus
  #	
  #		with_ssl_verification git ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
  #		test_line_count -gt 0 actual
  #	
 
libcurl is 7.81.0, apache is 2.4.52 (whatever is shipped in this
slowly aging LTS...)
