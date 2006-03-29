From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git terminology
Date: Wed, 29 Mar 2006 07:59:16 -0800
Message-ID: <7vodzp9r8r.fsf@assigned-by-dhcp.cox.net>
References: <20060329052113.6a773480.sebastien@xprima.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 29 18:00:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOd51-0004Wu-Go
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 17:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWC2P7T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Mar 2006 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWC2P7S
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 10:59:18 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47347 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751185AbWC2P7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 10:59:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060329155917.IEQR17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 10:59:17 -0500
To: =?iso-8859-1?Q?S=E9bastien?= Pierre <sebastien@xprima.com>
In-Reply-To: <20060329052113.6a773480.sebastien@xprima.com>
 (=?iso-8859-1?Q?S=E9bastien?=
	Pierre's message of "Wed, 29 Mar 2006 05:21:13 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18175>

S=E9bastien Pierre <sebastien@xprima.com> writes:

> In the process of learning git, and browsing the docs, I
> realized that many particular terms are used, but I had
> difficulties finding their definitions.

I had difficulties reading your message.  Please fold your lines.

> Among those I found a bit arcane, there are (in no particular
> order) "refspec", "rebase", "rewound", "pickaxe", "refnames",
> "objectnames" ,"refnames", "fast-forward update".

I see some are missing from our glossary but some others are
found there.

refspec is used by fetch and push to describe the mapping
between remote ref and local ref.  E.g.  "git fetch $URL
refs/heads/master:refs/heads/origin" means "grab the master
branch head from there and store it as my origin branch head".
"git push $URL refs/heads/master:refs/heads/to-upstream" for
"publish my master branch head as to-upstream master head at
$URL".

Probably we can just say "ref" where we say "refname".

Probably we can just say "ref" where we say "refname".

A fast-forward is where you have a revision and you are
"merging" other's change that happen to be a descendant what you
have.  In such a case, you do not make a new merge commit but
just update to his revision.  That is:

          o---o---o---o his               o---o---o---o his
         /                      ->       /             \
    o---o---o---o yours             o---o---o---o-------* yours

updating to his needs a merge like above, but in this case:

          o---o---o---o his               o---o---o---o his =3D yours
         /                      ->       /
    o---o yours                     o---o

you just update to his.

A related concept is "being already up-to-date".  In the latter
picture, if he attempts to "merge" your changes and notices he
is simply ahead of you (i.e. his revision is a descendant of
yours), nothing happens.

> If some of you are willing to detail/explain/define those
> terms (and some others not mentioned here), I would be glad to
> collect the definitions and make a "git terminology" document.

Thanks, and what J Bruce Fields already said.
