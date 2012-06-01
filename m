From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 09:51:39 -0700
Message-ID: <7v396f3rhg.fsf@alter.siamese.dyndns.org>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7vmx4o58zc.fsf@alter.siamese.dyndns.org>
 <20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 01 18:51:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaV4l-0001HV-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965533Ab2FAQvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 12:51:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52801 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965469Ab2FAQvm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 12:51:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE4A8750;
	Fri,  1 Jun 2012 12:51:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FA9uWA9yRuCBW6nsTWn6R0c6DhY=; b=qZGavR
	WwJ3HlIH3/5oY27S0uagbUgXQEru+1ELXVoF4DBtE5TU85y2/YF5NKLU20bFtfre
	aTuydyyjeyvZorGAseSHk5tJMMVD6kYhY0c7lhBkkoCj1dBlVa6NRr85Nn7WOrNl
	SiBZt6xDTUz+nXLJcLXagdaI3/ZxdGscA51ks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0g3ezmjh8BfXKJ4CL6IRvg5Kj06n6EX
	DlqaKYG9inB1YOykMk7gH4kr1whUb6Tl4aWcI4tuMtTQxxf6IgZsiNRX7D8pa8kY
	6WtshZfiTB09jKnmbhnNa1T1SvyHIHryiPWMvboG+d1xt/ssCwiXSKyaJhyFHTch
	FVa1F9jOE+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1210874F;
	Fri,  1 Jun 2012 12:51:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B2E5874C; Fri,  1 Jun 2012
 12:51:41 -0400 (EDT)
In-Reply-To: <20120601111651.Horde.R0mdSHwdC4BPyIiDyUHhUVA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Fri, 01 Jun 2012 11:16:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FD11EA8-AC0A-11E1-BCC0-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199002>

konglu@minatec.inpg.fr writes:

>>> +	} else {
>>> +		status_printf_ln(s, color, _("You are currently editing a commit  
>>> during a rebase."));
>>> +		if (advice_status_hints) {
>>> +			status_printf_ln(s, color, _("  You can amend the commit with"));
>>> +			status_printf_ln(s, color, _("	git commit --amend"));
>>> +			status_printf_ln(s, color, _("  Once you are satisfied with  
>>> your changes, run"));
>>> +			status_printf_ln(s, color, _("	git rebase --continue"));
>>
>> For an advice in "git status" output, the above may be appropriate,
>> but would the user see this in "git commit" template, and if so,
>> isn't it because the user typed "git commit --amend"?  Does it make
>> sense to suggest to run "git commit --amend" in that context?
>
> True, the user will see the messages in the "git commit" template. We
> didn't take this case into account because we thought that not many people
> read the status in the "git commit" template. Anyway, just adding a condition
>
> if (advice_status_hints && !s->amend)
>
> does the job.

Hrm, what would happen if the user ran "git commit" without --amend?

It could be done by mistake, which will be greatly helped by the
information you already gathered during the inspection phase.  

This also can be done deliberately to split a commit in "rebase -i",
so "You are in 'rebase -i', do not commit without --amend!" is a
wrong message, but it may be sensible to give "are you sure you
meant to commit without --amend?"
