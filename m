From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the 
 --compose flag
Date: Sun, 09 Nov 2008 21:18:38 -0800
Message-ID: <7vbpwo88gh.fsf@gitster.siamese.dyndns.org>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com>
 <200811091513.55544.fg@one2team.com>
 <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site>
 <7viqqwa6wo.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Francis Galiegue <fg@one2team.com>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 06:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzPCG-0001Cv-VH
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 06:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbYKJFS6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2008 00:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbYKJFS6
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 00:18:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbYKJFS6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2008 00:18:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 93E3B96290;
	Mon, 10 Nov 2008 00:18:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 95C1F9628D; Mon,
 10 Nov 2008 00:18:41 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0811091910570.21142@sys-0.hiltweb.site> (Ian
 Hilt's message of "Sun, 9 Nov 2008 19:38:30 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12B97DD2-AEE7-11DD-B136-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100489>

Ian Hilt <ian.hilt@gmx.com> writes:

> On Sun, 9 Nov 2008, Junio C Hamano wrote:
>> Ian Hilt <ian.hilt@gmx.com> writes:
>>=20
>> > On Sun, 9 Nov 2008, Francis Galiegue wrote:
>> >> Le Sunday 09 November 2008 13:59:48 Ian Hilt, vous avez =C3=A9cri=
t=C2=A0:
>> >> > +	if ($c_file =3D~ /^To:\s*+(.+)\s*\nCc:/ism) {
>> >>=20
>> >> Greedy operators are only supported with perl 5.10 or more... I t=
hink it's a=20
>> >> bad idea to use them...
>> ...
>> You expect something non-blank there anyway, so why not do:
>>=20
>> 	To:\s*(\S.*?)\s*\n....
>
> That works.  Although, I seem to be missing Francis' point.  Accordin=
g
> to perlre, a quantified subpattern is "greedy".  So a "greedy operato=
r"
> is any one of the standard quantified subpatterns.  The "+" and "?"
> modify its matching behavior.  And it seems to me that it _has_ to us=
e a
> q.s. to work ...

The "perlre" documentation you are reading is from Perl 5.10.0; check
"perldelta" documentation next to it.

I think you are wrong in saying that "it _has_ to use".  Yes, you _can_
use possessive quantifiers to write that pattern (provided if you can
limit your users to Perl 5.10.0 or later), but you do _not_ have to (an=
d I
just showed you how).  By not using the new feature, you can make it wo=
rk
for people with older version of Perl.

Not everybody who uses git can upgrade their Perl to newer versions.  W=
e
try to stick to "5.6.1 or later"; anything that is not available in 5.8
series is too new to be used outside the contrib/ area.

That's the point Francis raised that you missed. =20
