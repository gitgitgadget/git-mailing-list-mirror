From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: git clone -b
Date: Fri, 28 Jun 2013 14:27:34 +0200
Message-ID: <51CD8136.6090702@atlas-elektronik.com>
References: <51CD7AB7.3040409@atlas-elektronik.com> <20130628121847.GB1351@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 14:27:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsXmA-0001Hv-Ag
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 14:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab3F1M1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 08:27:38 -0400
Received: from mail96.atlas.de ([194.156.172.86]:25678 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916Ab3F1M1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 08:27:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 869EC10143;
	Fri, 28 Jun 2013 14:27:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0aCrzUH5C9k; Fri, 28 Jun 2013 14:27:36 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 28 Jun 2013 14:27:35 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 6F48927169;
	Fri, 28 Jun 2013 14:27:35 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 28 Jun
 2013 14:27:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130628121847.GB1351@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229193>

Am 28.06.2013 14:18, schrieb Fredrik Gustafsson:
> On Fri, Jun 28, 2013 at 01:59:51PM +0200, Stefan N=E4we wrote:
>> Hi there!
>>
>> Is there any reason why 'git clone -b' only takes a branch (from ref=
s/heads/)
>> or a tag (from refs/tags/) ?
>>
>> Background: At $dayjob we're using some kind of 'hidden' refs (in re=
fs/releases/)
>> to communicate between the 'branch integrator' (who creates the ref =
in refs/releases/)
>> and the 'build master' who wants to build that ref.=20
>>
>> It would be a little easier if the build master could simply say
>>
>>   git clone -b refs/releases/the-release-for-today URL
>>
>> instead of: git clone... ; cd ... ; git fetch... ; git checkout....
>>
>> Any answer or even a better idea to solve that is appreciated.
>>
>> Stefan
>=20
> I don't understand what the alternative should be. You can't look in
> /refs/* because there's a lot of other stuff like bisect/remotes etc.
> there.

Well, I tell clone exactly what I want. There is no reason try somethin=
g
from refs/*.
=20
> Of course you could add to also look in /refs/releases/ but as I
> understand you that a special solution for your company. Why should a=
ll
> git users have that addition?

It wouldn't hurt, IMHO. Maybe it would even make sense to allow any SHA=
-1
to be passed to '-b'.
=20
> Two questions about your setup:
>=20
> 	1. Why do you always clone your repository? To me clone is a one
> 	time operation.

We would use 'git archive' if that would be submodule-aware...

> 	2. Why don't you tag your releases with an ordinary tag?

Because we use that 'refs/release' thing as a hidden ref that other
developers will not see when they fetch (unless they are told to checko=
ut
that particular ref).

Think of using this similar to the way github uses refs/pull/*/{head,me=
rge}=20
for their pull request mechanism.

Stefan
--=20
----------------------------------------------------------------
/dev/random says: The Definition of an Upgrade: Take old bugs out, put =
new ones in.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
