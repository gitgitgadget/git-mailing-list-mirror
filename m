Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168C42A88
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612817; cv=none; b=nLqe9lAsO2YsO0ZRKnw9Agb0Ri7H4sq1flbJBbK/vSppf7qbowHK5UnL8oA77Z5LOP3bDXF30Gc4KSfdt9n4KznJy0au5OTwo2xyaP6rJ2f1CJ+bQuvgxEBhnRzjxNLlMAn5FKkc0i9WMZW1ilOT5zhUhV1/j+3EdTL6U6e5Noc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612817; c=relaxed/simple;
	bh=Z7zExBs53MHQo0Gbt0dy3LgoeTPB9Wj44OCll3N1x3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDIIxYy2DRhkxjp5Z6B4QCQ4/MuQ1Rou3f960hqM7VK5J25Br321QHGPi4oVKcMAlOUCGHirWR5jYjUePYtKVGW8RXKvZrSZ/LeJPeEpsllbrulYuyaRrlBe8O1aZ0y3hSwjI2gvzcvwhHfaoM3xyfc95q4QABT0CV+ABcoweEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR7a9/IN; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR7a9/IN"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a450bedffdfso68510266b.3
        for <git@vger.kernel.org>; Thu, 28 Mar 2024 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612812; x=1712217612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dE96NbVf4kZRFw9ayPyJr0EVZNKHZljNpulomra3UP0=;
        b=RR7a9/INVWHoic3U7LoEMAMAnJkKV38KqLKKDrr4mVLQanhtO72/kCnfcHPhveJRLZ
         1/tdw2Na2HHaEOvhF3q/Qzs92uG5SahTaVU36SIfXc+IHhaIhS527iqXa4BdClyUj9iI
         iPlYqioF6aKhexFyg0Qc303RB1VxIJI1L+JFMelItUf0Tpv2638aJWtJ3IDSIGkfkzuP
         hTg6oW8gXc6IOmLyZatUPFqjkJxN7Kr8BolqsNGIDlU/t9HYOQQY63DpitRgaUmFe22A
         mQegKxhgNPjMY8KlXhI1q7Nzi6ziEr57gVJjZ6xVvuSbDHooRVDk8xonWVaUbj0PTP//
         3+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612812; x=1712217612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE96NbVf4kZRFw9ayPyJr0EVZNKHZljNpulomra3UP0=;
        b=OUK0bbx8MmIromuftLJNUBI4ahc7ekfCbL3CdBdGYP3wZMlo906eWrLS3GlJuFFUsf
         ndhD9771umucOwoFHBsO6fw0bMjx4TJbeipcABY4wT9eejN6fdo3ZvWsP9PAO9SarpQp
         GxNIRA5B9GglPYwCm2uO3nDCnEalwTc70H5ChEW2fLIhmJpt6DOFRJSavEBseo+ImUR+
         eR/Y7SVFR1GLvYZ0JJ9OOGvRWCcYYg/0FJVY88W1zhLFT0Scu8hzeEE+N4DHGvMccQLf
         wjMLssBYEFIn3IXHT19VGjxqlAxFN9tlx/UUOO7l7/O/sFHLpTMeSUFgD7d5uiD04ujF
         dOUA==
X-Gm-Message-State: AOJu0YwQHkv+V+rhblafYFo4sKEJULxbl/8zYSMBLs36SWi3pQ7oUokH
	bBJ0xDubIjSQpHNSNGc59lwPdU2FLLOdb9b/o4GwZJyVsxHO+vKxm0l4QLVU5k9e875U3W7Rn0I
	UncfJbtdOVYfhbl7wSckL9+y0ylcWTPq+Guu60hj2
X-Google-Smtp-Source: AGHT+IHh2LLGGRmP/4h4urT80/TMyOx8DACPP4s69vSBb54nHEwmAoOsyx29+Y/6HU+RcPTjwhblAZKHt6sp8gYTzIg=
X-Received: by 2002:a17:906:255a:b0:a47:183d:6c82 with SMTP id
 j26-20020a170906255a00b00a47183d6c82mr1116187ejb.31.1711612812077; Thu, 28
 Mar 2024 01:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net> <20240324011301.1553072-14-sandals@crustytoothpaste.net>
