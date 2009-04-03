From: P Baker <me@retrodict.com>
Subject: [RFC] GSoC Proposal v2:
Date: Thu, 2 Apr 2009 23:15:28 -0400
Message-ID: <526944450904022015n67be674dwfab5d3dc597c806b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 03 05:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpZtu-0002bg-JA
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 05:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757701AbZDCDPd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Apr 2009 23:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbZDCDPd
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 23:15:33 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:34698 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757680AbZDCDPb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2009 23:15:31 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1062556qwh.37
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wflNXK/DiLA7Z9IGhD1rj/UifTjAFqsRYlm2WYCW5FQ=;
        b=G8BHz6P8ubhDobc/wJNmh03M2wcClC+qCIcLsp/0PrcVgDSF+OJzINdtlio1vHafm7
         xRLsDIRVgahM2+NYrASnz/9TsbwFohB9ohkOm+OW6fnMJCbwnI2AA95leQIi7088v6JS
         uMNmtcGdnp/x3W6O0YsdbsfLV8CXRivGnxnUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        b=vo+Lo3ihFH5whVoW2ozSFkOtAtDh2WAYWLHwROMH50tgoOZ6gqm8AQgInvAjOr3cQ5
         ElvAg8isiXGP/dG1T9Srpf99BY1l0DpDXsMLG9L9Rvl3bm3Uw9In7+HBpYQOb7DyHjuT
         SMB4NtksYWATQQz0OsQRffgPHUrx9MtUdXeyM=
Received: by 10.220.96.213 with SMTP id i21mr1226656vcn.113.1238728528585; 
	Thu, 02 Apr 2009 20:15:28 -0700 (PDT)
X-Google-Sender-Auth: ccd3d0e0ccdafc88
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115514>

See below for a revised project application. More comments would be
appreciated. Thanks to Shawn, Dscho and Andreas for already offering
some help!

Title: git-submodule for multiple, active developers on active trees

Abstract:

	This project focuses on upgrading git-submodule to manage code created=
 in
external projects in ways that allow users to safely branch and merge t=
hat
code without loss of data or routine merge conflicts. This will incorpo=
rate
some unfinished patches, but will also include making substantial chang=
es to
the underlying code of git-submodule.

Content:

	Today, git-submodule is a solid component designed to allow developers=
 to
leverage the work of others by incorporating external code into a proje=
ct.
However, as most core developers are not heavy users of the feature its
implementation is underdeveloped [1], which creates problems when it do=
es not
act according to developers=E2=80=99 expectations based on the robustne=
ss of other git
features. This project would devote a summer of work to filling in the =
gaps so
that git-submodule contains the features necessary to fully exploit its
potential to track, update and edit external codebases incorporated int=
o a
super-project.
	Submodules are unique in their goal. As opposed to =E2=80=9Cremotes,=E2=
=80=9D which also
incorporate external code into a project, submodules maintain the disti=
nct
nature of code and separate projects=E2=80=99 histories. This is perfec=
t for the
intended nature of =E2=80=9Cembedding foreign repositories in dedicated=
 subdirectories
of the source tree.=E2=80=9D[2] For example, managing plug-ins within a=
 larger,
standalone project that depends on them is an important technique to le=
verage
others' work and shorten the development process made much more difficu=
lt by
the shortcomings of git-submodule and require laborious workarounds or
explicit manual content management.[3] Adding the most commonly request=
ed
features would give current users a desired tool, boost git=E2=80=99s c=
redibility by
providing a common feature among revision control systems, make the ado=
ption
of git for new and existing projects easier and, as a result, likely bo=
ost
git=E2=80=99s overall usage.
	This project will consist of several stages: an initial community base=
d
design review and investigation of specific requirements; specifying an=
d
documenting the planned changes; and writing, debugging and merging the=
 code
and related tests. A few specific changes that this project will likely
include are:

*move objects of submodules into base .git/ directory
**This would accomplish two goals. It would protect submodules from bei=
ng
overwritten, and implicitly, modified content from potentially being lo=
st.
This can happen when a branch with a submodule is replaced by checking =
out a
branch of a super-project that does not contain the submodule. As well,=
 this
would centralize submodule management into one location. The added bene=
fits of
fully using git's ability to branch and merge submodules makes it worth=
 adding
complexity in the .git directory to accomplish this. Basically, this wo=
uld add
support for local branches of submodules.[4]

*make git-submodule help with merging
**Instead of issuing merge conflicts on updated submodule references, t=
his
will allow submodules on default detached HEAD so that changes from the=
 local
repo can be committed without first pulling changes from the shared
repository. This made 'submodules...unsuitable for active development'.=
[5]
Clearly losing this kind of functionality impairs the overall usability=
 of git
