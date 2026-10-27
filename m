Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112791;
	b=3CwNxYcY8hIFfbLHkDfJyNGUbBi9+Prbpx/cjzxNHBAwoloIhRXqXb8Jl4gUkCBUtLZA
	 pxk2/+pMfOXcMX6ao2RUzWkpCDTn0TYkMJwuTr6Aq/Jh6x0t6LbgzmJ7nD+8sY7QiaZw1
	 yEnuF1RN9RDL7NcQnTaSZBL5VItLV/0y5unxEq5dVmM5rLb1NyK8l6mvPnxrB00oOcRv+
	 IF9ZqTuZXuG/jnV7RKr278uvwde5ZCiwgumfhl6zWqvPU4AgncsYM8hz3VYYYBG1arZy+
	 5qCmo8422T4jWUSF/LOPDfpjA6CD2kYP5Wf/bNoeZLNvGXielVEt5y1IVNZKkRS7pXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xO4jLi3LNN4vGFBx8TqUL3BxSHS9MtomDzn5AS9hAGY=;
	b=JED3uQNnt/gJ7WOCJkNZn31tWeBaVPFak2FFZOQwP7gGsym5CXEEp5/ngJQTwYQWkD5Q
	 79VF3p/AqIxvYXYqO2g5R5eIsA1LFbbLMv6A4XnXf9RiJh4sIrWPOXnDagfDKQtOdN1eR
	 cQgu/a+7VsBxk+rVKXVAzG+PJ16Rk6rMPIqComTyyN+mIeS95Qxa/D1/BV+T4ftLRfm/4
	 Snf2bcyCgzhV1KOo3D0MCb/Ab5fpAMbSuxJozSa51qpXDDZeDMUt5BkEMo31qZ4SLpELq
	 gK+W0DLdmZHv+zSlV3vI+YGAwdBliceAxGFUofe3Zj87qZH+rt7PggfdCf0PGsun9Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YY0Z4b4a;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF8C606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YY0Z4b4a
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so37542975e9.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793112790; x=1793717590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xO4jLi3LNN4vGFBx8TqUL3BxSHS9MtomDzn5AS9hAGY=;
        b=YY0Z4b4aqApBgSdAcI2NLb0PGGhL9FtVJb9TDk+UQlxMyp2gMpov4TZX9LsgIUZD5n
         mErOzgEYvsR+N1mOJC/SdET05ifdzjtvmlKcbfsQuhzSHypBwYhXaSzrElo+kfg9zgdj
         mBwDPMZLWNBFPahJKAtS6GEypkBRDlsXDW0ztu7ln5Go1ro2jszmrebEpp8AFp8++beR
         XsxHaf9Iy3LF3USJKPuzu5h3jkxPu4L8AfZLyIRC8m+mD/h9Sk6DPj7tKI4mp4VRdzQy
         AI7Zqb6q0YhNA4VdB5shHhvxOqIkwHcb2WOqm+ExTUAmYt7jhlMpVelGh9bxtIi0eHjI
         Zelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112790; x=1793717590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xO4jLi3LNN4vGFBx8TqUL3BxSHS9MtomDzn5AS9hAGY=;
        b=arW5CU4sk0BeSgXOj905FlDrQoxW3ICzZpHPG2+sRrg8ruLo45RbEqA038ZPoI2Mik
         RHeIQAfmlYdlgrrR+kwzVbBO8GEQux7ITfGbbqFZnku8zsrbrZPkI2jviDCrDHdJIy9O
         uOH/6Pr7dJP0loelsNOHs4VxeCBpl5cOQaydyUVB42rDbVCalRZ746XT4XIwALr0c3ak
         DFeFO89JHPcE5Db8SVNz9U2R5hpKxrBbEeQjXHKu+Ijt/tEu6vDPL9IlEiuiKU/peLpf
         t/80v9qTFJeRsAuSQkdFRt85R/w62+ykvt6hr916zAFRIugE36JlUfXNQY6uGpxJpuEF
         oIvA==
X-Forwarded-Encrypted: i=1; AKwUvBwv0yosnlo/SVeG/8Z48iKpqYUnnY5JYvLVIa6LxOS579h12bIV7lfCx28BN+Yi9QZEfok=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwJivxFUpk9lmLHNQ3qK9IUNZPQ+ehLopPXhg9YWybGes4FP4H
	W8/NZilNn1trpWA8D0slQ+l6MPvitebjB/kIG4t/kc86IczpMaSxVf8F
