From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/16] t/t5505-remote: remove dependency on $origin_url
Date: Sat, 22 Jun 2013 14:10:48 -0700
Message-ID: <7vbo6xkg13.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<1371813160-4200-5-git-send-email-artagnon@gmail.com>
	<7v61x7ktcw.fsf@alter.siamese.dyndns.org>
	<CALkWK0mKQnyDXe6AfVzNbh7qOdYbyrVrgt9GMgT2c9u+1jykJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 22 23:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqV5T-0006Ll-Ne
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 23:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096Ab3FVVKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 17:10:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab3FVVKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 17:10:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B52C27AF2;
	Sat, 22 Jun 2013 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QVq8MGu8LOYW8dlDQs2y5+R9bm8=; b=R7VuZE
	JVDOmddi5mNW+Y5bG1WjzEObefOwb7c3NPmBZlfpQlIJopVo7BQYd1pPQdNu4nGE
	idgqDHwrGn/afegqDOqhgt5xcLlHYQJIWiizXetvZLbY7u9hwV4Iak0ZxX7uKoPR
	pHdJXkhJfDSFR3Xqp3JAP5ySbr8Ndsd+Enl0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IJjZ5EJ+5Pb6HSM+BZaZAmXaw3JHdOQP
	J+p0gNbLUyLSj1w9+tGrCNFW7XP9tLLATFEr/gLp8fNcKKndo6Uagd4aavFGRG12
	EFkoiSEM1NRbMFQCG/iP0Xw4BQMs45aAsZtTK6Bg4EMZ4HlefKXHKxa47zyifj4a
	JQzBAXL8lBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62BBC27AEC;
	Sat, 22 Jun 2013 21:10:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB23827AE8;
	Sat, 22 Jun 2013 21:10:50 +0000 (UTC)
In-Reply-To: <CALkWK0mKQnyDXe6AfVzNbh7qOdYbyrVrgt9GMgT2c9u+1jykJg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sat, 22 Jun 2013 11:57:52 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3786AEBC-DB80-11E2-93DF-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228718>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> Is there a reason why "quux" is better than another randomly chosen
>> string "$(pwd)/one"?
>
> "$(pwd)/one" is not randomly chosen: that configuration will work with
> push/pull, and is therefore misleading.

But isn't the "URL:" field in remotes file meant to be usable with
push and pull?  Why is it misleading to put a value that is more
plausible (I believe "'one' in the current directory" is another
repository and the intent is that the old .git/remotes/origin setup
lets you fetch from and push to that repository) there?

I do not think you are creating a quux repository to be pushed into
and fetched from with this change. Placing 'quux' in the "URL:" field
feels a lot more misleading to me.  What am I missing?
