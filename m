From: Thomas Rast <tr@thomasrast.ch>
Subject: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sat, 19 Oct 2013 08:09:33 +0200
Message-ID: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Straub <bs@github.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Thomas Gumm
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 19 08:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXPjV-0004bB-7v
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 08:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab3JSGJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Oct 2013 02:09:49 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:35702 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966Ab3JSGJs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Oct 2013 02:09:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 791DC4D650A;
	Sat, 19 Oct 2013 08:09:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FejVHrspDWTj; Sat, 19 Oct 2013 08:09:35 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B866D4D64C1;
	Sat, 19 Oct 2013 08:09:32 +0200 (CEST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236385>

[Unfortunately libgit2 no longer has a mailing list.  I put an arbitrar=
y
group of libgit2 contributors in the Cc list.]


Previous Episodes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Git participated in Google Summer of Code (GSoC) 2007-2012, but did not
participate in 2013 based on discussion in February [1].  At Git-Merge
in Berlin there was a discussion round [2] that this post attempts to
summarize as a basis for further discussion and (hopefully)
participation in GSoC'14.

Much sooner than in previous years, Google has already confirmed that
GSoC'14 will in fact happen [3].

Note that while mistakes herein are mine, many ideas and opinions
aren't.  This really tries to be a summary.  Please flame >/dev/null,
not me.


GSoC 2007-2012
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Data presented in [2] shows that roughly half of the projects resulted
in merged code, and roughly half of the students remained with the Git
community significantly after the end of GSoC.  (The sets aren't
exactly the same.)

A feeling expressed in [1], [2] and elsewhere is that this is not
enough value for money and effort.  We should therefore discuss how to
improve.

Note that everyone seems to agree that libgit2 had a much better run
in GSoC than core git.  There seems to be less agreement on what
exactly they do differently, though.


Theories
=3D=3D=3D=3D=3D=3D=3D=3D

These are the hypotheses that I have heard (mostly in [1] and [2]) as
to what is bad about Git's prior GSoC participations.

* Aiming far too high, focusing on cool/shiny projects with a large
  impact.  This also affects the students, who tend to cluster around
  the largest, shiniest project suggestions.

* Diminishing returns: Git is too mature, with little low-hanging
  fruit left, making such projects harder

* Projects are too political, progress depending on non-technical
  arguments

* Our mentors suck on various axes, notably not supporting students
  enough in things that matter:
  - smooth interaction with community
  - ensure fast iteration/short cycles
  - navigating the code base

* Scope creep: projects tend to get blocked on some bigger
  refactoring/restructuring task that was not in the original proposal


Ideas and Suggestions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

These are mostly from [2].  There were some suggestions that we learn
from Matthieu Moy's very successful student projects (eg. [4]).

* View GSoC much more as a lot of work than free labor

* Break projects into smaller, easier tasks
  - They should individually be simple, quick things if the mentor did
    them.
  - Should be parallelizable so students don't have to block on reviews=
=2E

* Mentoring improvements:
  - Always have a co-mentor
  - Focus on social aspects (who to Cc, etc.)
  - Nominate separate "review mentors" to ensure fast review cycles

* Define explicit criteria
  - what we want to do
  - how we judge code and social interactions
  - when to fail the students

* Have students review some patches


=46urther steps
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* Discuss :-)

  And then apply this hard-won knowledge systematically.  In
  particular I think it wouldn't hurt to keep the project proposals
  out of this thread until we have agreed on goals/standards to
  measure them against.

* Does libgit2 want to remain under the Git umbrella, or participate
  on its own?

* Figure out the wiki situation.  In previous years the project
  proposals and other important information were hosted at k.org [5] an=
d
  github wikis [6].  Other options were floated, such as an official
  wiki hosted by github.  (This is somewhat of a contentious issue that
  spans beyond GSoC.)

* Find an org admin and backup.  In previous years Shawn and Peff did
  this.  Would you do it again?

* Gather a list of potential mentors.



[1]  http://thread.gmane.org/gmane.comp.version-control.git/216485
[2]  http://www.youtube.com/watch?v=3DXP4CxUkBPSQ=E2=80=8E
[3]  http://googleblog.blogspot.ch/2013/10/50-million-lines-of-code-and=
-counting.html
[4]  http://thread.gmane.org/gmane.comp.version-control.git/221159
[5]  https://git.wiki.kernel.org/index.php/SoC2011Projects
     similarly for previous years
[6]  https://github.com/peff/git/wiki/SoC-2012-Ideas
     https://github.com/trast/git/wiki/SoC-2013-Ideas

--=20
Thomas Rast
tr@thomasrast.ch
