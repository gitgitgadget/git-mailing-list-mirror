From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix git format-patch --cc=<email> format
Date: Sat, 28 Feb 2009 18:24:50 -0800
Message-ID: <7vk57aasjx.fsf@gitster.siamese.dyndns.org>
References: <1235824944-4967-1-git-send-email-bergwolf@gmail.com>
 <76718490902280815if1c3fa7o790112b410d52224@mail.gmail.com>
 <7vy6vqfp0p.fsf@gitster.siamese.dyndns.org>
 <20090301010116.GA20255@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, Peng Tao <bergwolf@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 03:26:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdbNz-0003pG-6x
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 03:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbZCACZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 21:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbZCACZA
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 21:25:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42101 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbZCACY7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 21:24:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25F502DCE;
	Sat, 28 Feb 2009 21:24:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6AABD2DCD; Sat,
 28 Feb 2009 21:24:52 -0500 (EST)
In-Reply-To: <20090301010116.GA20255@coredump.intra.peff.net> (Jeff King's
 message of "Sat, 28 Feb 2009 20:01:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 28306144-0608-11DE-9F35-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111807>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 28, 2009 at 09:29:58AM -0800, Junio C Hamano wrote:
>
>> >> If there are multiple --cc=3D<email> arguments, git format-patch =
will generate
>> >> patches with cc lines like:
>> >> =C2=A0Cc: <email>,
>> >> =C2=A0 =C2=A0 =C2=A0<email>
>> >> which git send-email fails to parse.
>> >> git send-email only accept formats like:
>> >> =C2=A0Cc: <email>
>> >> =C2=A0Cc: <email>
>> >> So change git format-patch to generate patches in a proper format=
=2E
>> >
>> > This is fixed in next, but we fixed send-email instead to handle t=
he
>> > messages that format-patch generates, as they should be valid.
>>=20
>> Per RFC2822 3.6 (pp 19-20), "cc" is to appear at most once (same is =
true
>> for "to" and "bcc").  I think fix to format-patch is necessary regar=
dless
>> of what send-email does.
>
> Then isn't the current format-patch output (folding the cc over
> multiple lines) correct, and the patch (outputting multiple cc header=
s)
> wrong?

Ahh, sorry I misread what the commit message was saying and the patch w=
as
doing.
