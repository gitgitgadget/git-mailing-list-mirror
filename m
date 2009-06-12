From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Thu, 11 Jun 2009 23:18:53 -0400
Message-ID: <20090612031853.GC5076@inocybe.localdomain>
References: <4A319CE1.6040201@garzik.org>
 <20090612011737.GB5076@inocybe.localdomain>
 <7v7hzidvcj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 05:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MExIL-0008Uj-5W
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 05:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757762AbZFLDTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 23:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZFLDS7
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 23:18:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbZFLDS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 23:18:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 47250BAF69;
	Thu, 11 Jun 2009 23:18:58 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4C8F2BAF68; Thu,
 11 Jun 2009 23:18:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7hzidvcj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: C4976102-56FF-11DE-B30E-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121385>


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
>
>> It is notable that Fedora 11 is the first Fedora release that
>> follows the git 1.6.x defaults and installs most git binaries
>> outside of PATH.  I don't think that would cause this, and I
>> haven't had any troubles running these packages for many months,
>> but that's never stopped really obvious bugs in the past...
>
> I do not follow distro packaged versions of git, but it may help to
> double check your spec changes against the output of
>
>     $ git log -p v1.5.6..v1.6.2.2 -- git.spec.in
>
> to see which paths need to be updated.

AFAIK, we're installing things in the correct locations.  git-pull is
located with the rest of the git commands in /usr/libexec/git-core
(which is what 'git --exec-path' shows).

The Fedora 10 packages (unfortunately, IMO) set gitexecdir=3D%{_bindir},
but that was rectified as soon as the Fedora 11 cycle started and we
tried to track each upstream git release closely until things were
frozen to make the release.  I know there are a good number of fedora
developers and packagers who use git, so I would really expect that
we'd have seen pitchfork wielding mobs if we broke the packaging
badly. ;)

> Of course, you might not be using a specfile remotely similar to
> what we have in-tree (I believe it was originally done by Chris
> Wright who is listed as one of the persons who have something to do
> with Fedora packaged versions of git in your maintainers list), so
> this may not be a helpful tip at all, in which case I apologize...

Your help and insight is always welcome Junio. :)

Chris has been busy with other things for a while.  I started helping
with git package maintenance only in the last 6 months or so.  Over
time, the spec file we have has drifted a bit from what is in git.git,
though not terribly so.  I need to spend some time and look at what,
if any, changes in the Fedora spec file would be good candidates for
submitting to git.git.  I have been primarily concerned with making
things work cleanly on Fedora and RHEL/CentOS though, so some of the
changes may not be as generic as they ought to be if they are to be
included in git.git.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Rowe's Rule: The odds are five to six that the light at the end of the
tunnel is the headlight of an oncoming train.
    -- Paul Dickson


--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKMckWJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjj4MIAIv89wjSoUifvThuqWUma7AoyGJQgxMooDed
AkEkiPKYHZMMLbeJA9Q71k5X8OzsnW4Dy8MprC0SXUi+JWmmXFrJ+nXRvmctNGFV
zwxl8uTuOKbktrrLCERSd5Ct0B8H+nOaU08TZEpVEtFE7W4sJqai2SwQwQe7c/RK
e2AokFjAmKYR5L2KSUUqt1fSXyeUhaJPUaeH3BPdHboU9bAaclgltkuNQ9Gnrvt2
Q3RyUAu7PJdo0ZbUiJI7d7i9DR67BRf9kZF9OPiGxbqIF8srrIb+YqFAgYBi5fSc
B8x3otfUAr5mV2m0zzJmIbbpJaa3pq4rO9JyJzzqk6V81eBbYks=
=opnJ
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
