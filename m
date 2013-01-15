From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] test-lib.sh: unfilter GIT_PERF_*
Date: Tue, 15 Jan 2013 14:43:11 +0100
Message-ID: <87ehhmr28g.fsf@pctrast.inf.ethz.ch>
References: <1358254409-15187-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 14:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv6np-0004k0-Jk
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 14:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558Ab3AONnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 08:43:18 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:35564 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756064Ab3AONnP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 08:43:15 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 15 Jan
 2013 14:43:07 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (46.126.8.85) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 15 Jan
 2013 14:43:11 +0100
In-Reply-To: <1358254409-15187-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 15
 Jan 2013 19:53:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213635>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> These variables are user parameters to control how to run the perf
> tests. Allow users to do so.
[...]
> @@ -86,6 +86,9 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" =
-e '
>  		PROVE
>  		VALGRIND
>  		PERF_AGGREGATING_LATER
> +		PERF_LARGE_REPO
> +		PERF_REPEAT_COUNT
> +		PERF_REPO
>  	));

Wouldn't it be more futureproof to put simply PERF as an entry, and rel=
y
on the leading-match logic

> 	my @vars =3D grep(/^GIT_/ && !/^GIT_($ok)/o, @env);

to allow all GIT_PERF variables?

Other than that, Ack.  I never noticed because I set mine through
config.mak, which goes to GIT-BUILD-OPTIONS.  Those options are not
exported, which means perl does not pick them up.  (That just took me
far too long to realize.)

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
