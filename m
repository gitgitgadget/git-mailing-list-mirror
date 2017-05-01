Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7591F790
	for <e@80x24.org>; Mon,  1 May 2017 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999024AbdEALdI (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 07:33:08 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35002 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969300AbdEALca (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 07:32:30 -0400
Received: by mail-wr0-f196.google.com with SMTP id g12so13584231wrg.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 04:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L6hIe0NY3BbI+IG5YU5w8uy9puuOQOu5hvdFSU3214U=;
        b=hYnqLcT1EYZcwnheyi94EP2V0NAL/XCyAxbfTD6HOZeoppRcJ9Hbt/E72tBEyGZdry
         6lBHp0C2AQL9fofiNus462UJ1G1fD6IXJKT6vFsoD1w7WcoO1cQyPdY6Jen1QfLTkbh5
         hNJd7djloPaqOhStUz2g5cVfOO6Q5SLseTNuEhJSu1g9qE9dCAzYv1dKXwXZLWYnT6Z9
         drZ17uFjft5JqUP3s66LLtev67okbHsf+gdmAos1XicIY4Kq/fJXaV7kkIcm3N04PVQW
         1hti0j+39J2VW4hjBkoDsuGw7EjPjpdX+iTIHbR6bA8dz7lDmYa/mQ9udFis9CzZ7E7p
         PU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=L6hIe0NY3BbI+IG5YU5w8uy9puuOQOu5hvdFSU3214U=;
        b=fhO/N4uWtzolhHZP+CEsmd48NVF6vBCETebCQmbTB1aIHRmGJxSgV/EEhvLjqBpBzR
         PycKTFFKzff7G7ZaC4y/zta62u0LAeUv7UlI+hAA2KELRFQef0scBvufHNiVyZZICKj/
         7G5UUzOH6wgWLMxHtqSNTvze+mcAV+RGghZSxXdw3uuc7/ekVYqGnTSETcp/5B0b5nfh
         AaDVjSnnDCE6HJ5jcb6158xm5eTKgZAcy3Z4X1arQtW63g0bgH5pbriseuSt4Id/2cfR
         od9fcyI91yy1Cw9CH/da4fS3VzMJ+sQXFrlXzOPLu2SF52s+GsEBRCL3X6rXXsAhvOUZ
         7x3A==
X-Gm-Message-State: AN3rC/5KhlZ5uRnSuNIdiRYsJUhzcdTC9UrdXJwOLsC5lB/Qw89edgzU
        go2wvANtfshY3A==
X-Received: by 10.223.131.34 with SMTP id 31mr18214499wrd.95.1493638349152;
        Mon, 01 May 2017 04:32:29 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4780.dip0.t-ipconnect.de. [93.219.71.128])
        by smtp.gmail.com with ESMTPSA id 39sm15275968wru.50.2017.05.01.04.32.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 May 2017 04:32:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170429184822.10128-1-larsxschneider@gmail.com>
Date:   Mon, 1 May 2017 13:32:27 +0200
Cc:     Johannes.Schindelin@gmx.de, Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C434AB60-F2BB-44A1-B40D-449EA27E2314@gmail.com>
References: <20170429184822.10128-1-larsxschneider@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Apr 2017, at 20:48, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>=20
> The Git for Windows CI web app sometimes returns HTTP errors of
> "502 bad gateway" or "503 service unavailable" [1]. Wait a little and
> retry the request if this happens.
>=20
> [1] =
https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-tro=
ubleshoot-http-502-http-503
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>=20
> Hi,
>=20
> this should make the Git for Windows build a bit more stable. We saw
> a few 502's recently. E.g. =
https://travis-ci.org/git/git/jobs/226669324
>=20
> I did not add any checks to avoid an endless loop because TravisCI =
would
> shutdown the worker if there is no output for more than 10min. =
Therefore
> I think we don't need to handle this case ourselves.
>=20
> Cheers,
> Lars
>=20
> Notes:
>    Base Ref: next
>    Web-Diff: https://github.com/larsxschneider/git/commit/b57ebf31ab
>    Checkout: git fetch https://github.com/larsxschneider/git =
travisci/win-retry-v1 && git checkout b57ebf31ab
>=20
> ci/run-windows-build.sh | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>=20
> diff --git a/ci/run-windows-build.sh b/ci/run-windows-build.sh
> index e043440799..7a9aa9c6a7 100755
> --- a/ci/run-windows-build.sh
> +++ b/ci/run-windows-build.sh
> @@ -15,6 +15,8 @@ COMMIT=3D$2
> gfwci () {
> 	local CURL_ERROR_CODE HTTP_CODE
> 	exec 3>&1
> +	while test -z $HTTP_CODE
> +	do
> 	HTTP_CODE=3D$(curl \
> 		-H "Authentication: Bearer $GFW_CI_TOKEN" \
> 		--silent --retry 5 --write-out '%{HTTP_CODE}' \
> @@ -22,6 +24,16 @@ gfwci () {
> 		=
"https://git-for-windows-ci.azurewebsites.net/api/TestNow?$1" \
> 	)
> 	CURL_ERROR_CODE=3D$?
> +		# The GfW CI web app sometimes returns HTTP errors of
> +		# "502 bad gateway" or "503 service unavailable".
> +		# Wait a little and retry if it happens. More info:
> +		# =
https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-tro=
ubleshoot-http-502-http-503
> +		if test $HTTP_CODE -eq 502 || test $HTTP_CODE -eq 503
> +		then
> +			sleep 10
> +			HTTP_CODE=3D
> +		fi
> +	done

Please don't move this to next, yet. This seems not to work as expected =
:-(
https://travis-ci.org/git/git/jobs/227513693

- Lars=
