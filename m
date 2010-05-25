From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Tue, 25 May 2010 09:19:18 +0200
Message-ID: <4BFB79F6.5070501@drmicha.warpmail.net>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com> <20100505050640.GC8779@coredump.intra.peff.net> <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com> <20100512133537.GA28956@coredump.intra.peff.net> <AANLkTilkFHK1UIvSLEstXFIOJTsit02EZe1Wsoj_zRRX@mail.gmail.com> <20100523092348.GA16811@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 09:19:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGoQW-0003ql-Iy
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 09:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab0EYHTn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 03:19:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55995 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752410Ab0EYHTm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 03:19:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6522BF7FCC;
	Tue, 25 May 2010 03:19:39 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 25 May 2010 03:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=UgDPpM0T6jtBffnNvFNomgM4cck=; b=Fm4qGZG8OKco7AQ8izOQvFtsFCgy42uIx8M4CmrDmzZsMt5eiJlSZCp+7AgXcMx0JpvI4az4CqL9PWafA6P12wkGEVmsCTwSIQ9W/BDJqXFh2tX6L452NOocAjpuUud4uS2jRsrhH/nbtM31rJqY3IYFnVO4in1D66P+IfR9Tbg=
X-Sasl-enc: JUO0rYjaHngsUt47+0o+v7QdkafbHsQwanY/Wv6kBmFY 1274771971
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A876F4E2A8E;
	Tue, 25 May 2010 03:19:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <20100523092348.GA16811@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147674>

Jeff King venit, vidit, dixit 23.05.2010 11:23:
> On Fri, May 14, 2010 at 08:54:07AM +0200, Knittl wrote:
>=20
>>> That being said, I still get "Initial commit on master". I think th=
at
>>> stat_tracking_branch just gives up if the branch doesn't exist (whi=
ch
>>> does make some sense). So in practice, I think your original and th=
is
>>> one actually behave the same (sorry, I know that changing it was my
>>> suggestion).
>>
>> yep, that's what i discovered too=E2=80=94but i don't care if this c=
ondition
>> is 3 lines up or down. if stat_tracking_branch decides it will work
>> for initial commits, then this code will do the expected thing
>=20
> Agreed.
>=20
>> should be no problem. the second patch changed quite a bit, so i
>> thought it is easier to review when i send it as a separate patch. t=
he
>> final patch can be squashed of course
>=20
> OK.  Nobody else seems to be commenting, so I would go ahead and put
> together your final patch, cc-ing the maintainer.

Been following silently :)

I'm a regular shortstatus user and find myself calling ordinary status
just to get that part of info you're adding to shortstatus. I agree the
default should stay as is and use aliases anyways. (I also think we nee=
d
to clean up our option/config mess at one point and make at least long
options the same as config variables.)

I even wanted to try out the patch but was stopped by:

>=20
>>>  2. Your patch has wrapped lines which make it impossible to apply
>>>     without fixing up manually. This is a common gmail problem.  Se=
e
>>>     the "gmail" section of SubmittingPatches.
>>
>> ok, browsed through that. i think i will just put my branch into a
>> pasteservice or on a fileserver, unless the email way is *really*
>> preferred=E2=80=94what about email attachments?
>=20
> Inline email is best, but I think an email attachment would be prefer=
red
> to putting it on some out-of-band service (it's nice for the mailing
> list archive to have a record of everything).

I'm really wondering what the problem is with git-send-email + GMail's
smtp. I'm not saying there is none: I'm just observing that we seem to
attract a lot of new contributors lately and that the email-inline-patc=
h
requirement seems to be a hurdle to quite a few. I've created a mob
branch at

http://repo.or.cz/w/git/mjg.git

based off current master to which you can push, Daniel.

I'm wondering whether we should have a mob branch+receive hook solution
where people can push to mob-{maint,master,next} (whose tip coincides
with the resp. main branches), maybe allowing fast-forwards only, and
where a post-receive-hook hook sends the patch to the list and resets
the mob-... branch.

That would require push/pull expertise only, no MUA tweaking necessary.

Cheers,
Michael
