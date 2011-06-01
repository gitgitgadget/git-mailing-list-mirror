From: Tim Guirgies <lt.infiltrator@gmail.com>
Subject: Re: gitosis asking for password
Date: Wed, 1 Jun 2011 12:23:16 +1000
Message-ID: <20110601022313.GA3025@Imperial-SD-Longsword>
References: <20110531154954.GB4483@Imperial-SSD-Overlord>
 <vpqy61mrha6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 04:23:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRb5m-0004eN-H8
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 04:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758569Ab1FACXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 22:23:25 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51140 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758557Ab1FACXY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 22:23:24 -0400
Received: by gwaa18 with SMTP id a18so2038085gwa.19
        for <git@vger.kernel.org>; Tue, 31 May 2011 19:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YhndLrgtJGhFUvPE41KwP3pj9bqZFnuo+rlEYX8JhAM=;
        b=K5NuU4o2PZYIs7OFj07t7n4z3wbaDddtWNIOBE1OfwhDLrds06uJuJ/mfabZpzDToA
         F3tkteV2tlTH0XT7+XLgjVD1P18/CHHXcEXqRFeV67ZB0p6wvJ6WynqKwdGn3FzIzDa9
         f73x2HYfftnxk0UDAarkYLOCeHiKevjqorz9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZVVHB0SOxqmJ7sCEJ/Ayc/dN4nBtdDVwKG3yeql+CsSSjoeMQ5Z8iK1Q24XRn4IpHV
         OWePbj2oXj8zGqlG0iaT/FTtFpSN6cJO0k5obnv9qHaabD+ArWpMky9yV6vq/AyQ5io6
         ek/HM7I38DUHPT3CG+gHsejGs/Q/nA34bK5Jg=
Received: by 10.236.180.101 with SMTP id i65mr8375782yhm.493.1306895003542;
        Tue, 31 May 2011 19:23:23 -0700 (PDT)
Received: from longsword.imperial.fleet ([58.171.231.203])
        by mx.google.com with ESMTPS id i61sm716190yhe.75.2011.05.31.19.23.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 May 2011 19:23:23 -0700 (PDT)
Received: from tim by longsword.imperial.fleet with local (Exim 4.76)
	(envelope-from <tim@imperial-sd-longsword>)
	id 1QRb5Y-0000qj-Cj; Wed, 01 Jun 2011 12:23:16 +1000
Content-Disposition: inline
In-Reply-To: <vpqy61mrha6.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174846>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 31, 2011 at 06:01:05PM +0200, Matthieu Moy wrote:
> Gitosis is no longer maintained. You should probably be trying gitolite
> instead.

Ah; well, I guess now's as good a time as any to migrate to gitolite
then.  I set up gitosis a few years ago and it hadn't been giving me any
problems.


> If it asks for password, then it's probably a plain SSH problem. Try
> reproducing it with e.g.
=2E..
> ssh -vvv gitosis@overlord.imperial.fleet

I did this just to see, and this is quite interesting:

debug3: Not a RSA1 key file /home/tim/.ssh/id_rsa.
debug2: key_type_from_name: unknown key type '-----BEGIN'
debug3: key_read: missing keytype
debug2: key_type_from_name: unknown key type 'Proc-Type:'
debug3: key_read: missing keytype
debug2: key_type_from_name: unknown key type 'DEK-Info:'
debug3: key_read: missing keytype
debug3: key_read: missing whitespace   (x~20)
debug2: key_type_from_name: unknown key type '-----END'
debug3: key_read: missing keytype
debug1: identity file /home/tim/.ssh/id_rsa type 1
=2E..
debug2: key: /home/tim/.ssh/id_rsa (0x7f7c8f0f7020)
debug2: key: /home/tim/.ssh/id_dsa ((nil))
debug1: Authentications that can continue: publickey,password
debug3: start over, passed a different list publickey,password
debug3: preferred
gssapi-keyex,gssapi-with-mic,publickey,keyboard-interactive,password
debug3: authmethod_lookup publickey
debug3: remaining preferred: keyboard-interactive,password
debug3: authmethod_is_enabled publickey
debug1: Next authentication method: publickey
debug1: Offering public key: /home/tim/.ssh/id_rsa
debug3: send_pubkey_test
debug2: we sent a publickey packet, wait for reply
debug1: Authentications that can continue: publickey,password
debug1: Trying private key: /home/tim/.ssh/id_dsa
debug3: no such identity: /home/tim/.ssh/id_dsa
debug2: we did not send a packet, disable method
=2E..

That is very odd, as I didn't change anything after ssh-keygen and
gitosis-init.  I suppose it's irrelevant anyway, as I'll be switching to
gitolite.

Thanks for the advice, and sorry about the noise.


Tim

--=20
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org   - against proprietary attachments

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCgAGBQJN5aKQAAoJEGNoa2q+dzQWF6wP/2GAeyGKSBtrfS0/pRqvJroI
LxJnF5sq0xkOa/8/uMrnljmAmbIwP0BeDfTfPMIW4Oh/D2bGGL3EkpOEt1Df9Q0O
7rEuhGn59BueMyqogls8RG0NPmKuI3VXd5g0Vg5Diqzw/wR0SPBiinD1cyQy6Kfs
6GhprnIOLo9ifGv8/rHdFOdQoCeXqP4bUgP5OvInUa4Y3/IjNtwwzuBzB5xKX3xj
c2FdUtwxcAt5FUdbG+ldReKAhfHwF46eMRo/ieK6SqEWJ9VAPU8BNDdc+TZjXctv
0WLeIDbPX+eCo073ULWt8QPyK81cEAljWAXKyJcGQ+H/uLwser1pH52YWAgQfw7j
bKFnhHH6an73B2ylj0zRgsQUzp8K01fHq2p51y97/s6XtoAaO1jn7W8obaTi7p8m
iW3CE1049H1T5xrcMSklVSKp+68cbDjdFl8nUzsEi7aTibkuVgdHVw3KRbBzWkOy
+3TtS8VYY1tAp0BVfNfWLff8DiW3p2GKtKQl97IQnZZ/JENP8KN1YHqulhHWAn3b
BJVEBU8ogNdhZU3iQct8lPOtKmjoVYkYLEQ8EotxPifPIJd4dmhrnlC2WgsQfTnu
uPjCLM1Pls+BjvIEewdCf/DLctlK1DYzruAru5HsGYiWPrSof334QKzkGkEs3niX
XQaBC80tfEOoZBPnZVfF
=1iDc
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
