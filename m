From: "Bernhard R. Link" <brl+list+git@mail.brlink.eu>
Subject: Re: [PATCH] gitweb: add pf= to limit project list to a subdirectory
Date: Sat, 28 Jan 2012 16:37:50 +0100
Message-ID: <20120128153750.GB3397@server.brlink.eu>
References: <20120126144517.GA4229@server.brlink.eu>
 <m31uqkepx6.fsf@localhost.localdomain>
 <20120127235330.GA2718@server.brlink.eu>
 <201201281553.29387.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:39:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFU-0000o9-8V
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab2A1Phi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 10:37:38 -0500
Received: from server.brlink.eu ([78.46.187.186]:54050 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289Ab2A1Phe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 10:37:34 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrALM-00036m-Ox; Sat, 28 Jan 2012 16:37:32 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrALe-0000w2-HO; Sat, 28 Jan 2012 16:37:50 +0100
Content-Disposition: inline
In-Reply-To: <201201281553.29387.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189254>

* Jakub Narebski <jnareb@gmail.com> [120128 15:53]:
> On Sat, 28 Jan 2012, Bernhard R. Link wrote:
> > The project list takes often a very long time and searching in that list
> > takes the same time (and would also show projects not starting with the
> > text).
>
> There are at least two ways to speed up getting projects list page.

There are other ways, but they are both limited and quite backward:
Instead of showing me the information I want (what is in that
directory), I guess to search in the larger pool of information needing
all sort of half-working tricks causing all kinds of other problems
working around the issue that much more information never used must be
collected first.

Subversion's ViewVC for example only shows what is in some directory
directory and available subdirectories. (That of course has the
disadvantage to make it harder to find a project one does not know
the subdirectory it is in, but why shouldn't gitweb offer the best of
both worlds?)

> First is to limit number of projects shown, like e.g. http://repo.or.cz
> which shows only search form and tag cloud, but no projects, or at least
> paginate (divide into pages of e.g. 100 projects) list of projects.

But a page showing all projects (as long as it is possible) is something
I'd quite miss if it is gone. What I want is some way to have that and
to also be able to look at some subset interesting to me directly in an
effective way.

> Second solution would be to finally add caching support to gitweb,

But caching also means new projects or changes will take some time to
show up. And again it would not be a solution to by original problem.
(Showing effectively what is in some directory).

> > I'd for example like to be able to place a link to all projects shown
> > at http://anonscm.debian.org/gitweb/ which are below mirrorer/ and get
> > a not having to wait for description information being extracted for all
> > the other projects.
>
> I would prefer instead of introducing yet another arbitrary parameter
> extend project searching, so that you can specify that you want to
> search project names only (IIRC I have a patch for that, or beginnings
> of one, in my StGit stack), and use prefix search by the way of regexp
> search.

> So
>
>   pf=mirrorer/
>
> would be
>
>   s=^mirrorer/;sr=1;st=project_name

That might be a workaround, but still need to look at quite some amount
of unecessary data (i.e. it would need to run at least as long as a
http://anonscm.debian.org/gitweb/?a=project_index would not to load,
wouldn't it?)

        Bernhard R. Link
