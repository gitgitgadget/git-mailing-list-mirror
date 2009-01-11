From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn: File was not found in commit
Date: Sun, 11 Jan 2009 22:55:26 +0100
Message-ID: <20090111215526.GA15533@atjola.homenet>
References: <49678705.4040506@mog.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Morgan Christiansson <git@mog.se>
X-From: git-owner@vger.kernel.org Sun Jan 11 22:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8Ik-00034K-5q
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 22:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZAKVzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Jan 2009 16:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZAKVzb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 16:55:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:40810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751491AbZAKVzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 16:55:31 -0500
Received: (qmail invoked by alias); 11 Jan 2009 21:55:28 -0000
Received: from i577BBA7A.versanet.de (EHLO atjola.local) [87.123.186.122]
  by mail.gmx.net (mp070) with SMTP; 11 Jan 2009 22:55:28 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19CjbE772xC3d2naucXDBk63LObSKOk0UFMXB3lff
	zXbtC66mHA/zIP
Content-Disposition: inline
In-Reply-To: <49678705.4040506@mog.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105233>

On 2009.01.09 18:19:01 +0100, Morgan Christiansson wrote:
> Hi, i'm trying to "git svn fetch" my repository from a local file:///
> repo and i'm running into this problem:
>
> $ git svn init -t tags -b branches -T trunk file:///path/to/svn/repo
> $ git svn fetch
> branches/rails/rails/vendor/plugins/acts_as_xapian/.git/refs/heads/ma=
ster
> was not found in commit a643e882c557593f36bb9fd0966490010b9dba61 (r10=
576)
>
>
> I found another report that seems to describe the same error:
> http://marc.info/?l=3Dgit&m=3D121537767308135&w=3D2
> Investigating the the history it's committed in r10577 and it's looki=
ng
> for it in r10576, so it seems to be off by one revision number. Exact=
ly
> like the other report.
> I've tried the latest git version of git-svn.perl and the problem is =
not
> fixed there.
>
>
> $ svn log file:///path/to/repo -r10576:10577 -v
> ---------------------------------------------------------------------=
---
> r10576 | morgan | 2008-11-28 14:35:53 +0000 (Fri, 28 Nov 2008) | 3 li=
nes
> Changed paths:
>   A /branches/rails/rails/app/controllers/browse_sheetmusic_controlle=
r.rb
>   M /branches/rails/rails/app/controllers/scores_controller.rb
>   M /branches/rails/rails/app/models/composer.rb
>   M /branches/rails/rails/app/models/score.rb
>   M /branches/rails/rails/config/routes.rb
>
> Commit message.
>
> ---------------------------------------------------------------------=
---
> r10577 | morgan | 2008-11-28 18:31:00 +0000 (Fri, 28 Nov 2008) | 3 li=
nes
> Changed paths:
>   A /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/FETCH_HE=
AD
>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/config
>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/index
>   M /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/HEA=
D
>   M
=20
> /branches/rails/rails/vendor/plugins/acts_as_xapian/.git/logs/refs/he=
ads/master=20
>=20
>
> # <-- THIS FILE

Unless I totally misread that line, SVN reports that the file was
_modified_, not added. For the file to be modified, it seems reasonable
to expect that it existed in the previous commit.

Is there anything "special" about how that file came into existence in
that branch? Without further knowledge, that looks like a svn bug, but
hey, it's svn, it might do funny stuff on purpose ;-)

Maybe you could provide a small test case/repo?

Bj=F6rn
