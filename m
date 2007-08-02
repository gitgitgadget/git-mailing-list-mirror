From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Fri, 03 Aug 2007 00:50:43 +0200
Message-ID: <46B25FC3.6000205@fs.ei.tum.de>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de> <46B215E2.8010307@fs.ei.tum.de> <EDE86758-FFD0-4CED-A2C9-033FA13DD3B6@zib.de> <46B2309E.3060804@fs.ei.tum.de> <6715F560-FE69-4F15-8C5F-B5B6071D97ED@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:50:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjVK-0006Jj-BE
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239AbXHBWur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 2 Aug 2007 18:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755135AbXHBWuq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:50:46 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:59433 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbXHBWuq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:50:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 6A777280E5;
	Fri,  3 Aug 2007 00:50:44 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EeHsL5A2uBDH; Fri,  3 Aug 2007 00:50:44 +0200 (CEST)
Received: from sweatshorts.home.corecode.ath.cx (85-218-17-223.dclient.lsne.ch [85.218.17.223])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id F2B06280E3;
	Fri,  3 Aug 2007 00:50:43 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070627)
In-Reply-To: <6715F560-FE69-4F15-8C5F-B5B6071D97ED@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54634>

Steffen Prohaska wrote:
>> yah, that pretty much tells me it is shawn's bug :)  but without mor=
e=20
>> details, it is very hard to diagnose.
>=20
> I tried again. Interestingly now togit works but tohg still fails.
>=20
> togit starts with reporting
>=20
> fatal: Not a valid object name

that's fine.

> as the first line. But besides that it seems to work fine. What
> concerns me a bit is that the last line togit reports is
>=20
> committing set 18100/18173
>=20
> I'd expect it should report 18173/18173.

that's fine as well.  You only saw multiples of 100, but you didn't con=
sider it would skip the itermediate ones, right? :)

> BTW, togit creates much more complex branching patterns than cvs2svn
> does. The attached file branching.png displays a small view of a
> branching pattern that extends downwards over a couple of screens.
> I checked the cvs2svn history again. It doesn't contain anything
> of similar complexity.

haha yea, there is still some issue with duplicate branch names and the=
 branchpoint.  if it doesn't get the branch right, it will always "pull=
" files from the parent branch.

did you do some manual RCS file copying or manual branch name changing =
of individual files?  this could be the reason.  I still have to find a=
 simple repo to reproduce this.

> tohg fails (on the same repo that togit imported) with the
> following error
[..]
> AssertionError: failed to remove X/Y.cpp from manifest

This is a mercurial 0.9.3 error, as far as I can tell from the reports.=
  This never occured here, and nobody reporting to me could ever reprod=
uce this problem to pinpoint it.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +=
++      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \
