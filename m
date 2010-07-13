From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Question about 'branch -d' safety
Date: Wed, 14 Jul 2010 00:21:05 +0200
Message-ID: <20100713222105.GA9293@localhost>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
 <20100711133730.GA10338@localhost>
 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org>
 <20100712184754.GA18429@localhost>
 <7v39vo8dkn.fsf@alter.siamese.dyndns.org>
 <20100713071317.GA26348@localhost>
 <1279008023.2030.11.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYnqo-0002UL-7D
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791Ab0GMWVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 18:21:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48395 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab0GMWVM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 18:21:12 -0400
Received: by bwz1 with SMTP id 1so571175bwz.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=hSLvEF+fcHdMy0GJUMDzfBnx0+SeUldEcB5V/OcdJXQ=;
        b=dQ5TTMn/fou/aoY495P0eTRWDTJtprgolWu4JP+Fjpes+wJLLAa/E493k7kVXZKxvj
         nwi/CSvoMSgPB+BiqqeeB7Ru+9ryDzQXoy/X0G5fRmRJBnFzKIdu+01TwPOPFV+ZbPCO
         jQ/TLlCWX/v8WCmUs3xP9y6omPhUmsa+9VJ5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=UNU5swV5hcDLGvJwQ5twtZN+oWP0V/u4cF4ovq06zgdjnZRa+6ilnM9XVbW16ph1MK
         EbVwyMeJTIm6nro3IfJ3plEXvIGVPEYDkfuEzr44UrFMkklKx+j74AxTHvLBFMiV/wnY
         7kyuUURYN0O1RtG8QITW/i4ytr0BCkFQSId1k=
Received: by 10.204.53.140 with SMTP id m12mr1056886bkg.195.1279059670388;
        Tue, 13 Jul 2010 15:21:10 -0700 (PDT)
Received: from darc.lan (p549A484C.dip.t-dialin.net [84.154.72.76])
        by mx.google.com with ESMTPS id a11sm23339927bkc.0.2010.07.13.15.21.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 15:21:08 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OYnqb-0002Sy-AJ; Wed, 14 Jul 2010 00:21:05 +0200
Content-Disposition: inline
In-Reply-To: <1279008023.2030.11.camel@wpalmer.simply-domain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150932>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 13, 2010 at 09:00:23AM +0100, Will Palmer wrote:
>=20
> With that in mind, would it not be enough to simply remove the ref, but
> not the reflog, and change the logic to let the reflog live on until
> either pruned or all of its entries have expired normally?

That's the idea. The only reason why this patch renames the reflog
after deletion is due to the current directory style layout of refs
and reflogs. In particular, it is not possible to have refs foo/bar
and foo at the same time, since that would be a directory/file
conflict.

I therefore rename reflogs of deleted refs to foo~/bar, for
example, which for all intents and purposes is still the reflog of
foo/bar, only now it's not in the way of creating a new ref foo.
The fact that we rename the ref internally should be transparent to
the user.

Clemens

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMPObNAAoJELKdZexG8uqMm/4H/04K2HUoo7Rof6QP0e9piuDU
3Y0alNohSOT7S0FZlEbT6tssyVpNWuRg6AVMngf95Igsq0XhDdvfGr7rdtCXLY3m
/VfuGId3e758e0JGvVfAYxcUL6xmrz3UpnQ8+/xxLYsrMjWbFtIjN/yHtOS1oYGO
jnLy8PDmGpXufCJzlPMDu77+LUbTjVNWR64fb/JE8u6CqymS5EdfTwtgkgbdiu05
TmC4vtDQECXA/fp4SJR2XhvmXNPkD/Zz62x9qMaxz9/JlkhITQDgwbR/MSf7H4HV
u/QyVy/Ge1uUO6Zvjookzy7Lu/Q5FnO17sbDCi1RZGSTfmGO5iIJEYrZHWjzEUk=
=zwwh
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
