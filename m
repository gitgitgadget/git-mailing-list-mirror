From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 04 Oct 2010 10:23:13 +0200
Message-ID: <4CA98EF1.1050102@drmicha.warpmail.net>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de> <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com> <1285967766.6750.2.camel@gandalf.stny.rr.com> <4CA9815D.3040801@drmicha.warpmail.net> <20101004075015.GN28679@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Darren Hart <darren@dvhart.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Oct 04 10:23:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2gKV-0008Fr-S4
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 10:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056Ab0JDIXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 04:23:04 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49099 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752893Ab0JDIXC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 04:23:02 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 390BB57F;
	Mon,  4 Oct 2010 04:23:02 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 04 Oct 2010 04:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=aPGhe7EqVhUOWSmEOYMglM9yqLA=; b=o700B9kpy+pzlyGIerfz8valvnu3nbUp6xNLuhvR8eYxLtcQpPn5ohZKLHNlu8+rJmZe/HeMn+GMGgVpE/TWRi60L92g+/kyykTBZSp/9TA4w7BMVSchBzpoknmc5BxlmCmVFG0r3D9lvYKGuZWK9V/U/Ap0/rkZdPqP6QPYT6o=
X-Sasl-enc: EwDhUmTH7d8DDJwwGBqHKEpwgW0XZmKMsiURomp0eFLd 1286180581
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2A747409506;
	Mon,  4 Oct 2010 04:23:01 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <20101004075015.GN28679@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158011>

Uwe Kleine-K=F6nig venit, vidit, dixit 04.10.2010 09:50:
> Hello Michael,
>=20
> On Mon, Oct 04, 2010 at 09:25:17AM +0200, Michael J Gruber wrote:
>> Steven Rostedt venit, vidit, dixit 01.10.2010 23:16:
>>> On Fri, 2010-10-01 at 13:18 -0700, Darren Hart wrote:
>>>> 2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>>>>> Some people in #linux-rt claimed that you cannot define "--mirror=
" with
>>>>> "mirror".
>>>>>
>>
>> I'd say "mirror" is a commonly known term for an exact copy. Moreove=
r,
>> the text below doesn't explain what a mirror is either, only how
>> "update" behaves in it.
> hmm.  The --mirror option doesn't have any effect (apart from the
> changes in the config file) until you update.  So I think it's natura=
l
> to talk about git update.  No?

"git clone" (with or without --mirror) does a couple of things, and it
does them differently when "--mirror" is used. It mirrors each branch
from the source repo in the target repo under the same name, including
for example any remote branches in the source repo. This is completely
different without "--mirror", where clone does not look at the source's
remote branches at all. Also, it sets up a mirroring refspec, i.e.
+refs/*:refs/*

Then, when you use the mirror clone, the refspec makes it behave
differently from a normal clone, which is what you notice with "update"=
 etc.

>>>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
>
>>>>
>>>> Acked-by: Darren 'Some People' Hart <darren@dvhart.com>
>>>
>>>   Acked-by: Steven Rostedt <rostedt@goodmis.org>
>>>
>>> -- Steve
>>>
>>>>
>>>>> ---
>>>>>  Documentation/git-clone.txt |   11 ++++++++++-
>>>>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clon=
e.txt
>>>>> index dc7d3d1..5eedfbd 100644
>>>>> --- a/Documentation/git-clone.txt
>>>>> +++ b/Documentation/git-clone.txt
>>>>> @@ -128,7 +128,16 @@ objects from the source repository into a pa=
ck in the cloned repository.
>>>>>        configuration variables are created.
>>>>>
>>>>>  --mirror::
>>>>> -       Set up a mirror of the remote repository.  This implies `=
--bare`.
>>>>> +       Set up a mirror of the remote repository.
>>>>> +       Using
>>>>> +
>>>>> +               git remote update origin
>>>>> +
>>>>> +       (or `<name>` instead of `origin` if -o is given) in the r=
esulting
>>
>> "remote" has no "-o" option. You probably mean the "clone" option, b=
ut
>> the way it's written it refers to the preceding command.
> So what do you think about:
>=20
> 	... (or `<name>` instead of `origin` if -o is given to clone)

maybe "was given"

>=20
>>
>>>>> +       repository overwrites the local branches without asking.
>>>>> +       This implies `--bare`.
>>
>> Again, "this" refers to the preceding sentence. But the update behav=
ior
>> does not imply "--bare". Specifying "--mirror" for "clone" implies "=
--bare".
> OK.
> =20
>>>>> +       Without --mirror (but with --bare) git remote update does=
n't touch any
>>>>> +       branches at all.
>>
>> That's not true. It just doesn't touch any local branches; it update=
s
>> the remote branches, of course.
> Hmm, for me there are no remote branches when using --bare:

I'm sorry, I missed the parenthetical remark. You're completely right
for the case with "--bare" only.

>=20
> 	ukleinek@cassiopeia:~/tmp$ git clone --bare ~/gsrc/topgit
> 	Cloning into bare repository topgit.git...
> 	done.
> 	ukleinek@cassiopeia:~/tmp$ cd topgit.git/
> 	ukleinek@cassiopeia:~/tmp/topgit.git$ git remote update
> 	Fetching origin
> 	From /home/ukleinek/gsrc/topgit
> 	 * branch            HEAD       -> FETCH_HEAD
>=20
> This is also documented for --bare:
>=20
> 	When this option is used, neither remote-tracking branches nor
> 	the related configuration variables are created.
>=20
> Best regards
> Uwe
>=20

This makes me think that --mirror should be explained on top of --bare.
=46or example:

In addition to the mapping of local branches to local branches which
--bare does, --mirror maps all refs which the source has under the same
name in the target (including remote branches, notes etc.) and sets up =
a
refspec configuration so that all these refs are updated by a `git
update` in the target repo.

Michael
