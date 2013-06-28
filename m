From: =?ISO-8859-15?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git clone -b
Date: Fri, 28 Jun 2013 14:15:57 +0200
Message-ID: <51CD7E7D.4040104@atlas-elektronik.com>
References: <51CD7AB7.3040409@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 28 14:16:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsXax-0007vc-Us
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 14:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab3F1MQB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 08:16:01 -0400
Received: from mail96.atlas.de ([194.156.172.86]:20938 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113Ab3F1MQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 08:16:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id A30D910143
	for <git@vger.kernel.org>; Fri, 28 Jun 2013 14:15:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q6cbg6VyAj6n for <git@vger.kernel.org>;
	Fri, 28 Jun 2013 14:15:58 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP
	for <git@vger.kernel.org>; Fri, 28 Jun 2013 14:15:58 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id EE0052716A
	for <git@vger.kernel.org>; Fri, 28 Jun 2013 14:15:57 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 28 Jun
 2013 14:15:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51CD7AB7.3040409@atlas-elektronik.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229191>

Am 28.06.2013 13:59, schrieb Stefan N=E4we:
> Hi there!
>=20
> Is there any reason why 'git clone -b' only takes a branch (from refs=
/heads/)
> or a tag (from refs/tags/) ?
>=20
> Background: At $dayjob we're using some kind of 'hidden' refs (in ref=
s/releases/)
> to communicate between the 'branch integrator' (who creates the ref i=
n refs/releases/)
> and the 'build master' who wants to build that ref.=20
>=20
> It would be a little easier if the build master could simply say
>=20
>   git clone -b refs/releases/the-release-for-today URL
>=20
> instead of: git clone... ; cd ... ; git fetch... ; git checkout....
>=20
> Any answer or even a better idea to solve that is appreciated.
>=20
> Stefan
>=20

Oh, and while at it:

This doesn't look/feel right:

  $ git clone -b refs/heads/master git/.git other-git
  Cloning into 'other-git'...
  fatal: Remote branch refs/heads/master not found in upstream origin
  fatal: The remote end hung up unexpectedly

(where git is git's git which definitely has refs/heads/master...)

Stefan
--=20
----------------------------------------------------------------
/dev/random says: In God we trust; all else we walk through.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
