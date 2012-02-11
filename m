From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 10:31:53 -0800
Message-ID: <7v4nuxmdba.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
 <7vy5s9n70x.fsf@alter.siamese.dyndns.org>
 <m3sjihu18t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 19:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwHju-0008RQ-6P
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 19:32:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab2BKSb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 13:31:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60276 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324Ab2BKSb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 13:31:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCD2B70E1;
	Sat, 11 Feb 2012 13:31:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=273SmHSsxMB4V0OhDHbuGuOGjfc=; b=VmyA/C
	hwgymsN8LvbIUWZoGk56IFo7qeeBUUytBldPrmb0AcA7tCuMrP5f8HiPwmhcsIlG
	unm0XNQ2jEkSuAGe1em3keczJwu6oR3eMYDQg/BVeq5a+JaaQKZnsHgAzGbRqe+Z
	4hsmZAVuqfRfyJE0s4Oas1bdEAZTdRz7lGGvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fg3zVCIc40g7sBlEyysm2+xEHQ0pcz7U
	zMUMuMmjfKkG7uUEEjubTb/1EEDpvv0v50LloZPIOPsVHLKZc5OcsnjHV4Q4GM7R
	PrtK2xvo4E7bOQzg9K7i46wzezwfGfukGnU36BQ8npU2vKebINoFvWuo64JqzRUm
	6CcJnzuRH2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D42C070E0;
	Sat, 11 Feb 2012 13:31:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4856B70DF; Sat, 11 Feb 2012
 13:31:55 -0500 (EST)
In-Reply-To: <m3sjihu18t.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Sat, 11 Feb 2012 02:13:13 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC9DB698-54DE-11E1-884A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190526>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> In a future versions, we may want to have "branch/tag --list" also ask for
>> FNM_PATHNAME (this *is* a backward incompatible change, so it needs to be
>> performed across major version boundary, with backward compatibility
>> configurations, deprecation warnings and whole nine yards). Under the new
>> match function, today's "branch --list 'maint*'" needs to be spelled as
>> "branch --list 'maint*/*'" or something.
>
> Or "branch --list 'maint**'

That is one of the things covered by "or something", and I deliberately
left it like so because all the good things that can happen "In future
version" are irrelevant at the present _unless_ the required first step
you omitted from your quote is not done properly, and I didn't want to
invite people to derail the discussion into such a tangent that does not
yet have any value.

Please don't.
