Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812388;
	b=LH2LuZoXsn1gSyNr9qbymaTPti4ivfOWS1oeG9/DjcHucNEZbBitpfmRB42IHG08HART
	 AFu9TIa37z6qFiTN0bz20hRRZWRdAaej8kQmRqchZMw1h9L3W6p+mtlMIbT2caxKbWcoz
	 1pIXrchiEmD7QGHvFDfah1td+f6vpj5wMEn4zz9iyz/YUp/OuOP0MnyOvYjrb5TKyDVde
	 8zSQJ9IuTnJkySkbscOi5JqEhOu9NBbpVGHoMresq6PbfyUg7E5EMsTaD3lc1slIZC129
	 8sAt5JK/OcHIOF/jhV4Ob6PCvfSmYfVGMh+LrpleiBMOColK9DXSdlub2+j0xutQhsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812388;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=w5XYJsS5vbbAydTfLNMUBsM9dZBNhzRy65jvofQdLu8=;
	b=aT8j2+xLQM3NPxVJUYQ3pdSHFyc1P60NMU6lwQhgnnu/xxAMEc1urHQZZYMXNtGBtJBY
	 uHN9b4AQBHAKJ8QQQa2pKFMPWiMjFFoN+c/XLbHOIFLItPrB+FolghOriA834EnwmFiTI
	 rQwxDxwoUgSpaY47tWyDtKhahMq5Ok+PCvlhI/WluFcOaNgGKeelYd4rx4Gt/XmFqC/ry
	 jnWVGbTsIX61gpw5Q6OwlMYx7KeCTjHq7BASMcNBJXSaY9jQnC8E6Z5fI1XcjzU847imZ
	 Q+jFiGD0mecH+JyGiAcX88Yo5/rFQ5qFsqL8ezdyX0uaG2h6cgsWAPYVnEiReMEyjRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eQ5IBXzz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1xfMrta3;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D4606A31C
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 20:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 503D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=eQ5IBXzz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1xfMrta3
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E057EC0B76
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 15:46:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 27 Nov 2026 15:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795812387; x=1795898787; bh=w5XYJsS5vb
	bAydTfLNMUBsM9dZBNhzRy65jvofQdLu8=; b=eQ5IBXzzgyk0jMxKcAdy1mKCA2
	bUraqsj6IyOk+I1j95gj+yBpApkhA3P3a0O3PCgCSVDcVgYT7zDV2oB2O59yOivL
	icYjw8dalfwTeBkK0r0u2o/6uSI/YygddvJDqjPPrPCRhuZ+OFhucZuwplHLKVG/
	HgY7cV0BTPNj5Bv1m0jV3emDB5eCwSrDre/MUGcCveorn3xBCFy7a0yR5r9GMZTf
	arpjbbXZB78PnnarJIL0g++rDHOEn9ey5RIk9D2u8GzLH/827UL7YzpxcA0JjDwq
	y1cH5RvXaIQ/l5JdWT31rvHFPRTn/lbHU9A73Xpi2CB/9YUq05aza4/4ijFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795812387; x=1795898787; bh=w5XYJsS5vbbAydTfLNMUBsM9dZBNhzRy65j
	vofQdLu8=; b=1xfMrta3hMivd8tmwu7zhQ4FrpFJ/DvtEomPbNvN8utTsT4gbcN
	nJE/F5bSZwezJVSxHn8ISjafcntH3u2hRjX3CBLA1lDybEB5vc1w2b7l6UtKUTAC
	3LCaM7p1yZF1SVLaJnSGB0fJt1C6VpBUv8/ffGsGmDtdGqGVYMM4eQ57QPB470XY
	BppqFwSVhC/so0Efkrt4vNFDECGhxoC4COXO0mpK4XEBhkowFiFVAA7P2mkl2Q29
	luv+KIKOvXTUwLQhyjLyLZM5qS92xgWdnOzPqqX1b7eY671Ipwu6jTTWr9qLW2oa
	8Zuq53ZR2pGF0d75BdrL0XbGjq/HoVLfJXw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795812387; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ehQ1y1Lxm+M37kVHrrVU/NU/MRXxGNFKObki7G1F1SI4/XG
	6sBrf6eQ1G+8iuVbr22i3+db9bYes/zbYO78jipuL5Hnhl9HP7d0Nr3043/ue9nN
	ne5QQ3idcbaQhcLZr0ZFi7UI37xzjrSZqc3gqBtemraUBv+5kvvAFU8W5SslU1Bw
	f/ttiqaZ7Vi4djnHehIBDV6XZXDMF2rOl9yHQlXkCnReDdv4I5tDCcT857jfiB1G
	bLWFCi00QqkHUJcdY2X0doHsyjzZJ6XKRyemsxM95HzmgWhfht8M+TkKIAgTAE+M
	oVi03tX2oeChIv2q+EOVfgJPuSnQG2iOSCznl2w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tR3SNEDds94IjIGucYkAbb694lkX6LBreDL+mvVHQeQ=:PgRV5yFgnqb3JT0jswnAnMA1jFuKWFPp9ypXUtrD54c=;
