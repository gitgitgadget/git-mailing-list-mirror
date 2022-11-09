Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BEDC433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiKIXlN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 18:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiKIXlF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 18:41:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C2C19016
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 15:40:51 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-36fde8f2cdcso494917b3.23
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 15:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmlz5tg0zy2sATbFFLlqyGcE0uV2JD/jygCl03wkGXE=;
        b=iSXFog81glmH8n6hp3oOiLWK4KtS4utBYb7v53mpnxGaLxFWzI++Jm3dtzGTJUwQ9H
         La1KojZkUr/J0sV4rRgXPNC4LLY6vFjNR0rF411ZBAAzK/YVthzZZgwwh1AZGTDpjFoX
         wjZwmS+CvNbnM8SEF/uKMRnCk2So4sskLszdvCQqBwBb5d24/wUxXkPJguDgasFKvVz8
         JVRZVb6orJESHvijPLFcMd+TZBCTQ8V+H1Ev7oil5EOnvu7dIY7CzwKmOhzbTC6XQyaq
         L8/jvMX7D0Tlzj5TAkSnQKsN/FuHaPMHR0Y2IX06gxgUKzQirX2UZfhmeptPsnExqNEJ
         Sh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmlz5tg0zy2sATbFFLlqyGcE0uV2JD/jygCl03wkGXE=;
        b=wChqszRjg2CyIH3GwL/A+HM5dhsplhcbsfRt44+7SbDtAwyseHyqX+WP28Ks5IFhnj
         I8oa7cPTg8ma9AVWPm0BtWGG7L0nx7V6KAYwz1l6hgrsJit21dr6UdL0p6zIIWIZV/Bb
         ioU41S7h3HDQiU7Te2UMB0W+SLVRVj4ae2ve3O/bnXC/7loHFEh1rrZZs8+AcLTYXEgW
         mfnPSTZuZpp9V63Y6ELkYHiXi3DsaI5V9z/Xk0P80hkKzQ7+2G1mG7DrcVbP9IkEetSW
         TxPivZbgLd9PEiQaONiyMZBgKPv972+52Z10ToapxFC3XBhVmtvVvfm025znp0RkXs7C
         l6YQ==
X-Gm-Message-State: ACrzQf3oyzi4LpSlu+Lq/3XKbiB1oTd5Cpr13CLC1QGwSfsYbFMxoypi
        cauYjRELrbECjn0wRGrcDatIs4gHM1FlNA==
X-Google-Smtp-Source: AMsMyM4rtx+aXVC14TUeAYCcZECNcGgkBgCOMIBvewXdf9IXnMUzB3HQJIAMoUsD1zLT8JAV1b6D4zGMvzDiNQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6902:4ec:b0:6cb:86b1:a5cc with SMTP
 id w12-20020a05690204ec00b006cb86b1a5ccmr61559409ybs.551.1668037250709; Wed,
 09 Nov 2022 15:40:50 -0800 (PST)
Date:   Wed, 09 Nov 2022 15:40:49 -0800
In-Reply-To: <2f38427aa8db188060d153d8ece9503e1b604e91.1667426970.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com> <2f38427aa8db188060d153d8ece9503e1b604e91.1667426970.git.gitgitgadget@gmail.com>
Message-ID: <kl6lzgcz3ddq.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 05/11] http: set specific auth scheme depending on credential
From:   Glen Choo <chooglen@google.com>
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Introduce a new credential field `authtype` that can be used by
> credential helpers to indicate the type of the credential or
> authentication mechanism to use for a request.
>
> Modify http.c to now specify the correct authentication scheme or
> credential type when authenticating the curl handle. If the new
> `authtype` field in the credential structure is `NULL` or "Basic" then
> use the existing username/password options. If the field is "Bearer"
> then use the OAuth bearer token curl option. Otherwise, the `authtype`
> field is the authentication scheme and the `password` field is the
> raw, unencoded value.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  Documentation/git-credential.txt | 12 ++++++++++++
>  credential.c                     |  5 +++++
>  credential.h                     |  1 +
>  git-curl-compat.h                | 10 ++++++++++
>  http.c                           | 24 +++++++++++++++++++++---
>  5 files changed, 49 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> index 791a57dddfb..9069bfb2d50 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -175,6 +175,18 @@ username in the example above) will be left unset.
>  	attribute 'wwwauth[]', where the order of the attributes is the same as
>  	they appear in the HTTP response.
>  
> +`authtype`::
> +
> +	Indicates the type of authentication scheme that should be used by Git.
> +	Credential helpers may reply to a request from Git with this attribute,
> +	such that subsequent authenticated requests include the correct
> +	`Authorization` header.
> +	If this attribute is not present, the default value is "Basic".
> +	Known values include "Basic", "Digest", and "Bearer".
> +	If an unknown value is provided, this is taken as the authentication
> +	scheme for the `Authorization` header, and the `password` field is
> +	used as the raw unencoded authorization parameters of the same header.
> +

