From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] Add 'git-p4.allowSubmit' to git-p4
Date: Thu, 26 Jun 2008 20:42:09 +0200
Message-ID: <200806262042.13121.simon@lst.de>
References: <20080622181239.GA1855@jabba.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1266399.anFvjrcCxK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 20:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBwRK-00084m-LG
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 20:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbYFZSmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 14:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbYFZSmU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 14:42:20 -0400
Received: from hoat.troll.no ([62.70.27.150]:44472 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbYFZSmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 14:42:19 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 770B820838;
	Thu, 26 Jun 2008 20:42:13 +0200 (CEST)
Received: from luria.local (unknown [172.20.1.59])
	by hoat.troll.no (Postfix) with ESMTP id 618D72081D;
	Thu, 26 Jun 2008 20:42:13 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080622181239.GA1855@jabba.hq.digizenstudio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86473>

--nextPart1266399.anFvjrcCxK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 22 June 2008 20:12:39 Jing Xue wrote:
> I'm working with a perforce repo using git-p4. There are some config
> files which I need to change locally according to my environment. I'm
> using a 'local' git branch to park these changes. And I want to avoid
> accidentally checking them into p4 just by doing "git p4 submit"
> mindlessly without realizing which branch I'm actually on.
>
> This patch adds a new git config, 'git-p4.allowSubmit', which is a
> whitelist of branch names. "git p4 submit" will only allow submissions
> from local branches on the list. Useful for preventing inadvertently
> submitting from a strictly local branch.
>
> For backward compatibility, if this config is not set at all,
> submissions from all branches are allowed.
>
> Signed-off-by: Jing Xue <jingxue@digizenstudio.com>

Acked-By: Simon Hausmann <simon@lst.de>


Simon

>  contrib/fast-import/git-p4 |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index d8de9f6..87ca51e 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -687,6 +687,10 @@ class P4Submit(Command):
>          else:
>              return False
>
> +        allowSubmit = gitConfig("git-p4.allowSubmit")
> +        if len(allowSubmit) > 0 and not self.master in
> allowSubmit.split(","): +            die("%s is not in git-p4.allowSubmit"
> % self.master)
> +
>          [upstream, settings] = findUpstreamBranchPoint()
>          self.depotPath = settings['depot-paths'][0]
>          if len(self.origin) == 0:



--nextPart1266399.anFvjrcCxK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIY+MFWXvMThJCpvIRAoHzAKDsoNhPn81hm4xyiiB2bApQEf9H3gCfUDR3
zRG0AnvBWilHnBwbHiL0CWk=
=fmYm
-----END PGP SIGNATURE-----

--nextPart1266399.anFvjrcCxK--
