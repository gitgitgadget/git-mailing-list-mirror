From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t5510: run auto-gc in the foreground
Date: Mon, 2 May 2016 09:01:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605020859131.9313@virtualbox>
References: <20160501153743.323-1-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1835063548-1462172469=:9313"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon May 02 09:01:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax7r4-0000Dk-GY
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbcEBHBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:01:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:57259 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcEBHBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:01:14 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MV30j-1bBZex1aSj-00YUKM; Mon, 02 May 2016 09:01:06
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160501153743.323-1-szeder@ira.uka.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KdAJaFEyzXd+2hi0Ospl/BR5kmcEv1Q6Td2FzoALavzI/ywLKJz
 dEHRjnIc6JVCIwOfOG7DpObJg1syNOqQ9SeOarKq+P0ABjEVDBVIcbuGe6D1OpE0gDISB4n
 Bw+BeS/frIlvIB++tt/nRfO+maJo2IOBCJPGmnFfLB2uZYFs2sYh85yRRDhMKqFqW8NRlk3
 mTabk1bZNRwkmi8L6K2yA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TWcV+HEnVGA=:h/hjK+Ym9wQD+XGqHgZV/6
 uJIz3j+4xc/s6u/th790l8oyVGaI75l5i8oS0wD95mFwKXTbO+Q4aiVUT9VcWwMbv+a5xH6wm
 SIDhp3WK9I8w49CBFjdtVnjQYHjupg1pTl6TVYvW7zmCBUpiw2TInpttkvU61N+qQQ/qr+KsF
 AUQ0w4PoW1oUgHftxcJ4Mp7PWZT8Vg7hFuEo4MQn+HheL9eYKErTF334wPEj0doz52PRE0I3x
 CX7mwyJIEeQgai8vv8WlVNMSTNATDNJdclBkGe4UOFSKOC57U/iEC4CbNKNS/RBDONSUgHkyD
 bXrAJz1+TnPufgc/U/y14MqIVhZXMVdxBz46h8nrwcgMNm0SDS00CKy1IKtbt8d0fvXe4MC2N
 p3E+bFYIgqt/Ly/GQWrGXMoccff/VFbfQUGMAynBD0tsq4ck1H2EpSj7jR7WD3u6zI8EoH9bt
 2YY/ySb0qCgrGwkZmqXr7aJsBVLNdHQTPS8QC/6QM7GJQQO41cpeTnqYX9Oh/7SAJ7LA9RUxX
 0mKGDH2jIQ/wKp7VbJFZfPgjmmTTWU29WovPNh5TW8lebBGea5+744t9Fd2v6QWx2CRtNiksn
 2lrpSSrGkCviH+/QqdftZhaLGLze2Uut4gS+FraE7EXTijUXUCqcoQgiVfBtd1lt9gfdNtE6g
 Aw8SrMwhBGqoWvbjr9habwX6mJokwpuFILaD/u8LpSNeSFcssnuGhhMeaPfoDicOSB1Oh1CMn
 rMx2qrlkaP+jZmnlnJxHCQPcvSdvSOBRZXOOVleevoQwvWSn9Aj6moNKXhTCZ6m+2+bdGpI0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293221>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1835063548-1462172469=:9313
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sun, 1 May 2016, SZEDER G=C3=A1bor wrote:

> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 38321d19efbe..454d896390c0 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -682,6 +682,7 @@ test_expect_success 'fetching with auto-gc does not l=
ock up' '
>  =09(
>  =09=09cd auto-gc &&
>  =09=09git config gc.autoPackLimit 1 &&
> +=09=09git config gc.autoDetach false &&
>  =09=09GIT_ASK_YESNO=3D"$D/askyesno" git fetch >fetch.out 2>&1 &&
>  =09=09! grep "Should I try again" fetch.out
>  =09)

Sounds good to me.

Alternatively, we could consider passing `-c gc.autoDetach=3Dfalse` instead=
,
to limit the scope. I am not insisting on it, of course ;-)

Ciao,
Dscho
--8323329-1835063548-1462172469=:9313--
