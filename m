From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/33] refs: change the internal reference-iteration API
Date: Tue, 16 Apr 2013 10:47:49 -0700
Message-ID: <7vli8imkoq.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-16-git-send-email-mhagger@alum.mit.edu>
 <7vvc7nvglw.fsf@alter.siamese.dyndns.org> <516D51B2.8090007@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 16 19:48:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9z2-0000OX-OV
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 19:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081Ab3DPRrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 13:47:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031Ab3DPRrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 13:47:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5FAF16818;
	Tue, 16 Apr 2013 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eueJsHskHySTo/Mz8QTk+YoFYhc=; b=N8Y/T5
	s+gxwcE8JjO+Ekgrn9LsmjYJ9o6oY5IWImoWpatJuyeobw9frTnd++h7yMHg49T3
	ysS+oKNneoOl9EiQ7g3HmPLHw8OlGpPcnXX9NdoBXz88eHA6bn49Znht4Ql0vhrK
	Za8CAmwwYSac0Cf0GDTHu4zx7n/FkFo3penus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=weOr8KJBlv+tAYWX5zWWubsRDI1aeWes
	8FwtR+4MDK77BUogJpuLG9d5N0P/0GJCJ4vkDhuZN/3iJ0UO3RulT3qjfBbzZHWg
	K70EcDTgIUae6cYgdMm0Fb4fZot2UShY6HESW33YfF0UtNnScVti2UPbdbt0zQi2
	B/gpEanqQ+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCADE16817;
	Tue, 16 Apr 2013 17:47:51 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4811216813; Tue, 16 Apr
 2013 17:47:51 +0000 (UTC)
In-Reply-To: <516D51B2.8090007@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 16 Apr 2013 15:27:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C247BDB8-A6BD-11E2-8C4A-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221435>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> ...  This scenario doesn't currently occur in the code,
>>> but fix it to prevent things from breaking in a very confusing way in
>>> the future.
>> 
>> Hopefully that means "in later patches in this series" ;-)
>
> I don't think that the rest of the series would have triggered this
> problem either.

Yeah, I misread the message when I said "Hopefully". I somehow
thought it was saying "we will fix it in the future; otherwise
things can break in a confusing way", which is not the case.
