From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 11:18:10 -0700
Message-ID: <7v7iblsnfh.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:19:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBax-0003dS-3x
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbYGPSST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbYGPSST
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:18:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbYGPSSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:18:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AA1D225CD;
	Wed, 16 Jul 2008 14:18:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 48E07225CC; Wed, 16 Jul 2008 14:18:12 -0400 (EDT)
In-Reply-To: <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 16 Jul 2008 13:53:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F3CA238-5363-11DD-9716-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88707>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 7/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>  Am I the only one who deems teaching plumbing to users ("I like it raw!
>>  So I teach it the same way!") harmful?
>
> I believe the only way you can get away with such a simple learning
> sequence is if your workflow is as simple as that you seem to
> describe: everyone has push access to the central 'master'.
>
> That works (and mostly just as well as any other "supposedly easy"
> VCS, like svn), but because git's power is so tempting, almost
> nobody's real-life repository actually works like that.
>
> At the very least, there will be branches.  And where there are
> branches, there's merging.  And with merging comes merge conflicts.

Well, you are wrong.  Even when people work only with a single branch
'master', once you have more than one repository involved, there's already
merging.  Dscho just described how he would guide new people into the
process without going into the details in that message, by the time his
audiences need merge conflict resolution they are already comfortable with
the index.

>        git diff :{1,3}:path/to/filename
>
> Which is a great command, but svn definitely makes it easier to do the
> same thing.

I've never seen anybody who finds "diff :{1,3}:path" *useful*.

Well, if you are coming from SVN or CVS where a merge is just a large goo
of everything that happened on a side branch squashed into one, perhaps it
might look useful.

What you should learn and teach instead is:

	git log -p --merge

This shows individual changes from the commits involved in the conflict
with rationale (of course your committers must be disciplined enough to
write usable commit log messages for you to take full benefit of this).
Add path/to/filename if you want to process one path at a time.  Also
adding --left-right to the command line may make it more understandable if
you are merging two histories, both of which are from other people, and
you do not know which commit is from which side of the merge.

> Even if you have a repo with widespread push access, git's log looks
> annoying compared to svn because of all the merge commits.  That's a
> primary reason why rebase was invented, of course.

Please don't talk nonsense if you do not know history.  I invented rebase
primarily because I wanted to help e-mail based contributors.  There is
nothing about merge avoidance to it.

You can skip merges with "git log --no-merges", just in case you didn't
know.

I won't comment on the remainder but that is not because I agree with
anything you said there ;-)
