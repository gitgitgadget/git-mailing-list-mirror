From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 13:49:08 -0800
Message-ID: <7v3b77y52j.fsf@assigned-by-dhcp.cox.net>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<emhdir$he9$1@sea.gmane.org> <7vejqrznwo.fsf@assigned-by-dhcp.cox.net>
	<200612222156.21215.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:49:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxsGQ-0003U6-Op
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbWLVVtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 16:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbWLVVtK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:49:10 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40957 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbWLVVtJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 16:49:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222214909.VEOE15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 16:49:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1xoS1W00L1kojtg0000000; Fri, 22 Dec 2006 16:48:26 -0500
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200612222156.21215.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 22 Dec 2006 21:56:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35226>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>>>> Possibilities:
>>>>=20
>>>> =A0(1) Forget about that "protection" business. =A0If you do not
>>>> =A0 =A0 =A0want mistakes, use 'branch.*.merge' but otherwise we wi=
ll
>>>> =A0 =A0 =A0continue to follow the good old "first set of branches"
>>>> =A0 =A0 =A0rule.
>>>
>>> What about marking default branch to merge explicitely using
>>> "Merge:" in remotes/<repo>, or remote.<name>.merge?
>>=20
>> Sorry, how is that an improvement over the current branch.*.merge?
>> and how would that help not breaking existing setups?
>
> I meant that in addition to forgetting about "protection" business.
> This would be intermediate improvement over old behavior.

I do not think so.  It does not talk about "when on my local
branch X do this", and applies to all pulls from the named
remote.  Then longstanding rule of merging the first set of
branches is just fine and as expressive.  You see them the first
in the list, and you already know they somehow matter more.

On the other hand, I think Santi's branch.*.merge (done in
commit 5372806a) _was_ a real improvement.

> Perhaps make "protection" business optional, default to on for
> new users?

Now the question is how you would tell "new users".

The possibility (2) is not even good enough, because even old
timers work in a newly cloned repositories.
