Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235624;
	b=erawbUqCK48f6p/7lmEHA2H9hQn6PAuF+qzFSA5/ESjFJVN1OASX3nU6VnfY1pDgjA5k
	 JMLmaRURC4ndHGe7sRars6aOebNtTVg7Os7nf4VWyavJkUa+35Sn8O17taOQbHpS7echY
	 vHGicdwg57LcokaElPM8xYPK3fxH1gSVj9k3WEXnWVa30UXsdvqNVDyi6zXTwbjaC8VCd
	 5oOSid5U2NM2ct3GAyoRsP46FCwUw/53ycyzM5dFHkL9BHXZOYqldA1inG2mJf+sT402p
	 gAPL/g4GXzR/+Zwl9Fn+wAC3fhZYSUzTe4dZlNZqaJgUqXF/LRc39aCotIU3mGwDqVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235624;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport:Content-Transfer-Encoding;
	bh=D3ZWx1rTywyxOpGZxBUpE4DCNTg5wS/gaf1zjwxH5pc=;
	b=Nsm47q9vpfyJhcFprj/rpZp2xZgrQpywWKNrWNVqNcWec2y5bRqNFI1mDyAchYWNqTTu
	 rAwJebHX0kK0sFnoRVnV4SBtja7XidrB5nX9RqcnfKt2BnDwxixM5hIDoLQrngWFjCPyZ
	 AY65SFSRtMIlzF1wAhfqNERdNNUkg7LAUGpjmAGXHyb2aa1Dsi2dkhIRXcFP/x9amxXJn
	 s0zOMVjAOgzI3Lu/cMG8SNOHM38WGJEq3ug+MC/RvpfgdhGEbIQgekUkZZFyz1iDKmzFt
	 jmLNHAfKoxFJ8OJ8FzC07jW5ZTznWpULObP/5GyD1oBhc6/ITVb5jnA2pjhXf3Tu8mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ACPdXWhS;
	arc=none smtp.remote-ip=212.227.17.11
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D5606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 14:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D83D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=web.de header.i=tboegi@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ACPdXWhS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794235612; x=1794840412; i=tboegi@web.de;
	bh=D3ZWx1rTywyxOpGZxBUpE4DCNTg5wS/gaf1zjwxH5pc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ACPdXWhSxIGyKjSdamhST3qxhPC3SIVArtRP6y33tbox1B+eqi6F82fp0aC6yJF0
	 Mlm/sqlUexeUCf11KuxrWnC3p4+kTHhaQQyg9VsGwTrfU9XSh4O/AV3T+OAw+fC0F
	 KiKv5rZ9PM1v4hHQrRK48rqx6qNg/1RWXgkoYs/XA+56ye5L+jg6ixvo8CV8bmODQ
	 YH+MXT6kf856tUnUI5JOg+WXONnH3IaaefhnLnANy2yQ7N9SChtl39XWXw+gkndcQ
	 LwPsYUpx086w0/PlhBGg6OjFGx09dyIpFMuEZZ11SQ/Nm90UECnReo97Mvzyy2MqW
	 KCMXuztd0UKGw8nZFg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVwi-1wmAPy23e2-00mOQs; Mon, 09
 Nov 2026 15:46:52 +0100
