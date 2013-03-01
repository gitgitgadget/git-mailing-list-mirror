From: William Giokas <1007380@gmail.com>
Subject: [bug report] git-am applying maildir patches in reverse
Date: Fri, 1 Mar 2013 16:20:18 -0600
Message-ID: <20130301222018.GA839@WST420>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 01 23:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBYK0-0000Px-7m
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 23:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484Ab3CAWUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 17:20:30 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:60821 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3CAWU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 17:20:29 -0500
Received: by mail-ia0-f175.google.com with SMTP id k38so919367iah.20
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=WYxhChehXTnz/Pn3tVZOUXp0m70M16atow06hkKw5Sw=;
        b=LdndsTMhztaMkY7RuO2tYzlE4IhLzI52KY3BVqdmFZjsQ5FgDOAcN89EL2D0k/MLBW
         MvdEdReYcG3iYR81Ef7Y15lvqYlCVzj3uV6++DFn4ysEW9JnFc7899e/3TI9bptnb080
         hTjSrnDKBqByTcQXc1bIQ7BCOtTLsPK3OJFTTpHLwqxBmeXDOzgbOCA/YxBiU5lH9RYh
         Y/AnPrGyGI/vYpw94qa9D+cJgw3fLAc2TAZVi+FDWrleqYReG9DhqOGts6AMwu3jgnn7
         tVQ99RNdoVqPb1h7YoE0s6yvTjyosQ6cR1wEk4kxGIIfY7Uaqbb5WZfP/2hLu4UHMqBV
         tedg==
X-Received: by 10.42.204.79 with SMTP id fl15mr8077062icb.57.1362176429401;
        Fri, 01 Mar 2013 14:20:29 -0800 (PST)
Received: from localhost (adsl-99-141-208-216.dsl.emhril.sbcglobal.net. [99.141.208.216])
        by mx.google.com with ESMTPS id wo8sm283473igb.6.2013.03.01.14.20.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 01 Mar 2013 14:20:28 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217298>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All,

I've been using git for a while and this is the first time I've had to
use `git am` and I've got a 16 patch patchset that I'm looking to apply.
The files were copied to a separate maildir by mutt to keep things
clean, and then I ran `git am -i /path/to/maildir/` expecting things to
start from the patch with the subject=20

    [PATCH 01/16] refactor common code in query_search/sync_search

But instead, it starts with the 16/16 patch and works backwards, which,
obviously, breaks the application process as the patches depend on each
other. I looked in the maildir directory just to see if the file names
were backwards, and that's not the issue. I talked to `gitster` on IRC
and he said to send in a bug report on this issue here. The patchset I'm
trying to apply can be found here[0].=20

Process to reproduce:
* find a multi-patch set with interdependent patches
* run `git am` on the maildir containing these patches

Expected result:
* Apply patches in [01..N] order

Actual result:
* Patches applied in [N N-1..01] order

[0]: https://mailman.archlinux.org/pipermail/pacman-dev/2013-March/016541.h=
tml

Thank you,
--=20
William Giokas | KaiSforza
GnuPG Key: 0x73CD09CF
Fingerprint: F73F 50EF BBE2 9846 8306  E6B8 6902 06D8 73CD 09CF

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRMSmiAAoJEGkCBthzzQnPf98P/0enYqpRsiiFS8PrsC1p55Kk
tAISixF6D0MYTA0UHHNxjvL+l/jcIsMlmqlu5YVcoTmhcX2/+Fz4agk4WjaiwkEh
dTGP4T8OH2rz8ILFpfdZZ3MN1zUcxqm0GWtgKR6R481+jfZpJaDaJRMJ5Z/3rbC8
i1mDUmUyYnD1IIz9SVt4qAP0eztbKOdpFOUqEw9s+PzCP8P61k0/sTWj5F+FSMz8
nIn44dGqeeYySy3Y4PjlWOQaMP6WiapWI1SB4EiyvQRVmanHk2zHr0jpeIKRTbgM
AZ5xc2JwB8PcwE3hSqb5nP9zOAPCYmdiw9DCfc9Wsw8D/RZRymGafgSW0wDQutdJ
Xd8CTLCjPoj7KCuRiFSjraM3l1rvRrVQyegF4tWFPITBv9ziyHDmWSgZxXtUJEUy
UctBdxJx1vpT/ImyuCVMW6NJEQ720TtDB02gKZN2i4Os2DA2eIS/u2RfbcSWprUN
v8clCJHI22VZxIeu+2vzk1nnqwFzIhz0WxLFf+Y9Dq1tUxILc706Pi2x7dUnU33H
9TDO51qMrlWbRTSxdD6YT7xP8jXwifpURKQK4exlTdmDnxm9LPFqyMKNCsS7sDe5
R4acthU3JYSGfEnqSHg2tMBd8BmFsoQV63mQaKhSdR9LAEb6TPxPf4srbZiBf4eU
3wH1lkUUXH7LFVhj7Ffc
=K5X3
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
