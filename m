From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: RE: moving a remote branch?
Date: Thu, 17 Jun 2010 10:28:46 +0200
Message-ID: <A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
References: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
 <AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Nazri Ramliy <ayiehere@gmail.com>,
	Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 10:29:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPATA-0003P9-7E
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 10:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757155Ab0FQI25 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 04:28:57 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:37971 "EHLO
	krynn.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755713Ab0FQI24 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 04:28:56 -0400
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by krynn.se.axis.com (8.14.3/8.14.3/Debian-5) with ESMTP id o5H8SmpZ007212;
	Thu, 17 Jun 2010 10:28:48 +0200
Received: from xmail3.se.axis.com ([10.0.5.75]) by xmail3.se.axis.com
 ([10.0.5.75]) with mapi; Thu, 17 Jun 2010 10:28:48 +0200
Thread-Topic: moving a remote branch?
Thread-Index: AcsN5SqUaW4mr4D9Q/26xJkEyaiSDgAEMOJA
In-Reply-To: <AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US, sv-SE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149292>

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Nazri Ramliy
> Sent: den 17 juni 2010 08:20
> To: Thomas Anderson
> Cc: git@vger.kernel.org
> Subject: Re: moving a remote branch?
>=20
> On Thu, Jun 17, 2010 at 12:35 PM, Thomas Anderson <zelnaga@gmail.com>
> wrote:
> > git branch -m origin/zelnaga/featurea origin/zelnaga/featureb doesn=
't
> > seem to be working for me. =A0Instead, I get this error:l
> >
> > error: refname refs/heads/origin/zelnaga/featurea
> > fatal: Branch rename failed
> >
> > Any ideas?
>=20
> The error  message could be improved here.
>=20
> The reason you get the error is because you were asking git
> to rename a "remote" branch, which it refuses to do because,
> well, it's a remote branch, and for all practical purposes git
> won't allow you to modify any "remote" stuff as they are all
> read-only from our point of view.
>=20
> If you run "git remote -v" you'll most likely see that "origin"
> is listed in the output which means that your "origin/zelnaga/feature=
a"
> is a remote branch because its name begin with "origin/".
>=20
> Hope this helps.
>=20
> nazri.

Renaming a remote branch is a two step operation. First you push the=20
old branch into its new name, and then you remove the old branch. It=20
can be done with these commands:

	git push origin origin/featurea:refs/heads/featureb
	git push origin :featurea

//Peter
