Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EED3ACF0B
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064684; cv=pass; b=s8zBu/+cswkboo9Vkue94xEFdnd++RALYE0hzthXqlnUzw2ehfDsfbjtB5Gk9BI8+yLwBectq6JAw+XVYZGq94E122lPRAnYYjbwimvRnrngIXl6wAybWm4L3VwbO+ewhCQ5URYa9H1N4sLVC9qW2hEPvd/VoBPxSvumkOBTtnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064684; c=relaxed/simple;
	bh=wc2P14TRj42r2FpeONFkZuw2Hynn6ebhBwkDxqmR8GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orkrH8fibp0BqNA8+C0DC16rSmPhnixrMCU1SPZbyCxCSQGOimJ2PXYxWU4H06/O5VF70l8XCnaFhTBfPJdD1BAES+pC1blfEgsAHk4UI3FxgcnnZSeeaik8ONAPoecnp/XxLo1Tw2ymUBABmV3JqPSmpPskM9/fXLeNnEjvRqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn2t0Mfe; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn2t0Mfe"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so6271858e87.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2026 07:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787064680; cv=none;
        d=google.com; s=arc-20260327;
        b=aJHF0msu4TCiPfTdfc5kOifBV7dWKfgGUlQ54/UOmTR/fUuU0xwwVQmEBvhN02qB6J
         cexnPERdGT3VaFVOIUHsU03iWz+IpXb/pDp+k4/kTq/UxZe038uKOAGHN5UluT8sLRN9
         yd1qQ0H1q8SoKwIKvumQ+rGEazVFnLRSgtmpWUoi4pv6JyuS3ri6azmf5Aw62VqPhR0s
         YI3hEtM4nq3Obk9gTm7oUao30VeKyVWRY+nj4NpePl2j+SN7K5y9jcgbnS3RxFjEx45U
         ahkWnc76aIJ+fA5uVoc9t9v8xGfTuGSMrJZV1QVTeatCD0vbUOzmTW1uy8Kur452QOJe
         inZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8VpSKnkznlhXEvYZGj7zNORWNWjxRUdY7p8dbpr99ro=;
        fh=VM3ifk780jYIigTY6U/ZeitZx1H4gC4fTZYROhN/Mr0=;
        b=LFLuFG30oEE6z32CBI453Tg+PkST3H+HwYbGS21F0qWe2PD+4db+qPuFJwazkvxoYt
         gLC4NcadQr+bHmr93aOe/U2O72TbibQ1/xAS32KC/pozf0oPGou9itLAImDQFO4x6zpC
         txsmEwDbDHavcXXzu818c8pXUZXlE4Ck4e8CJwETWArd9APTOwQAdyPOoKjhRG2tVbt8
         RA5Mxhd3ZTzMLVO/GbIUvOIr+fMT52X/O/jkJaxDN/wi8xh+QgnAaGzr9oXcrMVzx6gG
         XNJC2FhKGTXsnaaiNwwcyV9K2lUPYGJLO9TsKnOmvkuBiWsjRj9KgudabQOg7opbAw1W
         PJ3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787064680; x=1787669480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8VpSKnkznlhXEvYZGj7zNORWNWjxRUdY7p8dbpr99ro=;
        b=Bn2t0MfeeXYQBz4oCeh5FJpxIZZn24tnoWuKoPIf6X+awOJoCJj3k484g4a6UE7XG3
         iN8lIWzGYu8dT7zh8/8EZ3/IgLTEUvFJ+a1HvVSaAKrW8WH9SQHfSv8YnxdpmHIZ2ccH
         GJ24Q0DYUNbw7bJKkKN+o5KPeQDEpGTPwjbzTny3pj2T8/bC0RDqmwjfUBffGTov3yQR
         iw4WDz2CHHJxPVey9ew0HOA3wOAkS4oElNngxf3AmMZ1MQ8QJKbiWZgbpzkXVwY7IXSx
         +0ljpIJ7rzpKOru5q8Bp7Qddc475euo5sutX5WBZUQ2YRsr75lUL4cgPqLbfpnNLwcF2
         uNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787064680; x=1787669480;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8VpSKnkznlhXEvYZGj7zNORWNWjxRUdY7p8dbpr99ro=;
        b=HUr9pujwbNCeBfDeTuD2rl0unevZW6J4ixRUGlFfLN+/PxmUTTO9g0KwQaGe1Axti2
         GhBloh8sIpwx2RkrE2iAfNCEYvgfu3ES3Qo4PRVPNaiyZPBURL1TujcUjgpCIWbQ3Ewt
         2cYtTi0+AHjXutFUIzNldtl6TPM4fWNB3+0iJWzAF1bwl8LxO/EUgkyXZ1Ojy8NQOt4D
         fqeG29OmXzMRpdGwFkNVuFNYvUso44YvwNy3B1wEne6upxJsLK8rcrcbYbU7qt2uZwza
         yaY2v/WXC0yIZeywUTLSw18TzKga32Y0ccR8AnbuDijg6tBS/ucm2+KISVKWb/ui66u5
         FMLQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKdVqkpqS0ljZdSun9BXHW87ISE88WkvOWgQM9VxKlb0vB7tQ8rwwRkZ7zXomwMJkzSIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3i2U7qOJnB+td6bbZCMNKVX1VWxHKoWkepshKMYe7TTXuOkz1
	9nwJm/GPP2EMD7pf883I4sqcXH+2nYEKoRcS82xhcizm3NyzaV2zKLbk/rTb9m6Dkwlb9gfLTPx
	5weLLANfJ91jB8pLXGCNmKLS7jheCG6U=
