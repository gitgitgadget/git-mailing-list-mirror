From: Ingo Molnar <mingo@elte.hu>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 16:04:42 +0200
Message-ID: <20080723140441.GA9537@elte.hu>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 16:06:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLeyZ-0004Pi-8S
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbYGWOEy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbYGWOEy
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:04:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:51098 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbYGWOEx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:04:53 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KLexP-0003rm-MI
	from <mingo@elte.hu>; Wed, 23 Jul 2008 16:04:51 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 04B6C3E21AB; Wed, 23 Jul 2008 16:04:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723135621.GJ22606@neumann>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89657>


* SZEDER G=E1bor <szeder@ira.uka.de> wrote:

> Hi,
>=20
> On Wed, Jul 23, 2008 at 03:05:18PM +0200, Ingo Molnar wrote:
> > I've got the following, possibly stupid question: is there a way to=
=20
> > merge a healthy number of topic branches into the master branch in =
a=20
> > quicker way, when most of the branches are already merged up?
> >=20
> > Right now i've got something like this scripted up:
> >=20
> >   for B in $(git-branch | cut -c3- ); do git-merge $B; done=20
> you cound use 'git branch --no-merged' to list only those branches
> that have not been merged into your current HEAD.

hm, it's very slow:

  $ time git branch --no-merged
  [...]

  real    0m9.177s
  user    0m9.027s
  sys     0m0.129s

when running it on tip/master:

  http://people.redhat.com/mingo/tip.git/README

	Ingo
