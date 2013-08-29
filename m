From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Thu, 29 Aug 2013 14:42:00 -0700
Message-ID: <xmqq8uzk2mzb.fsf@gitster.dls.corp.google.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
	<xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
	<xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
	<CALWbr2xe8jC4QnLTEOWJX_kn_FcQjSafPn=NKd3UsK9fO5f=_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9yp-0005nn-AC
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047Ab3H2VmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:42:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755Ab3H2VmK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:42:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B183DA51;
	Thu, 29 Aug 2013 21:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G9/6rkkgUCldAb0mDt5jX3U9dZM=; b=sAx/wb
	4D9wh9gRYRWCSPf0hk3G3RNq7Tfzjb33yBiSlOwyQEwG+eZlTb9ijeIa/nTDqf4X
	07pXvuF4SazqhSpdCy7Nd6exOjMCEUclZNEk6FAl4QXeGLgcJBW8H/FGECrsXp/M
	htMFsu22h4PUMxFGZQhmfxx/EXPONKbRiGdkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BvqMk+ZzCyZSIrOMT/jTXxYMRnV1qYn/
	OYkVvQ8LM2PGI7rz576rKYWOvQQFCcsLRKXS2kSXqCJ8JtaWsXhAcpLe07YBF4cN
	WJWe7lGpo+fXhlOnCmKArT5qSk1OdLB9ockaD2g2ZgwwWMwPQAxNtCOYN0b30wtT
	HDJwD4Y0Sew=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 999CC3DA50;
	Thu, 29 Aug 2013 21:42:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D46F83DA4E;
	Thu, 29 Aug 2013 21:42:08 +0000 (UTC)
In-Reply-To: <CALWbr2xe8jC4QnLTEOWJX_kn_FcQjSafPn=NKd3UsK9fO5f=_g@mail.gmail.com>
	(Antoine Pelisse's message of "Thu, 29 Aug 2013 23:28:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB03E336-10F3-11E3-9B96-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233368>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Thu, Aug 29, 2013 at 11:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> -- >8 --
>> Subject: [PATCH 9/8] contrib/remote-helpers: style updates for test scripts
>>
>> During the review of the main series it was noticed that these test
>> scripts can use updates to conform to our coding style better, but
>> fixing the style should be done in a patch separate from the main
>> series.
>>
>> This updates the test-*.sh scripts only for styles:
>>
>>  * We do not leave SP between a redirection operator and the
>>    filename;
>>
>>  * We change line before "then", "do", etc. rather than terminating
>>    the condition for "if"/"while" and list for "for" with a
>>    semicolon;
>>
>>  * When HERE document does not use any expansion, we quote the end
>>    marker (e.g. "cat <<\EOF" not "cat <<EOF") to signal the readers
>>    that there is no funny substitution to worry about when reading
>>    the code.
>
> May I ask what pattern you used to replace all these or if you went
> through manually ?

"M-x query-replace" from "> " to ">" with manual inspection. I never
use full automation myself, as I do not trust that I am careful
enough and it is prone to unexpected changes that I can easily miss.
