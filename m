From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1304: fall back to $USER if $LOGNAME is not defined
Date: Fri, 14 Oct 2011 11:41:02 -0700
Message-ID: <7vobxjza9t.fsf@alter.siamese.dyndns.org>
References: <4E98750D.1020106@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Oct 14 20:41:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REmh0-0002M9-9c
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 20:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab1JNSlI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 14:41:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44435 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754693Ab1JNSlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 14:41:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E7105527F;
	Fri, 14 Oct 2011 14:41:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VLE022Ruy7z3
	0h0wJv21yYowHiY=; b=mHvWcdUwpvZzX3Y5VbBIRYwkC+mevl5kD+yF6Vi2MJBP
	uYVP5i9vmXsMeR0J94AMwtUqNTWDJLAjUbkFPeU16lnSAhIe5g9MH7wmljZQfpCd
	faEdpq1YAJtH4Zrm5YZeGwo0JtSIzHFpvzNM4eTab+Lpe+vlLWl9Ok08cg9/BXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=n+ur5R
	ZDyRDeNFqJizMlqBUeyr1DVRWeDpCF3CF3fpjn4OxNMG4RawhVjyG2ZGDDX1UMXe
	BE5tL7XuPRPQXL34Q3p/Ul67cqI4HqXOIisKnXDFNB83JZq1aVv2bWlinYr5damY
	qQU8mcfEIUG2UotHI136qfeeDtWLI8wH6nCzM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE0D527E;
	Fri, 14 Oct 2011 14:41:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54DBA527D; Fri, 14 Oct 2011
 14:41:04 -0400 (EDT)
In-Reply-To: <4E98750D.1020106@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Fri, 14 Oct 2011 19:44:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 124ABAE4-F694-11E0-8342-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183593>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> For some reason $LOGNAME is not set anymore for me after an upgrade f=
rom
> Ubuntu 11.04 to 11.10.  Use $USER in such a case.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> The only other use of $LOGNAME is in git-cvsimport, which does the sa=
me.

While the change to assign $USER to $LOGNAME when the latter is not set=
 is
not wrong per-se, I have to wonder (1) why this test should use LOGNAME
not USER in the first place, and (2) why you lost LOGNAME.

LOGNAME
The system shall initialize this variable at the time of login to be th=
e
user's login name. See <pwd.h> . For a value of LOGNAME to be portable
across implementations of POSIX.1-2008, the value should be composed of
characters from the portable filename character set.

Will apply anyway. Thanks.
