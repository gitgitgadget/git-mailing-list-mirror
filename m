From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] commit.c: check for lock error and return early
Date: Thu, 17 Apr 2014 14:09:04 -0700
Message-ID: <xmqqppkfd5ov.fsf@gitster.dls.corp.google.com>
References: <1397674613-4922-1-git-send-email-sahlberg@google.com>
	<1397674613-4922-3-git-send-email-sahlberg@google.com>
	<534EFEE0.9000806@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 17 23:09:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WatYZ-0002Aq-4u
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 23:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbaDQVJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 17:09:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbaDQVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 17:09:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D26FE7D8E1;
	Thu, 17 Apr 2014 17:09:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XcFX2YgILzLhUfgClC5YXZP4NY0=; b=xSCSwz
	Ss+ZjnTrrBvTCcjiHJgtvFPeIPp52wcb+yas3jgAZGAHdIMMy5XSqPpsMKaVre5u
	brh5pybHgZqes+Na1zaJ0EBDfKFnxIxcoq8IaD0lnNqcqqRkWqJVNVmzmCC+RkzV
	FoMfKIyESbabjlr07yfU8t7sgxf6qWrZ2J/8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rOWCoRt9RqUoR3JZ+rKFGqHBcLLhkYmR
	y3EKeYRhai4s5VOLAQPqQm0WGkmGSg6dLJgCox3ONraSY0MNtvrZ/yQzlVUNsAIV
	/RYHxscSz/Po39LY9QXtYDwlIBlWKjS3Fy3MKinTLNI8NqvpDd6rmTJsVXUQQrKP
	u6yAzvbjuSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAB207D8E0;
	Thu, 17 Apr 2014 17:09:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B7A67D8DE;
	Thu, 17 Apr 2014 17:09:06 -0400 (EDT)
In-Reply-To: <534EFEE0.9000806@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 17 Apr 2014 00:06:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 82DCD6F4-C674-11E3-9BDE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246452>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/16/2014 08:56 PM, Ronnie Sahlberg wrote:
>> Move the check for the lock failure to happen immediately after
>> lock_any_ref_for_update().
>> Previously the lock and the check-if-lock-failed was separated by a handful
>> of string manipulation statements.
>
> Please flow sentences together into paragraphs for easier reading,
> rather than having an extremely ragged right-hand margin.
>
> The rest looks good.

Thanks, both.  I tentatively queued with the suggested log message
tweaks, and I think result reads better.
