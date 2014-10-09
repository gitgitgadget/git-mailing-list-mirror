From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH v3] completion: ignore =?utf-8?b?Y2hwd2RfZnVuY3Rpb25z?= when cding on zsh
Date: Thu, 9 Oct 2014 19:21:59 +0000 (UTC)
Message-ID: <loom.20141009T211723-95@post.gmane.org>
References: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com> <1412804988-56858-2-git-send-email-bt@brandonturner.net> <loom.20141009T093007-811@post.gmane.org> <xmqqlhop6rmj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 21:22:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcJI1-0001BX-4j
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 21:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbaJITWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Oct 2014 15:22:14 -0400
Received: from plane.gmane.org ([80.91.229.3]:37703 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751128AbaJITWM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 15:22:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XcJHt-00016C-8M
	for git@vger.kernel.org; Thu, 09 Oct 2014 21:22:09 +0200
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 21:22:09 +0200
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 21:22:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:32.0) Gecko/20100101 Firefox/32.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster <at> pobox.com> writes:

>=20
> =C3=98ystein Walle <oystwa <at> gmail.com> writes:
>=20
> > Brandon Turner <bt <at> brandonturner.net> writes:
> >
> >>=20
> >> Software, such as RVM (ruby version manager), may set chpwd functi=
ons
> >> that result in an endless loop when cding.  chpwd functions should=
 be
> >> ignored.
> >
> > Now that it has moved to the zsh-specific script you can achieve th=
is more
> > simply by using cd -q.
>=20
>=20
>=20
> Is the way we defeat CDPATH for POSIX shells sufficient, or does it
> also need to be customized for zsh?
>=20

That is fine (to the best of my knowledge). If the current directory is=
 not
part of CDPATH at all then Zsh will try the current directory first, so=
 if
anything Zsh should fail more seldom here than others (but not *never*,=
 so
the hack is still needed).

=C3=98sse
