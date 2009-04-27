From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Lets avoid the SHA-1 term (was [doc] User Manual Suggestion)
Date: Mon, 27 Apr 2009 14:06:25 +0200
Message-ID: <49F59FC1.5020708@drmicha.warpmail.net>
References: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?QmrDtnJuIFN0ZWluYnJpbms=?= <B.Steinbrink@gmx.de>,
	David Abrahams <dave@boostpro.com>,
	Michael Witten <mfwitten@gmail.com>, Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 14:19:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyPbm-00005F-Cp
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 14:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZD0MGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 08:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753117AbZD0MGm
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 08:06:42 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58993 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752999AbZD0MGl (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 08:06:41 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id CBE8E321F42;
	Mon, 27 Apr 2009 08:06:40 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 27 Apr 2009 08:06:40 -0400
X-Sasl-enc: 3yb1p30i2VUanJwDJpSAasw1uR/DQZiuBR2OtXp0Z5oU 1240834000
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9FE80A296;
	Mon, 27 Apr 2009 08:06:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <94a0d4530904261638o6cbda368p4f3aa641505a6768@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117666>

=46elipe Contreras venit, vidit, dixit 27.04.2009 01:38:
> 2009/4/27 Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>:
>> On 2009.04.24 20:48:57 -0400, David Abrahams wrote:
>>>
>>> On Apr 24, 2009, at 8:01 PM, Michael Witten wrote:
>>>
>>>>> What's wrong with just calling the object name "object name"?
>>>>
>>>> What's wrong with calling the object address "object address"?
>>>
>>> Neither captures the connection to the object's contents.  I think
>>> "value ID" would be closer, but it's probably too horrible.
>>
>> I think I asked this in another mail, but I'm quite tired, so just t=
o
>> make sure: What do you mean by "value"? I might be weird (I'm not a
>> native speaker, so I probably make funny and wrong connotations from
>> time to time), but while I can accept "content" to include the type =
and
>> size of the object, the term "value" makes me want to exclude those
>> pieces of meta data. So "value" somehow feels wrong to me, as the ha=
sh
>> covers those two fields.
>=20
> Just to summarize.
>=20
> Do you agree that SHA-1 is not the proper term to choose?
>=20
> Do you agree that either 'id' or 'hash' would work fine?
>=20
> Personally I think there's an advantage of choosing 'hash'; if we pic=
k
> 'id' then the user might think that he can change the contents of the
> object while keeping the same id, if we pick 'hash' then it's obvious
> the 'id' is tied to the content and why.
>=20

Apparently a branch of that thread touched the "[PATCH 0/2] Unify use o=
f
[sha,SHA][,-]1", so I'll do a cc merge, feeling entitled to summarize
the latter:

- There are two SHA-1ish things we talk about: the SHA-1 hash
algorithm/function on the one hand and git object names on the other ha=
nd.

- The object name of a file is not the SHA-1 checksum of its contents:
That's more or less obvious because there are no files in git, only
objects. The object name is the SHA-1 of a representation of an object
(which, for blobs, consists of header + content).

- There seemed to be an implicit claim that the Doc uses SHA-1 for the
algorithm and sha1/SHA1 for the object name. That's not founded by fact=
s
(see below) and is not practical.

- The glossary defines SHA1 to be equivalent to the object name and doe=
s
not mention any other spelling.

The stats (line counts for simplicity) and facts for Documentation/ are=
:

SHA-1: 56
Used exclusively for the object name.

SHA1: 73
Used mostly for the object name, but also for the patch-id (SHA-1
checksum of patch), in the tutorial, and pack-format, i.e. in places
where the actual hash algorithm/function is mentioned.

sha1: 102
Used all over the place, mostly for the object name and when quoting
from the source. I don't think it's used for the hash algorithm/functio=
n.

sha-1: 0

So, the current confusion is mostly due to the fact that 3 different
names are used for the same thing (object name) and to a much lesser
degree to the fact that the same name (SHA1) is used for 2 different
things (hash algorithm/function vs. object name).

My patch tried to lessen the confusion by naming one thing by 1 name
only (SHA-1). It continued the tradition of identifying the object name
with the hash algorithm which is used in forming that name. I don't
think it matters much (confusion-wise) which one we choose from those 3=
,
it would be easy to rewrite the patch to use SHA1 or sha1 instead of
SHA-1 (and I'd be willing to), but consistently so.

An alternative patch would substitute most occurrences of the above by
X, X being the future term for "object name" to be agreed upon, and go
for say SHA-1 at the very few places where the actual algorithm is
mentioned. I just don't want to bet on that agreement and patch happeni=
ng.

Michael
