From: Petr Baudis <pasky@suse.cz>
Subject: Re: Understanding git.git's branch policy
Date: Mon, 25 Jan 2010 01:17:32 +0100
Message-ID: <20100125001732.GD9553@machine.or.cz>
References: <83pr4znklo.fsf@torus.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Steven E. Harris" <seh@panix.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 01:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZCeE-0007Cc-KO
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 01:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab0AYARg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 19:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441Ab0AYARg
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 19:17:36 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55722 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181Ab0AYARf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 19:17:35 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id D56BF125A0E9; Mon, 25 Jan 2010 01:17:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <83pr4znklo.fsf@torus.sehlabs.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137930>

On Sun, Jan 24, 2010 at 06:34:11PM -0500, Steven E. Harris wrote:
> Radding the maintain-git.txt document=C2=B9, there are a few points t=
hat I'm
> having trouble decoding. Under "The Policy", it notes
>=20
> ,----
> | The tips of 'master', 'maint' and 'next' branches will always
> | fast-forward, to allow people to build their own customization on t=
op
> | of them.
> `----
>=20
> I understand that a "fast-forward merge" means that one's current HEA=
D
> commit is an ancestor of the evolved branch's head, so that the HEAD
> pointer can move forward to "catch up" without needing to combine
> disparate content.
>=20
> How does this relate to the prescribed use of the "master", "maint", =
and
> "next" branches? What operations or patterns does it constrain agains=
t?

Rebases or other jumps. New tip of 'master' will always be descendant o=
f
old tip of 'master', never a commit from a parallel commit line. This i=
s
preserved over commits and merges, but not over operations that rewrite
history - rebase, filter-branch and such.

The term "fast-forward" is used commonly in this sense. E.g. git push
will typically deny you to push out a branch that is not fastforwarding
the currently pushed out branch, unless you force it to.

--=20
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
