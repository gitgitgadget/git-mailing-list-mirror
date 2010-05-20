From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git, Mac OS X and German special characters
Date: Thu, 20 May 2010 10:50:31 +0200
Message-ID: <4BF4F7D7.60002@drmicha.warpmail.net>
References: <4BF4E40B.30205@math.tu-dortmund.de> <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: matthias.moeller@math.tu-dortmund.de, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 10:51:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OF1TV-00038l-GP
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 10:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab0ETIur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 May 2010 04:50:47 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:38770 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755185Ab0ETIuq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 May 2010 04:50:46 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3E671F7344;
	Thu, 20 May 2010 04:50:23 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 20 May 2010 04:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=akrCDpWa6n+qzuKAN9EVblzOcns=; b=Qu1w5dtj3EnfGeBAIDQqNSiVjnPBGhGCY9ze+SJd7ayQsPpz0yRQRgVQviALDi3l/mTeami5xPqoOoe4dkywz7YsVtqF2pdyPGf87YemP7jinO7qZ2qZ624F4zrOm6OFhElArGCKJ/lGd/s8dCESVzWglLjhFFkNjLfmNSTIlF0=
X-Sasl-enc: p0EwB/sEWU6XWW9rWogXTan8af5iyh229eb98DCHzApI 1274345422
Received: from localhost.localdomain (p548498FC.dip0.t-ipconnect.de [84.132.152.252])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4E00C4A76A5;
	Thu, 20 May 2010 04:50:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <AANLkTimYgkv6q6fTXqNOCq1ZbodxgCZ18Fum_NryyiO8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147364>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.05.2010 1=
0:34:
> On Thu, May 20, 2010 at 07:26, Matthias Moeller
> <matthias.moeller@math.tu-dortmund.de> wrote:
>> I have been searching the web for help and found lengthy discussions
>> which state that this is a common problem of the HFS+ filesystem.
>> What I did not find was a solution to this problem. Is there a solut=
ion
>> to this problem?
>=20
> Is this problem particular to Git, or do you also get it if you
> e.g. rsync from the Linux box to the Mac OS X box?
>=20
>> #       "U\314\210bersicht.xls"
>=20
> You probably have to configure your shell on OSX to render UTF-8
> correctly. It's just showing the raw escaped byte sequence instead of
> a character there.
>=20
> There isn't anything wrong with OSX in this case, filename encoding o=
n
> any POSIX system is only done by convention. You'll find that you hav=
e
> similar problems on Linux if you encode filename in Big5 or
> UTF-32.
>=20
> Linux will happily accept it, but your shell / other applications wil=
l
> render it as unknown goo because they expect UTF-8.

No, the problem with git status is not the display. Matthias' problem i=
s
that git status reports a tracked file as untracked. The reason is that
on HFS+, you create a file with name A and get a file with name B, wher=
e
A and B are different representations of the same name. There seems to
be no way to reliably detect which one HFS+ uses.

Michael
