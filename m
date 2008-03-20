From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path" config var
Date: Thu, 20 Mar 2008 08:49:14 +0100
Message-ID: <200803200849.14664.chriscool@tuxfamily.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org> <7vabkv7t4c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 08:44:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFS6-0003Hl-Uc
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbYCTHno convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2008 03:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755618AbYCTHno
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:43:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:33266 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755373AbYCTHnl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 03:43:41 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1F5E41AB309;
	Thu, 20 Mar 2008 08:43:39 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D7CED1AB313;
	Thu, 20 Mar 2008 08:43:38 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vabkv7t4c.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77639>

Le mardi 18 mars 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This makes it possible to use different version of the tools
> > than the one on the current PATH, or maybe a custom script.
> >
> > In this patch we also try to launch "konqueror" using
> > "kfmclient" even if a path to a konqueror binary is given
> > in "man.konqueror.path".
>
> It may be true that allowing customizable paths may be more useful th=
an
> not allowing them, so I do not have fundamental objection to this
> enhancement.  However, I doubt this s/konqueror/kfmclient/ is a good
> idea.
>
> As a general rule, if you allow the user to explicitly say "instead o=
f
> what you would normally use, use _this_", you should not try to outsm=
art
> the user by using something else that you derived from that "_this_" =
the
> user gave you.
>
> If the user wants to use kfmclient, then the user can say so. =20

Yes, but if the user just wants to use a konq that is not in the path, =
then=20
the konq specified with "man.konqueror.path" should behave the same as =
when=20
using the konq in the path. That means that we should also try to open =
a=20
new tab on an existing konq, and this will not be the case if we=20
use "/path/konqueror URL" instead of "/path/kfmclient newTab URL".

> If the
> user wants to really launch konq instead of using kfmclient for whate=
ver
> reason, the outsmarting code will interfere and make it impossible.

I think it will still be possible using custom commands. I am working o=
n the=20
patch. It should be ready in a few days.

Thanks,
Christian.
