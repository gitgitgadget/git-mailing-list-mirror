From: Christian Brabandt <cblists@256bit.org>
Subject: Re: Mark trailing whitespace error in del lines of diff
Date: Tue, 26 May 2015 18:29:37 +0200
Message-ID: <20150526162937.GA24439@256bit.org>
References: <9b8e349e223dc9cd871fc5f7915e590548322932.1432585659.git.cb@256bit.org>
 <20150525222215.GI26436@vauxhall.crustytoothpaste.net>
 <xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 26 18:51:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxI4P-0007Sn-ND
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 18:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755425AbbEZQvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2015 12:51:07 -0400
Received: from 256bit.org ([144.76.87.176]:46387 "EHLO 256bit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817AbbEZQvB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 12:51:01 -0400
Received: from chrisbra by 256bit.org with local (Exim 4.76)
	(envelope-from <cblists@256bit.org>)
	id 1YxHjV-00005d-GY; Tue, 26 May 2015 18:29:37 +0200
Content-Disposition: inline
In-Reply-To: <xmqqbnh89r0z.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: cblists@256bit.org
X-SA-Exim-Scanned: No (on 256bit.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269952>

Hi Junio!

On Mo, 25 Mai 2015, Junio C Hamano wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I like this idea.
>=20
> I don't.
>=20
> > My use case is determining whether a patch to a pristine-tar
> > repository introduced trailing whitespace (which is not okay) or
> > just left it there (which is okay).
>=20
> In your use case, where keeping trailing blank that is otherwise not
> OK is fine only when the breakage was inherited from the preimage,
> wouldn't it be equally fine to keep other kinds of breakages as long
> as they were inherited from the preimage?  E.g. "The original used
> 8-space as leading indent, and you would not use that for your new
> lines, but the breakage was inherited from the preimage" would want
> to be treated the same way, no?  Why trailing blanks so special?

It was the one I am interesting in and also the one that I usually try=20
to avoid ;)

(In fact, I thought if the other options would be needed, one could add=
=20
additional suboptions for core.whitespace as well, so one would be able=
=20
to exactly say, what kind of things one would like to see and which=20
could be different for new lines and old lines).

>=20
> So, from that point of view, your "use case" does not justify this
> particular implementation that special-cases trailing blanks on
> deleted lines and mark them [*1*].

>=20
> If the implementation were addition of a new option to check and
> mark all kinds of errors core.whitespace would catch for new lines
> also for old lines, then it would be a somewhat different story.  I
> personally do not find such an option interesting, but at least I
> can understand why some people might find it useful.

Wouldn't that mean, that one couldn't see different kind of whitespace=20
markings for newlines and deleted lines? I don't know, if one would wan=
t=20
that a configuration however.

However, as I don't know the codebase very well, I doubt I can implemen=
t=20
this.

> [Footnote]
>=20
> *1* To support your use case with the ultimate ease-of-use, it would
> be best if the new option were to squelch the whitespace error on
> the new line when it was inherited from the old line, which is
> different from showing and marking the breakage on the old line.
> But I do not think it can be implemented sanely, so I will not go
> there.

Aside from the difficulties it would take to do this,
personally, I don't like this option. Because I like to see such=20
problems, but just want to know whether a particular patch has=20
introduced the problem or not.

Best,
Christian
--=20
In den Fragen im gemeinen Leben, wie man etwas am besten tun k=C3=B6nnt=
e,
wird ein gewisses Maximum gesucht.
		-- Georg Christoph Lichtenberg
