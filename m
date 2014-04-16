From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Make update refs more atomic
Date: Wed, 16 Apr 2014 14:42:09 -0700
Message-ID: <xmqqtx9teytq.fsf@gitster.dls.corp.google.com>
References: <1397500163-7617-1-git-send-email-sahlberg@google.com>
	<534CD376.7080108@alum.mit.edu>
	<CAL=YDWmm1pDtNuibs5CrPTDkaxT9PUvZscXFicoNsNpXVXJv1A@mail.gmail.com>
	<534D9741.3010404@alum.mit.edu>
	<CAL=YDW=g=jkm4yhBvnZXSvLLm-6ZGhJORKv_evg66v0U=E71FA@mail.gmail.com>
	<xmqq1twxgjge.fsf@gitster.dls.corp.google.com>
	<CAL=YDWnHtPedxYmpycgSybZA=CmdD55XQAFdA-Bs_42bk2Z0Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaXb2-0005rk-2d
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 23:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754920AbaDPVmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 17:42:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbaDPVmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 17:42:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C2967B954;
	Wed, 16 Apr 2014 17:42:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jEZzOUhWam2qGKSM7aZLYZacI2A=; b=QC++km
	CeySLCGokziKmkj6DLY+MEhYe0p9h6wiu2A3mcBzblzFL8waOUFDbBSXl+iTcheP
	4LwAP3RTwe/W+QhjuRBhKQUg/u1JVRQnd62MKM06YgrnT7IRPA67QzLI+aA+BUhB
	RZW1xvhA4w8/Lg5EGaf6PLbzi4z4e1ZG58klI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PFz9sI2aPup2A+qKgOLE65gJzcMp417O
	sI6E3CtQO98ZNWwe138tmKEvfAq4Zx9aO07yHoSGwBqpYMJgKCoFaVM7UPH7Gn19
	yoQ1czpXca9fqJNZjlqv8aOzxRa4FTQvf1iCeTaKtlHhZzHUkzws/SbzWLKXmzqE
	Br5n+0IFfAk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 651D67B953;
	Wed, 16 Apr 2014 17:42:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB1297B950;
	Wed, 16 Apr 2014 17:42:10 -0400 (EDT)
In-Reply-To: <CAL=YDWnHtPedxYmpycgSybZA=CmdD55XQAFdA-Bs_42bk2Z0Tg@mail.gmail.com>
	(Ronnie Sahlberg's message of "Wed, 16 Apr 2014 14:31:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F73E2900-C5AF-11E3-AD10-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246383>

Ronnie Sahlberg <sahlberg@google.com> writes:

>> I am not sure if that is the right way to go, or instead change all
>> create/update/delete to take locks without adding a new primitive.
>
> ack.

Hmph.  When I say "I am not sure", "I dunno", etc., I do mean it.

Did you mean by "Ack" "I do not know, either", or "I think it is
better to take locks early everywhere"?
