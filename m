From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently processed
Date: Fri, 21 Jun 2013 07:23:37 -0700
Message-ID: <7vwqpno846.fsf@alter.siamese.dyndns.org>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
	<alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
	<c878cf98bff28ea8b72fb6d33fd9ca85@ensibm.imag.fr>
	<alpine.DEB.2.00.1306171452340.7683@perkele.intern.softwolves.pp.se>
	<0b88af05ea8d4723a870476036992abc@ensibm.imag.fr>
	<51BF26F9.1080900@viscovery.net>
	<7vvc5cg0i8.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.1306200853250.7267@ds9.cixit.se>
	<51C2B8DA.6040400@viscovery.net>
	<7vzjukveiz.fsf@alter.siamese.dyndns.org>
	<51C3E5D7.6040604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Mathieu =?utf-8?Q?Li=C3=A9na?= =?utf-8?Q?rd--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>, git@vger.kernel.org,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 16:23:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq2Fi-0007Rh-SU
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 16:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985Ab3FUOXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 10:23:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422773Ab3FUOXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 10:23:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1587F29359;
	Fri, 21 Jun 2013 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mcGz0kjihhuwwpi4KSccq6IeLdM=; b=cWd8Nv
	f82I2V4cStfOA/8752uTZm8oOGlJmauuBtkFB1tEfuXFl49SjKjoThx5wjVHdvSc
	PXAwli4cR3tJA2Hn6xeGVaYbIuzU9S9717yR3UVxPg40LRK22LVzuXp2UASrRXaC
	3NgnZRu6WuZa6LRe5haATaWmGtYh/pw0zGoYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1R6bfGBYpyhnep51FKjQXzEXpljNVwf
	EAnY+xNBzKCfg/nIfvJy4077KwvucyJF26WCYA8uY16/O2rGUKUVOerBWzslUi/L
	aLW0FAwBS40kIEbfJaA/VjMcE1EIC5fC/TnFlOtXC0zMozJdHbK6y3rGVRXd294I
	W3mCLi6h34M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3C6029358;
	Fri, 21 Jun 2013 14:23:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7393E29354;
	Fri, 21 Jun 2013 14:23:39 +0000 (UTC)
In-Reply-To: <51C3E5D7.6040604@viscovery.net> (Johannes Sixt's message of
	"Fri, 21 Jun 2013 07:34:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2AE3E8D0-DA7E-11E2-BB73-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228616>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 6/20/2013 20:11, schrieb Junio C Hamano:
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>> But you can't have this string:
>>>
>>>   "Splitting a commit while rebasing branch '%2$s' on '%3$s'."
>>>
>>> neither in the template nor in the translation, because the numbers must
>>> begin at 1 (and must be used without gaps).
>> 
>> Did any message we saw in the patch (and the discussion to possibly
>> improve it) need to have such a format string, or are you pointing
>> out a common gotcha we may want to warn translators about in
>> po/README?
>
> I took the example from Peter's message earlier in this thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/228062/focus=228064

Yeah, that one would not work.
