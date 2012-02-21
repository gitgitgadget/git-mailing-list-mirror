From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Mon, 20 Feb 2012 23:05:34 -0800
Message-ID: <7vr4xois3l.fsf@alter.siamese.dyndns.org>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl>
 <7v4nuljcnk.fsf@alter.siamese.dyndns.org> <4F42E4C2.7070801@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Tue Feb 21 08:06:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzjnh-0003Y8-2K
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 08:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab2BUHFj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 02:05:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab2BUHFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 02:05:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 243932369;
	Tue, 21 Feb 2012 02:05:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ct9jwgyGnEpe
	2jv0sftf996Igqo=; b=WhafpAMzU6XcKdFXVRlaHRVYP7vc0f/Qb3trrp6X4plA
	YsRVgPwXQvCi/CLCl4Y8P9Sr4qIpZcTeHwznhAlws9wAySraxwtxDmcR/n4H5e9G
	hQNPjcAEkEPqLQjmnmdXkZtcxiI8Z4q4arkmMmlZfrJMdqftkEy3Wtb9s7TWmWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P9eHaO
	8VI/rATvFzNgq8ZIYSq/QlUPw4z4HkTOCo+rT1t/NL21S1PyM/13SUsgUNaXUgZT
	BuQNOrJFbmOY4ZIv3MsrgrJJGyd4+rZArQewhIvBEOv7ixIa0B+7Oem3+mgGsKIX
	dJdc5rcALXdpbTVOz1qSok/i1Jjuzu+kFxrxg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B8B12368;
	Tue, 21 Feb 2012 02:05:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77F9F2367; Tue, 21 Feb 2012
 02:05:37 -0500 (EST)
In-Reply-To: <4F42E4C2.7070801@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Tue, 21 Feb 2012 01:26:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74D943AC-5C5A-11E1-AF2A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191136>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On 02/21/2012 12:41 AM, Junio C Hamano wrote:
>> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>>
>>> JC:
>>>> Perhaps the maximum for garph_width should be raised to something =
like
>>>> "min(80, stat_width) - name_width"?
>>> I think that a graph like
>>> a | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++
>>> b |    1 -
>>> is not very readable. I like the consistency forced by the 40-colum=
n limit.
>>> But I guess that this is very subjective.
>>
>> The above makes it very obvious that there is a huge amount of chang=
e made
>> to 'a' and a bit of deletion to 'b', compared to a mini-graph that i=
s
>> truncated to half the screen width.
> Yes. But the same graph with 40 columns tells me exactly the same thi=
ng.

That is a bogus argument, isn't it?  You can say the same thing if you
limited the length of the graph bars to 10-columns if you only compare
between 1000 and 1. You can even do with just 5-columns.  For that matt=
er,
without any graph bar at all, it tells us exactly the same thing becaus=
e
we have numbers.  Does that mean we do not need any bar?  Of course not=
=2E
We use bars as visual aid.

Imagine what happens to the graph if you had paths with medium amount o=
f
changes like 980, 800, 40, in addition to 1000 and 1.  By limiting the
length of the bars more than necessary, you are losing the resolution
without a good reason, and that is why I find 40-column limit a poor
design choice.

>> Besides, the above is what you would get without your patch on 80-co=
lumn
>> terminal, no?
>
> Yes.

I think this "use at most 40-places for the graph bar" was your respons=
e
to somebody's observation that "on 200-column terminal, we will still s=
ee
the commit log messages (and for many projects, also patch text) that a=
re
designed to be comfortably viewable within the 80-column on the left, a=
nd
overlong graph bar stands out like an ugly sore thumb".

While that "ugliness" observation might be a valid one to make, I do no=
t
think limiting the length of the graph bar without taking the length of
the name part into account at all is the right solution to it.

After all, that is exactly the same thinking that led to the bug in the
current code that you fixed with your series, isn't it?  Our safety cod=
e
truncated the graph bar width too early without taking the width needed=
 to
show the names into account, and then when the names turn out to be all
short, we ended up wasting space on the right hand side, because we mad=
e
the bars too short and the decision was made too early in the code.

If the problem you are addressing is to make sure that the diffstat par=
t
in the series of lines that are structured like this:

   log message part ~80 column
   diff stat part that can extend very very very very very very very lo=
ng
   patch text part  ~80 column

does not become overly long, wouldn't it be a more natural solution to
make sure that when the total (i.e. name and graph) length can fit to
align with the message and patch (i.e. traditional ~80 col regardless o=
f
the terminal width), not to give it too much width?  If the names are
short, like "a" and "b", that may result in graph bar part to use ~70
columns or so, and if the names are long, like in a Java project, you m=
ay
allocate 50 columns to the name and leave only 50 columns or so for the
graph part.

A simple heuristic might be to see if name part (without truncation) an=
d
the graph part (without scaling) fits under 100-columns if the terminal=
 is
wider than that, and if so limit the whole thing to 100-columns before
deciding the allocation of the total into two parts.  If the name part
alone is very wide, showing the name and the graph using the whole
terminal width would give you a better result than using the bars that =
are
artificially capped to a short limit, I would imagine.
