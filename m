From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git reset --hard <commit> superfluous?
Date: Sat, 3 Jan 2009 13:20:01 +0100
Message-ID: <20090103122001.GA20199@atjola.homenet>
References: <20090103011319.GA24149@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Sat Jan 03 13:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ5Ve-0004CV-Ph
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 13:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759844AbZACMUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2009 07:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759918AbZACMUM
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 07:20:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:56755 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759844AbZACMUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 07:20:08 -0500
Received: (qmail invoked by alias); 03 Jan 2009 12:20:05 -0000
Received: from i577B8799.versanet.de (EHLO atjola.local) [87.123.135.153]
  by mail.gmx.net (mp063) with SMTP; 03 Jan 2009 13:20:05 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+mqjduGESm/kn8CXePK8medWAGxZly9tIuf70oY+
	hkJwJhN9mIEf0p
Content-Disposition: inline
In-Reply-To: <20090103011319.GA24149@seberino.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104463>

On 2009.01.02 17:13:19 -0800, chris@seberino.org wrote:
> David
>=20
> git reset --hard <commit>
> "resets" the current branch head.
>=20
> Is this equivalent to deleting the branch
> and doing
>=20
> git branch <branch> <commit> ??
>=20
> So "git reset --hard" is syntactic sugar and 'unnecessary' right?

Deleting the branch also deletes the reflog, while using reset adds a
new entry to the reflog. So returning the branch head to its previous
state is pretty trivial if you used reset and might be pretty hard if
you deleted the branch. HEAD's reflog should probably have the right
entry as well, but chances are that it's hidden in a crapload of other
entries, especially if you rebase often.

Bj=F6rn
