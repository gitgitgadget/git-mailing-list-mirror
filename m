From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 21 Jan 2013 13:54:23 -0500
Message-ID: <kdk2ss$498$1@ger.gmane.org>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com> <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil> <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil> <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com> <87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2UFLEIDWEFCRWVWBTFOBA"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 19:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxMWH-0000qA-3c
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 19:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab3AUSyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 13:54:35 -0500
Received: from plane.gmane.org ([80.91.229.3]:41724 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755Ab3AUSye (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 13:54:34 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TxMW9-0000kR-H4
	for git@vger.kernel.org; Mon, 21 Jan 2013 19:54:49 +0100
Received: from d67-193-232-12.home3.cgocable.net ([67.193.232.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 19:54:49 +0100
Received: from brian by d67-193-232-12.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2013 19:54:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: d67-193-232-12.home3.cgocable.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
X-Enigmail-Version: 1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214139>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2UFLEIDWEFCRWVWBTFOBA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-01-21 11:11 AM, Thomas Rast wrote:
>=20
> What's odd is that while I cannot reproduce the original problem, there=

> seems to be another issue/bug with utime():

I wonder if this is related to http://jira.whamcloud.com/browse/LU-305.
 That was reported as fixed in Lustre 2.0.0 and 2.1.0 but I thought I
saw it on 2.1.1 and added a comment to the above ticket about that.

> In the absence of it, wouldn't we in theory have to write a simple
> loop-on-EINTR wrapper for *all* syscalls?

IIUC, that's what SA_RESTART is all about.

> Of course there's the added problem that when open(O_CREAT|O_EXCL) fail=
s
> with EINTR, it's hard to tell whether a file that may now exist is
> indeed yours or some other process's.

Or whether it's in a "half created" state such as I hypothesize in
http://jira.whamcloud.com/browse/LU-2276.

b.



------enig2UFLEIDWEFCRWVWBTFOBA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD9jt8ACgkQl3EQlGLyuXClSACfYuyrxqb9W1W1Vhl93xo/EvQr
J8QAnjlI/fYD8PQoATNITvuQIRLSgeGC
=DYdv
-----END PGP SIGNATURE-----

------enig2UFLEIDWEFCRWVWBTFOBA--
