From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Sun, 18 Mar 2012 17:29:55 -0700
Message-ID: <7v3995cu0s.fsf@alter.siamese.dyndns.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org>
 <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org>
 <7vipi1d9r7.fsf@alter.siamese.dyndns.org>
 <CACBZZX6_m6b3Abf=NhWvL_g5aHEG9xZEBFfc3K35aSRrUBeWOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Sayers <andrew-git@pileofstuff.org>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 01:30:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9QU8-0000W2-0v
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 01:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab2CSA37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 20:29:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54055 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756009Ab2CSA36 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 20:29:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C92C47592;
	Sun, 18 Mar 2012 20:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ibnFM+zCJeoK
	DYeURHZDP62Rx5M=; b=vOeaPC+Z0+a6fXj5nT7mjTxXY3WPobsw0ARrRM4YNA40
	l/OPfLPbAD5gJgyPYW3eni8MLgPjQCJn/wTlkdKt4opGQLqmWy936sbdQx4nlh4Q
	HKRF6kmRjmfWBiVfNEJQ1mLh0rXmnaU4h3nMq6mO52mwQY+95KJw/+Irx+nOtYA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sA7tmZ
	+D6bzgW9BOzwHcUm2YzX0VAF9Pw92yNhgtCL9J5K27Uf4ZpLcX+S+jxBozP/G2rT
	UjN0E+aQXtewW9CR+P3+bqk2WCNbScb2Ik9oBgNGZ4fV0l0+gdEfruUwD6lq93Ho
	pgpmyecvDBlf3XOlQJv44m0OEd5NvtiMdCRVM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0F087591;
	Sun, 18 Mar 2012 20:29:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 577C6758F; Sun, 18 Mar 2012
 20:29:57 -0400 (EDT)
In-Reply-To: <CACBZZX6_m6b3Abf=NhWvL_g5aHEG9xZEBFfc3K35aSRrUBeWOQ@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 18 Mar
 2012 22:26:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7C7A122-715A-11E1-835C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193403>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Most of our users are either never going to see this warning because
> their OS will skip the whole of steps 2-6, or worse yet their OS
> might upgrade Git between steps 2-5 and they'll be stuck watching the
> warning it for 1-6 years, or however long their upstream vendor takes
> up upgrade.
>
> I think a better strategy would be to just announce that we're going
> to change it, and then just change it without any intermediate
> steps.

You are only arguing that what we do does not matter much to Distro use=
rs,
and you already read that I agreed with that. It's really up to the dis=
tro
to make sure their release cycle does not harm the users.

But does that mean we won't have to help our own users who do not depen=
d
on distros with a gentler approach?  I don't think so.

Just like we say we would want to see Perl 5.8.3 or newer for unicode
purposes, it would be sufficient if our announce says Git 1.8.x and lat=
er
gives an updated default behaviour to help new people by avoiding a har=
der
to understand error modes when used in the simplest workflow.
