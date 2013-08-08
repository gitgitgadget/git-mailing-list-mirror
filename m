From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout
Date: Thu, 08 Aug 2013 14:41:41 +0200
Message-ID: <52039205.5060307@googlemail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA113D832FB90A63CFB393259"
Cc: git@vger.kernel.org
To: gitml.jexpert@recursor.net
X-From: git-owner@vger.kernel.org Thu Aug 08 14:41:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7PXG-0002Mw-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757814Ab3HHMlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 08:41:42 -0400
Received: from mail-ea0-f173.google.com ([209.85.215.173]:55958 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757776Ab3HHMlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 08:41:42 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so1418741eak.18
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=6LUxj1gYUocD/1vwpMZYQ3CGCXRXUEoOOpaB5oHRooc=;
        b=kZlXL2V+wlga2RInX89npvcI1pUQCwS6Uc2xCG0q26sQwuJsFJYFKQA/951ejtaeWS
         Bs2WatzfxmYfjDVcZhzaxE3BDSenYt47K/isZPsKk4q6RJjEFo9j8uEXjXCBompf4XB+
         pdCV3BSCkGlHJtSicRHKem+UI+FcX/7yuHXoyi4g3A9Y52X3AqU8DvEEsI+r45jtQPVn
         VQb4OpclPVmpKUpUVvmaGsHbnabHK90foehcR7SM364pjjbsNwNt5VC347Z5F+HsoWyN
         TgrhGL4bNtC/AYCf2+3QkkrVhS4LZ2RIZ2DdxMnubtJHnOMo48m1KqKVoDjqWMMYFsqE
         1WeA==
X-Received: by 10.14.173.194 with SMTP id v42mr8091275eel.111.1375965700828;
        Thu, 08 Aug 2013 05:41:40 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n48sm18871423eeg.17.2013.08.08.05.41.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 05:41:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231878>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA113D832FB90A63CFB393259
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2013 02:23 PM, gitml.jexpert@recursor.net wrote:
>> Regardless of any possible fault in git-svn, there's an obvious bug he=
re
>> with git-fsck.  Can you share the pack (if the project is public) or
>> compile a git-fsck without optimization and with debugging, and run it=

>> under valgrind, to hopefully get us a backtrace of where the memory
>> management goes off the rails?
>=20
> Unfortunately I'm unable to share the pack.
>=20
> As Java Developer I'm note very savy, but I'd try.
> Do you have me any pointers on ".. without optimization and with
> debugging" and "run it under valgrind"?
>=20
> Currently I used
>    deb http://ppa.launchpad.net/git-core/ppa/ubuntu quantal main
> as source.

The version from the ppa seems to be 1.7.0.4-1ubuntu0.2 but the version
of git being in the native ubuntu quantal repository=20
(I assume you're running Ubuntu?) is already 1.7.10.4-1ubuntu1=20
(http://packages.ubuntu.com/quantal/git)


However to get an unoptimized version with debug symbols you could do thi=
s:

	# get the source:
	git clone git://git.kernel.org/pub/scm/git/git.git/
	cd git

	# read INSTALL, the section starting at=20
	# > Git is reasonably self-sufficient, but does depend on a few external=

	# > programs and libraries
	# this is a guess, maybe you need more or less packages, but you'd need =
the -dev packages for the C-headers
	sudo apt-get install libz-dev libopenssl-dev libcurl-dev libexpat-dev=20
=09
	# Now disable optimizing by overwriting default compile flags:
	echo "CFLAGS=3D-g" > config.mak

	# compile and install=09
	make=20
	make install # installs to ~/bin

	# open a new shell or relogin, and see if you're using the version you j=
ust build:
	git --version
	# git version 1.8.4.rc1....

Stefan


--------------enigA113D832FB90A63CFB393259
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSA5IFAAoJEJQCPTzLflhq2EkP/1zBijSC+3CkFwS2hNWVWTTq
/I7L2Lpv7oETXuVE77HfuUpqFiHYk8VZ3SG0vKEYBLknTPQu6iuTvTHbese3ES8q
KwkVrjer2ExT8d8mj+PnjJjgpTbF9oeQoek/EurWWRUhJFbmee0zysUwD+bYYYFN
ipuYpyfgVjqpdvoI9MwzU/wXvO4h1BJlkdJU14GMuNKqfqHbmHb4D1Div1JwWZWP
sCJ3MwztCcHmoIXY0qusBiZh8H1cl9dLofG7WzGuduxgyUdqvtCu1oik9UN0cdZj
5axak2O9n1/A1a4cN8bYFpfEVVPQULX9fX95AnGGASQXr2fq89flfT9Ejd/Xz/oG
1dJlVC5m10czg3vabpk1UeRz5FyVnm96Tb5TObcWleFsP25AQfU5pso3wG9f73HI
XB6CdyPdQH1siJfy0OrRGTSthZpBjvHPGc1NCDrCTwjo38HdTc4l1bFcZaDKtBtH
7eVtFi6bcFRcUw4ie2rHL6uVhXZLyqrsy0XrXaeyY/LRH5z6bOpZU8ilAYQytPFN
XK+lfJg5fS0c2WLXoX34lXQxNijpcN3TAMzfuznUr6eA870IOa5eyLztVih68ceA
aB3UGVafNjklb6NuLN25c2qsaar22DpLgHY3vvhCzKEhvX3gB+2mkKfnu4ocUOZI
EAQrsRWoRVL/pDIj+LAo
=1H+8
-----END PGP SIGNATURE-----

--------------enigA113D832FB90A63CFB393259--
