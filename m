From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] NetBSD 6?
Date: Tue, 08 Jan 2013 11:03:40 -0800
Message-ID: <7vy5g3cx9v.fsf@alter.siamese.dyndns.org>
References: <7vd2xn18p5.fsf@alter.siamese.dyndns.org>
 <rmipq1numzj.fsf@fnord.ir.bbn.com> <7vd2xnypt6.fsf@alter.siamese.dyndns.org>
 <rmi8v8av05d.fsf@fnord.ir.bbn.com> <7vvcbew895.fsf@alter.siamese.dyndns.org>
 <rmiobgz4icr.fsf@fnord.ir.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Greg Troxel <gdt@ir.bbn.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:04:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TseSx-0005bH-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 20:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970Ab3AHTDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 14:03:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756905Ab3AHTDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 14:03:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213B6B468;
	Tue,  8 Jan 2013 14:03:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g6xvknNk51G/M30D+Jcin90BUOo=; b=lv5tCV
	k1vC+ZXtNIhxVjKdNzdCl4uDsnf5IdCpEqcSn3eeX0efKJlepdRunW1nnzlqef8B
	K7fsQJHs7TOZ1PY2OtrnGJgJS7Q75BmnuPOrM1SD9AvB4J2q4v+exXkwE7WvWNfU
	EoK++M8r5okd7ysZaJUrUZF99MbYgK/5basM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMeKUKsrEJRTQvZvVo7ebcbn/RrVzb9A
	sctqMtwKKFgMMAHZRpxUkuHXWDql9PYbVw/q2qG3LhuZTMvaTwi8rZUNCY9Hytih
	mjGEeMJI0BFmUNF+LzTYU8ckQopu5mibRpTX6m0n35hfKH9M15dZUYbeZe7Au050
	/Ssp00JbPs4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16B1FB467;
	Tue,  8 Jan 2013 14:03:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50D5AB466; Tue,  8 Jan 2013
 14:03:42 -0500 (EST)
In-Reply-To: <rmiobgz4icr.fsf@fnord.ir.bbn.com> (Greg Troxel's message of
 "Tue, 08 Jan 2013 13:53:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E6CDF96-59C6-11E2-ADBD-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212998>

Greg Troxel <gdt@ir.bbn.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  [OLD_ICONV]
>
>> It refers to the type of the second parameter to iconv(); OLD_ICONV
>> makes it take "const char *", as opposed to "char *", the latter of
>> which matches
>>
>>   http://pubs.opengroup.org/onlinepubs/9699919799/functions/iconv.html
>
> I just wanted to follow up on this.  It turns out that the old POSIX
> standard was buggy (header file and function spec were different), and
> they resolved it in favor of non-const.  NetBSD followed the const way,
> and just now documented that with links to the standards email archives.
>
> Interestingly, GNU iconv 1.14 seems to define it as const also:
>
>   https://www.gnu.org/savannah-checkouts/gnu/libiconv/documentation/libiconv-1.14/iconv.3.html
>
> (which matches man/iconv.3 in the tarball).
>
> When I build libiconv-1.14, it produces a .h with const.  But it has a
> configure test to check if there is a host include file with const, and
> puts the const in the built header file or not to match!
> In include/iconv.h.in, there is:
>
>   extern size_t iconv (iconv_t cd,
>       @ICONV_CONST@ char* * inbuf, size_t *inbytesleft,
>        char* * outbuf, size_t *outbytesleft);
>
> Someday, it would be nice to have the configure test not fail an iconv
> implementation just because of the const, unless the presence of const
> is causing a real problem.  But I can understand that no one thinks
> that's important enough to get around to.

Interesting.

Don't get too offended by the "OLD_" prefix to that symbol, by the
way.  I do not think "old" means "old and broken hence fixed in
newer version and you are low life if you live on a platform that
has to define it" ;-).

We just needed to have a boolean to tell which variant it is to let
the compiler build objects without complaining, and we named that
switch as OLD_ICONV.
