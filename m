From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 09 Dec 2014 15:18:28 -0800
Message-ID: <xmqq61dkl8e3.fsf@gitster.dls.corp.google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
	<20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
	<20141209201713.GY16345@google.com> <20141209202738.GC12001@peff.net>
	<20141209222337.GA16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 00:18:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyU3A-0004kR-RR
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 00:18:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbaLIXSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 18:18:33 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61904 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753797AbaLIXSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 18:18:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81F532510A;
	Tue,  9 Dec 2014 18:18:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/2M30T1h6KkFdDu4rHoC5yJg5E=; b=ZsEnVV
	gW01ISJnEcqeqL0U7fV8wMWC3bNrR140luF7FUukJnLFTUyosvHeYFD2oAkHSHip
	GPlGvbtFuzTdjDIJRlkQiyqz5xzKoAOOED/g3GqiDRR/4MpoefUyFvpKVKXbWajZ
	1jMD55UcHha7XQ2iV58e1gBXNK7ymkqeHOLEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AMmmIjIQ79vH5KsxiVyldnmpA5O0n+xl
	S/TmZCKuS9VzH2Vf3oj7L0l7zXHg9lmv3F5QoR5LAv9RamUZbjP1vbZgl4D8dLd9
	zFBl15m/VgiUHmQTx63esSw43UhaEWtG4snDSlxYU09WdllJM8HGH0C+KN3sjsOf
	dG4Zz2eFYNQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7941725109;
	Tue,  9 Dec 2014 18:18:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E66D925108;
	Tue,  9 Dec 2014 18:18:29 -0500 (EST)
In-Reply-To: <20141209222337.GA16345@google.com> (Jonathan Nieder's message of
	"Tue, 9 Dec 2014 14:23:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AFB6EA54-7FF9-11E4-B7B6-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261176>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jeff King wrote:
>
>> Elsewhere I mentioned a tool to extract comments and format them. But do
>> people actually care about the formatting step?
>
> If formatting means "convert to a straightforward text document that I
> can read through", then I do.

If the result becomes unparsable by AsciiDoc(or), those who
AsciiDoc'ified the api-*.txt may feel unhappy.  I however strongly
suspect that the primary consumer of these api-*.txt documents are
consuming the text version, not AsciiDoc-to-html output.

>>                                                 Does anybody asciidoc
>> the technical/api-* files? We did not even support building them until
>> sometime in 2012. Personally, I only ever view them as text.
>
> I also view them as text.  I tend to find it easier to read the
> technical/api-* files than headers.  That might be for the same reason
> that some other people prefer header files --- a
> Documentation/technical/ file tends to be written in one chunk
> together and ends up saying exactly what I need to know about the
> calling sequence in a coherent way, while header files tend to evolve
> over time to match the implementation without maintaining that
> organization and usability.

The documentation that was written with an explicit purpose to serve
as documentation would explain how each pieces fit in the whole
system much better than a list of pieces extracted from per-function
comments, unless the header comment that serves as the source of
generated document is written carefully.  But as people pointed out,
having the same set of information in two places in sync forces us
to be extra careful in a different way.  There is no free lunch.

We would want (1) documentation in one place, (2) easy access to it
when deciding which API function to call with what information, and
(3) make it hard to forget updating the documentation when making
changes to the API.  If that single source of truth is the header
file, perhaps we would become more careful commenting our headers
(i.e. "do not just comment each functions and structures, but
enhance introductory part that describes how things fit together"),
so I think it would be OK in the end.  We may need to reorganize and
reorder the headers so that associated comments to functions and
data types match desirable presentation order, but that effort will
kill two birds with one stone.  The resulting header would also be
easier to read by humans.

I am a bit hesitant to see us spending extra cycles either to
reinvent doxygen (if we do our own) or working around quirks in
third-party tools (if we decide to use existing ones).

Thanks.
