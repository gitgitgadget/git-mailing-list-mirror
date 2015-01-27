From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 broken under Mac OS X
Date: Mon, 26 Jan 2015 18:51:53 -0800
Message-ID: <xmqqh9vdlyuu.fsf@gitster.dls.corp.google.com>
References: <54B68D99.2040906@web.de>
	<xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
	<54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
	<xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
	<20150115222719.GA19021@peff.net>
	<xmqqa91j6537.fsf@gitster.dls.corp.google.com>
	<20150115235752.GB25120@peff.net>
	<xmqqh9vr4mlz.fsf@gitster.dls.corp.google.com>
	<CABPQNSYZMS+feX=jSxwOhr+P8isroct2=Dcw18LSjCYZUvug=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 03:52:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFwG0-00009m-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 03:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbbA0Cv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 21:51:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752529AbbA0Cv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 21:51:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FB7332E88;
	Mon, 26 Jan 2015 21:51:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pOptP/1n6WRtZ8jOpSM5MJlZK/A=; b=VJ6JLe
	ys/Ef9pWrvMXmqnCMkeUq+VZD2Vs54kTXG3Tk6gzjQx0ZmL30u6Sulji7UWLknPS
	rZkKk1ZtGp7T7HvZg4xAPMRs4PWAiJKH0PgeBDWPZq63XQR2T7CzG6u75ywmXM2S
	aryFF13qZkTlCES2EMcf9bkLIXEhPTa0TLKuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J/QbfEV47j4609wfZrwQKD6TYG4jSAQI
	3aO36UzMvyqiiLFc7VP3GFBYaWC67MjMjgR7Y+nZGPXj4GbycwPCaVW0hQ78ORJ9
	45pBcQZhByN3kFCA8MGrmloW48if9W9ge99EU+IFFScEC/Wu19q8DR42+GpSiA32
	bVSHBN2b54k=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 956D032E87;
	Mon, 26 Jan 2015 21:51:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F3B532E84;
	Mon, 26 Jan 2015 21:51:55 -0500 (EST)
In-Reply-To: <CABPQNSYZMS+feX=jSxwOhr+P8isroct2=Dcw18LSjCYZUvug=A@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 27 Jan 2015 02:44:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7406EC2E-A5CF-11E4-A2F5-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263055>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, Jan 16, 2015 at 1:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> Exactly. I am happy to submit a patch, but I cannot think of any
>>> mechanisms besides:
>>>
>>>   1. Calling `id`, which I suspect is very not portable.
>>>
>>>   2. Writing a C program to check getuid(). That's portable for most
>>>      Unixes. It looks like we already have a hacky wrapper on mingw that
>>>      will always return "1".
>>>
>>> Is (2) too gross?
>>
>> Not overly gross compared to some existing test-*.c files, I would
>> say.
>>
>> I wondered what 'perl -e 'print $>' would say in mingw, and if that
>> is portable enough, though.
>
> $ perl -e 'print $>'
> 500

Thanks for a follow-up.

Is "id -u" not useful over there?  I ask because that is what is
used in the version tentatively queued on 'pu' for NOT_ROOT
prerequisite (the jk/sanity topic).

The SANITY prerequisite in that topic needs to be replaced with the
one from Torsten that attempts to check what we want to know in a
more direct way; i.e. "after making a directory or a file read-only,
does the filesystem really honours that, or lets us clobber?" is
what we need to know to skip some tests, and we should check that,
instead of "is / writable by us?" or "are we root?".
