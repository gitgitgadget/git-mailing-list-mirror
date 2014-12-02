From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 2 Dec 2014 18:12:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412021804210.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <xmqq389qam25.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info> <xmqqh9y32e36.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
 <xmqq4mu2285w.fsf@gitster.dls.corp.google.com> <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com> <xmqq1tp643yb.fsf@gitster.dls.corp.google.com> <xmqqa936ohs3.fsf@gitster.dls.corp.google.com> <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info> <xmqqtx1em2fu.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412021744490.13845@s15462909.onlinehome-server.info> <xmqqppc2m1fz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-866838004-1417540372=:13845"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:13:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvr0h-0000U5-PE
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbaLBRNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:13:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:64475 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbaLBRNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:13:04 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MS5QA-1XTi3C04YU-00TEG8;
 Tue, 02 Dec 2014 18:12:52 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqppc2m1fz.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:PsOPHB+WAWuzqimGxzFeUQHgs4x+IqIuHIHhcDHGh1MNSyna80w
 PLmK32Jngbg2ufnWsaAZcsgxYZIvOpwvEAGSxScoqavJf5fgZkf7CD2qHGS6klb0A+Zz7xa
 s6QNHVXk/Ez+Sto9wGUZ6/BnGCvGj0lgTqsI/Kqbt3HNWaMNwhPj/Z8Xrz3hTYvEJ5+ByH3
 1jgY6QVNMOEHRyEX421sg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260578>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-866838004-1417540372=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Tue, 2 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> >> Not really.  You need to remember that we write tests not to show
> >> off the new shiny, but to protect essential invariants from being
> >> broken by careless others attempting to rewrite the implementation
> >> in the future.
> >
> > Fair enough. You are the boss.
> >
> > I am not, therefore it does not matter what I think,
>=20
> It is not that it does not matter because you are not the boss; it
> is just that when you are wrong, you are wrong.

Please, there is no need to get emotional, let alone personal.

I am not really interested in challenging your policy regarding the test
suite, even if it does hurt my development style where I want to run the
test suite frequently but its tests just take too long because their focus
is more on thoroughness rather than trying to save time in the manner I
suggested (i.e. by only lightly testing obscure code paths that will be
executed rarely, risking bugs in favor of adding tests when fixing said
bugs when =E2=80=93 and if =E2=80=93 they arise). There is nothing inherent=
ly wrong in the
way you want to have the test suite, it is a matter of preference, that is
all. I would like a more light-weight test suite that runs much faster,
you want a thorough one, even if it takes more time to run.

So: you are the boss, you do the things you do, and my opinion does not
matter. I say this most pragmatically, to save more time by ending this
discussion now. There are no hard feelings on my side.

Ciao,
Johannes
--1784107012-866838004-1417540372=:13845--
