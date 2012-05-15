From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] completion: add new __git_complete helper
Date: Tue, 15 May 2012 10:01:42 -0700
Message-ID: <7v62bxfkeh.fsf@alter.siamese.dyndns.org>
References: <1337009718-1164-1-git-send-email-felipe.contreras@gmail.com>
 <7vvcjyhd5n.fsf@alter.siamese.dyndns.org>
 <CAMP44s1pb+J_SAzZ66QVcWq4V=LauUQ2VmzMD8KBtnhjubkkVg@mail.gmail.com>
 <7vmx5ahbrm.fsf@alter.siamese.dyndns.org>
 <CAMP44s1h=MPT8vx6JrGjMZWJzRjndxYKoYgo+1Y_Mmv+gWXzaQ@mail.gmail.com>
 <7vaa1ah95p.fsf@alter.siamese.dyndns.org>
 <CAMP44s2L=s4bd-sDcY3RWLWe9=YzLgC7UavgnE6K0akMCJSK4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 19:02:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUL8N-0006M7-P7
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 19:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933268Ab2EORB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 13:01:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757304Ab2EORB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 13:01:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A31B8595;
	Tue, 15 May 2012 13:01:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nyW4izOhiwc+apaHNYbCcm4TaEM=; b=Xf6a7r
	NcHhsbaYoA/ytS3eEW7/XEDWTiKGaLjSJ5B3zGBO/fIhR/5xYW34cGksBa+8cgi3
	dFRDkV5kr7ADlAyar6lIyk6W9lydQRerZRCWGaDwg5T1nHjvdaO++b6+Zl0fodiF
	eJBhZzTr9x0g+fJwHfKHDhDnsdq+T0fgI3YyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r6scXgHETvLIPY8FJF9nqPcQyTYeuPpP
	t3JCOqyLmgWs2tcTlr9u3qTzLqVXwU2ix0VdL8xNnhjhO9x+yujxK4zvvQwgROxa
	mbLHs97NtmNYiSLvCNM+Ja/3eqlO/BFbo2SAEao8yH4toNrtf4N0UyRfCrsJ/SVB
	HHi4z8g28j0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 109128593;
	Tue, 15 May 2012 13:01:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 930128592; Tue, 15 May 2012
 13:01:56 -0400 (EDT)
In-Reply-To: <CAMP44s2L=s4bd-sDcY3RWLWe9=YzLgC7UavgnE6K0akMCJSK4w@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 14 May 2012 21:53:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD8F307A-9EAF-11E1-A6CB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197841>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, May 14, 2012 at 9:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>> Here is my attempt to explain why none of them needs to be quoted:
>>>> ...
>>> I don't understand that.
>>
>> That was my attempt to give the readers some context to understand what
>> comes after that....
>
> I mean I don't understand this "Note that none of the variable
> reference in the implementation of this function needs dq around it."

You later say "then yeah, I agree.", so I am interpreting this "I don't
understand" to mean that you do agree that missing dq around $1, $2 and
$wrapper in the function is _not_ a problem, and you do not understand why
it needs to be explained.  See below.

> I suppose you meant 'references' (as that would make it grammatically
> correct AFAICS),...

Correct.

> but I still don't understand what you are trying so
> say. That the way the arguments are used in the __git_complete
> function makes it so double quotes are irrelevant?

Correct.

> If so, then yeah, I agree.
>
> Is there something actionable?

Like adding an explanation, preferrably a better one, there, so that the
next person do not have to wonder and waste time like I did?
