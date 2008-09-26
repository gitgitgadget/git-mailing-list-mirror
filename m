From: Andreas Ericsson <ae@op5.se>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Fri, 26 Sep 2008 09:26:09 +0200
Message-ID: <48DC8E91.6080909@op5.se>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809251729440.3265@nehalem.linux-foundation.org> <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 09:27:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj7jZ-0000Yl-BQ
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 09:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbYIZH0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2008 03:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYIZH0P
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 03:26:15 -0400
Received: from mail.op5.se ([193.201.96.20]:57261 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbYIZH0P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 03:26:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6767B1B80050;
	Fri, 26 Sep 2008 09:17:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.086
X-Spam-Level: 
X-Spam-Status: No, score=-3.086 tagged_above=-10 required=6.6
	tests=[AWL=-0.587, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rh86CQrk8uTZ; Fri, 26 Sep 2008 09:17:02 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 3924C1B800A7;
	Fri, 26 Sep 2008 09:17:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <BD7D0F18-32BD-4059-9190-A2C1B101B4C1@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96833>

Wincent Colaiuta wrote:
> El 26/9/2008, a las 2:37, Linus Torvalds escribi=F3:
>=20
>> On Thu, 25 Sep 2008, Linus Torvalds wrote:
>>>
>>> And the thing I wanted to work was to have the abbreviated SHA1's t=
hat
>>> have started to get more common in the kernel commit logs work as=20
>>> links in
>>> gitk too, just the way a full 40-character SHA1 link works.
>>
>> For a test-case, I just pushed out my current top-of-tree that final=
ly
>> pushed me over the edge. I've seen this before, but I couldn't reall=
y
>> force me to do anything about it until now.
>>
>> So to see this in action, do
>>
>>     gitk v2.6.26..6ef190c
>>
>> on the current kernel repo, and notice that "Commit ee1e2c82 ("IPoIB=
:
>> Refresh paths .." thing, where we want that 'ee1e2c82' to be a link =
even
>> though it's not a full SHA1.
>>
>> Of course, the matching could be better, it will now accept any rand=
om 6+
>> character sequence of hex characters, even if they are surrounded by
>> characters that make it clear that it's not a SHA1 ("Haahahhaaaaaa!"
>> would find the 'aaaaaa' and if you have a commit that starts with th=
at,
>> link to it ;)
>=20
> I know nothing about tcl/tk, but will comment anyway:
>=20
> It's a shame that tcl/tk regular expressions don't appear to support=20
> anchoring matches against word boundaries (ie. "\b").
>=20
> If so, a regexp like:
>=20
>  [regexp {\b[0-9a-f]{4,39}\b} $id]
>=20
> would mostly eliminate that kind of false positive. But from my readi=
ng=20
> of the wiki[1], looks like there's no "\b" escape sequence. Nor does =
it=20
> look like tcl/tk has support for lookahead/lookbehind assertions whic=
h=20
> could be used to the same effect.
>=20

It's not as if this will be a real problem anyway. gitk is designed to
be used by humans, who can fortunately parse such things a trillion
times better than any regex a billion monkeys could come up with in a
billion years, even if one was to take evolution into account. ;-)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
