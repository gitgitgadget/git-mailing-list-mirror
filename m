From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 14:51:20 +0200
Message-ID: <op.utw7buoi1e62zd@balu>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 14:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4aPT-0003vK-Im
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 14:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761370AbZENMva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 08:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761401AbZENMv3
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 08:51:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:58613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761522AbZENMv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 08:51:26 -0400
Received: (qmail invoked by alias); 14 May 2009 12:51:26 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp053) with SMTP; 14 May 2009 14:51:26 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+vWxxIhXCvi0397iG0aGQTdB7NrU7bhGGrK1rHkJ
	+UpMKiiwsNS4OK
Received: from [127.0.0.1] (helo=balu)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KJMX1K-000DI8-FF; Thu, 14 May 2009 14:51:20 +0200
In-Reply-To: <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119186>

Am 14.05.2009, 14:16 Uhr, schrieb Alex Riesen <raa.lkml@gmail.com>:

> 2009/5/14 Matthias Andree <matthias.andree@gmx.de>:
>> Am 14.05.2009, 05:18 Uhr, schrieb Junio C Hamano <gitster@pobox.com>=
:
>>> No. =A0You can tag any object, and a tag is an object. =A0You can p=
oint a
>>> signed tag with your own signed tag to attest your own belief on th=
at
>>> other guy's tag, be it "it's genuine", "the tagged commit suits my =
=20
>>> need",
>>> etc.
>>
>> OK, so I can tag/sign any object, fine.
>>
>> HOWEVER, I see two problems here (yes, they are corner cases):
>>
>> #1: git tag -f ("replace tag") fails to "replace" a heaviweight tag =
if =20
>> I try
>> to replace a tag by itself (or create a cycle by some other means).
>
> It is not a "cycle" ("loop"?) The tags information is the SHA1, not
> the tag's name.
>
>> The new "foo" is unique in refs (OK), but it's *not unique* in objec=
ts
>> (FAIL), as the old "foo" is referenced by the new "foo" and bears th=
e =20
>> same
>> tag name.
>
> Of course it is unique. Look at tag's SHA1.

Hi Alex,

I'm sorry to say this is irrelevant. Please read my earlier message aga=
in, =20
and completely this time - you appear to have missed crucial parts, as =
=20
your next paragraph suggests:

>> #2: related: git tag -d cannot reliably delete tag objects
>>
>> Same here: if another tag object references the tag object I'm =20
>> deleting, we
>> only delete the ref, but not the tag object. It doesn't (cannot) bec=
ome
>> dangling.
>
> As soon as an object is not referenced anymore by any reference =20
> (including references from refs/tags/), reference log or index it wil=
l =20
> be removed by
> garbage collection (gc, prune) at the next opportunity.

Irrelevant, because your assumption "not referenced anymore" is false. =
=20
This was clearly written in my earlier message, which please see.

--=20
Matthias Andree
