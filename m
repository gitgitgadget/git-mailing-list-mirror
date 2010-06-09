From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 09 Jun 2010 09:23:49 +0200
Message-ID: <4C0F4185.2000207@web.de>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006080912.31448.johan@herland.net> <4C0E6A8A.70608@web.de> <201006082352.38136.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jun 09 09:24:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMFdk-0000un-QG
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 09:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab0FIHXw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 03:23:52 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:49086 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab0FIHXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 03:23:51 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id CF69316550773;
	Wed,  9 Jun 2010 09:23:49 +0200 (CEST)
Received: from [80.128.93.210] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OMFdd-0008Mu-00; Wed, 09 Jun 2010 09:23:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006082352.38136.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/JoBYiY6hk414RzxY5GHAZ+mXJdeteh31ayJCS
	oEGu1QWoaBEMgFs6JY5pNjGAl3dyygNalrVh9UbqhepXoIN7ne
	sEbwjEejpTZOI9aJXqFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148749>

Am 08.06.2010 23:52, schrieb Johan Herland:
> The good thing with =C3=86var's approach is that this is all configur=
able per=20
> branch (indeed, per commit[1]) by editing your .gitmodules file.

Yep, I think this is the sane way to do that.


> Interesting. Will the object parsing machinery handle that without hi=
ccups?=20
> What if an older Git version tries to checkout/update a submodule wit=
h a 0-
> hash?

Maybe =C3=86var's idea of dropping such a submodule from the tree is be=
tter.


> Me too, but I suspect that if you draw the "one big repo" approach to=
 its=20
> logical conclusion, there will be some demand for recursive commits.

You may be right here. But as submodules often have a detached HEAD, th=
is
might get interesting ;-)


> [1]: Say your submodule usually tracks a branch, but you're creating =
some=20
> tag in the super-repo, and you want that tag to uniquely identify the=
=20
> submodule. You achieve this by making sure the tagged commit removes =
the=20
> relevant "branch =3D whatever" line from .gitmodules, and records the=
=20
> appropriate submodule version in the super-repo tree. Then, you can r=
evert=20
> the .gitmodules change on the next commit to resume tracking the subm=
odule=20
> branch.
>=20
> Now, whenever you checkout the tag, you will always get the exact sam=
e=20
> version of the submodule, although the submodule otherwise tracks som=
e=20
> branch.

Won't work anymore when we would use 0{40} or drop it from the tree.
AFAICS always-tip and referencing a certain commit don't mix well.