Date: Mon, 9 Nov 2026 15:46:51 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/7] t0027: cache expected output files
Message-ID: <20261109144651.GA14738@tb-raspi4>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
 <20261109-pks-gitlab-ci-speedups-v2-5-508832602d0b@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-5-508832602d0b@pks.im>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:IZbaqv31w51oFMp/+EcxtCm/8ewmdU1o9H4lZvdwQu+mMjPsIR4
 vqdvg42gJ4ll6zUFDn9Vlv3d/12MMcVAtEI1hMQLI31LMuO8WL6RkDDBB9i9PBSBRoB6aui
 6/Vu1axp3K6N8Yx0fm5UPpMaxFU5ssJRtjshXyFoxs8aCcz/xFCS6uSB6vsU+Ca157ju6vn
 S+k/KfdcUP+ixdMa/7aFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wzpSc05stnA=;y34K+4vuHjXwSahPVtgyAGTz2ff
 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
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2026 at 10:58:26AM +0100, Patrick Steinhardt wrote:
> In the preceding commit we have optimized one aspect of t0027 already.
> Another inefficiency is `compare_files ()` and `compare_ws_file ()`,
> which are both called more than a 1000 times.
>=20
> These functions will repeatedly generate the same expected outcome even
> though there's only a small handful of input files that the expected
> outcome is computed from. Recomputing those every time is of course
> quite pointless.
>=20
> Improve this by computing the expected outcome once, only, to reduce the
> number of spawned processes. This reduces the runtime by around 20-25%,
> and on Windows the runtime decreases from 480 to 380 seconds.
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0027-auto-crlf.sh | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
> index 504a7ea54bb..b021f0855a8 100755
> --- a/t/t0027-auto-crlf.sh
> +++ b/t/t0027-auto-crlf.sh
> @@ -5,22 +5,23 @@ test_description=3D'CRLF conversion all combinations'
>  . ./test-lib.sh
> =20
>  compare_files () {
> -	tr '\015\000' QN <"$1" >"$1".expect &&
> +	{ test -f "$1".expect || tr '\015\000' QN <"$1" >"$1".expect; } &&
>  	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
> -	test_cmp "$1".expect "$2".actual &&
> -	rm "$1".expect "$2".actual
> +	test_cmp "$1".expect "$2".actual
>  }
> =20

Nice.
If you want to save even more CPU/SSD-cycles,
you can prepare the expect files like this:
(No, I didn't do any benchmarks, nor look at ws_compare)


diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 49dbf09da7..3563336162 100755
=2D-- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -5,10 +5,9 @@ test_description=3D'CRLF conversion all combinations'
 . ./test-lib.sh
=20
 compare_files () {
-	tr '\015\000' QN <"$1" >"$1".expect &&
 	tr '\015\000' QN <"$2" | tr -d 'Z' >"$2".actual &&
-	test_cmp "$1".expect "$2".actual &&
-	rm "$1".expect "$2".actual
+	test_cmp "expd/$1".expect "$2".actual &&
+	rm "$2".actual
 }
=20
 compare_ws_file () {
@@ -343,6 +342,25 @@ checkout_files () {
 	"
 }
=20
+test_expect_success 'create expect files' '
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINE=
TWO\nLINETHREE"     >LF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\n=
LINETWO\r\nLINETHREE" >CRLF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\nLI=
NETWO\nLINETHREE"   >CRLF_mix_LF &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINE=
TWO\rLINETHREE"     >LF_mix_CR &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\n=
LINETWO\rLINETHREE"   >CRLF_mix_CR &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONEQ\r\=
nLINETWO\r\nLINETHREE" | q_to_nul >CRLF_nul &&
+	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONEQ\nLIN=
ETWO\nLINETHREE" | q_to_nul >LF_nul &&
+  mkdir expd &&
+  echo "* -text" >expd/.gitattributes &&
+	tr "\015\000" QN <LF >expd/LF.expect &&
+	tr "\015\000" QN <CRLF >expd/CRLF.expect &&
+	tr "\015\000" QN <CRLF_mix_LF >expd/CRLF_mix_LF.expect &&
+	tr "\015\000" QN <LF_mix_CR >expd/LF_mix_CR.expect &&
+	tr "\015\000" QN <CRLF_mix_CR >expd/CRLF_mix_CR.expect &&
+	tr "\015\000" QN <CRLF_nul >expd/CRLF_nul.expect &&
+	tr "\015\000" QN <LF_nul >expd/LF_nul.expect
+  '
+
 # Test control characters
 # NUL SOH CR EOF=3D=3D^Z
 test_expect_success 'ls-files --eol -o Text/Binary' '



[snip]
