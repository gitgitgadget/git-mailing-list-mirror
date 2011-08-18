From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Thu, 18 Aug 2011 09:15:53 +0200
Message-ID: <4E4CBC29.7080703@drmicha.warpmail.net>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com> <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com> <7vhb5fd4zy.fsf@alter.siamese.dyndns.org> <CACsJy8CX7X3u4i_kXChVHkFK=Q--pRBrxmdvjxrF7wr5_SyakA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Conrad Irwin <conrad.irwin@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:16:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtwpe-0002OX-DB
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135Ab1HRHP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 03:15:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48838 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754920Ab1HRHP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 03:15:57 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 00021205CA;
	Thu, 18 Aug 2011 03:15:55 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute5.internal (MEProxy); Thu, 18 Aug 2011 03:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=or1awWQ5Fj3DQEXGzfSRj3
	WRVG0=; b=g6uJ//DAKHf2MxPhSWWM6PQZOZlZFL8RYpJ8XFIGd4HPBfYH6hqdsm
	E56fR35kKWWXBRCBNsVzzITDj0j53ol3S6bQc6ipHmPkZGrd0lBY4Ns3TrCYsoLQ
	GpyXZybKOIv8gJOOD5OUVd7+U5Ac3POEdWsfvHw9JSev7J3r1R5/Q=
X-Sasl-enc: 6//Fviat28p+F/C40z7Doz/P0+CO858bggbXfSvDEqtV 1313651755
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2414541F823;
	Thu, 18 Aug 2011 03:15:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CACsJy8CX7X3u4i_kXChVHkFK=Q--pRBrxmdvjxrF7wr5_SyakA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179571>

Nguyen Thai Ngoc Duy venit, vidit, dixit 18.08.2011 03:53:
> On Thu, Aug 18, 2011 at 5:53 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Letting u/upstream spelled case-insensitively does improve consisten=
cy
>> among the above, but at the same time if we ever wanted to enhance @=
{...}
>> notation even further in the future, we are restricted to a payload =
that
>> is case insensitive to retain the consistency.
>>
>> The only remotely semi-plausible enhancement I could think of is per=
haps
>> to allow @{/regexp} to find a reflog entry that matches the given pa=
ttern,
>> and in such a use case we would certainly want to take the pattern i=
n a
>> case sensitive way. This change closes the door to that, and that is=
 the
>> only downside I can think of right now.
>>
>> I hate to declare that we will never support such a feature with thi=
s
>> change, but at the same time, I do not think I would need such a fea=
ture
>> that often. But for that matter, I do not think I would miss @{UpStR=
EAM},
>> either, and that takes me back to "Meh" for this change.
>>
>> What do people think?
>=20
> The itch is probably because people have to release shift, then press
> shift again to type "@{u}". How about allow case insensitive match if
> there's only _one_ letter inside @{}?
>=20
> That would solve the shift problem while leaving door for @{...} exte=
nsion.

Well, this patch is actually specific to a particular keyboard layout!
It improves things only for a layout where you get @ and { using a shif=
t
key.

=46or a german keyboard layout, you get @{u} from

hold AltGr (Meta)
press q
press 7
release AltGr
press u
hold AltGr
press 0

=46or me, an improvement would be to have the alias

@{=E2=86=93}

for @{u} so that I can hold AltGr throughout and press q7u0. Which woul=
d
be very nice, pictorially :)

In general git could benefit from a rev alias mechanism. This idea has
come up several times, but in order to be really useful, we would need
that to be more general than textual replacements and allow for macro
like replacements such as

git config revalias.new "\1@{1}..\1"

to be used as, say

git log @{new(origin/next)}

after a fetch. (No, I'm not suggesting that specific syntax here.)

As a simpler case, a user could tailor to her keyboard layout with

git config revalias.=E2=86=93 u

but for obvious reasons

git config revalias.U u

won't work.

So, maybe we could make the key part of a special revspec case
insensitive (just like config variable names) but still have a possible
payload (parameter) be case sensitive (just like config variable values=
)?

Michael
