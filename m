From: Andreas Ericsson <ae@op5.se>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 12:39:05 +0200
Message-ID: <4D906549.9050102@op5.se>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 12:39:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q49qv-0005Yr-PM
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 12:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab1C1KjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 06:39:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63867 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab1C1KjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 06:39:10 -0400
Received: by eyx24 with SMTP id 24so1102889eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 03:39:09 -0700 (PDT)
Received: by 10.14.9.224 with SMTP id 72mr1589850eet.95.1301308748256;
        Mon, 28 Mar 2011 03:39:08 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id v60sm2656741eeh.2.2011.03.28.03.39.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 03:39:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170114>

On 03/28/2011 11:32 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> Something was broken a 100 revisions ago, has now been fixed, but I
> want to find when it was fixed.
>=20
> I'd expect this to work:
>=20
>      $ git bisect start
>      $ git bisect good
>      $ git bisect bad HEAD~100
>      Some good revs are not ancestor of the bad rev.
>      git bisect cannot work properly in this case.
>      Maybe you mistake good and bad revs?
>=20
> But instead I have to do:
>=20
>      $ git bisect start
>      $ git bisect bad
>      $ git bisect good HEAD~100
>=20
> And then proceed to mark good revisions as bad, and bad revisions as
> good.
>=20
> That works, but it's very confusing.
>=20
> Why can't bisect just do the right thing here and accept that your
> more recent revesion is the good one, and the old one is the bad one?

It's due to the fact that bisect is, in 99% of the cases, used to
locate the commit that introduced a bug and the implementation details
naturally gear towards that scenario, with fixed names that do the
Right Thing(tm) in 99% of all cases.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