X-ME-Sender: <xms:I-wJa1_1ftRRsQbP-PiM1x2MQXz7pAPgFdwFCfE6XtRUqMipIRkuYw>
    <xme:I-wJawuURIO2NeBtqwvfZ6KKm2s3C9iL8z7liAOn97yDQwmh9YrpTrIpeJQVCu8nC
    hwQ52ert2s3iXtBsMGjhmCz_pItPIyeJl_FApbjd6ZuX3oW32--hvo>
X-ME-Received: <xmr:I-wJa4D4QvMnvrxxKlQrMye3nm16yFycchILq3LCPVDm_Puvbb9WbhHnNcESF_ywmXOJ0ozRSFkNXAHef6gDI0z8tgBvQMFnK9yxQMc>
X-ME-Proxy-Cause: dmFkZTFGHoqp+qToA1FpIDOLTrmWhp/mjoWxuzt3dvevcNO2nyofBgm1jkKe6rmR2UonQr
    N6lNAD34l0sI6QXNpykUcuvxVQA5qyeWb82v1sPrKAXd9hj9cTMMr0XSe8ZX827GhE9cB4
    ehQLVsarOYDarDruZIDEOQBQXy/h52Ymria/yo8RwVf6tmxJhTDti1YJFOgyf/y2iO+nC6
    jYEHc7HswcAVdvDtvHy1NyaHUXxBHEPpBDs6SUCmUr4j88C8/0PWzNJGwEHB60RwijcQbx
    hAQ9g6Ch8MwLn7COtZlvzBgYNoY213v2Jzo8nY1UrUVosmhbtTtyS/l3tGJjuFmr/hd5by
    tItY3xgHLAadxUd6ezrHpfvjpqA3A7eGEXi/SgsIbK+kdXZ+YVt3PyJocpiX48926RAJG9
    +TxzDE4mGzG8MnTc8eRnkhhUdkcvmm/izBJ26V/GmZgujFejbaA9qVMSES0gmwNcFsxNaf
    Ru7veOEmL2jIodAELW1JDjcoEX/pS3/EnNp3jHYAMazbVjik6zdOC6wUHz5qcHgQO+Yvyt
    S2Ij/agjPyidriRWrQyv3iE0CWoFoPS1A/Vw35izEQIOtCFu4J3pGjeDHY/VA481ntGF+x
    +CgondYRncgsEeYavrkJwweYmADJbX8qgYHwsjpHdPZ3SC6H02hGQIcb0KMQ
X-ME-Proxy: <xmx:I-wJa4Xc5q1shdRODV0Xcv3QDKb139Fg4cWTtA6TzMwHLDSRngpCpg>
    <xmx:I-wJa2CYSMMg0Gynl9ZFiOlIAEo_oESd8spTxTfQmfuBrVdlWrQ3oQ>
    <xmx:I-wJa79u5WVIepaZWs-ZafMonyNgpeEQP9C8-M_KXYqGW5clL7pT-Q>
    <xmx:I-wJa9HULsbwMiM8APVrek6WxNdLpMq6eWVpCqukfsOi9VDyJjhRgw>
    <xmx:I-wJa7i-oZk9rTNLCX6WhQnEuiI__zZ8BK3OuCOJKlvRHiCCIA_dDXbz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Nov 2026 15:46:27 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3] test-lib: run EXPENSIVE tests one at a time
