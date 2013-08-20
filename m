From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] mailmap: fix check for freeing memory
Date: Tue, 20 Aug 2013 16:38:17 +0200
Message-ID: <52137F59.2030103@googlemail.com>
References: <1377004958-14489-1-git-send-email-stefanbeller@googlemail.com> <878uzw7a6l.fsf@linux-k42r.v.cablecom.net> <52137A63.3010609@googlemail.com> <871u5o785o.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig48D66C3CB9ECA842866AD2CC"
Cc: git@vger.kernel.org, peff@peff.net, gitster@pobox.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 20 16:38:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBn4k-0005yl-F5
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 16:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168Ab3HTOiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 10:38:22 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:38514 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097Ab3HTOiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 10:38:21 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so262013eaj.25
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 07:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=TKqeFs5VyhfF7USqczzeC75f7vFdPhXsNZKEjHPX3f4=;
        b=vtB6QsKaJLGBmJYUjDF14dEqgurseqxtBH7qYmZh0i8ZQvT7nH8MaMTXQXMqloohR0
         76iQ7MBIV1BgZ0L89xgLQV32zsO8a6pyy/ak1er8SlHIJgK6oMhD02CyonLWqjexySeI
         n/KBc0Tldzgxeo6c1mnbwbDb2Gqg98LEDnhCg2RAjLic+/eU7X+Ep0nAFjGnZchowgjl
         yCU3s96XZS6Xsxd8j73OlZ/V4911gblUSgjXKdNJzdzMZYe5WWxCUNin35PP8Z+5mzpO
         ReAxtwyNTC1dsJtbUXi3+LPJLVVjPMsU/lVIjwROc8aH5UaTy7Flg2nbVl3wEmYWcd4q
         6wrg==
X-Received: by 10.14.4.1 with SMTP id 1mr2861764eei.21.1377009498696;
        Tue, 20 Aug 2013 07:38:18 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a43sm2836616eep.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 07:38:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <871u5o785o.fsf@linux-k42r.v.cablecom.net>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232607>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig48D66C3CB9ECA842866AD2CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/20/2013 04:23 PM, Thomas Rast wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> As I am resending the patch, could somebody please explain me
>> the mechanism of the "# repo-abbrev:" line? Even git itself doesn't
>> use it in the .mailmap file, but a quick google search shows up only
>> kernel repositories.
>=20
> I had no idea (we really lack documentation on this), but some history
> digging shows this:
>=20
>   commit 7595e2ee6ef9b35ebc8dc45543723e1d89765ce3
>   Author: Junio C Hamano <junkio@cox.net>
>   Date:   Sat Nov 25 00:07:54 2006 -0800
>=20
>       git-shortlog: make common repository prefix configurable with .ma=
ilmap
>      =20
>       The code had "/pub/scm/linux/kernel/git/" hardcoded which was
>       too specific to the kernel project.
>      =20
>       With this, a line in the .mailmap file:
>      =20
>           # repo-abbrev: /pub/scm/linux/kernel/git/
>      =20
>       can be used to cause the substring to be abbreviated to /.../
>       on the title line of the commit message.
>      =20
>       Signed-off-by: Junio C Hamano <junkio@cox.net>
>=20
> It apparently serves to abbreviate commits coming from pull requests,
> with a subject like
>=20
>   Merge branch 'release' of git://git.kernel.org/pub/scm/linux/kernel/g=
it/lenb/linux
>=20

Thanks for looking through the history, I need to adapt my search pattern=
s. ;)

Personally I have the feel this is a very kernel specific, but also=20
useful thing to have. So I would definitely not drop it, but maybe move
it to another place, such as in the .git/config file.=20
Then anybody can configure it themselves and maybe even have multiple
abbreviation lines possible.
It's very likely nowadays that there are repos at various different
hosting sites, so just one abbreviation would not cut it anymore.

Or as Jeff just mentioned in his email, it's there for historical
purpose, but not needed anymore as git-merge produces nicer commit
messages there.

As proposed I checked recent kernel history and saw:

$ git log --min-parents=3D2 --oneline=20
d6a5e06 Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-3.=
0-fixes
7067552 Merge branch 'x86-urgent-for-linus' of git://git.kernel.org/pub/s=
cm/linux/kernel/git/tip/tip
e91dade Merge branch 'timers-urgent-for-linus' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/tip/tip
fbf2184 Merge branch 'drm-fixes' of git://people.freedesktop.org/~airlied=
/linux
3387ed8 Merge tag 'drm-intel-fixes-2013-08-15' of git://people.freedeskto=
p.org/~danvet/drm-intel
d2b2c08 Merge branch 'drm-fixes-3.11' of git://people.freedesktop.org/~ag=
d5f/linux
50e37cc Merge branch 'for-3.11-fixes' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tj/cgroup
a08797e Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/=
kernel/git/tytso/ext4
2620bf0 Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm=

359d16c Merge branch 'for-3.11' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/geert/linux-m68k
0f7dd1a Merge tag 'clk-fixes-for-linus' of git://git.linaro.org/people/mt=
urquette/linux
2d2843e Merge tag 'pm-3.11-rc6' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/rafael/linux-pm
f43c606 Merge tag 'sound-3.11' of git://git.kernel.org/pub/scm/linux/kern=
el/git/tiwai/sound
89cb9ae Merge tag 'usb-3.11-rc6' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/gregkh/usb

in their .mailmap it read:
	# repo-abbrev: /pub/scm/linux/kernel/git/

So the abbreviation doesn't take place, can this feature be turned off?
I'm still confused by that feature.

Thanks,
Stefan




--------------enig48D66C3CB9ECA842866AD2CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSE39ZAAoJEJQCPTzLflhqHx0P+wRCNKBUWwuBPdF1UkVqOLBq
mmHbZ7yqVa9l62kf0jvc0M+gRckQjyvv2vt6JwQvz1Nn6Vx5K1Y0tFFOLz9kv/bd
CmuNlIdxBlQQTKa13jhAckbKYfKA8SHilqUlda2Ju2Z1WjSwOOeSC0x/eOoJwXLD
gCMtQhrvMCBPYyLw48K0IA6umIUIQ1YoFobsBWwnydjdPVseohlv21KgqQNGH2BP
l0wDbEXnVFfJT31+v8qhhpyre0UwQIk50TsGsp8JUVLEmoVEE5zQO98m2Rv7VAdL
EqQgSvmZTfobz7XQoymm1rNg5v8nlMCeEVoQWm+yV1kPsObFnPAFzPKOaNgM9cxe
O1YVxO4DRKSHhGtscnP18q2dUj4FUnkoUhKVxbf0efRFGwwrPJpKdTz/NLwpNgR0
cFqeb33F70eBGr84lIxBFYE61oXJujboijncobj8EanHAZCM3Ou/Jq08M7r1nupn
Gx7+iyD0YDFgy4J+Koi6sCU99HAUuafVz0lOvX5f48mKQWk4KOTCLLgdPNBpaX9c
cfOP0VPQ6k0s30O1RYV2hHL3NMSlvQedMzIGEPDoS3azuERZif3CNojo/i8k1JFe
qELYp0gknBUrEaOjmDB3gq90S88UPo8VktagUnSj6Ia2v48eYTY8c5ZbdNkHV8r6
aeiwGiY8ZRibPVHEtRtX
=3siD
-----END PGP SIGNATURE-----

--------------enig48D66C3CB9ECA842866AD2CC--
