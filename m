From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t9001: use older Getopt::Long boolean prefix '--no'
 rather than '--no-'
Date: Fri, 30 Jan 2015 23:05:16 +0000
Message-ID: <20150130230516.GA7867@vauxhall.crustytoothpaste.net>
References: <54CA3611.1000804@statsbiblioteket.dk>
 <1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: git@vger.kernel.org
To: "Tom G. Christensen" <tgc@statsbiblioteket.dk>
X-From: git-owner@vger.kernel.org Sat Jan 31 00:05:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHKcx-0005Ks-R6
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 00:05:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201AbbA3XFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 18:05:23 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47437 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753675AbbA3XFW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2015 18:05:22 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EC5CF2808F;
	Fri, 30 Jan 2015 23:05:20 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1422599085-11804-1-git-send-email-tgc@statsbiblioteket.dk>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263202>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2015 at 07:24:45AM +0100, Tom G. Christensen wrote:
>The '--no-xmailer' option is a Getopt::Long boolean option. The
>'--no-' prefix (as in --no-xmailer) for boolean options is not
>supported in Getopt::Long version 2.32 which was released with Perl 5.8.0.
>This version only supports '--no' as in '--noxmailer'.  More recent
>versions of Getopt::Long, such as version 2.34, support either prefix. So
>use the older form in the tests.
>
>See also:
>
>d2559f734bba7fe5257720356a92f3b7a5b0d37c
>907a0b1e04ea31cb368e9422df93d8ebb0187914
>84eeb687de7a6c7c42af3fb51b176e0f412a979e
>3fee1fe87144360a1913eab86af9ad136c810076
>
>Signed-off-by: Tom G. Christensen <tgc@statsbiblioteket.dk>
>---
> t/t9001-send-email.sh | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
>index af6a3e8..30df6ae 100755
>--- a/t/t9001-send-email.sh
>+++ b/t/t9001-send-email.sh
>@@ -1580,20 +1580,20 @@ do_xmailer_test () {
>
> test_expect_success $PREREQ '--[no-]xmailer without any configuration' '
> 	do_xmailer_test 1 "--xmailer" &&
>-	do_xmailer_test 0 "--no-xmailer"
>+	do_xmailer_test 0 "--noxmailer"

I don't think this is an adequate fix.  The documented option is=20
--no-xmailer.  If your version of Getopt::Long is not capable of that,=20
then the program doesn't work as documented, and the test is correctly=20
failing.  --noxmailer is not documented at all, so it's not something we=20
should be testing.

We should probably require a certain version of Getopt::Long or=20
explicitly handle this in the parsing code itself.  I think the former=20
is a better choice, since no security-supported OS still ships with such=20
a positively ancient version.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUzA4sAAoJEL9TXYEfUvaLCIMQAJJmvKVaunL3GGO9EOjAmsWE
AJGphxwenWBJ9XpOSI0/dpMc3heHjsBzN+E2yGE+2mdfil8HsDsGBzuOB0iRBPmb
teBMHiyAovNxC0tAHEpju8oEqVbZt91ibTAQGUsAEeQfQs19bvHvoM3nIppJOJuo
S/FK7c492fB8rIKHnubNtyjXtRD4CZ9SPpUhG/bqU20iZ0Qm1EXvYT/HZULig2mW
bqL2PZMaiHjmr7P3gIJ7Fpbah/+NqiXs1oIXwDhtxMz0oNDyXRl45qqPiH+ESwPr
zUJlyTHSX2dC2IMCts9onBLuJdnWQrp4CaQn9vu6LRhhkI1djhdRp+dag2GyI+cD
FEh9HElhdaK8/geXdXd8JMr85oBdaSEfUQW9M2DlO4DOk/hdaafcMHiqg9suRMqB
yahru2Tg7dX/E1nFnrtY3+hyXJ+66qgAo6FKbSKkomnjv2MizLEcGctyIRo2AheN
wTfwzfy2HmjJyCIyZGfbt0lL1ySuO1HZRNmsen1sAtp66lrHV/3nLlzCsiMLuIdX
mW2vaaCH8xayS56N8l0Grau6Tsp0O5lDlnHVw0Ua8awgl+sJwWD9En09shA4DSiY
986CE+VYoe7Wuzww8a6SRjpr0Vvc63F9XOAAJHBewH8mURjESO5UkI5NqYagpeBZ
pC2emWLKyQhMeTWnPH5X
=jSs1
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
