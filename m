From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 12:55:19 -0700
Message-ID: <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Namit Bhalla <namitbhalla@yahoo.com>, Dave <dag@cray.com>,
	Seth Robertson <in-gitvger@baka.org>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 21:55:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKEUn-0000Td-FM
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 21:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab2DQTzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 15:55:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59092 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab2DQTzT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 15:55:19 -0400
Received: by yhmm54 with SMTP id m54so3313571yhm.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2Y53MzhcncLM2VDTnPc0+SiTWtBa6jwW+60DwU4lfT4=;
        b=xQBnCnsNC23PRglLZfj2XDZS2R+zT0zetsLaqjcSq0NYqa8BvVdR0ST0BgzIUkHLgv
         fTMbDt/vMF8bEl1qvmKRA1VwqKNkgULLL3Pip1QJtdi8mZVgnOllI2n4imTUn3cRbiGk
         or6QXyOcpWIWHemQNhQmGhLk5oYKmyefUAAtglvXrcez/z5f4QZp9ETxsPQ5bjiFkZZY
         PEALgNwl9dUAym8j0sRtIvQroe1rTEHFIGOecYqQaoVj7KgiEGZdP4WF6Cb8fu1n98f1
         fuAhVdVNOntFQpL6ZHjRKpHVX0hROmD0F1abfvfTRydNoSAv8Dq9mM7R7AreGUGKTddZ
         u7Pg==
Received: by 10.236.175.105 with SMTP id y69mr8216245yhl.83.1334692519149;
 Tue, 17 Apr 2012 12:55:19 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 17 Apr 2012 12:55:19 -0700 (PDT)
In-Reply-To: <201204171837.q3HIbbcW013784@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195796>

On 17 April 2012 11:37, Seth Robertson <in-gitvger@baka.org> wrote:
> In message <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=3DAje0TQ@mai=
l.gmail.com>, Hilco Wijbenga writes:
>
> =C2=A0 =C2=A0On 16 April 2012 13:08, =C2=A0<dag@cray.com> wrote:
> =C2=A0 =C2=A0> Jakub Narebski <jnareb@gmail.com> writes:
> =C2=A0 =C2=A0>> Put reusable library in its own repository, and use s=
ubmodules to link
> =C2=A0 =C2=A0>> it up to project-a and project-b repositories.
>
> =C2=A0 =C2=A0If you really have only one or two libraries then submod=
ules will work
> =C2=A0 =C2=A0just fine but if you have quite a few (we had around 50 =
when we moved
> =C2=A0 =C2=A0away from submodules) you will find it pretty much unwor=
kable. [...]
> =C2=A0 =C2=A0Branches are per submodule but you want them for all
> =C2=A0 =C2=A0submodules. You might want to look into git-slave if you=
 want to
> =C2=A0 =C2=A0go this route.
>
> =C2=A0 =C2=A0In general, I do not think the blanket statement "one re=
po per
> =C2=A0 =C2=A0project" is good advice. If projects depend on each othe=
r they should
> =C2=A0 =C2=A0be in the same repo. At least with the current support i=
n GIt for
> =C2=A0 =C2=A0including separate projects. Please note that I'm not di=
sagreeing with
> =C2=A0 =C2=A0the notion "one repo per project" itself. It's just not =
supported well
> =C2=A0 =C2=A0enough to be feasible if you have a fairly large group o=
f projects
> =C2=A0 =C2=A0that depend on each other.
>
> As you mentioned, this is exactly the environment that gitslave was
> designed for. =C2=A0It provides the flexibility to work on the subpro=
jects
> as if they were standalone independent git repositories (which of
> course they are) or treat the entire superproject as one giant git
> repository (with only a few cracks showing through). =C2=A0All gitsla=
ve
> commands are just git commands (s/^git\s/gits /) so training to use i=
t is
> rather easy.
>
> Unlike with git-submodules there is no strict binding between the
> parent repo's commits and the sub-project's commits except at tag
> boundaries. =C2=A0This gives you the flexibility of person A saying t=
hat A
> is master and B is underneath it while person B says that B is master
> and A is underneath it (or alternatively you can also say that A
> include B plus whatever B includes). =C2=A0However, I would in genera=
l
> recommend that the common library be factored out and be a child of A
> and B. =C2=A0gitslave makes it trivial to work with federated git
> repositories, if you can handle only having binding between
> repositories at tag boundaries.

Well, since I seem to have pretty much everyone who is involved with
"subprojects" (be it submodules, subtree, or gitslave) in this thread,
I wanted to clarify what I meant with "not supported well in Git". To
me, subproject support is one of the most important pieces missing in
Git. Git submodules, subtree and gitslave all provide a part of what
I'm looking for: non-invasive subproject support. I would like to be
able to use normal Git commands on the umbrella project that "trickle
down" to the subprojects. If you work on a subproject (in its own
repo) then a subsequent pull in the umbrella project should bring this
new code into the umbrella project (assuming that would make sense
given the branches involved).

After rereading my earlier reply I felt that it might be interpreted
as being disparaging of submodules/subtree/gitslave. I just wanted to
make clear that that was not my intent. I'm hopeful that we can get
some sort of combination of submodules, subtree and gitslave to
provide subproject support in Git.