In-Reply-To: <20240324011301.1553072-14-sandals@crustytoothpaste.net>
From: M Hickford <mirth.hickford@gmail.com>
Date: Thu, 28 Mar 2024 08:00:00 +0000
Message-ID: <CAGJzqsn4Lz1T=q8NHi7kHHRdYVXKCMPGVBGzkkvZA=P1O9HtUw@mail.gmail.com>
Subject: Re: [PATCH 13/13] credential: add support for multistage credential rounds
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Matthew John Cheetham <mjcheetham@outlook.com>, M Hickford <mirth.hickford@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 01:13, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Over HTTP, NTLM and Kerberos require two rounds of authentication on the
> client side.  It's possible that there are custom authentication schemes
> that also implement this same approach.  Since these are tricky schemes
> to implement and the HTTP library in use may not always handle them
> gracefully on all systems, it would be helpful to allow the credential
> helper to implement them instead for increased portability and
> robustness.

Is this design sufficiently flexible for OAuth DPoP (RFC 9449), or at
least to make it work in future?

OAuth 2.0 Demonstrating Proof of Possession describes "a mechanism for
sender-constraining OAuth 2.0 tokens via a proof-of-possession
mechanism on the application level. This mechanism allows for the
detection of replay attacks with access and refresh tokens."
https://www.rfc-editor.org/rfc/rfc9449.html

