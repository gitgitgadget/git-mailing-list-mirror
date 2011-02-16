From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 11:08:22 +0100
Message-ID: <201102161108.26637.jnareb@gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:08:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpeJS-0002NM-AW
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab1BPKIm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 05:08:42 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51691 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1BPKIk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:08:40 -0500
Received: by gyb11 with SMTP id 11so515199gyb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JBAFdJFPyZIj0BFJvmLGkQY7Y3+HoSTarFKTBM2cLZM=;
        b=a5jG16oSgwa8zfYvYec2BlDPUFGvhBktIBxLR746pSFSMYFp7o+47mSzpm+U45x3Gd
         XUO55FGsEai2n/9lf6JAson+OZ0lXR0wxtg0Ewi55umUO/Ci44IszDd76fSrOca2WXra
         hdVbneQsUNrmqW3lSvygkPH8Jpi0Zh6H4QGzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fNrrLBd0J9EllufHyWSPFWKf/kleHovWsmTJtCfr14SledZExGCVXRa2X9LRGUBYox
         hTXe5Bn9VoOCl3cdp6NydBR2/gw6HYYJv4lpwxmpWLVgjSGIxaJ/pB/5TKxu+oYZRjgg
         7pp69XDUiPkArO6muE/392tUHki4skcVPLO6Y=
Received: by 10.236.109.14 with SMTP id r14mr581919yhg.80.1297850919331;
        Wed, 16 Feb 2011 02:08:39 -0800 (PST)
Received: from [192.168.1.13] (abvl215.neoplus.adsl.tpnet.pl [83.8.209.215])
        by mx.google.com with ESMTPS id 1sm3026706yhl.11.2011.02.16.02.08.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Feb 2011 02:08:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.2.00.1102160421300.14950@debian>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166944>

Dnia =B6roda 16. lutego 2011 10:42, Martin von Zweigbergk napisa=B3:
> On Wed, 16 Feb 2011, Matthieu Moy wrote:
>=20
> > Johan Herland <johan@herland.net> writes:
> >=20
> > > In order to make this more understandable to the user, we rename =
the
> > > push.default =3D=3D 'tracking' option to push.default =3D=3D 'ups=
tream'.
> >=20
> > While we're there, shouldn't we also rename 'branch.<remote>.merge'=
 to
> > 'branch.<remote>.upstream'?
>=20
> I have a draft proposal not exactly to rename it, but to replace it b=
y
> a new branch.<name>.upstream which would point to local ref rather
> than a ref on the remote, so one would have e.g.
> branch.topic.upstream =3D refs/remotes/origin/master. Maybe I should
> clean up that proposal and send it soon. The topic comes up quite
> frequently.

Actually while I think that it makes more sense to use local ref for
'branch.<name>.merge' because it is what is merged, i.e.:

  branch.topic.merge =3D refs/remotes/origin/master

or in case of tracking local branch

  branch.topic.remote =3D .
  branch.topic.merge  =3D refs/heads/master

I think that for 'branch.<name>.upstream' it would make more sense to
use the name that *upstream* uses, i.e.

  branch.topic.upstream =3D refs/heads/master

--=20
Jakub Narebski
Poland
