From: David Kastrup <dak@gnu.org>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 11:23:24 +0200
Message-ID: <87fvkx6c4z.fsf@fencepost.gnu.org>
References: <535C47BF.2070805@game-point.net>
	<1748955386.11457068.1398588660139.JavaMail.zimbra@dewire.com>
	<535D3DF8.4020904@game-point.net>
	<535e12389eb8d_338911e930c9c@nysa.notmuch>
	<535E1622.70608@game-point.net> <87r44h6d47.fsf@fencepost.gnu.org>
	<535E1AF6.8080609@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 14:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WekJU-0005Om-8m
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 14:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbaD1MFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 08:05:14 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:33258 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaD1MFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 08:05:13 -0400
Received: from localhost ([127.0.0.1]:60531 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WekJ6-0001Nb-3D; Mon, 28 Apr 2014 08:05:12 -0400
Received: by lola (Postfix, from userid 1000)
	id 296F9E060B; Mon, 28 Apr 2014 11:23:24 +0200 (CEST)
In-Reply-To: <535E1AF6.8080609@game-point.net> (Jeremy Morton's message of
	"Mon, 28 Apr 2014 10:10:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247306>

Jeremy Morton <admin@game-point.net> writes:

> On 28/04/2014 10:02, David Kastrup wrote:
>> Jeremy Morton<admin@game-point.net>  writes:
>>
>>> On 28/04/2014 09:32, Felipe Contreras wrote:
>>>>>> some people to is to always merge with --no-ff, that way you see the branch
>>>>>> name in the merge commit.
>>>>>
>>>>> But surely, it's recommended with Git that you try to avoid doing
>>>>> --no-ff merges to avoid commit noise?
>>>>
>>>> Nope. Different people have different needs, there's no recommendation. If
>>>> anything, the recommendation is to do a ff merge, because that's the default.
>>>
>>> That's what I'm saying.  With an ff merge, you don't get the merge
>>> commit message telling you the branch name.
>>
>> And I don't _want_ that branch name to be recorded.  The whole point of
>> a distributed version control system is that it's nobody else's business
>> how I organize my work before submitting it.
>
> Well it would be optional, so obviously you wouldn't be forced to
> share the branch name.  It's not like we're trying to "pry in" to your
> private development.  It's a way of choosing to share what you may
> consider to be useful contextual information about the commit.

But it isn't useful contextual information about the commit because it
is tied to a particular repository.

>> It is _totally_ useless information in a distributed development
>> model.  Why would or should anybody be concerned what private
>> branches some submitter has developed his patches in?
>
> Why should anybody be concerned about what commit message some
> submitter has typed in for his commit?  They could just read the
> source code to see what has changed, right?

The commit message is an integral part of a commit.  The contents of the
commit message are not tied to a particular repository.  The branch
name, however, is.

> Because the commit message is a way for the submitter to try and make
> it easier for the people looking at the commit to understand what the
> commit is doing.

The commit message is written for an audience and is independent of the
repository.  The branch name isn't.

> In the same way, a meaningful branch name may also make it easier for
> people looking at the commit to understand what it is doing,

It is nobody's business how I name my branches.  I can change the commit
message using git commit --amend, but what should happen if I rename the
branch a commit is on?

And what nightmare should occur when doing git cherry-pick?  What _is_
the originating branch of a cherry-pick?  What _is_ the originating
branch of a merge commit?  Or even of a cherry-picked merge commit?

> or what part of the application it is affecting, or what group of
> commits it is a part of.

If I have useful information to offer to the readers of a commit, it
belongs in the commit message.  Not in some involuntarily created and
leaked piece of metadata specific to my workflow and repository that
will be awfully hard to change after the fact.

-- 
David Kastrup
