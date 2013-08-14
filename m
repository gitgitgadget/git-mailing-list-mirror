From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Thu, 15 Aug 2013 00:16:35 +0200
Message-ID: <520C01C3.2060804@googlemail.com>
References: <520BAF9F.70105@googlemail.com> <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com> <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com> <201308141125.59991.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig136E127629A2178DE033F351"
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 00:16:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9jMq-0007Ng-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 00:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933189Ab3HNWQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 18:16:32 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:43290 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933153Ab3HNWQb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 18:16:31 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so16854eek.22
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 15:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=LWajlQBC1jjEBwk+3YxcRqyax6C//QjXdZc93mrp+3Q=;
        b=HyhmCNKevWknqVzE5yAkK+wpnG7G4dhCfkGcO9WPeZ7rteLXORWRMepoankOvNkrOS
         JtUsmzl/J93+ntaiupLFkL4oDXrJwCnGSlE8LCWis2het0Iiru2B1SXUlaJq1KwOkiZv
         JPbzhkyS9ey9Ct2tXbvjLcVSXWEiO4kMZwkU9pjPjmwRod2QeHfaXtvm/keHDFySImA9
         KaJHh+dcMvj6e4p+vlHh9mHl+F0XQMF8lJk5iOssUsJj+rFa8UJ1ytT8GRVBlL7iCIIo
         YiUkdlJvXNEl9ON8V1TGDIROKQRttluKeUtl5TwgjR/PTkoy9fe3yjpfblzshoghmloi
         6j+Q==
X-Received: by 10.14.95.2 with SMTP id o2mr292288eef.82.1376518590334;
        Wed, 14 Aug 2013 15:16:30 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m54sm78963202eex.2.2013.08.14.15.16.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 15:16:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <201308141125.59991.mfick@codeaurora.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232315>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig136E127629A2178DE033F351
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2013 07:25 PM, Martin Fick wrote:
> I have been holding off a bit on expressing this opinion too=20
> because I don't want to squash someone's energy to improve=20
> things, and because I am not yet a git dev, but since it was=20
> brought up anyway...

It's ok, if you knew a better topic to work on, I'd gladly switch over.
(Given it would be a good beginners topic.)

> =20
> I can say that as a user, having git-repack as a shell=20
> script has been very valuable.  For example:  we have=20
> modified it for our internal use to no longer ever overwrite
> new packfiles with the same name as the current packfile. =20
> This modification was relatively easy to do and see in shell=20
> script.  If this were C code I can't imagine having=20
> personally: 1) identified that there was an issue with the=20
> original git-repack (it temporarily makes objects=20
> unavailable) 2) made a simple custom fix to that policy.

Looking at the `git log -- git-repack.sh` the last commit is
from April 2012 and the commit before is 2011, so I assumed it
stable enough for porting over to C, as there is not much
modification going on. I'd be glad to include these changes
you're using into the rewrite or the shell script as of now.

>=20
> The script really is mostly a policy script, and with the=20
> discussions happening in other threads about how to improve=20
> git gc, I think it is helpful to potentially be able to=20
> quickly modify the policies in this script, it makes it=20
> easier to prototype things.  Shell portability issues aside,=20
> this script is not a low level type of tool that I feel will=20
> benefit from being in C, I feel it will in fact be worse off=20
> in C,

So far I have been following the git mailing list, there are
people dreaming of 'everything in C' and apparently those, who
are ok with lots of shell code as well, 'because it's high level'.
I tend to follow the first group, dreaming of everything in C.
Thanks for pointing that out, if it really hurts people from using
git effectively, I'd rather not contribute this patch. But I'd like
to stress again, that the prototying should be done by now.

I asked for a todo wish list a few weeks ago, but got no real answer,
but rather: "Pick your choice and try to come up with good patches".
This is a good policy from the projects point of view (your choice
helps in doing good patches, and good patches do not need as much
review, hence the reviewing costs are low), so I also choose this topic.

>=20
> -Martin
>=20

Stefan


--------------enig136E127629A2178DE033F351
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDAHDAAoJEJQCPTzLflhqeI0P/jxyyVkodVPAF/tZprW5xfZy
6id+SlxtrlV6S4IakOWuiM00q3PRZq0460s0C3JdSHUVH1wShSrddJ1UbmcCQgTK
GvUdh9YnYD93tyQ09oiVOtbfJKTApFWMZ2VmzIRcUKL5QI4vIFgCwU6mMW5Pytri
PiIAyWxbFYTJwlUucUOmxquuWjw9ux8Xa9KqyL8BSSCDYoeMgh/FooqKqEydlFwI
rW1gjmvjsM4vU76yCHttkVPexdWmJlbWNS8+74BP7ZcYa/g8GHVabW7re2Thb61o
8gmcYcVTrZLA8X2EAPZbPTdcv+CjSMHrHhz87omfUuFYS01Irz7dk/2z8RDvW8qv
YbOloiZK+tJbef14PtznbJumRmmLtWZ1iW6ITzBdorAaiQOLG/WSR8PNtfVIFVQO
udUl9REK8BDjUPUfB7MKDNLfnIi/+N2y30QPQ9mAfedsg9hDpZIFKpt7PYKT3IFL
jPxXmM5WCeQLEVaPYiPsk+T8HhP+9XlNZsc5SkAmC+DJtC5KhWrWRjQGkK30R0cN
Y5UBD50N01/hMf4A3miDPXDlG/Dbjx4BcqVMbEZvITpPVxrgacJ8LWA5bvCbegpX
V0B4Hl14N7Ax39y/j3A8SkaCnR3Za977q74rPXapbB913O8KKibA+d5M4HuKSIsC
eUbv/ZrKvspmjfFvzeyt
=jGCn
-----END PGP SIGNATURE-----

--------------enig136E127629A2178DE033F351--
