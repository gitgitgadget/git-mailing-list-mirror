From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 09 Jun 2010 09:15:53 +0200
Message-ID: <4C0F3FA9.7000800@web.de>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006080912.31448.johan@herland.net> <4C0E6A8A.70608@web.de> <7vbpblruj8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= =?ISO-8859-1?Q?_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 09:17:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMFXL-0005ZR-5V
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 09:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab0FIHRN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 03:17:13 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:42083 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab0FIHRN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 03:17:13 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id E0F361654A591;
	Wed,  9 Jun 2010 09:15:53 +0200 (CEST)
Received: from [80.128.93.210] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OMFVx-0006ul-00; Wed, 09 Jun 2010 09:15:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vbpblruj8.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/guIpgNokUDFrUwwNmxdg9y0nX+kp5aQDpFAF3
	sLpAgCkfybtAtTqcTZ4Te8wQWXFdGQzXCWkWHBhc7Vgkcnrz6Q
	I8Vr6qIkzyQ52SrSDyiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148747>

Am 09.06.2010 01:09, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
>> Don't record a commit in the first place, following a branch is not =
bound
>> to a special commit, so pretending to do that might do more harm tha=
n good.
>> Just putting the 0-hash there might be the solution.
>=20
> Ugh.  Even though I understand that in some scenarios you would want =
to
> say "I don't care what commit is used for this submodule---just use t=
he
> tip of the branch 'fred'", I don't think you want to use 0{40} in the
> superproject.  I think it would be Ok to add such a note to .gitmodul=
es in
> the superproject, but I also think we should still record which _exac=
t_
> commit was used to test and validate such a commit in the superprojec=
t
> when it was made.

I think we are in violent agreement here. But I as far as understood th=
e
always-tip mode (and I might be wrong here as I never used something li=
ke
SVN Externals) it is intended to not be able to tell which exact versio=
n
of the submodules branch was used. Otherwise you could just update the
branch in the submodule and commit that in the superproject, which is w=
hat
people do not seem to want (please correct me if I am wrong).

Under this assumption it seems to me that it doesn't make sense to reco=
rd
anything but 0{40}, as this tells people "this submodule was somewhere =
at
the tip of <branch>, but we can't say where exactly"). Or maybe don't a=
dd
the submodule to the tree at all, like =C6var proposed. Same outcome, m=
aybe
even easier to do.

But I always have the feeling there is something I don't get when peopl=
e
talk about the always-tip mode, so maybe the potential users of such a
feature should speak up now.
