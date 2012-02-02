From: Norbert Nemec <norbert.nemec@native-instruments.de>
Subject: Re: How to find and analyze bad merges?
Date: Thu, 02 Feb 2012 12:17:46 +0100
Message-ID: <4F2A70DA.6020107@native-instruments.de>
References: <jgdgcv$h8n$1@dough.gmane.org> <jgdn5j$v4g$1@dough.gmane.org> <87haz97c2k.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Feb 02 12:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsumw-0003mI-3p
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 12:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab2BBLZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 06:25:07 -0500
Received: from mx.native-instruments.com ([46.231.181.241]:44128 "EHLO
	mx.native-instruments.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755309Ab2BBLZG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 06:25:06 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Feb 2012 06:25:06 EST
In-Reply-To: <87haz97c2k.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189629>

To be yet more precise:

My complaint is that you need this kind of sledge-hammer solutions to=20
analyze the situation. I, as an semi-expert with git did manage to find=
=20
the problem without even having to resort to bisect or manually redoing=
=20
the merge. My complaint is about the perspective of the=20
medium-experienced user who is completely puzzled by the fact that a
"git log <filename>" silently skips the critical merge commit.




Am 02.02.12 11:40, schrieb Thomas Rast:
> "norbert.nemec"<norbert.nemec@native-instruments.de>  writes:
>
>> Thinking about a possible solution:
>>
>> Is there a way to re-do a merge-commit and diff the result against t=
he
>> recorded merge without touching the working tree? This would be the
>> killer-feature to analyze a recorded merge-commit.
>
>    git checkout M^
>    git merge M^2
>    git diff M HEAD
>
> You'd have to resolve conflicts though.  If you want to skip that, I
> think you could still see some information if you said
>
>    git reset
>    git diff M
>
> to see the differences between the (unmerged, with conflict hunks) st=
ate
> in the worktree and M.
>
> (Remember to re-attach your HEAD after playing around like this.)
>
>> Am 02.02.12 09:16, schrieb Junio C Hamano:
>>>
>>> Bisect?
>>
>> This is not the point: My colleague knew exactly which commit
>> contained the bugfix. The trouble was finding out why this bugfix
>> disappeared even though everything indicated that it was cleanly
>> merged into the current branch.
>
> But that makes it a prime candidate for bisect: you know the good com=
mit
> (the original bugfix), and you know that the newest version is bad.
> Bonus points if you have an automated test for it, in which case bise=
ct
> can nail the offender while you get coffee.
>
> Or am I missing something?
>

--=20
Dr. Norbert Nemec
Teamleader Software Development

Tel +49-30-611035-1882
norbert.nemec@native-instruments.de

KOMPLETE 8 ULTIMATE - the premium NI producer collection
=3D>  http://www.native-instruments.com/komplete8

TRAKTOR KONTROL S2 - the professional 2.1 DJ system
=3D>  http://www.native-instruments.com/s2

->>>>>> NATIVE INSTRUMENTS - The Future of Sound <<<<<<-

Registergericht: Amtsgericht Charlottenburg
Registernummer: HRB 72458
UST.-ID.-Nr. DE 20 374 7747

Gesch=E4ftsf=FChrung: Daniel Haver (CEO), Mate Galic
