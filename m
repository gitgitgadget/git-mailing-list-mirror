From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Merge commit subjects git.git
Date: Sun, 18 Jul 2010 21:03:18 +0300
Message-ID: <20100718180318.GA22033@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AANLkTikavL0DH8FgFxBw7hbGLtj2tqxnP-BT77zo5FJT@mail.gmail.com>
 <201007181733.59704.trast@student.ethz.ch>
 <AANLkTinTOMxWVM9kwhIfcG44SqOjpexY-Xy6kZYkemU9@mail.gmail.com>
 <AANLkTim4FxPdHsDxkRmHzJT24LnZyiv9xLUqbTUndS9T@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYD0-0003jl-0a
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756833Ab0GRSDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:03:20 -0400
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:41660 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827Ab0GRSDT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jul 2010 14:03:19 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 34F4AEBDE3;
	Sun, 18 Jul 2010 21:03:18 +0300 (EEST)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A04D812F55B; Sun, 18 Jul 2010 21:03:18 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id D4CB727D89;
	Sun, 18 Jul 2010 21:03:10 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <AANLkTim4FxPdHsDxkRmHzJT24LnZyiv9xLUqbTUndS9T@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151226>

On Sun, Jul 18, 2010 at 05:22:01PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> On Sun, Jul 18, 2010 at 16:56, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
> >
> > Wow, I thought the only place where we gave "master" any special
> > meaning was in that we create it as the default branch. Can't we fi=
x
> > this to be less hard-coded?

There's yet another place as well, but its only related to obsolete pre=
-1.5
stuff that has very little use anymore.
=20
> I.e. master is also treated more magically than others when
> cloning. But I couldn't find the code that does this, so perhaps it
> doesn't do that.

Its guess_remote_head of remote.c (checked v1.7.2-rc3+). Additionally, =
it
appears that if master doesn't tie for exact match, then first ref in l=
exical
order is choosen (if master ties for exact match, then it is chosen).

Additionally, it appears that if exact HEAD symref information is avail=
able
(not all protocols support that), then that is choosen with no guessing=
=2E

-Ilari
