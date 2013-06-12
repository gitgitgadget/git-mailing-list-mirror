From: John Keeping <john@keeping.me.uk>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 13:52:26 +0100
Message-ID: <20130612125226.GP22905@serenity.lan>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
 <20130611125521.GL22905@serenity.lan>
 <vpqbo7c4wen.fsf@anie.imag.fr>
 <CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
 <CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
 <fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
 <vpqehc7y00a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu =?iso-8859-1?Q?Li=E9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmkXk-0000Nq-VL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab3FLMwq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 08:52:46 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55691 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab3FLMwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 08:52:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 46038CDA5B8;
	Wed, 12 Jun 2013 13:52:44 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5I5bFuio9xWL; Wed, 12 Jun 2013 13:52:36 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 104F7CDA57E;
	Wed, 12 Jun 2013 13:52:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqehc7y00a.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227612>

On Wed, Jun 12, 2013 at 02:41:25PM +0200, Matthieu Moy wrote:
> Mathieu Li=E9nard--Mayor <mathieu.lienard--mayor@ensimag.fr> writes:
>=20
> > $ git status
> > # HEAD detached from ecb9f3e
> > # You are currently editing a832578... my_commit_message [3/5] whil=
e
> > rebasing.
>=20
> Showing the commit message here is too much IMHO. With a typical
> 50-characters message, it already gives
>=20
> # You are currently editing a832578 _________________________________=
_________________ [3/5] while rebasing
>=20
> and we usually try to fit everything on a 80-columns terminal.
>=20
> My vote would go for just showing the short sha1. The user can run "g=
it
> show $sha1" to get more information if needed, it's just a copy-paste
> away. If we want to show the commit message, it should be on its own
> line.

I agree.  I liked your earlier suggestion of adding something like
"(applying 1d3fb08, 2/5)".  Where "applying" should be "cherry picking"
or "reverting" when appropriate.

I actually think this should be the only change to the default status
output, additional information on the full list of commits being applie=
d
should either come from "git rebase --status" or some new flag to "git
status" which is off by default.
