From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Tue, 28 Jun 2011 23:59:31 +0200
Message-ID: <20110628215931.GA3974@paksenarrion.iveqy.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
 <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
 <7v1uydvmh0.fsf@alter.siamese.dyndns.org>
 <20110628193034.GB3700@book.hvoigt.net>
 <7viprpu1p5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 23:45:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbg5q-0006dN-UP
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 23:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296Ab1F1VpJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 17:45:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56349 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab1F1VpH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 17:45:07 -0400
Received: by bwd5 with SMTP id 5so533611bwd.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 14:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oGP0Uady+8VFit5CECWbOy/Tu6LXF5GmWNlL9UXwTDI=;
        b=a7P+TJ0F8RaD9Wof97UJxzXbXPy9rXQQtgQpCCTHdflYuhhWbsz3o+L+onVYfB/svy
         P85et6yyK1KuBobrVOvPlORfcarFaK+5xMuM5o/jrALDQ+teofL3T4aNbtJ2pWE2Fr8M
         ocZCv2SHq+S10mZ9lDdwVezVWGCV44F7CT000=
Received: by 10.204.14.147 with SMTP id g19mr61450bka.11.1309297506037;
        Tue, 28 Jun 2011 14:45:06 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id af13sm558999bkc.7.2011.06.28.14.45.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Jun 2011 14:45:05 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1QbgJf-00013T-VJ; Tue, 28 Jun 2011 23:59:32 +0200
Content-Disposition: inline
In-Reply-To: <7viprpu1p5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176420>

On Tue, Jun 28, 2011 at 01:43:18PM -0700, Junio C Hamano wrote:
> > This check is solely meant as a convenience security measure. It sh=
ould
> > and can not enforce a tight check whether a superproject (including=
 its
> > submodules) can be cloned/checked out at all times. But it ensures =
that
> > a developer has pushed his submodule commits "somewhere" which is e=
nough
> > in practice.
>=20
> I am not entirely convinced but if this would catch more than 80% of
> casual mistakes, it would be good enough.  I was hoping that somebody=
 may
> come up with an idea that would work even in case (3), though.
>=20

There's ways to do a "better" check, but only(*) if the client communic=
ates
with the server. This is expensive and doesn't make any sense to do for
the error we're trying to prevent here, forgetful developers that
forgotten to push a submodule.

A design goal for this check has been to make it just a client side
check.

I do not have a % value of how usual this fault is. I do know that
developers being introduced to submodules that I know of tends to
forget this (and so do I occasionally).

* According to what I found out. If there's a better solution I would o=
f
  course be very happy.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
