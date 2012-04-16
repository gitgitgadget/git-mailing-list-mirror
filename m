From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] tests: add tests for the bash prompt functions in the
 completion script
Date: Mon, 16 Apr 2012 13:04:41 +0300
Message-ID: <CAMP44s0vkH9iE4MoV7HgGwOXna40pAL=h6be13qdreexp5_14w@mail.gmail.com>
References: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
	<CAMP44s3LJO_Ryc-ONjF+rEHCb1hB8+4Muar6pzjD3zrazYqK+A@mail.gmail.com>
	<20120416094938.GE2900@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Apr 16 12:04:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJing-0003Qo-1i
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 12:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab2DPKEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 06:04:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41872 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2DPKEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 06:04:42 -0400
Received: by eaaq12 with SMTP id q12so1221090eaa.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7R+uVLo5dnFIs6npMRw+Vigcp/+NYVEdP4spkff4U9Y=;
        b=cRjpjI083BwFx6s9HgKdQHdQ63odHc+wTzo3GlC/Eklw1rzG+XP4VrNtbVubH37BtA
         m9ml5p3J2re+Y48fA+JmJ3j2uKbPTV5Aqq3TivRVx27I7wafN+jgbdxHgUBxfWKjs/J9
         Y3yCUVaqM2eHJvsNVHVC/fs/YHUhJ126ek/nff46rwqwv248w+YhkVYNZp5IbNVxQFge
         sVIKHAHNKgu6PTLtAoWCib+ni57rW7D0XZfmaZXSaE7fhFwuBTW0Y6BWLkgNdPOJBeSv
         jSCj45CYVM4jj/DPiTP5B29lvSD4WVzX6NkmLZ0lcFxcDpmgVEU784tb9yESbzOB5JUm
         dYvg==
Received: by 10.213.9.209 with SMTP id m17mr117861ebm.19.1334570681594; Mon,
 16 Apr 2012 03:04:41 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 03:04:41 -0700 (PDT)
In-Reply-To: <20120416094938.GE2900@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195606>

2012/4/16 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> Hi,
>
> On Sun, Apr 15, 2012 at 11:56:36PM +0300, Felipe Contreras wrote:
>> On Sun, Apr 15, 2012 at 11:31 PM, SZEDER G=C3=A1bor <szeder@ira.uka.=
de> wrote:
>> > The tests cover the discovery of the .git directory in the __gitdi=
r()
>> > function in different scenarios, and the prompt itself, i.e. branc=
h
>> > name, detached heads, operations (rebase, merge, cherry-pick, bise=
ct),
>> > and status indicators (dirty, stash, untracked files; but not the
>> > upstream status).
>> >
>> > Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
>> > ---
>> >
>> > Goes on top of fc/completion-tests (b8574ba7).
>> >
>> > =C2=A0t/t9902-completion.sh | =C2=A0436 ++++++++++++++++++++++++++=
+++++++++++++++++++++++
>> > =C2=A01 file changed, 436 insertions(+)
>>
>> Perhaps it would make sense to create another file for these,
>
> I thought about that briefly but decided against it to avoid
> duplicating the bash-specific checks at the beginning, but I don't
> care that much either way.
>
>> specially since there's the plan of splitting the prompt stuff to a
>> separate file.
>
> Oh, I was not aware of such a plan. =C2=A0What would be the benefits =
of
> such a move, why is it necessary? =C2=A0Where would you split it up? =
=C2=A0In
> particular, what would happen with __gitdir(), which is used in many
> completion functions and in __git_ps1() as well?

I guess __gitdir() would be duplicated, I don't think that has been dis=
cussed.

http://thread.gmane.org/gmane.comp.version-control.git/194188

Basically splitting helps for systems that use bash-completion, and
also helps for zsh users who don't want the bash completion, but still
want __git_ps1(). I split the file myself for this reason.

Cheers.

--=20
=46elipe Contreras
