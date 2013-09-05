From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Thu, 05 Sep 2013 16:09:44 -0700
Message-ID: <xmqqsixig91j.fsf@gitster.dls.corp.google.com>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
	<vpqioyfukkw.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHigV-0007rJ-R7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758694Ab3IEXJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:09:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47342 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757754Ab3IEXJv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:09:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9A123F94C;
	Thu,  5 Sep 2013 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SGD2/QGVTeu+dSN9JEZngsch9CM=; b=GwULtp
	kR8RZR9ZVP6qoHDz3xByLLZh4+wew2+mcfMYj49PIK/4oTEMeQzf7kOCfbLt18Rq
	3WqrNh+yBSeURLwUQaibZHJ/nYrLZEtgwJXRKeUu9wHHOF+aFUjsqcgKosjxuXd0
	CqpcmxhhseEQ0DTbQLjWa4GKIhdastN7S4ed4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h9Ch/aYoM6qX57aI3/68XWPfQOw1Er/i
	ILpZpMpSmzSvV81KjoLiz/Wc8E/N0GjzKfOYPM4wNHoQfdT7IrUjEEXr7BlQU4qM
	dZNXPV0IiStKiQuGY8ZP0Ilkkv9V5lYKNSH+dW9oYikX8auHDob6oGZgUJUikFYg
	amYmj8VcosE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EED43F949;
	Thu,  5 Sep 2013 23:09:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB96C3F941;
	Thu,  5 Sep 2013 23:09:46 +0000 (UTC)
In-Reply-To: <vpqioyfukkw.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	05 Sep 2013 21:36:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4210EC68-1680-11E3-BEC5-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234000>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> One caveat, though.  The name "oldStyle" will become problematic,
>> when we want to remove some wart in the output format long after
>> this "no comment prefix by default" series lands.  Some people may
>> expect setting oldStyle=true would give output from 1.8.4 era, while
>> some others would expect that it would give output from 1.8.5 era
>> that does not have comment prefix but still has that wart we will
>> remove down the line.
>
> I'm fine with any name actually (since it is enabled by default, people
> don't need to know the name to benefit from the new output). Maybe
> status.displayCommentPrefix was the best name after all.

Yeah, I think so.  It makes it clear what kind of old behaviour the
user is asking for.
