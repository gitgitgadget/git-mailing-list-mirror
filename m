Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B794BC43467
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6582720878
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kNEppR+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbgJLT0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:26:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:41491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387595AbgJLT0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602530766;
        bh=rRsMaTJDdYnK37lOoJyCuppSvyhfNe0YjGRLkNPcE4k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kNEppR+PdV/B7KmvW/pa2vxqk5ZWeluqING7iauYWH53MBfmpbGkBJpji+TA77o01
         b0E79lRDdPJvpwnkiklnXr8vmA7o1xtD+bnG25gRY8W7d4DF+sLbiDP/SZTG5MqxRQ
         dghV7DQp9eZv7b0xdjHU8RYldPS+P95UXrQbcrHY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1kexVB01LT-00FGBG; Mon, 12
 Oct 2020 21:26:06 +0200
Date:   Mon, 12 Oct 2020 21:26:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Sean McAllister <smcallis@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        masayasuzuki@google.com
Subject: Re: [PATCH 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
In-Reply-To: <20201012184806.166251-2-smcallis@google.com>
Message-ID: <nycvar.QRO.7.76.6.2010122119580.50@tvgsbejvaqbjf.bet>
References: <20201012184806.166251-1-smcallis@google.com> <20201012184806.166251-2-smcallis@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9npECT0xQ31tlqJyhRxdLQKNEnRVL39iYNyWduuPyAeqPJmDU0n
 /Oxj019DaYUvHWVtW9GWvpNskYOmkna1F3xRDI2rBvBh1oZmcZwipqjCAoD9P040KjkQTQN
 vL9OoeVEfgXMLqEG3PCiWUfhYgkihVvZrDeG3PT7jbY2bIs2wLiLvAhUulf1vkKJ4P70k6T
 Lqm7vEUF1b1srR28r1tkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gZRtwLOGF+0=:VyaiyMIYYEuWdRsywnYt4f
 H1+6Yo+xVUx1f763PS3AVgfwpiueG+XIevIjC6MU1IAD7qwEPj6NyzsBK0Gu5Rvqi1MJF2YmG
 E1g4GiXd9Gu1YaXVuD1p0LdLPktarWtuP7WPPEt9r+b/nPlTPBbh5QlSrZE0K/5KWceRbQZda
 8csZGnziOWe3lJXxdtPihlOn/MJhwmVtrQpIm5v7MKXIIv1NDFXW5FjwTj0Wm7baQIrHS1Qmr
 711IUDmP0qFdCvhV+qrHpDNrYI4vUHfDTJlE08EhFsGn7XrV6wbFL5Tj3TyDr1TH5okj92XSf
 OQ7dU+8A5/jGV455uM20F+gJuo/UDZqufF3R4OK5V+udGCqE4jX04xmLaZIny1gtYVgDSDKu0
 imfIiQ7xGurq6Uhd8tIZVviG13atpO/9b/6xi0I+hJnileDbHXeUwVtCjAQzu5Fv11Bkth/Ww
 4ZhqTuy+u2Yv2/WvUuK8/kcnfcxNY7KkfWo/8HWOk1Hxt8WlGqxX6VDsVnZv3g4fmIysQCsE8
 i+gCnEv5iOS9OACu6JQutuQjtfn2zqVy4wYUUtsA88y2qBGMVaOuqbsLLUe/v2W29QeX4uap6
 opUqVCJy2ooyrxnJM9YDH3+3qLDhWqqL2ma+nIyG2/YdWAk+ZgXUc8shaGdVLFGJkKDynQMcv
 2Ob0Mhcox2q+AChzDHyof+LZJ7jfBidLp3n6f0wvA2lxH6ZD1wcxGbfEu5l7DQ0JhGo1Dfbq2
 deFPRZCnZYIvxWTa1UToOTK6fujExKEGRJRKOVkYLatj8lGI9F6vD0bQ1Ohbkqykzy70avKxE
 gRm2K9+axwB4D9mBaA9VyJ02mt97OH16tELmewRj7JQLzmgs+9lex0AAHkbHpF9OByBxqcJfK
 TumiarGOUYf2r+8NVVsUUyEQNJffd+JWQdr07aLNxD6TpjrH4NUR5jK8mL39OuOSUSjtBqyk+
 RUlngjTlkZhxgVU8jC2wZWuOYnYPiG+FsK5AAHl14pmhE10b1cpdOw0zc93VOADGpIoK3e9Hv
 Vw+NDFPqOcLh5XTgzl+PJZ2Z4NwcDWmO2oPZE/7GOdpT8X2Z4rlXBiohZrzu715beTAHR23QA
 U9jEEghJPKGvGeRNG8+EN2lbqjeTY75AEG8gVNAfGu6aAh5G3T/N2NlyTMkfZwMp69K2ZY4S9
 2xPsmbfdX4Q4S4bLrUS2dH+zrcC7MCqpMHoyGMbGS6wCj0yOPo+uxCw0ldASTDMqrM/9TBTZG
 ZsH9Ylcz6gGLIiOLgIVo2gIFAUZZsxcAB0KiLLw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sean,

On Mon, 12 Oct 2020, Sean McAllister wrote:

> CURLOPT_FILE has been deprecated since 2003.

To be precise, it has been aliased to `CURLOPT_WRITEDATA` in cURL v7.9.7:
https://github.com/curl/curl/commit/980a47b42b95d7b9ff3378dc7b0f2e1c453fb6=
49

The `CURLOPT_WRITEDATA` symbol became the preferred one only in v7.37.1 in
2014, though:
https://github.com/curl/curl/commit/5fcef972b289bdc7f3dbd7a55a5ada0460b74b=
2d

Ciao,
Dscho

>
> Signed-off-by: Sean McAllister <smcallis@google.com>
> ---
>  http-push.c   | 6 +++---
>  http-walker.c | 2 +-
>  http.c        | 6 +++---
>  remote-curl.c | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index 6a4a43e07f..2e6fee3305 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -894,7 +894,7 @@ static struct remote_lock *lock_remote(const char *p=
ath, long timeout)
>  	slot->results =3D &results;
>  	curl_setup_http(slot->curl, url, DAV_LOCK, &out_buffer, fwrite_buffer)=
;
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
>
>  	lock =3D xcalloc(1, sizeof(*lock));
>  	lock->timeout =3D -1;
> @@ -1151,7 +1151,7 @@ static void remote_ls(const char *path, int flags,
>  	curl_setup_http(slot->curl, url, DAV_PROPFIND,
>  			&out_buffer, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
>
>  	if (start_active_slot(slot)) {
>  		run_active_slot(slot);
> @@ -1225,7 +1225,7 @@ static int locking_available(void)
>  	curl_setup_http(slot->curl, repo->url, DAV_PROPFIND,
>  			&out_buffer, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &in_buffer);
>
>  	if (start_active_slot(slot)) {
>  		run_active_slot(slot);
> diff --git a/http-walker.c b/http-walker.c
> index 4fb1235cd4..6c630711d1 100644
> --- a/http-walker.c
> +++ b/http-walker.c
> @@ -384,7 +384,7 @@ static void fetch_alternates(struct walker *walker, =
const char *base)
>  	alt_req.walker =3D walker;
>  	slot->callback_data =3D &alt_req;
>
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
>  	curl_easy_setopt(slot->curl, CURLOPT_URL, url.buf);
>
> diff --git a/http.c b/http.c
> index 8b23a546af..b3c1669388 100644
> --- a/http.c
> +++ b/http.c
> @@ -1921,7 +1921,7 @@ static int http_request(const char *url,
>  		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 1);
>  	} else {
>  		curl_easy_setopt(slot->curl, CURLOPT_NOBODY, 0);
> -		curl_easy_setopt(slot->curl, CURLOPT_FILE, result);
> +		curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, result);
>
>  		if (target =3D=3D HTTP_REQUEST_FILE) {
>  			off_t posn =3D ftello(result);
> @@ -2337,7 +2337,7 @@ struct http_pack_request *new_direct_http_pack_req=
uest(
>  	}
>
>  	preq->slot =3D get_active_slot();
> -	curl_easy_setopt(preq->slot->curl, CURLOPT_FILE, preq->packfile);
> +	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEDATA, preq->packfile);
>  	curl_easy_setopt(preq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
>  	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
>  	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER,
> @@ -2508,7 +2508,7 @@ struct http_object_request *new_http_object_reques=
t(const char *base_url,
>
>  	freq->slot =3D get_active_slot();
>
> -	curl_easy_setopt(freq->slot->curl, CURLOPT_FILE, freq);
> +	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEDATA, freq);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_FAILONERROR, 0);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_WRITEFUNCTION, fwrite_sha1_=
file);
>  	curl_easy_setopt(freq->slot->curl, CURLOPT_ERRORBUFFER, freq->errorstr=
);
> diff --git a/remote-curl.c b/remote-curl.c
> index 32cc4a0c55..7f44fa30fe 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -847,7 +847,7 @@ static int probe_rpc(struct rpc_state *rpc, struct s=
lot_results *results)
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, 4);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buf);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &buf);
>
>  	err =3D run_slot(slot, results);
>
> @@ -1012,7 +1012,7 @@ static int post_rpc(struct rpc_state *rpc, int sta=
teless_connect, int flush_rece
>  	rpc_in_data.slot =3D slot;
>  	rpc_in_data.check_pktline =3D stateless_connect;
>  	memset(&rpc_in_data.pktline_state, 0, sizeof(rpc_in_data.pktline_state=
));
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &rpc_in_data);
> +	curl_easy_setopt(slot->curl, CURLOPT_WRITEDATA, &rpc_in_data);
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 0);
>
>
> --
> 2.28.0.1011.ga647a8990f-goog
>
>