Popular hosts GitHub, GitLab, Bitbucket and Gitea already support
OAuth. OAuth DPoP "provides a general defense in depth against the
impact of unanticipated token leakage". Motivated by a 2022 GitHub
attack involving stolen tokens
(https://github.blog/2022-04-15-security-alert-stolen-oauth-user-tokens/),
some hosts are already experimenting with it.
https://lore.kernel.org/git/20230128142827.17397-1-mirth.hickford@gmail.com/

In particular, the http request has to include both Authorization and
DPoP headers https://www.rfc-editor.org/rfc/rfc9449.html#name-the-dpop-authentication-sch.
The latter depends on timestamp and a server-optional challenge in a
DPoP-Nonce header.
https://www.rfc-editor.org/rfc/rfc9449.html#name-resource-server-provided-no.


On Sun, 24 Mar 2024 at 01:13, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Over HTTP, NTLM and Kerberos require two rounds of authentication on the
> client side.  It's possible that there are custom authentication schemes
> that also implement this same approach.  Since these are tricky schemes
> to implement and the HTTP library in use may not always handle them
> gracefully on all systems, it would be helpful to allow the credential
> helper to implement them instead for increased portability and
> robustness.
>
> To allow this to happen, add a boolean flag, continue, that indicates
> that instead of failing when we get a 401, we should retry another round
> of authentication.  However, this necessitates some changes in our
> current credential code so that we can make this work.
>
> Keep the state[] headers between iterations, but only use them to send
> to the helper and only consider the new ones we read from the credential
> helper to be valid on subsequent iterations.  That avoids us passing
> stale data when we finally approve or reject the credential.  Similarly,
> clear the multistage and wwwauth[] values appropriately so that we
> don't pass stale data or think we're trying a multiround response when
> we're not.  Remove the credential values so that we can actually fill a
> second time with new responses.
>
> Limit the number of iterations of reauthentication we do to 3.  This
> means that if there's a problem, we'll terminate with an error message
> instead of retrying indefinitely and not informing the user (and
> possibly conducting a DoS on the server).
>
> In our tests, handle creating multiple response output files from our
> helper so we can verify that each of the messages sent is correct.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-credential.txt | 16 +++++-
>  builtin/credential.c             |  1 +
>  credential.c                     | 32 ++++++++++--
>  credential.h                     | 27 +++++++++-
>  http.c                           | 59 +++++++++++----------
>  t/t5563-simple-http-auth.sh      | 89 ++++++++++++++++++++++++++++++--
>  6 files changed, 187 insertions(+), 37 deletions(-)
>
> diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
> index 6b7e017066..160dee5c6a 100644
> --- a/Documentation/git-credential.txt
> +++ b/Documentation/git-credential.txt
> @@ -207,6 +207,19 @@ provided on input.
>  This value should not be sent unless the appropriate capability (see below) is
>  provided on input.
>
> +`continue`::
> +       This is a boolean value, which, if enabled, indicates that this
> +       authentication is a non-final part of a multistage authentication step. This
> +       is common in protocols such as NTLM and Kerberos, where two rounds of client
> +       authentication are required, and setting this flag allows the credential
> +       helper to implement the multistage authentication step.  This flag should
> +       only be sent if a further stage is required; that is, if another round of
> +       authentication is expected.
> ++
> +This value should not be sent unless the appropriate capability (see below) is
> +provided on input.  This attribute is 'one-way' from a credential helper to
> +pass information to Git (or other programs invoking `git credential`).
> +
>  `wwwauth[]`::
>
>         When an HTTP response is received by Git that includes one or more
> @@ -225,7 +238,8 @@ to pass additional information to credential helpers.
>  +
>  There are two currently supported capabilities.  The first is `authtype`, which
>  indicates that the `authtype` and `credential` values are understood.  The
> -second is `state`, which indicates that the `state[]` value is understood.
> +second is `state`, which indicates that the `state[]` and `continue` values are
> +understood.
>
>  It is not obligatory to use the additional features just because the capability
>  is supported, but they should not be provided without this capability.
> diff --git a/builtin/credential.c b/builtin/credential.c
> index 5123dabcf1..f14d1b5ed6 100644
> --- a/builtin/credential.c
> +++ b/builtin/credential.c
> @@ -22,6 +22,7 @@ int cmd_credential(int argc, const char **argv, const char *prefix UNUSED)
>
>         if (!strcmp(op, "fill")) {
>                 credential_fill(&c, 0);
> +               credential_next_state(&c);
>                 credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
>         } else if (!strcmp(op, "approve")) {
>                 credential_approve(&c);
> diff --git a/credential.c b/credential.c
> index 0ca7c12895..9a08efe113 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -31,10 +31,23 @@ void credential_clear(struct credential *c)
>         string_list_clear(&c->helpers, 0);
>         strvec_clear(&c->wwwauth_headers);
>         strvec_clear(&c->state_headers);
> +       strvec_clear(&c->state_headers_to_send);
>
>         credential_init(c);
>  }
>
> +void credential_next_state(struct credential *c)
> +{
> +       strvec_clear(&c->state_headers_to_send);
> +       strvec_swap(&c->state_headers, &c->state_headers_to_send);
> +}
> +
> +void credential_clear_secrets(struct credential *c)
> +{
> +       FREE_AND_NULL(c->password);
> +       FREE_AND_NULL(c->credential);
> +}
> +
>  static void credential_set_all_capabilities(struct credential *c)
>  {
>         c->capa_authtype.request_initial = 1;
> @@ -295,6 +308,8 @@ int credential_read(struct credential *c, FILE *fp, int op_type)
>                                 credential_set_capability(&c->capa_authtype, op_type);
>                         else if (!strcmp(value, "state"))
>                                 credential_set_capability(&c->capa_state, op_type);
> +               } else if (!strcmp(key, "continue")) {
> +                       c->multistage = !!git_config_bool("continue", value);
>                 } else if (!strcmp(key, "password_expiry_utc")) {
>                         errno = 0;
>                         c->password_expiry_utc = parse_timestamp(value, NULL, 10);
> @@ -359,8 +374,10 @@ void credential_write(const struct credential *c, FILE *fp, int op_type)
>         for (size_t i = 0; i < c->wwwauth_headers.nr; i++)
>                 credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
>         if (credential_has_capability(&c->capa_state, op_type)) {
> -               for (size_t i = 0; i < c->state_headers.nr; i++)
> -                       credential_write_item(fp, "state[]", c->state_headers.v[i], 0);
> +               if (c->multistage)
> +                       credential_write_item(fp, "continue", "1", 0);
> +               for (size_t i = 0; i < c->state_headers_to_send.nr; i++)
> +                       credential_write_item(fp, "state[]", c->state_headers_to_send.v[i], 0);
>         }
>  }
>
> @@ -431,6 +448,9 @@ void credential_fill(struct credential *c, int all_capabilities)
>         if ((c->username && c->password) || c->credential)
>                 return;
>
> +       credential_next_state(c);
> +       c->multistage = 0;
> +
>         credential_apply_config(c);
>         if (all_capabilities)
>                 credential_set_all_capabilities(c);
> @@ -443,8 +463,10 @@ void credential_fill(struct credential *c, int all_capabilities)
>                         /* Reset expiry to maintain consistency */
>                         c->password_expiry_utc = TIME_MAX;
>                 }
> -               if ((c->username && c->password) || c->credential)
> +               if ((c->username && c->password) || c->credential) {
> +                       strvec_clear(&c->wwwauth_headers);
>                         return;
> +               }
>                 if (c->quit)
>                         die("credential helper '%s' told us to quit",
>                             c->helpers.items[i].string);
> @@ -464,6 +486,8 @@ void credential_approve(struct credential *c)
>         if (((!c->username || !c->password) && !c->credential) || c->password_expiry_utc < time(NULL))
>                 return;
>
> +       credential_next_state(c);
> +
>         credential_apply_config(c);
>
>         for (i = 0; i < c->helpers.nr; i++)
> @@ -475,6 +499,8 @@ void credential_reject(struct credential *c)
>  {
>         int i;
>
> +       credential_next_state(c);
> +
>         credential_apply_config(c);
>
>         for (i = 0; i < c->helpers.nr; i++)
> diff --git a/credential.h b/credential.h
> index e2021455fe..adb1fc370a 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -143,10 +143,15 @@ struct credential {
>         struct strvec wwwauth_headers;
>
>         /**
> -        * A `strvec` of state headers from credential helpers.
> +        * A `strvec` of state headers received from credential helpers.
>          */
>         struct strvec state_headers;
>
> +       /**
> +        * A `strvec` of state headers to send to credential helpers.
> +        */
> +       struct strvec state_headers_to_send;
> +
>         /**
>          * Internal use only. Keeps track of if we previously matched against a
>          * WWW-Authenticate header line in order to re-fold future continuation
> @@ -156,6 +161,7 @@ struct credential {
>
>         unsigned approved:1,
>                  configured:1,
> +                multistage: 1,
>                  quit:1,
>                  use_http_path:1,
>                  username_from_proto:1;
> @@ -184,6 +190,7 @@ struct credential {
>         .password_expiry_utc = TIME_MAX, \
>         .wwwauth_headers = STRVEC_INIT, \
>         .state_headers = STRVEC_INIT, \
> +       .state_headers_to_send = STRVEC_INIT, \
>  }
>
>  /* Initialize a credential structure, setting all fields to empty. */
> @@ -229,6 +236,24 @@ void credential_approve(struct credential *);
>   */
>  void credential_reject(struct credential *);
>
> +/**
> + * Clear the secrets in this credential, but leave other data intact.
> + *
> + * This is useful for resetting credentials in preparation for a subsequent
> + * stage of filling.
> + */
> +void credential_clear_secrets(struct credential *c);
> +
> +/**
> + * Prepares the credential for the next iteration of the helper protocol by
> + * updating the state headers to send with the ones read by the last iteration
> + * of the protocol.
> + *
> + * Except for internal callers, this should be called exactly once between
> + * reading credentials with `credential_fill` and writing them.
> + */
> +void credential_next_state(struct credential *c);
> +
>  int credential_read(struct credential *, FILE *, int);
>  void credential_write(const struct credential *, FILE *, int);
>
> diff --git a/http.c b/http.c
> index f98c520924..9d373c6460 100644
> --- a/http.c
> +++ b/http.c
> @@ -1781,6 +1781,10 @@ static int handle_curl_result(struct slot_results *results)
>         else if (results->http_code == 401) {
>                 if ((http_auth.username && http_auth.password) ||\
>                     (http_auth.authtype && http_auth.credential)) {
> +                       if (http_auth.multistage) {
> +                               credential_clear_secrets(&http_auth);
> +                               return HTTP_REAUTH;
> +                       }
>                         credential_reject(&http_auth);
>                         return HTTP_NOAUTH;
>                 } else {
> @@ -2178,6 +2182,7 @@ static int http_request_reauth(const char *url,
>                                void *result, int target,
>                                struct http_get_options *options)
>  {
> +       int i = 3;
>         int ret = http_request(url, result, target, options);
>
>         if (ret != HTTP_OK && ret != HTTP_REAUTH)
> @@ -2191,35 +2196,35 @@ static int http_request_reauth(const char *url,
>                 }
>         }
>
> -       if (ret != HTTP_REAUTH)
> -               return ret;
> +       while (ret == HTTP_REAUTH && --i) {
> +               /*
> +                * The previous request may have put cruft into our output stream; we
> +                * should clear it out before making our next request.
> +                */
> +               switch (target) {
> +               case HTTP_REQUEST_STRBUF:
> +                       strbuf_reset(result);
> +                       break;
> +               case HTTP_REQUEST_FILE:
> +                       if (fflush(result)) {
> +                               error_errno("unable to flush a file");
> +                               return HTTP_START_FAILED;
> +                       }
> +                       rewind(result);
> +                       if (ftruncate(fileno(result), 0) < 0) {
> +                               error_errno("unable to truncate a file");
> +                               return HTTP_START_FAILED;
> +                       }
> +                       break;
> +               default:
> +                       BUG("Unknown http_request target");
> +               }
>
> -       /*
> -        * The previous request may have put cruft into our output stream; we
> -        * should clear it out before making our next request.
> -        */
> -       switch (target) {
> -       case HTTP_REQUEST_STRBUF:
> -               strbuf_reset(result);
> -               break;
> -       case HTTP_REQUEST_FILE:
> -               if (fflush(result)) {
> -                       error_errno("unable to flush a file");
> -                       return HTTP_START_FAILED;
> -               }
> -               rewind(result);
> -               if (ftruncate(fileno(result), 0) < 0) {
> -                       error_errno("unable to truncate a file");
> -                       return HTTP_START_FAILED;
> -               }
> -               break;
> -       default:
> -               BUG("Unknown http_request target");
> +               credential_fill(&http_auth, 1);
> +
> +               ret = http_request(url, result, target, options);
>         }
> -
> -       credential_fill(&http_auth, 1);
> -
> -       return http_request(url, result, target, options);
> +       return ret;
>  }
>
>  int http_get_strbuf(const char *url,
> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> index 515185ae00..5d5caa3f58 100755
> --- a/t/t5563-simple-http-auth.sh
> +++ b/t/t5563-simple-http-auth.sh
> @@ -21,9 +21,17 @@ test_expect_success 'setup_credential_helper' '
>         CREDENTIAL_HELPER="$TRASH_DIRECTORY/bin/git-credential-test-helper" &&
>         write_script "$CREDENTIAL_HELPER" <<-\EOF
>         cmd=$1
> -       teefile=$cmd-query.cred
> +       teefile=$cmd-query-temp.cred
>         catfile=$cmd-reply.cred
>         sed -n -e "/^$/q" -e "p" >>$teefile
> +       state=$(sed -ne "s/^state\[\]=helper://p" "$teefile")
> +       if test -z "$state"
> +       then
> +               mv "$teefile" "$cmd-query.cred"
> +       else
> +               mv "$teefile" "$cmd-query-$state.cred"
> +               catfile="$cmd-reply-$state.cred"
> +       fi
>         if test "$cmd" = "get"
>         then
>                 cat $catfile
> @@ -32,13 +40,15 @@ test_expect_success 'setup_credential_helper' '
>  '
>
>  set_credential_reply () {
> -       cat >"$TRASH_DIRECTORY/$1-reply.cred"
> +       local suffix="$(test -n "$2" && echo "-$2")"
> +       cat >"$TRASH_DIRECTORY/$1-reply$suffix.cred"
>  }
>
>  expect_credential_query () {
> -       cat >"$TRASH_DIRECTORY/$1-expect.cred" &&
> -       test_cmp "$TRASH_DIRECTORY/$1-expect.cred" \
> -                "$TRASH_DIRECTORY/$1-query.cred"
> +       local suffix="$(test -n "$2" && echo "-$2")"
> +       cat >"$TRASH_DIRECTORY/$1-expect$suffix.cred" &&
> +       test_cmp "$TRASH_DIRECTORY/$1-expect$suffix.cred" \
> +                "$TRASH_DIRECTORY/$1-query$suffix.cred"
>  }
>
>  per_test_cleanup () {
> @@ -479,4 +489,73 @@ test_expect_success 'access using bearer auth with invalid credentials' '
>         EOF
>  '
>
> +test_expect_success 'access using three-legged auth' '
> +       test_when_finished "per_test_cleanup" &&
> +
> +       set_credential_reply get <<-EOF &&
> +       capability[]=authtype
> +       capability[]=state
> +       authtype=Multistage
> +       credential=YS1naXQtdG9rZW4=
> +       state[]=helper:foobar
> +       continue=1
> +       EOF
> +
> +       set_credential_reply get foobar <<-EOF &&
> +       capability[]=authtype
> +       capability[]=state
> +       authtype=Multistage
> +       credential=YW5vdGhlci10b2tlbg==
> +       state[]=helper:bazquux
> +       EOF
> +
> +       cat >"$HTTPD_ROOT_PATH/custom-auth.valid" <<-EOF &&
> +       id=1 creds=Multistage YS1naXQtdG9rZW4=
> +       id=2 creds=Multistage YW5vdGhlci10b2tlbg==
> +       EOF
> +
> +       CHALLENGE="$HTTPD_ROOT_PATH/custom-auth.challenge" &&
> +
> +       cat >"$HTTPD_ROOT_PATH/custom-auth.challenge" <<-EOF &&
> +       id=1 status=401 response=WWW-Authenticate: Multistage challenge="456"
> +       id=1 status=401 response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
> +       id=2 status=200
> +       id=default response=WWW-Authenticate: Multistage challenge="123"
> +       id=default response=WWW-Authenticate: Bearer authorize_uri="id.example.com" p=1 q=0
> +       EOF
> +
> +       test_config_global credential.helper test-helper &&
> +       git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
> +
> +       expect_credential_query get <<-EOF &&
> +       capability[]=authtype
> +       capability[]=state
> +       protocol=http
> +       host=$HTTPD_DEST
> +       wwwauth[]=Multistage challenge="123"
> +       wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
> +       EOF
> +
> +       expect_credential_query get foobar <<-EOF &&
> +       capability[]=authtype
> +       capability[]=state
> +       authtype=Multistage
> +       protocol=http
> +       host=$HTTPD_DEST
> +       wwwauth[]=Multistage challenge="456"
> +       wwwauth[]=Bearer authorize_uri="id.example.com" p=1 q=0
> +       state[]=helper:foobar
> +       EOF
> +
> +       expect_credential_query store bazquux <<-EOF
> +       capability[]=authtype
> +       capability[]=state
> +       authtype=Multistage
> +       credential=YW5vdGhlci10b2tlbg==
> +       protocol=http
> +       host=$HTTPD_DEST
> +       state[]=helper:bazquux
> +       EOF
> +'
> +
>  test_done
