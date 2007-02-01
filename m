From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-blame.el
Date: Thu, 01 Feb 2007 14:21:29 +0100
Message-ID: <87veimxbc6.fsf@morpheus.local>
References: <87iren2vqx.fsf@morpheus.local> <20070201131213.GB11611@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 14:22:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCbtu-0001YM-GD
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 14:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422862AbXBANWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Feb 2007 08:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbXBANWv
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 08:22:51 -0500
Received: from main.gmane.org ([80.91.229.2]:60213 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422862AbXBANWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 08:22:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCbt2-000261-SD
	for git@vger.kernel.org; Thu, 01 Feb 2007 14:22:00 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 14:22:00 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 14:22:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:sZRnrqprcODB05IX77HUVNdNHDA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38350>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-01-31 14:04:06 +0100, David K=C3=A5gedal wrote:
>
>> Here's another version of git-blame.el that automatically tries to
>> create a sensible list of colors to use for both light and dark
>> backgrounds. Plus a few minor fixes.
>
> I've tried it, like the concept of in-buffer blame and the pretty
> colors, and have a few comments and suggestions:
>
>   1. For some files, but not all, emacs is unresponsive (and consumes
>      lots of CPU) right after git-blame-mode is activated. Once
>      git-blame has finished, it becomes responsive again, but this
>      kind of defeats the whole "incremental" idea.
>
>      This is most easily seen by holdnig down Ctrl+N or similar, to
>      make the cursor move constantly.

Don't know why this happens.  I haven't seen it myself.

>   2. Getting to see the sha1 of the commit is not so useful when it
>      can't be selected for copy-pasting. Maybe a keyboard shortcut fo=
r
>      "copy-sha1-to-kill-ring"?

Sure.  It's a trivial addition.

>   3. Even after I've edited a line, or added a new line, they continu=
e
>      to be attributed to the same existing commits. They should eithe=
r
>      have no attribution, or possibly just "local edit" or something.
>      I seem to recall this kind of functionality for git-blame being
>      discussed very recently?

I saw it was discussed, but I don't think it was added.  Currently, it
probably makes most sense to verify that the file hasn't been
modified, and then switch to read-only mode while viewing the blame.

>   4. It would be nice with a keyboard shortcut that (in a new buffer)
>      printed more details about the commit under the cursor, kind of
>      like the output from git-log. (Having this available would
>      obviate the need for (2).)
>
>   5. It would be nice with a keyboard shortcut for displaying the
>      commit under the cursor in gitk. (For extra points: successive
>      uses of this command should reuse the same gitk window if it's
>      still open.)

This is almost as trivial as 2, since the hash is available, you can
simply run shell-command.

>   6. It would be nice with a keyboard shortcut for displaying (in a
>      separate buffer) the diff to that file introduced by the commit
>      under the cursor. This could be combined with (3) by having
>      commit details followed by diff.

As in "git log -p", you mean?

> Oh, and try to have it done by Monday. ;-)

Sorry Kalle.  I won't have any more spare cycles until next week.

--=20
David K=C3=A5gedal
