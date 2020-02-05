Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE965C35254
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 13:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D4A217BA
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 13:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IspIHFeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBENLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:11:49 -0500
Received: from mout.gmx.net ([212.227.17.20]:59525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgBENLt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 08:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580908304;
        bh=8cnCFVDfllRaDledWIWV2bDd4hyeMgwx1gq8XfHSiVw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IspIHFeoPTIIvsdw4Mw09d8P6z/7RxomrCEGx7v35VdL6NiJ+ekG6Hbl5BkvxxV/C
         TZ86u4aYdHqin6Al+ko/vSBL0+LokP3FdMbFlKeoCtLJ07uOYRV3qAmO/AcZ5QnrnQ
         xzRSyY5G5qrm9sYtdO1uABmbKYLvnzzTzc50vn6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9MpY-1jdu2G0us0-015Mjq; Wed, 05
 Feb 2020 14:11:44 +0100
Date:   Wed, 5 Feb 2020 14:11:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>
Subject: Re: [PATCH v2 2/4] fsmonitor: handle version 2 of the hooks that
 will use opaque token
In-Reply-To: <f969c4bc17b79f7c857987793cb0c23ad3f4e899.1579793207.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002051353170.3718@tvgsbejvaqbjf.bet>
References: <pull.510.git.1578423871.gitgitgadget@gmail.com>        <pull.510.v2.git.1579793207.gitgitgadget@gmail.com> <f969c4bc17b79f7c857987793cb0c23ad3f4e899.1579793207.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qoD6zgnxLTRGbbqESBnz0HB0UdvEu8IvBXGO5FW0Am3HjVUVJ3w
 ZgBI7jqRVVMTMTpHvBL6fqx9cVpJcf8QCsQQgeL1ZIdSawSpn+mMMkZq52rAzJNEJ/hxvtO
 cHkLtCBWe59l29n0W4u027W/Opa3kxEnQN5KU9O8VZPkblZtX2kWAV7zWRBbduhe0e6aFPd
 1x4ytjFhYD21p3feUkSLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SfT7yBW/Orw=:7tX5lipAOJS1ROGcBtMA+S
 +GgLlvlorIZJGvJzo8FPV0U9Pu5AyFwcIEAA7KC598ho/WcjP3tpjAdonCp5cpxisdNliWAJD
 FM0Act37QhnhI5leoqeBmC3BJC8KZ+1+t1PNk6b265mvqsJxz7Zxxt/AbdQ4RPI7qpT9LNUtc
 NHlJYhVU8XADeTrZ8ZCx/9TySpwISKOxFf2YugvCKvsfUuxBRBlVh6HZfH6V0hMNdTDqObGtt
 A2gaBbRAjb4cCE0784EclV0aMyP2ofJrMgG0PY02MSsh+OZf2A6+dH+whywvJJ80oclCxgjmp
 0eXyy2lwbvnEW8F4yHVPnOB77CTgHdfa1wbnN3UgDkH8bMM7myuvMqCmYiQKQWSazwVK7Fdtr
 i2jqCUFEevj2tGhxZHBpXTBejtFVv1Tt43h3q6pfPVJMoKBuhC/s60Vg5XAGf+Vb/V/26SiZK
 Hs9K00VcGaUUXwVhzQTA/p9hkpzFdOknq35u93ak9OnlMvF+IYEEBpXztWYC9LX7DHgv+JIt3
 abg19FzLDwHjAoM7OvNwFLJJe8+p1PPPaRA1tHjqgfc2H1c/OIeEWyW+88wijwH0BoNjSeEkh
 ujznGGOm6CMkHNAX9jivsvuOJB3zcqsHyy6RCB/oK1jTL3fIxVgnP+PvmvQmRsS6QWTK8Fn3J
 HXU2+aA1WNI/RLns7uftVJzNUVQZqpkJHW1pBKEF/1DcLFk+IW9P4AhxGWj56PAaWBH+vqG89
 1thz0k8w1ExHKxYvHd84nQ5oi1XmbeKiRGs5y3E9+JU3U16FtWRVnplpNOPuOHazEauXsDbTK
 kvio/d4CSV4+cuyxC7t06Wd2UW8a3Fd2t4I5PAwYov7EzgSMnlIAylhIF0wU4pYRa/9zkKbIK
 32E1Ch+QGU7FwqPrz2VAqWVjNxw+Da3nw4fUdyf+n/M3f89nf5eVxpPeyWKUV/vaIuiIs7UHx
 tDF0Zn0HBTWM+kgiMNlA5aNmBgF5cQzLaqs8tGU2fMyt8xFbfKu4+3BL/9aCV/V5Gsn8vxOSx
 ySgFwVjdYEoOjWb9L6aWbTDoqMjr2KXcocFDhrx+mjNCbQa4LXKVAWqikcMI5a35SBSkluFiP
 yzm4fNuueqGGBT7D7x2OzpUNZWDlLtXQ3AXKB63/T+vExlA8N2E1aZbWwnjJWFDbxQn4Wy3rl
 XYfdY6Gr7p0EauJ/bWzVRYKSxydziBSpzGcEVfj/XDlCyGBhGip2drjDJ7HIjputN+1fw3QmD
 rteJMABG7WKmygVCO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kevin,

On Thu, 23 Jan 2020, Kevin Willford via GitGitGadget wrote:

> diff --git a/fsmonitor.c b/fsmonitor.c
> index 9860587225..932bd9012d 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -175,27 +195,60 @@ void refresh_fsmonitor(struct index_state *istate)
>  	 * should be inclusive to ensure we don't miss potential changes.
>  	 */
>  	last_update =3D getnanotime();
> -	strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
> +	if (hook_version =3D=3D HOOK_INTERFACE_VERSION1)
> +		strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
>
>  	/*
> -	 * If we have a last update time, call query_fsmonitor for the set of
> -	 * changes since that time, else assume everything is possibly dirty
> +	 * If we have a last update token, call query_fsmonitor for the set of
> +	 * changes since that token, else assume everything is possibly dirty
>  	 * and check it all.
>  	 */
>  	if (istate->fsmonitor_last_update) {
> -		query_success =3D !query_fsmonitor(HOOK_INTERFACE_VERSION,
> -			istate->fsmonitor_last_update, &query_result);
> +		if (hook_version =3D=3D -1 || hook_version =3D=3D HOOK_INTERFACE_VERS=
ION2) {
> +			query_success =3D !query_fsmonitor(HOOK_INTERFACE_VERSION2,
> +				istate->fsmonitor_last_update, &query_result);
> +
> +			if (query_success) {
> +				if (hook_version < 0)
> +					hook_version =3D HOOK_INTERFACE_VERSION2;
> +
> +				/*
> +				 * First entry will be the last update token
> +				 * Need to use a char * variable because static
> +				 * analysis was suggesting to use strbuf_addbuf
> +				 * but we don't want to copy the entire strbuf
> +				 * only the the chars up to the first NUL
> +				 */
> +				buf =3D query_result.buf;
> +				strbuf_addstr(&last_update_token, buf);
> +				if (!last_update_token.len) {
> +					warning("Empty last update token.");
> +					query_success =3D 0;
> +				} else {
> +					bol =3D last_update_token.len + 1;
> +				}
> +			} else if (hook_version < 0) {
> +				hook_version =3D HOOK_INTERFACE_VERSION1;
> +				if (!last_update_token.len)
> +					strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
> +			}
> +		}
> +
> +		if (hook_version =3D=3D HOOK_INTERFACE_VERSION1) {
> +			query_success =3D !query_fsmonitor(HOOK_INTERFACE_VERSION1,
> +				istate->fsmonitor_last_update, &query_result);

I suspect that `istate->fsmonitor_last_update` might be incorrect here and
that you need `last_update_token.buf` instead. Besides...

> +		}

I could imagine that this would be easier to read if you initialized

	int interface_version =3D HOOK_INTERFACE_VERSION2;
	const char *token =3D istate->fsmonitor_last_update;

and then, at the beginning of this hunk, where you already added an `if`,
extend it to

	if (hook_version =3D=3D HOOK_INTERFACE_VERSION1) {
		interface_version =3D HOOK_INTERFACE_VERSION1;
		strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
		token =3D last_update_token.buf;
	}

Now, you can call

		query_success =3D !query_fsmonitor(interface_version,
			token, &query_result);
		if (!query_success && hook_version < 0) {
			hook_version =3D HOOK_INTERFACE_VERSION1;
			strbuf_reset(&last_update_token);
			strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
			token =3D last_update_token.buf;
			query_success =3D !query_fsmonitor(hook_version,
				token, &query_result);
		}

		if (query_success && interface_version =3D=3D HOOK_INTERFACE_VERSION2)
			bol =3D last_update_token.len + 1;


Technically, you could force `hook_version` to non-negative, via:

		if (hook_version < 0) {
			if (query_success)
				hook_version =3D HOOK_INTERFACE_VERSION2;
			else {
				hook_version =3D HOOK_INTERFACE_VERSION1;
				strbuf_reset(&last_update_token);
				strbuf_addf(&last_update_token, "%"PRIu64"", last_update);
				token =3D last_update_token.buf;
				query_success =3D !query_fsmonitor(hook_version,
					token, &query_result);
			}
		}

but that would not make anything quicker, and would make the code more
convoluted.

It is good that you keep the `fsmonitor-all` and `fsmonitor-watchman`
versions at 1, to verify that this fall-back mechanism works. I wonder
whether we should add one explicit test for that, so that those two hooks
can be upgraded to the interface v2.

Thanks,
Dscho

> +
>  		trace_performance_since(last_update, "fsmonitor process '%s'", core_f=
smonitor);
>  		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %=
s",
>  			core_fsmonitor, query_success ? "success" : "failure");
>  	}
>
>  	/* a fsmonitor process can return '/' to indicate all entries are inva=
lid */
> -	if (query_success && query_result.buf[0] !=3D '/') {
> +	if (query_success && query_result.buf[bol] !=3D '/') {
>  		/* Mark all entries returned by the monitor as dirty */
>  		buf =3D query_result.buf;
> -		bol =3D 0;
> -		for (i =3D 0; i < query_result.len; i++) {
> +		for (i =3D bol; i < query_result.len; i++) {
>  			if (buf[i] !=3D '\0')
>  				continue;
>  			fsmonitor_refresh_callback(istate, buf + bol);
> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
> index cf0fda2d5a..fbfdcca000 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -32,11 +32,12 @@ write_integration_script () {
>  		echo "$0: exactly 2 arguments expected"
>  		exit 2
>  	fi
> -	if test "$1" !=3D 1
> +	if test "$1" !=3D 2
>  	then
>  		echo "Unsupported core.fsmonitor hook version." >&2
>  		exit 1
>  	fi
> +	printf "last_update_token\0"
>  	printf "untracked\0"
>  	printf "dir1/untracked\0"
>  	printf "dir2/untracked\0"
> @@ -107,6 +108,7 @@ EOF
>  # test that "update-index --fsmonitor-valid" sets the fsmonitor valid b=
it
>  test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor=
 valid bit' '
>  	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +		printf "last_update_token\0"
>  	EOF
>  	git update-index --fsmonitor &&
>  	git update-index --fsmonitor-valid dir1/modified &&
> @@ -167,6 +169,7 @@ EOF
>  # test that newly added files are marked valid
>  test_expect_success 'newly added files are marked valid' '
>  	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +		printf "last_update_token\0"
>  	EOF
>  	git add new &&
>  	git add dir1/new &&
> @@ -207,6 +210,7 @@ EOF
>  # test that *only* files returned by the integration script get flagged=
 as invalid
>  test_expect_success '*only* files returned by the integration script ge=
t flagged as invalid' '
>  	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	printf "last_update_token\0"
>  	printf "dir1/modified\0"
>  	EOF
>  	clean_repo &&
> @@ -276,6 +280,7 @@ do
>  		# (if enabled) files unless it is told about them.
>  		test_expect_success "status doesn't detect unreported modifications" =
'
>  			write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +			printf "last_update_token\0"
>  			:>marker
>  			EOF
>  			clean_repo &&
> diff --git a/t/t7519/fsmonitor-all b/t/t7519/fsmonitor-all
> index 691bc94dc2..94ab66bd3d 100755
> --- a/t/t7519/fsmonitor-all
> +++ b/t/t7519/fsmonitor-all
> @@ -17,7 +17,6 @@ fi
>
>  if test "$1" !=3D 1
>  then
> -	echo "Unsupported core.fsmonitor hook version." >&2
>  	exit 1
>  fi
>
> diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
> index d8e7a1e5ba..264b9daf83 100755
> --- a/t/t7519/fsmonitor-watchman
> +++ b/t/t7519/fsmonitor-watchman
> @@ -26,8 +26,7 @@ if ($version =3D=3D 1) {
>  	# subtract one second to make sure watchman will return all changes
>  	$time =3D int ($time / 1000000000) - 1;
>  } else {
> -	die "Unsupported query-fsmonitor hook version '$version'.\n" .
> -	    "Falling back to scanning...\n";
> +	exit 1;
>  }
>
>  my $git_work_tree;
> --
> gitgitgadget
>
>
