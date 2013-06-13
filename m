From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: New feature discussion: git rebase --status
Date: Thu, 13 Jun 2013 14:19:53 +0200
Message-ID: <dc115f90be3bc5830473a6648bf37df5@ensibm.imag.fr>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
 <20130611125521.GL22905@serenity.lan> <vpqbo7c4wen.fsf@anie.imag.fr>
 <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
 <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
 <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
 <51B857B0.5030603@ensimag.fr>
 <3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
 <CALWbr2xhhUNTo54u7K5iFr+wSMSiX6JrgTX=QJsDQ6E30uwDzQ@mail.gmail.com>
 <7vzjuvynt0.fsf@alter.siamese.dyndns.org>
 <CALWbr2x-4_QSurvScYL+2Utn=-K3Knb7Kif9SAvV_V-ZdvPfCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 14:20:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un6Vx-00061P-6x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 14:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab3FMMUK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 08:20:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60484 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753798Ab3FMMUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 08:20:04 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5DCJrpe013624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 14:19:53 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5DCJsqe012445;
	Thu, 13 Jun 2013 14:19:54 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5DCJsJX023710;
	Thu, 13 Jun 2013 14:19:54 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5DCJrLw023707;
	Thu, 13 Jun 2013 14:19:53 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <CALWbr2x-4_QSurvScYL+2Utn=-K3Knb7Kif9SAvV_V-ZdvPfCw@mail.gmail.com>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 14:19:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227724>

Le 2013-06-13 07:52, Antoine Pelisse a =C3=A9crit=C2=A0:
> On Thu, Jun 13, 2013 at 12:19 AM, Junio C Hamano <gitster@pobox.com>=20
> wrote:
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>
>>> Maybe we can display previous and next commits to provide some
>>> context. Like we do for diff.
>>> For example:
>>>
>>> $ git status
>>> # HEAD detached from ecb9f3e
>>> # Already applied 330 patches (displaying next 3):
>>> #     b170635... my_commit_message
>>> #     b170635... my_commit_message
>>> #     b170635... my_commit_message
>>> # Already applied 119 (displaying last 3)
>>> #     b170635... my_commit_message
>>> #     b170635... my_commit_message
>>> #     b170635... my_commit_message
>>
>> I think you meant one of them to be
>>
>>     # Still to be applied 119 (showing the first 3)
>>
>> instead.
>
> Of course,
>
>> I am not sure if it is worth 8 lines, especially given
>> that "git log --oneline -$n" would give you "Already applied" part
>> that is beyond what will be shown in this message easily if you
>> wanted to.  So it might be enough to show "The one that has last
>> been replayed" (aka "HEAD") and "The one you are in the middle of
>> replaying".
>
> That's very true. The piece of information that is hard to get is
> "what's left to be done".
>
> So something like this would make sense:
>
> $ git status
> # HEAD detached from ecb9f3e
> # You are currently editing a832578... my_commit_message [120/450]
> while rebasing.
> # 320 patches left to apply (showing next 3):
> #       b170635... my_commit_message
> #       b170635... my_commit_message
> #       b170635... my_commit_message
> #   (use "git commit --amend" to amend the current commit)
> #   (use "git rebase --continue" once you are satisfied with your=20
> changes)
>
> So that's 4 extra lines compared to current output. But should we=20
> make
> it a default ?
Personally I believe we should not make it the default output.

Currently, the output I'm working on is the following:

$ git status
# HEAD detached from ecb9f3e
# You are currently editing a832578 while rebasing branch 'split-rm-v7'=
=20
on 'ecb9f3e'.
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your=20
changes)

$ git status --rebase-todo
# HEAD detached from ecb9f3e
# You are currently editing a832578 while rebasing branch 'split-rm-v7'=
=20
on 'ecb9f3e'.
# Still 2 patches left to apply:
# e a832578 rm: better error message on failure for multiple files
# e fd0330b rm: introduce advice.rmHints to shorten messages
#   (use "git commit --amend" to amend the current commit)
#   (use "git rebase --continue" once you are satisfied with your=20
changes)

I'm still unsure about the name of the flag, I chose that one=20
accordingly
to .git/merge-rebase/rebase-todo

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02
