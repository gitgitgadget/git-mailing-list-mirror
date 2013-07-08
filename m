From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] t0000: do not use export X=Y
Date: Mon, 8 Jul 2013 16:36:05 +0200
Message-ID: <8761wli0fe.fsf@linux-k42r.v.cablecom.net>
References: <201307081121.22769.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 08 16:36:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwCY1-00048k-3g
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 16:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab3GHOgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jul 2013 10:36:08 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6281 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183Ab3GHOgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 10:36:07 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Jul
 2013 16:36:05 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 8 Jul 2013 16:36:05 +0200
In-Reply-To: <201307081121.22769.tboegi@web.de> ("Torsten \=\?utf-8\?Q\?B\?\=
 \=\?utf-8\?Q\?\=C3\=B6gershausen\=22's\?\=
	message of "Mon, 8 Jul 2013 11:21:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229859>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The shell syntax "export X=3DY A=3DB" is not understood by all shells=
=2E
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t0000-basic.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 5c32288..10be52b 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -53,7 +53,8 @@ run_sub_test_lib_test () {
>  		# Pretend we're a test harness.  This prevents
>  		# test-lib from writing the counts to a file that will
>  		# later be summarized, showing spurious "failed" tests
> -		export HARNESS_ACTIVE=3Dt &&
> +		HARNESS_ACTIVE=3Dt &&
> +		export HARNESS_ACTIVE &&
>  		cd "$name" &&
>  		cat >"$name.sh" <<-EOF &&
>  		#!$SHELL_PATH

Ack.  Sorry for breaking this -- I suppose test-lint would have caught
me out?

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
