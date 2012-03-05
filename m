From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 05 Mar 2012 13:49:24 -0800
Message-ID: <7veht6zpjv.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org>
 <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
 <CA+55aFzuCJWfzp2ROxvMY78NZWb3ofYWOebfPfPba9kypyytKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:49:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fmz-0000CB-A3
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 22:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab2CEVt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 16:49:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33877 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754510Ab2CEVt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 16:49:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810956853;
	Mon,  5 Mar 2012 16:49:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=26Og7eeLrGEdyIBSQSla14o0Xro=; b=SMir4N
	fM4OjPCtc/IoiJsHBSrvHEyQ6TjHOexhZP1+rsw1n2C8P7fy2nj3i0HIGMmlV3fC
	r3FqNHWFwFCsnYI3Ujmy37nB969AOToXxJw+4KnSGaBtpqwYXAV9ZgM+FPybYNw5
	UfEHVLOmK5j8LGbP7e+V5sG4N77OdMlGJSlNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N0QcuTJxL7IQZbY4SracWYJQXEdAESPj
	NTLkLLL6XlPgd+YSbJgErh30M3pzBE1xgI/P5UjVRrFOdxzdWxCeFA+AXKRAKrd9
	PYIwkSm217xRyjB2DzpTI66QiboxSSEa1TLR4VUjqSdpeQJsxx5uhMwMnE0YB/fn
	M3nMdU93MCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7728B6852;
	Mon,  5 Mar 2012 16:49:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 110456851; Mon,  5 Mar 2012
 16:49:25 -0500 (EST)
In-Reply-To: <CA+55aFzuCJWfzp2ROxvMY78NZWb3ofYWOebfPfPba9kypyytKA@mail.gmail.com> (Linus
 Torvalds's message of "Mon, 5 Mar 2012 13:46:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13B6A7E6-670D-11E1-B6D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192277>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Mar 5, 2012 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> This patch punts the deep thinking part and just picks the tip
>> committer and counts only merges in the history you are pulling in.
>> It may not be a very good heuristics, but the code structure should
>> be a good place to start.
>
> Yeah, this looks good to me (but I didn't actually *test* it, so
> that's just from looking at the patch).

As I said, I didn't actually *test* it, either, and the committer
based heuristics may have a huge room for improvements.