X-Gm-Gg: AR+sD11KDBdn2zOXwdssp0gDmjvgqvPUyDr0gp32LAfyHtz5sjburlQiSZqab/JtmC6
	1YBAVFoaoxd77tTf9ezq1HqPQdHIkVVbqOeTrGBArgVEhbF+0KdmMuVXQs/0xoIYxe2a8f3STVf
	TANZx+L7E0+JXvoAr7hU9Yj1ecnHGh4PLpkap+R00s9Y37HQZ8MbZwtoVgs3JmRTUGPQqvHvI39
	mFdxtB2pSBSqtmaCF526OKmlPnVdHlZRq3ikda3LteF7zjoJwgHd4a21BJwscp+YayZyqhzkgEj
	HIged0H1Bj7S18sTy3R+xvMmwS5ZLFa+oloEBJ+aYDFK+Vuef4cLfgIX/9Vdc0pXqCHr6uI+PZw
	G8hc=
X-Received: by 2002:a2e:bea8:0:b0:394:5c9a:f315 with SMTP id
 38308e7fff4ca-3a1751fb822mr15860851fa.14.1787064680007; Tue, 18 Aug 2026
 07:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmruqt36l.fsf@gitster.g> <20260817185242.22736-1-ggordon@gitlab.com>
 <aoQOxISPfEwh-ik2@pks.im>
In-Reply-To: <aoQOxISPfEwh-ik2@pks.im>
From: Grayson Gordon <graysongordon1@gmail.com>
Date: Tue, 18 Aug 2026 10:51:08 -0400
X-Gm-Features: AcwNN1XhfBuViNJgkY_2owGfdoa47g2HwFq4TBZ8NDyGumcNgxJ68_vpKCKmlAs
Message-ID: <CALgUfNhxLEeTK5xH9Dw9ZPBG+oPq9Fw1qDgt=wbXqrnuEetJyw@mail.gmail.com>
Subject: Re: [PATCH v4] http: add http.sslVerifyStatus to check stapled OCSP responses
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patrick,

Thanks again for the feedback. I'm going to break this into sections
delimited by all caps headers to address each thing you mentioned.

ON GNUTLS VS OPENSSL DIFFERENCES

I appreciate you including the extra context around GnuTLS 3.8's
GNUTLS_NO_STATUS_REQUEST flag, and curl 8.10 setting it when
"verifystatus" is false.

