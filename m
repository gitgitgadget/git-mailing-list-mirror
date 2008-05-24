From: Dennis Schridde <devurandom@gmx.net>
Subject: Re: Multiple user questions
Date: Sat, 24 May 2008 11:13:54 +0200
Message-ID: <200805241113.57848.devurandom@gmx.net>
References: <200805231327.41216.devurandom@gmx.net> <m3zlqg32w9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1375752.3NDoTtG2TE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 11:15:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzpqY-0001qy-8P
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 11:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYEXJOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 05:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYEXJOH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 05:14:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:34949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752933AbYEXJOF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 05:14:05 -0400
Received: (qmail invoked by alias); 24 May 2008 09:14:02 -0000
Received: from hnvr-4dbb9929.pool.einsundeins.de (EHLO ernie.local) [77.187.153.41]
  by mail.gmx.net (mp003) with SMTP; 24 May 2008 11:14:02 +0200
X-Authenticated: #19202771
X-Provags-ID: V01U2FsdGVkX19HHIlIgQtHVB0yj6QwsLas1UZ1ddbNC0jJ7I55PX
	9NAqtRXiK0FqPe
User-Agent: KMail/1.9.9
In-Reply-To: <m3zlqg32w9.fsf@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82805>

--nextPart1375752.3NDoTtG2TE
Content-Type: multipart/mixed;
  boundary="Boundary-01=_Sx9NI6tj3eAqBhu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_Sx9NI6tj3eAqBhu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks for your answers!

Am Samstag, 24. Mai 2008 03:30:43 schrieb Jakub Narebski:
> Dennis Schridde <devurandom@gmx.net> writes:
> > 2) Can I make format-patch include the full commit message, date, autho=
r,
> > stats in the patches? (To mimic what git-show would show me.)
> > Will this be sent via send-email, too?
>
> Errr... git-format-patch output _does_ include full commit message,
> author, author date and diffstat.
=46or me only the first line of the commit message is printed in the subjec=
t,=20
all other lines are missing.
If I want a message to appear in the body at all, I need a special way to=20
format my commit messages: 1 line summary, 1 empty line, description.
Only the description is then shown in the email.
This seems inconvenient, especially for smaller changes.

=46urther, attachments do not at all contain any information like that.
See the attached example.

> > 4) Can I make format-patch output one deletion and one insertion for a
> > complete rewrite of a function, instead of multiple deletes/inserts?
>
> Try git-format-patch with -B option, or -B<num>.
I tried that already.
Whether I specified -B or not, it always gave the exact same output (says=20
diff).

The <num> parameter to -B is not mentioned or explained in the manpages.

5) fsck --full --lost-found shows me a lot of "dangling commit". I would li=
ke=20
to clean them up. prune did only remove "dangling tree" and blobs.
(Reason: Last time I droped a stash accidently, I was able to find it in th=
at=20
list. I will not be able to do this again if it continues to grow at that=20
rate.)
How can I do that?
=46urther fsck --full --unreachable also shows a lot of unreachable things=
=20
(commits, trees, blobs). Can that be cleaned up as well?

Greetings,
Dennis

Again: Please CC me, as I am not subscribed.

--Boundary-01=_Sx9NI6tj3eAqBhu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="5b7f87a087d7372b04fd81202191a3d8cb818bab.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="5b7f87a087d7372b04fd81202191a3d8cb818bab.diff"

diff --git a/src/projectile.c b/src/projectile.c
index 1389d4c..f9ae99a 100644
=2D-- a/src/projectile.c
+++ b/src/projectile.c
@@ -640,8 +640,8 @@ static void proj_InFlightDirectFunc( PROJECTILE *psProj=
 )
 	/* we want a delay between Las-Sats firing and actually hitting in multiP=
layer
 	magic number but that's how long the audio countdown message lasts! */
 	const unsigned int LAS_SAT_DELAY =3D 8;
=2D	unsigned int timeSoFar;
=2D	unsigned int distancePercent; /* How far we are 0..100 */
+	int timeSoFar;
+	int distancePercent; /* How far we are 0..100 */
 	float distanceRatio; /* How far we are, 1.0=3D=3Dat target */
 	float distanceExtensionFactor; /* Extended lifespan */
 	Vector3i move;
@@ -909,8 +909,8 @@ static void proj_InFlightIndirectFunc( PROJECTILE *psPr=
oj )
 		- Some optimisations by leaving out tests which are never true (homing, =
AA, counter-missile, lassat)
 	*/
=20
=2D	unsigned int timeSoFar;
=2D	unsigned int distancePercent; /* How far we are 0..100 */
+	int timeSoFar;
+	int distancePercent; /* How far we are 0..100 */
 	float distanceRatio; /* How far we are, 1.0=3D=3Dat target */
 	float distanceExtensionFactor; /* Extended lifespan */
 	Vector3i move;

--Boundary-01=_Sx9NI6tj3eAqBhu--

--nextPart1375752.3NDoTtG2TE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkg33FUACgkQjqfyF1DtJW74RACbBwL5Y8XKBnrz76TiwKi7Zvnv
FN0An2OEz+2vUJITO02YrzYiL6FYKd9l
=x21i
-----END PGP SIGNATURE-----

--nextPart1375752.3NDoTtG2TE--
