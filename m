From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, RFC] diff: add option to show context between close
	chunks
Date: Tue, 21 Oct 2008 07:20:40 -0400
Message-ID: <20081021112040.GB17363@coredump.intra.peff.net>
References: <48FB757B.9030105@lsrfire.ath.cx> <7vabcy3k9l.fsf@gitster.siamese.dyndns.org> <48FD781C.2000103@viscovery.net> <7vskqqzajy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 13:22:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsFJE-000449-6h
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 13:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbYJULUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbYJULUn
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 07:20:43 -0400
Received: from peff.net ([208.65.91.99]:1893 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbYJULUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 07:20:42 -0400
Received: (qmail 19670 invoked by uid 111); 21 Oct 2008 11:20:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 21 Oct 2008 07:20:41 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Oct 2008 07:20:40 -0400
Content-Disposition: inline
In-Reply-To: <7vskqqzajy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98774>

On Tue, Oct 21, 2008 at 12:12:17AM -0700, Junio C Hamano wrote:

> Yeah.  Ren=C3=A9 wanted this for _human consumption_, not mechanical =
patch
> application, so "hardcoding" literally there in the very low level of=
 the
> diff callchain is not quite right (it would affect format-patch which=
 is
> primarily for mechanical application).
>=20
> I guess you could make the hardcoded value 1 for everybody else and 0=
 for
> format-patch.

I see your reasoning, but at the same time, a large portion of patches =
I
read are from format-patch (and Ren=C3=A9 even said that he was trying =
to
save the user from the "apply then diff just to look at the patch"
annoyance). And I have personally, as a patch submitter, created some
format-patch output sent to the git list with -U5 to combine hunks and
make it more readable for reviewers.

Not to mention that I sometimes apply or post the output of "git diff".

To me that it implies that either:

 - the increased chance of conflict is not a problem in practice, and w=
e
   should have the option on by default everywhere

 - it is a problem, in which case we should ask the user to turn on the
   feature manually instead of second-guessing how they will use the
   resulting patch (which they might not even know, since they are
   making assumptions about how other people might use the patch, and
   they must decide for their situation between shipping something that
   is more readable but slightly more conflict prone, or as easy to
   apply as possible)

-Peff
