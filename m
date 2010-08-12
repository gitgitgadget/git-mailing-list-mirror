From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 15:08:46 -0700
Message-ID: <7v62zfqya9.fsf@alter.siamese.dyndns.org>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C63BD9B.6000608@viscovery.net>
 <AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Aug 13 00:09:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjfxZ-0000cX-QU
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 00:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933977Ab0HLWJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 18:09:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342Ab0HLWJH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 18:09:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D072CC2CF;
	Thu, 12 Aug 2010 18:09:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BfGmIgkTI0Gp
	mEL+HQ3D4CfPRH0=; b=gLtrsBE9sk/y/LmzbALJ2xe5ed3gALc/0ME6C5SSQOkK
	WkSRDEr4aHe7lsRqoRebBFv3dJfXyxkiCMspxSHpO+SicXp2pqRKf4rnnYw21XM6
	9uUXhGJ2E+aQhmL/KvG9FVUWZ1A0WkaXBXYK9rNThv+yBDsolpYq6QkJNXfRZaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=WlB+ld
	XFDfN2e8J56Q5GuWpEgfTB/laZucTx8DLxYlvvlF/+I4IzyCkdDMo1aT64sS1oUi
	Y1cWwPNhqnvgOlJIXHwsUsD8q7byPWtR9GmRpwbv6r6Zv8KfsWe9wevMZo1wS+wJ
	5klgx/z85r7xOuhMhvW/rYbDBoMgUlS+E32UM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBACCCC2C9;
	Thu, 12 Aug 2010 18:08:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4329ECC2C3; Thu, 12 Aug
 2010 18:08:48 -0400 (EDT)
In-Reply-To: <AANLkTi=MenKX7Eh5PTpjfiYirrgLBCamWgorA35rx-Fy@mail.gmail.com>
 (Greg Brockman's message of "Thu\, 12 Aug 2010 05\:37\:33 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 33AF0618-A65E-11DF-9CE2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153428>

Greg Brockman <gdb@MIT.EDU> writes:

>>> * gb/shell-ext (2010-07-28) 3 commits
>>> =C2=A0- Add sample commands for git-shell
>>> =C2=A0- Add interactive mode to git-shell for user-friendliness
>>> =C2=A0- Allow creation of arbitrary git-shell commands
>>
>> This needs work on Windows because we do not have geteuid(), perhaps=
 just
>> a compiler flag -Dgeteuid=3Dgetuid
> I had a submitted a revised patch that just uses HOME, see
> http://thread.gmane.org/gmane.comp.version-control.git/152050/focus=3D=
152135.
>  I guess that didn't make it in yet.

No, it didn't; because you said

    Err, actually it would probably be a good idea to
    s/char *home =3D getenv("HOME");/const char *home =3D getenv("HOME"=
);/

    Greg

hinting me not to pick it up.
