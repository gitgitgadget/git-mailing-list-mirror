From: Junio C Hamano <gitster@pobox.com>
Subject: Re: make install error
Date: Thu, 28 Jan 2010 00:56:36 -0800
Message-ID: <7vockemwu3.fsf@alter.siamese.dyndns.org>
References: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
 <7v8wbjndn6.fsf@alter.siamese.dyndns.org>
 <81b0412b1001280048y6f91ad25t5c636f959630825@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kap4lin <kap4lin@gmail.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 09:56:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaQBH-0006tw-Fg
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 09:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0A1I4q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 03:56:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752327Ab0A1I4q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 03:56:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589Ab0A1I4p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 03:56:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CDBA93837;
	Thu, 28 Jan 2010 03:56:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CtaC2F4MS/JO
	z198o35PLJ0CLKg=; b=W7g2Cb4sDDU2//lP2g6QZENwz1TED9+sIDiAU+IaYV+P
	MJdyNkWlpJLvGXveHT8xBfbxMZkOL/BzgjMj1a54Dg9yBRGNcfeNnTvdx22jkW+m
	6a56a3VcTPwRpV8ZtZ1I1P5/TGp+nie8R3MfeImNpRQrnpleBMUVsNKLbXA0Pb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bjjRx7
	s5j4Vsx3e2FwJiBmVe6t6Fy36ktXrxKKvaXeWK56wGOX6EIZ0QWQLg8EJ/zSfViL
	nQqG1jBe0VHOogqXv/WeSR4n+QzcDb6pglKMjUWZy7s4nC/B5p+E7+I1QFR3RLLJ
	WobJ+6e8yrf511ryn4madA2v2DBHoG6GQgAIA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A52093831;
	Thu, 28 Jan 2010 03:56:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 868959382F; Thu, 28 Jan
 2010 03:56:37 -0500 (EST)
In-Reply-To: <81b0412b1001280048y6f91ad25t5c636f959630825@mail.gmail.com>
 (Alex Riesen's message of "Thu\, 28 Jan 2010 09\:48\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D5646A6-0BEB-11DF-8523-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138230>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Thu, Jan 28, 2010 at 03:53, Junio C Hamano <gitster@pobox.com> wro=
te:
>> kap4lin <kap4lin@gmail.com> writes:
>>
>>> (cd blt && gtar cf - .) | \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cd '/scratch/kap4lin/usr/share/git-cor=
e/templates' && umask
>>> 022 && gtar xof -)
>>> gtar: This does not look like a tar archive
>>
>> Perhaps "unset CDPATH".
>>
>
> BTW, will "cd ./blt &>/dev/null" also help and prevent this problem f=
rom
> happening ever again?

Except that (1) it would be ">/dev/null", and (2) why contaminate Makef=
ile
command lines with such unreadability to work around stupid misdesign o=
f
CDPATH?

I _could_ live with something like this that won't affect the main part=
 of
the Makefile, though.

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index af08c8f..20b0b34 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,10 @@
 # The default target of this Makefile is...
 all::
=20
+# Work around CDPATH exported to the environment that would
+# break "(cd there && tar cf - ) | tar xf -" and the like.
+CDPATH :=3D
+
 # Define V=3D1 to have a more verbose compile.
 #
 # Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
