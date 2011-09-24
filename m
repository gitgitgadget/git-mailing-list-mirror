From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.6.4
Date: Fri, 23 Sep 2011 20:50:32 -0700
Message-ID: <7vd3eqsinr.fsf@alter.siamese.dyndns.org>
References: <7vlitesucu.fsf@alter.siamese.dyndns.org>
 <4850EB43-5CC7-4D33-90A8-1EDEE16ECAB7@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: BJ Hargrave <bj@bjhargrave.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 05:50:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7JGC-00041G-Kk
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 05:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab1IXDug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 23:50:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37479 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab1IXDuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 23:50:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3B5759DF;
	Fri, 23 Sep 2011 23:50:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JdvRvaJwNMv/02ilTbCipVF/+lU=; b=lyGPqz
	CK2jze1jCuTW4cqy22hvDtGXAsAnfuw/IN7CYnur0yaKckt22BAaz1YQ9OJLkB9N
	noGnAWwRAtk3ttUzKS0Uwf4UNPWFXzABEx358LKoTDmSj3Wj8jiXbM89+n/8Vifa
	dLTsU77EL6rKfAHzvQDnVvL2p8tK/POKjsWLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZczsniN5q2Z4H+gmdXOG3jG+4DnzUK1H
	SzFMTxbkAULYena79mfKQmEuDgZeUjM5pqepV+vBJ/QZ5Ra1D9v1BWg2FbMuVIVt
	s8cFKTLzIjAb0aY8u2KxzKcYzAH3FtgQDDjamYbU/e2/BZvj2GcUT89xhbw8DQwI
	JKfeHh50Wvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C81FD59DE;
	Fri, 23 Sep 2011 23:50:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E2B759D4; Fri, 23 Sep 2011
 23:50:34 -0400 (EDT)
In-Reply-To: <4850EB43-5CC7-4D33-90A8-1EDEE16ECAB7@bjhargrave.com> (BJ
 Hargrave's message of "Fri, 23 Sep 2011 23:33:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B4A57F2-E660-11E0-9C02-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182018>

BJ Hargrave <bj@bjhargrave.com> writes:

> The test
>
>  invalid_ref "$(printf 'heads/foo\177')"
>
> was added to t1402-check-ref-format.sh. However sh on my RHEL 4 system
> does not handle the DEL (\177) character well in double quoted strings.
>
> sh-3.00$ echo $(printf 'hello\177') | hexdump -C
> 00000000  68 65 6c 6c 6f 7f 0a                              |hello..|
> 00000007
> sh-3.00$ echo "$(printf 'hello\177')" | hexdump -C
> 00000000  68 65 6c 6c 6f 0a                                 |hello.|
> 00000006
>
> The double quotes cause the DEL (\177) character to be discarded.
>
> Can this test be rewritten to avoid this apparent bug in sh on RHEL 4?

For older distros, I would prefer a workaround patch first tested by
distro packaging people and then upstreamed.

Thanks.
