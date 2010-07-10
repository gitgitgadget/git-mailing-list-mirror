From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use of 
	it.
Date: Sat, 10 Jul 2010 02:01:38 -0300
Message-ID: <AANLkTimWpEmaLrRK0YoM2BA7_VU3FIsKr3uq0utd5n6q@mail.gmail.com>
References: <20100702202257.GA7539@burratino>
	<546093148a7ccecace6552c75a70a1cd66b3f420.1278272508.git.tfransosi@gmail.com>
	<20100707151956.GA1529@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com,
	raa.lkml@gmail.com, peter.kjellerstedt@axis.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 07:01:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXSCF-0001g1-Od
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 07:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab0GJFBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Jul 2010 01:01:46 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:60465 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab0GJFBp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Jul 2010 01:01:45 -0400
Received: by qwh6 with SMTP id 6so681006qwh.19
        for <git@vger.kernel.org>; Fri, 09 Jul 2010 22:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bf0HmDxWIMFIzWWeEPGJsJfK+TBv5PMDvadbgwe1T2c=;
        b=A3fyXzs669HgKolaw9fLaqFQotysaOnv52ceIPUSAnPWJxt32hNKVPdJUihB6Jeuwc
         EPRk0QvuzDMd8k8Dob3ETplHu1h2PGEFHKKAyF+O9c1QzgYh/Q6+QS6o+76nULSE3Q97
         owoGS+9s5iapSj4ySdoCp01bZ869nI0VSLsw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DKc9Tnfso1SllQA6cZS7J/FXcQD8Jr6LdI4fsZ0EMYcQy+VM190ajaDyD0ckGEnkV+
         l8cFwKapijrKijEc3btYule02S0HUOhvjICUgRzoskxClE69nkqEHvWb7tCCMe1dVHNo
         P2BTAcPGS9JqLbJWGXvWRP4uyHZANI4r+DO4U=
Received: by 10.224.54.131 with SMTP id q3mr6169049qag.202.1278738098202; Fri, 
	09 Jul 2010 22:01:38 -0700 (PDT)
Received: by 10.229.22.146 with HTTP; Fri, 9 Jul 2010 22:01:38 -0700 (PDT)
In-Reply-To: <20100707151956.GA1529@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150710>

Hi Jonathan,

On Wed, Jul 7, 2010 at 12:19 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Hi Thiago,
>
> Thiago Farina wrote:
>
>> I see that no one commentted in the patch, but I can't see it on
>> http://git.kernel.org/?p=3Dgit/git.git;a=3Dsummary, so I'm not sure =
if it
>> was accepted.
>>
>> What is the easiest way to verify if the patch was committed?
>
> Good question. =C2=A0When no one comments on a patch, that is usually
> a bad sign. =C2=A0In this case, I think the patch is good and I was t=
oo
> lazy to comment on it (sorry).
>
> | $ git log --oneline --author=3DThiago origin/pu
> | 183113a string_list: Add STRING_LIST_INIT macro and make use of it.
> | [...]
> | $ git branch tf/string-list-init 183113a
How did you figure out the part "tf/string-list-init"? The first step
doesn't seem to give any hint about that.

> | $ git branch -r --contains tf/string-list-init
> | origin/pu
Now it shows origin/master, origin/next and origin/pu, so I assume
it's all these three branches.

> | $
>
> So it has been queued in "pu" but not graduated to "next" yet.
>
> Side note. =C2=A0From the description of the "pu" branch in
> origin/todo:MaintNotes
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The "pu" branch, and topic branches that a=
re only in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"pu", are subject to rebasing in general. =
=C2=A0By the above
> =C2=A0 =C2=A0 =C2=A0 =C2=A0definition of how "next" works, you can te=
ll that this
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branch will contain quite experimental and=
 obviously
> =C2=A0 =C2=A0 =C2=A0 =C2=A0broken stuff.
>
> it might sound like Junio thinks your patch is obviously broken!
> I suspect that description of "pu" is intended for testers
> (meaning: try this branch only if you found "next" too boring and
> like writing bug reports) rather than patch authors[1].
>
> Especially during a release candidate period (which this is),
> promising new features are often queued to "pu" and only merged to
> "next" when Junio has had time to look them over again.
>
> HTH,
> Jonathan
>
> [1] Maybe it could be clarified: how about inserting "sometimes"
> before "contain"?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ... you can tell that=
 this
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branch will sometimes contain quite experi=
mental and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0obviously broken stuff.
>
