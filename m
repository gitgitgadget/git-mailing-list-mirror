From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: Forcing --no-ff on pull
Date: Tue, 09 Dec 2008 02:12:45 -0800
Organization: Slide, Inc.
Message-ID: <1228817565.18611.54.camel@starfruit.local>
References: <1228815240.18611.48.camel@starfruit.local>
	 <8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ULjVqK0PnJdo+QoREHeP"
Cc: git@vger.kernel.org
To: Lars Hjemli <lh@elementstorage.no>
X-From: git-owner@vger.kernel.org Tue Dec 09 11:14:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9zbS-00019f-Cx
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 11:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbYLIKMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 05:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYLIKMs
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 05:12:48 -0500
Received: from mx0.slide.com ([208.76.68.7]:48202 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbYLIKMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 05:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=j
	wsMYCgVwxew4cseTMwJ8KzW/AXiPHYkcbnC5kcQECc=; b=LLhvyPWgnC7nLvU4m
	GaeOD1ryPmKPtoPj2t+Bu8XfBEXw/EFnXmxvx9FDrENxIR8pzfLsJD3eo2+2vmZZ
	iKfILp3FFGS8VjXMOHHiFy1ty4k96q1+xRtah8/UamlCuHN85HWZDV1hGhIbXOV4
	9AAt5+jDlXTMhC23q4lSDq03To=
Received: from nat3.slide.com ([208.76.69.126]:59329 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1L9zaB-0004yq-2k; Tue, 09 Dec 2008 02:12:47 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 0ABA2A6F0002;
	Tue,  9 Dec 2008 02:12:47 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.41 tagged_above=-10 required=6.6 tests=[AWL=0.089,
	BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WMkwvZzJIW3W; Tue,  9 Dec 2008 02:12:46 -0800 (PST)
Received: from [10.12.0.194] (unknown [10.12.0.194])
	by calculon.corp.slide.com (Postfix) with ESMTP id BADCEA6F0001;
	Tue,  9 Dec 2008 02:12:46 -0800 (PST)
In-Reply-To: <8c5c35580812090149lc6dd79cj60a9d23c18089557@mail.gmail.com>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102620>


--=-ULjVqK0PnJdo+QoREHeP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-12-09 at 10:49 +0100, Lars Hjemli wrote:
> On Tue, Dec 9, 2008 at 10:34, R. Tyler Ballance <tyler@slide.com> wrote:
> > Is there a header macro I can define or a config option I could define
> > to make --no-ff on `git pull` implicit instead of explicit?
>=20
> Try this:
> $ git config branch.stable.mergeoptions "--no-ff"

I recall stumbling across this a while ago looking at the git-config(1)
man page, but this isn't /quite/ what we need.

I'm talking about forcing for *every* pull, it's a safe assumption to
make that we want a merge commit every time somebody fast-forwards a
branch.=20

The only way I could think to make use of branch.<name>.mergeoptions
would be to automagically set it up in a "pre-merge" hook, but alas
post-merge exists but not pre-merge.

I could certainly patch to support a pre-merge, but that seems like the
longest possible route to my desired destination ;)


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-ULjVqK0PnJdo+QoREHeP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkk+RJ0ACgkQFCbH3D9R4W8JmgCbBRn8aC3+KCQ50ov64L7sqiGX
ZTsAn0h2+7LM8cVjg1lxWMLExYC0+LvH
=FXfQ
-----END PGP SIGNATURE-----

--=-ULjVqK0PnJdo+QoREHeP--
