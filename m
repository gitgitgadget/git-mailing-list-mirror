From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH jh/notes-merge-in-git-dir-worktree] fixup! t3310 on Windows
Date: Wed, 14 Mar 2012 13:56:44 +0100
Message-ID: <CALKQrgdWZM959OyrEp+WCCehczZmMA3K8_RAcf23aAczKBCfvA@mail.gmail.com>
References: <1319438176-7304-3-git-send-email-pclouds@gmail.com>
	<1331563647-1909-1-git-send-email-johan@herland.net>
	<1331563647-1909-2-git-send-email-johan@herland.net>
	<4F60593A.5070106@viscovery.net>
	<CALKQrgdjYvkSBn8UORSsZecSVyhJbfU5tjU0hPJOYn1OMVxMyw@mail.gmail.com>
	<4F60882E.90303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, david@tethera.net,
	pclouds@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 13:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7nl8-0007KU-HY
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 13:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121Ab2CNM4t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 08:56:49 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:60974 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab2CNM4t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Mar 2012 08:56:49 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1S7nl1-0000R4-Fr
	for git@vger.kernel.org; Wed, 14 Mar 2012 13:56:47 +0100
Received: by eaaq12 with SMTP id q12so804594eaa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 05:56:45 -0700 (PDT)
Received: by 10.50.85.131 with SMTP id h3mr11500963igz.39.1331729804538; Wed,
 14 Mar 2012 05:56:44 -0700 (PDT)
Received: by 10.43.52.6 with HTTP; Wed, 14 Mar 2012 05:56:44 -0700 (PDT)
In-Reply-To: <4F60882E.90303@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193102>

On Wed, Mar 14, 2012 at 12:59, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> Am 3/14/2012 12:39, schrieb Johan Herland:
>> On Wed, Mar 14, 2012 at 09:39, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
>>> From: Johannes Sixt <j6t@kdbg.org>
>>>
>>> On Windows, a directory cannot be removed while it is the working
>>> directory of a process. "git notes merge --commit" attempts to remo=
ve
>>> .git/NOTES_MERGE_WORKTREE, but during the test the directory was st=
ill
>>> "occupied" by the shell. Move the command out of the subshell to re=
lease
>>> the directory.
>>>
>>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>>> ---
>>> =C2=A0Feel free to squash this into 1/2.
>>>
>>> =C2=A0t/t3310-notes-merge-manual-resolve.sh | =C2=A0 =C2=A04 ++--
>>> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-=
merge-manual-resolve.sh
>>> index d6d6ac6..6351877 100755
>>> --- a/t/t3310-notes-merge-manual-resolve.sh
>>> +++ b/t/t3310-notes-merge-manual-resolve.sh
>>> @@ -565,9 +565,9 @@ test_expect_success 'switch cwd before committi=
ng notes merge' '
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd .git/NOTE=
S_MERGE_WORKTREE &&
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "foo" >=
 $(git rev-parse HEAD) &&
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "bar" >> $(=
git rev-parse HEAD) &&
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git notes merge =
--commit
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "bar" >> $(=
git rev-parse HEAD)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0) &&
>>> + =C2=A0 =C2=A0 =C2=A0 git notes merge --commit &&
>>
>> NAK. This defeats the entire purpose of this test. The bug that we'r=
e
>> trying to solve is exactly the situation where the user has changed
>> into the .git/NOTES_MERGE_WORKTREE directory, and invokes 'git notes
>> merge --commit' from within. We need to find a different solution fo=
r
>> this on Windows. Maybe we should just abort 'git notes merge
>> --commit/--abort' if the current directory is within
>> .git/NOTES_MERGE_WORKTREE (and we're on Windows)?
>
> Isn't this an indication that something *VERY* wrong is happening? Ho=
w do
> you explain to POSIX people that you have just pulled the rug unter t=
heir
> feet?
>
> $ git notes merge --commit
> $ git notes
> fatal: Unable to read current working directory: No such file or dire=
ctory

True.

> I doubt that the use-case that is tested here makes sense.

As David wrote, the use case is likely to pop up among regular users.
We can't simply ignore it.

> Or .git/NOTES_MERGE_WORKTREE should not be removed. Would it be an op=
tion
> to clear it out only when it is needed, right before it is filled aga=
in?

Maybe, but then we wouldn't be able to warn or abort in the case where
there is a previous unfinished notes merge, and the user tries to
start a new notes merge. Instead, we'd silently overwrite the previous
unfinished notes merge...

Maybe it's better to simply detect if cwd is inside
=2Egit/NOTES_MERGE_WORKTREE, and then abort, telling the user to chdir
out before trying again?


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
