From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] fc/transport-helper-sync-error-fix rebased
Date: Sun, 20 Apr 2014 14:10:55 -0700
Message-ID: <7voazvlna8.fsf@alter.siamese.dyndns.org>
References: <1397334812-12215-1-git-send-email-felipe.contreras@gmail.com>
	<1397890843-27035-1-git-send-email-gitster@pobox.com>
	<535413cbc7eaa_1f08dd12eca5@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 23:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbyzP-0003rm-Al
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 23:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbaDTVJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 17:09:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaDTVJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 17:09:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB657EF74;
	Sun, 20 Apr 2014 17:09:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6RzF2ubv4leLIOSEsMbT5NSlqE=; b=H+pnX0
	7nkFVmIQFscKTRvrumzJpjdpCyP2/+bFCWkO0UCJZ7+EO+W7AOKtLSKwt6KxbOqM
	l6n8+xQhtHmRWzOOgDMIbPnRN6khKaE5XO1aHafdebJt7+hGbYnKjoNMQVhOCqaY
	7Bxh6tlwg5s343+gOZuipBrkfn1olp1qmNREk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgzruoXMJxv3RUApQUHcwgoHCgT6OYIf
	1dNwaodl8abWIy5cN5dMfmpOMpYybvZNVhcaYPt6+iGuyuzUyMN4mgfyi79ER4GS
	rFONAw5fwOGR5HaT+kZd1iGJVRMab/610/+BmIk/nVIAPflSpY2/cBYeZTeytR91
	GDm9nRzJt9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8D147EF73;
	Sun, 20 Apr 2014 17:09:16 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D82E17EF71;
	Sun, 20 Apr 2014 17:09:14 -0400 (EDT)
In-Reply-To: <535413cbc7eaa_1f08dd12eca5@nysa.notmuch> (Felipe Contreras's
	message of "Sun, 20 Apr 2014 13:36:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 0719228A-C8D0-11E3-AAB7-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246584>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> As I have said in the recent What's cooking reports, the original
>> posted here were based on older codebase and needed to be rebased,
>> but it had some conflicts and I wanted to see the result double
>> checked by the original author before we can merge it to 'next',
>> cooked there and hopefully merged to 'master' before tagging -rc1.
>> 
>> So here is the series that has been queued in 'pu' for the past
>> several days.
>> 
>> Felipe, can you double check it?
>
> These patches don't help much,...

What do you mean by that, exactly?  As long as your "don't help
much" is "would not hurt and will help some even for a small subset
of audience", that would be OK, but I am puzzled.

My reading of your responses to bug reports and the cover letter of
the series has been that these were real fixes to a real problem
without downsides, and that you consider that they are good changes
to have in the upcoming release.

I am hoping that you did not mean that we shouldn't merge it to the
'next' and 'master' branches, but if that is what you meant, can we
hear what the downsides of the series are?
Are they more churn than they are worth without solving the real
issue?  Do they regress for some repositories/workflows while
improving for others?  I didn't get such an impression.


> ..., I did and interdiff with my own fixes and this is the result:
> ...  I don't like it, but it's OK.

Correct.  Following the coding style of the project is not the
matter for your liking or not liking.  It is part of being on the
same codebase with other participant of this project.
