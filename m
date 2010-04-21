From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff too slow for a file
Date: Tue, 20 Apr 2010 19:49:31 -0700
Message-ID: <7vzl0xcyf8.fsf@alter.siamese.dyndns.org>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx>
 <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx>
 <7vd3xuinbe.fsf@alter.siamese.dyndns.org> <4BCE1983.4020009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org,
	Paolo Bonzini <bonzini@gnu.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Apr 21 04:49:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Q0f-000536-3g
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 04:49:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab0DUCto convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 22:49:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40442 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0DUCtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 22:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED838ACD35;
	Tue, 20 Apr 2010 22:49:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hvh56f7ifMgH
	qgU6T1zf2kuezcE=; b=w+j7YvmN8fHL3EKUbwoYQ5zo+AAlDrd8VUDMXpU6mXfU
	GuCX8CqXNyOFeUCGvG1K+KCzqcOmR6x5EKrq6rLPrcoyZd2Uv0a2d/6+L26rzYCh
	HDQgHdUz8+uJEukX0QAiG9IdOMSI5K4d/IRM4x7hIK70eHFLthHCCqbTCTC/W4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oGTmRO
	X32AfU8AzBx6wh6vktTCB+tbmN5VRZTZwX3rm3XYILJGQtXKEet9Qm92gjgwPJrd
	NlmaAvlVZwqR5bjXutLOMbsDUtnVGeoZfltP2+TrrA0kI2eHKwWNt1vlDv/ToK7H
	HQEi7vyLGDn6EJulz7AlPy93IY8ki3+xJnhNE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A7BC7ACD33;
	Tue, 20 Apr 2010 22:49:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1E18ACD31; Tue, 20 Apr
 2010 22:49:32 -0400 (EDT)
In-Reply-To: <4BCE1983.4020009@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue\, 20 Apr 2010 23\:15\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 867C8D42-4CF0-11DF-9BBE-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145403>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Turning XDF_NEED_MINIMAL off by default looks like the sane thing to =
do
> in order to help the fringe cases without hurting the normal ones.
>
> A --slow/--minimal/--try-harder option for git diff could come in han=
dy
> for longer patches, though.  GNU diff has it, too (-d/--minimal).
>
>> I expect that there will also be some differences in the blame outpu=
t.
>
> I haven't looked at the impact on blame, but additionally patch IDs a=
re
> going to change (for those patches where XDF_NEED_MINIMAL makes a
> difference).  Are they stored somewhere?  Do we need to worry about t=
hem?

Patch-IDs are purely transient inside core-git as far as I know, but I
wouldn't surprised if people keep database of patch-IDs and correspondi=
ng
commits to somehow speed up change look-ups.

Theoretically, conflict IDs used to index the rerere database would als=
o
be affected, but I don't think it is such a huge issue.
