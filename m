From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 3/6] Makefile: Split out the untested functions target
Date: Sun, 25 Jul 2010 01:02:19 +0200
Message-ID: <201007250102.20099.trast@student.ethz.ch>
References: <1280004663-4887-1-git-send-email-avarab@gmail.com> <1280004663-4887-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 25 01:02:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocnjz-0000J8-K6
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 01:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab0GXXCm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jul 2010 19:02:42 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14109 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab0GXXCl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jul 2010 19:02:41 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 25 Jul
 2010 01:02:40 +0200
Received: from thomas.localnet (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sun, 25 Jul
 2010 01:02:19 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.93; x86_64; ; )
In-Reply-To: <1280004663-4887-4-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151684>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Change the coverage-report target so that it doesn't generate the
> coverage-untested-functions file by default. I'm adding more targets
> for doing various things with the gcov files, and they shouldn't all
> run by default.
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 63f3f84..5e9a6a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2299,6 +2299,8 @@ coverage-report:
>  	gcov -b -o builtin builtin/*.c
>  	gcov -b -o xdiff xdiff/*.c
>  	gcov -b -o compat compat/*.c
> +
> +coverage-report-untested-functions:
>  	grep '^function.*called 0 ' *.c.gcov \
>  		| sed -e 's/\([^:]*\)\.gcov: *function \([^ ]*\) called.*/\1: \2/'=
 \
>  		| tee coverage-untested-functions

This should depend on coverage-report, and either have its name
changed to coverage-untested-functions or be .PHONY.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
