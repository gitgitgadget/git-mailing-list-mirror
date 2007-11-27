From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 09:22:54 -0800
Message-ID: <7vbq9fd2mp.fsf@gitster.siamese.dyndns.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
	<Pine.LNX.4.64.0711271109130.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix49e-0001XA-SC
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 18:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbXK0RXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 12:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758243AbXK0RXF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 12:23:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52172 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996AbXK0RXD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 12:23:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 667172EF;
	Tue, 27 Nov 2007 12:23:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id BD22F9A50F;
	Tue, 27 Nov 2007 12:23:18 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711271109130.27959@racer.site> (Johannes
	Schindelin's message of "Tue, 27 Nov 2007 11:12:45 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66244>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 27 Nov 2007, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=
=81=AA=E3=81=93 wrote:
>
>> Quoting Andreas Ericsson <ae@op5.se>:
>>=20
>> > "git pull --rebase" already has an implementation. Dscho cooked on=
e up
>> > which I've been using since then. It works nicely.
>>=20
>> What is the reason that the option was not added to the official git=
? =20
>> Was it coded poorly, buggy or were there some other issues?
>
> It is very well possible that it was coded poorly ;-)
>
> The main reason, I believe, was that some old-timers who know the=20
> implications said that it would encourage a wrong workflow.  One thin=
g=20
> that could go possibly wrong, for example, is to rebase commits that =
you=20
> already published.
>
> So AFAICT it was deemed not only giving people rope, but making that =
rope=20
> look like a necklace to them.

Hmph, that is different from how I remember, and the "workflow" argumen=
t
would not be something I would make if we were having that discussion
today.

I think what happened was that we took a misguided detour to make this
an option to "git merge" (which was _my_ mistake IIRC, sorry), which di=
d
not pan out well (because rebase is not "a different form of merge").
After that for some reason we failed to follow-up on the topic.  We
could have gone back to the original "a pull is integrating following a
fetch, and the integration does not have to be merge" approach to see i=
f
it was workable, but we didn't.

If people find it useful, I do not think of a huge reason to object to
the inclusion.  "Give them rope" is good ;-)
