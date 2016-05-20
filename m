From: enrico <enrico.guiraud@gmail.com>
Subject: Re: more novice-friendly behaviour of =?utf-8?b?YGdpdA==?= add =?utf-8?b?LXBg?=
Date: Fri, 20 May 2016 15:32:54 +0000 (UTC)
Message-ID: <loom.20160520T172851-785@post.gmane.org>
References: <loom.20160520T150517-391@post.gmane.org> <xmqq7feohirb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 17:33:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3mQT-0008Cm-6V
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 17:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754913AbcETPdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 11:33:16 -0400
Received: from plane.gmane.org ([80.91.229.3]:39752 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936AbcETPdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 11:33:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1b3mQE-00080K-VY
	for git@vger.kernel.org; Fri, 20 May 2016 17:33:07 +0200
Received: from nancy.w2kroot.uni-oldenburg.de ([134.106.116.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2016 17:33:06 +0200
Received: from enrico.guiraud by nancy.w2kroot.uni-oldenburg.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2016 17:33:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.106.116.48 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:44.0) Gecko/20100101 Firefox/44.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295176>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> enrico <enrico.guiraud <at> gmail.com> writes:
> 
> > Hello all,
> > I have encountered a couple of non-necessary difficulties when editing a
> > patch during a `git add -p`.
> >
> > Firstly, the help message says
> > "To remove '-' lines, make them ' ' lines (context)."
> > which is a bit confusing because that "them" refers to '-', not to 'lines'.
> 
> I think that sentence refers to a line line this in a patch:
> 
>     -This is what the line used to be
> 
> as a '-'-line.  A line that does not change between preimage and
> postimage have SP instead of '-' at the beginning, and the sentence
> seems to refer to it as a ' '-line.  So from that reading, "turning
> '-'-lines that you do not want to loes into ' '-lines" is perfectly
> sensible phrasing.

I agree it is, and that little dash would definitely make the message less
ambiguous.
Git has a way to "explain itself" to its users so that they can become
better as they use it, and these sort of messages play a very important part
in this learning process.

> 
> In any case, "edit" is about giving a low-level access and precise
> control to people who are familiar with (1) what each line of "diff"
> output means and (2) what is done to them by "patch" (rather, in
> Git's context, "apply").
> 
> I agree with you that "edit" mode is a too-advanced tool for those
> who are not comfortable with these two things.  A solution would
> however not be to modify "edit" mode (which would affect those who
> are prepared to and want to use the "low-level access and precise
> control" to their advantage), but to introduce an easier-to-use,
> and perhaps a bit limited for safety, mode for those who are not the
> target audience for "edit" mode.
> 
> The "split" subcommand to split the hunk before applying was an
> attempt to go in that direction; it never allows you the user to
> make an arbitrary change to corrupt the patch and make it unusable.
> Perhaps you can mimick its spirit and come up with a new "guarded
> edit" command?
>

I am not sure we are talking about the same issue. I am not pointing out
that git is unsafe to less-than-very-expert users.
Much more trivially, I am saying that the current behaviour of the "edit"
mode, when coupled with hunk splitting, is needlessly frustrating (because
of the issue described in the link I provided in my previous message).
That's why I would argue that git would help wanna-be-experts better if
it told them, in some way, that editing after splitting is generally a bad idea.
Advanced users would not be bothered by this
warning/lack-of-edit-after-splitting because, I think, they don't do it
anyway. They already know it
is a pain, so they either split or edit.
