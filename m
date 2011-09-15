From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] make-static: master
Date: Wed, 14 Sep 2011 21:29:54 -0700
Message-ID: <7vk49aqvgd.fsf@alter.siamese.dyndns.org>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk>
 <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
 <CALkWK0=TovazpdOvS_va7L0Fv=HcAc9x1-f+LEH_mXgKa-wCQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 06:30:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R43aO-0008Vd-ID
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 06:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab1IOE36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 00:29:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077Ab1IOE36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 00:29:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 694035C72;
	Thu, 15 Sep 2011 00:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vpk7oYZd12X+
	bkMpzLCeBlo54h0=; b=FJZtdXZC4kMP5f2LqYAho10OL8Zz4+OhTfXLanJ/NNap
	4RfWLV0foMzENP7bV2t+Y+WucYcIgBUNkLyme9acN1kWXLbqe+f5p8kWGEfJqoJd
	OXmLSqkVI28rCNTE+5q6ZNjfmy5JbHX+CjSln4ny8870Tj9rXGr36eISN7ICVns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=U3ylHw
	z+3P6p+c13Jm7W5q5LkxzeH4NmAEYIcy6lPPESauLWgz2g06PBi1DPH01yWE22X0
	mwh7alaSMn0OK5mBro2b2Ezji2EBd9YUfclibGrHWtqNpnjock8AW4QSpaItt8DG
	F7vILUNZy5BY+1dv4LgFSv6HVn5sAc9E9V40s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60AC75C71;
	Thu, 15 Sep 2011 00:29:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3B305C70; Thu, 15 Sep 2011
 00:29:55 -0400 (EDT)
In-Reply-To: <CALkWK0=TovazpdOvS_va7L0Fv=HcAc9x1-f+LEH_mXgKa-wCQg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 12 Sep 2011 11:44:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5D160DD8-DF53-11E0-A1AA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181434>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano writes:
>> Many symbols that are exported to the global scope do not have to be=
=2E
>>
>> Signed-off-by: Junio C Hamano <junio@pobox.com>
>> ---
>> =C2=A0  To be applied on top of 3793ac5 (RelNotes/1.7.7: minor fixes=
, 2011-09-07)
>> [...]
>
> Awesome!  I've seen many similar "make-static" patches come up on the
> list, but turned down due to code churn issues.  I'm happy to finally
> see it being merged.

Not so fast.

We just got a new series from Brandon Casey that adds a new caller to o=
ne
of the functions that were unused outside a file. Seeing that this happ=
ens
even inside a relative calm of pre-release feature and code freeze,
realize why we call such a change a "churn" and try to avoid it, and
imagine how much damage it would have caused if more topics were active=
ly
being updated.

You should learn to tame your enthusiasm ;-)
