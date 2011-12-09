From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/9] revert: tolerate extra spaces, tabs in insn sheet
Date: Fri, 09 Dec 2011 12:12:55 -0800
Message-ID: <7vty59ec6w.fsf@alter.siamese.dyndns.org>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:13:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6oa-0005I3-1N
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab1LIUM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:12:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab1LIUM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:12:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C82D1637C;
	Fri,  9 Dec 2011 15:12:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QbZkMC+qEfb7iLN4z64nEoQ48os=; b=vmIL2C
	h3BiC+OCY/r+MCjVbvPNmK+waWNW/JicGcMDyblHC5XWBc1imvIBgxr3LNVDxyDD
	W4EuDqxpJy5AzpAtqHi8sPBgj0rZiRztYbDp8aBoYhzedkdNfR7TEBhmXAVQKsXS
	QOaJDvLBcJc3IPTFOOwaJkX7VY13q99bmWx/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oi7vpQxDxAT/UdMkZ6ahlkZ59YyJoRIw
	4gJl+lO3PFVBEBZalU6ThyaLWs6BKGOu7+V76+WSJQ7N24NJFlkhZVrX64PJMlTX
	lnphuebTDKl+9fiYLtwkrTUmnWI8zGHrxAfh9Q46YmhUVeds1dH9cXgyNHYn1Iy5
	nUU6kgLAXcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C045D637B;
	Fri,  9 Dec 2011 15:12:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 576B4637A; Fri,  9 Dec 2011
 15:12:57 -0500 (EST)
In-Reply-To: <1323445326-24637-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Fri, 9 Dec 2011 21:12:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F6F3386-22A2-11E1-8B5F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186679>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Tolerate extra spaces and tabs as part of the the field separator in
> '.git/sequencer/todo', for people with fat fingers.
>
> Requested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

I did not request it, by the way. I actually was hinting to start tight
and later loosen the parsing.

Also if you are using strcspn() why use a hand-rolled loop instead of
strspn()?