and should be fixed. Essentially, this would enable branch and merging =
between
local and remote repositories.

*protect changes in local submodules when doing =E2=80=9Cgit submodule =
update=E2=80=9D
**This is similar to the previous point, in that changes need to be pro=
tected
or merged or warnings issued when updating the submodule. The potential=
 to
lose work with no warning is a big no-no.

*prevent unintentional super-project push without previous submodule pu=
sh
**A common mistake made when using git-submodule is to commit and push =
the
super-project, without first pushing the latest commits in the submodul=
e. This
problem will require some brainstorming to find a good solution.

*make git submodules easy to remove
** Adding a submodule has UI, removing one should as well.[6] There sho=
uldn't
have to be a tutorial on how to do it.[7]

These major changes are in addition to some bug-fixes which include: gi=
t
submodule summary should output to the pager by default; and finishing =
the
implementation of git submodule recurse [8]. The tentative timeline is:

End of May =E2=80=93 Conclusively finish the public discussion regardin=
g
features to be added to git-submodule
Beginning of June =E2=80=93 work on git submodule remove as a way to be=
come
familiar with the code and accomplish an "easy" first win.
Middle of June =E2=80=93 move objects of submodules into base .git/ dir=
ectory.
This should take up the majority of the month and will likely
constitute the major portion of contributed code for the summer.
Middle of July =E2=80=93 make submodules deal with updated references, =
this is
the second key component of upgrading submodules for use on active
trees.
End of July =E2=80=93 protect changes in local submodules during =E2=80=
=9Cgit
submodule update=E2=80=9D. This will interact with the previous work, a=
nd
might implicitly be solved by it, if not, it
Middle of August =E2=80=93 if time permits, finish git submodule recurs=
e.

This timeline should allow adequate flexibility while establishing dead=
lines
that ensure that the project will be completed in a timely and efficien=
t
manner. Most development will need to occur within git-submodules.sh, w=
ithout
changing much plumbing, however, other files might be affected by more
substantial changes.
	While git-submodule is stable and operational, it has not seen much ch=
ange
beyond bug-fixes. After reaching its current feature complete status, t=
he last
time a feature of any novelty was included in a public release was Augu=
st
2008. However, some work has already been started by different contribu=
tors
who have started patches, but not seen their inclusion into a public
release.[9][10] The project will incorporate and conclude these patches=
=2E
	At the end of the project, one metric by which to evaluate its success=
 will
be its acceptance in online communities. The final goal is to make git =
a
top-tier version control system in its management of external code
repositories. My main usage of git started as an intern when managing a=
 summer
project that had many of the requirements that make git-submodule probl=
ematic:
built in a web application framework and dependent on plug-ins, some of=
 which
were managed in SVN. Even though the Ruby on Rails community has popula=
rized
the use of git-submodule to manage plug-ins, and quite a bit has been w=
ritten
on the topic, a significant portion of explanations end either in frust=
ration
or convoluted workarounds. Personally, the problems and confusing natur=
e of
git-submodule led me to give up on it altogether, and manage the code a=
nd
updates to it by hand. The need for improvement is clearly indicated by=
 the
frequency with which improvements are requested (for example, in the Gi=
t 2009
User Survey responses [11]).
	I currently am finishing my sophomore year as an Electrical Engineer a=
t the
University of Pennsylvania (and dual-majoring in the Wharton School of
Business). I started to develop professionally when I took a year off b=
etween
high school and college to work for a small firm in Silicon Valley, Cal=
ifornia
developing diagnostic imaging software for quality assurance and resear=
ch on
their products. Last summer I developed a Ruby on Rails-based engine to=
 test
user-designed investment strategies for QED Benchmark, a boutique hedge=
 fund.

[1]http://article.gmane.org/gmane.comp.version-control.git/79167
[2]http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
[3]http://flavoriffic.blogspot.com/2008/05/managing-git-submodules-with=
-gitrake.html?showComment=3D1210125780000#c1605130977296198852
[4]http://marc.info/?l=3Dgit&m=3D121726233001151&w=3D2
[5]http://flavoriffic.blogspot.com/2008/05/managing-git-submodules-with=
-gitrake.html?showComment=3D1211380200000#c3897235118548537475
[6]See http://pitupepito.homelinux.org/?p=3D24, for an example of how
the current process is hard.
[7]http://git.or.cz/gitwiki/GitSubmoduleTutorial
[8]http://article.gmane.org/gmane.comp.version-control.git/69834
[9]http://marc.info/?l=3Dgit&m=3D121676896924019&w=3D2
[10]http://article.gmane.org/gmane.comp.version-control.git/88724/match=
=3Dgitmodules
[11]

Thanks,

P Baker
