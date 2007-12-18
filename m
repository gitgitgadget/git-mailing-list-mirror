From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 12:07:48 -0800
Message-ID: <7vk5nbzrzf.fsf@gitster.siamese.dyndns.org>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
	<4767ED52.9010004@viscovery.net> <4767EE6D.5070509@obry.net>
	<alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:08:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ik0-0002Pr-6A
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXLRUIH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 15:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXLRUIG
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:08:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbXLRUIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 15:08:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AB1C15069;
	Tue, 18 Dec 2007 15:07:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E195068;
	Tue, 18 Dec 2007 15:07:50 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712180840060.21557@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 18 Dec 2007 08:50:01 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68800>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 18 Dec 2007, Pascal Obry wrote:
>
>> Johannes Sixt a =C3=A9crit :
>> > that we need another diff option for it. Ok, on my keyboard 0 is t=
yped
>> > with the right hand, and 1 with the left hand, but... ??
>>=20
>> Because you just did not read my follow-up message :)
>>=20
>> I need this has I do not have the way to change the server applying =
the
>> patch. So nothing wrong with my hands or fingers :)
> ....
> So I think you'd need separate arguments for the from/to prefixes, an=
d not=20
> try to shoehorn it into one argument. With possibly some simple form =
to=20
> say "no prefix". So maybe something like
>
>   --src-prefix=3D<string>		// default "a/"
>   --dst-prefix=3D<string>		// default "b/"
>   --no-prefix			// shorthand for --src-prefix=3D"" --dst-prefix=3D""
>
> would work for everybody?

One worry I have is that "diff --git" is validated more strictly than
other diffs by "git-apply", and patches generated with arbitrary prefix
would break it.  It might make sense to drop " --git" from the patch
header if we allow a/ and b/ to be changed inconsistently.
