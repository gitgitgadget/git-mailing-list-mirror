From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add optional parameters to the diff option
 "--ignore-submodules"
Date: Tue, 08 Jun 2010 16:26:49 -0700
Message-ID: <7vy6epqf5y.fsf@alter.siamese.dyndns.org>
References: <4C0E7037.8080403@web.de>
 <7vhbldtow3.fsf@alter.siamese.dyndns.org> <4C0EAAE8.3060300@web.de>
 <alpine.DEB.1.00.1006082247390.1732@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 09 01:27:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM8CQ-0007f8-VL
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 01:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab0FHX1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 19:27:05 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410Ab0FHX1E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 19:27:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9655BA14A;
	Tue,  8 Jun 2010 19:27:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xzojY+dq9UKhZpv9yxYQQOkZqDk=; b=ouX5US
	IhbT3yr1MBLPZu3Ci8m8oNOYn71HOJRkQTcQoP3BnSNGQkX9xrEqOE/UyT0kX7jG
	o6l/By2/PEcBkC3UtR6mmQzO99jIenCflpfyAq+69HgxKxrTIPmEjky+DpIZk/Hi
	oemBOABEd7QxtOhN6JcLKAfSEnlcF0OFJZuLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PzHTxEd/xthlu+Pm/RRT6re5B9R78Qg7
	ub51tp6EtyUoXRi6fLj05GK+xanWT4azHBqWu3DyXvqm8UU7uBBFSHrocly1eB8B
	bDOavGfXoxBahAxj9eFPCxifZKlZmhbQM0S3yoXMSqorkhMAkoyQ888mgKfyg9iZ
	pblIVXqpyyk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94053BA145;
	Tue,  8 Jun 2010 19:26:57 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A702BA143; Tue,  8 Jun
 2010 19:26:51 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1006082247390.1732@bonsai2> (Johannes
 Schindelin's message of "Tue\, 8 Jun 2010 23\:02\:39 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54C12E4E-7355-11DF-93DA-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148733>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I agree that the basic reason for the default to check for dirty and 
> untracked files is sound.
>
> It is not your (Jens') fault that this does not integrate well into the 
> Git context, and that users of the submodule feature were punished that 
> heavily (just to reiterate, if anybody missed that number, the time on 
> "git status" -- or for that matter, "git diff" -- went up by >4500%. In 
> English words, that is four-thousand five hundred percent, and that is 
> just a lower bound).
>
> So I would actually argue (being a real submodule user, not just an 
> imaginary one) that the default for dirty checking in the submodules 
> should stay.

Let me make sure I understand.  You repeated three times that you suffered
big time spending too many cycles due to extra checks (compared with older
behaviour of not checking submodule working tree at all), but you would
recommend the default to be the expensive one?

I am not trying to point out that these two statements are inconsistent. I
am guessing that you are suggesting to "default to safe-but-expensive, let
people who know what they are doing to tweak for performance", but you are
as always a bit too terse for me to be sure, hence this question.
