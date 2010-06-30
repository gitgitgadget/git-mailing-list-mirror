From: Sam Vilain <sam@vilain.net>
Subject: Re: notify alternative to auto gc?
Date: Wed, 30 Jun 2010 14:27:18 +1200
Message-ID: <1277864838.23613.18.camel@wilber>
References: <EA7717AE-DA72-48D7-A27E-C958896FD158@gmail.com>
	 <AANLkTil8sHZrfvHetwzjhOsyprsqrf7-XRS3B8qKH7cs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl Stenerud <kstenerud@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 04:29:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTn3U-0002Bj-78
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 04:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0F3C1N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jun 2010 22:27:13 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:51068 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752363Ab0F3C1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 22:27:12 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 179E6FCD32; Wed, 30 Jun 2010 14:27:12 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FH_DATE_PAST_20XX autolearn=no version=3.2.5
Received: from [IPv6:::1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 446B4FCD2D;
	Wed, 30 Jun 2010 14:27:08 +1200 (NZST)
In-Reply-To: <AANLkTil8sHZrfvHetwzjhOsyprsqrf7-XRS3B8qKH7cs@mail.gmail.com>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149936>

On Mon, 2010-06-28 at 16:26 +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
> On Mon, Jun 28, 2010 at 16:10, Karl Stenerud <kstenerud@gmail.com> wr=
ote:
> > The git help tells me I can disable it by setting gc.auto to 0, whi=
le the mailing list archive tells me I also have to set gc.autopacklimi=
t to 0.  This is fine, but if I do that, I won't know when the repo is =
in need of cleanup.  Is there any option I can set to instruct it to si=
mply TELL me when it's in need of gc?
>=20
> Anything that tells you whether you need to gc would incur much of th=
e
> speed penalty that running gc itself does.

See builtin/gc.c:too_many_loose_objects

Checking that gc is required involves opening one directory (objects/17
IIRC), reading all of the entries in it and counting them.  It really
doesn't hurt.

Sam
