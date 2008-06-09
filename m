From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] builtin-remote: make reuse of code easier by not die()ing
Date: Mon, 09 Jun 2008 22:43:16 +0200
Message-ID: <484D95E4.4090903@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <484D5322.6050309@free.fr> <alpine.DEB.1.00.0806091733230.1783@racer> <484D6128.1010800@freesurf.fr> <alpine.DEB.1.00.0806091856180.1783@racer> <484D7860.6050301@free.fr> <alpine.DEB.1.00.0806092110020.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 22:44:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5oDt-0002RJ-4t
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 22:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbYFIUnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754641AbYFIUnQ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 16:43:16 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:46809 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237AbYFIUnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 16:43:16 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 0742D12B6F6;
	Mon,  9 Jun 2008 22:43:15 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B1A1812B6BD;
	Mon,  9 Jun 2008 22:43:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806092110020.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84424>

Johannes Schindelin a =E9crit :
>=20
> 	Wow, that patch was hard ;-)

This is just what you wanted? I'm a little disappointed. ;-)

> 	BTW this thread shows -- again -- how hard it is to push toward=20
> 	libification.  People seem to actively block it.

I don't see how this patch will solve the real problem. You just hide t=
he die()
because get_fetch_map() still can die() and you add dead code. Now, the=
 next
person that will use get_ref_states() will think it always return. Seem=
s worse
to me.

IMHO, if you really want to libify you have to really analyze what shou=
ld be
done. Split the work in coherent steps, write some specs to explain whe=
re you
want to go, how you planed to do it and why?

If you want to go this way, I'm ready to help you to do the hard work.

Olivier.
