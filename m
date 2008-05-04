From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: EasyGit [Was: Re: my git problem]
Date: Sun, 4 May 2008 12:00:45 +0200
Message-ID: <200805041200.46099.chriscool@tuxfamily.org>
References: <51419b2c0805020441l7a52f9d2q6bfc8eb4e18e4e7e@mail.gmail.com> <51419b2c0805020454p144698e4l843e8edab00ddeb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Havoc Pennington" <hp@pobox.com>,
	"Carl Worth" <cworth@cworth.org>
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:56:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsaxY-0004Yl-3o
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbYEDJzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 05:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754071AbYEDJzz
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:55:55 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:51371 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbYEDJzy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 05:55:54 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id BF94E1AB2F9;
	Sun,  4 May 2008 11:55:51 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7102E1AB2F0;
	Sun,  4 May 2008 11:55:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <51419b2c0805020454p144698e4l843e8edab00ddeb7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81162>

Le vendredi 2 mai 2008, Elijah Newren a =E9crit :
>
> EasyGit (eg) is a single-file script/porcelain that looks and feels l=
ike
> core git.  In contrast to other simple-to-use porcelains, eg has all =
the
> same capabilities as git (in particular, it does not remove the index=
)
> and uses the same general syntax as core git.  Eg primarily reduces t=
he
> learning curve associated with git and prevents common user errors.
>
> Changes:
>   Most of the changes in eg relative to git boil down to:
>     - plugging a large gap in git documentation (namely, providing a
>       tutorial-oriented built-in help system)

I had a look at it. And I have a few comments that I prefixed with '#'=20
below.

$ eg help
[...]
Time saving commands
  eg bisect     Find the change that introduced a bug by binary search
[...]

#=A0What did they do to my beloved bisect? I need to have a look.

$ eg help bisect
Sorry, bisect is not overridden or modified for eg, and no
help has been written for it.  If you're feeling brave, you may
want to try running 'git help bisect'.

# So they did nothing to it. Good ;-)
# But then why don't they ask people to use "git bisect" directly inste=
ad
# of "eg bisect" ?
#
#=A0And they point to "git help bisect", good point.
# No need to "feel brave" to look at "git help bisect" though,=A0becaus=
e I
# think it is quite good. But I guess this is a generic=A0message aimed=
 at
# other commands.=20

$ eg help clone
[...]
See also
  Run 'man git-clone' for a comprehensive list of options available.
  eg clone is designed to accept the same options as git clone, and
  with the same meanings unless specified otherwise in the above
  "Differences" section.

# The output is longer than my terminal's 41 lines so I don't see=A0its=
 top
# because there is no paging.=20
# And why ask people to use "man git-clone" here, instead of "git help
# clone" ?

$ git clone -h
[...]

#=A0"git clone -h" show more options in 18 lines only, but no examples
#=A0and no description.
#
# I am not sure that the "Differences from git clone" part from "eg hel=
p
# clone" is really usefull for beginners.

$ eg changes --details
[...]

# Very long output but it's paged.

$ eg help help
[...]
Differences from git help:
  eg help uses its own help system, ignoring the one from git help...ex=
cept
  that eg help will call git help if asked for help on a subcommand it =
does
  not recognize.

  "git help COMMAND" simply calls "man git-COMMAND".  The git man pages=
 are
  really nice for people who are experts with git; they are comprehensi=
ve
  and detailed.

# It's not true that "eg help will call git help if asked for help on a
# subcommand it does not recognize", it only display the same message a=
s
# for "eg help bisect" above.
#=20
# Also it's not exactly true that '"git help COMMAND" simply calls "man
# git-COMMAND". If you use "git help -w COMMAND" or if you have
# the "help.format" set to "web", you get a HTML man page opened in a n=
ew
#=A0tab in firefox (or something like that).
#
# And why not pointing to "git COMMAND -h" too, as it should give a "lo=
ng
# usage" string that is often usefull and easier to use as the man page=
 ?=20

[...]
>
>   I would like to see the parts of eg that the community likes
>   incorporated into git core.  I do not know which changes would be
> wanted or welcome, and it may turn out that some of my changes show
> ignorance of certain aspects of git (some such cases have previously =
been
> uncovered already...and fixed).  But the discussion can't hurt, and a
> number of the solutions I used in eg I have not found in searches of
> previous discussions in the archives.

What I like about the built-in help system in eg is that there are lots=
 of=20
examples displayed. I think the git man pages are somewhat lacking in t=
his=20
area. (Some examples are still using the "git-COMMAND" syntax for examp=
le.)=20

The built-in help text in eg also seems simpler and easier to understan=
d,=20
but it may be because there are fewer options and simpler commands to=20
explain.

So here are some things that could be done to improve git help system:

- find a way to make users know that they can get long usage help using=
 "git=20
COMMAND -h"
- find a way to display some examples on the command line without the f=
ull=20
man page
- add and improve examples in man pages
- add some simpler explanations to man pages and perhaps move more comp=
lex=20
explanations to a "DETAILED DESCRIPTION" part of the man page
- improve man pages in other ways

Thanks,
Christian.
