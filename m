From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 25 Sep 2008 17:41:31 +0200
Message-ID: <200809251741.32649.jnareb@gmail.com>
References: <200809251230.11342.jnareb@gmail.com> <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:43:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiszb-0002bi-4Q
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 17:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbYIYPlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 11:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbYIYPlt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 11:41:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:59221 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbYIYPls (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 11:41:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so338276fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ULsvGDdeIOf9kwmVWFKaXWD8OIBwNa7wInlTVhQvpHU=;
        b=E6Eghn2VO8pam5rfj/E8HZsjo6aPcBWxGRj5MIZjU3LCYw/wyTpjoGf9mZofoEBNHf
         I6ub/NXo4VqwjdiNDE2Lz6rdd6b3x5vU5yIhZM+TMYhMb2IBkSInLPDcHndFejbY88Ka
         VXmGnO0OALU+ptKo/I19oVPvRCOfFojuN37kI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mnmuoE3PeDZOuqwxVdD3qAsWSROxxdQI+Vps9Libh4HMXS6R7ZwtLnkI7VNivTtMqS
         0WV9kMgIRHC0dF5p1otPM8L264Fw1cSoc4Lpraq5XHLfQlLQoGJZdTfB44QgZRgGymmJ
         nyHW/JicETVP/qLflO63dXz0/0v9lzP1l39WI=
Received: by 10.181.27.7 with SMTP id e7mr5436516bkj.2.1222357305981;
        Thu, 25 Sep 2008 08:41:45 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.235.56])
        by mx.google.com with ESMTPS id 4sm1756220fgg.4.2008.09.25.08.41.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 08:41:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <B3B6996F-EC51-49DC-8ECE-DBA25E8F61DE@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96780>

On Thu, 25 Sep 2008, Wincent Colaiuta wrote:
> El 25/9/2008, a las 12:30, Jakub Narebski escribi=F3:
>=20
> > This is yet another series of planned gitweb features. It expands m=
ore
> > on new user-visible features than on improving gitweb code (therefo=
re
> > for example using Git.pm/Git::Repo, gitweb caching, and list form o=
f
> > open for pipelines are not mentioned here).
> >
> > Which tasks / features are most requested?  Which tasks should be d=
one
> > first?  What do you have on your gitweb TODO list?
>=20
> One which I'm looking at doing is supporting reading the "README.html=
" =20
> from the tree indicated by the current HEAD instead of reading it fro=
m =20
> a file in the .git directory.

One problem is with the concept of using "current HEAD" for that.

I have nothing against for example showing README or README.html (in
some order of preference), or initial fragment of it with link to full
version ('blob' view), either below or above 'tree' view, like
GitHub and Gitorious does.  When you are on 'tree' view you are on
some branch, even implicitly[1].  But for 'summary' view, which is
currently the only view that shows $GIT_DIR/README.html, you are not.

It might happen that you push to git hosting site while on some side
unrelated branch like 'todo', 'html' or 'man' pages in git.git, or
are on branch spawned off subtree-merged subproject like git-gui;
or your gitweb shows state of live non-bare repo and you happen to be
on such branch.  What then?  Repository description vanishing by
accident is not a good solution...


[1] And you can have different READMEs shown for different subprojects,
like there is README, and gitweb/README, and contrib/README, etc.
=20
> This should make tracking and updating such READMEs a little easier a=
s =20
> all that'll be required is a "push" to advance the HEAD and the new =20
> README goes live.
>=20
> Obviously, will have to make this optional and configurable. I'm =20
> thinking of providing a means of specifying the filename to look for =
=20
> (no filename, the default, means don't look), and also a setting to =20
> indicate the content type of the file (either plain text, which would=
 =20
> be wrapped in a <pre></pre> block with HTML entities used where =20
> appropriate, or HTML which would be included verbatim).

Well, $GIT_DIR/README.html was meant as extension of simple project
description ($GIT_DIR/description or gitweb.description in config).
One paragraph of concise short description; something like projects
description on software hosting site like SourceForge or Savannah,
or software metric site like Ohloh, or software catalog/directory
like Freshmeat.  It is meant as short introduction to project, or
to be more exact to given repository (see below).

In-tree README has different purpose.  Besides describing project
in detail, it usually has some instructions on how to install it
(even if it is referring to INSTALL file), how to configure it,
how to use it; should have all the things required by GNU Coding
Standards and/or Gnits Standards.  It is usually therefore much
longer than $GIT_DIR/README.html (and usually does not use HTML,
but [almost] plain text); so I think gitweb should display around
some given number of lines, ending at break between paragraph if
possible.

Besides $GIT_DIR/README.html can describe specific _repository_,
either some fork of a project (like who created it, what is purpose
of this fork, even if in-tree README remains the same; an example
would be git.git repository forks for git GSoC projects), or
specific mirror (for example describing difference between git.git
and alt-git.git on repo.or.cz).


But I would be not against having in-tree (with the mentioned caveat
of using top-tree HEAD version) README or README.html as fallback
if $GIT_DIR/README.html does not exists, taking into account some
order of preference among README* files if there exists more than one
such file, and displaying it not in full if in-tree README is large.

Alternate solution would be add some kind of _gitweb-admin_ script,
which would allow to set parameters of gitweb or of repository
displayed in gitweb on-line, which would include one-line plain-text
description of a project, and short README.html.  Although I'm
not sure if it should be not left for higher level of hosting site
(Gitorious, repo/Girocco, GitHub, Savane-clean, GForge,...).

--=20
Jakub Narebski
Poland