In-Reply-To: <20261127-ks-ci-long-test-hang-fix-v3-1-91b2aac82a1c@gmail.com>
	(Kaartic Sivaraam's message of "Fri, 27 Nov 2026 22:53:15 +0530")
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
	<20261127-ks-ci-long-test-hang-fix-v3-1-91b2aac82a1c@gmail.com>
Date: Fri, 27 Nov 2026 12:46:25 -0800
Message-ID: <xmqqpkvq6lzy.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Recently, we've acquired quite a few expensive tests in our test suite.
> For instance, these commits add several tests that require
> multi-gigabytes of memory:

Either "multi-gigabyte" or "multiple gigabytes"?

> GitHub CI runners are no exception and observe the same behaviour.

Pedantic.  You "observe" that runners "experience/suffer from/trigger".
They do not observe themselves ;-).

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c56654b7c5..916ec2d7d1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -784,6 +784,8 @@ die () {
>  	# test script run with '--immediate' fails, or when the user hits
>  	# ctrl-C, i.e. when 'test_done' is not invoked at all.
>  	test_atexit_handler || code=$?
> +	release_expensive_lock_
> +	test -z "$expensive_lock_" || rm -f "$expensive_lock_.$$"

Minor ordering observation.  Because "trap die EXIT" is registered right
after die(), well before fail_117() where release_expensive_lock_() is
defined, an early failure while sourcing test-lib-functions.sh under set
-e would enter die() while release_expensive_lock_() is still undefined.

I notice that "$expensive_lock_" already has a test -z guard here, and
that would help avoid such issues to some degree.  Defining the lock
variables and helpers above die() (or guarding the call) would close
that small window.

> +acquire_expensive_lock_ () {
> +	local owner waited= tmp="$expensive_lock_.$$" misses=0
> +	mkdir -p "$TEST_RESULTS_DIR" || return 1
> +	# The lock is a hard link to a file that already holds our PID, so
> +	# it never exists without its owner recorded in it. Remove any
> +	# $tmp left by a dead process with our PID first: it may still be
> +	# linked to that process's lock, which writing to it would empty.
> +	rm -f "$tmp"
> +	echo $$ >"$tmp" || return 1

This pre-cleanup and hard-link scheme is neat.  Removing any leftover
"$tmp" before writing "$$" keeps us from truncating the inode of a stale
lock still hard-linked to an old "$tmp" from a recycled PID, and
hard-linking after writing "$$" guarantees $expensive_lock_ never exists
empty.

One minor consistency note.  When ln(1) fails three times with no lock
present, acquire_expensive_lock_() prints "cannot take the EXPENSIVE
lock, running anyway" to FD 3, removes "$tmp", and returns 0.

If mkdir or redirecting to "$tmp" fails instead (say, a read-only
TEST_RESULTS_DIR or a full disk), it returns 1 silently and leaves an
empty "$tmp" behind on write failure until die() runs.  Because
test_run_() ignores the return value, the test still runs anyway as
documented, though sharing the same cleanup, message, and return 0 would
keep all fallback paths consistent.

> @@ -1103,6 +1170,12 @@ test_run_ () {
>  		fi
>  	fi
>  
> +	case ",$test_prereq," in
> +	*,EXPENSIVE,*)
> +		acquire_expensive_lock_
> +		;;
> +	esac

Because test_expect_success() and test_expect_failure() call test_skip()
first, skipped tests never enter test_run_(), and the chainlint dry-run
above this block runs before we take the lock.  Placing the lock around
test_eval_() and outside its set -x block also keeps the polling loop
out of -x trace logs under CI --verbose-log -x, while still releasing
the lock before _error_exit() on --immediate failures.

Optional thought.  A small subtest in t/t0000-basic.sh seeding a stale
expensive.lock with a dead PID or "$$" and checking that it is cleared
and released (including under --immediate) could give quick regression
coverage without any sleep delay.

Overall this is clean and well thought out.

Very nice.
