From: Todd Zullinger <tmz@pobox.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Sun, 2 Feb 2014 16:07:24 -0500
Message-ID: <20140202210724.GX3241@zaya.teonanacatl.net>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
 <20140130181643.GG27577@google.com>
 <20140130185104.GV3241@zaya.teonanacatl.net>
 <CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NNF9FXNTY80mBlY+"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 02 22:07:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WA4GM-0004D5-Fj
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 22:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbaBBVH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 16:07:29 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:50585 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbaBBVH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 16:07:28 -0500
Received: by mail-qa0-f50.google.com with SMTP id cm18so8894390qab.37
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 13:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Zas2Y4QGtsyiSU7rhC6aIUkWJvT4yXogOIgwsCdwYmk=;
        b=HGh+tilOHRiWpX4nKi4sBYTTHSBD4dIxjttfp+qJ+ruh63/mpbrDRSWnoL7H/jvDQl
         Z1+hbP687NWqHWXrOffKfgEo8L4TS15blsxgZEbUFZXqb4leboqihCxxsNDMmmwcZ9WW
         tTpd0Gioe0/cYUSVQaSKDDKiRgoGANUQEwM//Y8cYjEfcv0ucMVclXvwqHsf68iP9ug5
         MNd1v05e2UlmMd5Y5PjaznmSqzYbHPE+55PPSbzfSyrbRi4SxqUEYsMFEiEK+bnVr4nW
         RfbcF/bqEIPUXw475AqMksLtAD8m0/1zE+AYezo/6lkBA6EkTmqM275hdVU5Wr23Avw3
         G0nQ==
X-Received: by 10.224.4.130 with SMTP id 2mr15118732qar.83.1391375247627;
        Sun, 02 Feb 2014 13:07:27 -0800 (PST)
Received: from zaya.teonanacatl.net (zaya.teonanacatl.net. [2001:470:5:873:862b:2bff:fe5e:698b])
        by mx.google.com with ESMTPSA id p3sm49897843qat.5.2014.02.02.13.07.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 13:07:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALMr_pVP-YVJ9K7ZpQxk3d5YBFQmCZBonFeUYY1fxdZNHHZJHA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241384>


--NNF9FXNTY80mBlY+
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Erez,

Erez Zilber wrote:
> Thanks. I will try to use the rpm from Todd's build. BTW - if I want=20
> to create such a build on Fedora that will create el6 packages (e.g.=20
> git-1.8.5.3-2.el6.x86_64.rpm), what's the procedure?

Something like this (this is from memory):

# Install fedpkg
$ yum install fedpkg

# Checkout the fedora git package (anonymously)
$ fedpkg clone -a git && cd git

Verify the git tarball.  This is optional, but I would be remiss to=20
suggest you skip it.  We used to include the tarball .asc file in the=20
fedora git repo, but that is no longer available for download. =20
Instead, it must be copied and pasted from Google Code (I'd love to=20
see the .asc files return, FWIW).

# To verify the tarball, have fedpkg download the sources first -- if=20
# you don't want to verify the tarball, you can skip this command and=20
# the gpg/sha1sum commands that follow
$ fedpkg sources

# Copy and paste the gpg signature from=20
# http://code.google.com/p/git-core/downloads/detail?name=3Dgit-1.8.5.3.tar=
=2Egz&can=3D2&q=3D=20
# to a local file and use gpg to verify it, then sha1sum to check the=20
# tarballs
$ gpg --verify sha1.asc
=2E..
$ sha1sum -c sha1.asc

# Create an el6 srpm
$ fedpkg --dist el6 srpm

# Build that package in mock, adding yourself or your build user to=20
# the mock group first
$ sudo useradd -a -G mock $USER
$ mock -r epel-6-x86_64 git-1.8.5.3-2.el6.src.rpm

The first time you build for a given release in mock will take longer=20
than subsequent builds, because mock needs to download a lot of=20
packages for the build root.  These packages will be cached for future=20
runs builds.

In the end, you should end up with a set of packages and build logs=20
under /var/lib/mock/epel-6-x86_64/result/.

Hope this helps,

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Anyone who is capable of getting themselves made President should on
no account be allowed to do the job.
     -- Douglas Adams, "The Hitchhiker's Guide to the Galaxy"


--NNF9FXNTY80mBlY+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQFDBAEBCAAtBQJS7rOMJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzj7A4H/1a3TIr+0A2hEfYZvcEP0rUJfmHGtCWQ2Rxc
tzZztWrrCuSM3eg/SygSBk9J2v0/LzVvLfXaXxH5Mw6iW3O53fr75xLgIkndZhA7
wS959T8k+BrjuekHvtU/HEXaC9KW0MWBmSH5bYssuovn8xSn77B0RgZTEcr/LUDM
JbvWzAunVmnZ/2CNGa0HFw2ZBA3pfxMh64rsHB+4AKQS0N3ZUhPBe/wmEb9fUFke
/7j1ujzcn6oU7IcMhXZoSTC4+NZKLzy5kRm26dsLzLu1huYjxXC+1/vRG2C8tv4c
M1C0uATPLtWGVsUHVXSuqVVFY3oj/2ddr8DyC8m9q4ght/T9rTM=
=AjKl
-----END PGP SIGNATURE-----

--NNF9FXNTY80mBlY+--
