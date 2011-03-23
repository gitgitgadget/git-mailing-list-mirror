From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 11:46:38 +0100
Message-ID: <4D89CF8E.4070100@drmicha.warpmail.net>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 11:50:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Ldt-0001fb-P8
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 11:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090Ab1CWKuM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 06:50:12 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:55751 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755271Ab1CWKuL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 06:50:11 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D33B0209CE;
	Wed, 23 Mar 2011 06:50:10 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 23 Mar 2011 06:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=oPsEAZZ5jis+ozUFu5yAI+US5VM=; b=P9TvoDVs9+vcb9ja4Wynja2C+boEM1w+0ejcpVWXB/Y0T3WExtTZrYhQH1KzNNcpHELln5XhwBZMZ+ORSypKHxfD1lX2064vu6o34jQWrK/nREtanHHKXry0K5HY15SNCi2yT77qidqXArp0hdE0nMj9UVWvHr7c/E6024PF/8o=
X-Sasl-enc: mYPybnhTtA9dzfAKTxXbkdvwa1s0B59GVUza9Ky7U0F0 1300877410
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 53CD6400445;
	Wed, 23 Mar 2011 06:50:10 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169814>

Piotr Krukowiecki venit, vidit, dixit 23.03.2011 09:11:
> Hi,
>=20
> Short version:
>=20
> 1. The <limit> is misleading IMO

In what way? Is the documentation wrong?

> 2. Please extend the output to show "full diff"
> 3. Please add numerical/time <limit>
> 4. Would it be possible to use "=3D" for "equivalent change"?
>=20
> Please tell me your opinions.

You will be a happy user of "git log --cherry A...B" instead of "git
cherry A B". It gives you all the log option (e.g. p for diff) that you
like and uses "=3D" rather than "-". It's currently in next and will be=
 in
the next release.

>=20
>=20
> Long version:
>=20
> I have a branch that have diverged long time ago from main branch. I =
can't use
> merge, so I'm using cherry-pick to transplant changes between branche=
s
> (the other reason is I'm using git-svn...)
>=20
> I noticed I did not transplant a certain commit recently. I wanted to
> see if there
> are any other commits I didn't transplant. I tried using git cherry:
>=20
>=20
> 1. man page says: git cherry [-v] [<upstream> [<head> [<limit>]]]
>=20
>    $ git cherry -v master 9_1 20
>    fatal: Unknown commit 20
>=20
> After reading man page I though the limit is a numeric limit, like "c=
heck
> last 20 commits".

It clearly is the name of a commit in that picture.

>=20
> 2. The cherry currently shows only changes against one branch:
>=20
>    Every commit that doesn=92t exist in the <upstream> branch has its=
 id (sha1)
>    reported[...] The ones that have equivalent change already in the =
<upstream>
>    branch are prefixed with a minus (-) sign, and those that only exi=
st in the
>    <head> branch are prefixed with a plus (+)  symbol
>=20
> So it will not show commits that exist only in <upstream> but not in =
<head>.
>=20
> In my case changes are transplanted both ways (in general), so I have=
 to check
> both branches.

You'll be a happy user of "git log --cherry-mark --left-right A...B" :)


> 3. I think a numerical limit (or even: time limit etc) of checked com=
mits would
> be useful, especially in "full diff" mode. Without it would be not

log has a limit argument (-<number>), though I'm not sure it is exactly
what you want.


> 4. The output format uses "-" to show commits that exist in both bran=
ches.
> I find this unnatural. There probably is a reason for this? But maybe=
 it would
> be possible to change the symbols? For example:
>=20
>    - commit in upstream only
>    + commit in head only
>    =3D equivalent commit
>=20
> Or "<", ">", " " or any other graphic symbol.

git log --cherry-mark --left-right will use <,=3D,>
git log --cherry-mark or --cherry will use *,=3D

(And yes, you can use it with --graph!)

Cheers,
Michael
