From: Amadeusz =?utf-8?B?xbtvxYJub3dza2k=?= <aidecoe@aidecoe.name>
Subject: Re: [PATCH] git-p4.py: Make submit working on bare repository
Date: Sun, 28 Feb 2016 20:46:44 +0000
Message-ID: <87si0cpnpn.fsf@freja.aidecoe.name>
References: <CAPig+cQA4sJ2RneG8zRsUx+bDPAMYVtmhFjZx5SOGDqnsKNUaQ@mail.gmail.com> <1455919074-5683-1-git-send-email-aidecoe@aidecoe.name> <xmqq7fi0b9rt.fsf@gitster.mtv.corp.google.com> <87fuwnd4u7.fsf@freja.aidecoe.name> <xmqqbn7aa522.fsf@gitster.mtv.corp.google.com> <877fhwd1g0.fsf@freja.aidecoe.name> <xmqqegc33oal.fsf@gitster.mtv.corp.google.com> <CAE5ih7_vBMsi+zRZRTCaO56VrOYZUR0NQ0CSSE+Do48xkJ_BwA@mail.gmail.com> <871t83cfi7.fsf@freja.aidecoe.name> <CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 21:47:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aa8F4-0001od-O2
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 21:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbcB1Uqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 15:46:53 -0500
Received: from jim.zolnowski.name ([188.116.54.122]:49896 "EHLO
	jim.zolnowski.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881AbcB1Uqx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 15:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aidecoe.name; s=jim;
	h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From; bh=OCQrscSTCLWrtERlnCx2lI4M0YgtYQgIVDb6GYVL7TU=;
	b=xhBPN24YmdoMdAo0vIM2G4s4TawQhRSUTf2o70E+AqoUzVKhgxwwvmJowopZpxsVTDaG+HDtrjQRGEChBBzJISGgBdn1vYCnIRbxgx0dB2Di+nbzi6AszFXcuH7pXANK4glwvdw5Ue3JO68vSWH69I2WmLy1jUbV3eNhLuStdgPGX7Y3AH+J4Hl61o0Rw3R0SDJwj8GcnwlgEux4pU6rVLJ1tllTT0TwHbXO3fWi3i2+dXnmZy38LXUEfpCrOG8Rez5HHyHVzn9Psh9M593iuSJRB/RxupJmt8z6l1AnnGekmvLyqaFzz+1uHU2O9HDR16iNkEIeD/Uv+Z+J0QNUMw==;
Received: from cpc92302-cmbg19-2-0-cust189.5-4.cable.virginm.net ([82.1.208.190] helo=localhost)
	by jim.zolnowski.name with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.85)
	(envelope-from <aidecoe@aidecoe.name>)
	id 1aa8En-00041A-Sl; Sun, 28 Feb 2016 21:46:46 +0100
In-Reply-To: <CAE5ih7-rBuipoAGEnK60iidi1nYA9xWZQV6jRMHTVQe6f=cQag@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/24.5.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287791>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luke Diamand <luke@diamand.org> writes:

> On 23 February 2016 at 20:56, Amadeusz =C5=BBo=C5=82nowski <aidecoe@aidec=
oe.name> wrote:
>>
>> To simplify things, why not just update ref during submit from bare
>> repository? As you have pointed out, if user invokes submit in this
>> context he/she actually wants to submit from bare repo and probably
>> knows what he/she is doing - especially if he/she reads man page. (-:
>
> Will it do something sensible if anything goes wrong?
>
> I'm thinking about what happens if you submit and one of the commits
> fails to go to P4 due to a merge conflict.

Handling failures in this case is a bit tricky, indeed.


> But I guess just doing an update-ref could be an OK thing to do.
> Without actually trying it out for real though I can't be sure. It
> might make sense to get some practical experience of how this works
> out.

True. For now I have these cases covered by wrapper scripts. The minimum
I need from git-p4 is just not to fail on git submit from bare
repository which is covered by patch I have submitted. If I get my
solution enough testing, I'd think of transforming it into patch for
git-p4.py as well.

=2D-=20
Amadeusz =C5=BBo=C5=82nowski

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1

iQJ8BAEBCgBmBQJW01y1XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCMzcyRTFENjI5NUM1MzYwQTQwODQyRUZD
QkNDODAyM0Y1OUUxNzA0AAoJEMvMgCP1nhcEjTQP/286bSQYfJTf/GArW51SPLXP
zcLW444B8oXZLmiCU89q8hEO8rQp1lf+yxtF51v3+hGqmz53UgPiLDdqc9MLKm8s
k8J+fsK1s9BI5ZrX9YXI/hbUGQi7dnn7qi5XWV+WCtvwe2uW5kLhluIE/f0+EcrR
qY7c//OzrN0CCf+ko3GxQ7kkr9Te768SmAJXUbWng1IK0F7qGvLmai/9WHEaf5wj
ybAoPU0Vkf+FhcvRsSiVWbRWT+vy6pQ8OW5NnEeouq4gOH48y+5XNygfn0PANCmC
xebDm/g3SiIWznBLv+rtYc1sE6LgPXm50N+JKbTjnYj1H+lCaoO9kkqEU4maZYK6
i9i1SyoUWoDdOZmzWVbhGaDeBtnUjEyDjhNzB/nOppXDc5kN6Il/W7arqugoYgC/
yN6wmHSmFgbgX47wijthflNv71PUVGWmRUwqlumi8nGUpkDJNcmwGW3pFsSET9mT
Y1wJlxaTl6ojLmmbyyUIlc2AfuqkZrjQDfUYhX6mjpUdMi6ipdZ3tEkq6fzptTZ4
WejXTihRz0jaI1SwDdVdiuekirtyxpaoiXQI47EX3yJg3ClsaQZwZIRFN2x9YwDJ
W6Luv4OfwUnOWPO3nuwTsNZ8RbeWdmACAFu9IMky665My3GDBhMvrGUN11NUzmON
u9O+LPuyzoQE6/muWwXw
=O85b
-----END PGP SIGNATURE-----
--=-=-=--
