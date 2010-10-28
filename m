From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: svn repository URL and git
Date: Thu, 28 Oct 2010 21:37:29 +0200
Message-ID: <20101028193729.GD46314@acme.spoerlein.net>
References: <loom.20101027T170254-268@post.gmane.org>
 <4CC845EE.5040602@debugon.org>
 <loom.20101027T180316-38@post.gmane.org>
 <loom.20101028T184823-831@post.gmane.org>
 <20101028190227.GC46314@acme.spoerlein.net>
 <4CC9CF86.7040307@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: H Krishnan <hetchkay@gmail.com>, git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Thu Oct 28 21:37:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBYI7-00034Z-IK
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 21:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759518Ab0J1Thf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 15:37:35 -0400
Received: from acme.spoerlein.net ([188.72.220.29]:41246 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab0J1The (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 15:37:34 -0400
Received: from acme.spoerlein.net (localhost.spoerlein.net [IPv6:::1])
	by acme.spoerlein.net (8.14.4/8.14.4) with ESMTP id o9SJbTHh063920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Oct 2010 21:37:30 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1288294650;
	bh=zXT3OF0+uxq7tHStLmDvA0GhISVGKwUJ6l7o3yxVHwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:In-Reply-To;
	b=WBV/eIHjd9U0cea/ByDjwlSAOg8vkE8QWCKqCHqNismCUpYBSq3WX56duILqJlGDK
	 nvL7MYv6qVshUwaaVj3Pm+x2aJuNvl6zVe0l1xjRUEGWrM4JUBcHBolVrrVXMrpVZe
	 bsFhQVkBTI4qt/KGcyQIHOXlA66UQslQ88CEwvHw=
Received: (from uqs@localhost)
	by acme.spoerlein.net (8.14.4/8.14.4/Submit) id o9SJbTgG063919;
	Thu, 28 Oct 2010 21:37:29 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
Content-Disposition: inline
In-Reply-To: <4CC9CF86.7040307@debugon.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-Spam-Report: 5.4 points;
 * -2.6 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
 *      [score: 0.0000]
 *  4.0 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
 *      [188.72.220.29 listed in zen.spamhaus.org]
 *  4.0 URIBL_SBL Contains an URL listed in the SBL blocklist
 *      [URIs: spoerlein.net]
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160214>

On Thu, 28.10.2010 at 21:31:18 +0200, Mathias Lafeldt wrote:
> On 10/28/2010 09:02 PM, Ulrich Sp=C3=B6rlein wrote:
> > On Thu, 28.10.2010 at 16:58:28 +0000, H Krishnan wrote:
> >>
> >> Hi,
> >> I think I resolved this problem by using --rewrite-root as suggest=
ed. I used a=20
> >> dummy root during the git-svn clone:
> >>
> >> git-svn clone --rewrite-root http://git.is.great <myrepo>
> >>
> >> All my commit messages now have http://git.is.great but I am able =
to change the=20
> >> repository URL and continue.
> >>
> >> Could this approach be used as an insurance against svn url change=
s? When=20
> >> initializing the repository, we could use --rewrite-root. Subseque=
ntly, if the=20
> >> svn repository relocates, we need to edit only .git/config.=20
> >=20
> > Yes, that's exactly what the rewrite-url was introduced for, you ca=
n
> > even clone from a local svnsync mirror (iff the UUID matches, you h=
ave
> > to setup the mirror in a special way ...).
> >=20
> > So, every developer must use:
> >=20
> > $ git svn clone --rewrite-root CANONICAL-URL-NEVER-TO-CHANGE <whate=
ver-url-is-convenient>
> >=20
> > Oh, and all devs must use the same authormap (or no authormap at al=
l).
> >=20
> > hth,
> > Uli
>=20
> FYI, I just learned [1] that git-svn even has a --rewrite-uuid option=
=2E
>=20
> [1] http://www.kernel.org/pub/software/scm/git/docs/git-svn.html

Try using them both at the same time! :]

(No, I have no idea, why that is not supported ... OTOH having the same
UUID on the mirror is a kinda no-brainer)

Uli
