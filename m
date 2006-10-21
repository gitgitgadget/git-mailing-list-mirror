From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 22:19:13 +0200
Message-ID: <200610212219.14115.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610212130.31414.jnareb@gmail.com> <Pine.LNX.4.64.0610211237460.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Carl Worth <cworth@cworth.org>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 22:19:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbNJH-0004pW-Bu
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 22:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161490AbWJUUTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 16:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161494AbWJUUTH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 16:19:07 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:11083 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161490AbWJUUTE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 16:19:04 -0400
Received: by qb-out-0506.google.com with SMTP id p36so290517qba
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 13:19:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aA89RHf2T+5m4OQAHRq9x7Fxj6BuC6y3HFq6QrEFnT/bW0raYm2DXNYGWopc2oyMlxByKlPzW3icZ/VdQP5BPCC0doCu7eHb3GauC8DfX58oUBPa/FclSKxHBJEP8lEB+uXBM8n6/2qiUPtNEWBhtjHF0/xws9fuTdbLSfqbKH0=
Received: by 10.66.252.4 with SMTP id z4mr4349526ugh;
        Sat, 21 Oct 2006 13:19:02 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id 50sm158010ugb.2006.10.21.13.19.02;
        Sat, 21 Oct 2006 13:19:02 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0610211237460.3962@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29670>

Linus Torvalds wrote:
> =A0- sometimes you have multiple branches in the same tree that have =
very=20
> =A0 =A0_different_ sources. For example, you might start out cloning =
my tree,=20
> =A0 =A0but if you _also_ want to track the stable tree, you just do s=
o: you=20
> =A0 =A0can just do
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0git fetch <repo> <remote-branch-name>:<local-=
branch-name>
>=20
> =A0 =A0at any time, and you now have a new branch that tracks a diffe=
rent=20
> =A0 =A0repository entirely (to make it easier to keep track of them, =
you'd=20
> =A0 =A0probably want to make note of this in your .config file or you=
r remote=20
> =A0 =A0tracking data, but that's a small "usability detail", not a re=
al=20
> =A0 =A0conceptual issue).

That for example allows of joining two initially separate projects
into one project. For example that was the case for gitk and gitweb
which are now in git.git repository. Most probably gitweb/gitk was
fetched into separate gitweb/gitk branch, then merged with the 'master'
branch of git (in case of gitweb we "resolved conflict" by moving=20
all gitweb files to gitweb/ subdirectory) then propagated to other
branches by merging with master.

=46or example git has 7 "initial" (parentless) commits. Two of them
are superficial 'html' and 'man' branches for automatic generation
of HTML and man version of git documentation, keeping it current.
There is 'todo' branch, [also] totally separate for notes. And there
are initial commits of git, git-tools, gitk and gitweb:
 * Initial revision of "git", the information manager from hell
 * Start of early patch applicator tools for git.
 * Add initial version of gitk to the CVS repository
 * first working version=20
   [of gitweb: this commit message should be more descriptive]

$ git rev-list --parents --all | grep -v " " | xargs git -p show
--=20
Jakub Narebski
Poland
