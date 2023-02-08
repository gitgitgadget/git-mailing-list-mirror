Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C6C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 20:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBHUYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 15:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBHUYn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 15:24:43 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAD77ECB
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 12:24:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id f6so114058pln.12
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IGUCSogUzE7PrlmQ2e0Pgp8CIEr4/tqmPnKEh9BY6vw=;
        b=c9RkFyOKBMNy6sKHdZL9UZ9Fw2LBPsR7FNYgO9yd3Q5EUm7MmSrYrFWQgtLBeD6fRk
         3/5tZVukYOnxTwE9zvG2i+2WVIDv5ZN2uwtqwCjQKeMRfxTIdKcrvY8A8KHZkoSTRlOE
         8oxWpPBBN+2YPtGPW47BbsuWODuhW6KjfAoq7U/eyVQyM3Qwum5JkawOvTW4v8oJh2nx
         Lj0uFo35PgNC4SDOB1m9WKcsXScWlE5dbJJ/6QSNOALLkIhJjy5kpLSGFa42wkEr+8vu
         jUZqAOH8tKw4lYjveSh+IRbNBjVD+tlYOgSmUkq6BxARWxatAbH9LfPxRF+238htAe41
         PM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGUCSogUzE7PrlmQ2e0Pgp8CIEr4/tqmPnKEh9BY6vw=;
        b=XYskM7BZtpxKrfbXrtBjAeHC69c6eltteNGlazGX0V6O1/4pzhZRU8th5JLTV1vrw6
         +IKLuwRpMeg1+/DvtbkOWqaPaR5MnThK+4EA1Ew+l5KprbGWUotXvVydwvbyT1ZplZb6
         7SyyQChBntT+o/EutUU6+rFMZoLmO5xnAjE0hi5/FbiLlDAdu+OQLnCCGX67VlqFBdQi
         OHWM2BYtiSpAGrOBkpMS8L/0s7iNL4lze3Wm4D0kpthlzvaE3apPtteubJaaCc7lPUlE
         suPPSsrA4Nq/BamMSRzr3L3od6Kpgd0wCXxmZvS9cqIylI9s+boE6kxn2ufrSIJ+sTmZ
         okKA==
X-Gm-Message-State: AO0yUKUVaP4AIevN8SNB8ep682Z9bHvRY1PF/HUdaZ1uJm4P9nuBd0hs
        jxw/11soerZNNywNwK4anHuj
X-Google-Smtp-Source: AK7set8oriocRz4fIA9Co5lJLyTb1YrmOufL8tezx5xDWlEYxGr6lGjO99QV35a0kkGbae9PT2VyTg==
X-Received: by 2002:a17:903:2284:b0:19a:5939:51dd with SMTP id b4-20020a170903228400b0019a593951ddmr65802plh.20.1675887873133;
        Wed, 08 Feb 2023 12:24:33 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id p10-20020a1709026b8a00b00183c67844aesm11468772plk.22.2023.02.08.12.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 12:24:32 -0800 (PST)
