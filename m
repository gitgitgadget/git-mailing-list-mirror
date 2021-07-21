Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B4C6377B
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27925610D2
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 22:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhGUV7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 17:59:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65090 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhGUV7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 17:59:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C1D7C252C;
        Wed, 21 Jul 2021 18:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JdqQEeoEL51p
        P7XVd3aUVwnI7/bQI/xrArARiWiPwiE=; b=Ibok/nqQXDHJBC7DpghUnbDz60rs
        ohUDUlbQxQkYsWCrpG14y53lT4lv2vqSuuDx7V69b5TVDAS2zqwbgpThAzE/mYIZ
        iVfrPWA5re/93M0CCcok+0h1uQZjD6WMZ8p4XO2Et7LTHVi+AjkirTdsPKHtd3LQ
        h0Bo+WGfZLfBY/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 216A1C252B;
        Wed, 21 Jul 2021 18:39:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B54BC252A;
        Wed, 21 Jul 2021 18:39:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>,
        "Tom G . Christensen" <tgc@jupiterrise.com>,
        Mischa POSLAWSKY <git@shiar.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/5] drop support for ancient curl
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
        <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
Date:   Wed, 21 Jul 2021 15:39:45 -0700
In-Reply-To: <cover-0.5-00000000000-20210721T220402Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 22 Jul
 2021 00:22:11 +0200")
Message-ID: <xmqq35s7cmvi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8CEF3322-EA74-11EB-8BA5-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series simplifies the http code by dropping support for curl
> versions older than 7.19.4, released in March 2009.

Thanks.

Will take a look and may have some comments, but I'd prefer to see
an Ack from Peff as well.

> Jeff King (3):
>   http: drop support for curl < 7.11.1
>   http: drop support for curl < 7.16.0
>   http: drop support for curl < 7.19.4
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
>   http: drop support for curl < 7.19.3 and < 7.16.4 (again)
>   http: rename CURLOPT_FILE to CURLOPT_WRITEDATA
>
>  http-push.c   |  29 +--------
>  http-walker.c |  14 +----
>  http.c        | 169 ++------------------------------------------------
>  http.h        |  46 --------------
>  imap-send.c   |   4 --
>  remote-curl.c |  11 +---
>  6 files changed, 10 insertions(+), 263 deletions(-)
>
> Range-diff against v1:
> 1:  8793735cc2c ! 1:  dcbb6f95652 http: drop support for curl < 7.11.1
>     @@ Metadata
>       ## Commit message ##
>          http: drop support for curl < 7.11.1
>     =20
>     -    Recent versions of Git will not build with curl older than
>     -    7.11.1 due to (at least) two issues:
>     +    Drop support for this ancient version of curl and simplify the=
 code by
>     +    allowing us get rid of some "#ifdef"'s.
>     +
>     +    Git will not build with vanilla curl older than 7.11.1 due to =
(at
>     +    least) two issues:
>     =20
>            - our use of CURLOPT_POSTFIELDSIZE in 37ee680d9b
>              (http.postbuffer: allow full range of ssize_t values,
>     @@ Commit message
>          obvious benefit is that we'll have fewer conditional bits
>          cluttering the code.
>     =20
>     -    But more importantly, we're doing a disservice to users to
>     -    pretend that Git works with old versions. It's clear that
>     -    nobody is testing modern Git with such old versions of curl
>     -    (we've had 3 released versions with the CURLPROTO issue
>     -    without a report of anyone seeing the breakage in the wild).
>     -    And there are a lot of subtle ways we could be getting this
>     -    wrong (for instance, curl prior to 7.17.0 did not copy
>     -    string arguments to curl_easy_setopt(), which means that
>     -    using an old copy of curl could produce use-after-free
>     -    bugs that are not present with more recent versions).
>     -
>          This patch drops all #ifdefs that reference older versions
>          (note that curl's preprocessor macros are in hex, so we're
>          looking for 070b01, not 071101).
>     =20
>     +    Signed-off-by: Jeff King <peff@peff.net>
>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>     +
>       ## http.c ##
>      @@
>       static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);
> 2:  15638cd1856 ! 2:  1c9f3bc031b http: drop support for curl < 7.16.0
>     @@ Metadata
>       ## Commit message ##
>          http: drop support for curl < 7.16.0
>     =20
>     -    As discussed in the previous commit, Git is not well-tested
>     -    with old versions of curl (and in fact since v2.12.0 does
>     -    not even compile with versions older than 7.19.4). Let's
>     -    stop pretending we support curl that old and drop any
>     -    now-obslete #ifdefs.
>     +    In the last commit we dropped support for curl < 7.11.1, let's
>     +    continue that and drop support for versions older than 7.16.0.=
 This
