From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 12:01:29 -0800
Message-ID: <7va9rpgm06.fsf@alter.siamese.dyndns.org>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org> <20130131190747.GE27340@google.com>
 <7vip6dgmx2.fsf@alter.siamese.dyndns.org> <20130131195712.GH27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 21:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U10Kc-0004og-Fv
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 21:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab3AaUBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 15:01:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756718Ab3AaUBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 15:01:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDBC4C714;
	Thu, 31 Jan 2013 15:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UE62aBsb0bnq7Oy5nhgPFbDcOn8=; b=NP26PS
	M5m+0iCVH4c/95pNkbQn10X//CpHhZ6M+tV0+RFB+fn9XFihXo4N+6N9v8NSn5pp
	maMz+9lOERCJ2XF/CjTBC5ew+j4qRIP1WmuwYDO8eLVGtB7U3+WtORxwZ1TJzIZs
	L4UFGZI+XE1GDqx5c+a/wPYC0I5xTxr7h/Yv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xADa2l3k4oTVM6IR7yw1O+RS45ByL8Wj
	qbJ6cyMWSFQxWE1fZyr/QfAPh0T90USQcyPlRIeDIZbjDk+G0u/OQ4MMMi4aZ+vj
	8lGGDBcUnPN6IlDHLB/IopXEGVHaP2WutnHouQwzO/6nuUgJCzspdmGj4VaHs/L+
	d5tMPG1AoQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0298C713;
	Thu, 31 Jan 2013 15:01:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56886C70E; Thu, 31 Jan 2013
 15:01:31 -0500 (EST)
In-Reply-To: <20130131195712.GH27340@google.com> (Jonathan Nieder's message
 of "Thu, 31 Jan 2013 11:57:12 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01A41758-6BE1-11E2-B8A0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215159>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> That is why I tend to prefer how check-ref-format documentation
>> describes --print:
>>
>>         --normalize::
>>                 Normalize 'refname' by removing any leading slash (`/`)
>>                 characters and collapsing runs of adjacent slashes between
>>                 name components into a single slash.  Iff the normalized
>>                 refname is valid then print it to standard output and exit
>>                 with a status of 0.  (`--print` is a deprecated way to spell
>>                 `--normalize`.)
>
> That works because, as you mention, the usual way to look up an option
> in manpages is to search for "--print", including the two minus signs.
>
> Unfortunately an analagous approach in gitconfig(5) would be seriously
> broken, because searching for "tracking" (no minus signs) is going to
> hit many false positives.  I do not think such a change would be an
> improvement.

I thought your example was that you saw "pull.default = tracking"
and wondering what it is.  Why do you need global search for
"tracking", not just near pull.default is described, in the first
place?