Fair enough, said another way, if either of these are true:
Condition 1: curl is being built with GnuTLS version < 3.8. (There's
no NO_STATUS_REQUEST flag to set.)
OR
Condition 2:  curl version < 8.10. (Curl's not using the flag.)

You'll see a discrepancy in cert verification behavior between the
versions of git built with GnuTLS vs OpenSSL.

While I appreciate the increased precision here, the purpose of my
contribution was to expose the functionality that enables git users to
set it if they so choose. As it stands today, this option is not
presented. So while the discrepancy is what incited me to look deeper,
it isn't the central reason I'm here.

You had a section further down that said: "This information is not
accurate because recent GnuTLS+libcurl versions
handle this the same as OpenSSL, as mentioned above." I think that
this response section suffices for both.

I didn't look into any other TLS backends, as curl's docs say that the
verifystatus option only works with GnuTLS and OpenSSL
https://curl.se/libcurl/c/CURLOPT_SSL_VERIFYSTATUS.html and the other
backend options didn't apply to GitLab customers as it relates to our
CNG charts. There may still be value in looking and capturing it in
the git docs somewhere.

---------------

ON DEFAULT BEHAVIOR AND THE COMMIT MESSAGE

In reality we ARE leaving the default to curl without the flag being
set, so my comment "Leaving the default to libcurl is not an option
either." wasn't super precise either. A nit.
Again the change that's being introduced here is an OPTION for git
users to include the "verifystatus" flag.

Sorry that the commit message feels a bit awkward to you, I can rework
it to be a bit more direct and not spend as much time on
justifications if that'll be easier to read.

---------------

ON DESCRIPTIVE ERROR MESSAGES

Yes, I like this idea. We could give user's a much clearer error that
way. I'll include that. My tests grep for the current string though,
so I'll have to update that too.

---------------

ON COMPREHENSIVE TESTING

I'll leave this at you and Junio's discretion. I worked with him
earlier in this thread to avoid introducing another test file and keep
the testing succinct.
Right now these tests are just limited to parsing the config and
applying it to the user-provided remote.
We COULD do the full suite of tests that cover the full range of
cases/behaviors:
- The flag is set AND
    - no staple sent (should fail)
    - good staple (should pass)
    - bad staple (should fail)
etc.

We're going to need a lot of infrax for that though:
- test CA.
- test server certificate issued by that CA.
- OCSP responder which knows the certificate's status.
- a way for the TLS server to obtain and staple that response.
- a way to control the response so you can test good vs revoked/invalid.

I set all of that stuff up in my own experiment repo, emulating this
with nginx in docker...

It's feasible, just need to know how you all would like it.

- Grayson

On Tue, Aug 18, 2026 at 3:50=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Aug 17, 2026 at 02:52:42PM -0400, graysongordon-gl wrote:
> > From: Grayson Gordon <graysongordon1@gmail.com>
> >
> > git asks libcurl to verify the peer certificate and the hostname, but i=
t
> > never sets CURLOPT_SSL_VERIFYSTATUS, so the "Certificate Status Request=
"
> > TLS extension is never requested and any stapled OCSP response the serv=
er
> > does send is ignored.
> >
> > On an OpenSSL-linked build this is silent. OpenSSL hands the stapled
> > response to the application and takes no view on it:
> > SSL_CTX_set_tlsext_status_cb(3) says the callback "should determine
> > whether the returned OCSP response(s) are acceptable or not", and libcu=
rl
> > only installs that callback when CURLOPT_SSL_VERIFYSTATUS is set. So gi=
t
> > will fetch from a server whose own staple says its certificate has been
> > revoked.
> >
> > A GnuTLS-linked build behaves differently, and the difference does not
> > come from curl. GnuTLS consults a stapled response inside
> > gnutls_certificate_verify_peers(), so the failure surfaces through the
> > verifypeer branch of curl's GnuTLS backend (lib/vtls/gtls.c) whether or
> > not CURLOPT_SSL_VERIFYSTATUS was ever set. The same git, against the sa=
me
> > server, therefore enforces revocation or not depending only on how its
> > libcurl was built. That difference is documented here rather than paper=
ed
> > over: this option turns the check on where the backend needs asking, an=
d
> > setting it to false does not turn the check off on GnuTLS.
>
> This is only part of the story though: GnuTLS 3.8 introduced
> GNUTLS_NO_STATUS_REQUEST, and curl 8.10 started to set that option in
> case of `!verifystatus`. So with new-enough versions of both libraries,
> Git behaves the same no matter whether we use OpenSSL or GnuTLS as
> backend. See also aeb1a281ca (gtls: fix OCSP stapling management,
> 2024-08-20) in curl.
>
> > Add an http.sslVerifyStatus boolean that sets CURLOPT_SSL_VERIFYSTATUS.
> > Because http_options() is the collect_fn of a urlmatch config, the
> > per-URL form works with no further changes:
> >
> >     git config http.https://example.com/.sslVerifyStatus true
> >
> > It defaults to false, and has to. The option is fail-closed: libcurl fa=
ils
> > verification when the server staples nothing at all, so turning this on
> > globally would break every remote that does not staple.
> >
> > Leaving the default to libcurl is not an option either. The same
> > complaint was raised there in https://github.com/curl/curl/issues/15483
> > and closed as intentional ("Marked as enhancement since this was done o=
n
> > purpose"), with the observation that stapling is expected to see less u=
se
> > as Let's Encrypt drops OCSP support. If the check is to be reachable at
> > all, the lever has to come from the application.
>
> But... don't we still leave the default to libcurl? If
> "http.sslVerifyStatus" is not set then we don't touch
> `CURLOPT_SSL_VERIFYSTATUS`, either.
>
> I might be misreading this though, as the whole commit message is quite
> hard to digest. I'd assume that this is because it's generated by AI,
> and it added a lot of the usual weird phrases to the message. It might
> be a good idea to adapt the message to have a bit more of a human touch
> to it.
>
> > If the TLS backend cannot check the staple, curl_easy_setopt() returns
> > CURLE_NOT_BUILT_IN. Fail loudly there rather than carrying on, since
> > silently not checking is precisely what this option exists to prevent.
>
> Makes sense.
>
> > diff --git a/Documentation/config/http.adoc b/Documentation/config/http=
.adoc
> > index 792a71b413..40b849bf7f 100644
> > --- a/Documentation/config/http.adoc
> > +++ b/Documentation/config/http.adoc
> > @@ -196,6 +196,23 @@ http.sslVerify::
> >       over HTTPS. Defaults to true. Can be overridden by the
> >       `GIT_SSL_NO_VERIFY` environment variable.
> >
> > +http.sslVerifyStatus::
> > +     Whether to check the revocation status of the server
> > +     certificate using the stapled OCSP response supplied during
> > +     the TLS handshake ("OCSP stapling"). Defaults to false.
> > ++
> > +This is fail-closed: if the server staples no response, verification
> > +fails. Set it per remote, e.g.
> > +`http.https://example.com/.sslVerifyStatus`, rather than globally.
> > ++
> > +What it changes depends on the TLS backend libcurl was built against.
> > +An OpenSSL-linked build ignores a stapled response unless this is set.
> > +A GnuTLS-linked build consults the staple during ordinary certificate
> > +verification, so it already rejects a revoked certificate under
> > +`http.sslVerify` alone, and setting this to `false` does not disable
> > +that. Where a backend cannot check the staple at all, git fails with a=
n
> > +error rather than continuing unchecked.
>
> This information is not accurate because recent GnuTLS+libcurl versions
> handle this the same as OpenSSL, as mentioned above.
>
> Also, it might make sense to convert the backend-specific information
> into a bulleted list as we may add more items to it going forward. Do we
> have any info how other backends like mbedTLS behave? Or do we know that
> those all fail.
>
> > diff --git a/http.c b/http.c
> > index caccf2108e..94f8dd817a 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -400,6 +401,10 @@ static int http_options(const char *var, const cha=
r *value,
> >               curl_ssl_verify =3D git_config_bool(var, value);
> >               return 0;
> >       }
> > +     if (!strcmp("http.sslverifystatus", var)) {
> > +             curl_ssl_verify_status =3D git_config_bool(var, value);
> > +             return 0;
> > +     }
> >       if (!strcmp("http.sslcipherlist", var))
> >               return git_config_string(&ssl_cipherlist, var, value);
> >       if (!strcmp("http.sslversion", var))
> > @@ -1133,6 +1138,11 @@ static CURL *get_curl_handle(void)
> >               curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 2L);
> >       }
> >
> > +     if (curl_ssl_verify_status &&
> > +         curl_easy_setopt(result, CURLOPT_SSL_VERIFYSTATUS, 1L) !=3D C=
URLE_OK)
> > +             die(_("http.sslVerifyStatus is set, but the TLS backend o=
f "
> > +                   "this libcurl cannot verify certificate status"));
>
> Should we include the output of `curl_easy_strerror()` in the error
> message? That'd cause us to include the following error message in case
> we see CURLE_NOT_BUILT_IN:
>
>   case CURLE_NOT_BUILT_IN:
>     return "A requested feature, protocol or option was not found built-i=
n in"
>            " this libcurl due to a build-time decision.";
>
> So we could instead do:
>
>         if (curl_ssl_verify_status) {
>                 CURLcode error =3D curl_easy_setopt(result, CURLOPT_SSL_V=
ERIFYSTATUS, 1L);
>                 if (error !=3D CURLE_OK)
>                     die(_("http.sslVerifyStatus is set, but could not ena=
ble OCSP status verification: %s"),
>                         curl_easy_strerror(error));
>         }
>
> > diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> > index 805bec025c..c11e96c1ac 100755
> > --- a/t/t5551-http-fetch-smart.sh
> > +++ b/t/t5551-http-fetch-smart.sh
> > @@ -680,6 +680,35 @@ test_expect_success 'passing hostname resolution i=
nformation works' '
> >       git -c "http.curloptResolve=3D$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0=
.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
> >  '
> >
> > +test_lazy_prereq SSL_VERIFYSTATUS '
> > +     test "$HTTPD_PROTO" =3D "https" &&
> > +     test_might_fail git -c http.sslVerifyStatus=3Dtrue \
> > +             ls-remote "$HTTPD_URL/smart/repo.git" 2>err &&
> > +     ! grep "cannot verify certificate status" err
> > +'
> > +
> > +test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=3Dtrue fail=
s without a staple' '
> > +     test_must_fail git -c http.sslVerifyStatus=3Dtrue \
> > +             ls-remote "$HTTPD_URL/smart/repo.git"
> > +'
> > +
> > +test_expect_success SSL_VERIFYSTATUS 'http.sslVerifyStatus=3Dfalse is =
a no-op' '
> > +     git -c http.sslVerifyStatus=3Dfalse \
> > +             ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> > +     test_line_count -gt 0 actual
> > +'
> > +
> > +test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus applies =
to a matching URL' '
> > +     test_must_fail git -c "http.$HTTPD_URL/.sslVerifyStatus=3Dtrue" \
> > +             ls-remote "$HTTPD_URL/smart/repo.git"
> > +'
> > +
> > +test_expect_success SSL_VERIFYSTATUS 'per-URL sslVerifyStatus is not a=
pplied to other URLs' '
> > +     git -c "http.https://example.com/.sslVerifyStatus=3Dtrue" \
> > +             ls-remote "$HTTPD_URL/smart/repo.git" >actual &&
> > +     test_line_count -gt 0 actual
> > +'
>
> Can we reasonably add tests that send OCSP information and verify that
> enabling "sslVerifyStatus" makes this work as expected?
>
> Patrick
