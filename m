From: Nathaniel P Dawson <nathaniel.dawson@gmail.com>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Mon, 30 Mar 2009 10:33:19 -0700
Message-ID: <20090330173319.GC25950@eiku.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com> <49D0A3DF.4000203@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:39:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoLOR-00067Q-ON
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 19:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754040AbZC3RdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 13:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbZC3RdZ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 13:33:25 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:6298 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbZC3RdY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 13:33:24 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2687303wff.4
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=03YTSHN4lzYYBkTDTXeMvxLyegxpK4weglPNnspMCTs=;
        b=O6DFUhOg3T2ywCOYaaOs1vtB1Yt2V3h+z5GLba+wMt4UFRrt0ZKYQizrSFxaJ7CDAq
         nDorTMkxejmNnIR7G+ATl0KH2oUZEHkqCMf/E5zvYGpSXtgNTwPSAQtdkcmgTpOdQ01o
         16MO7FdfDt3oHUW99sk4UmraOqgiCPkExykzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hkNt5Ry7EzFedRnTR8I31kJuAwR020JLjGJwB5NETrRhQQ+tpxq7s6KNRvMuGgWyif
         dMc7tKBbN/OHyt7G5pzCdEXsoC8YzOjI6ov7YxwBbsYsOujjwkh6bUjeyZpVjUmceSH4
         jz8vi7NosQo9iZ0rvMks4Ia2MAQQJfXo1zx9k=
Received: by 10.140.157.4 with SMTP id f4mr2414833rve.3.1238434402508;
        Mon, 30 Mar 2009 10:33:22 -0700 (PDT)
Received: from localhost (ip68-98-113-49.ph.ph.cox.net [68.98.113.49])
        by mx.google.com with ESMTPS id f42sm14481786rvb.41.2009.03.30.10.33.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Mar 2009 10:33:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49D0A3DF.4000203@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115177>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm sorry, I must have misunderstood the task on the janitor
list. Could you explain it a bit better so I would be able to do it
properly?

And as for line wrapping I apologize, emacs on my laptop was
apparently not turning on auto-fill but has been rectified.

Regards,
Nathaniel P Dawson

On Mon, Mar 30, 2009 at 12:50:07PM +0200, Johannes Sixt wrote:
> Please wrap your lines at ca. 75 columns.
>=20
> Nathaniel P Dawson schrieb:
> > This is just the beginning for this project. I'm slowly cleaning up
> > the header includes one chunk at a time. I hope my patches aren't too
> > messy, I've learned how to better utilize git to make patches and
> > organize my commits logically so I'll submit neater chunks henceforth.
> > You can expect patches from me nightly until I've finished this project.
>=20
> You have removed includes that are implied by other includes, i.e. if
> foo.h includes bar.h, then you removed #include "bar.h" from *.c if there
> is #include "foo.h".
>=20
> IMO, this is not a good guiding principle to reduce includes. A better
> principle is to keep #include "bar.h" in a source or header file iff a
> feature that is declared or defined in bar.h is *used* *directly* in that
> source or header file, regardless of whether bar.h is included in foo.h
> that is itself included in that source or header file.
>=20
> If this latter principle is obeyed, then the build won't break by removing
> the include of foo.h (for the reason that nothing of foo.h is *use*
> *directly* anymore).
>=20
> -- Hannes
>=20

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEAREKAAYFAknRAl8ACgkQJPz5XkJJCtC9CwCfRmlnG9KNmIaIDNg0KXeigwux
bGAAn3NMAx0cPWwjaTiM/17XlAUTlrCo
=PuKP
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
