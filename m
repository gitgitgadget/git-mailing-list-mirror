From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 10:35:12 -0800
Message-ID: <7vipjer0yn.fsf@alter.siamese.dyndns.org>
References: <4F3472F4.4060605@aegee.org>
 <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
 <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
 <4F34EF9D.8030509@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Fri Feb 10 19:35:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvvJa-0001R0-D5
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 19:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759678Ab2BJSfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 13:35:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759332Ab2BJSfO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 13:35:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6006F6D1C;
	Fri, 10 Feb 2012 13:35:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D08YsPNvHa2FwCFrVZtSIf8O7I8=; b=in64L8
	cjB3q18g/8GUeLxTXcVmfQdGWhKNmu5Gad99L3G+EZ44m9lHS3IoRTwLibSQ7EJA
	8BC1NOmLjzXxYh8zPJa1JPutnYX3Wo2PzO4wfSGg3pKDBXez1cvTnMVSNy1JDrqg
	5pIE4HGSYHvhGbU4/J0BEO6z5K+fsalvswzIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DE4F42n+AHBtjiANhzVjdjKnEcyjc1KI
	8MiHfWpXiF/iy7E6cxzQH2SrbZWCDz995hV02F2XYdSbh6+esfgJ7/CSSqHpDoNo
	89zA5IzdwO5mSN0I074U6tVeKLiIXFWbTWdijFpP4bbjgdrya8MNft6ARcHlluoR
	Ff4wn/wHi1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 555B96D1B;
	Fri, 10 Feb 2012 13:35:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA2F46D1A; Fri, 10 Feb 2012
 13:35:13 -0500 (EST)
In-Reply-To: <4F34EF9D.8030509@aegee.org> (=?iso-2022-jp?B?IhskQiclGyhC?=
 =?iso-2022-jp?B?GyRCJ1onXSdxJ18bKEIgGyRCJzEnUSddJ1EnZSdZJ2AnUxsoQiIncw==?=
 message of "Fri, 10 Feb 2012 11:21:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F88FD618-5415-11E1-9477-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190434>

Дилян Палаузов <dilyan.palauzov@aegee.org> writes:

>>> What I am wondering is there are systems that need to include the header,
>>> but locale_charset() does not live in /lib/libcharset.a, in which case we
>>> cannot make HAVE_LIBCHARSET_H imply use of -lcharset.
>
> I do not understand this.  If you want to use a function from
> libcharset, you have to use both #include <libcharset.h> and
> -lcharset.

You are mistaken.

The only constraint is that you have to "#include <libcharset.h>" and need
to link with the library that has locale_charset() defined.  Does everybody
has that function in -lcharset, or a system you do not know have it in some
other library?

For example, Msysgit part defines HAVE_LIBCHARSET_H but it apparently does
not need -lcharset. It could be that the port is incomplete, but another
possibility is that perhaps the function is in part of libc and does not
even need -lcharset passed to the linker.

If you look at our Makefile, you see "On this platform foo() can be
obtained by linking with -lfoo, but on this other platform you need to
link with -lbar" gotchas around some libraries (e.g. ssl/crypto), and I am
wondering if this function has a similar issue.
