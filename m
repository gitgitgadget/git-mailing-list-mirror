From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Why does git-patch-id(1) sometimes print two lines, one of which
 has commit = 0000000000000000000000000000000000000000
Date: Wed, 16 Feb 2011 17:11:42 +0100
Message-ID: <4D5BF73E.50002@drmicha.warpmail.net>
References: <AANLkTimHvA_LsU4YaiDHDKoXnsk5WgGCXgbuSJ99emXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 17:14:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppk1n-00043Y-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 17:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab1BPQOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 11:14:50 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45204 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752669Ab1BPQOt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 11:14:49 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8314520950;
	Wed, 16 Feb 2011 11:14:48 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Wed, 16 Feb 2011 11:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=WUwvH/379oE5lCjUUIXBufPcN08=; b=eBbofhqH1G0EmF8y+KoLROR7vi8lavL9HZrhAJyUuEdoegu2E1F0Hxj5a80hZntAgdoYWItUJSdRpQs3r2+ALk43AMEcoFGizlq9bqkkD+iwKhzppcER5cbuwr+QhZ9HxU+uUmuCVWXWTcTYp0yJRVDv+XpG+4DP0iv2z+O6Qqk=
X-Sasl-enc: OODNzGAcJb8le/Drnyu9Jf0KW90k6sOislMKkM1IiVzA 1297872888
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0364F402A6D;
	Wed, 16 Feb 2011 11:14:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTimHvA_LsU4YaiDHDKoXnsk5WgGCXgbuSJ99emXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166972>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 16.02.2011 1=
5:56:
> This behaves as I'd expect on git.git, i.e. shows a patch id and the =
commit id:
>=20
>     $ git show 24231e063f0f003f8ffd7b64c7ba6a0baaaa5283 | git patch-i=
d
>     f10c69e0e5b33da206f37bd93639875555ac9b79
> 24231e063f0f003f8ffd7b64c7ba6a0baaaa5283
>=20
> But what does this mean, also on git.git:
>=20
>     $ git show 7d48e9e6f77d336376c1a554eeff0590f77e1ee1 | git patch-i=
d
>     4ba8a248731c5fcbd09cacb248d3128e742d1c90
> 7d48e9e6f77d336376c1a554eeff0590f77e1ee1
>     d019b35e0b859cdd6907ee170927de1124c0ed6e
> 0000000000000000000000000000000000000000
>=20
> 7d48e9e6f77d336376c1a554eeff0590f77e1ee1 is just one of the commits
> that results in this output:
>=20
>     $ git log --pretty=3Dformat:%H -p | git patch-id | grep
> 0000000000000000000000000000000000000000
>     d019b35e0b859cdd6907ee170927de1124c0ed6e
> 0000000000000000000000000000000000000000
>     3b23a2a11055aef557369971e825010879a8c4d7
> 0000000000000000000000000000000000000000
>     d498fbbad6f1374d952925df699da237c3e8f2df
> 0000000000000000000000000000000000000000
>     b0c930dc1926ffae9cca022797856762fa908be6
> 0000000000000000000000000000000000000000

You're telling us that patch-ids, not the sha1's of affected commits he=
re.

>=20
> And on another repository where I'm dealing with this I have a bunch
> more of them.
>=20
> Why are they there and what do they mean? Maybe it's a bug, or
> something I can explain in the manual page.

You would have to explain that git-patch-id trips over "\ Now
newline..." lines in our diffs. Alternatively, wait a few minutes for m=
y
patch (done) with a test (the boring part...).

Cheers,
Michael
