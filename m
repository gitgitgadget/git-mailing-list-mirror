From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce receive.denyDeletes
Date: Fri, 31 Oct 2008 07:30:22 -0700
Message-ID: <20081031143022.GQ14786@spearce.org>
References: <20081030191134.62455c24@perceptron> <20081030183210.GO14786@spearce.org> <20081030194503.2f9ece1a@perceptron> <7v63n99omx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Krrrger <jk@jk.gs>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 15:31:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvv2H-0008Qx-NW
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 15:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYJaOaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Oct 2008 10:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbYJaOaY
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 10:30:24 -0400
Received: from george.spearce.org ([209.20.77.23]:36462 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350AbYJaOaX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 10:30:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D3AC93835F; Fri, 31 Oct 2008 14:30:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v63n99omx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99589>

Junio C Hamano <gitster@pobox.com> wrote:
> "Jan Kr=FCger" <jk@jk.gs> writes:
>=20
> > Can I then delete the branch afterwards without lots of juggling (i=
n
> > case the test fails due to a random other reason that the branch
> > accidentally getting deleted by receive-pack)? I'd expect I'd have =
to
> > save the exit code to a temporary variable and that's just as ugly.

If you want to delete the branch after the test is done, do it
outside of the test_expect_success's 3rd argument.  Then it will
run the branch deletion whether or not the test was successful.
=20
> Although I agree that your attempt to allow the test continue even wh=
en
> this test fails is a very good practice, I personally do not find the
> alternative you mention ugly at all.  I actually find that "return 1"
> uglier because it feels like it knows too much about how
> test_expect_success is implemented.

Yea, I also found the "return 1" to be horribly difficult to read, and
knowing far too much about the test suite.

--=20
Shawn.
