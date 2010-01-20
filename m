From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] What to you think about a loose status for submodules?
Date: Wed, 20 Jan 2010 11:45:50 -0800
Message-ID: <7v7hrc36hd.fsf@alter.siamese.dyndns.org>
References: <20091021160122.GA2067@book.hvoigt.net>
 <7vy6n4339k.fsf@alter.siamese.dyndns.org>
 <20091022194446.GA3944@book.hvoigt.net>
 <7vvdi7fbg3.fsf@alter.siamese.dyndns.org>
 <20100120181652.GA10803@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 20:46:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXgVQ-0002rs-3M
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 20:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab0ATTqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2010 14:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822Ab0ATTqP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 14:46:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab0ATTqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 14:46:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BDFE920D5;
	Wed, 20 Jan 2010 14:46:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cuFO83ptcUEv
	6x1SKaUi1gHV6Uw=; b=PKY55iLm1nQMZjYoCHvDi+rd88ntxRnbGdMHKnhXsJow
	tKSGWP67UUZex5nOuWv88xtmu0yznjvoVJdVoFZdTl+HFDEoS/a5s1D9KjX6PmMh
	mpwN1X590Hjy82nDfahjn4WD2/RpEAuSIEaIwR+/lVOfMxy5KF/gk+o19Nm2MGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V38CA/
	EQ+hwNYEBU31Je/IsAYcc6nVtYAIK73vEDxGMPlgMQAzWXiVBP6G3IR+GNYuSiOe
	ael+JQNTiF26EfyYI1LgUKFfnOV9bAZWi6+k7yvMum5hWuDkVlvxDf8+sUjLQae+
	bDbIZem+JoLgBUv1v2X5hCP6UpLYsASrIa2go=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C94CD920CF;
	Wed, 20 Jan 2010 14:45:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBC6D920BF; Wed, 20 Jan
 2010 14:45:51 -0500 (EST)
In-Reply-To: <20100120181652.GA10803@book.hvoigt.net> (Heiko Voigt's message
 of "Wed\, 20 Jan 2010 19\:16\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6D49A41C-05FC-11DF-BD8F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137564>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Even though there has not been much more work on this item the idea h=
as
> become much clearer for me since the last discussion. Now that sparse
> checkout is in master I would like to generalize this idea a little
> further.

Selective init/update of submodules is a fundamental design element and
the presense of "sparse checkout" does not affect it.

In the remainder of your message

> How about ...

you are talking about a change that would also apply to a project that
does not have submodules at all, and you would want to involve Nguy=E1=BB=
=85n in
the discussion.

I have no strong opinion if attributes is the right vehicle to carry th=
is
information, except for this part:

> Does the current sparse implementation work with submodule entries as
> well? Then it could be even more straightforward to implement than th=
e
> previous idea.

What the project ships as grouping suggestions to cloners is merely a
small part of the information on submodules (others such as URL and nam=
e
are already found in .gitmodules, and .gitmodules are designed to be
extensible by allowing other "config"-ish items in it).  Separating onl=
y
the grouping info into a different file (I don't particularly care if y=
ou
use .gitattributes or something else; as long as it is not .gitmodules,
the argument is the same) is not such a good idea.
