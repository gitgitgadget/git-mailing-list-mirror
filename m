From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: pulling the root commit overwrites untracked files without
 warning (1.7.2.3)
Date: Sun, 14 Nov 2010 22:34:53 +0100
Message-ID: <20101114213453.GA29287@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Cc: git@vger.kernel.org
To: Gert Palok <gert@planc.ee>
X-From: git-owner@vger.kernel.org Sun Nov 14 22:34:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkDw-00035I-SW
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031Ab0KNVew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:34:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33602 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab0KNVev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:34:51 -0500
Received: by fxm6 with SMTP id 6so1329719fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=h3LHQ7gIYwRwzCHFbdqBC7PEG6/ZjyRGE2j/FY3/15o=;
        b=Uk6GCtQgkcvqjM9S/ZW7iw3lkSTJddLllj0jMtJPTjPvrp5jtDUDP3H/9aef9CNnqH
         vdRuQTrYwqjxf1YQd9iIGiYsaltcftzAFfzxmbEaQFMWsWPo8yU6EXP9u3FqxGLdQmBu
         zvICdiZtZ2uPwaSHwUa+ybIaaNXsawuim8q18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=JrHzx0AAaK87j+/vSHSAUtgIGVdNdOavFJtGAgo72D1n3JT7dzipMVkOE/EEpPbjtt
         6Vi7R4Bu0zPlRuAs2aW7Zpg1/SozDdyiEOfSL7wXG7rq+aPyHSZUs8KYsst+e/pdT96I
         KXrOz5kzxDRJHh66ithxNg7Eh42graTUzaxuU=
Received: by 10.223.127.16 with SMTP id e16mr3992612fas.101.1289770490388;
        Sun, 14 Nov 2010 13:34:50 -0800 (PST)
Received: from darc.lan (p549A7640.dip.t-dialin.net [84.154.118.64])
        by mx.google.com with ESMTPS id 16sm664689fal.24.2010.11.14.13.34.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:34:49 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PHkDt-0007hq-1u; Sun, 14 Nov 2010 22:34:53 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161446>


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 21, 2010 at 04:18:19PM +0300, Gert Palok wrote:
>=20
> On 1.7.2.3, pulling the root commit overwrites untracked files
>
> Minimal working example:                                                 =
      =20
> $ git init wc1                                                           =
      =20
> $ cd wc1                                                                 =
      =20
> $ echo a > a                                                             =
      =20
> $ git add a                                                              =
      =20
> $ git commit -m "added a"                                                =
      =20
> $ mkdir ../wc2                                                           =
      =20
> $ cd ../wc2                                                              =
      =20
> $ echo b > a                                                             =
      =20
> $ git init                                                               =
      =20
> $ git remote add origin ../wc1                                           =
      =20
> $ git pull origin master                                                 =
      =20
> $ # expected: error: Untracked working tree file 'a' would be            =
      =20
> overwritten by merge.  Aborting                                          =
      =20
> $ # actual: no error                                                     =
      =20
> $ cat a                                                                  =
      =20
> $ # expected: b                                                          =
      =20
> $ # actual: a

I finally got a chance to look at this. Contrary to my initial
suspicion, it's not a problem with the merge algorithm at all. It
doesn't even do a merge.

Instead, git merge finds that it has no valid HEAD and therefore
does a hard reset, which obviously overwrites any files already
there.

Patch to follow.

Clemens

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJM4FX8AAoJELKdZexG8uqMrOIIAKoVau5/XuIch9QuyFPvRzkZ
YYQXuk8JXB9+xYsWPShWANnmciOB/DprJwAYi0LlDbjYuek2auMCNVVanNaS2fML
xOb6MxFZttNfpikXztXCZnB4GTcjJ/vEraWKUMXpU/XuF/78vZEKwjvh2lOgQyR7
6T5P84/fxpdeaMjmr+6nrL4/dmCFj+f/4eli0+LM7vq6X4dwSXOS1DgOSsfT07Yn
HCilL5RyWyhMXVHtbZwFo7cqYA/y7Ij+kpuD5XHsArhqgZkk/OObMgjcCbvgFyyV
Ep1AQYtzSkDz4UPjMx3nAMcWzO1CjeztzxHg8k+xTYDgNLUORD1fi/rVczVzUEU=
=t5iI
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
