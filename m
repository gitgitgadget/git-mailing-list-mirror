From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rebase -p loses amended changes
Date: Wed, 04 Apr 2012 13:26:46 -0700
Message-ID: <7viphf8cqh.fsf@alter.siamese.dyndns.org>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
 <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
 <87fwcpun95.fsf@thomas.inf.ethz.ch>
 <CAH3AnrpasFU2bLEZsAXRQu4U+=R_YyW+-yRXDfzy2JQpqf9dNw@mail.gmail.com>
 <CADb3U=4Y0njLiYC1qrYbdm+h0h8vLh78yfz_u3B6veEqCX0xCQ@mail.gmail.com>
 <CAH3Anrq_Z0V=DpU1iH-A3F8RFWTG0_C1hEe3iDZYe=AYDTRT3g@mail.gmail.com>
 <CABURp0pnXvnT2=fDJXk-yiGctsJBHiNGSCOZiT4Vo74woi0Zxg@mail.gmail.com>
 <4F7BEA9F.3060805@viscovery.net> <7vpqbna0cd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	J Robert Ray <jrobertray@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 04 22:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFWn9-0000hk-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 22:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080Ab2DDU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 16:26:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38087 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab2DDU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 16:26:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C81E7A97;
	Wed,  4 Apr 2012 16:26:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Al9PNz0CWYFLxcpC3Rhn4GT6Pmk=; b=iyQe6m
	Ed2cLragaN1fz+C5aB8mA0ZGOwodPyxp0WRVxBfnZR2VeH4wp/U7Dyaras2UfChF
	wfipW5yGfaYpvvU318/jpgDzhK7pftEUywK0lbhCGYUw2c81x1cZg5U1nYmqJ0I2
	0UQhb/dg/zSQrkeBKbzQSjaesKV6XmlSyCNKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pnAOLVbsCciW5cBNegjvhOG6Va4xCr/m
	pyvSjEoNOrht6fomRjyDPZojDmJzc34xIL8x4W9TuWDh9CpsVZX5zGHTeb84LaMV
	dvSkn4l31xKgV5zQplrMaPZaHP0VddtPynppnskcf4MEdQTavzSon4aiDTDGrZCi
	pXtxuIGN15k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 631BB7A96;
	Wed,  4 Apr 2012 16:26:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1D657A93; Wed,  4 Apr 2012
 16:26:47 -0400 (EDT)
In-Reply-To: <7vpqbna0cd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Apr 2012 10:11:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80D6B64C-7E94-11E1-A1AD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194737>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> IMO, it is a sub-optimal implementation of rebase -p that it attempts to
>> redo the merge. A better strategy is to just replay the changes between
>> the first parent and the merge commit, and then generate a new merge commit:
>>
>>    git diff-tree -p M^ M | git apply --index &&
>>    git rev-parse M^2 > .git/MERGE_HEAD &&
>>    git commit -c M
>>
>> This would side-step all the issues discussed here, no?
>
> Or cherry-pick the change made by the merge to its first parent, i.e.
>
> 	git cherry-pick -m 1 M

Err, that was a confusing unfinished message.  I meant the step to replace
the part that uses pipe to "git apply", more like

        git rev-parse M^2 >.git/MERGE_HEAD &&
	git cherry-pick --no-commit -m 1 M &&
        git commit -c M

The primary difference is that, because "apply -3" is not implemented yet,
this will help when the base has drifted too much from the corresponding
blob recorded in M^.
