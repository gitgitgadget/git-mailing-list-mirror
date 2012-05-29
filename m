From: "Steven E. Harris" <seh@panix.com>
Subject: How does Git's maintenance policy handle topics that don't start from "master?"
Date: Tue, 29 May 2012 16:33:45 -0400
Organization: SEH Labs
Message-ID: <m21um2682e.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 22:34:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZT7G-0002VA-6M
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 22:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab2E2UeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 16:34:01 -0400
Received: from plane.gmane.org ([80.91.229.3]:49638 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754386Ab2E2UeA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 16:34:00 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SZT76-0002Pv-N5
	for git@vger.kernel.org; Tue, 29 May 2012 22:33:56 +0200
Received: from c-24-23-122-157.hsd1.pa.comcast.net ([24.23.122.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2012 22:33:56 +0200
Received: from seh by c-24-23-122-157.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2012 22:33:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-122-157.hsd1.pa.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
Cancel-Lock: sha1:/Gmu3cqgyNb2D6CbdjHFOK73l24=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198758>

I've read the /Addendum to "MaintNotes"/ document=C2=B9 several times i=
n the
last few years, but in the process of trying to employ the policy with
my current team, our progress is stuck on a case that isn't addressed b=
y
the policy -- directly, anyway.

In the policy section "Handle the remaining patches," the first clause
reads as follows:

,----[ First case for remaining patches ]
| Anything unobvious that is applicable to 'master' (in other
| words, does not depend on anything that is still in 'next'
| and not in 'master') is applied to a new topic branch that
| is forked from the tip of 'master'.  This includes both
| enhancements and unobvious fixes to 'master'.
`----

It addresses topics that can be built on top of the "master" branch,
these topics not depending on anything only available outside the
"master" branch, such as in the "next" branch. This policy is focusing
on the receiver and integrator of patches, rather than the author, but
it's not hard to infer that an author should start his work from the
"master" branch in order for his patches to be eligible for treatment b=
y
this clause.

What about the case where an author started his work from the "next"
branch instead? He may have submitted an earlier batch of work that's
still cooking in "next," and now he needs to build something else that
can take advantage of that earlier work. It's clear that if he starts
from "next" and relies on that earlier work, then his later work is not
independent and cannot possibly graduate to the "master" branch unless
and until his earlier work graduates too.

Is the Git policy on such dependency simply, "Don't do that?"

Consider a situation where the earlier topic branch's contribution
cooking in "next" is looking good and everyone is feeling confident tha=
t
it's going to graduate, and our poor author /needs/ to get started on
his next task that would make use of the earlier work. If he does start
his new topic branch from "next" -- or maybe starts it from his earlier
topic branch instead -- what will go wrong later? Is there a part of th=
e
policy that addresses this case that I missed?


=46ootnotes:=20
=C2=B9 http://www.kernel.org/pub/software/scm/git/docs/v1.7.10.1/howto/=
maintain-git.txt

--=20
Steven E. Harris
