From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Mon, 03 Jun 2013 10:23:29 -0700
Message-ID: <7vr4gjglbi.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-2-git-send-email-artagnon@gmail.com>
	<87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYTo-0002O4-Sw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759167Ab3FCRXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:23:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab3FCRXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:23:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDD9B24B85;
	Mon,  3 Jun 2013 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Jz39BWqIOAzZ1S2f5oW6U3koaI=; b=p7DyPh
	iZXAbLiRwLqRok+hvvUtEh4w2I0dX9L/KddYNTqy9VqibvkCyvpn4sORnqxGjyCd
	8ArBxPBAoNToTF4QfhxF1ujb3VyRT84VaG4aHY5LsHP1AdmLXuNurrOXSdh8mncB
	E12adPslYCNxtH8cVEST+huJU1fQnFZ6tgaPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HTU+xBhls3xYDymA7gzu0k75EaUOO5Ng
	JIblwejyFntB5TbPgb8pZuJ3pwDrvU9hMrZpFbOOx1PQP/2hixzc61+m82ZoK0U8
	VH4ccQv7wasLFQbGFiPglTFhgk5av19axg/RF6vbfnefVfn2n+1JG6+UXvOKZED6
	t9cFg8K2DtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E366024B84;
	Mon,  3 Jun 2013 17:23:31 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 681AA24B81;
	Mon,  3 Jun 2013 17:23:31 +0000 (UTC)
In-Reply-To: <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 3 Jun 2013 10:58:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FF55592-CC72-11E2-9380-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226241>

Thomas Rast <trast@inf.ethz.ch> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> Currently, when performing any operation that saves the state and
>> expects the user the continue (like rebase, bisect, am), the prompt
>> screams:
>>
>>   artagnon|completion|REBASE-i 2/2:~/src/git$
>>
>> Lowercase the words, so we get a more pleasant
>>
>>   artagnon|completion|rebase-i 2/2:~/src/git$
>
> So I'm not sure whether this falls under bikeshedding or actual
> features, but I like the screaming.

Sounds like bikeshedding.

My personal opinion is that "detached in the middle of something" is
not a normal state, and it deserves to be in bold as a reminder.
Let's leave it as-is.
 
