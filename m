From: =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>
Subject: Re: slow git-cherry-pick.
Date: Sun, 24 Nov 2013 20:17:25 +0100
Message-ID: <32998962.pucYdvRloz@localhost.localdomain>
References: <2142926.gg3W3MsbJZ@localhost.localdomain> <CACsJy8CAAov1nSGPx79U+md4xROsCydidHPcipOb_sdFwNdSkA@mail.gmail.com>
Reply-To: pawel.sikora@agmk.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 24 20:18:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkfBv-0005I1-G3
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 20:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab3KXTRk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 14:17:40 -0500
Received: from adamg.eu ([91.192.224.99]:33364 "EHLO adamg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752122Ab3KXTRj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Nov 2013 14:17:39 -0500
Received: from mail.agmk.net ([91.192.224.71]:47190)
	by adamg.eu with esmtp (Exim 4.82)
	(envelope-from <pluto@agmk.net>)
	id 1VkfBZ-0000FE-Ep; Sun, 24 Nov 2013 20:17:37 +0100
Received: from localhost.localdomain (unknown [185.28.248.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pluto@agmk.net)
	by mail.agmk.net (Postfix) with ESMTPSA id 1BC6A1EE3CBA;
	Sun, 24 Nov 2013 20:17:27 +0100 (CET)
User-Agent: KMail/4.11.3 (Linux/3.11.8-300.fc20.x86_64; KDE/4.11.3; x86_64; ; )
In-Reply-To: <CACsJy8CAAov1nSGPx79U+md4xROsCydidHPcipOb_sdFwNdSkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238266>

On Sunday 24 of November 2013 19:47:10 Duy Nguyen wrote:
> On Sun, Nov 24, 2013 at 5:45 PM, Pawe=C5=82 Sikora <pawel.sikora@agmk=
=2Enet> wrote:
> > i've recently reinstalled a fresh system (fc20-beta) on my workstat=
ion
> > and observing a big slowdown on git cherry-pick operation (git-1.8.=
4.2-1).
> > the previous centos installation with an old git version works fast=
er
> > (few seconds per cherry pick). now the same operation takes >1 min.
>=20
> What is the git version before the reinstallation?

git-1.7.11.3-1.el5.rf.

i've checked this version on another machine with centos-5.$latest
and it does similar amout of stat/read operation quickly (~6s).
this "fast" centos-5 machine has /home on raid-0 (2x500GB) while
my "slow (>1min)" workstation has /home on linear lvm (250G+1T).

so, i suppose that my "slow" working copy crosses disks boundary
or spread over 1TB drive and the random git i/o impacts performance.

the question still remains - does the git need to scan whole checkout
during picking well defined set of files?

> Do you cherry-pick on one commit or a commit range?

single commit.

--=20
gpg key fingerprint =3D 60B4 9886 AD53 EB3E 88BB  1EB5 C52E D01B 683B 9=
411
