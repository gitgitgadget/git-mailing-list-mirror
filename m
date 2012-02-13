From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support wrapping commit messages when you read them
Date: Mon, 13 Feb 2012 14:25:29 -0800
Message-ID: <7vzkcmbcbq.fsf@alter.siamese.dyndns.org>
References: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com>
 <7vfwg99dom.fsf@alter.siamese.dyndns.org>
 <46957CEB-5E48-4C11-8428-9A88C3810548@sidneysm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sidney San =?utf-8?Q?Mart=C3=ADn?= <s@sidneysm.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 23:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx4L3-0003nR-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 23:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492Ab2BMWZc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 17:25:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab2BMWZb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 17:25:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BFD699B;
	Mon, 13 Feb 2012 17:25:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=U7khGRGGQKxa
	H8Wf6HSowe0AUXM=; b=I8mmbYR+o2/JfGII5Maiwmqofg7ogthNhydG4Dbbp9hi
	zz4Ve1eYcIbi4pozFcaw5wALTejsdHcaQmy8cpeDj4vebZRJyxJFkHkilvH03bUx
	5/XZOSEp7+pgGQfYqa4rcoc/LFnwrIDhgUGqQ1XZeB4Np9vAcS67oqtAf4iWBRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bVtXc/
	3VF7wb59Xp3dbRP+wBd+MeHizZ68dmD2LrZYt5WzTP7v8qBQDvjMb75FFXY2NeJv
	jjUuHE6GU2uV3bTeAwweWlxbBvOm/zg4GGwdoRk7ZZ06FoiToCUHWFnM7qS7tAA3
	cv9nR5fVgz4volur6hRxTJgooINPPXV5W5FzE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA31B699A;
	Mon, 13 Feb 2012 17:25:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79C916999; Mon, 13 Feb 2012
 17:25:30 -0500 (EST)
In-Reply-To: <46957CEB-5E48-4C11-8428-9A88C3810548@sidneysm.com> ("Sidney San
 =?utf-8?Q?Mart=C3=ADn=22's?= message of "Mon, 13 Feb 2012 16:26:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A323A884-5691-11E1-9927-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190680>

Sidney San Mart=C3=ADn <s@sidneysm.com> writes:

>> After all, SCM is merely a method to help communication between
>> developers, and sticking to the common denominator is a proven good =
way to
>> make sure everybody involved in the project can use what is recorded=
 in
>> the repository. This is not limited only to the log message, but equ=
ally
>> applies to filenames (e.g. don't create xt_tcpmss.c and xt_TCPMSS.c =
in the
>> same directory if you want your project extractable on case insensit=
ive
>> filesystems) and even to the sources.
>>=20
>> You need to justify the cause a bit better. Why is such a new logic
>> justified?
>
> You=E2=80=99re right, that sentence doesn't say anything.
>
> I agree that projects need to have standards for their commit message=
s,
> but I also think that line wrapping should be taken care of by the
> computer so that the humans can think about the content of their comm=
it
> messages. It's easier for everyone.

I just typed M-q to wrap the above paragraph from you to make it readab=
le.

"Computers are good at automating" is true, and that is why real editor=
s
give an easy way to auto-wrap long prose in a paragraph while composing=
=2E
But "computers are good at automating" is not a convincing justificatio=
n
to let the composer leave unreasonably long lines in the commit log obj=
ect
and force the reader side to line-wrap the mess only to fix it up.