[...]

> @@ -525,8 +526,25 @@ static void init_curl_http_auth(struct active_request_slot *slot)
>  
>  	credential_fill(&http_auth);
>  
> -	curl_easy_setopt(slot->curl, CURLOPT_USERNAME, http_auth.username);
> -	curl_easy_setopt(slot->curl, CURLOPT_PASSWORD, http_auth.password);
> +	if (!http_auth.authtype || !strcasecmp(http_auth.authtype, "basic")
> +				|| !strcasecmp(http_auth.authtype, "digest")) {
> +		curl_easy_setopt(slot->curl, CURLOPT_USERNAME,
> +			http_auth.username);
> +		curl_easy_setopt(slot->curl, CURLOPT_PASSWORD,
> +			http_auth.password);
> +#ifdef GIT_CURL_HAVE_CURLAUTH_BEARER
> +	} else if (!strcasecmp(http_auth.authtype, "bearer")) {
> +		curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, CURLAUTH_BEARER);
> +		curl_easy_setopt(slot->curl, CURLOPT_XOAUTH2_BEARER,
> +			http_auth.password);
> +#endif
> +	} else {
> +		struct strbuf auth = STRBUF_INIT;
> +		strbuf_addf(&auth, "Authorization: %s %s",
> +			http_auth.authtype, http_auth.password);
> +		slot->headers = curl_slist_append(slot->headers, auth.buf);
> +		strbuf_release(&auth);
> +	}

As expected, a "Bearer" authtype doesn't require passing a username to
curl, but as you noted in the cover letter, credential helpers were
designed with username-password authentication in mind, which raises the
question of what a credential helper should do with "Bearer"
credentials.

e.g. it is not clear to me where the "username" comes from in the tests, e.g.

  +test_expect_success 'http auth www-auth headers to credential helper basic valid' '
  +	test_when_finished "per_test_cleanup" &&
  +	# base64("alice:secret-passwd")
  +	USERPASS64=YWxpY2U6c2VjcmV0LXBhc3N3ZA== &&
  +	export USERPASS64 &&
  +
  +	start_http_server \
  +		--auth=bearer:authority=\"id.example.com\"\ q=1\ p=0 \
  +		--auth=basic:realm=\"example.com\" \
  +		--auth-token=basic:$USERPASS64 &&
  +
  +	cat >get-expected.cred <<-EOF &&
  +	protocol=http
  +	host=$HOST_PORT
  +	wwwauth[]=bearer authority="id.example.com" q=1 p=0
  +	wwwauth[]=basic realm="example.com"
  +	EOF
  +
  +	cat >store-expected.cred <<-EOF &&
  +	protocol=http
  +	host=$HOST_PORT
  +	username=alice
  +	password=secret-passwd
  +	authtype=basic
  +	EOF
  +
  +	cat >get-response.cred <<-EOF &&
  +	protocol=http
  +	host=$HOST_PORT
  +	username=alice
  +	password=secret-passwd
  +	authtype=basic
  +	EOF
  +
  +	git -c credential.helper="$CREDENTIAL_HELPER" ls-remote $ORIGIN_URL &&
  +
  +	test_cmp get-expected.cred get-actual.cred &&
  +	test_cmp store-expected.cred store-actual.cred
  +'

I'm not sure how we plan to handle this. Some approaches I can see are:

- We require that credential helpers set a reasonable value for
  "username". Presumably most credential helpers generating bearer
  tokens have some idea of user identity, so this might be reasonable,
  though it is wasteful, since we never use it in a meaningul way, e.g.
  I don't think Git asks the credential helper for "username=alice" and
  the credential helper decides to return the 'alice' credential instead
  of the 'bob' credential (but I could be mistaken).

- We require that credential helpers set _some_ value for "username",
  even if it is bogus. If so, we should communicate this explicitly.

- It is okay for "username" to be missing. This seems like the most
  elegant approach for credential helpers. I'm not sure if we're there
  yet with this series, e.g. http.c::handle_curl_result() reads:

    else if (results->http_code == 401) {
      if (http_auth.username && http_auth.password) {
        credential_reject(&http_auth);
        return HTTP_NOAUTH;

  which seems to assume both a username _and_ password. If the username
  is missing, we presumably don't send "erase", which might be a problem
  for revoked access tokens (though presumably not an issue for OIDC id
  tokens).
