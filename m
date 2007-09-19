From: Simon Hausmann <simon@lst.de>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 21:03:50 +0200
Message-ID: <200709192103.53526.simon@lst.de>
References: <119022570352-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3368248.aUz5rUbQol";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 21:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4q4-00051s-VQ
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 21:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXISTDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 15:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXISTDv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 15:03:51 -0400
Received: from esparsett.troll.no ([62.70.27.18]:33764 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbXISTDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 15:03:50 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 8DC5D7427A; Wed, 19 Sep 2007 21:03:49 +0200 (CEST)
Received: from luria.local (unknown [172.20.1.24])
	by esparsett.troll.no (Postfix) with ESMTP
	id 7935974193; Wed, 19 Sep 2007 21:03:49 +0200 (CEST)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
In-Reply-To: <119022570352-git-send-email-git@davidb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58725>

--nextPart3368248.aUz5rUbQol
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 19 September 2007 20:15:03 David Brown wrote:
> git-p4 was missing the execute bit setting if the file had other attribute
> bits set.
> ---
>  contrib/fast-import/git-p4 |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index adaaae6..50850b8 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -932,7 +932,10 @@ class P4Sync(Command):
>                  data = file['data']
>
>                  mode = "644"
> -                if file["type"].startswith("x"):
> +                if (file["type"].startswith("x") or
> +                        file["type"].startswith("cx") or
> +                        file["type"].startswith("kx") or
> +                        file["type"].startswith("ux")):
>                      mode = "755"
>                  elif file["type"] == "symlink":
>                      mode = "120000"

I'm fine with this, so unless you find a better way:

Acked-By: Simon Hausmann <simon@lst.de>


Simon

--nextPart3368248.aUz5rUbQol
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8XKZWXvMThJCpvIRAu5WAKDZT4ZrdIAWHnxTfYhIYs+9V23IvACg2Aiw
syQHvpjmZRXAJEn38IVv7Js=
=PZJv
-----END PGP SIGNATURE-----

--nextPart3368248.aUz5rUbQol--
