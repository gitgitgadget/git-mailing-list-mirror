From: Christian Brabandt <cblists@256bit.org>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 18:31:08 +0200
Message-ID: <20150526163108.GB24439@256bit.org>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
 <xmqq617g9oer.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 18:51:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxI4J-0007PR-B9
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 18:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963AbbEZQvC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 12:51:02 -0400
Received: from 256bit.org ([144.76.87.176]:46386 "EHLO 256bit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbbEZQu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 12:50:59 -0400
X-Greylist: delayed 1279 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 May 2015 12:50:59 EDT
Received: from chrisbra by 256bit.org with local (Exim 4.76)
	(envelope-from <cblists@256bit.org>)
	id 1YxHky-00009S-6k; Tue, 26 May 2015 18:31:08 +0200
Content-Disposition: inline
In-Reply-To: <xmqq617g9oer.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cblists@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269951>

Hi Junio!

On Mo, 25 Mai 2015, Junio C Hamano wrote:

> Christian Brabandt <cblists@256bit.org>, Christian Brabandt
> <cb@256bit.org> writes:
>=20
> > As far as I can see, this does not break any tests and also the=20
> > behaviour of git-diff --check does not change.=20
>=20
> Even if this change introduced a bug that changed the behaviour
> (e.g. say, exited with failure status code when only preimage had
> errors), I wouldn't be surprised if no existing test caught such a
> breakage.  Because the existing tests were written with the
> assumption that the code to check whitespace breakages would never
> look at preimage, it is plausible that no preimage line used in the
> test has any whitespace error in the first place.
>=20
> In other words, you'd need to add new tests that change preimage
> lines with various kinds of whitespace errors into postimage lines
> with and without whitespace errors, and run "diff" with various
> combinations of the existing set of core.whitespace values as well
> as your new one.
>=20
> But as I said in the other message, I think that the approach this
> patch takes goes in a wrong direction.  Instead of adding a single
> "check and highlight this and only kind of breakage on preimage"
> option as a new kind to existing "what kind of use of whitespaces
> are errors" set, it would be more sensible to add a single "check
> and highlight breakages on preimage lines as well" option that is
> orthogonal to the existing ones that specify "what kind of use of
> whitespaces are errors".

Oh well, too bad. It sounded like a good idea...

Best,
Christian
--=20
Unser Gef=C3=BChl f=C3=BCr Natur gleicht der Empfindung des Kranken f=C3=
=BCr die
Gesundheit.
		-- Friedrich Johann Christoph Schiller