X-Gm-Gg: AYBFou3LqD7PpxyvxjQockfdfVzTst43xfO5IJg8wfWiQafaVD9IMQUPPnLg0c6yyta
	bnjmrawvAxne1Ev301ONmm3qzfIa0YgNEFz58CgO9UQxckfJ3LO/VfQr1sGKgUHz/IqdiFJ+z7U
	3GV2WzTjtocWSk4Obz2/jXuUKvxLfpqFxlBg2LfGGnMDHIA1zIiHcvNIBp5Zr0UOemxNkb/5f+Z
	EcdD6L9aMRcWCcwV4MicQxKLp3hoydeOM/py1F108+1dZvqB/q/ke2TiCJyw7fgIIsCGp7xUkC5
	Xy422BhKMWNV8EbYR0aCiu/ofP/zZhsqqu6PCP/U1csIqVhwXrf6vQ4TtVM+GuYZXEGe787/fZ7
	LCFkRaw33OmJb7OcEg7UUqRWhBkgWYZ4jqTO9dZSIxdpOBeZm+4/yB9Gg4bzHrFIdThykowsZJ9
	kdJ3t6jlO2HmmwyGoTtmjEzmF3m9bXenhcOvOCwMmJa7UHCxja/XSCZJochN1Lk6vNAAbHwvZBx
	6IGHmQL/2JSZFJyTglwO65mamjEg2FAbKi6Opwd3i5lJupsdr5cjiE0O4XTW/GsJWIbBJ5UL+/o
	76I0LPfAywjJO/8FMMTq1w6s0P7Bx4mJjykJwz4IgU19mluYwHminHo=
X-Received: by 2002:a05:600c:3486:b0:49f:f099:6fb1 with SMTP id 5b1f17b1804b1-4a35ac95955mr171862835e9.15.1793112789523;
        Tue, 27 Oct 2026 07:53:09 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a046fefsm346624495e9.5.2026.10.27.07.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 07:53:08 -0700 (PDT)
Message-ID: <1da30fde-75bf-469f-80e1-ce90cd29c84d@gmail.com>
Date: Tue, 27 Oct 2026 14:53:07 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 8/8] t/test-lib: make feature-testbed job more accessible
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
 <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261027-b4-pks-ci-test-vars-consolidation-v1-8-f28edf79bd6c@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2026 08:18, Patrick Steinhardt wrote:
> Our "feature-testbed" job sets up a bunch of GIT_TEST environment
> variables and then executes our tests. This is mostly intended as a
> testbed for features that aren't default-enabled, but that may
> eventually become so.
> 
> Due to the job being special it has a higher potential of failing even
> though a local test run succeeds. But running these tests locally with
> the same environment is somewhat painful, as the developer has to
> manually set all of these environment variables.
> 
> Introduce a new "--feature-testbed" toggle for our test suite that, when
> set, sets up exactly these environment variables. Migrate our CI to use
> this toggle so that we have a single source of truth, only.
> 
> Note that we only set these GIT_TEST variables in the case where they
> haven't already been configured. This serves two purposes:
> 
>    - The user can continue to manually override a subset of those
>      variables, if they desire.
> 
>    - Test scripts typically source "t/test-lib.sh" after they already
>      overrode GIT_TEST variables, and we don't want to discard that.

That all sounds sensible, the commit message could maybe flag that the 
"feature-testbed" also sets OPENSSL_SHA1_UNSAFE which 
"--feature-testbed" does not because it is only concerned with GIT_TEST_*.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index de566309861..8863bcac930 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -202,6 +202,14 @@ finalize_test_case_output () { :; }
>   finalize_test_leak_output () { :; }
>   finalize_test_output () { :; }
>   
> +set_default_env () {
> +	if eval "test -z \"\${$1+set}\""

This made me scratch my head for a couple of minutes, but I think it is 
correct

	set_default_env ABC 1

evaluates

	test -z "${ABC+set}"

to see if $ABC is unset.

Thanks

Phillip
> +	then
> +		eval "$1=\$2"
> +	fi
> +	export "$1"
> +}
> +
>   parse_option () {
>   	local opt="$1"
>   
> @@ -212,6 +220,19 @@ parse_option () {
>   		immediate=t ;;
>   	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
>   		GIT_TEST_LONG=true; export GIT_TEST_LONG ;;
> +	--feature-testbed)
> +		set_default_env GIT_TEST_SPLIT_INDEX yes
> +		set_default_env GIT_TEST_FULL_IN_PACK_ARRAY true
> +		set_default_env GIT_TEST_OE_SIZE 10
> +		set_default_env GIT_TEST_OE_DELTA_SIZE 5
> +		set_default_env GIT_TEST_COMMIT_GRAPH 1
> +		set_default_env GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS 1
> +		set_default_env GIT_TEST_MULTI_PACK_INDEX 1
> +		set_default_env GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL 1
> +		set_default_env GIT_TEST_NO_WRITE_REV_INDEX 1
> +		set_default_env GIT_TEST_CHECKOUT_WORKERS 2
> +		set_default_env GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL 1
> +		;;
>   	-r)
>   		mark_option_requires_arg "$opt" run_list
>   		;;
> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
> index 752fb38fb32..f4898353045 100644
> --- a/t/unit-tests/unit-test.c
> +++ b/t/unit-tests/unit-test.c
> @@ -27,6 +27,7 @@ int cmd_main(int argc, const char **argv)
>   		 * options understood by integration tests.
>   		 */
>   		OPT_NOOP_NOARG('d', "debug"),
> +		OPT_NOOP_NOARG(0, "feature-testbed"),
>   		OPT_NOOP_NOARG(0, "github-workflow-markup"),
>   		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
>   		OPT_NOOP_ARG(0, "no-chain-lint"),
> 

