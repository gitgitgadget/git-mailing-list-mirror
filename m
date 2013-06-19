From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Request] Git reset should be able to ignore file permissions
Date: Wed, 19 Jun 2013 11:43:30 -0700
Message-ID: <7vobb2ym99.fsf@alter.siamese.dyndns.org>
References: <CACuz9s31OUWNxTqCmj7ukAo7=TpXK7zBv5kTFZ5obpXKOju9ng@mail.gmail.com>
	<vpqsj0fr19j.fsf@anie.imag.fr>
	<CACuz9s1KGKsL-pGftAtAWyX5gUA5c-PYyJUSstf+xw151rZLtA@mail.gmail.com>
	<vpq7ghrqzrv.fsf@anie.imag.fr>
	<CACuz9s0=7z-M1-zgRNUs2hS-4LcuXrsWbqyDaMnuvFXRnP7E-Q@mail.gmail.com>
	<vpqppvjpjz3.fsf@anie.imag.fr>
	<CACuz9s2DfN5O91ZF8QOnWuA0V3bGFuUG5RVmkmjeL7Jien+fYg@mail.gmail.com>
	<CACuz9s1H2Gi+B7=Fc3yJ+PC9oDueLQzXstSX0C9uAy3_MN4Kag@mail.gmail.com>
	<vpqy5a7mmsg.fsf@anie.imag.fr>
	<CACuz9s2KEne5_PwHwmsd1X7iE=GB3pC=iUzxSo=t6TbF+ZjCxA@mail.gmail.com>
	<vpqsj0emzdu.fsf@anie.imag.fr>
	<CACuz9s0jqe9zErBLZ5+kv2OCKW5fFHq0sifc2GS=n4jFpDiQZw@mail.gmail.com>
	<vpqfvwel4bi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Nestorov <alexandernst@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 19 20:43:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNMH-0007nG-MC
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 20:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073Ab3FSSnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 14:43:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52624 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965084Ab3FSSnc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 14:43:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E785298DC;
	Wed, 19 Jun 2013 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rUHGEjOJf9ofYaLUiYaE/j5qY2k=; b=l9i4v2
	IA/Jwa1duKXrDIG3dRoaZgWfXuX113yjXrkwQ5Z0593s1ixhV+faZLHTYc/j2iWS
	BzVF/v+jZH7RNe53K4jv6MUD++hWVXuEedxw58Y8XgxdgkaL8npePNqqT1AcCefU
	VeHJS5AGuzjQrnw0P9NEOj9pUc0dPblBmFRTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wsX46HgtrCvWDOVdSqj2tn1nMpEnzKc4
	yJ1zqSfdYUjmQT+9GZIJnMacU8x0epYJI9ArE3Swk/DjSjOyFbPhdskCkn0c4W3x
	RETbYqIrGS6hwal5KHGzx58iQMjdaf0HnfUMIeQUPopIfeaQULWUGG1mfLO/2WX/
	bzTCzeFOkig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2509F298DB;
	Wed, 19 Jun 2013 18:43:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87886298D8;
	Wed, 19 Jun 2013 18:43:31 +0000 (UTC)
In-Reply-To: <vpqfvwel4bi.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	19 Jun 2013 13:37:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23AAE56A-D910-11E2-9AC0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228409>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Alexander Nestorov <alexandernst@gmail.com> writes:
>
>> Ok, this is how it looks. If everything is ok, I'm sending it to the ML
>
> Please, read Documentation/SubmittingPatches (you lack a sign-off and if
> you think the patch is ready, you should Cc Junio). Also, it's better to
> have the commit headers directly as mail headers (git send-email is your
> friend).
>
>> +Reset only files who's content changed (instead of stat information)::
>
> That's still not 100% accurate. Actual mode changes would trigger a
> rewrite of the file. Perhaps stg like
>
> Reset only files which actually changed (not those with only stat information change)::
>
> (Sorry for nitpicking so much)

I do not think the above clarifies anything to be of much help.

If you _know_ what "actually changed" means, i.e. either contents or
the executable-ness changed, then "(not those ...)" does not help
you at all.

If you don't, then "only stat information change" will invite "I did
chmod -x and the file does not have any actual change." confusion.

If this addition is to help people who do not know what "actually
changed" means, that part needs to be clarified, no?
