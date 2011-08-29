From: Junio C Hamano <gitster@pobox.com>
Subject: Re: obstack fails to compile on OS X 10.7
Date: Sun, 28 Aug 2011 23:07:06 -0700
Message-ID: <7vty907nud.fsf@alter.siamese.dyndns.org>
References: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com>
 <20110827101418.GA8074@gmail.com> <20110828200846.GA10754@fredrik-Q430-Q530>
 <20110829031806.GA58338@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <frekui@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:07:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxv07-0006MD-95
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab1H2GHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 02:07:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752788Ab1H2GHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 02:07:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6FFA2054;
	Mon, 29 Aug 2011 02:07:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=CbHGlPfP864satwJGzTYaBSgAks=; b=xyu6xn/gh9pY+cRwZ3Mc
	3N2RVeWlWVpzEScEqduPvGKdyxXgAUiG1hkoafrgzgkPP7T+7sY/gMt5aWGpgrMk
	zNQYY7c+K1QZlL5fmIIpTOBavfy2iaZREbLtiGSwTKxoCwQ7e+z4rfjx+pmLzF+z
	2mV8Mx6J6DBFbxPUKA3fUYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=qZOzey+sstyz/4ZLNlQl2yGGQK/3+q3q/RhvjW3GRHQPa4
	/31J9dgogHNfqCFbfyx2q2rZ2txAmaBh3nqLh9yQZgoJ4xVm4bTvuROqyqzl/ocl
	6kNKlgYHHrHzoSx1SrAqljIoTYB5SXXIgilJtGopUa9IWDH6VGwrWQBc6Jrws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE92E2053;
	Mon, 29 Aug 2011 02:07:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 598B22052; Mon, 29 Aug 2011
 02:07:08 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 208B5158-D205-11E0-80BF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180299>

David Aguilar <davvid@gmail.com> writes:

>> -void obstack_free (struct obstack *__obstack, void *__block);
>> +void obstack_free (struct obstack *obstack, void *block);
>
> Tiny nit: I know it's just a declaration but would it be advisable to
> drop the variable names altogether here?

I agree. In general it is easier to read if parameter names to a function
declaration is omitted, especially if it is clear from their types what
they mean [*1*]. And in this case, it is.

> Tested-by: David Aguilar <davvid@gmail.com>

Thanks.

[Footnote]

*1* It is Ok to spell them out in a case like this:

    int copy(char *dst, const char *src, size_t);

You do not have to, as "char *" vs "const char *" makes it clear which one
is which.
