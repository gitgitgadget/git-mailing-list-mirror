From: linux@horizon.com
Subject: Re: Adding Git to Better SCM Initiative : Comparison
Date: Sun, 13 Jan 2008 13:42:06 -0500
Message-ID: <20080113184206.22452.qmail@science.horizon.com>
References: <20080113150541.21883.qmail@science.horizon.com>
 <vpqd4s5ycvv.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
To: Matthieu.Moy@imag.fr, linux@horizon.com
X-From: git-owner@vger.kernel.org Sun Jan 13 19:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JE7nr-0001Lr-5p
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 19:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbYAMSm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 13:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753301AbYAMSm5
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 13:42:57 -0500
Received: from science.horizon.com ([192.35.100.1]:10743 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753213AbYAMSm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 13:42:56 -0500
Received: (qmail 22453 invoked by uid 1000); 13 Jan 2008 13:42:06 -0500
In-Reply-To: <vpqd4s5ycvv.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70404>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> linux@horizon.com writes:
>> "Rename support" is a kludge to make a fundamentally broken model
>> less painful.
>
> It's not.
>
> Git _has_ rename support. Look into the code, you'll find some code
> whose purpose is to manage renames. And _no_, rename support is not
> just a direct consequence of commits being atomic.
>
> Atomic commit help, but if you do nothing else, moving a file and then
> trying to merge will fail for example. So, in addition to atomic
> commits, you have at least 3 options : explicit file ID (bzr),
> recording renames (hg), or detecting renames after-the-fact (git).

Please forgive me for not mentioning that part.  Yes, there are
interesting things to do with renames, and git is doing them, but I
skipped over them because they don't have much to do with the better-scm
definition of the feature:

"Does the system support moving a file or directory to a different
location while still retaining the history of the file?"

You can try to interpret it so it makes sense, but the question is
basically assuming that the history is attached to the file rather than
that the file is attached to the history.

With the latter model, the question is almost silly.  Even with the very
primitive version of git that Linus used to make v2.6.12-rc2 with none
of that fancy code, you can rename a file and git retains the history.
Period.  The qualification "of the file" doesn't even make sense.

As Linus has observed in the past, git does lots of fancy stuff to follow
the history of the code that's *in* the file, but the idea is that a file,
per se, doesn't have a history or even an identity.

You can ask about the history of a file *name*, or of a file's *contents*,
but if not that, what exactly is this "file" thing you want the history of?

Once you've answered that, you can then figure out if the answer to
the question based on whether the file has a history to retain in the
first place.


There are interesting questions about renames that you could ask, but
better-scm isn't asking questions like "can you resolve merges properly
after renaming a file on one branch?"  Maybe I'm being uncharitable, but I
can't help but read the question as asking if the system has a workaround
for a well-known CVS problem.  And one honest answer is "no, there's no
workaround; git doesn't suffer from the problem in the first place."
