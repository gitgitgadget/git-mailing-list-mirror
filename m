From: Sergei Organov <osv@javad.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 23:28:38 +0300
Message-ID: <874pg73u6h.fsf@osv.gnss.ru>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 21:29:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKBP-0006tO-Ht
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbXJaU2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 16:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXJaU2q
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:28:46 -0400
Received: from javad.com ([216.122.176.236]:3169 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521AbXJaU2p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:28:45 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id l9VKShm89216
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 20:28:44 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InKB4-0000Et-5K
	for git@vger.kernel.org; Wed, 31 Oct 2007 23:28:38 +0300
In-Reply-To: <20071031195702.GB24332@atjola.homenet> (=?utf-8?Q?=22Bj?=
 =?utf-8?Q?=C3=B6rn?= Steinbrink"'s message of "Wed\, 31 Oct 2007 20\:57\:02
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62864>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:
> On 2007.10.31 22:39:06 +0300, Sergei Organov wrote:
>> Hello,
>>=20
>> I've made my first attempt at tracking my changes to upstream git
>> repository using git-fetch/git-rebase workflow. I did three commits =
to
>> my master branch, and then upstream incorporated two of them in slig=
htly
>> modified form, so that some conflicts are to be expected. I did
>> git-fetch followed by git-rebase, and finally have got the end resul=
t I
>> hoped for, but there were some confusion along the way. I think I'd =
post
>> the log of the session here along with my thoughts so that an intere=
sted
>> person could see how it works for a newbie (my thoughts and non-git
>> actions at the time of rebasing are marked with 'me>' prefix):
>>=20
>> $ git fetch
>> [...]
>> $ git rebase origin
>> First, rewinding head to replay your work on top of it...
>> HEAD is now at 9c51414... Merge branch 'maint' into HEAD
>>=20
>> Applying Fix a typo.
>>=20
>> Wrote tree f5b2feefc021486eae9d2d84c69e0d6ead027a9d
>> Committed: 983e907b1360c17c7ac925d6035d82cc7243f406
>>=20
>> Applying Use new syntax (-m option) for git-merge.
>>=20
>> error: patch failed: Documentation/core-tutorial.txt:878
>> error: Documentation/core-tutorial.txt: patch does not apply
>> Using index info to reconstruct a base tree...
>> Falling back to patching base and 3-way merge...
>> Auto-merged Documentation/core-tutorial.txt
>> CONFLICT (content): Merge conflict in Documentation/core-tutorial.tx=
t
>> Failed to merge in the changes.
>> Patch failed at 0002.
>>=20
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase --sk=
ip".
>> To restore the original branch and stop rebasing run "git rebase --a=
bort".
>>=20
>> me> Nice, this conflict is expected.
>> me> Editing Documentation/core-tutorial.txt to resolve the
>> me> conflict... Conflict is resolved so that the working file matche=
s
>> me> upstream version.
>>=20
>> $ git rebase --continue
>> You must edit all merge conflicts and then
>> mark them as resolved using git add
>>=20
>> me> Nice helpful message, -- need to do git-add
>>=20
>> $ git add Documentation/core-tutorial.txt
>> $ git rebase --continue
>>=20
>> Applying Use new syntax (-m option) for git-merge.
>>=20
>> No changes - did you forget to use 'git add'?
>>=20
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase --sk=
ip".
>> To restore the original branch and stop rebasing run "git rebase --a=
bort".
>>=20
>> me> What?! I just did the git-add! Moreover, before I did git-add, t=
he
>> me> error was different and helpful. Something went wrong?=20
>> me> Well, it's unlikely, but maybe I made a mistake of not specifyin=
g
>> me> the 'origin'?
>>=20
>> $ git rebase --continue origin
>>=20
>> Applying Use new syntax (-m option) for git-merge.
>>=20
>> No changes - did you forget to use 'git add'?
>>=20
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase --sk=
ip".
>> To restore the original branch and stop rebasing run "git rebase --a=
bort".
>>=20
>> me> No luck :( A few seconds of thinking... Hmm... no-op patch, do I
>> me> need to skip it? Let's try the --skip:
>>=20
>> $ git rebase --skip
>>=20
>> Applying Fix SYNOPSIS.
>>=20
>> error: patch failed: Documentation/git-merge.txt:10
>> error: Documentation/git-merge.txt: patch does not apply
>> Using index info to reconstruct a base tree...
>> Falling back to patching base and 3-way merge...
>> Auto-merged Documentation/git-merge.txt
>> CONFLICT (content): Merge conflict in Documentation/git-merge.txt
>> Failed to merge in the changes.
>> Patch failed at 0003.
>>=20
>> When you have resolved this problem run "git rebase --continue".
>> If you would prefer to skip this patch, instead run "git rebase --sk=
ip".
>> To restore the original branch and stop rebasing run "git rebase --a=
bort".
>>=20
>> me> Aha, that's it! But why git didn't just skip the no-op patch
>
> It wasn't a no-op patch. It had conflicts which you resolved to the
> upstream version and _then_ you had a no-op.

Yes, and that's the problem. Why 'git --continue' didn't just skip this
patch that *already became no-op* after conflict resolution and forced
me to explicitly use 'git --skip' instead?

This forces one to use 'git --skip' if the patch happens to become a
no-op after conflict resolution, and 'git --continue' otherwise. Why
this complication?

--=20
Sergei.
