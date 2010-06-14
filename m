From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Return or exit after done serving request
Date: Mon, 14 Jun 2010 13:54:29 -0700
Message-ID: <7v8w6h9vy2.fsf@alter.siamese.dyndns.org>
References: <20100613100800.28221.77529.stgit@localhost.localdomain>
 <7v1vcach4x.fsf@alter.siamese.dyndns.org>
 <201006141029.00310.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 22:54:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOGg6-0002OF-VA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 22:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755885Ab0FNUyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 16:54:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab0FNUyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 16:54:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 67BFFBCBFA;
	Mon, 14 Jun 2010 16:54:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zEbLUMiuaBLNEAvhbXxe7bixiuU=; b=hlIwU+
	DLhp/cBY8VUbKYipaPWekEriKPYPkryHJ7dWupRm0cKRueR8h/+M/0MBKw/hl9an
	WVfdfCr4CxoSyVuMzLPe42ICtbDpjvQYrtOZYmzGyPFMcaAS74zionaeGaOsmnOj
	YTObp/W+24F8aAX72G+w7xj/y3edKOxjpO4so=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b33CIrspuuOMo0xH8je9wGmeGD4m+4/W
	uo0yEJc2jSPgPZTqYDj9nR1g0vXix9TxtfZOq90EgtZVNm87tazH6WKFoRNZvSPm
	VPt6xq6QxO5tLCrraV3WQN0NhcKqyanXEu8OcNR9u1EKygC/+gDOu/rltsLmr0Ff
	sTvCooQwYgw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 426B1BCBF8;
	Mon, 14 Jun 2010 16:54:33 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78FCCBCBF5; Mon, 14 Jun
 2010 16:54:30 -0400 (EDT)
In-Reply-To: <201006141029.00310.jnareb@gmail.com> (Jakub Narebski's message
 of "Mon\, 14 Jun 2010 10\:28\:58 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 08C3D1C6-77F7-11DF-B01C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149137>

Jakub Narebski <jnareb@gmail.com> writes:

> On Mon, 14 June 2010, Junio C Hamano wrote:
> ...
>> Is the last "1;" still needed if we did this?
>
> Probably not, and probably we never need this.
>> 
>> I am guessing that this new codeblock will go inside "sub run" when
>> merging with your c2394fe (gitweb: Put all per-connection code in run()
>> subroutine, 2010-05-07) and Sam's a0446e7 (gitweb: Add support for
>> FastCGI, using CGI::Fast, 2010-05-07).  If I am mistaken, please advise.
>
> No, the code is meant to be after last code to be run in gitweb, 
> in *top level* scope, otherwise it would always return.

Ok, tentatively I fixed the mismerge of 'pu' from the last night and
pushed it out.
