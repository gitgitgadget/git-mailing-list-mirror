From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/27] refs: add a concept of a reference transaction
Date: Tue, 15 Apr 2014 00:40:56 -0700
Message-ID: <xmqqk3arkpkn.fsf@gitster.dls.corp.google.com>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
	<1396878498-19887-20-git-send-email-mhagger@alum.mit.edu>
	<xmqq8urhlzr1.fsf@gitster.dls.corp.google.com>
	<534BBE67.3040100@alum.mit.edu>
	<xmqqa9bnmwnk.fsf@gitster.dls.corp.google.com>
	<534CC69C.1020503@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 15 09:41:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZxzU-0004uE-76
	for gcvg-git-2@plane.gmane.org; Tue, 15 Apr 2014 09:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbaDOHlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2014 03:41:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbaDOHlA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2014 03:41:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4426778E78;
	Tue, 15 Apr 2014 03:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w4/+D8BtNRUZ7Z9YZHC8/BAvUFg=; b=bG9KqI
	/rX7hYVkvAACAvAZ6UyibFXApIwd6KLwvtMRlWIXvxBOxDu9ohhUMse7m48NNRVA
	YyJsQ3ooZt3t4MxSdU3Asqh4bwtbVNACYXQhO08WySNFSVyMOYQfEkFkfYm/8khV
	WB41GQs0S7Bz1By2vUd0UgBDhWrqY3vhVAGD8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gpGc0fTxP/23nv0BY/wMc/G8xkCcezRX
	G5H/YzmHjkFRHP9upv3wlA3JWHj5lfPeeE9aPfWnLOpDvTk0EPF6bI7u4mxPsWeN
	BL8s/Tg2R3IKX+gAagTpB7MouozjJaDSS8y/Q09BLoKTIzFd6t4RW5v3m7kzwYnb
	zJi4MZ70+bg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2875078E77;
	Tue, 15 Apr 2014 03:40:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B543578E74;
	Tue, 15 Apr 2014 03:40:57 -0400 (EDT)
In-Reply-To: <534CC69C.1020503@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 15 Apr 2014 07:41:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 487EBCC0-C471-11E3-BB48-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246278>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> In retrospect, you might have been objecting more to the misleading
> docstring than to the behavior as implemented at the time.  

Yeah, I was reacting to the comment that said create can delete ;-)

> The
> docstring implied that create could actually be used to delete a
> reference, but that was not true: it always checked that the reference
> didn't exist beforehand.  So at worst it could leave a non-existent
> reference un-created.

OK, all is clear then.  

>>  (2) keep the assert(), reject such user input at the callers, and
>>      document that these are invalid inputs;
>
> The current status in v3 is that (2) is implemented.

Good.  Thanks.
