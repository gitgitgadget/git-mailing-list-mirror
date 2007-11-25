From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] builtin-add: fix command line building to call interactive
Date: Sun, 25 Nov 2007 20:02:33 +0100
Message-ID: <22CBC161-57C2-4A7E-9415-CE8117758A44@wincent.com>
References: <1195996542-86074-1-git-send-email-win@wincent.com> <7vd4tynqpw.fsf@gitster.siamese.dyndns.org> <F09249EB-475A-4352-A3A1-A8B15D2A94FF@wincent.com> <7vlk8mmatu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 20:03:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwMl5-0003qU-7N
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 20:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbXKYTCw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 14:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755035AbXKYTCw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 14:02:52 -0500
Received: from wincent.com ([72.3.236.74]:36802 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754392AbXKYTCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Nov 2007 14:02:51 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAPJ2YkP018364;
	Sun, 25 Nov 2007 13:02:35 -0600
In-Reply-To: <7vlk8mmatu.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65983>

El 25/11/2007, a las 19:36, Junio C Hamano escribi=F3:

> I _think_ the only remaining thing is --patch, and none of the =20
> pathspec
> thing is needed.

You're probably right; the pathspec validation is probably not =20
necessary (and you may recall that my original patch didn't include =20
it; I only tried adding after you said it might be appropriate to have =
=20
the "--error-unmatch" behaviour). This is probably more convenient for =
=20
the user, as it allows them to pass "sloppy" parameters like the =20
following:

	git-add -i *.h

(Note that's "*.h" and not "\*.h"). In the Git repository, without =20
validation, this just works. With strict validation, it would complain:

	error: pathspec 'common-cmds.h' did not match any file(s) known to git=
=2E

So just forgetting about the validation is probably the right thing to =
=20
do.

As for adding the --patch option, I'll stand back and see if someone =20
more skilled than I wants to do it; should only be a few lines and =20
will save traffic to the list because they'll probably get it right =20
first time.

Cheers,
Wincent