Message-ID: <87f79e79-1591-ca28-4975-3bca5b8f7266@github.com>
Date:   Wed, 8 Feb 2023 12:24:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v8 1/3] t5563: add tests for basic and anoymous HTTP
 access
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <pull.1352.v8.git.1675711789.gitgitgadget@gmail.com>
 <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <d362f7016d34c4803adf42a88012997c66e0bde8.1675711789.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index 608949ea80b..2c49569f675 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -137,6 +137,7 @@ prepare_httpd() {
>  	install_script error-smart-http.sh
>  	install_script error.sh
>  	install_script apply-one-time-perl.sh
> +	install_script nph-custom-auth.sh
>  
>  	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
>  
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 0294739a77a..76335cdb24d 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -135,6 +135,11 @@ Alias /auth/dumb/ www/auth/dumb/
>  	SetEnv GIT_HTTP_EXPORT_ALL
>  	SetEnv GIT_PROTOCOL
>  </LocationMatch>
> +<LocationMatch /custom_auth/>
> +	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
> +	SetEnv GIT_HTTP_EXPORT_ALL
> +	CGIPassAuth on
> +</LocationMatch>
>  ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
>  ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
>  ScriptAlias /smart/no_report/git-receive-pack error-no-report.sh/
> @@ -144,6 +149,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
>  ScriptAlias /error_smart/ error-smart-http.sh/
>  ScriptAlias /error/ error.sh/
>  ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
> +ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1

This setup (redirecting '/custom_auth/' routes to the 'nph-custom-auth.sh'
script) is nice and straightforward. 

>  <Directory ${GIT_EXEC_PATH}>
>  	Options FollowSymlinks
>  </Directory>
> diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/nph-custom-auth.sh
> new file mode 100755
> index 00000000000..8f851aebac4
> --- /dev/null
> +++ b/t/lib-httpd/nph-custom-auth.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +VALID_CREDS_FILE=custom-auth.valid
> +CHALLENGE_FILE=custom-auth.challenge
> +ANONYMOUS_FILE=custom-auth.anonymous
> +
> +#
> +# If $ANONYMOUS_FILE exists in $HTTPD_ROOT_PATH, allow anonymous access.
> +#
> +# If $VALID_CREDS_FILE exists in $HTTPD_ROOT_PATH, consider each line as a valid
> +# credential for the current request. Each line in the file is considered a
> +# valid HTTP Authorization header value. For example:
> +#
> +# Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
> +#
> +# If $CHALLENGE_FILE exists in $HTTPD_ROOT_PATH, output the contents as headers
> +# in a 401 response if no valid authentication credentials were included in the
> +# request. For example:
> +#
> +# WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
> +# WWW-Authenticate: Basic realm="example.com"
> +#
> +
> +if test -f "$ANONYMOUS_FILE" || (test -f "$VALID_CREDS_FILE" && \
> +	grep -qi "^${HTTP_AUTHORIZATION:-nopenopnope}$" "$VALID_CREDS_FILE")

So there are two cases where you want to return a '200 OK' response:

1. anonymous access is allowed (indicated by $ANONYMOUS_FILE existing)
2. anonymous access is *not* allowed, 'HTTP_AUTHORIZATION' is non-empty, and
   it matches at least one line in $VALID_CREDS_FILE

Does the '$' at the end of "^${HTTP_AUTHORIZATION:-nopenopnope}$" need to be
escaped? I'm guessing it doesn't *need* to be based on the fact that the
tests are passing, but it might be safer to escape it anyway.

I see what you're going for with the "nopenopenope" substitution, but I
think you could be more explicit about requiring that 'HTTP_AUTHORIZATION'
is set without the need for a special invalid value fallback:

    if test -f "$ANONYMOUS_FILE" || (test -n "$HTTP_AUTHORIZATION" && \
    	grep -qsi "^${HTTP_AUTHORIZATION}\$" "$VALID_CREDS_FILE")

Note the addition of '-s' to 'grep' - it seems cleaner than redirecting to
'/dev/null' (as Ævar suggested [1]) while achieving the same result.

[1] https://lore.kernel.org/git/230206.86fsbi5y63.gmgdl@evledraar.gmail.com/

> +then
> +	# Note that although git-http-backend returns a status line, it
> +	# does so using a CGI 'Status' header. Because this script is an
> +	# No Parsed Headers (NPH) script, we must return a real HTTP
> +	# status line.
> +	# This is only a test script, so we don't bother to check for
> +	# the actual status from git-http-backend and always return 200.
> +	echo 'HTTP/1.1 200 OK'
> +	exec "$GIT_EXEC_PATH"/git-http-backend

I'm not familiar with 'exec', but a cursory look at the documentation shows
that, because this replaces the current shell, it will exit with the code
from 'git-http-backend', so there's no risk of continuing on to print the
'401 Authorization Required' response & challenge handling. 

> +fi
> +
> +echo 'HTTP/1.1 401 Authorization Required'
> +if test -f "$CHALLENGE_FILE"
> +then
> +	cat "$CHALLENGE_FILE"
> +fi

In contrast to Ævar's comments in the review linked earlier, I like having
the explicit 'test -f' (to sort of "self-document" that the challenge is
only issued if $CHALLENGE_FILE exists). I think you're fine keeping this
as-is or changing it, depending on your preference.

> +test_expect_success 'access anonymous no challenge' '
> +	test_when_finished "per_test_cleanup" &&
> +	touch "$HTTPD_ROOT_PATH/custom-auth.anonymous" &&
> +	git ls-remote "$HTTPD_URL/custom_auth/repo.git"
> +'
> +
> +test_expect_success 'access using basic auth' '
> +	test_when_finished "per_test_cleanup" &&
> +
> +	set_credential_reply get <<-EOF &&
> +	username=alice
> +	password=secret-passwd
> +	EOF
> +
> +	cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
> +	Basic YWxpY2U6c2VjcmV0LXBhc3N3ZA==
> +	EOF
> +
> +	cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
> +	WWW-Authenticate: Basic realm="example.com"
> +	EOF
> +
> +	test_config_global credential.helper test-helper &&
> +	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
> +
> +	expect_credential_query get <<-EOF &&
> +	protocol=http
> +	host=$HTTPD_DEST
> +	EOF
> +
> +	expect_credential_query store <<-EOF
> +	protocol=http
> +	host=$HTTPD_DEST
> +	username=alice
> +	password=secret-passwd
> +	EOF
> +'
> +
> +test_done

And these tests properly exercise the custom auth handling. 

While I wasn't as opposed to the custom HTTP handler as others that have
commented, I do appreciate the relative simplicity of this new Apache setup
and like that it's still pretty easy to test. Nice work!

