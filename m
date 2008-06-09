From: Olivier Marin <dkr@freesurf.fr>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 09 Jun 2008 17:43:47 +0200
Message-ID: <484D4FB3.2090309@freesurf.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer> <484C901B.6000401@free.fr> <alpine.DEB.1.00.0806090330490.1783@racer> <484CAE95.3020008@free.fr> <alpine.DEB.1.00.0806090551070.1783@racer> <484D3C90.2050009@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 17:44:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5jY4-0002GJ-Tm
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 17:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbYFIPnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 11:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752322AbYFIPnu
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 11:43:50 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:38337 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbYFIPnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 11:43:50 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 94EEC12B6DA;
	Mon,  9 Jun 2008 17:43:48 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B269E12B73A;
	Mon,  9 Jun 2008 17:43:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <484D3C90.2050009@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84395>

Olivier Marin a =E9crit :
> Johannes Schindelin a =E9crit :
>=20
>> I would not like to remove the got_states.  I think this is the wron=
g=20
>> direction.  Rather change the die() into a return error().
>=20
> OK, I will try that.
>=20

After reading some more code, I can say that changing die() in return
error() won't change anything here because, in get_ref_states() we only
die() if get_fetch_map() return an error. But guess what, get_fetch_map=
()
never return an error. It just die() or return 0. And I can't change it
without breaking "clone" and "fetch".

So, what I think is:

  Those changes are not in the scope of my patch. I can provide an othe=
r
  one for that, if you really care about. But IMHO it's not a problem t=
o
  die(). Maybe we can simply remove the if () die().

  I will send a v2 patch with the changes we both agree.

Olivier.