>     +    allows us to get rid of some now-obsolete #ifdefs.
>     =20
>     -    Choosing 7.16.0 is a somewhat arbitrary cutoff, but:
>     +    Choosing 7.16.0 is a somewhat arbitrary cutoff:
>     =20
>     -      1. it came out in October of 2006, over 10 years ago.
>     -         Besides being a nice round number, it's a common
>     -         end-of-life support period, even for conservative
>     +      1. It came out in October of 2006, almost 15 years ago.
>     +         Besides being a nice round number, around 10 years is
>     +         a common end-of-life support period, even for conservativ=
e
>               distributions.
>     =20
>     -      2. that version introduced the curl_multi interface, which
>     +      2. That version introduced the curl_multi interface, which
>               gives us a lot of bang for the buck in removing #ifdefs
>     =20
>     +    RHEL 5 came with curl 7.15.5[1] (released in August 2006). RHE=
L 5's
>     +    extended life cycle program ended on 2020-11-30[1]. RHEL 6 com=
es with
>     +    curl 7.19.7 (released in November 2009), and RHEL 7 comes with
>     +    7.29.0 (released in February 2013).
>     +
>     +    1. http://lore.kernel.org/git/873e1f31-2a96-5b72-2f20-a5816cad=
1b51@jupiterrise.com
>     +
>     +    Signed-off-by: Jeff King <peff@peff.net>
>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>     +
>       ## http-push.c ##
>      @@ http-push.c: static void curl_setup_http(CURL *curl, const char=
 *url,
>       	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
>     @@ http.h: void finish_all_active_slots(void);
>       void http_init(struct remote *remote, const char *url,
>       	       int proactive_auth);
>     =20
>     + ## imap-send.c ##
>     +@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_se=
rver_conf *server,
>     + 	if (cred.username) {
>     + 		if (res =3D=3D CURLE_OK)
>     + 			credential_approve(&cred);
>     +-#if LIBCURL_VERSION_NUM >=3D 0x070d01
>     + 		else if (res =3D=3D CURLE_LOGIN_DENIED)
>     +-#else
>     +-		else
>     +-#endif
>     + 			credential_reject(&cred);
>     + 	}
>     +=20
>     +
>       ## remote-curl.c ##
>      @@ remote-curl.c: static size_t rpc_out(void *ptr, size_t eltsize,
>       	return avail;
> 3:  335046de7bc ! 3:  faae88b7fec http: drop support for curl < 7.19.4
>     @@ Metadata
>       ## Commit message ##
>          http: drop support for curl < 7.19.4
>     =20
>     -    Since v2.12.0, Git does not compile with versions of curl
>     -    older than 7.19.4. That version of curl is about 8 years
>     -    old. This means it may still be used in some distributions
>     -    with long-running support periods. But the fact that we
>     -    haven't received a single bug report about the compile-time
>     -    breakage implies that nobody cares about building recent
>     -    releases on such platforms.
>     +    In the last commit we dropped support for curl < 7.16.0, let's
>     +    continue that and drop support for versions older than 7.19.4.=
 This
>     +    allows us to simplify the code by getting rid of some "#ifdef"=
's.
>     =20
>     -    As discussed in the previous two commits, this cleans up the
>     -    code and gives a more realistic signal to users about which
>     -    versions of Git are actually tested (in particular, this
>     -    moves us past the potential use-after-free issues with curl
>     -    older than 7.17.0).
>     +    Git was broken with vanilla curl < 7.19.4 from v2.12.0 until
>     +    v2.15.0. Compiling with it was broken by using CURLPROTO_* out=
side any
>     +    "#ifdef" in aeae4db174 (http: create function to get curl allo=
wed
>     +    protocols, 2016-12-14), and fixed in v2.15.0 in f18777ba6ef (h=
ttp: fix
>     +    handling of missing CURLPROTO_*, 2017-08-11).
>     +
>     +    It's unclear how much anyone was impacted by that in practice,=
 since
>     +    as noted in [1] RHEL versions using curl older than that still
>     +    compiled, because RedHat backported some features. Perhaps oth=
er
>     +    vendors did the same.
>     +
>     +    Still, it's one datapoint indicating that it wasn't in active =
use at
>     +    the time. That (the v2.12.0 release) was in Feb 24, 2017, with=
 v2.15.0
>     +    on Oct 30, 2017, it's now mid-2021.
>     +
>     +    1. http://lore.kernel.org/git/c8a2716d-76ac-735c-57f9-175ca3ac=
bcb0@jupiterrise.com;
>     +       followed-up by f18777ba6ef (http: fix handling of missing C=
URLPROTO_*,
>     +       2017-08-11)
>     +
>     +    Signed-off-by: Jeff King <peff@peff.net>
>     +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@=
gmail.com>
>     =20
>       ## http.c ##
>      @@ http.c: static int min_curl_sessions =3D 1;
>     @@ http.c: static void var_override(const char **var, char *value)
>       }
>      =20
>       static void init_curl_proxy_auth(CURL *result)
>     +@@ http.c: void setup_curl_trace(CURL *handle)
>     + 	curl_easy_setopt(handle, CURLOPT_DEBUGDATA, NULL);
>     + }
>     +=20
>     +-#ifdef CURLPROTO_HTTP
>     + static long get_curl_allowed_protocols(int from_user)
>     + {
>     + 	long allowed_protocols =3D 0;
>     +@@ http.c: static long get_curl_allowed_protocols(int from_user)
>     +=20
>     + 	return allowed_protocols;
>     + }
>     +-#endif
>     +=20
>     + #if LIBCURL_VERSION_NUM >=3D0x072f00
>     + static int get_curl_http_version_opt(const char *version_string, =
long *opt)
>      @@ http.c: static CURL *get_curl_handle(void)
>       	}
>      =20
>     @@ http.c: static CURL *get_curl_handle(void)
>      -#if LIBCURL_VERSION_NUM >=3D 0x071301
>       	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL)=
;
>      -#elif LIBCURL_VERSION_NUM >=3D 0x071101
>     - 	curl_easy_setopt(result, CURLOPT_POST301, 1);
>     +-	curl_easy_setopt(result, CURLOPT_POST301, 1);
>      -#endif
>      -#ifdef CURLPROTO_HTTP
>       	curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> 4:  e049f37357a < -:  ----------- http: #error on too-old curl
> -:  ----------- > 4:  9a30e92520c http: drop support for curl < 7.19.3 =
and < 7.16.4 (again)
> -:  ----------- > 5:  64e510b4a6b http: rename CURLOPT_FILE to CURLOPT_=
WRITEDATA
