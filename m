From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] [RFC] Design for pathname encoding gitattribute [RESEND]
Date: Tue, 22 Jan 2008 23:44:53 +1300
Message-ID: <4795C925.2090409@catalyst.net.nz>
References: <20080122050215.DE198200A2@wilber.wgtn.cat-it.co.nz>	<7vlk6iv0ik.fsf@gitster.siamese.dyndns.org>	<7vr6gatidd.fsf@gitster.siamese.dyndns.org>	<4795BE07.4040500@catalyst.net.nz> <7vprvuqh94.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 11:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHGc9-0003yi-QG
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 11:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760167AbYAVKnw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 05:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759103AbYAVKnv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 05:43:51 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:41567 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759451AbYAVKnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 05:43:50 -0500
Received: from 203-97-235-49.cable.telstraclear.net ([203.97.235.49] helo=[192.168.69.104])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1JHGbb-0001NV-69; Tue, 22 Jan 2008 23:43:47 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vprvuqh94.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71443>

Junio C Hamano wrote:
> Sam Vilain <sam.vilain@catalyst.net.nz> writes:
>=20
>> On the chicken and egg thing, ...
>> ...  I do agree with Dscho's point that mixing encodings in a
>> repository is not necessarily a use case worth catering for.
>=20
> Are you talking about "repository" as in "a specific clone", or
> "a project that can be cloned by many people and checked out to
> suit cloner's needs"?  I definitely agree that mixing encodings
> in a project (i.e. "paths in tree objects") does not make any
> sense _if_ clones of the projects _may_ want to check things out
> in different pathname encodings from each other.  And if all
> clones would want to check things out the same way, it does not
> really matter what encoding the paths in tree objects are.

I'm referring to the normalized form in the object database - ie what
affects the generated SHA1s - what you check it out to locally is a
developer's choice, and assuming that they can handle whatever issues
they create by doing this, then that should be fine.

> I am not absolutely sure if you are talking about mixing
> encodings depending on parts of the tree in a specific clone (my
> earlier "Documenta=C3=A7=C3=A3o/ja/ =E3=81=8A=E8=AA=AD=E3=81=BF=E4=B8=
=8B=E3=81=95=E3=81=84" example).  I would
> certainly say it would be a very low priority for us to support
> such usage, as I imagine that multi-language trees would most
> likely be checked out in UTF-8 everywhere, but it _might_ be
> something people may find real need for.

Agreed - not something you want to condone, but if it's just as easy to
come up with a design that doesn't limit to one encoding for a whole
repository, it might help some people.

The use case for mixed encodings I had in mind was when you clone some
repository that's got them mixed, and you need to tell git the encoding
per-path to get the darned thing to behave sensibly for you (presumably
while you write a patch to submit upstream to fix it).

Sam.
