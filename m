From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Local clones aka forks disk size optimization
Date: Sun, 18 Nov 2012 18:02:37 +0100 (CET)
Message-ID: <27f681a7-f87d-47b4-a512-93511b44b286@zcs>
References: <CAMK1S_hCk3QdDn8XnXVisL1i2V0iPCZBYN989JmZ3JYr7ckRrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Javier Domingo <javierdo1@gmail.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 18:03:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta8H1-0004EV-Fi
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 18:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab2KRRCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2012 12:02:40 -0500
Received: from zcs.vnc.biz ([83.144.240.118]:14461 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab2KRRCj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2012 12:02:39 -0500
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 6B2256228C0;
	Sun, 18 Nov 2012 18:02:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xDWcY2L4lde3; Sun, 18 Nov 2012 18:02:38 +0100 (CET)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 0106E62203A;
	Sun, 18 Nov 2012 18:02:37 +0100 (CET)
In-Reply-To: <CAMK1S_hCk3QdDn8XnXVisL1i2V0iPCZBYN989JmZ3JYr7ckRrA@mail.gmail.com>
X-Originating-IP: [91.43.183.14]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210034>

Hi,

> That's not the only problem.  I believe you only get the savings when
> the main repo gets the commits first.  Which is probably ok most of
> the time but it's worth mentioning.

Well, the saving will just be deferred to the point where the commit
finally went to the main repo and downstreams are gc'ed.

> > hmm, distributed GC is a tricky problem.
>=20
> Except for one little issue (see other thread, subject line "cloning
> a
> namespace downloads all the objects"), namespaces appear to do
> everything we want in terms of the typical use cases for alternates,
> and/or 'git clone -l', at least on the server side.

hmm, not sure about the actual internals, but that namespace filtering
should work in a way that local clone should never see (or consider)
remote refs that are outside of the requested namespace. Perhaps that
should be handled entirely on server side, so all called commands treat
these refs as nonexisting.

By the way: what happens if one tries to clone from an broken repo
(which has several refs pointing to nonexisting objects ?


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
